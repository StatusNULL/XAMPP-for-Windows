unit uMercury;

interface

uses GnuGettext, uBaseModule, SysUtils, Classes, Windows, ExtCtrls, StdCtrls,
  Buttons,
  uNetstatTable, uTools, uProcesses;

type
  tMercury = class(tBaseModule)
    OldPIDs, OldPorts: string;
    procedure ServiceInstall; override;
    procedure ServiceUnInstall; override;
    procedure Start; override;
    procedure Stop; override;
    procedure Admin; override;
    procedure UpdateStatus; override;
    procedure AddLog(Log: string; LogType: tLogType = ltDefault); reintroduce;
    constructor Create(pbbService: TBitBtn; pStatusPanel: tPanel; pPIDLabel, pPortLabel: tLabel; pStartStopButton, pAdminButton: TBitBtn);
    destructor Destroy; override;
  end;

implementation

uses uMain;

const
  // cServiceName = 'Mercury';
  cModuleName = 'Mercury';

var
  hWindow: HWND;

  { tMercury }

procedure tMercury.AddLog(Log: string; LogType: tLogType);
begin
  inherited AddLog('mercury', Log, LogType);
end;

function EnumProcess(hHwnd: HWND; lParam: integer): boolean; stdcall;
var
  pPid: DWORD;
  title, ClassName: string;
begin
  if (hHwnd = 0) then
  begin
    result := false;
  end
  else
  begin
    GetWindowThreadProcessId(hHwnd, pPid);
    SetLength(ClassName, 255);
    SetLength(ClassName, GetClassName(hHwnd, PChar(ClassName), Length(ClassName)));
    SetLength(title, 255);
    SetLength(title, GetWindowText(hHwnd, PChar(title), Length(title)));
    // fMain.Addlog(
    // 'Class Name = ' + className +
    // '; Title = ' + title +
    // '; HWND = ' + IntToStr(hHwnd) +
    // '; Pid = ' + IntToStr(pPid)
    // );
    if title = 'Mercury/32' then
    begin
      hWindow := hHwnd;
    end;

    result := true;
  end;
end;

procedure tMercury.Admin;
begin
  hWindow := 0;
  EnumWindows(@EnumProcess, 0);
  if hWindow <> 0 then
    ShowWindow(hWindow, SW_SHOW);
end;

constructor tMercury.Create;
// const Ports:array[0..6] of integer=(25,79,105,106,110,143,2224);
var
  PortBlocker: string;
  ServerApp: string;
  p: integer;
  Ports: array [0 .. 6] of integer;
  // DidShowRunningWarn: Boolean;
  BlockedPorts: string;
begin
  inherited;
  ModuleName := cModuleName;
  Ports[0] := Config.ServicePorts.Mercury1;
  Ports[1] := Config.ServicePorts.Mercury2;
  Ports[2] := Config.ServicePorts.Mercury3;
  Ports[3] := Config.ServicePorts.Mercury4;
  Ports[4] := Config.ServicePorts.Mercury5;
  Ports[5] := Config.ServicePorts.Mercury6;
  Ports[6] := Config.ServicePorts.Mercury7;
  isService := false;
  // DidShowRunningWarn:=false;
  AddLog(_('Initializing module...'), ltDebug);
  ServerApp := basedir + 'MercuryMail\mercury.exe';
  if not FileExists(ServerApp) then
  begin
    AddLog(_('Possible problem detected: Mercury Not Found!'), ltError);
    AddLog(_('Run this program from your XAMPP root directory!'), ltError);
  end;

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
          // if NOT DidShowRunningWarn then
          // AddLog(Format(_('"%s" seems to be running on port %d?'),[ServerApp,Ports[p]]),ltError);
          // DidShowRunningWarn:=true;
          if BlockedPorts = '' then
            BlockedPorts := InttoStr(Ports[p])
          else
            BlockedPorts := BlockedPorts + ', ' + InttoStr(Ports[p]);
        end
        else
        begin
          //AddLog('Possible problem detected: Port ' + InttoStr(Ports[p]) + ' in use by "' + PortBlocker + '"!', ltError);
          AddLog(_('Possible problem detected!'), ltError);
          AddLog(Format(_('Port %d in use by "%s"!'), [Ports[p], PortBlocker]), ltError);
        end;
      end;
    end;
    if BlockedPorts <> '' then
    begin
      AddLog(_('XAMPP Mercury is already running'), ltInfo);
      AddLog(Format(_('Ports in use: %s'), [BlockedPorts]), ltInfo);
    end;
  end;
end;

destructor tMercury.Destroy;
begin
  inherited;
end;

procedure tMercury.ServiceInstall;
begin
  inherited;
end;

procedure tMercury.ServiceUnInstall;
begin
  inherited;
end;

procedure tMercury.Start;
var
  App: string;
  RC : Cardinal;
begin
  App := basedir + 'MercuryMail\mercury.exe';
  AddLog(Format(_('Starting %s app...'), [cModuleName]));
  AddLog(Format(_('Executing "%s"'), [App]), ltDebug);
  RC := RunProcess(App, SW_HIDE, false);
  if RC = 0 then
    AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
  else
    AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
  //AddLog('Starting Mercury...');
end;

procedure tMercury.Stop;
var
  App: string;
  RC: Cardinal;
begin
  Admin;
  AddLog(_('Stopping') + ' ' + cModuleName);
  App := basedir + 'apache\bin\pv.exe -f -c mercury.exe -q -e';
  AddLog(Format(_('Executing "%s"'), [App]), ltDebug);
  RC := RunProcess(App, SW_HIDE, false);
  if RC = 0 then
    AddLog(Format(_('Return code: %d'), [RC]), ltDebug)
  else
    AddLog(Format(_('There may be an error, return code: %d - %s'), [RC, SystemErrorMessage(RC)]), ltError);
end;

procedure tMercury.UpdateStatus;
var
  p: integer;
  ProcInfo: TProcInfo;
  s: string;
  Ports: string;
begin
  if isService then
  begin
  end
  else
  begin
    isRunning := false;
    PIDList.Clear;
    for p := 0 to Processes.ProcessList.Count - 1 do
    begin
      ProcInfo := Processes.ProcessList[p];
      if (pos(basedir, ProcInfo.ExePath) = 1) and (pos('mercury.exe', ProcInfo.Module) = 1) then
      begin
        isRunning := true;
        PIDList.Add(Pointer(ProcInfo.PID));
      end;
    end;
  end;
  s := '';
  // Checking processes
  for p := 0 to PIDList.Count - 1 do
  begin
    if p = 0 then
      s := InttoStr(integer(PIDList[p]))
    else
      s := s + #13 + InttoStr(integer(PIDList[p]));
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
