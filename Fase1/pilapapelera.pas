unit pilaPapelera;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, correo;

type
   PNodo = ^TNodo;
   TNodo = record
     Correo: TCorreo;
     Siguiente: PNodo;
   end;

   TPilaPapelera = class
     private
       Tope: PNodo;
       FCantidad: Integer;
     public
       constructor Create;
       destructor Destroy; override;

       procedure Push(NuevoCorreo: TCorreo);
       procedure GenerarDOT(const RutaArchivo: string);
       function Pop: TCorreo;
       function Count: Integer;
       function GetTope: PNodo;
   end;

implementation

constructor TPilaPapelera.Create;
begin
  Tope := nil;
  FCantidad := 0;
end;

destructor TPilaPapelera.Destroy;
var
 Aux: PNodo;
begin
  while Tope <> nil do
   begin
     Aux := Tope;
     Tope := Tope^.Siguiente;
     Aux^.Correo.Free;
     Dispose(Aux);
   end;
   inherited Destroy;
end;

procedure TPilaPapelera.Push(NuevoCorreo: TCorreo);
var
 nuevoNodo: PNodo;
begin
  New(NuevoNodo);
  NuevoNodo^.Correo := NuevoCorreo;
  NuevoNodo^.Siguiente := Tope;
  Tope := nuevoNodo;
  Inc(FCantidad);
end;

function TPilaPapelera.Pop: TCorreo;
var
 Aux: PNodo;
begin
  if Tope = nil then
  begin
    Result := nil;
    Exit;
  end;

  Result := Tope^.Correo;
  Aux := Tope;
  Tope := Tope^.Siguiente;
  Dispose(Aux);
  Dec(FCantidad);
end;

function TPilaPapelera.Count: Integer;
begin
  Result := FCantidad;
end;

function TPilaPapelera.GetTope: PNodo;
begin
  Result := Tope;
end;

procedure TPilaPapelera.GenerarDOT(const RutaArchivo: string);
var
  Archivo: TextFile;
  Temp: PNodo;
  NodoNombre: string;
  Contador: Integer;
begin
  AssignFile(Archivo, RutaArchivo);
  Rewrite(Archivo);

  Writeln(Archivo, 'digraph G {');
  Writeln(Archivo, '  rankdir=TB;');
  Writeln(Archivo, '  node [shape=record, style=filled, fillcolor=lightcoral];');
  Writeln(Archivo, '  label="Pila de Correos (Papelera)";');
  Writeln(Archivo, '  labelloc=top; fontsize=20;');

  Temp := Tope;
  Contador := 0;

  while Temp <> nil do
  begin
    NodoNombre := 'Nodo' + IntToStr(Contador);
    Writeln(Archivo, '  ', NodoNombre, ' [label="{Id: ', (IntToStr(Temp^.Correo.GetId)),
            '\nRemitente: ', (Temp^.Correo.GetRemitente),
            '\nEstado: ', (Temp^.Correo.GetEstado),
            '\nProgramado: ', (Temp^.Correo.GetProgramado),
            '\nAsunto: ', (Temp^.Correo.GetAsunto),
            '\nFecha: ', (Temp^.Correo.GetFecha),
            '\nMensaje: ', (Temp^.Correo.GetMensaje), '}"];');

    Temp := Temp^.Siguiente;
    Inc(Contador);
  end;

  Temp := Tope;
  Contador := 0;
  while (Temp <> nil) and (Temp^.Siguiente <> nil) do
  begin
    Writeln(Archivo, '  Nodo', Contador, ' -> Nodo', Contador + 1, ';');
    Temp := Temp^.Siguiente;
    Inc(Contador);
  end;

  Writeln(Archivo, '}');
  CloseFile(Archivo);
end;


end.

