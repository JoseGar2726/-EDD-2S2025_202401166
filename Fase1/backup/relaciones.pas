unit relaciones;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  PNodo = ^TNodo;
  TNodo = record
    fila, columna: string;
    valor: Integer;
    derecha, abajo: PNodo;
  end;

  PCabecera = ^TCabecera;
  TCabecera = record
    nombre: string;
    siguiente: PCabecera;
    acceso: PNodo;
  end;

  TRelaciones = class
  private
    filas: PCabecera;
    columnas: PCabecera;
    function BuscarCabecera(var lista: PCabecera; nombre: string): PCabecera;
    function CrearCabecera(var lista: PCabecera; nombre: string): PCabecera;
  public
    constructor Create;
    procedure Insertar(origen, destino: string; cantidad: Integer);
    procedure GenerarDOT(const RutaArchivo: string);
  end;

implementation
constructor TRelaciones.Create;
begin
  filas := nil;
  columnas := nil;
end;

function TRelaciones.BuscarCabecera(var lista: PCabecera; nombre: string): PCabecera;
var
  temp: PCabecera;
begin
  temp := lista;
  while temp <> nil do
  begin
    if temp^.nombre = nombre then
      Exit(temp);
    temp := temp^.siguiente;
  end;
  Result := nil;
end;

function TRelaciones.CrearCabecera(var lista: PCabecera; nombre: string): PCabecera;
var
  nueva, temp: PCabecera;
begin
  nueva := BuscarCabecera(lista, nombre);
  if nueva <> nil then
    Exit(nueva);

  New(nueva);
  nueva^.nombre := nombre;
  nueva^.acceso := nil;
  nueva^.siguiente := nil;

  if lista = nil then
    lista := nueva
  else
  begin
    temp := lista;
    while temp^.siguiente <> nil do
      temp := temp^.siguiente;
    temp^.siguiente := nueva;
  end;

  Result := nueva;
end;

procedure TRelaciones.Insertar(origen, destino: string; cantidad: Integer);
var
  filaCab, colCab: PCabecera;
  nuevo, temp: PNodo;
begin
  filaCab := CrearCabecera(filas, origen);
  colCab := CrearCabecera(columnas, destino);

  temp := filaCab^.acceso;
  while temp <> nil do
  begin
    if temp^.columna = destino then
    begin
      temp^.valor := temp^.valor + cantidad;
      Exit;
    end;
    temp := temp^.derecha;
  end;

  New(nuevo);
  nuevo^.fila := origen;
  nuevo^.columna := destino;
  nuevo^.valor := cantidad;
  nuevo^.derecha := nil;
  nuevo^.abajo := nil;

  if filaCab^.acceso = nil then
    filaCab^.acceso := nuevo
  else
  begin
    temp := filaCab^.acceso;
    while temp^.derecha <> nil do
      temp := temp^.derecha;
    temp^.derecha := nuevo;
  end;

  if colCab^.acceso = nil then
    colCab^.acceso := nuevo
  else
  begin
    temp := colCab^.acceso;
    while temp^.abajo <> nil do
      temp := temp^.abajo;
    temp^.abajo := nuevo;
  end;
end;

procedure TRelaciones.GenerarDOT(const RutaArchivo: string);
var
  Dot: Text;
  filaCab, colCab: PCabecera;
  nodo, prevNodo: PNodo;
  NodeName, PrevName: string;
