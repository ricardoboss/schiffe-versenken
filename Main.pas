unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Game, Computer, ComCtrls, ExtCtrls, StdCtrls, StrUtils, Info,
  MMSystem, MPlayer;

type
  TPanelClickEvent = procedure(Sender: TObject) of object;

  TFieldCell = class(TPanel)
  public
    x: Integer;
    y: Integer;
  end;

  TWindow = class(TForm)
    Menu: TMainMenu;
    ComputerBoard: TGroupBox;
    PlayerBoard: TGroupBox;
    MenuGame: TMenuItem;
    MenuNewGame: TMenuItem;
    MenuClose: TMenuItem;
    MessageBox: TGroupBox;
    Messages: TLabel;
    MenuShipDirection: TMenuItem;
    ShipDirectionUpwards: TMenuItem;
    ShipDirectionRightwards: TMenuItem;
    ShipDirectionDownwards: TMenuItem;
    ShipDirectionLeftwards: TMenuItem;
    MenuDifficulty: TMenuItem;
    DifficultyHard: TMenuItem;
    DifficultyEasy: TMenuItem;
    MenuInfo: TMenuItem;
    MenuSettings: TMenuItem;
    function DirToString(dir: Integer): string;
    procedure FormCreate(Sender: TObject);
    procedure MenuNewGameClick(Sender: TObject);
    procedure MenuCloseClick(Sender: TObject);
    procedure PanelClick(Sender: TObject);
    procedure ComputerPanelClick(c: TFieldCell; x, y, r: Integer);
    procedure PlayerPanelClick(c: TFieldCell; x, y, r: Integer);
    procedure ComputerAttack(x, y: Integer);
    procedure CheckWin;
    procedure ShowMessage(s: string);
    procedure UpdateBoard;
    procedure ShipDirectionUpwardsClick(Sender: TObject);
    procedure ShipDirectionRightwardsClick(Sender: TObject);
    procedure ShipDirectionDownwardsClick(Sender: TObject);
    procedure ShipDirectionLeftwardsClick(Sender: TObject);
    procedure DifficultyHardClick(Sender: TObject);
    procedure DifficultyEasyClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuInfoClick(Sender: TObject);
  end;

const
  n = 10; // Must not be greater than 26 (alphabet)
  btnWidth = 20;

var
  Window: TWindow;
  InfoWindow: TWindowInfo;
  Game: TGame;
  Computer: TComputer;
  ComputerField,
  PlayerField: array[1..n, 1..n] of TFieldCell;
  waterClr,
  missedClr,
  shipClr,
  hitClr: TColor;
  NextShipSize,
  NextShipDirection,
  PlayerHits,
  ComputerHits: Integer;
  PanelClickEvent: TPanelClickEvent;

implementation

{$R *.dfm}

function TWindow.DirToString(dir: Integer): string;
begin
  case dir of
    1: Result := 'Hoch';
    2: Result := 'Rechts';
    3: Result := 'Runter';
    4: Result := 'Links';
    else Result := 'Unbekannt';
  end;
end;

procedure TWindow.FormCreate(Sender: TObject);
var
  x, y: Integer;
  c: TFieldCell;
