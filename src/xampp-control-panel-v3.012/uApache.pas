unit uApache;

interface

uses GnuGettext, uBaseModule, SysUtils, Classes, Windows, ExtCtrls, StdCtrls, Buttons, uNetstatTable, uTools, uProcesses, Messages, uServices;

type
  tApacheLogType = (altAccess, altError);

  tApache = class(tBaseModule)
    OldPIDs, OldPorts: string;
    procedure ServiceInstall; override;
    procedure ServiceUnInstall; override;
    procedure Start; override;
    procedure Stop; override;
    procedure Admin; override;
    procedure UpdateStatus; override;
    procedure CheckIsService; reintroduce;
    procedure EditConfig(ConfigFile: string); reintroduce;
    procedure ShowLogs(LogType: tApacheLogType); reintroduce;
    procedure AddLog(Log: string; LogType: tLogType = ltDefault); reintroduce;
    constructor Create(pbbService: TBitBtn; pStatusPanel: tPanel; pPIDLabel, pPortLabel: tLabel; pStartStopButton, pAdminButton: TBitBtn);
    destructor Destroy; override;
  end;

implementation

const
  // cServiceName = 'Apache2.2';
  cModuleName = 'apache';

  { tApache }

procedure tApache.AddLog(Log: string; LogType: tLogType = ltDefault);
begin
  inherited AddLog(cModuleName, Log, LogType);
end;

procedure tApache.Admin;
var
  App, Param: string;
begin
  inherited;
  if Config.ServicePorts.Apache = 80 then
    Param := 'http://localhost/'
  else
    Param := 'http://localhost:' + IntToStr(Config.ServicePorts.Apache) + '/';
  if Config.BrowserApp <> '' then
  begin
    App := Config.BrowserApp;
    ExecuteFile(App, Param, '', SW_SHOW);
    AddLog(Format(_('Executing "%s" "%s"'), [App, Param]), ltDebug);
  end
  else
  begin
    ExecuteFile(Param, '', '', SW_SHOW);
    AddLog(Format(_('Executing "%s"'), [Param]), ltDebug);
  end;
end;

procedure tApache.CheckIsService;
var
  s: string;
  path: string;
begin
  inherited CheckIsService(RemoveWhiteSpace(Config.ServiceNames.Apache));
  if isService then
  begin
    s := _('Service installed');
    path:=GetServicePath(RemoveWhiteSpace(Config.ServiceNames.Apache));
  end
  else
    s := _('Service not installed');
  AddLog(Format(_('Checking for service (name="%s"): %s'), [RemoveWhiteSpace(Config.ServiceNames.Apache), s]), ltDebug);
  if (path<>'') then
  begin
    if (Pos(LowerCase(basedir + 'apache\bin\httpd.exe'), LowerCase(path))<>0) then
      AddLog(Format(_('Service Path: %s'), [path]), ltDebug)
    else
    begin
      AddLog(_('Apache Service Detected With Wrong Path'), ltError);
      AddLog(_('Uninstall the service manually first'), ltError);
    end
  end
  else
      AddLog(_('Service Path: Service Not Installed'), ltDebug);
end;

constructor tApache.Create;
var
  PortBlocker: string;
  ServerApp: string;
  p: integer;
  Ports: array [0 .. 1] of integer;
  path: string;
  // =(Config.ServicePorts.Apache,Config.ServicePorts.ApacheSSL);
begin
  inherited;
  Ports[0] := Config.ServicePorts.Apache;
  Ports[1] := Config.ServicePorts.ApacheSSL;
  ModuleName := cModuleName;
  AddLog(_('Initializing module...'), ltDebug);
  ServerApp := basedir + 'apache\bin\httpd.exe';
  if not FileExists(ServerApp) then
  begin
    AddLog(_('Possible problem detected: Apache Not Found!'), ltError);
    AddLog(_('Run this program from your XAMPP root directory!'), ltError);
  end;

  CheckIsService;
  path:=GetServicePath(RemoveWhiteSpace(Config.ServiceNames.Apache));

  if Config.CheckDefaultPorts then
  begin
    AddLog(_('Checking default ports...'), ltDebug);

    for p := Low(Ports) to High(Ports) do
    begin
      PortBlocker := NetStatTable.isPortInUse(Ports[p]);
      if (PortBlocker <> '') then
      begin
        //if (LowerCase(PortBlocker) = LowerCase(ServerApp)) then
        if (pos(LowerCase(ServerApp), LowerCase(PortBlocker))<>0) then
        begin
          // AddLog(Format(_('"%s" seems to be running on port %d?'),[ServerApp,Ports[p]]),ltError);
          AddLog(Format(_('XAMPP Apache is already running on port %d'), [Ports[p]]), ltInfo);
        end
        else if (pos(LowerCase(PortBlocker), LowerCase(path))<>0) and (isService = True) then
        begin
          AddLog(Format(_('XAMPP Apache Service is already running on port %d'), [Ports[p]]), ltInfo);
        end
        else
        begin
          AddLog(_('Possible problem detected! '), ltError);
          AddLog(Format(_('Port %d in use by "%s"!'), [Ports[p], PortBlocker]), ltError);
        end;
      end;
    end;
  end;