begin
  Assign(Dot, RutaArchivo);
  Rewrite(Dot);

  Writeln(Dot, 'digraph Matriz {');
  Writeln(Dot, '  graph [splines=ortho];');
  Writeln(Dot, '  rankdir=TB;');
  Writeln(Dot, '  node [shape=record, style=filled, fillcolor=white];');
  Writeln(Dot, '  label = "Matriz Dispersa de Relaciones";');

  { Cabeceras de columnas }
  colCab := columnas;
  Write(Dot, '  { rank=same; "ROOT";');
  while colCab <> nil do
  begin
    Write(Dot, Format(' "col_%s";', [colCab^.nombre]));
    Writeln(Dot, Format('  "col_%s" [label="%s", shape=plaintext, fillcolor=lightblue];',
      [colCab^.nombre, colCab^.nombre]));
    colCab := colCab^.siguiente;
  end;
  Writeln(Dot, ' }');

  { Cabeceras de filas }
  filaCab := filas;
  while filaCab <> nil do
  begin
    Writeln(Dot, Format('  "row_%s" [label="%s", shape=plaintext, fillcolor=lightgreen];',
      [filaCab^.nombre, filaCab^.nombre]));
    filaCab := filaCab^.siguiente;
  end;

  { Conectar ROOT }
  if columnas <> nil then
  begin
    Writeln(Dot, Format('  "ROOT" -> "col_%s";', [columnas^.nombre]));
    Writeln(Dot, Format('  "col_%s" -> "ROOT";', [columnas^.nombre]));
  end;
  if filas <> nil then
  begin
    Writeln(Dot, Format('  "ROOT" -> "row_%s";', [filas^.nombre]));
    Writeln(Dot, Format('  "row_%s" -> "ROOT";', [filas^.nombre]));
  end;

  { Conectar cabeceras en cadena (doble enlace) }
  colCab := columnas;
  while (colCab <> nil) and (colCab^.siguiente <> nil) do
  begin
    Writeln(Dot, Format('  "col_%s" -> "col_%s";', [colCab^.nombre, colCab^.siguiente^.nombre]));
    Writeln(Dot, Format('  "col_%s" -> "col_%s";', [colCab^.siguiente^.nombre, colCab^.nombre]));
    colCab := colCab^.siguiente;
  end;

  filaCab := filas;
  while (filaCab <> nil) and (filaCab^.siguiente <> nil) do
  begin
    Writeln(Dot, Format('  "row_%s" -> "row_%s";', [filaCab^.nombre, filaCab^.siguiente^.nombre]));
    Writeln(Dot, Format('  "row_%s" -> "row_%s";', [filaCab^.siguiente^.nombre, filaCab^.nombre]));
    filaCab := filaCab^.siguiente;
  end;

  { Nodos internos }
  filaCab := filas;
  while filaCab <> nil do
  begin
    nodo := filaCab^.acceso;
    prevNodo := nil;

    { Alinear por fila }
    Write(Dot, '  { rank=same;');
    Write(Dot, Format(' "row_%s";', [filaCab^.nombre]));
    while nodo <> nil do
    begin
      NodeName := Format('f_%s_c_%s', [nodo^.fila, nodo^.columna]);
      Write(Dot, Format(' "%s";', [NodeName]));
      nodo := nodo^.derecha;
    end;
    Writeln(Dot, ' }');

    { Conexiones de la fila }
    nodo := filaCab^.acceso;
    prevNodo := nil;
    while nodo <> nil do
    begin
      NodeName := Format('f_%s_c_%s', [nodo^.fila, nodo^.columna]);
      Writeln(Dot, Format('  "%s" [label="%d"];', [NodeName, nodo^.valor]));

      if prevNodo = nil then
      begin
        Writeln(Dot, Format('  "row_%s" -> "%s";', [filaCab^.nombre, NodeName]));
        Writeln(Dot, Format('  "%s" -> "row_%s";', [NodeName, filaCab^.nombre]));
      end
      else
      begin
        PrevName := Format('f_%s_c_%s', [prevNodo^.fila, prevNodo^.columna]);
        Writeln(Dot, Format('  "%s" -> "%s";', [PrevName, NodeName]));
        Writeln(Dot, Format('  "%s" -> "%s";', [NodeName, PrevName]));
      end;

      { Conexiones de la columna }
      Writeln(Dot, Format('  "col_%s" -> "%s";', [nodo^.columna, NodeName]));
      Writeln(Dot, Format('  "%s" -> "col_%s";', [NodeName, nodo^.columna]));

      prevNodo := nodo;
      nodo := nodo^.derecha;
    end;

    filaCab := filaCab^.siguiente;
  end;

  Writeln(Dot, '}');
  Close(Dot);
end;



end.