begin
  waterClr := StringToColor('$ffcc99');
  missedClr := StringToColor('$cc8855');
  shipClr := StringToColor('$888888');
  hitClr := StringToColor('$0000ff');
  PanelClickEvent := Window.PanelClick;

  // adjust form and groupbox height and width
  Window.ClientWidth := n * btnWidth + 40;
  Window.ClientHeight := n * btnWidth * 2 + 150;

  ComputerBoard.Width := Window.ClientWidth;
  ComputerBoard.Height := n * btnWidth + 50;

  PlayerBoard.Width := Window.ClientWidth;
  PlayerBoard.Height := ComputerBoard.Height;
  PlayerBoard.Top := ComputerBoard.Height + 50;

  MessageBox.Width := Window.ClientWidth;
  MessageBox.Top := ComputerBoard.Height + 4;

  // build computer board
  for y := 1 to n do
  begin
    c := TFieldCell.Create(ComputerBoard);
    c.Parent := ComputerBoard;
    c.Left := (y - 1) * btnWidth + 30;
    c.Top := 20;
    c.Caption := IntToStr(y);
    c.Name := 'ComputerBoard' + IntToStr(y);
    c.Width := btnWidth;
    c.Height := 20;
  end;

  for x := 1 to n do
  begin
    c := TFieldCell.Create(ComputerBoard);
    c.Parent := ComputerBoard;
    c.Left := 10;
    c.Top := (x - 1) * btnWidth + 40;
    c.Caption := chr(Ord('A') - 1 + x);
    c.Name := 'ComputerBoard' + chr(Ord('A') - 1 + x);
    c.Width := 20;
    c.Height := btnWidth;
  end;

  for x := 1 to n do
    for y := 1 to n do
    begin
      c := TFieldCell.Create(ComputerBoard);
      c.Parent := ComputerBoard;
      c.Left := (x - 1) * btnWidth + 30;
      c.Top := (y - 1) * btnWidth + 40;
      c.x := x;
      c.y := y;
      c.Caption := ' ';
      c.Name := 'ComputerBoard' + chr(Ord('A') - 1 + y) + IntToStr(x);
      c.Color := waterClr;
      c.Width := btnWidth;
      c.Height := btnWidth;
      c.OnClick := PanelClickEvent;
      ComputerField[x, y] := c;
    end;

  // build player board
  for y := 1 to n do
  begin
    c := TFieldCell.Create(PlayerBoard);
    c.Parent := PlayerBoard;
    c.Left := (y - 1) * btnWidth + 30;
    c.Top := 20;
    c.Caption := IntToStr(y);
    c.Name := 'PlayerBoard' + IntToStr(y);
    c.Width := btnWidth;
    c.Height := 20;
  end;

  for x := 1 to n do
  begin
    c := TFieldCell.Create(PlayerBoard);
    c.Parent := PlayerBoard;
    c.Left := 10;
    c.Top := (x - 1) * btnWidth + 40;
    c.Caption := chr(Ord('A') - 1 + x);
    c.Name := 'PlayerBoard' + chr(Ord('A') - 1 + x);
    c.Width := 20;
    c.Height := btnWidth;
  end;

  for x := 1 to n do
    for y := 1 to n do
    begin
      c := TFieldCell.Create(PlayerBoard);
      c.Parent := PlayerBoard;
      c.Left := (x - 1) * btnWidth + 30;
      c.Top := (y - 1) * btnWidth + 40;
      c.x := x;
      c.y := y;
      c.Caption := ' ';
      c.Name := 'PlayerBoard' + chr(Ord('A') - 1 + y) + IntToStr(x);
      c.Color := waterClr;
      c.Width := btnWidth;
      c.Height := btnWidth;
      c.OnClick := PanelClickEvent;
      PlayerField[x, y] := c;
    end;

  Game := TGame.Create(n);

  Computer := TComputer.Create(Game);
  Computer.placeShips;

  NextShipDirection := 1; // default ship direction: up
  Computer.setDifficulty(0); // default computer difficulty is 0 (easy)
  MenuSettings.Enabled := true;

  NextShipSize := 4; // start at size 4 ships
  ShowMessage('Verbleibende Schiffe: 4 (hoch)');

  PlayerHits := 0;
  ComputerHits := 0;

  UpdateBoard;

  // Create Info window
  InfoWindow := TWindowInfo.Create(self);
end;

procedure TWindow.MenuNewGameClick(Sender: TObject);
begin
  Game.reset;
  Computer.placeShips;

  NextShipDirection := 1;
  Computer.setDifficulty(0);
  MenuSettings.Enabled := true;

  NextShipSize := 4;
  ShowMessage('Verbleibende Schiffe: 4 (hoch)');

  PlayerHits := 0;
  ComputerHits := 0;

  UpdateBoard;
end;

procedure TWindow.PanelClick(Sender: TObject);
var
  c: TFieldCell;
  r: Integer;
begin
  if Game.gameState = 3 then // if the game has ended
    Exit;

  c := Sender as TFieldCell; // get the panel, that called this procedure

  if AnsiStartsStr('ComputerBoard', c.Name) then // check if the computer board was clicked or the player board
  begin
    r := Game.computerBoard.check(c.x, c.y); // check the position
    ComputerPanelClick(c, c.x, c.y, r); // execute the computer board logic
  end
  else
  begin
    r := Game.playerBoard.check(c.y, c.x);
    PlayerPanelClick(c, c.x, c.y, r);
  end;

  UpdateBoard; // update board after every turn
end;

procedure TWindow.ComputerPanelClick(c: TFieldCell; x, y, r: Integer);
begin
  case Game.gameState of
    0: ShowMessage('Bitte setzen Sie zuerst ihre Schiffe!');
    1:
      begin
        r := Game.computerBoard.attack(x, y);
        case r of
          0:
            begin
              c.Color := missedClr;
              ShowMessage('Platsch auf ' + chr(Ord('A') - 1 + y) + IntToStr(x) + '! (Computer ist dran; klicken)');
              inc(Game.gameState);
            end;
          2:
            begin
              c.Color := hitClr;
              ShowMessage('Treffer auf ' + chr(Ord('A') - 1 + y) + IntToStr(x) + '! (Computer ist dran; klicken)');
              inc(Game.gameState);
              inc(PlayerHits);
              CheckWin;
            end;
        else
          ShowMessage('Sie können hier nicht hinschießen!');
        end;
      end;
    2: ComputerAttack(x, y);
    3: ShowMessage('Bitte neues Spiel starten!');
  end;
end;

procedure TWindow.PlayerPanelClick(c: TFieldCell; x, y, r: Integer);
var
  a: Integer;
