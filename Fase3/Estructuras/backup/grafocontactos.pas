unit GrafoContactos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  { Clase Nodo de contacto }
  TContactoNodo = class
  private
    FId: Integer;
    FUsuario: string;
    FConexiones: TList;
  public
    constructor Create(AId: Integer; AUsuario: string);
    destructor Destroy; override;

    procedure AgregarConexion(Nodo: TContactoNodo);
    function TieneConexion(Nodo: TContactoNodo): Boolean;

    function GetId: Integer;
    function GetUsuario: string;
    function GetConexiones: TList;
  end;

  { Clase Grafo de contactos }
  TGrafoContactos = class
  private
    FNodos: TList;
    function GetNodoPorId(AId: Integer): TContactoNodo;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AgregarNodo(AId: Integer; AUsuario: string);
    procedure ConectarNodos(Id1, Id2: Integer);
    procedure GenerarDOT(const rutaArchivo: string);
  end;

implementation

{ TContactoNodo }

constructor TContactoNodo.Create(AId: Integer; AUsuario: string);
begin
  FId := AId;
  FUsuario := AUsuario;
  FConexiones := TList.Create;
end;

destructor TContactoNodo.Destroy;
begin
  FConexiones.Free;
  inherited Destroy;
end;

procedure TContactoNodo.AgregarConexion(Nodo: TContactoNodo);
begin
  if (Nodo <> nil) and (not TieneConexion(Nodo)) then
    FConexiones.Add(Nodo);
end;

function TContactoNodo.TieneConexion(Nodo: TContactoNodo): Boolean;
begin
  Result := FConexiones.IndexOf(Nodo) <> -1;
end;

function TContactoNodo.GetId: Integer;
begin
  Result := FId;
end;

function TContactoNodo.GetUsuario: string;
begin
  Result := FUsuario;
end;

function TContactoNodo.GetConexiones: TList;
begin
  Result := FConexiones;
end;

{ TGrafoContactos }

constructor TGrafoContactos.Create;
begin
  FNodos := TList.Create;
end;

destructor TGrafoContactos.Destroy;
var
  i: Integer;
begin
  for i := 0 to FNodos.Count - 1 do
    TContactoNodo(FNodos[i]).Free;
  FNodos.Free;
  inherited Destroy;
end;

procedure TGrafoContactos.AgregarNodo(AId: Integer; AUsuario: string);
begin
  if GetNodoPorId(AId) = nil then
    FNodos.Add(TContactoNodo.Create(AId, AUsuario));
end;

procedure TGrafoContactos.ConectarNodos(Id1, Id2: Integer);
var
  Nodo1, Nodo2: TContactoNodo;
begin
  if Id1 = Id2 then Exit;

  Nodo1 := GetNodoPorId(Id1);
  Nodo2 := GetNodoPorId(Id2);

  if (Nodo1 = nil) or (Nodo2 = nil) then
  begin
    WriteLn(Format('Advertencia: no se pudo conectar %d con %d (uno de los nodos no existe)', [Id1, Id2]));
    Exit;
  end;

  if not Nodo1.TieneConexion(Nodo2) then
  begin
    Nodo1.AgregarConexion(Nodo2);
    Nodo2.AgregarConexion(Nodo1);
  end;
end;

function TGrafoContactos.ObtenerNodos: TList;
begin
  Result := FNodos;
end;

function TGrafoContactos.GetNodoPorId(AId: Integer): TContactoNodo;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FNodos.Count - 1 do
    if TContactoNodo(FNodos[i]).GetId = AId then
    begin
      Result := TContactoNodo(FNodos[i]);
      Exit;
    end;
end;

procedure TGrafoContactos.GenerarDOT(const rutaArchivo: string);
var
  ArchivoDOT: TextFile;
  i, j: Integer;
  Nodo, NodoDestino: TContactoNodo;
begin
  if FNodos = nil then Exit;

  AssignFile(ArchivoDOT, rutaArchivo);
  Rewrite(ArchivoDOT);
  try
    Writeln(ArchivoDOT, 'graph GrafoContactos {');
    Writeln(ArchivoDOT, '  layout=circo;');
    Writeln(ArchivoDOT, '  node [shape=circle, style=filled, fillcolor=lightblue];');
    Writeln(ArchivoDOT, '');

    for i := 0 to FNodos.Count - 1 do
    begin
      Nodo := TContactoNodo(FNodos[i]);
      Writeln(ArchivoDOT, Format('  "%d" [label="%d: %s"];', [Nodo.GetId, Nodo.GetId, Nodo.GetUsuario]));
    end;

    Writeln(ArchivoDOT, '');

    for i := 0 to FNodos.Count - 1 do
    begin
      Nodo := TContactoNodo(FNodos[i]);
      for j := 0 to Nodo.GetConexiones.Count - 1 do
      begin
        NodoDestino := TContactoNodo(Nodo.GetConexiones[j]);
        if Nodo.GetId < NodoDestino.GetId then
          Writeln(ArchivoDOT, Format('  "%d" -- "%d";', [Nodo.GetId, NodoDestino.GetId]));
      end;
    end;

    Writeln(ArchivoDOT, '}');
  finally
    CloseFile(ArchivoDOT);
  end;
end;

end.

