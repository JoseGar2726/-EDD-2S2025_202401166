program tarea4;

uses SysUtils ,grafond;

var
  g: TGraph;

begin
  Writeln('Bienvenido');
  Writeln('Se generara un grafo con la siguiente informacion');
  Writeln('');
  Writeln('Vertices:');
  Writeln('Ciudad A: 1');
  Writeln('Ciudad B: 2');
  Writeln('Ciudad C: 3');
  Writeln('Ciudad D: 4');
  Writeln('Ciudad E: 5');
  Writeln('');
  Writeln('Conexiones:');
  Writeln('1 <-> 2');
  Writeln('1 <-> 3');
  Writeln('2 <-> 4');
  Writeln('3 <-> 5');
  Writeln('1 <-> 5');
  Writeln('2 <-> 5');

  InitGraph(g, 5);

  AddVertex(g, 1, 'Ciudad A');
  AddVertex(g, 2, 'Ciudad B');
  AddVertex(g, 3, 'Ciudad C');
  AddVertex(g, 4, 'Ciudad D');
  AddVertex(g, 5, 'Ciudad E');

  AddEdge(g, 1, 2);
  AddEdge(g, 1, 3);
  AddEdge(g, 2, 4);
  AddEdge(g, 3, 5);
  AddEdge(g, 1, 5);

  Writeln('');
  Write('Presione Enter para continuar...');
  ReadLn;
  GenerarDOT(g, 'grafo.dot');
  Write('Presione Enter para salir...');
  ReadLn;

end.

