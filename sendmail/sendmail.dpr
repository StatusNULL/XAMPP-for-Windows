program sendmail;

{

  fake sendmail for windows

  Copyright (c) 2004-2005, Byron Jones, sendmail@glob.com.au
  All rights reserved.

  requires indy 9 or higher

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
  Windows, Classes, SysUtils, Registry, IniFiles, IDSmtp, IdMessage, IdEmailAddress, IdLogFile, IdGlobal;

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

  i    : integer;
  s    : string;
  found: boolean;
  ss   : TStringStream;
  msg  : TIdMessage;
  debug: TIdLogFile;
  sl   : TStringList;

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

  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    if (OpenKeyReadOnly('\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters')) then
      defaultDomain := ReadString('Domain');
  finally
    Free;
  end;

  // read ini

  with TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini')) do
  try

    smtpServer    := ReadString('sendmail', 'smtp_server',    'mail.mydomain.com');
    defaultDomain := ReadString('sendmail', 'default_domain', defaultDomain);
    errorLogFile  := ReadString('sendmail', 'error_logfile',  '');
    debugLogFile  := ReadString('sendmail', 'debug_logfile',  '');
    authUsername  := ReadString('sendmail', 'auth_username',  '');
    authPassword  := ReadString('sendmail', 'auth_password',  '');
    forceSender   := ReadString('sendmail', 'force_sender',   '');

    if (smtpServer = 'mail.mydomain.com') or (defaultDomain = 'mydomain.com') then
    begin
      writeln('you must configure the smtp_server and default_domain in ' + fileName);
      halt(1);
    end;

  finally
    Free;
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
      if (Msg.Recipients.Count = 0) then
        raise Exception.Create('email is missing recipient''s address');

      with TIdSMTP.Create(nil) do
      try

        if (debugLogFile <> '') then
        begin
          debug          := TIdLogFile.Create(nil);
          debug.FileName := debugLogFile;
          debug.Active   := True;
          Intercept      := debug;
        end;

        // set host, port

        i := pos(':', smtpServer);
        if (i = 0) then
        begin
          host := smtpServer;
          port := 25;
        end
        else
        begin
          host := copy(smtpServer, 1, i - 1);
          port := strToIntDef(copy(smtpServer, i + 1, length(smtpServer)), 25);
        end;

        // connect to server

        Connect(10 * 1000);

        // authentication

        if (authUsername <> '') then
        begin
          AuthenticationType := atLogin;
          Username := authUsername;
          Password := authPassword;
          Authenticate;
        end;

        // sender and recipients

        if (forceSender = '') then
          SendCmd('MAIL FROM: <' + appendDomain(Msg.From.Address, defaultDomain) + '>', [250])
        else
          SendCmd('MAIL FROM: <' + appendDomain(forceSender, defaultDomain) + '>', [250]);

        for i := 0 to msg.Recipients.Count - 1 do
          SendCmd('RCPT TO: <' + appendDomain(Msg.Recipients[i].Address, defaultDomain) + '>', [250]);

        // start message content

        SendCmd('DATA', [354]);

        // add date header if missing

        if (Msg.Headers.Values['date'] = '') then
          writeln('Date: ' + DateTimeToInternetStr(Now));

        // send message line by line

        sl := TStringList.Create;
        try
          sl.Text := messageContent;
          for i := 0 to sl.Count - 1 do
          begin
            if (i = 0) and (sl[i] = '') then
              continue;
            writeln(sl[i]);
          end;
        finally
          sl.Free;
        end;

        // done

        SendCmd('.', [250]);
        SendCmd('QUIT');

      finally
        Free;
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