end;

destructor tApache.Destroy;
begin
  inherited;
end;

procedure tApache.EditConfig(ConfigFile: string);
var
  App, Param: string;
begin
  App := Config.EditorApp;
  Param := basedir + ConfigFile;
  AddLog(Format(_('Executing %s %s'), [App, Param]), ltDebug);
  ExecuteFile(App, Param, '', SW_SHOW);
end;

procedure tApache.ServiceInstall;
var
  App, Param: string;
  RC: integer;
begin
  App := basedir + 'apache\bin\httpd.exe';
  Param := '-k install -n "' + RemoveWhiteSpace(Config.ServiceNames.Apache) + '"';
  AddLog(_('Installing service...'));
  AddLog(Format(_('Executing "%s %s"'), [App, Param]), ltDebug);
  RC := RunAsAdmin(App, Param, SW_HIDE);
  if RC = 0 then
    AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
  else
    AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
end;

procedure tApache.ServiceUnInstall;
var
  App, Param: string;
  RC: Cardinal;
begin
  App := basedir + 'apache\bin\httpd.exe';
  Param := '-k uninstall -n "' + RemoveWhiteSpace(Config.ServiceNames.Apache) + '"';
  AddLog(_('Uninstalling service...'));
  AddLog(Format(_('Executing "%s %s"'), [App, Param]), ltDebug);
  RC := RunAsAdmin(App, Param, SW_HIDE);
  if RC = 0 then
    AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
  else
    AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
end;

procedure tApache.ShowLogs(LogType: tApacheLogType);
var
  App, Param: string;
begin
  App := Config.EditorApp;
  if LogType = altAccess then
    Param := basedir + 'apache\logs\access.log';
  if LogType = altError then
    Param := basedir + 'apache\logs\error.log';
  AddLog(Format(_('Executing "%s %s"'), [App, Param]), ltDebug);
  ExecuteFile(App, Param, '', SW_SHOW);
end;

procedure tApache.Start;
var
  App, ErrMsg: string;
  RC: Cardinal;
begin
  if isService then
  begin
    AddLog(Format(_('Starting %s service...'), [cModuleName]));
    App := Format('start "%s"', [RemoveWhiteSpace(Config.ServiceNames.Apache)]);
    AddLog(Format(_('Executing "%s"'), ['net ' + App]), ltDebug);
    RC := RunAsAdmin('net', App, SW_HIDE);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
    begin
      ErrMsg := SysUtils.SysErrorMessage(System.GetLastError);
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
      //AddLog(Format(_('%s'), [ErrMsg]), ltError);
      if (Pos('SideBySide', SystemErrorMessage(RC)) <> 0)
        or (Pos('VC9', SystemErrorMessage(RC)) <> 0)
        or (Pos('VC9', ErrMsg) <> 0 )
        or (Pos('SideBySide', ErrMsg) <> 0) then
      begin
        AddLog(_('You appear to be missing the VC9 Runtime Files'), ltError);
        AddLog(_('You need to download and install the Microsoft Visual C++ 2008 SP1 (x86) Runtimes'), ltError);
        AddLog(_('http://www.microsoft.com/download/en/details.aspx?id=5582'), ltError);
      end;
    end;
  end
  else
  begin
    AddLog(Format(_('Starting %s app...'), [cModuleName]));
    App := basedir + 'apache\bin\httpd.exe';
    AddLog(Format(_('Executing "%s"'), [App]), ltDebug);
    RC := RunProcess(App, SW_HIDE, false);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
    begin
      ErrMsg := SysUtils.SysErrorMessage(System.GetLastError);
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
      //AddLog(Format(_('%s'), [ErrMsg]), ltError);
      if (Pos('SideBySide', SystemErrorMessage(RC)) <> 0)
        or (Pos('VC9', SystemErrorMessage(RC)) <> 0)
        or (Pos('VC9', ErrMsg) <> 0 )
        or (Pos('SideBySide', ErrMsg) <> 0) then
      begin
        AddLog(_('You appear to be missing the VC9 Runtime Files'), ltError);
        AddLog(_('You need to download and install the Microsoft Visual C++ 2008 SP1 (x86) Runtimes'), ltError);
        AddLog(_('http://www.microsoft.com/download/en/details.aspx?id=5582'), ltError);
      end;
    end;
  end;
end;

procedure tApache.Stop;
var
  i, pPID: integer;
  App, ErrMsg: string;
  RC: Cardinal;
