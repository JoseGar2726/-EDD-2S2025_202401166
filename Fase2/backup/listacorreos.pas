unit listaCorreos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, correo;

type
  PNodo = ^TNodo;

  TNodo = record
    Correo: TCorreo;
    Siguiente: PNodo;
    Anterior: PNodo;
  end;

  TListaCorreos = class
    private
      Cabeza: PNodo;
      Cola: PNodo;
      FCantidad: Integer;
    public
      constructor Create;
      destructor Destroy; override;

      procedure AgregarCorreo(NuevoCorreo: TCorreo);
      procedure GenerarDOT(const RutaArchivo: string);
      property Count: Integer read FCantidad;
      function ContarCorreos(): Integer;
      function Eliminar(const id: Integer): TCorreo;
      function Primero: PNodo;
  end;

implementation

constructor TListaCorreos.Create;
begin
  Cabeza := nil;
  Cola := nil;
  FCantidad := 0;
end;

destructor TListaCorreos.Destroy;
var
 Aux, Temp: PNodo;
begin
  Aux := Cabeza;
  while Aux <> nil do
  begin
    Temp := Aux^.Siguiente;
    Aux^.Correo.Free;
    Dispose(Aux);
    Aux := Temp;
  end;
  inherited Destroy;
end;

procedure TListaCorreos.AgregarCorreo(NuevoCorreo: TCorreo);
var
 NuevoNodo: PNodo;
begin
  New(NuevoNodo);
  NuevoNodo^.Correo := NuevoCorreo;
  NuevoNodo^.Siguiente := nil;
  NuevoNodo^.Anterior := Cola;

  if Cola <> nil then
   Cola^.Siguiente := NuevoNodo
  else
   Cabeza := NuevoNodo;

  Cola := NuevoNodo;
  Inc(FCantidad);
end;

function TListaCorreos.Primero: PNodo;
begin
  Result := Cabeza;
end;

function TListaCorreos.ContarCorreos: Integer;
var
 Aux: PNodo;
 Contador: Integer;
begin
  Contador := 0;
  Aux := Cabeza;
  while Aux <> nil do
  begin
    if Aux^.Correo.GetEstado = 'NL' then
     Inc(Contador);
    Aux := Aux^.Siguiente;
  end;
  Result := Contador;
end;

function TListaCorreos.Eliminar(const id: Integer): TCorreo;
var
 Aux: PNodo;
begin
  Result:= nil;
  Aux:=Cabeza;

  while Aux <> nil do
  begin
    if Aux^.Correo.GetId = id then
     begin
       Result := Aux^.Correo;
       if Aux^.Anterior <> nil then
        Aux^.Anterior^.Siguiente := Aux^.Siguiente
       else
        Cabeza := Aux^.Siguiente;

       if Aux^.Siguiente <> nil then
        Aux^.Siguiente^.Anterior := Aux^.Anterior
       else
        Cola := Aux^.Anterior;

       Dispose(Aux);
       Dec(FCantidad);
       Exit;
     end;
     Aux := Aux^.Siguiente;
  end;
end;

procedure TListaCorreos.GenerarDOT(const RutaArchivo: string);
var
  F: TextFile;
  Aux: PNodo;
  NodoNombre: string;
  Contador: Integer;

  function EscaparTexto(const S: string): string;
  begin
    Result := StringReplace(S, '"', '\"', [rfReplaceAll]);
    Result := StringReplace(Result, '{', '\{', [rfReplaceAll]);
    Result := StringReplace(Result, '}', '\}', [rfReplaceAll]);
    Result := StringReplace(Result, '|', '\|', [rfReplaceAll]);
  end;

begin
  AssignFile(F, RutaArchivo);
  Rewrite(F);

  Writeln(F, 'digraph G {');
  Writeln(F, '  rankdir=LR;');
  Writeln(F, '  node [shape=record, style=filled, fillcolor=lightblue];');
  Writeln(F, '  label="Lista Doblemente Enlazada: Correos";');
  Writeln(F, '  labelloc=top; fontsize=20;');

  Aux := Cabeza;
  Contador := 0;

  while Aux <> nil do
  begin
    NodoNombre := 'Nodo' + IntToStr(Contador);
    Writeln(F, '  ', NodoNombre, ' [label="{Id: ', EscaparTexto(IntToStr(Aux^.Correo.GetId)),
            '\nRemitente: ', EscaparTexto(Aux^.Correo.GetRemitente),
            '\nEstado: ', EscaparTexto(Aux^.Correo.GetEstado),
            '\nProgramdo: ', (Temp^.Correo.GetProgramado),
            '\nAsunto: ', EscaparTexto(Aux^.Correo.GetAsunto),
            '\nFecha: ', EscaparTexto(Aux^.Correo.GetFecha),
            '\nMensaje: ', EscaparTexto(Aux^.Correo.GetMensaje), '}"];');
    Aux := Aux^.Siguiente;
    Inc(Contador);
  end;

  Aux := Cabeza;
  Contador := 0;
  while (Aux <> nil) and (Aux^.Siguiente <> nil) do
  begin
    Writeln(F, '  Nodo', Contador, ' -> Nodo', Contador + 1, ' [dir=both];');
    Aux := Aux^.Siguiente;
    Inc(Contador);
  end;

  Writeln(F, '}');
  CloseFile(F);
end;



end.

