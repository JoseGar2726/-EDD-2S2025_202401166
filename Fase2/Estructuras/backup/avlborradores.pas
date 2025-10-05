unit avlBorradores;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, correo;

type
  PNodo = ^TNodo;
  TNodo = record
    Datos: TCorreo;
    Izquierda, Derecha: PNodo;
    Altura: Integer;
  end;

TAvlBorradores = class
  private
    raiz: PNodo;
    procedure LiberarNodo(var nodo: PNodo);
    function ObtenerAltura(nodo: PNodo): Integer;
    procedure ActualizarAltura(nodo: PNodo);
    function ObtenerBalance(nodo: PNodo): Integer;
    function RotarDerecha(y: PNodo): PNodo;
    function RotarIzquierda(x: PNodo): PNodo;
    function CrearNodo(correo: TCorreo): PNodo;
    function InsertarNodo(nodo: PNodo; correo: TCorreo): PNodo;
    function Contar(nodo: PNodo): Integer;
    function Buscar(nodo: PNodo; idCorreo: Integer): PNodo;
    function EliminarNodo(nodo: PNodo; idCorreo: Integer): PNodo;
    function EncontrarMinimo(nodo: PNodo): PNodo;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Insertar(correo: TCorreo);
    function GetRaiz: PNodo;
    function Count: Integer;
    procedure GenerarDot(const RutaArchivo: string);
    procedure Editar(nuevoCorreo: TCorreo);
    function Busca(idCorreo: Integer): TCorreo;
    procedure Eliminar(idCorreo: Integer);
end;

implementation

{ TAvlBorradores }

constructor TAvlBorradores.Create;
begin
  raiz := nil;
end;

procedure TAvlBorradores.LiberarNodo(var nodo: PNodo);
begin
  if nodo <> nil then
  begin
    LiberarNodo(nodo^.Izquierda);
    LiberarNodo(nodo^.Derecha);

    Dispose(nodo);
    nodo := nil;
  end;
end;

destructor TAvlBorradores.Destroy;
begin
  LiberarNodo(raiz);
  inherited Destroy;
end;

//OBTENER ALTURA
function TAvlBorradores.ObtenerAltura(nodo: Pnodo): Integer;
begin
  if nodo = nil then
     ObtenerAltura := 0
  else
    ObtenerAltura :=  nodo^.Altura;
end;

//ACTUALIZAR ALTURA BASADA EN SUS HIJOS
procedure TAvlBorradores.ActualizarAltura(nodo: Pnodo);
var
 alturaIzq, alturaDer: Integer;
begin
  alturaIzq := ObtenerAltura(nodo^.Izquierda);
  alturaDer := ObtenerAltura(nodo^.Derecha);
  if alturaIzq > alturaDer then
   nodo^.Altura := alturaIzq + 1
  else
    nodo^.Altura := alturaDer + 1;
end;

//FACTOR DE BALANCE
function TAvlBorradores.ObtenerBalance(nodo: PNodo): Integer;
begin
  if nodo = nil then
     ObtenerBalance := 0
  else
     ObtenerBalance := ObtenerAltura(nodo^.Izquierda) - ObtenerAltura(nodo^.Derecha);
end;

//ROTACION DERECHA
function TAvlBorradores.RotarDerecha(y: PNodo): PNodo;
var
 x: PNodo;
begin
  x := y^.Izquierda;
  y^.Izquierda := x^.Derecha;
  x^.Derecha := y;
  ActualizarAltura(y);
  ActualizarAltura(x);
  RotarDerecha := x;
end;

//ROTACION IZQUIERDA
function TAvlBorradores.RotarIzquierda(x: PNodo): PNodo;
var
 y: PNodo;
begin
  y := x^.Derecha;
  x^.Derecha := y^.Izquierda;
  y^.Izquierda := x;
  ActualizarAltura(x);
  ActualizarAltura(y);
  RotarIzquierda := y;
end;

//CREAR NUEVO NODO
function TAvlBorradores.CrearNodo(correo: TCorreo): PNodo;
var
 nuevo: PNodo;
