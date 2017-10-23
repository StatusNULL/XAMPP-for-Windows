program sendmail;

{

  fake sendmail for windows

  Copyright (c) 2004-2005, Byron Jones, sendmail@glob.com.au
  All rights reserved.

  requires indy 9 or higher

  version 14
    - errors output to STDERR
    - fixes for delphi 7 compilation
    - added 'connecting to..' debug logging
    - reworked error and debug log format

  version 13
    - added fix to work around invalid multiple header instances

  version 12
    - added cc and bcc support

  version 11
    - added pop3 support (for pop before smtp authentication)

  version 10
    - added support for specifying a different smtp port

  version 9
    - added force_sender

  version 8
    - *really* fixes broken smtp auth

  version 7
    - fixes broken smtp auth

  version 6
    - correctly quotes MAIL FROM and RCPT TO addresses in <>

  version 5
    - now sends the message unchanged (rather than getting indy
      to regenerate it)

  version 4
    - added debug_logfile parameter
    - improved error messages

  version 3
    - smtp authentication support
    - clearer error message when missing from or to address
    - optional error logging
    - adds date header if missing

  version 2
    - reads default domain from registry (.ini setting overrides)

  version 1
    - initial release

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.

    * Neither the name of the glob nor the names of its contributors may
      be used to endorse or promote products derived from this software
      without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

}

{$APPTYPE CONSOLE}

uses
  Windows, Classes, SysUtils, Registry, IniFiles,
  IDSmtp, IDPOP3, IdMessage, IdEmailAddress, IdLogFile, IdGlobal, IdResourceStrings;

// ---------------------------------------------------------------------------

function buildLogLine(data, prefix: string) : string;
// ensure the output of error and debug logs are in the same format, regardless of source
begin

  data := StringReplace(data, EOL, RSLogEOL, [rfReplaceAll]);
  data := StringReplace(data, CR, RSLogCR, [rfReplaceAll]);
  data := StringReplace(data, LF, RSLogLF, [rfReplaceAll]);

  result := FormatDateTime('yy/mm/dd hh:nn:ss', now) + ' ';
  if (prefix <> '') then
    result := result + prefix + ' ';
  result := result + data + EOL;
end;

// ---------------------------------------------------------------------------

type

  // TidLogFile using buildLogLine function

  TlogFile = class(TidLogFile)
  protected
    procedure LogReceivedData(const AText: string; const AData: string); override;
    procedure LogSentData(const AText: string; const AData: string); override;
    procedure LogStatus(const AText: string); override;
  public
    procedure LogWriteString(const AText: string); override;
  end;

// ---------------------------------------------------------------------------

procedure TlogFile.LogReceivedData(const AText: string; const AData: string);
begin
  // ignore AText as it contains the date/time
  LogWriteString(buildLogLine(Adata, '<<'));
end;

// ---------------------------------------------------------------------------

procedure TlogFile.LogSentData(const AText: string; const AData: string);
begin
  // ignore AText as it contains the date/time
  LogWriteString(buildLogLine(Adata, '>>'));
end;

// ---------------------------------------------------------------------------

procedure TlogFile.LogStatus(const AText: string);
begin
  LogWriteString(buildLogLine(AText, '**'));
end;

// ---------------------------------------------------------------------------

procedure TlogFile.LogWriteString(const AText: string);
begin
  // protected --> public
  inherited;
end;

// ---------------------------------------------------------------------------

var
  errorLogFile: string;
  debugLogFile: string;
  debug       : TlogFile;

// ---------------------------------------------------------------------------

procedure writeToLog(const logFilename, logMessage: string; const prefix: string = '');
var
  f: TextFile;
begin
  AssignFile(f, logFilename);
  try

    if (not FileExists(logFilename)) then
    begin
      ForceDirectories(ExtractFilePath(logFilename));
      Rewrite(f);
    end
    else
      Append(f);

    write(f, buildLogLine(logMessage, prefix));
    closeFile(f);

  except
    on e:Exception do
      writeln(ErrOutput, 'sendmail: Error writing to ' + logFilename + ': ' + logMessage);
  end;
end;

// ---------------------------------------------------------------------------

procedure debugLog(const logMessage: string);
begin
  if (debug <> nil) and (debug.Active) then
    debug.LogWriteString(buildLogLine(logMessage, '**'))
  else
    writeToLog(debugLogFile, logMessage, '**');
end;

// ---------------------------------------------------------------------------

procedure errorLog(const logMessage: string);
begin
  if (errorLogFile <> '') then
    writeToLog(errorLogFile, logMessage, ':');
  debugLog(logMessage);
end;

// ---------------------------------------------------------------------------

function appendDomain(const address, domain: string): string;
begin
  Result := address;
  if (Pos('@', address) <> 0) then
    Exit;
  Result := Result + '@' + domain;
end;

// ---------------------------------------------------------------------------

