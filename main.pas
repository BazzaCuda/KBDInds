unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
  TMainForm = class(TForm)
    TrayIcon: TTrayIcon;
    ImageList: TImageList;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    procedure LoadIcon(aKBDState: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

function GetKBDState: string;
begin
  result := '00';
  if GetKeyState(VK_NUMLOCK) = 1 then result[1] := '1';
  if GetKeyState(VK_CAPITAL) = 1 then result[2] := '1';
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  LoadIcon(GetKBDState);
end;

procedure TMainForm.LoadIcon(aKBDState: string);
const
  states: array[0..3] of string = ('00', '01', '10', '11');
var
  i: integer;
begin
  for i := Low(states) to High(states) do
    if states[i] = aKBDState then begin
      TrayIcon.IconIndex := i;
      BREAK;
    end;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  LoadIcon(GetKBDState);
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject);
begin
  Close;
end;

end.
