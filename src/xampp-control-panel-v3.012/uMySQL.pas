unit uMySQL;

interface

uses GnuGettext, uBaseModule, SysUtils, Classes, Windows, ExtCtrls, StdCtrls, Buttons, uNetstatTable, uTools, uProcesses, uServices;

type
  tMySQL = class(tBaseModule)
    OldPIDs, OldPorts: string;
    procedure ServiceInstall; override;
    procedure ServiceUnInstall; override;
    procedure Start; override;
    procedure Stop; override;
    procedure Admin; override;
    procedure UpdateStatus; override;
    procedure CheckIsService; reintroduce;
    procedure AddLog(Log: string; LogType: tLogType = ltDefault); reintroduce;
    constructor Create(pbbService: TBitBtn; pStatusPanel: tPanel; pPIDLabel, pPortLabel: tLabel; pStartStopButton, pAdminButton: TBitBtn);
    destructor Destroy; override;
  end;

implementation

const // cServiceName = 'mysql';
  cModuleName = 'mysql';

  { tMySQL }

procedure tMySQL.AddLog(Log: string; LogType: tLogType);
begin
  inherited AddLog('mysql', Log, LogType);
end;

procedure tMySQL.Admin;
var
  App, Param: string;
begin
  if Config.ServicePorts.Apache = 80 then
    Param := 'http://localhost/phpmyadmin/'
  else
    Param := 'http://localhost:' + IntToStr(Config.ServicePorts.Apache) + '/phpmyadmin';
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

procedure tMySQL.CheckIsService;
var
  s: string;
  path: string;
begin
  inherited CheckIsService(Config.ServiceNames.MySQL);
  if isService then
  begin
    s := _('Service installed');
    path:=GetServicePath(Config.ServiceNames.MySQL);
  end
  else
    s := _('Service not installed');
  AddLog(Format(_('Checking for service (name="%s"): %s'), [Config.ServiceNames.MySQL, s]), ltDebug);
  if (path<>'') then
  begin
    if (Pos(LowerCase(basedir + 'mysql\bin\mysqld.exe'), LowerCase(path))<>0) then
      AddLog(Format(_('Service Path: %s'), [path]), ltDebug)
    else
    begin
      AddLog(_('MySQL Service Detected With Wrong Path'), ltError);
      AddLog(_('Uninstall the service manually first'), ltError);
    end
  end
  else
    AddLog(_('Service Path: Service Not Installed'), ltDebug);
end;

constructor tMySQL.Create;
var
  PortBlocker: string;
  ServerApp: string;
  ServerPort: Integer;
  path: string;
begin
  inherited;
  ModuleName := cModuleName;
  AddLog(_('Initializing module...'), ltDebug);
  ServerApp := basedir + 'mysql\bin\mysqld.exe';
  if not FileExists(ServerApp) then
  begin
    AddLog(_('Possible problem detected: MySQL Not Found!'), ltError);
    AddLog(_('Run this program from your XAMPP root directory!'), ltError);
  end;

  CheckIsService;
  path:=GetServicePath(Config.ServiceNames.MySQL);

  if Config.CheckDefaultPorts then
  begin
    ServerPort := Config.ServicePorts.MySQL;
    AddLog(_('Checking default ports...'), ltDebug);
    PortBlocker := NetStatTable.isPortInUse(ServerPort);
    if (PortBlocker <> '') then
    begin
      //if (LowerCase(PortBlocker) = LowerCase(ServerApp)) then
      if (pos(LowerCase(ServerApp), LowerCase(PortBlocker))<>0) then
      begin
        AddLog(Format(_('XAMPP MySQL is already running on port %d'), [ServerPort]), ltInfo);
      end
      else if (pos(LowerCase(PortBlocker), LowerCase(path))<>0) and (isService = True) then
      begin
        AddLog(Format(_('XAMPP MySQL Service is already running on port %d'), [ServerPort]), ltInfo);
      end
      else
      begin
        AddLog(_('Possible problem detected!'), ltError);
        AddLog(Format(_('Port %d in use by "%s"!'), [ServerPort, PortBlocker]), ltError);
      end;
    end;
  end;
end;

destructor tMySQL.Destroy;
begin
  inherited;
end;

procedure tMySQL.ServiceInstall;
var
  App, Param: string;
  RC: Integer;
