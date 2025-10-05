unit bFavoritos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, correo;

const
  ORDEN = 5;
  MAX_CLAVES = ORDEN - 1;
  MIN_CLAVES = ORDEN div 2 - 1;

type
  PNodoB = ^TNodoB;
  TNodoB = record
    n: Integer;
    Datos: array[0..MAX_CLAVES-1] of TCorreo;
    Hijos: array[0..ORDEN-1] of PNodoB;
    esHoja: Boolean;
  end;

  TbFavoritos = class
  private
    raiz: PNodoB;
    procedure LiberarNodo(var nodo: PNodoB);
    function CrearNodoB(esHoja: Boolean): PNodoB;
    procedure InsertarNoLleno(nodo: PNodoB; correo: TCorreo);
    procedure DividirHijo(padre: PNodoB; i: Integer; hijo: PNodoB);
    //ELIMINAR
    procedure EliminarNodo(nodo: PNodoB; id: Integer);
    function ObtenerPredecesor(nodo: PNodoB; idx: Integer): TCorreo;
    function ObtenerSucesor(nodo: PNodoB; idx: Integer): TCorreo;
    procedure Llenar(nodo: PNodoB; idx: Integer);
    procedure TomarPrestadoDelAnterior(nodo: PNodoB; idx: Integer);
    procedure TomarPrestadoDelSiguiente(nodo: PNodoB; idx: Integer);
    procedure Unir(nodo: PNodoB; idx: Integer);
    function ContarNodos(nodo: PNodoB): Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Insertar(correo: TCorreo);
    function GetRaiz: PNodoB;
    function Buscar(id: Integer): TCorreo;
    procedure Eliminar(id: Integer);
    function ContarCorreos: Integer;
    procedure GenerarDOT(const RutaArchivo: string);
  end;

implementation

{ TbFavoritos }

constructor TbFavoritos.Create;
begin
  raiz := nil;
end;

destructor TbFavoritos.Destroy;
begin
  LiberarNodo(raiz);
  inherited Destroy;
end;

function TbFavoritos.GetRaiz: PNodoB;
begin
  Result := raiz;
end;

procedure TbFavoritos.LiberarNodo(var nodo: PNodoB);
var
  i: Integer;
begin
  if nodo <> nil then
  begin
    for i := 0 to ORDEN - 1 do
      LiberarNodo(nodo^.Hijos[i]);
    Dispose(nodo);
    nodo := nil;
  end;
end;

function TbFavoritos.CrearNodoB(esHoja: Boolean): PNodoB;
var
  i: Integer;
begin
  New(Result);
  Result^.n := 0;
  Result^.esHoja := esHoja;
  for i := 0 to ORDEN - 1 do
    Result^.Hijos[i] := nil;
end;

procedure TbFavoritos.InsertarNoLleno(nodo: PNodoB; correo: TCorreo);
var
  i: Integer;
begin
  i := nodo^.n - 1;
  if nodo^.esHoja then
  begin
    while (i >= 0) and (correo.GetId < nodo^.Datos[i].GetId) do
    begin
      nodo^.Datos[i + 1] := nodo^.Datos[i];
      Dec(i);
    end;
    nodo^.Datos[i + 1] := correo;
    Inc(nodo^.n);
  end
  else
  begin
    while (i >= 0) and (correo.GetId < nodo^.Datos[i].GetId) do
      Dec(i);
    Inc(i);
    if nodo^.Hijos[i]^.n = MAX_CLAVES then
    begin
      DividirHijo(nodo, i, nodo^.Hijos[i]);
      if correo.GetId > nodo^.Datos[i].GetId then
        Inc(i);
    end;
    InsertarNoLleno(nodo^.Hijos[i], correo);
  end;
end;

procedure TbFavoritos.DividirHijo(padre: PNodoB; i: Integer; hijo: PNodoB);
var
  nuevo: PNodoB;
  j: Integer;
  medio: TCorreo;
begin
  nuevo := CrearNodoB(hijo^.esHoja);
  nuevo^.n := MIN_CLAVES;

  for j := 0 to MIN_CLAVES - 1 do
    nuevo^.Datos[j] := hijo^.Datos[j + MIN_CLAVES + 1];

  if not hijo^.esHoja then
    for j := 0 to MIN_CLAVES do
      nuevo^.Hijos[j] := hijo^.Hijos[j + MIN_CLAVES + 1];

  hijo^.n := MIN_CLAVES;

  for j := padre^.n downto i + 1 do
    padre^.Hijos[j + 1] := padre^.Hijos[j];

  padre^.Hijos[i + 1] := nuevo;

  for j := padre^.n - 1 downto i do
    padre^.Datos[j + 1] := padre^.Datos[j];

  medio := hijo^.Datos[MIN_CLAVES];
  padre^.Datos[i] := medio;
  Inc(padre^.n);
end;

procedure TbFavoritos.Insertar(correo: TCorreo);
var
  nuevaRaiz: PNodoB;
