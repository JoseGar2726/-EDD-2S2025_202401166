unit grafond;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const
  MAX = 100;

type
  PNode = ^TNode;
  TNode = record
    vertice: integer;
    siguiente: PNode;
  end;

  TGraph = record
    vertices: integer;
    adjList: array[1..MAX] of PNode;
    nombres: array[1..MAX] of string;
  end;

procedure InitGraph(var g: TGraph; n: integer);

procedure AddVertex(var g: TGraph; pos: integer; nombre: string);

procedure AddEdge(var g: TGraph; u, v: integer);

procedure PrintGraph(g: TGraph);

procedure GenerarDOT(g: TGraph; const nombreArchivo: string);

implementation

function CreateNode(v: integer): PNode;
var
  newNode: PNode;
begin
  New(newNode);
  newNode^.vertice := v;
  newNode^.siguiente := nil;
  CreateNode := newNode;
end;

procedure InitGraph(var g: TGraph; n: integer);
var
  i: integer;
begin
  g.vertices := n;
  for i := 1 to n do
  begin
    g.adjList[i] := nil;
    g.nombres[i] := '';
  end;
end;

procedure AddVertex(var g: TGraph; pos: integer; nombre: string);
begin
  if (pos >= 1) and (pos <= g.vertices) then
    g.nombres[pos] := nombre
  else
    Writeln('Posición de nodo inválida');
end;

procedure AddEdge(var g: TGraph; u, v: integer);
var
  newNode: PNode;
begin
  if (u < 1) or (u > g.vertices) or (v < 1) or (v > g.vertices) then
  begin
    Writeln('Error: nodos fuera de rango');
    Exit;
  end;

  newNode := CreateNode(v);
  newNode^.siguiente := g.adjList[u];
  g.adjList[u] := newNode;

  newNode := CreateNode(u);
  newNode^.siguiente := g.adjList[v];
  g.adjList[v] := newNode;
end;

procedure PrintGraph(g: TGraph);
var
  i: integer;
  temp: PNode;
begin
  for i := 1 to g.vertices do
  begin
    Write('Nodo ', i, ' (', g.nombres[i], '): ');
    temp := g.adjList[i];
    while temp <> nil do
    begin
      Write(temp^.vertice, ' ');
      temp := temp^.siguiente;
    end;
    Writeln;
  end;
end;

procedure GenerarDOT(g: TGraph; const nombreArchivo: string);
var
  f: TextFile;
  i: integer;
  temp: PNode;
  comando, pngFile: string;
begin
  AssignFile(f, nombreArchivo);
  Rewrite(f);

  Writeln(f, 'graph G {');
  Writeln(f, '  node [shape=circle, style=filled, fillcolor=lightblue];');

  for i := 1 to g.vertices do
    Writeln(f, '  ', i, ' [label="', g.nombres[i], '"];');

  for i := 1 to g.vertices do
  begin
    temp := g.adjList[i];
    while temp <> nil do
    begin
      if (i < temp^.vertice) then
        Writeln(f, '  ', i, ' -- ', temp^.vertice, ';');
      temp := temp^.siguiente;
    end;
  end;

  Writeln(f, '}');
  CloseFile(f);

  Writeln('Archivo DOT generado: ', nombreArchivo);

  pngFile := ChangeFileExt(nombreArchivo, '.png');
  comando := 'dot -Tpng "' + nombreArchivo + '" -o "' + pngFile + '"';

  if ExecuteProcess('cmd.ex  e', ['/C', comando]) = 0 then
    Writeln('Imagen PNG generada: ', pngFile)
  else
    Writeln('Error al generar la imagen PNG. Verifica que Graphviz esté instalado.');
end;

end.

