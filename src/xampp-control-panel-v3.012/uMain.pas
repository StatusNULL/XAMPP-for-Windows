(*
  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/ or
  send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

  Programmed by Steffen Strueber,

  Updates:
  3.0.2: May 10th 2011, Steffen Strueber
  3.0.12: June 24th 2012, hackattack142
*)

unit uMain;

interface

uses
  GnuGettext, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, uTools, uTomcat,
  uApache, uMySQL, uFileZilla, uMercury, uNetstat, uNetstatTable, Menus,
  IniFiles, uProcesses, AppEvnts, ImgList, JCLDebug, JCLSysInfo;

type
  TfMain = class(TForm)
    imgXAMPP: TImage;
    lHeader: TLabel;
    bConfig: TBitBtn;
    bSCM: TBitBtn;
    gbModules: TGroupBox;
    bApacheAction: TBitBtn;
    bApacheAdmin: TBitBtn;
    bMySQLAction: TBitBtn;
    bMySQLAdmin: TBitBtn;
    bFileZillaAction: TBitBtn;
    bFileZillaAdmin: TBitBtn;
    bMercuryAction: TBitBtn;
    bMercuryAdmin: TBitBtn;
    sbMain: TStatusBar;
    bQuit: TBitBtn;
    bHelp: TBitBtn;
    bExplorer: TBitBtn;
    pApacheStatus: TPanel;
    TimerUpdateStatus: TTimer;
    TrayIcon1: TTrayIcon;
    bNetstat: TBitBtn;
    puSystray: TPopupMenu;
    miShowHide: TMenuItem;
    miTerminate: TMenuItem;
    N1: TMenuItem;
    bApacheConfig: TBitBtn;
    lPIDs: TLabel;
    lPorts: TLabel;
    lApachePIDs: TLabel;
    bApacheLogs: TBitBtn;
    lApachePorts: TLabel;
    bMySQLConfig: TBitBtn;
    bMySQLLogs: TBitBtn;
    bFileZillaConfig: TBitBtn;
    bFileZillaLogs: TBitBtn;
    bMercuryConfig: TBitBtn;
    reLog: TRichEdit;
    lMySQLPIDs: TLabel;
    lMySQLPorts: TLabel;
    lFileZillaPorts: TLabel;
    lFileZillaPIDs: TLabel;
    lMercuryPorts: TLabel;
    lMercuryPIDs: TLabel;
    pMySQLStatus: TPanel;
    pFileZillaStatus: TPanel;
    pMercuryStatus: TPanel;
    ApplicationEvents1: TApplicationEvents;
    ImageList: TImageList;
    bMySQLService: TBitBtn;
    bFileZillaService: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    bApacheService: TBitBtn;
    bMercurylogs: TBitBtn;
    puGeneral: TPopupMenu;
    lTomcatPorts: TLabel;
    lTomcatPIDs: TLabel;
    bTomcatAction: TBitBtn;
    bTomcatAdmin: TBitBtn;
    bTomcatConfig: TBitBtn;
    pTomcatStatus: TPanel;
    bTomcatLogs: TBitBtn;
    bTomcatService: TBitBtn;
    bMercuryService: TBitBtn;
    bXamppShell: TBitBtn;
    puLog: TPopupMenu;
    Copy1: TMenuItem;
    SelectAll1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure bApacheActionClick(Sender: TObject);
    procedure TimerUpdateStatusTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bNetstatClick(Sender: TObject);
    procedure miTerminateClick(Sender: TObject);
    procedure bQuitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miShowHideClick(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure bExplorerClick(Sender: TObject);
    procedure bSCMClick(Sender: TObject);
    procedure bApacheAdminClick(Sender: TObject);
    procedure bApacheConfigClick(Sender: TObject);
    procedure miGeneralClick(Sender: TObject);
    procedure bConfigClick(Sender: TObject);
    procedure bApacheLogsClick(Sender: TObject);
    procedure miApacheLogsAccessClick(Sender: TObject);
    procedure miApacheLogsErrorClick(Sender: TObject);
    procedure bMySQLActionClick(Sender: TObject);
    procedure bMySQLAdminClick(Sender: TObject);
    procedure bMySQLConfigClick(Sender: TObject);
    procedure bMySQLLogsClick(Sender: TObject);
    procedure bFileZillaActionClick(Sender: TObject);
    procedure bFileZillaAdminClick(Sender: TObject);
    procedure bFileZillaConfigClick(Sender: TObject);
    procedure bFileZillaLogsClick(Sender: TObject);
    procedure bMercuryActionClick(Sender: TObject);
    procedure bMercuryAdminClick(Sender: TObject);
    procedure bMercuryConfigClick(Sender: TObject);
    procedure bHelpClick(Sender: TObject);
    procedure bApacheServiceClick(Sender: TObject);
    procedure bMySQLServiceClick(Sender: TObject);
    procedure bFileZillaServiceClick(Sender: TObject);
    procedure bMercuryServiceClick(Sender: TObject);
    procedure bMercurylogsClick(Sender: TObject);
    procedure bXamppShellClick(Sender: TObject);
    procedure bTomcatConfigClick(Sender: TObject);
    procedure bTomcatLogsClick(Sender: TObject);
    procedure bTomcatActionClick(Sender: TObject);
    procedure bTomcatAdminClick(Sender: TObject);
    procedure bTomcatServiceClick(Sender: TObject);
    procedure miActionTomcatAutoClick(Sender: TObject);
    procedure miActionTomcatStopClick(Sender: TObject);
    procedure miActionTomcatStartClick(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure Copy1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
  private
    Apache: tApache;
    MySQL: tMySQL;
    FileZilla: tFileZilla;
    Mercury: tMercury;
    Tomcat: tTomcat;
    WindowsShutdownInProgress: Boolean;
    procedure UpdateStatusAll;
    function TryGuessXamppVersion: string;
    procedure EditConfigLogs(ConfigFile: string);
    procedure GeneralPUClear;
    procedure GeneralPUAdd(text: string = ''; hint: string = ''; tag: integer = 0);
    procedure GeneralPUAddUser(text: string; hint: string = '');
    procedure GeneralPUAddUserFromSL(sl: tStringList);
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QueryEndSession; // detect Windows shutdown message
    procedure SaveLogFile;
    procedure updateTimerStatus(enabled: Boolean);
  public
    procedure AddLog(module, log: string; LogType: tLogType = ltDefault); overload;
    procedure AddLog(log: string; LogType: tLogType = ltDefault); overload;
    procedure AdjustLogFont(Name: string; Size: integer);
  end;

var
  fMain: TfMain;

implementation

uses uConfig, uHelp;

{$R *.dfm}

procedure TfMain.updateTimerStatus(enabled: Boolean);
begin
  TimerUpdateStatus.Enabled := enabled;
end;

procedure TfMain.miShowHideClick(Sender: TObject);
begin
  if Visible then
  begin
    Hide;
    if fMain.WindowState = wsMinimized then
      fMain.WindowState := wsNormal;
  end
  else
  begin
    Show;
    if fMain.WindowState = wsMinimized then
      fMain.WindowState := wsNormal;
    Application.BringToFront;
  end;
end;

procedure TfMain.miGeneralClick(Sender: TObject);
var
  mi: TMenuItem;
  App: string;
begin
  if not(Sender is TMenuItem) then
    exit;
  mi := Sender as TMenuItem;
  if mi.tag = 0 then
    EditConfigLogs(mi.hint);
  if mi.tag = 1 then
  begin
    App := BaseDir + mi.hint;
    ExecuteFile(App, '', '', SW_SHOW);
    AddLog(Format(_('Executing "%s"'), [App]));
  end;
end;

procedure TfMain.AddLog(module, log: string; LogType: tLogType = ltDefault);
begin
  if (not Config.ShowDebug) and (LogType = ltDebug) or (LogType = ltDebugDetails) then
    exit;
  if (LogType = ltDebugDetails) and (Config.DebugLevel = 0) then
    exit;

  with reLog do
  begin
    SelStart := GetTextLen;

    SelAttributes.Color := clGray;
    SelText := TimeToStr(Now) + '  ';

    SelAttributes.Color := clBlack;
    SelText := '[';

    SelAttributes.Color := clBlue;
    SelText := module;

    SelAttributes.Color := clBlack;
    SelText := '] ' + #9;

    case LogType of
      ltDefault:
        SelAttributes.Color := clBlack;
      ltInfo:
        SelAttributes.Color := clBlue;
      ltError:
        SelAttributes.Color := clRed;
      ltDebug:
        SelAttributes.Color := clGray;
      ltDebugDetails:
        SelAttributes.Color := clSilver;
    end;

    SelText := log + #13;

    // SelStart := GetTextLen;
    SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  end;

end;

procedure TfMain.AddLog(log: string; LogType: tLogType = ltDefault);
begin
  AddLog('main', log, LogType);
end;

procedure TfMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
var
  ts: tStringList;
  i: integer;
begin
  // GlobalAddLog(Format('Exception in thread: %d / %s', [Thread.ThreadID, JclDebugThreadList.ThreadClassNames[Thread.ThreadID]]),0,'LogException');
  // Note: JclLastExceptStackList always returns list for *current* thread ID. To simplify getting the
  // stack of thread where an exception occured JclLastExceptStackList returns stack of the thread instead
  // of current thread when called *within* the JclDebugThreadList.OnSyncException handler. This is the
  // *only* exception to the behavior of JclLastExceptStackList described above.
  ts := tStringList.Create;

  AddLog('EXCEPTION', E.Message, ltError);

  JclLastExceptStackList.AddToStrings(ts, True, True, True);
  for i := 0 to ts.count - 1 do
    AddLog('EXCEPTION', ts[i], ltError);
  ts.Free;
end;

procedure TfMain.miActionTomcatAutoClick(Sender: TObject);
begin
  if Tomcat.isRunning then
    Tomcat.Stop
  else
    Tomcat.Start;
end;

procedure TfMain.miActionTomcatStartClick(Sender: TObject);
begin
  Tomcat.Start;
end;

procedure TfMain.miActionTomcatStopClick(Sender: TObject);
begin
  Tomcat.Stop
end;

procedure TfMain.bApacheActionClick(Sender: TObject);
begin
  if Apache.isRunning then
    Apache.Stop
  else
    Apache.Start;
end;

procedure TfMain.miTerminateClick(Sender: TObject);
begin
  //FormDestroy(Sender);
  //TimerUpdateStatus.Enabled := False;
  Closing := True;
  Application.ProcessMessages;
  //Exit;
  Application.Terminate;
  //Close;
end;

procedure TfMain.SaveLogFile;
var
  en: string;
  LogFileName: string;
  f: TextFile;
  i: integer;
begin
  en := ExtractFileName(Application.ExeName);
  while (length(en) > 0) and (en[length(en)] <> '.') do
    en := copy(en, 1, length(en) - 1);
  LogFileName := BaseDir + en + 'log';
  AssignFile(f, LogFileName);
  if FileExists(LogFileName) then
    Append(f)
  else
    Rewrite(f);
  for i := 0 to reLog.Lines.count - 1 do
    Writeln(f, reLog.Lines[i]);
  Writeln(f, '');
  CloseFile(f);
end;

procedure TfMain.SelectAll1Click(Sender: TObject);
begin
  reLog.SelectAll;
end;

procedure TfMain.miApacheLogsAccessClick(Sender: TObject);
begin
  Apache.ShowLogs(altAccess);
end;

procedure TfMain.miApacheLogsErrorClick(Sender: TObject);
begin
  Apache.ShowLogs(altError);
end;

procedure TfMain.bQuitClick(Sender: TObject);
begin
  miTerminateClick(Sender);
end;

procedure TfMain.bExplorerClick(Sender: TObject);
var
  App: string;
begin
  App := BaseDir;
  ExecuteFile(App, '', '', SW_SHOW);
  AddLog(Format(_('Executing "%s"'), [App]));
end;

procedure TfMain.bFileZillaActionClick(Sender: TObject);
begin
  if FileZilla.isRunning then
    FileZilla.Stop
  else
    FileZilla.Start;
end;

procedure TfMain.bFileZillaAdminClick(Sender: TObject);
begin
  FileZilla.Admin;
end;

procedure TfMain.bFileZillaConfigClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAdd('FileZilla Server.xml', 'FileZillaFTP\FileZilla Server.xml');
  GeneralPUAddUserFromSL(Config.UserConfig.FileZilla);
  GeneralPUAdd();
  GeneralPUAdd(_('<Browse>'), 'FileZillaFTP', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.bFileZillaLogsClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAddUserFromSL(Config.UserLogs.FileZilla);
  if DirectoryExists(BaseDir + 'FileZillaFTP\Logs') then
    GeneralPUAdd(_('<Browse>'), 'FileZillaFTP\Logs', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.bFileZillaServiceClick(Sender: TObject);
var
  oldIsService: Boolean;
begin
  oldIsService := FileZilla.isService;

  if FileZilla.isRunning then
  begin
    MessageDlg(_('Services cannot be installed or uninstalled while the service is running!'), mtError, [mbOk], 0);
    exit;
  end;
  if FileZilla.isService then
  begin
    if MessageDlg(Format(_('Click Yes to uninstall the %s service'), [FileZilla.ModuleName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      updateTimerStatus(False);
      FileZilla.ServiceUnInstall;
      updateTimerStatus(True);
    end
    else
      exit;
  end
  else
  begin
    if MessageDlg(Format(_('Click Yes to install the %s service'), [FileZilla.ModuleName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      updateTimerStatus(False);
      FileZilla.ServiceInstall;
      updateTimerStatus(True);
    end
    else
      exit;
  end;
  FileZilla.CheckIsService;
  if (oldIsService = FileZilla.isService) then
  begin
    FileZilla.AddLog(_('Service was NOT (un)installed!'), ltError);
    if (WinVersion.Major = 5) then // WinXP
      FileZilla.AddLog
        (_('One possible reason for failure: On windows security box you !!!MUST UNCHECK!!! the "Protect my computer and data from unauthorized program activity" checkbox!!!'),
        ltError);
  end
  else
  begin
    FileZilla.AddLog(_('Successful!'));
  end;
end;

procedure TfMain.bHelpClick(Sender: TObject);
begin
  fHelp.Show;
end;

procedure TfMain.bApacheServiceClick(Sender: TObject);
var
  oldIsService: Boolean;
begin
  oldIsService := Apache.isService;

  if Apache.isRunning then
  begin
    MessageDlg(_('Services cannot be installed or uninstalled while the service is running!'), mtError, [mbOk], 0);
    exit;
  end;

  if Apache.isService then
  begin
    if MessageDlg(Format(_('Click Yes to uninstall the %s service'), [Apache.ModuleName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      updateTimerStatus(False);
      Apache.ServiceUnInstall;
      updateTimerStatus(True);
    end
    else
      exit;
  end
  else
  begin
    if MessageDlg(Format(_('Click Yes to install the %s service'), [Apache.ModuleName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      updateTimerStatus(False);
      Apache.ServiceInstall;
      updateTimerStatus(True);
    end
    else
      exit;
  end;
  Apache.CheckIsService;
  if (oldIsService = Apache.isService) then
  begin
    Apache.AddLog(_('Service was NOT (un)installed!'), ltError);
    if (WinVersion.Major = 5) then // WinXP
      Apache.AddLog
        (_('One possible reason for failure: On windows security box you !!!MUST UNCHECK!!! the "Protect my computer and data from unauthorized program activity" checkbox!!!'),
        ltError);
  end
  else
  begin
    Apache.AddLog(_('Successful!'));
  end;
end;

procedure TfMain.bMercuryActionClick(Sender: TObject);
begin
  if Mercury.isRunning then
    Mercury.Stop
  else
    Mercury.Start;
end;

procedure TfMain.bMercuryAdminClick(Sender: TObject);
begin
  Mercury.Admin;
end;

procedure TfMain.bMercuryConfigClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAdd('mercury.ini', 'MercuryMail\mercury.ini');
  GeneralPUAddUserFromSL(Config.UserConfig.Mercury);
  GeneralPUAdd();
  GeneralPUAdd(_('<Browse>'), 'MercuryMail', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.bMercurylogsClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAddUserFromSL(Config.UserLogs.Mercury);
  GeneralPUAdd(_('<Browse>'), 'MercuryMail\LOGS', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.bMercuryServiceClick(Sender: TObject);
begin
  MessageDlg(_('Mercury cannot be run as service!'), mtError, [mbOk], 0);
end;

procedure TfMain.bMySQLActionClick(Sender: TObject);
begin
  if MySQL.isRunning then
    MySQL.Stop
  else
    MySQL.Start;
end;

procedure TfMain.bMySQLAdminClick(Sender: TObject);
begin
  MySQL.Admin;
end;

procedure TfMain.bMySQLConfigClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAdd('my.ini', 'mysql\bin\my.ini');
  GeneralPUAddUserFromSL(Config.UserConfig.MySQL);
  GeneralPUAdd();
  GeneralPUAdd(_('<Browse>'), 'mysql', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.bMySQLLogsClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAdd('error.log', 'mysql\data\mysql_error.log');
  GeneralPUAddUserFromSL(Config.UserLogs.MySQL);
  GeneralPUAdd();
  GeneralPUAdd(_('<Browse>'), 'mysql\data', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.bMySQLServiceClick(Sender: TObject);
var
  oldIsService: Boolean;
begin
  oldIsService := MySQL.isService;

  if MySQL.isRunning then
  begin
    MessageDlg(_('Services cannot be installed or uninstalled while the service is running!'), mtError, [mbOk], 0);
    exit;
  end;
  if MySQL.isService then
  begin
    if MessageDlg(Format(_('Click Yes to uninstall the %s service'), [MySQL.ModuleName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      updateTimerStatus(False);
      MySQL.ServiceUnInstall;
      updateTimerStatus(True);
    end
    else
      exit;
  end
  else
  begin
    if MessageDlg(Format(_('Click Yes to install the %s service'), [MySQL.ModuleName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      updateTimerStatus(False);
      MySQL.ServiceInstall;
      updateTimerStatus(True);
    end
    else
      exit;
  end;
  MySQL.CheckIsService;
  if (oldIsService = MySQL.isService) then
  begin
    MySQL.AddLog(_('Service was NOT (un)installed!'), ltError);
    if (WinVersion.Major = 5) then // WinXP
      MySQL.AddLog
        (_('One possible reason for failure: On windows security box you !!!MUST UNCHECK!!! the "Protect my computer and data from unauthorized program activity" checkbox!!!'),
        ltError);
  end
  else
  begin
    MySQL.AddLog(_('Successful!'));
  end;
end;

procedure TfMain.bConfigClick(Sender: TObject);
begin
  fConfig.Show;
end;

procedure TfMain.bSCMClick(Sender: TObject);
var
  App: string;
begin
  App := 'services.msc';
  ExecuteFile(App, '', '', SW_SHOW);
  AddLog(Format(_('Executing "%s"'), [App]));
end;

procedure TfMain.bTomcatActionClick(Sender: TObject);
begin
  if Tomcat.isRunning then
    Tomcat.Stop
  else
    Tomcat.Start;
end;

procedure TfMain.bTomcatAdminClick(Sender: TObject);
begin
  Tomcat.Admin;
end;

procedure TfMain.bTomcatConfigClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAdd('server.xml', 'Tomcat\conf\server.xml');
  GeneralPUAdd('tomcat-users.xml', 'Tomcat\conf\tomcat-users.xml');
  GeneralPUAdd('web.xml', 'Tomcat\conf\web.xml');
  GeneralPUAdd('context.xml', 'Tomcat\conf\context.xml');
  GeneralPUAddUserFromSL(Config.UserConfig.Tomcat);
  GeneralPUAdd();
  GeneralPUAdd(_('<Browse>'), 'Tomcat\conf', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.bTomcatLogsClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAddUserFromSL(Config.UserLogs.Tomcat);
  GeneralPUAdd();
  GeneralPUAdd(_('<Browse>'), 'tomcat\logs', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.bTomcatServiceClick(Sender: TObject);
var
  oldIsService: Boolean;
begin
  oldIsService := Tomcat.isService;

  if Tomcat.isRunning then
  begin
    MessageDlg(_('Services cannot be installed or uninstalled while the service is running!'), mtError, [mbOk], 0);
    exit;
  end;
  if Tomcat.isService then
  begin
    if MessageDlg(Format(_('Click Yes to uninstall the %s service'), [Tomcat.ModuleName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      updateTimerStatus(False);
      Tomcat.ServiceUnInstall;
      updateTimerStatus(True);
    end
    else
      exit;
  end
  else
  begin
    if MessageDlg(Format(_('Click Yes to install the %s service'), [Tomcat.ModuleName]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      updateTimerStatus(False);
      Tomcat.ServiceInstall;
      updateTimerStatus(True);
    end
    else
      exit;
  end;
  Tomcat.CheckIsService;
  if (oldIsService = Tomcat.isService) then
  begin
    Tomcat.AddLog(_('Service was NOT (un)installed!'), ltError);
    if (WinVersion.Major = 5) then // WinXP
      Tomcat.AddLog
        (_('One possible reason for failure: On windows security box you !!!MUST UNCHECK!!! the "Protect my computer and data from unauthorized program activity" checkbox!!!'),
        ltError);
  end
  else
  begin
    Tomcat.AddLog(_('Successful!'));
  end;

end;

procedure TfMain.bXamppShellClick(Sender: TObject);
const
  cBatchFileContents = '@ECHO OFF' + cr + '' + cr + 'GOTO weiter' + cr + ':setenv' + cr + 'SET "MIBDIRS=%~dp0php\extras\mibs"' + cr +
    'SET "MIBDIRS=%MIBDIRS:\=/%"' + cr + 'SET "MYSQL_HOME=%~dp0mysql\bin"' + cr + 'SET "OPENSSL_CONF=%~dp0apache\bin\openssl.cnf"' + cr +
    'SET "OPENSSL_CONF=%OPENSSL_CONF:\=/%"' + cr + 'SET "PHP_PEAR_SYSCONF_DIR=%~dp0php"' + cr + 'SET "PHPRC=%~dp0php"' + cr + 'SET "TMP=%~dp0tmp"' +
    cr + 'SET "PERL5LIB="' + cr +
    'SET "Path=%~dp0;%~dp0php;%~dp0perl\site\bin;%~dp0perl\bin;%~dp0apache\bin;%~dp0mysql\bin;%~dp0FileZillaFTP;%~dp0MercuryMail;%~dp0sendmail;%~dp0webalizer;%~dp0tomcat\bin;%Path%"'
    + cr + 'GOTO :EOF' + cr + ':weiter' + cr + '' + cr + 'IF "%1" EQU "setenv" (' + cr + '    ECHO.' + cr +
    '    ECHO Setting environment for using XAMPP for Windows.' + cr + '    CALL :setenv' + cr + ') ELSE (' + cr + '    SETLOCAL' + cr +
    '    TITLE XAMPP for Windows' + cr + '    PROMPT %username%@%computername%$S$P$_#$S' + cr + '    START "" /B %COMSPEC% /K "%~f0" setenv'
    + cr + ')';
  cFilename = 'xampp_shell.bat';
var
  ts: tStringList;
  batchfile: string;
begin
  batchfile := BaseDir + cFilename;
  if not FileExists(batchfile) then
  begin
    if MessageDlg(Format(_('File "%s" not found. Should it be created now?'), [batchfile]), mtConfirmation, [mbYes, mbAbort], 0) <> mrYes then
      exit;
    ts := tStringList.Create;
    ts.text := cBatchFileContents;
    try
      ts.SaveToFile(batchfile);
    except
      on E: Exception do
      begin
        MessageDlg(_('Error') + ': ' + E.Message, mtError, [mbOk], 0);
      end;
    end;
    ts.Free;
  end;
  ExecuteFile(batchfile, '', '', SW_SHOW);
end;

procedure TfMain.Copy1Click(Sender: TObject);
begin
  reLog.CopyToClipboard;
end;

procedure TfMain.GeneralPUAdd(text: string = ''; hint: string = ''; tag: integer = 0);
var
  mi: TMenuItem;
begin
  mi := TMenuItem.Create(puGeneral);
  mi.Caption := text;
  if text = '' then
  begin
    mi.Caption := '-';
  end
  else
  begin
    mi.hint := hint;
    mi.tag := tag;
    mi.OnClick := miGeneralClick;
  end;
  puGeneral.Items.Add(mi);
end;

procedure TfMain.GeneralPUAddUser(text: string; hint: string = '');
var
  myCaption: TranslatedUnicodeString;
  mi, miMain: TMenuItem;
begin
  myCaption := _('User defined');
  miMain := puGeneral.Items.Find(myCaption);
  if miMain = nil then
  begin
    GeneralPUAdd();
    miMain := TMenuItem.Create(puGeneral);
    miMain.Caption := myCaption;
    puGeneral.Items.Add(miMain);
  end;

  mi := TMenuItem.Create(miMain);
  mi.Caption := text;
  if hint <> '' then
    mi.hint := hint
  else
    mi.hint := text;
  mi.OnClick := miGeneralClick;
  miMain.Add(mi);
end;

procedure TfMain.GeneralPUAddUserFromSL(sl: tStringList);
var
  i: integer;
begin
  for i := 0 to sl.count - 1 do
    GeneralPUAddUser(sl[i]);
end;

procedure TfMain.GeneralPUClear;
begin
  puGeneral.Items.Clear;
end;

procedure TfMain.EditConfigLogs(ConfigFile: string);
var
  App, Param: string;
begin
  App := Config.EditorApp;
  Param := BaseDir + ConfigFile;
  AddLog(Format(_('Executing %s %s'), [App, Param]), ltDebug);
  ExecuteFile(App, Param, '', SW_SHOW);
end;

procedure TfMain.bNetstatClick(Sender: TObject);
begin
  fNetStat.Show;
  fNetStat.RefreshTable(True);
end;

procedure TfMain.bApacheAdminClick(Sender: TObject);
begin
  Apache.Admin;
end;

procedure TfMain.bApacheConfigClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAdd('Apache (httpd.conf)', 'apache/conf/httpd.conf');
  GeneralPUAdd('Apache (httpd-ssl.conf)', 'apache/conf/extra/httpd-ssl.conf');
  GeneralPUAdd('Apache (httpd-xampp.conf)', 'apache/conf/extra/httpd-xampp.conf');
  GeneralPUAdd('PHP (php.ini)', 'php/php.ini');
  GeneralPUAdd('phpMyAdmin (config.inc.php)', 'phpMyAdmin/config.inc.php');
  GeneralPUAddUserFromSL(Config.UserConfig.Apache);
  GeneralPUAdd();
  GeneralPUAdd(_('<Browse>') + ' [Apache]', 'apache', 1);
  GeneralPUAdd(_('<Browse>') + ' [PHP]', 'php', 1);
  GeneralPUAdd(_('<Browse>') + ' [phpMyAdmin]', 'phpMyAdmin', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.bApacheLogsClick(Sender: TObject);
begin
  GeneralPUClear;
  GeneralPUAdd('access.log', 'apache\logs\access.log');
  GeneralPUAdd('error.log', 'apache\logs\error.log');
  GeneralPUAddUserFromSL(Config.UserLogs.Apache);
  GeneralPUAdd();
  GeneralPUAdd(_('<Browse>'), 'apache\logs', 1);
  puGeneral.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if WindowsShutdownInProgress then
  begin
    CanClose := True;
  end
  else
  begin
    CanClose := false;
    Hide;
  end;
end;

procedure TfMain.AdjustLogFont(Name: string; Size: integer);
begin
  reLog.Font.Name := Name;
  reLog.Font.Size := Size;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  isAdmin: Boolean;
  xamppVersion: string;
  CCVersion: string;
  Bitness: string;
  OSVersionInfoEx: TOSVersionInfoEx;
begin
  TranslateComponent(Self);

  BaseDir := LowerCase(ExtractFilePath(Application.ExeName));

  reLog.PopupMenu := puLog;
  reLog.Font.Name := Config.LogSettings.Font;
  reLog.Font.Size := Config.LogSettings.FontSize;

  AddLog(_('Initializing Control Panel'));

  self.Left := Config.WindowSettings.Left;
  self.Top := Config.WindowSettings.Top;

  if (Config.WindowSettings.Width <> -1) then
    self.Width := Config.WindowSettings.Width;
  if (Config.WindowSettings.Height <> -1) then
    self.Height := Config.WindowSettings.Height;

  // WinVersion:=GetWinVersion;
  WindowsShutdownInProgress := false;

  if IsWindows64 then
    Bitness := '64-bit'
  else
    Bitness := '32-bit';

  AddLog(Format(_('Windows Version: %s %s %s'), [GetWindowsProductString, GetWindowsServicePackVersionString, Bitness]));
  // AddLog(Format(_('Windows version: %s'),[WinVersion.WinVersion]));

  OSVersionInfoEx.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(OSVersionInfoEx);

  if ((OSVersionInfoEx.dwMajorVersion = 5) and (OSVersionInfoEx.dwMinorVersion = 0)) or (OSVersionInfoEx.dwMajorVersion < 5) then
    AddLog(_('WARNING: Your Operating System is too old and is not supported'), ltError);

  xamppVersion := TryGuessXamppVersion;
  AddLog('XAMPP Version: ' + xamppVersion);

  if cCompileDate <> '' then
    CCVersion := GlobalProgramversion + Format(' [ Compiled: %s ]', [cCompileDate])
  else
    CCVersion := GlobalProgramversion;
  AddLog('Control Panel Version: ' + CCVersion);

  Caption := 'XAMPP Control Panel v' + GlobalProgramversion + Format('  [ Compiled: %s ]', [cCompileDate]);
  lHeader.Caption := 'XAMPP Control Panel v' + GlobalProgramversion;

  CurrentUser := GetCurrentUserName;
  isAdmin := IsWindowsAdmin;
  if isAdmin then
  begin
//    if (OSVersionInfoEx.dwMajorVersion < 6) then
//    begin
//      AddLog(_('Unable to check for Admin privileges on Windows before Vista'), ltInfo);
//      AddLog(_('You will be asked to run as Administrator when performing actions'), ltInfo);
//    end
//    else
      AddLog(_('Running with Administrator rights - good!'));
  end
  else
  begin
    AddLog(_('You are not running with administrator rights! This will work for'), ltInfo);
    AddLog(_('most application stuff but whenever you do something with services'), ltInfo);
    AddLog(_('there will be a security dialogue or things will break! So think '), ltInfo);
    AddLog(_('about running this application with administrator rights!'), ltInfo);
  end;

  AddLog(Format(_('XAMPP Installation Directory: "%s"'), [BaseDir]));

  if LastDelimiter(' ', Trim(BaseDir)) <> 0 then
    AddLog(_('WARNING: Your install directory contains spaces.  This may break programs'), ltError);

  if (LastDelimiter('(', Trim(BaseDir)) <> 0)
  or (LastDelimiter(')', Trim(BaseDir)) <> 0)
  or (LastDelimiter('!', Trim(BaseDir)) <> 0)
  or (LastDelimiter('@', Trim(BaseDir)) <> 0)
  or (LastDelimiter('#', Trim(BaseDir)) <> 0)
  or (LastDelimiter('$', Trim(BaseDir)) <> 0)
  or (LastDelimiter('%', Trim(BaseDir)) <> 0)
  or (LastDelimiter('^', Trim(BaseDir)) <> 0)
  or (LastDelimiter('&', Trim(BaseDir)) <> 0)
  or (LastDelimiter('*', Trim(BaseDir)) <> 0)
  or (LastDelimiter('<', Trim(BaseDir)) <> 0)
  or (LastDelimiter('>', Trim(BaseDir)) <> 0)
  or (LastDelimiter(',', Trim(BaseDir)) <> 0)
  or (LastDelimiter('?', Trim(BaseDir)) <> 0)
  or (LastDelimiter('[', Trim(BaseDir)) <> 0)
  or (LastDelimiter(']', Trim(BaseDir)) <> 0)
  or (LastDelimiter('{', Trim(BaseDir)) <> 0)
  or (LastDelimiter('}', Trim(BaseDir)) <> 0)
  or (LastDelimiter('=', Trim(BaseDir)) <> 0)
  or (LastDelimiter('+', Trim(BaseDir)) <> 0)
  or (LastDelimiter('`', Trim(BaseDir)) <> 0)
  or (LastDelimiter('~', Trim(BaseDir)) <> 0)
  or (LastDelimiter('|', Trim(BaseDir)) <> 0) then
    AddLog(_('WARNING: Your install directory contains special characters.  This may break programs'), ltError);

  if BaseDir[length(BaseDir)] <> '\' then
    BaseDir := BaseDir + '\';

  NetStatTable.UpdateTable;
  Processes.Update;

  AddLog(_('Initializing Modules'));
  Apache := tApache.Create(bApacheService, pApacheStatus, lApachePIDs, lApachePorts, bApacheAction, bApacheAdmin);
  MySQL := tMySQL.Create(bMySQLService, pMySQLStatus, lMySQLPIDs, lMySQLPorts, bMySQLAction, bMySQLAdmin);
  FileZilla := tFileZilla.Create(bFileZillaService, pFileZillaStatus, lFileZillaPIDs, lFileZillaPorts, bFileZillaAction, bFileZillaAdmin);
  Mercury := tMercury.Create(bMercuryService, pMercuryStatus, lMercuryPIDs, lMercuryPorts, bMercuryAction, bMercuryAdmin);
  Tomcat := tTomcat.Create(bTomcatService, pTomcatStatus, lTomcatPIDs, lTomcatPorts, bTomcatAction, bTomcatAdmin);

  if Config.ASApache then
  begin
    Apache.AutoStart := True;
    AddLog(Format(_('Enabling autostart for module "%s"'), [Apache.ModuleName]));
  end;
  if Config.ASMySQL then
  begin
    MySQL.AutoStart := True;
    AddLog(Format(_('Enabling autostart for module "%s"'), [MySQL.ModuleName]));
  end;
  if Config.ASFileZilla then
  begin
    FileZilla.AutoStart := True;
    AddLog(Format(_('Enabling autostart for module "%s"'), [FileZilla.ModuleName]));
  end;
  if Config.ASMercury then
  begin
    Mercury.AutoStart := True;
    AddLog(Format(_('Enabling autostart for module "%s"'), [Mercury.ModuleName]));
  end;
  if Config.ASTomcat then
  begin
    Tomcat.AutoStart := True;
    AddLog(Format(_('Enabling autostart for module "%s"'), [Tomcat.ModuleName]));
  end;

  AddLog(_('Starting') + ' Check-Timer');
  //TimerUpdateStatus.Enabled := True;
  updateTimerStatus(True);
  AddLog(_('Control Panel Ready'));
  // UpdateStatusAll;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  AddLog(_('Deinitializing Modules'));
  Apache.Free;
  MySQL.Free;
  FileZilla.Free;
  Mercury.Free;
  AddLog(_('Deinitializing Control Panel'));
  Config.WindowSettings.Left := self.Left;
  Config.WindowSettings.Top := self.Top;
  Config.WindowSettings.Width := self.Width;
  Config.WindowSettings.Height := self.Height;
  SaveSettings;
  SaveLogFile;
end;

procedure TfMain.TimerUpdateStatusTimer(Sender: TObject);
begin
  UpdateStatusAll;
end;

procedure TfMain.TrayIcon1DblClick(Sender: TObject);
begin
  miShowHideClick(nil);
end;

function TfMain.TryGuessXamppVersion: string;
var
  ts: tStringList;
  s: string;
  p: integer;
begin
  result := '???';
  ts := tStringList.Create;
  try
    ts.LoadFromFile(BaseDir + '\readme_de.txt');
    if ts.count < 1 then
      exit;
    s := LowerCase(ts[0]);
    p := pos('version', s);
    if p = 0 then
      exit;
    delete(s, 1, p + 7);
    p := pos(' ', s);
    if p = 0 then
      exit;
    result := copy(s, 1, p - 1);
  except
  end;
  ts.Free;
end;

procedure DumpProcesses;
var
  ProcInfo: TProcInfo;
  p: integer;
  s: string;
begin
  for p := 0 to Processes.ProcessList.count - 1 do
  begin
    ProcInfo := Processes.ProcessList[p];
    s := Format('%d %s', [ProcInfo.PID, ProcInfo.ExePath]);
    fMain.reLog.Lines.Add(s)
  end;
end;

procedure TfMain.UpdateStatusAll;
begin
  Processes.Update;
  NetStatTable.UpdateTable;
  // DumpProcesses;

  // 1. Check Apache
  Apache.UpdateStatus;

  // 2. Check MySql
  MySQL.UpdateStatus;

  // 3. Check Filezilla
  FileZilla.UpdateStatus;

  // 4. Check Mercury
  Mercury.UpdateStatus;

  // 5. Check Mercury
  Tomcat.UpdateStatus;
end;

procedure TfMain.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
  WindowsShutdownInProgress := True;
    miTerminateClick(nil);
  inherited;
end;

end.