begin
  if isService then
  begin
    AddLog(Format(_('Stopping %s service...'), [cModuleName]));
    App := Format('stop "%s"', [RemoveWhiteSpace(Config.ServiceNames.Apache)]);
    AddLog(Format(_('Executing "%s"'), ['net ' + App]), ltDebug);
    RC := RunAsAdmin('net', App, SW_HIDE);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
    begin
      ErrMsg := SysUtils.SysErrorMessage(System.GetLastError);
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
      //AddLog(Format(_('%s'), [ErrMsg]), ltError);
      if (Pos('SideBySide', SystemErrorMessage(RC)) <> 0)
        or (Pos('VC9', SystemErrorMessage(RC)) <> 0)
        or (Pos('VC9', ErrMsg) <> 0 )
        or (Pos('SideBySide', ErrMsg) <> 0) then
      begin
        AddLog(_('You appear to be missing the VC9 Runtime Files'), ltError);
        AddLog(_('You need to download and install the Microsoft Visual C++ 2008 SP1 (x86) Runtimes'), ltError);
        AddLog(_('http://www.microsoft.com/download/en/details.aspx?id=5582'), ltError);
      end;
    end;
  end
  else
  begin
    if PIDList.Count > 0 then
    begin
      for i := 0 to PIDList.Count - 1 do
      begin
        pPID := integer(PIDList[i]);
        AddLog(_('Stopping') + ' ' + cModuleName + ' ' + Format('(PID: %d)', [pPID]));
        App := Format(basedir + 'apache\bin\pv.exe -f -k -q -i %d', [pPID]);
        AddLog(Format(_('Executing "%s"'), [App]), ltDebug);
        RC := RunProcess(App, SW_HIDE, false);
        if RC = 0 then
          AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
        else
        begin
          ErrMsg := SysUtils.SysErrorMessage(System.GetLastError);
          AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
          //AddLog(Format(_('%s'), [ErrMsg]), ltError);
          if (Pos('SideBySide', SystemErrorMessage(RC)) <> 0)
            or (Pos('VC9', SystemErrorMessage(RC)) <> 0)
            or (Pos('VC9', ErrMsg) <> 0 )
            or (Pos('SideBySide', ErrMsg) <> 0) then
          begin
            AddLog(_('You appear to be missing the VC9 Runtime Files'), ltError);
            AddLog(_('You need to download and install the Microsoft Visual C++ 2008 SP1 (x86) Runtimes'), ltError);
            AddLog(_('http://www.microsoft.com/download/en/details.aspx?id=5582'), ltError);
          end;
        end;
      end;
    end
    else
    begin
      AddLog(_('No PIDs found?!'));
    end;
  end;
end;

procedure tApache.UpdateStatus;
var
  p: integer;
  ProcInfo: TProcInfo;
  s: string;
  Ports: string;
begin
  isRunning := false;
  PIDList.Clear;
  for p := 0 to Processes.ProcessList.Count - 1 do
  begin
    ProcInfo := Processes.ProcessList[p];
    if (pos('httpd.exe', ProcInfo.Module) = 1) then
    begin
      if (pos(IntToStr(Config.ServicePorts.Apache),NetStatTable.GetPorts4PID(ProcInfo.PID)) <> 0) or
      (pos(IntToStr(Config.ServicePorts.ApacheSSL),NetStatTable.GetPorts4PID(ProcInfo.PID)) <> 0) or
      (pos(BaseDir, ProcInfo.ExePath) <> 0) then
      begin
        isRunning := true;
        PIDList.Add(Pointer(ProcInfo.PID));
      end;
    end;
  end;

  // Checking processes
  s := '';
  for p := 0 to PIDList.Count - 1 do
  begin
    if p = 0 then
      s := IntToStr(integer(PIDList[p]))
    else
      s := s + #13 + IntToStr(integer(PIDList[p]));
  end;
  if s <> OldPIDs then
  begin
    lPID.Caption := s;
    OldPIDs := s;
  end;

  // Checking netstats
  s := '';
  for p := 0 to PIDList.Count - 1 do
  begin
    Ports := NetStatTable.GetPorts4PID(integer(PIDList[p]));
    if Ports <> '' then
    //begin
    //  if s = '' then
        s := RemoveDuplicatePorts(Ports);
    //  else
    //    s := s + ', ' + Ports;
    //end;
  end;
  if s <> OldPorts then
  begin
    lPort.Caption := s;
    OldPorts := s;
  end;

  if byte(isRunning) <> oldIsRunningByte then
  begin
    if oldIsRunningByte <> 2 then
    begin
      if isRunning then
        s := _('running')
      else
        s := _('stopped');
      AddLog(_('Status change detected:') + ' ' + s);
    end;

    oldIsRunningByte := byte(isRunning);
    if isRunning then
    begin
      pStatus.Color := cRunningColor;
      bStartStop.Caption := _('Stop');
      bAdmin.Enabled := true;
    end
    else
    begin
      pStatus.Color := cStoppedColor;
      bStartStop.Caption := _('Start');
      bAdmin.Enabled := false;
    end;
  end;

  if AutoStart then
  begin
    AutoStart := false;
    if isRunning then
    begin
      AddLog(_('Autostart active: module is already running - aborted'), ltError);
    end
    else
    begin
      AddLog(_('Autostart active: starting...'));
      Start;
    end;
  end;

end;

end.
