unit Computer;

interface

uses
  Game, Windows, UQueue;

type
  TPointObject = class(TObject)
    val: TPoint;
  end;

  TComputer = class
    { difficulty: 0 = easy; 1 = medium; 2 = hard }
    difficulty: Integer;
    strategy: TQueue;
    gapfill: boolean;
    lastAttack, lastPlan: TPoint;

    function attack: Integer;
    procedure placeShips;
    procedure setDifficulty(d: Integer);
    constructor Create(g: TGame);
  end;

var
  Game: TGame;

implementation

constructor TComputer.Create(g: TGame);
begin
  Game := g;
  strategy := TQueue.Create;
  gapfill := false;
  lastPlan = TPoint.Create(0, 0);
end;

procedure TComputer.placeShips;
var
  size, x, y, d: Integer;
begin
  for size := 1 to 4 do
  begin
    Randomize;
    repeat
      x := Random(Game.n) + 1;
      y := Random(Game.n) + 1;
      d := Random(4);
    until Game.computerBoard.addShip(x, y, size, d) = 0;
  end;
end;

procedure TComputer.setDifficulty(d: Integer);
begin
  difficulty := d;
end;

function TComputer.attack: Integer;
var
  r: Integer;
  po, newpo: TPointObject;
  p: TPoint;
  proceed, even: boolean;
begin                   
  r := 5; // default r is undefined
  po := TPointObject.Create;

  case difficulty of
    0: // easy
      begin
        // attack player at random positions until the computer hit a ship or water
        Randomize;
        repeat
          lastAttack.X := Random(Game.n) + 1;
          lastAttack.Y := Random(Game.n) + 1;
          r := Game.playerBoard.attack(lastAttack.X, lastAttack.Y);
        until (r = 0) or (r = 2);
      end;
    1: // middle
      begin
        Randomize;
        repeat

        until (r = 0) or (r = 2);
      end;
    2: // hard
      begin
        proceed := false; // repeat the logic until we are allowed to proceed
        repeat
          if strategy.isEmpty then
          begin
            even := (lastPlan.Y mod 2 = 0);

            if lastPlan.X = -1 then
            begin
              p.X := 1;
              p.Y := 1;
            end
            else
            begin // strategy is empty and we are not at the first attack
              if lastPlan.X + 2 < Game.n + 1 then
              begin
                p.X := lastPlan.X + 2;
                p.Y := lastPlan.Y;
              end
              else
              begin
                if lastPlan.Y + 1 < Game.n then
                begin
                  if even and not gapfill then
                    p.X := 1
                  else
                    p.X := 2;

                  p.Y := lastPlan.Y + 1;
                end
                else
                  gapfill := true;
              end;
            end;

            newpo := TPointObject.Create;
            newpo.val := p;

            strategy.enqueue(newpo);
          end
          else
          begin
            po := strategy.getFront as TPointObject;
            lastAttack := po.val;
            lastPlan := po.val;

            strategy.dequeue;

            r := Game.playerBoard.attack(po.val.X, po.val.Y);
          end;

          case r of
            0: // hit water
              begin
                proceed := true;
              end;
            2: // hit a ship
              begin
                // add points around this one to check for other ship parts
                if po.val.Y - 1 > 0 then
                begin
                  p.X := po.val.X;
                  p.Y := po.val.Y - 1;

                  newpo := TPointObject.Create;
                  newpo.val := p;

                  strategy.enqueue(newpo);
                end;

                if po.val.X - 1 > 0 then
                begin
                  p.X := po.val.X - 1;
                  p.Y := po.val.Y;

                  newpo := TPointObject.Create;
                  newpo.val := p;

                  strategy.enqueue(newpo);
                end;

                if po.val.Y + 1 < Game.n then
                begin
                  p.X := po.val.X;
                  p.Y := po.val.Y + 1;

                  newpo := TPointObject.Create;
                  newpo.val := p;

                  strategy.enqueue(newpo);
                end;

                if po.val.X + 1 < Game.n then
                begin
                  p.X := po.val.X + 1;
                  p.Y := po.val.Y;

                  newpo := TPointObject.Create;
                  newpo.val := p;

                  strategy.enqueue(newpo);
                end;

                proceed := true;
              end;
            4: // error: reset strategy
              begin
                strategy.clear;
                proceed := true;
              end;
          end;
        until proceed;
      end;
  end;

  Result := r;
end;

end.