begin
  case Game.gameState of
    0: // ship placement
      if r = 0 then // if the field is water...
      begin
        a := Game.playerBoard.addShip(x, y, NextShipSize, NextShipDirection); // get result when trying to place a ship at that panel
        case a of
          0: // ship placed
            begin
              dec(NextShipSize); // decrease ship size
              if NextShipSize > 0 then // if there are ships to place, continue
                ShowMessage('Verbleibende Schiffe: ' + IntToStr(NextShipSize) + ' (' + DirToString(NextShipDirection) + ')')
              else
              begin
                MenuSettings.Enabled := false;

                inc(Game.gameState); // else switch to first attack
                ShowMessage('Sie haben den ersten Zug!');
              end;
            end;
        else // ship not placed
          begin
            ShowMessage('Sie können hier kein Schiff platzieren!');
          end;
        end;
      end
      else // clicked field is not water
        ShowMessage('Sie können hier kein Schiff platzieren!');
    1: // player attacks computer
      ShowMessage('Sie können sich nicht selbst angreifen!');
    2: // computer attacks player
      ComputerAttack(x, y);
    3: // game ended
      ShowMessage('Bitte neues Spiel starten!');
  end;
end;

procedure TWindow.ComputerAttack(x, y: Integer);
var
  a: Integer;
begin
  repeat
    a := Computer.attack;
    case a of
      0: ShowMessage('Platsch auf ' + chr(Ord('A') - 1 + Computer.lastAttack.Y) + IntToStr(Computer.lastAttack.X) + '! (Sie sind dran)');
      2:
        begin
          ShowMessage('Treffer auf ' + chr(Ord('A') - 1 + Computer.lastAttack.Y) + IntToStr(Computer.lastAttack.X) + '! (Sie sind dran)');
          inc(ComputerHits);
          CheckWin;
        end;
    else
      ShowMessage('Computer zieht...');
    end;
  until (a = 0) or (a = 2);
  dec(Game.gameState);
end;

procedure TWindow.CheckWin;
begin
  if PlayerHits = 10 then
  begin
    Game.gameState := 3;
    ShowMessage('Sie gewinnen! Punktestand: ' + IntToStr(ComputerHits) + ':' + IntToStr(PlayerHits));
  end
  else if ComputerHits = 10 then
  begin
    Game.gameState := 3;
    ShowMessage('Computer gewinnt! Punktestand: ' + IntToStr(ComputerHits) + ':' + IntToStr(PlayerHits));
  end;
end;

procedure TWindow.ShowMessage(s: string);
begin
  Messages.Caption := s;
end;

procedure TWindow.UpdateBoard;
var
  x, y: Integer;
begin
  for x := 1 to n do
    for y := 1 to n do
    begin
      case Game.playerBoard.check(x, y) of
        0: PlayerField[x, y].Color := waterClr;
        1: PlayerField[x, y].Color := missedClr;
        2: PlayerField[x, y].Color := shipClr;
        3: PlayerField[x, y].Color := hitClr;
      end;

      case Game.computerBoard.check(x, y) of
        0, 2: ComputerField[x, y].Color := waterClr; // don't show computer's ships
        //2: ComputerField[x, y].Color := shipClr; // for debugging: comment ,2 above and uncomment this line
        1: ComputerField[x, y].Color := missedClr;
        3: ComputerField[x, y].Color := hitClr;
      end;
    end;
end;

procedure TWindow.MenuCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TWindow.ShipDirectionUpwardsClick(Sender: TObject);
begin
  NextShipDirection := 1;
  ShowMessage('Verbleibende Schiffe: ' + IntToStr(NextShipSize) + ' (' + DirToString(NextShipDirection) + ')');
end;

procedure TWindow.ShipDirectionRightwardsClick(Sender: TObject);
begin
  NextShipDirection := 2;
  ShowMessage('Verbleibende Schiffe: ' + IntToStr(NextShipSize) + ' (' + DirToString(NextShipDirection) + ')');
end;

procedure TWindow.ShipDirectionDownwardsClick(Sender: TObject);
begin
  NextShipDirection := 3;
  ShowMessage('Verbleibende Schiffe: ' + IntToStr(NextShipSize) + ' (' + DirToString(NextShipDirection) + ')');
end;

procedure TWindow.ShipDirectionLeftwardsClick(Sender: TObject);
begin
  NextShipDirection := 4;
  ShowMessage('Verbleibende Schiffe: ' + IntToStr(NextShipSize) + ' (' + DirToString(NextShipDirection) + ')');
end;

procedure TWindow.DifficultyEasyClick(Sender: TObject);
begin
  Computer.setDifficulty(0);
  ShowMessage('Computer spielt nun leicht.');
end;

procedure TWindow.DifficultyHardClick(Sender: TObject);
begin
  Computer.setDifficulty(1);
  ShowMessage('Computer spielt nun schwer.');
end;

procedure TWindow.FormDestroy(Sender: TObject);
begin
  if InfoWindow.Showing then
    InfoWindow.Close;

  InfoWindow.Destroy;
end;

procedure TWindow.MenuInfoClick(Sender: TObject);
begin
  if not InfoWindow.Showing then
    InfoWindow.Show;
end;

end.
