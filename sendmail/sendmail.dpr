program sendmail;

{

  fake sendmail for windows

  Copyright (c) 2004-2005, Byron Jones, sendmail@glob.com.au
  All rights reserved.

  requires indy 9 or higher

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
  Windows, Classes, SysUtils, Registry, IniFiles, IDSmtp, IDPOP3, IdMessage, IdEmailAddress, IdLogFile, IdGlobal;

// ---------------------------------------------------------------------------

procedure writeToLog(const logFilename, logMessage: string);
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

    writeln(f, '[' + DateTimeToStr(Now) + '] ' + stringReplace(logMessage, #13#10, ' ', [rfReplaceAll]));
    closeFile(f);

  except
    on e:Exception do
      writeln('sendmail: error writing to ' + logFilename + ': ' + logMessage);
  end;
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

var

  smtpServer    : string;
  defaultDomain : string;
  messageContent: string;
  errorLogFile  : string;
  debugLogFile  : string;
  authUsername  : string;
  authPassword  : string;
  forceSender   : string;
  pop3server    : string;
  pop3username  : string;
  pop3password  : string;

  registry: TRegistry;
  iniFile : TIniFile;
  idPop3  : TIdPop3;
  idSmtp  : TIdSmtp;

  i     : integer;
  s     : string;
  found : boolean;
  ss    : TStringStream;
  msg   : TIdMessage;
  debug : TIdLogFile;
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
    writeln('sendmail requires -t parameter');
    halt(1);
  end;

  // read default domain from registry

  registry := TRegistry.Create;
  try
    registry.RootKey := HKEY_LOCAL_MACHINE;
    if (registry.OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters')) then
      defaultDomain := registry.ReadString('Domain');
  finally
    registry.Free;
  end;

  // read ini

  iniFile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try

    smtpServer    := iniFile.ReadString('sendmail', 'smtp_server',    'mail.mydomain.com');
    defaultDomain := iniFile.ReadString('sendmail', 'default_domain', defaultDomain);
    errorLogFile  := iniFile.ReadString('sendmail', 'error_logfile',  '');
    debugLogFile  := iniFile.ReadString('sendmail', 'debug_logfile',  '');
    authUsername  := iniFile.ReadString('sendmail', 'auth_username',  '');
    authPassword  := iniFile.ReadString('sendmail', 'auth_password',  '');
    forceSender   := iniFile.ReadString('sendmail', 'force_sender',   '');
    pop3server    := iniFile.ReadString('sendmail', 'pop3_server',    '');
    pop3username  := iniFile.ReadString('sendmail', 'pop3_username',  '');
    pop3password  := iniFile.ReadString('sendmail', 'pop3_password',  '');

    if (smtpServer = 'mail.mydomain.com') or (defaultDomain = 'mydomain.com') then
    begin
      writeln('you must configure the smtp_server and default_domain in ' + iniFile.fileName);
      halt(1);
    end;

  finally
    iniFile.Free;
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

  if (debugLogFile <> '') then
  begin
    sl := TStringList.Create;
    try
      sl.Text := messageContent;
      for i := 0 to sl.Count - 1 do
        writeToLog(debugLogFile, sl[i]);
    finally
      sl.Free;
    end;
  end;

  // deliver message

  try

    // load message into stream (TidMessage expects message to end in ".")

    ss  := TStringStream.Create(messageContent + #13#10'.'#13#10);
    msg := nil;

    try

      // load message

      msg := TIdMessage.Create(nil);
      msg.LoadFromStream(ss);

      // check for from and to

      if (forceSender = '') and (Msg.From.Address = '') then
        raise Exception.Create('email is missing sender''s address');
      if (Msg.Recipients.Count = 0) and (Msg.CCList.Count = 0) and (Msg.BccList.Count = 0) then
        raise Exception.Create('email is missing recipient''s address');

      if (debugLogFile <> '') then
      begin
        debug          := TIdLogFile.Create(nil);
        debug.FileName := debugLogFile;
        debug.Active   := True;
      end
      else
        debug := nil;

      if ((pop3server <> '') and (pop3username <> '')) then
      begin

        // pop3 before smtp auth

        idPop3 := TIdPOP3.Create(nil);
        try
          if (debug <> nil) then
            idPop3.Intercept := debug;
          idPop3.Host        := pop3server;
          idPop3.Username    := pop3username;
          idPop3.Password    := pop3password;
          idPop3.Connect(10 * 1000);
          idPop3.Disconnect;
        finally
          idPop3.free;
        end;

      end;

      idSmtp := TIdSMTP.Create(nil);
      try

        if (debug <> nil) then
          idSmtp.Intercept := debug;

        // set host, port

        i := pos(':', smtpServer);
        if (i = 0) then
        begin
          idSmtp.host := smtpServer;
          idSmtp.port := 25;
        end
        else
        begin
          idSmtp.host := copy(smtpServer, 1, i - 1);
          idSmtp.port := strToIntDef(copy(smtpServer, i + 1, length(smtpServer)), 25);
        end;

        // connect to server

        idSmtp.Connect(10 * 1000);

        // authentication

        if (authUsername <> '') then
        begin
          idSmtp.AuthenticationType := atLogin;
          idSmtp.Username := authUsername;
          idSmtp.Password := authPassword;
          idSmtp.Authenticate;
        end;

        // sender and recipients

        if (forceSender = '') then
          idSmtp.SendCmd('MAIL FROM: <' + appendDomain(Msg.From.Address, defaultDomain) + '>', [250])
        else
          idSmtp.SendCmd('MAIL FROM: <' + appendDomain(forceSender, defaultDomain) + '>', [250]);

        for i := 0 to msg.Recipients.Count - 1 do
          idSmtp.SendCmd('RCPT TO: <' + appendDomain(Msg.Recipients[i].Address, defaultDomain) + '>', [250]);

        for i := 0 to msg.ccList.Count - 1 do
          idSmtp.SendCmd('RCPT TO: <' + appendDomain(Msg.ccList[i].Address, defaultDomain) + '>', [250]);

        for i := 0 to msg.BccList.Count - 1 do
          idSmtp.SendCmd('RCPT TO: <' + appendDomain(Msg.BccList[i].Address, defaultDomain) + '>', [250]);

        // start message content

        idSmtp.SendCmd('DATA', [354]);

        // add date header if missing

        if (Msg.Headers.Values['date'] = '') then
          idSmtp.writeln('Date: ' + DateTimeToInternetStr(Now));

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
            idSmtp.writeln(sl[i]);
          end;
        finally
          sl.Free;
        end;

        // done

        idSmtp.SendCmd('.', [250]);
        idSmtp.SendCmd('QUIT');

      finally
        idSmtp.Free;
      end;

    finally
      msg.Free;
      ss.Free;
    end;

  except
    on e:Exception do
    begin

      writeln('sendmail: error during delivery: ' + e.message);

      if (errorLogFile <> '') then
        writeToLog(errorLogFile, e.Message);

      if (debugLogFile <> '') then
        writeToLog(debugLogFile, e.Message);

      halt(1);
    end;
  end;

end.