begin
  if raiz = nil then
  begin
    raiz := CrearNodoB(True);
    raiz^.Datos[0] := correo;
    raiz^.n := 1;
  end
  else
  begin
    if raiz^.n = MAX_CLAVES then
    begin
      nuevaRaiz := CrearNodoB(False);
      nuevaRaiz^.Hijos[0] := raiz;
      DividirHijo(nuevaRaiz, 0, raiz);
      InsertarNoLleno(nuevaRaiz, correo);
      raiz := nuevaRaiz;
    end
    else
      InsertarNoLleno(raiz, correo);
  end;
end;

//Buscar
function TbFavoritos.Buscar(id: Integer): TCorreo;

  function BuscarNodo(nodo: PNodoB; id: Integer): TCorreo;
  var
    i: Integer;
  begin
    Result := nil;
    if nodo = nil then Exit;

    i := 0;
    while (i < nodo^.n) and (id > nodo^.Datos[i].GetId) do
      Inc(i);

    if (i < nodo^.n) and (id = nodo^.Datos[i].GetId) then
    begin
      Result := nodo^.Datos[i];
      Exit;
    end;

    if nodo^.esHoja then
      Exit
    else
      Result := BuscarNodo(nodo^.Hijos[i], id);
  end;

begin
  Result := BuscarNodo(raiz, id);
end;

//ELIMINAR
procedure TbFavoritos.Eliminar(id: Integer);
begin
  if raiz <> nil then
  begin
    EliminarNodo(raiz, id);
    if (raiz^.n = 0) then
    begin
      if raiz^.esHoja then
      begin
        Dispose(raiz);
        raiz := nil;
      end
      else
        raiz := raiz^.Hijos[0];
    end;
  end;
end;

procedure TbFavoritos.EliminarNodo(nodo: PNodoB; id: Integer);
var
  idx, i: Integer;
begin
  idx := 0;
  while (idx < nodo^.n) and (nodo^.Datos[idx].GetId < id) do
    Inc(idx);

  if (idx < nodo^.n) and (nodo^.Datos[idx].GetId = id) then
  begin
    if nodo^.esHoja then
    begin
      for i := idx to nodo^.n - 2 do
        nodo^.Datos[i] := nodo^.Datos[i + 1];
      Dec(nodo^.n);
    end
    else
    begin
      if nodo^.Hijos[idx]^.n >= MIN_CLAVES + 1 then
        nodo^.Datos[idx] := ObtenerPredecesor(nodo, idx)
      else if nodo^.Hijos[idx + 1]^.n >= MIN_CLAVES + 1 then
        nodo^.Datos[idx] := ObtenerSucesor(nodo, idx)
      else
      begin
        Unir(nodo, idx);
        EliminarNodo(nodo^.Hijos[idx], id);
        Exit;
      end;
      EliminarNodo(nodo^.Hijos[idx], nodo^.Datos[idx].GetId);
    end;
  end
  else
  begin
    if nodo^.esHoja then Exit;

    if nodo^.Hijos[idx]^.n = MIN_CLAVES then
      Llenar(nodo, idx);

    if idx > nodo^.n then
      EliminarNodo(nodo^.Hijos[idx - 1], id)
    else
      EliminarNodo(nodo^.Hijos[idx], id);
  end;
end;

function TbFavoritos.ObtenerPredecesor(nodo: PNodoB; idx: Integer): TCorreo;
var
  cur: PNodoB;
begin
  cur := nodo^.Hijos[idx];
  while not cur^.esHoja do
    cur := cur^.Hijos[cur^.n];
  Result := cur^.Datos[cur^.n - 1];
end;

function TbFavoritos.ObtenerSucesor(nodo: PNodoB; idx: Integer): TCorreo;
var
  cur: PNodoB;
begin
  cur := nodo^.Hijos[idx + 1];
  while not cur^.esHoja do
    cur := cur^.Hijos[0];
  Result := cur^.Datos[0];
end;

procedure TbFavoritos.Llenar(nodo: PNodoB; idx: Integer);
begin
  if (idx <> 0) and (nodo^.Hijos[idx - 1]^.n > MIN_CLAVES) then
    TomarPrestadoDelAnterior(nodo, idx)
  else if (idx <> nodo^.n) and (nodo^.Hijos[idx + 1]^.n > MIN_CLAVES) then
    TomarPrestadoDelSiguiente(nodo, idx)
  else
  begin
    if idx <> nodo^.n then
      Unir(nodo, idx)
    else
      Unir(nodo, idx - 1);
  end;
end;

procedure TbFavoritos.TomarPrestadoDelAnterior(nodo: PNodoB; idx: Integer);
var
  hijo, hermano: PNodoB;
  i: Integer;
