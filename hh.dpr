program hh;

uses
  Vcl.Forms,
  ceflib,
  Mainfrm in 'Mainfrm.pas' {MainDlg},
  Easysize in 'Easysize.pas';

{$R *.res}

procedure CustomCommandLine (const processType: ustring; const commandLine: ICefCommandLine);
begin
  // let's use our gpu instead, it will be better ;)
  commandLine.AppendSwitch('--enable-gpu-plugin');
  commandLine.AppendSwitch('--enable-accelerated-plugins');
  //another ones that might be great to use
  //commandLine.AppendSwitch('');
  //commandLine.AppendSwitch('--enable-accelerated-drawing');
  commandLine.AppendSwitch('--enable-system-flash'); // since it doesn't need any value, that's enough, otherwise use AppendSwitchWithValue(switch, value);
end;


begin

  CefCache := 'cache';
  CefSingleProcess := false;
  CefLocale := 'zh-CN';
  CefLogSeverity := LOGSEVERITY_DISABLE;
  CefPackLoadingDisabled := False;

  CefOnBeforeCommandLineProcessing := CustomCommandLine;
  if not CefLoadLibDefault then
    Exit;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainDlg, MainDlg);
  Application.Run;
end.
