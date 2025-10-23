unit bChain;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, correo;

type
  TBlock = class
  public
    Index: Integer;
    Timestamp: string;
    Correo: TCorreo;
    PrevHash: string;
    Hash: string;
    constructor Create(AIndex: Integer; ACorreo: TCorreo; APrevHash: string);
    function CalculateHash: string;
  end;

  TBlockchain = class
  private
    FChain: TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddBlock(ACorreo: TCorreo);
    function GetBlock(Index: Integer): TBlock;
    function Count: Integer;
    function IsValid: Boolean;
    procedure GenerarDOT(const RutaArchivo: string);
  end;

implementation

{ TBlock }

constructor TBlock.Create(AIndex: Integer; ACorreo: TCorreo; APrevHash: string);
begin
  Index := AIndex;
  Correo := ACorreo;
  PrevHash := APrevHash;
  Timestamp := FormatDateTime('dd-mm-yy::hh:nn:ss', Now);
  Hash := CalculateHash;
end;

function TBlock.CalculateHash: string;
var
  Combined: string;
  I, Sum: LongInt;
begin
  Combined := IntToStr(Index) + Timestamp + Correo.ToSingleLine + PrevHash;
  Sum := 0;
  for I := 1 to Length(Combined) do
    Sum := Sum + Ord(Combined[I]);
  Result := IntToHex(Sum, 8);
end;

{ TBlockchain }

constructor TBlockchain.Create;
var
  GenesisCorreo: TCorreo;
  GenesisBlock: TBlock;
begin
  FChain := TList.Create;

  GenesisCorreo := TCorreo.Create(0, 'genesis', 'network', '', FormatDateTime('dd-mm-yy::hh:nn:ss', Now), 'Bloque Génesis', 'Mensaje Inicial', '');
  GenesisBlock := TBlock.Create(0, GenesisCorreo, '0000');
  FChain.Add(GenesisBlock);
end;

destructor TBlockchain.Destroy;
var
  I: Integer;
begin
  for I := 0 to FChain.Count - 1 do
    TObject(FChain[I]).Free;
  FChain.Free;
  inherited Destroy;
end;

procedure TBlockchain.AddBlock(ACorreo: TCorreo);
var
  PrevBlock, NewBlock: TBlock;
begin
  PrevBlock := TBlock(FChain.Last);
  NewBlock := TBlock.Create(PrevBlock.Index + 1, ACorreo, PrevBlock.Hash);
  FChain.Add(NewBlock);
end;

function TBlockchain.GetBlock(Index: Integer): TBlock;
begin
  Result := TBlock(FChain[Index]);
end;

function TBlockchain.Count: Integer;
begin
  Result := FChain.Count;
end;

function TBlockchain.IsValid: Boolean;
var
  I: Integer;
  Curr, Prev: TBlock;
begin
  Result := True;
  for I := 1 to FChain.Count - 1 do
  begin
    Curr := TBlock(FChain[I]);
    Prev := TBlock(FChain[I-1]);

    if Curr.Hash <> Curr.CalculateHash then
    begin
      Result := False;
      Exit;
    end;

    if Curr.PrevHash <> Prev.Hash then
    begin
      Result := False;
      Exit;
    end;
  end;
end;


procedure TBlockchain.GenerarDOT(const RutaArchivo: string);
var
  SL: TStringList;
  I: Integer;
  B: TBlock;
  NodeLabel, SafeMsg, NodeName: string;
begin
  SL := TStringList.Create;
  try
    SL.Add('digraph Blockchain {');
    SL.Add('  rankdir=LR;');
    SL.Add('  node [shape=box, fontsize=10];');

    for I := 0 to FChain.Count - 1 do
    begin
      B := TBlock(FChain[I]);
      SafeMsg := StringReplace(B.Correo.GetMensaje, '"', '\"', [rfReplaceAll]);
      SafeMsg := StringReplace(SafeMsg, #13#10, ' ', [rfReplaceAll]);
      SafeMsg := StringReplace(SafeMsg, #10, ' ', [rfReplaceAll]);
      SafeMsg := StringReplace(SafeMsg, #13, ' ', [rfReplaceAll]);

      NodeName := Format('nodo%d', [I]);
      NodeLabel := Format('%s [label="#%d\n%s -> %s\n%s\nPrevHash: %s\nHash: %s"];',
        [NodeName, B.Index, B.Correo.GetRemitente, B.Correo.GetDestinatario, SafeMsg, B.PrevHash, B.Hash]);
      SL.Add('  ' + NodeLabel);
    end;

    for I := 0 to FChain.Count - 2 do
      SL.Add(Format('  nodo%d -> nodo%d;', [I, I + 1]));

    SL.Add('}');
    SL.SaveToFile(AFilename);
  finally
    SL.Free;
  end;
end;

end.