begin
  hijo := nodo^.Hijos[idx];
  hermano := nodo^.Hijos[idx - 1];

  for i := hijo^.n - 1 downto 0 do
    hijo^.Datos[i + 1] := hijo^.Datos[i];

  if not hijo^.esHoja then
    for i := hijo^.n downto 0 do
      hijo^.Hijos[i + 1] := hijo^.Hijos[i];

  hijo^.Datos[0] := nodo^.Datos[idx - 1];

  if not hijo^.esHoja then
    hijo^.Hijos[0] := hermano^.Hijos[hermano^.n];

  nodo^.Datos[idx - 1] := hermano^.Datos[hermano^.n - 1];

  Inc(hijo^.n);
  Dec(hermano^.n);
end;

procedure TbFavoritos.TomarPrestadoDelSiguiente(nodo: PNodoB; idx: Integer);
var
  hijo, hermano: PNodoB;
  i: Integer;
begin
  hijo := nodo^.Hijos[idx];
  hermano := nodo^.Hijos[idx + 1];

  hijo^.Datos[hijo^.n] := nodo^.Datos[idx];

  if not hijo^.esHoja then
    hijo^.Hijos[hijo^.n + 1] := hermano^.Hijos[0];

  nodo^.Datos[idx] := hermano^.Datos[0];

  for i := 1 to hermano^.n - 1 do
    hermano^.Datos[i - 1] := hermano^.Datos[i];

  if not hermano^.esHoja then
    for i := 1 to hermano^.n do
      hermano^.Hijos[i - 1] := hermano^.Hijos[i];

  Inc(hijo^.n);
  Dec(hermano^.n);
end;

procedure TbFavoritos.Unir(nodo: PNodoB; idx: Integer);
var
  hijo, hermano: PNodoB;
  i, j: Integer;
begin
  hijo := nodo^.Hijos[idx];
  hermano := nodo^.Hijos[idx + 1];

  hijo^.Datos[MIN_CLAVES] := nodo^.Datos[idx];

  for i := 0 to hermano^.n - 1 do
    hijo^.Datos[i + MIN_CLAVES + 1] := hermano^.Datos[i];

  if not hijo^.esHoja then
    for i := 0 to hermano^.n do
      hijo^.Hijos[i + MIN_CLAVES + 1] := hermano^.Hijos[i];

  for i := idx + 1 to nodo^.n - 1 do
    nodo^.Datos[i - 1] := nodo^.Datos[i];

  for i := idx + 2 to nodo^.n do
    nodo^.Hijos[i - 1] := nodo^.Hijos[i];

  hijo^.n := hijo^.n + hermano^.n + 1;
  Dec(nodo^.n);

  Dispose(hermano);
end;

function TbFavoritos.ContarNodos(nodo: PNodoB): Integer;
var
  i, total: Integer;
begin
  if nodo = nil then
    Exit(0);

  total := nodo^.n;

  if not nodo^.esHoja then
    for i := 0 to nodo^.n do
      total := total + ContarNodos(nodo^.Hijos[i]);

  Result := total;
end;

function TbFavoritos.ContarCorreos: Integer;
begin
  Result := ContarNodos(raiz);
end;

//GENERAR DOT
procedure TbFavoritos.GenerarDOT(const RutaArchivo: string);
var
  Archivo: TextFile;

  procedure RecorrerNodo(nodo: PNodoB);
  var
    i: Integer;
    etiqueta: string;
  begin
    if nodo = nil then Exit;

    // Crear etiqueta del nodo como record
    etiqueta := '"';
    for i := 0 to nodo^.n - 1 do
    begin
      etiqueta := etiqueta + Format('<f%d> ID:%d | Asunto:%s | Remitente:%s',
        [i, nodo^.Datos[i].GetId, nodo^.Datos[i].GetAsunto, nodo^.Datos[i].GetRemitente]);
      if i < nodo^.n - 1 then
        etiqueta := etiqueta + ' | ';
    end;
    etiqueta := etiqueta + '"';

    Writeln(Archivo, Format('  Nodo%p [label=%s, shape=record];', [nodo, etiqueta]));

    // Dibujar conexiones hacia los hijos
    if not nodo^.esHoja then
      for i := 0 to nodo^.n do
      begin
        if nodo^.Hijos[i] <> nil then
        begin
          Writeln(Archivo, Format('  Nodo%p:f%d -> Nodo%p;', [nodo, i, nodo^.Hijos[i]]));
          RecorrerNodo(nodo^.Hijos[i]);
        end;
      end;
  end;

begin
  AssignFile(Archivo, RutaArchivo);
  Rewrite(Archivo);

  Writeln(Archivo, 'digraph BTree_Favoritos {');
  Writeln(Archivo, '  rankdir=TB;');
  Writeln(Archivo, '  node [shape=record, style=filled, fillcolor=lightyellow];');
  Writeln(Archivo, '  label="Arbol B de Favoritos"; labelloc=top; fontsize=20;');

  if raiz <> nil then
    RecorrerNodo(raiz);

  Writeln(Archivo, '}');
  CloseFile(Archivo);
end;


end.