begin
  New(nuevo);
  nuevo^.Datos := correo;
  nuevo^.Izquierda := nil;
  nuevo^.Derecha := nil;
  nuevo^.Altura := 1;
  CrearNodo := nuevo;
end;

//INSERTAR NODO
procedure TAvlBorradores.Insertar(correo: TCorreo);
begin
  raiz := InsertarNodo(raiz, correo);
end;

function TAvlBorradores.InsertarNodo(nodo: PNodo; correo: TCorreo): PNodo;
var
  balance: Integer;
begin
  if nodo = nil then
    Exit(CrearNodo(correo));

  if correo.GetId < nodo^.Datos.GetId then
    nodo^.Izquierda := InsertarNodo(nodo^.Izquierda, correo)
  else if correo.GetId > nodo^.Datos.GetId then
    nodo^.Derecha := InsertarNodo(nodo^.Derecha, correo)
  else
    nodo^.Datos := correo;

  ActualizarAltura(nodo);

  balance := ObtenerBalance(nodo);

  // LL
  if (balance > 1) and (correo.GetId < nodo^.Izquierda^.Datos.GetId) then
    Exit(RotarDerecha(nodo));

  // RR
  if (balance < -1) and (correo.GetId > nodo^.Derecha^.Datos.GetId) then
    Exit(RotarIzquierda(nodo));

  // LR
  if (balance > 1) and (correo.GetId > nodo^.Izquierda^.Datos.GetId) then
  begin
    nodo^.Izquierda := RotarIzquierda(nodo^.Izquierda);
    Exit(RotarDerecha(nodo));
  end;

  // RL
  if (balance < -1) and (correo.GetId < nodo^.Derecha^.Datos.GetId) then
  begin
    nodo^.Derecha := RotarDerecha(nodo^.Derecha);
    Exit(RotarIzquierda(nodo));
  end;

  Result := nodo;
end;

function TAvlBorradores.GetRaiz: PNodo;
begin
  Result := raiz;
end;

function TAvlBorradores.Count: Integer;
begin
  Result := Contar(raiz);
end;

function TAvlBorradores.Contar(nodo: PNodo): Integer;
begin
  if nodo = nil then
    Exit(0);
  Result := 1 + Contar(nodo^.Izquierda) + Contar(nodo^.Derecha);
end;

//Buscar Nodo
function TAvlBorradores.Buscar(nodo: PNodo; idCorreo: Integer): PNodo;
begin
  if (nodo = nil) or (nodo^.Datos.GetId = idCorreo) then
     Buscar := nodo
  else if idCorreo < nodo^.Datos.GetId then
     Buscar := Buscar(nodo^.Izquierda, idCorreo)
  else
     Buscar := Buscar(nodo^.Derecha, idCorreo);
end;

function TAvlBorradores.Busca(idCorreo: Integer): TCorreo;
var
  nodo: PNodo;
begin
  nodo := Buscar(raiz, idCorreo);
  Result := nodo^.Datos;
end;

//Editar Nodo
procedure TAvlBorradores.Editar(nuevoCorreo: TCorreo);
var
  nodo: PNodo;
begin
  nodo := Buscar(raiz, nuevoCorreo.GetId);
  if nodo <> nil then
  begin
    nodo^.Datos := nuevoCorreo;
  end;
end;

//ELIMINAR
function TAvlBorradores.EncontrarMinimo(nodo: PNodo): PNodo;
begin
  while nodo^.Izquierda <> nil do
    nodo := nodo^.Izquierda;
  EncontrarMinimo := nodo;
end;

function TAvlBorradores.EliminarNodo(nodo: PNodo; idCorreo: Integer): PNodo;
var
  balance: Integer;
  temp: PNodo;
