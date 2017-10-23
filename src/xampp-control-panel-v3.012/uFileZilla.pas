unit uFileZilla;

interface

uses GnuGettext, uBaseModule, SysUtils, Classes, Windows, ExtCtrls, StdCtrls, Buttons, uNetstatTable, uTools, uProcesses, uServices;

type
  tFileZilla = class(tBaseModule)
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

const // cServiceName = 'FileZilla Server';
  cModuleName = 'FileZilla';

  { tFileZilla }

procedure tFileZilla.AddLog(Log: string; LogType: tLogType);
begin
  inherited AddLog('filezilla', Log, LogType);
end;

procedure tFileZilla.Admin;
var
  App: string;
begin
  App := BaseDir + 'filezillaftp\filezilla server interface.exe';
  AddLog(Format(_('Executing "%s"'), [App]), ltDebug);
  ExecuteFile(App, '', '', SW_SHOW);
end;

procedure tFileZilla.CheckIsService;
var
  s: string;
  path: string;
begin
  inherited CheckIsService(trim(Config.ServiceNames.FileZilla));
  if isService then
  begin
    s := _('Service installed');
    path:=GetServicePath(trim(Config.ServiceNames.FileZilla));
  end
  else
    s := _('Service not installed');
  AddLog(Format(_('Checking for service (name="%s"): %s'), [trim(Config.ServiceNames.FileZilla), s]), ltDebug);
  if (path<>'') then
  begin
    if(Pos(LowerCase(BaseDir + 'FileZillaFTP\FileZillaServer.exe'), LowerCase(path))<>0) then
      AddLog(Format(_('Service Path: %s'), [path]), ltDebug)
    else
    begin
      AddLog(_('FileZilla Service Detected With Wrong Path'), ltError);
      AddLog(_('Uninstall the service manually first'), ltError);
    end
  end
  else
    AddLog(_('Service Path: Service Not Installed'), ltDebug);
end;

constructor tFileZilla.Create;
var
  PortBlocker: string;
  ServerApp: string;
  Ports: array [0 .. 1] of integer;
  p: integer;
  path: string;
begin
  inherited;
  ModuleName := cModuleName;
  isService := false;
  AddLog(_('Initializing module...'), ltDebug);
  ServerApp := BaseDir + 'FileZillaFTP\FileZillaServer.exe';
  Ports[0] := Config.ServicePorts.FileZilla;
  Ports[1] := Config.ServicePorts.FileZillaAdmin;
  if not FileExists(ServerApp) then
  begin
    AddLog(_('Possible problem detected: FileZilla Not Found!'), ltError);
    AddLog(_('Run this program from your XAMPP root directory!'), ltError);
  end;

  CheckIsService;
  path:=GetServicePath(trim(Config.ServiceNames.FileZilla));

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
          AddLog(Format(_('XAMPP FileZilla FTP Server is already running on port %d'), [Ports[p]]), ltInfo);
        end
        else if (pos(LowerCase(PortBlocker), LowerCase(path))<>0) and (isService = True) then
        begin
          AddLog(Format(_('XAMPP FileZilla FTP Server Service is already running on port %d'), [Ports[p]]), ltInfo);
        end
        else
        begin
          AddLog(_('Possible problem detected!'), ltError);
          AddLog(Format(_('Port %d in use by "%s"!'), [Ports[p], PortBlocker]), ltError);
        end;
      end;
    end;
  end;
end;

destructor tFileZilla.Destroy;
begin
  inherited;
end;

procedure tFileZilla.ServiceInstall;
var
  App, Param1, Param2, Param3: string;
  RC: integer;
