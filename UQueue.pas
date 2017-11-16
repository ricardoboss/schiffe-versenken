unit UQueue;

interface

type
  TNode = class
  private
    nextNode: TNode;
    content: TObject;
  public
    constructor create(pObject: TObject);
    procedure setNext(pNode: TNode);
    procedure rippleDestroy;
    function getNext: TNode;
    function getContent: TObject;
  end;

  TQueue = class
  private
    head: TNode;
    tail: TNode;
  public
    constructor create;
    procedure clear;
    procedure enqueue(pObject: TObject);
    procedure dequeue;
    function isEmpty: boolean;
    function getFront: TObject;
    function getBack: TObject;
    destructor destroy; override;
  end;

implementation

constructor TNode.create(pObject: TObject);
begin
  self.content := pObject;
end;

procedure TNode.setNext(pNode: TNode);
begin
  self.nextNode := pNode;
end;

procedure TNode.rippleDestroy;
begin
  if self.getNext <> nil then
    self.getNext.rippleDestroy;
    
  self.Destroy;
end;

function TNode.getNext: TNode;
begin
  Result := self.nextNode;
end;

function TNode.getContent: TObject;
begin
  if not Assigned(self.content) then
    Result := nil
  else
    Result := self.content;
end;

constructor TQueue.create;
begin
  self.clear;
end;

procedure TQueue.clear;
begin
  if head <> nil then
    head.rippleDestroy;

  head := nil;
  tail := nil;
end;

procedure TQueue.enqueue(pObject: TObject);
var
  newNode: TNode;
begin
  if pObject <> nil then
  begin
    newNode := TNode.create(pObject);
    if self.isEmpty then
    begin
      self.head := newNode;
      self.tail := newNode;
    end
    else
    begin
      self.tail.setNext(newNode);
      self.tail := newNode;
    end;
  end;
end;

procedure TQueue.dequeue;
var
  oHead: TNode;
begin
  if self.head = self.tail then
  begin
    self.head.Destroy;
    self.head := nil;
    self.tail := nil;
  end
  else
  begin
    oHead := self.head;
    self.head := oHead.nextNode;
    oHead.Destroy;
  end;
end;                 

function TQueue.isEmpty: boolean;
begin
  Result := (head = nil) and (tail = nil);
end;

function TQueue.getFront: TObject;
begin
  if self.isEmpty then
    Result := nil
  else
    Result := self.head.getContent;
end;

function TQueue.getBack: TObject;
begin
  if self.isEmpty then
    Result := nil
  else
    Result := self.tail.getContent;
end;

destructor TQueue.destroy;
begin
  self.clear;
  inherited Destroy;
end;

end.
