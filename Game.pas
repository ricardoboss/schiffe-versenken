unit Game;

interface

type
  TFieldRow = array of Integer;
  TField = array of TFieldRow;

  TBoard = class
    { field: (0: water, 1: missed, 2: ship, 3: hit (, 4: error)) }
    field: TField;
    n: Integer;

    function check(const x, y: Integer): Integer;
    function addShip(x, y, size, dir: Integer): Integer;
    function attack(const x, y: Integer): Integer;
    procedure reset;
    constructor Create(n: Integer);
  end;

  TGame = class
    playerBoard: TBoard;
    computerBoard: TBoard;
    { gameState: 0: placing ships, 1: player attack, 2: computer attack, 3: end }
    gameState: Integer;
    n: Integer;

    procedure reset;
    constructor Create(n: Integer);
  end;

implementation

function TBoard.check(const x, y: Integer): Integer;
var
   l, h: Integer;
begin
  Result := 4; // default result is 4

  l := low(field);
  h := high(field);

  if (x - 1 < l) or (x - 1 > h) then
    Exit;
  if (y - 1 < l) or (y - 1 > h) then
    Exit;

  Result := field[x - 1][y - 1];
end;

function TBoard.addShip(x, y, size, dir: Integer): Integer;
var
  posX, posY, sY, dY, sX, dX: Integer;
begin         
  Result := 1; // default result is error code

  if check(x, y) <> 0 then // check if the position is in bound and water
    Exit; // otherwise return error code 1

  case dir of
    1: // upwards
      begin
        sY := y - size + 1;
        dY := y;

        for posY := sY to dY do // loop through the affected positions
          if check(x, posY) <> 0 then // if there is a ship (or something else)
            Exit; // return error code 1

        for posY := sY to dY do // otherwise, place ships
          field[x - 1][posY - 1] := 2;

        Result := 0; // return 0
      end;
    2: // rightwards
      begin
        sX := x;
        dX := x + size - 1;

        for posX := sX to dX do
          if check(posX, y) <> 0 then
            Exit;

        for posX := sX to dX do
          field[posX - 1][y - 1] := 2;

        Result := 0;
      end;
    3: // downwards
      begin
        sY := y;
        dY := y + size - 1;

        for posY := sY to dY do
          if check(x, posY) <> 0 then
            Exit;

        for posY := sY to dY do
          field[x - 1][posY - 1] := 2;

        Result := 0;
      end;
    4: // leftwards
      begin
        sX := x - size + 1;
        dX := x;

        for posX := sX to dX do
          if check(posX, y) <> 0 then
            Exit;

        for posX := sX to dX do
          field[posX - 1][y - 1] := 2;

        Result := 0;
      end;
  end;
end;

function TBoard.attack(const x, y: Integer): Integer;
begin
  Result := Self.check(x, y);
  case Result of
    0: Self.field[x - 1][y - 1] := 1; // hit the water
    2: Self.field[x - 1][y - 1] := 3; // hit a ship     
    else Exit; // (1): already bombed (missed) or (3): already hit a ship at this point (or 4: error)
  end;
end;

constructor TBoard.Create(n: Integer);
begin
  Self.n := n;

  SetLength(field, n, n);

  Self.reset;
end;

procedure TBoard.reset;
var
  x, y: Integer;
begin
  for x := low(field) to high(field) do
    for y := low(field[x]) to high(field[x]) do
      field[x][y] := 0;
end;

constructor TGame.Create(n: Integer);
begin
  Self.gameState := 0;
  Self.n := n;
  Self.reset;
end;

procedure TGame.reset;
begin
  if not Assigned(playerBoard) then
    playerBoard := TBoard.Create(n);

  playerBoard.reset;

  if not Assigned(computerBoard) then
    computerBoard := TBoard.Create(n);

  computerBoard.reset;

  gameState := 0;
end;

end.