begin
  App := BaseDir + 'filezillaftp\filezillaserver.exe';
  Param1 := '-install';
  Param2 := '-servicename ' + trim(Config.ServiceNames.FileZilla);
  Param3 := '-servicedisplayname ' + Config.ServiceNames.FileZilla;
  AddLog(_('Setting Service Name...'));
  AddLog(Format(_('Executing "%s %s"'), [App, Param2]), ltDebug);
  ExecuteFile(App, Param2, basedir, SW_HIDE);
  //RunAsAdmin(App, Param2, SW_HIDE);
  AddLog(_('Setting Service Display Name...'));
  AddLog(Format(_('Executing "%s %s"'), [App, Param3]), ltDebug);
  ExecuteFile(App, Param3, basedir, SW_HIDE);
  //RunAsAdmin(App, Param3, SW_HIDE);
  AddLog(_('Installing service...'));
  AddLog(Format(_('Executing "%s %s"'), [App, Param1]), ltDebug);
  RC := RunAsAdmin(App, Param1, SW_HIDE);
  if RC = 0 then
    AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
  else
    AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
end;

procedure tFileZilla.ServiceUnInstall;
var
  App, Param: string;
  RC: Cardinal;
begin
  App := BaseDir + 'filezillaftp\filezillaserver.exe';
  Param := '-uninstall';
  AddLog('Uninstalling service...');
  AddLog(Format(_('Executing "%s" "%s"'), [App, Param]), ltDebug);
  RC := RunAsAdmin(App, Param, SW_HIDE);
  if RC = 0 then
    AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
  else
    AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
end;

procedure tFileZilla.Start;
var
  App: string; //, Param: string;
  RC: Cardinal;
begin
  if isService then
  begin
    AddLog(Format(_('Starting %s service...'), [cModuleName]));
    App := Format('start "%s"', [trim(Config.ServiceNames.FileZilla)]);
    AddLog(Format(_('Executing "%s"'), ['net ' + App]), ltDebug);
    RC := RunAsAdmin('net', App, SW_HIDE);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
  end
  else
  begin
    //App := BaseDir + 'filezillaftp\filezillaserver.exe';
    //Param := '-compat -start';
    App := BaseDir + 'filezillaftp\filezillaserver.exe -compat -start';
    AddLog(Format(_('Starting %s app...'), [cModuleName]));
    //AddLog(Format(_('Executing "%s" "%s"'), [App, Param]), ltDebug);
    AddLog(Format(_('Executing "%s"'), [App]), ltDebug);
    //RC := RunAsAdmin(App, Param, SW_HIDE);
    RC := RunProcess(App, SW_HIDE, false);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
  end;
end;

procedure tFileZilla.Stop;
var
  App: string; //, Param: string;
  RC: Cardinal;
begin
  if isService then
  begin
    AddLog(Format(_('Stopping %s service...'), [cModuleName]));
    App := Format('stop "%s"', [trim(Config.ServiceNames.FileZilla)]);
    AddLog(Format(_('Executing "%s"'), ['net ' + App]), ltDebug);
    RC := RunAsAdmin('net', App, SW_HIDE);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
  end
  else
  begin
    //App := BaseDir + 'filezillaftp\filezillaserver.exe';
    //Param := '-compat -stop';
    App := BaseDir + 'filezillaftp\filezillaserver.exe -compat -stop';
    AddLog(Format(_('Stopping %s app...'), [cModuleName]));
    //AddLog(Format(_('Executing "%s" "%s"'), [App, Param]), ltDebug);
    AddLog(Format(_('Executing "%s"'), [App]), ltDebug);
    //RC := RunAsAdmin(App, Param, SW_HIDE);
    RC := RunProcess(App, SW_HIDE, false);
    if RC = 0 then
      AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
    else
      AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
  end;
end;

procedure tFileZilla.UpdateStatus;
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
    if (pos('filezillaserver.exe', ProcInfo.Module) = 1) then
    begin
      if (pos(IntToStr(Config.ServicePorts.FileZilla),NetStatTable.GetPorts4PID(ProcInfo.PID)) <> 0) or
      (pos(IntToStr(Config.ServicePorts.FileZillaAdmin),NetStatTable.GetPorts4PID(ProcInfo.PID)) <> 0) or
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
   // begin
   //   if s = '' then
        s := RemoveDuplicatePorts(Ports);
   //   else
   //     s := s + ', ' + Ports;
   // end;
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
