program Freefox;

uses
  Forms,
  Fenetre_Optimisation in 'Fenetre_Optimisation.pas' {Form1};

{$R Freefox.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.ShowMainForm:=False;
  Application.Run;
end.