begin
  if nodo = nil then
    Exit(nil);

  if idCorreo < nodo^.Datos.GetId then
    nodo^.Izquierda := EliminarNodo(nodo^.Izquierda, idCorreo)
  else if idCorreo > nodo^.Datos.GetId then
    nodo^.Derecha := EliminarNodo(nodo^.Derecha, idCorreo)
  else
  begin
    if (nodo^.Izquierda = nil) or (nodo^.Derecha = nil) then
    begin
      if nodo^.Izquierda <> nil then
       temp := nodo^.Izquierda
      else
       temp := nodo^.Derecha;

      if temp = nil then
      begin
        Dispose(nodo);
        Exit(nil);
      end
      else
      begin
        nodo^.Datos := temp^.Datos;
        nodo^.Izquierda := temp^.Izquierda;
        nodo^.Derecha := temp^.Derecha;
        nodo^.Altura := temp^.Altura;
        Dispose(temp);
      end;
    end
    else
    begin
      temp := EncontrarMinimo(nodo^.Derecha);
      nodo^.Datos := temp^.Datos;
      nodo^.Derecha := EliminarNodo(nodo^.Derecha, temp^.Datos.GetId);
    end;
  end;

  if nodo = nil then
    Exit(nil);

  ActualizarAltura(nodo);

  balance := ObtenerBalance(nodo);

  if (balance > 1) and (ObtenerBalance(nodo^.Izquierda) >= 0) then
    Exit(RotarDerecha(nodo));

  if (balance > 1) and (ObtenerBalance(nodo^.Izquierda) < 0) then
  begin
    nodo^.Izquierda := RotarIzquierda(nodo^.Izquierda);
    Exit(RotarDerecha(nodo));
  end;

  if (balance < -1) and (ObtenerBalance(nodo^.Derecha) <= 0) then
    Exit(RotarIzquierda(nodo));

  if (balance < -1) and (ObtenerBalance(nodo^.Derecha) > 0) then
  begin
    nodo^.Derecha := RotarDerecha(nodo^.Derecha);
    Exit(RotarIzquierda(nodo));
  end;

  Result := nodo;
end;

procedure TAvlBorradores.Eliminar(idCorreo: Integer);
begin
  raiz := EliminarNodo(raiz, idCorreo);
end;

//GENERAR DOT
procedure TAvlBorradores.GenerarDOT(const RutaArchivo: string);
var
  Archivo: TextFile;

  procedure RecorrerNodo(nodo: PNodo);
  begin
    if nodo = nil then Exit;

    Writeln(Archivo, Format('  Nodo%d [label="ID: %d\nRemitente: %s\nDestinatario: %s\nEstado: %s\nFecha: %s\nAsunto: %s\nMensaje: %s\nProgramado: %s"];',
      [nodo^.Datos.GetId,
       nodo^.Datos.GetId,
       nodo^.Datos.GetRemitente,
       nodo^.Datos.GetDestinatario,
       nodo^.Datos.GetEstado,
       nodo^.Datos.GetFecha,
       nodo^.Datos.GetAsunto,
       nodo^.Datos.GetMensaje,
       nodo^.Datos.GetProgramado]));

    if nodo^.Izquierda <> nil then
      Writeln(Archivo, Format('  Nodo%d -> Nodo%d;', [nodo^.Datos.GetId, nodo^.Izquierda^.Datos.GetId]));

    if nodo^.Derecha <> nil then
      Writeln(Archivo, Format('  Nodo%d -> Nodo%d;', [nodo^.Datos.GetId, nodo^.Derecha^.Datos.GetId]));

    RecorrerNodo(nodo^.Izquierda);
    RecorrerNodo(nodo^.Derecha);
  end;

begin
  AssignFile(Archivo, RutaArchivo);
  Rewrite(Archivo);

  Writeln(Archivo, 'digraph AVL_Borradores {');
  Writeln(Archivo, '  rankdir=TB;');
  Writeln(Archivo, '  node [shape=box, style=filled, fillcolor=lightblue];');
  Writeln(Archivo, '  label="Arbol AVL Borradores"; labelloc=top; fontsize=20;');

  if raiz <> nil then
    RecorrerNodo(raiz);

  Writeln(Archivo, '}');
  CloseFile(Archivo);
end;


end.