begin
  App := '"' + basedir + 'mysql\bin\mysqld.exe"';
  Param := '--install "' + Config.ServiceNames.MySQL + '" --defaults-file="' + basedir + 'mysql\bin\my.ini"';
  AddLog(_('Installing service...'));
  AddLog(Format(_('Executing %s %s'), [App, Param]), ltDebug);
  RC := RunAsAdmin(App, Param, SW_HIDE);
  if RC = 0 then
    AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
  else
    AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
end;

procedure tMySQL.ServiceUnInstall;
var
  App, Param: string;
  RC: Cardinal;
begin
  App := basedir + 'mysql\bin\mysqld.exe';
  Param := '--remove "' + Config.ServiceNames.MySQL + '"';
  AddLog('Uninstalling service...');
  AddLog(Format(_('Executing %s %s'), [App, Param]), ltDebug);
  RC := RunAsAdmin(App, Param, SW_HIDE);
  if RC = 0 then
    AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
  else
    AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
end;

procedure tMySQL.Start;
var
  App: string;
  RC: Cardinal;
begin
  if isService then
  begin
    AddLog(Format(_('Starting %s service...'), [cModuleName]));
    App := Format('start "%s"', [Config.ServiceNames.MySQL]);
    AddLog(Format(_('Executing "%s"'), ['net ' + App]), ltDebug);
    RC := RunAsAdmin('net', App, SW_HIDE);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
    begin
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
      //AddLog(Format(_('%s'), [SysUtils.SysErrorMessage(System.GetLastError)]), ltError);
    end;
  end
  else
  begin
    AddLog(Format(_('Starting %s app...'), [cModuleName]));
    //App := basedir + 'mysql\bin\mysqld.exe --defaults-file=' + basedir + 'mysql\bin\my.ini --standalone';
    App := '"' + basedir + 'mysql\bin\mysqld.exe" --defaults-file="' + basedir + 'mysql\bin\my.ini" --standalone';
    AddLog(Format(_('Executing "%s"'), [App]), ltDebug);
    RC := RunProcess(App, SW_HIDE, false);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
    begin
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
      //AddLog(Format(_('%s'), [SysUtils.SysErrorMessage(System.GetLastError)]), ltError);
    end;
  end;
end;

procedure tMySQL.Stop;
var
  i, pPID: Integer;
  App: string;
  RC: Cardinal;
begin
  if isService then
  begin
    AddLog(Format(_('Stopping %s service...'), [cModuleName]));
    App := Format('stop "%s"', [Config.ServiceNames.MySQL]);
    AddLog(Format(_('Executing "%s"'), ['net ' + App]), ltDebug);
    RC := RunAsAdmin('net', App, SW_HIDE);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
    begin
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
      AddLog(Format(_('%s'), [SysUtils.SysErrorMessage(System.GetLastError)]), ltError);
    end;
  end
  else
  begin
    if PIDList.Count > 0 then
    begin
      for i := 0 to PIDList.Count - 1 do
      begin
        pPID := Integer(PIDList[i]);
        AddLog(_('Stopping') + ' ' + cModuleName + ' ' + Format('(PID: %d)', [pPID]));
        App := Format(basedir + 'apache\bin\pv.exe -f -k -q -i %d', [pPID]);
        AddLog(Format(_('Executing "%s"'), [App]), ltDebug);
        RC := RunProcess(App, SW_HIDE, false);
        if RC = 0 then
          AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
        else
        begin
          AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
          AddLog(Format(_('%s'), [SysUtils.SysErrorMessage(System.GetLastError)]), ltError);
        end;
      end;
    end
    else
    begin
      AddLog(_('No PIDs found?!'));
    end;
  end;
end;

procedure tMySQL.UpdateStatus;
var
  p: Integer;
  ProcInfo: TProcInfo;
  s: string;
  ports: string;
begin
  isRunning := false;
  PIDList.Clear;
  for p := 0 to Processes.ProcessList.Count - 1 do
  begin
    ProcInfo := Processes.ProcessList[p];
    if (pos('mysqld.exe', ProcInfo.Module) = 1) then
    begin
      if (pos(IntToStr(Config.ServicePorts.MySQL),NetStatTable.GetPorts4PID(ProcInfo.PID)) <> 0) or
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
      s := IntToStr(Integer(PIDList[p]))
    else
      s := s + #13 + IntToStr(Integer(PIDList[p]));
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
    ports := NetStatTable.GetPorts4PID(Integer(PIDList[p]));
    if ports <> '' then
    //begin
    //  if s = '' then
        s := RemoveDuplicatePorts(ports);
    //  else
    //    s := s + ', ' + ports;
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
