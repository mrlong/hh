unit Mainfrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cefvcl,
  ceflib,
  Easysize,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Imaging.jpeg;

type

  TMainDlg = class(TForm)
    chrm1: TChromium;
    actlst1: TActionList;
    actdevetool: TAction;
    img1: TImage;
    tmr1: TTimer;
    procedure chrm1BeforePopup(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; const targetUrl, targetFrameName: ustring;
      targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
      var popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
      var client: ICefClient; var settings: TCefBrowserSettings;
      var noJavascriptAccess: Boolean; out Result: Boolean);
    procedure FormShow(Sender: TObject);
    procedure actdevetoolExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
    fFormResizer  : TFormResizer;

  protected
    procedure WndProc(var Message: TMessage); override;
  public
    { Public declarations }

  end;

var
  MainDlg: TMainDlg;

implementation

{$R *.dfm}

procedure TMainDlg.actdevetoolExecute(Sender: TObject);
begin
  //
  chrm1.ShowDevTools();
end;

procedure TMainDlg.chrm1BeforePopup(Sender: TObject; const browser: ICefBrowser;
  const frame: ICefFrame; const targetUrl, targetFrameName: ustring;
  targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
  var popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
  var client: ICefClient; var settings: TCefBrowserSettings;
  var noJavascriptAccess: Boolean; out Result: Boolean);
begin
  Result := True;
end;

procedure TMainDlg.FormCreate(Sender: TObject);
begin
  fFormResizer  := TFormResizer.Create(Self);
  fFormResizer.InitializeForm;
end;

procedure TMainDlg.FormDestroy(Sender: TObject);
begin
  fFormResizer.Free;
end;

procedure TMainDlg.FormResize(Sender: TObject);
begin
  fFormResizer.ResizeAll;
end;

procedure TMainDlg.FormShow(Sender: TObject);
begin

  Top := Screen.WorkAreaHeight - Height;
  Left := Screen.WorkAreaWidth - Width;

end;

procedure TMainDlg.tmr1Timer(Sender: TObject);
begin
  tmr1.Enabled := False;
  chrm1.Visible := True;
end;

procedure TMainDlg.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_MOVE then
  begin
    if (Chrm1.Browser <> nil) then
      Chrm1.Browser.Host.NotifyMoveOrResizeStarted;
  end;
  inherited WndProc(Message);
end;

end.