function joinMultiple(const messageContent: string; fieldName: string): string;
// the rfc says that some fields are only allowed once in a message header
// for example, to, from, subject
// this function joins multiple instances of the specified field into a single comma seperated line
var
  sl    : TstringList;
  i     : integer;
  s     : string;
  n     : integer;
  count : integer;
  values: TstringList;
begin

  fieldName := LowerCase(fieldName);
  sl := TStringList.Create;
  values := TStringList.Create;
  try

    sl.text := messageContent;
    result := '';

    // only modify the header if there's more than one instance of the field

    count := 0;
    for i := 0 to sl.count - 1 do
    begin
      s := sl[i];
      if (s = '') then
        break;
      n := pos(':', s);
      if (n = 0) then
        break;
      if (lowerCase(copy(s, 1, n - 1)) = fieldName) then
        inc(count);
    end;

    if (count <= 1) then
    begin
      result := messageContent;
      exit;
    end;

    // more than on instance of the field, combine into single entry, ignore fields with empty values

    while (sl.count > 0) do
    begin
      s := sl[0];
      if (s = '') then
        break;
      n := pos(':', s);
      if (n = 0) then
        break;

      if (lowerCase(copy(s, 1, n - 1)) = fieldName) then
      begin
        s := trim(copy(s, n + 1, length(s)));
        if (s <> '') then
          values.Add(s);
      end
      else
        result := result + s + #13#10;

      sl.Delete(0);
    end;

    if (values.count <> 0) then
    begin
      s := UpCaseFirst(fieldName) + ': ';
      for i := 0 to values.count - 1 do
        s := s + values[i] + ', ';
      setLength(s, length(s) - 2);
      result := result + s + #13#10;
    end;

    result := result + sl.Text;

  finally
    values.Free;
    sl.free;
  end;

end;

// ---------------------------------------------------------------------------

var

  smtpServer    : string;
  defaultDomain : string;
  messageContent: string;
  authUsername  : string;
  authPassword  : string;
  forceSender   : string;
  pop3server    : string;
  pop3username  : string;
  pop3password  : string;

  reg : TRegistry;
  ini : TIniFile;
  pop3: TIdPop3;
  smtp: TIdSmtp;

  i     : integer;
  s     : string;
  found : boolean;
  ss    : TStringStream;
  msg   : TIdMessage;
  sl    : TStringList;
  header: boolean;

