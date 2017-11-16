program Project;

uses
  Forms,
  Main in 'Main.pas' {Window},
  Game in 'Game.pas',
  Computer in 'Computer.pas',
  Info in 'Info.pas' {WindowInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Schiffe Versenken (Ricardo Boss)';
  Application.CreateForm(TWindow, Window);
  Application.CreateForm(TWindowInfo, WindowInfo);
  Application.Run;
end.
