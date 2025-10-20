unit merkletree;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, sha1, correo;

type

  //Nodo
  TMerkleNode = class
    public
      Hash: string;
      Left, Right: TMerkleNode;
      Correo: TCorreo;

      constructor CreateLeaf(ACorreo: TCorreo);
      constructor CreateInternal(ALeft, ARight: TMerkleNode);
    private
      function CalculateHash(const LeftHash, RightHash: string): string;
  end;

  //Arbol
  TMerkleTree = class
  private
    FLeaves: Tlist;
    FRoot: TMerkleNode;
    procedure BuildTree;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AgregarCorreo(ACorreo: TCorreo);
    function GetRootHash: string;
    procedure GenerarDot(const Ruta: string);
  end;

implementation

{ TMerkleNode }

constructor TMerkleNode.CreateLeaf(ACorreo: TCorreo);
begin
  Self.Correo := ACorreo;
  Self.Left := nil;
  Self.Right := nil;
  Self.Hash := SHA1Print(SHA1String(ACorreo.GetMensaje));
end;

constructor TMerkleNode.CreateInternal(ALeft, ARight: TMerkleNode);
begin
  Self.Left := ALeft;
  Self.Right := ARight;
  Self.Correo := nil;
  Self.Hash := CalculateHash(ALeft.Hash, ARight.Hash);
end;

function TMerkleNode.CalculateHash(const LeftHash, RightHash: string): string;
begin
  Result := SHA1Print(SHA1String(LeftHash + RightHash));
end;

{ TMerkleNode }

constructor TMerkleTree.Create;
begin
  FLeaves := TList.Create;
  FRoot := nil;
end;

destructor TMerkleTree.Destroy;
var
  i: Integer;
begin
  for i := 0 to FLeaves.Count - 1 do
    TObject(FLeaves[i]).Free;
  FLeaves.Free;
  inherited Destroy;
end;

procedure TMerkleTree.AgregarCorreo(ACorreo: TCorreo);
var
  nodo: TMerkleNode;
begin
  nodo := TMerkleNode.CreateLeaf(ACorreo);
  FLeaves.Add(nodo);
  BuildTree;
end;

procedure TMerkleTree.BuildTree;
var
  nodos, siguienteNivel: TList;
  i: Integer;
  leftNode, rightNode, parent: TMerkleNode;
begin
  if FLeaves.Count = 0 then Exit;

  nodos := TList.Create;
  try
    nodos.Assign(FLeaves);

    while nodos.Count > 1 do
    begin
      siguienteNivel := TList.Create;
      try
        i := 0;

        while i < nodos.Count do
        begin
          leftNode := TMerkleNode(nodos[i]);

          if i + 1 < nodos.Count then
            rightNode := TMerkleNode(nodos[i + 1])
          else
            rightNode := leftNode;

          parent := TMerkleNode.CreateInternal(leftNode, rightNode);
          siguienteNivel.Add(parent);

          Inc(i, 2);
        end;

        nodos.Free;
        nodos := siguienteNivel;
        siguienteNivel := TList.Create;
      except
        siguienteNivel.Free;
        raise;
      end;
    end;

    FRoot := TMerkleNode(nodos[0]);
  finally
    nodos.Free;
  end;
end;

function TMerkleTree.GetRootHash: string;
begin
  if FRoot <> nil then
     Result := FRoot.Hash
  else
     Result := '';
end;

procedure TMerkleTree.GenerarDot(const Ruta: string);
var
  SL: TStringList;
  contador: Integer;
  nodeMap: TStringList;

  procedure RecorrerNodo(Node: TMerkleNode; var IdCounter: Integer; var Output: TStringList; var NodeIds: TStringList);
  var
    NodeId, LeftId, RightId: Integer;
    LabelText: String;
  begin
    if Node = nil then Exit;

    NodeId := IdCounter;
    NodeIds.Add(IntToStr(PtrInt(Node)) + '=' + IntToStr(NodeId));
    Inc(IdCounter);

    if Assigned(Node.Correo) then
      LabelText := Format('"Correo #%d\nAsunto: %s\nFecha: %s\nHash: %s..."',
        [Node.Correo.GetId, Node.Correo.GetAsunto, Node.Correo.GetFecha, Copy(Node.Hash, 1, 8)])
    else
      LabelText := Format('"Hash: %s..."', [Copy(Node.Hash, 1, 8)]);

    Output.Add(Format('  node%d [label=%s, shape=box];', [NodeId, LabelText]));

    // Conexión izquierda
    if Assigned(Node.Left) then
    begin
      LeftId := IdCounter;
      RecorrerNodo(Node.Left, IdCounter, Output, NodeIds);
      Output.Add(Format('  node%d -> node%d;', [NodeId, LeftId]));
    end;

    // Conexión derecha
    if Assigned(Node.Right) then
    begin
      RightId := IdCounter;
      RecorrerNodo(Node.Right, IdCounter, Output, NodeIds);
      Output.Add(Format('  node%d -> node%d;', [NodeId, RightId]));
    end;
  end;

begin
  SL := TStringList.Create;
  try
    SL.Add('digraph MerkleTree {');
    SL.Add('  node [shape=record, style=filled, fillcolor="#E0F7FA"];');
    SL.Add('  graph [rankdir=TB];');
    SL.Add('  label="Árbol de Merkle - Correos Favoritos";');
    SL.Add('  labelloc="t";');
    SL.Add('');

    if FRoot = nil then
      SL.Add('  vacío [label="Árbol vacío"];')
    else
    begin
      contador := 0;
      nodeMap := TStringList.Create;
      try
        RecorrerNodo(FRoot, contador, SL, nodeMap);
      finally
        nodeMap.Free;
      end;
    end;

    SL.Add('}');
    SL.SaveToFile(Ruta);
  finally
    SL.Free;
  end;
end;

end.

