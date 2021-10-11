unit Fenetre_Optimisation;

interface

uses
  Windows, Classes, Graphics, Controls, Forms, ExtCtrls, jpeg,
  AppEvnts, Menus, StdCtrls, XPMan;

type
  TForm1 = class(TForm)
    TimerOptimisation: TTimer;
    ApplicationEvents1: TApplicationEvents;
    PopUp_Activation: TPopupMenu;
    ActiverFreefox1: TMenuItem;
    DsactiverFreefox1: TMenuItem;
    N1: TMenuItem;
    Quitter1: TMenuItem;
    GroupBox1: TGroupBox;
    XPManifest1: TXPManifest;
    Image_Status: TImage;
    Pnl_StatusOptimisation: TPanel;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Pnl_ProcessusActif: TPanel;
    Pnl_ConsoMemoire: TPanel;
    Pnl_EconomieMemoire: TPanel;
    procedure TimerOptimisationTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActiverFreefox1Click(Sender: TObject);
    procedure DsactiverFreefox1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Image_StatusClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  OptimisationEnCours:boolean;

implementation

{$R *.dfm}

uses API_LiberationProcessus;

procedure TForm1.TimerOptimisationTimer(Sender: TObject);
begin
  LibererMemoireProcessus('firefox.exe');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OptimisationEnCours:=True;
end;

procedure TForm1.ActiverFreefox1Click(Sender: TObject);
begin
  Image_StatusClick(nil);
end;

procedure TForm1.DsactiverFreefox1Click(Sender: TObject);
begin
  Image_StatusClick(nil);
end;

procedure TForm1.Quitter1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Image_StatusClick(Sender: TObject);
begin
  if OptimisationEnCours then
  begin
    OptimisationEnCours:=False;
    Image_Status.Picture.Icon.Handle:=LoadIcon(hInstance,'OPTIMISATION_ARRETE');
    Pnl_StatusOptimisation.Caption:='Stopped';
    PopUp_Activation.Items[0].Enabled:=True;
    PopUp_Activation.Items[1].Enabled:=False;
  end
  else
  begin
    OptimisationEnCours:=True;
    Image_Status.Picture.Icon.Handle:=LoadIcon(hInstance,'OPTIMISATION_EN_COURS');
    Pnl_StatusOptimisation.Caption:='Optimized';
    PopUp_Activation.Items[0].Enabled:=False;
    PopUp_Activation.Items[1].Enabled:=True;
  end;
end;

end.