begin

  // check parameters to make sure "-t" was provided

  found := False;
  for i := 1 to ParamCount do
    if (ParamStr(i) = '-t') then
    begin
      found := True;
      break;
    end;

  if (not found) then
  begin
    writeln(ErrOutput, 'sendmail requires -t parameter');
    halt(1);
  end;

  // read default domain from registry

  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if (reg.OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters')) then
      defaultDomain := reg.ReadString('Domain');
  finally
    reg.Free;
  end;

  // read ini

  ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try

    smtpServer    := ini.ReadString('sendmail', 'smtp_server',    'mail.mydomain.com');
    defaultDomain := ini.ReadString('sendmail', 'default_domain', defaultDomain);
    errorLogFile  := ini.ReadString('sendmail', 'error_logfile',  '');
    debugLogFile  := ini.ReadString('sendmail', 'debug_logfile',  '');
    authUsername  := ini.ReadString('sendmail', 'auth_username',  '');
    authPassword  := ini.ReadString('sendmail', 'auth_password',  '');
    forceSender   := ini.ReadString('sendmail', 'force_sender',   '');
    pop3server    := ini.ReadString('sendmail', 'pop3_server',    '');
    pop3username  := ini.ReadString('sendmail', 'pop3_username',  '');
    pop3password  := ini.ReadString('sendmail', 'pop3_password',  '');

    if (smtpServer = 'mail.mydomain.com') or (defaultDomain = 'mydomain.com') then
    begin
      writeln(ErrOutput, 'You must configure the smtp_server and default_domain in ' + ini.fileName);
      halt(1);
    end;

  finally
    ini.Free;
  end;

  if (errorLogFile <> '') and (ExtractFilePath(errorLogFile) = '') then
    errorLogFile := ExtractFilePath(ParamStr(0)) + errorLogFile;

  if (debugLogFile <> '') and (ExtractFilePath(debugLogFile) = '') then
    debugLogFile := ExtractFilePath(ParamStr(0)) + debugLogFile;

  // read email from stdin

  messageContent := '';
  while (not eof(Input)) do
  begin
    readln(Input, s);
    messageContent := messageContent + s + #13#10;
  end;

  // make sure message is CRLF delimited

  if (pos(#10, messageContent) = 0) then
    messageContent := stringReplace(messageContent, #13, #13#10, [rfReplaceAll]);

  if (debugLogFile <> '') then
  begin
    debugLog('--- MESSAGE BEGIN ---');
    sl := TStringList.Create;
    try
      sl.Text := messageContent;
      for i := 0 to sl.Count - 1 do
        debugLog(sl[i]);
    finally
      sl.Free;
    end;
    debugLog('--- MESSAGE END ---');
  end;

  // fix multiple to, cc, bcc and subject fields

  messageContent := joinMultiple(messageContent, 'to');
  messageContent := joinMultiple(messageContent, 'cc');
  messageContent := joinMultiple(messageContent, 'bcc');
  messageContent := joinMultiple(messageContent, 'subject');

  // deliver message

  try

    // load message into stream (TidMessage expects message to end in ".")

    ss  := TStringStream.Create(messageContent + #13#10'.'#13#10);
    msg := nil;

    try

      // load message

      msg := TIdMessage.Create(nil);
      try
        msg.LoadFromStream(ss);
      except
        on e:exception do
          raise exception.create('Failed to read email message: ' + e.message);
      end;

      // check for from and to

      if (forceSender = '') and (Msg.From.Address = '') then
        raise Exception.Create('Message is missing sender''s address');
      if (Msg.Recipients.Count = 0) and (Msg.CCList.Count = 0) and (Msg.BccList.Count = 0) then
        raise Exception.Create('Message is missing recipient''s address');

      if (debugLogFile <> '') then
      begin
        debug          := TlogFile.Create(nil);
        debug.FileName := debugLogFile;
        debug.Active   := True;
      end
      else
        debug := nil;

      if ((pop3server <> '') and (pop3username <> '')) then
      begin

        // pop3 before smtp auth

        debugLog('Authenticating with POP3 server');

        pop3 := TIdPOP3.Create(nil);
        try
          if (debug <> nil) then
            pop3.Intercept := debug;
          pop3.Host        := pop3server;
          pop3.Username    := pop3username;
          pop3.Password    := pop3password;
          pop3.Connect(10 * 1000);
          pop3.Disconnect;
        finally
          pop3.free;
        end;

      end;

      smtp := TIdSMTP.Create(nil);
      try

        if (debug <> nil) then
          smtp.Intercept := debug;

        // set host, port

        i := pos(':', smtpServer);
        if (i = 0) then
        begin
          smtp.host := smtpServer;
          smtp.port := 25;
        end
        else
        begin
          smtp.host := copy(smtpServer, 1, i - 1);
          smtp.port := strToIntDef(copy(smtpServer, i + 1, length(smtpServer)), 25);
        end;

        // connect to server

        debugLog('Connecting to ' + smtp.Host + ':' + intToStr(smtp.Port));

        smtp.Connect(10 * 1000);

        // authentication

        if (authUsername <> '') then
        begin

          debugLog('Authenticating as ' + authUsername);

          smtp.AuthenticationType := atLogin;
          smtp.Username := authUsername;
          smtp.Password := authPassword;
          smtp.Authenticate;
          
        end;

        // sender and recipients

        if (forceSender = '') then
          smtp.SendCmd('MAIL FROM: <' + appendDomain(Msg.From.Address, defaultDomain) + '>', [250])
        else
          smtp.SendCmd('MAIL FROM: <' + appendDomain(forceSender, defaultDomain) + '>', [250]);

        for i := 0 to msg.Recipients.Count - 1 do
          smtp.SendCmd('RCPT TO: <' + appendDomain(Msg.Recipients[i].Address, defaultDomain) + '>', [250]);

        for i := 0 to msg.ccList.Count - 1 do
          smtp.SendCmd('RCPT TO: <' + appendDomain(Msg.ccList[i].Address, defaultDomain) + '>', [250]);

        for i := 0 to msg.BccList.Count - 1 do
          smtp.SendCmd('RCPT TO: <' + appendDomain(Msg.BccList[i].Address, defaultDomain) + '>', [250]);

        // start message content

        smtp.SendCmd('DATA', [354]);

        // add date header if missing

        if (Msg.Headers.Values['date'] = '') then
          smtp.writeln('Date: ' + DateTimeToInternetStr(Now));

        // send message line by line

        sl := TStringList.Create;
        try
          sl.Text := messageContent;
          header  := true;
          for i := 0 to sl.Count - 1 do
          begin
            if (i = 0) and (sl[i] = '') then
              continue;
            if (sl[i] = '') then
              header := false;
            if (header) and (LowerCase(copy(sl[i], 1, 5)) = 'bcc: ') then
              continue;
            smtp.writeln(sl[i]);
          end;
        finally
          sl.Free;
        end;

        // done

        smtp.SendCmd('.', [250]);
        smtp.SendCmd('QUIT');

      finally

        if (smtp.Connected) then
          debugLog('Disconnecting from ' + smtp.Host + ':' + intToStr(smtp.Port));
          
        smtp.Free;
      end;

    finally
      msg.Free;
      ss.Free;
    end;

  except
    on e:Exception do
    begin
      writeln(ErrOutput, 'sendmail: Error during delivery: ' + e.message);
      errorLog(e.Message);
      halt(1);
    end;
  end;

end.

