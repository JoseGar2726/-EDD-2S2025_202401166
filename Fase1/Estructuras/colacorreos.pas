unit colaCorreos;

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

  TColaCorreos = class
    private
      Frente: PNodo;
      Final: PNodo;
      FCantidad: Integer;
    public
      constructor Create;
      destructor Destroy; override;

      procedure Encolar(NuevoCorreo: TCorreo);
      procedure GenerarDOT(const RutaArchivo: string);
      function Desencolar: TCorreo;
      property Count: Integer read FCantidad;
      function GetFrente: PNodo;
  end;

implementation

constructor TColaCorreos.Create;
begin
 Frente := nil;
 Final := nil;
 FCantidad := 0;
end;

destructor TColaCorreos.Destroy;
var
 Aux: PNodo;
begin
 while Frente <> nil do
 begin
   Aux := Frente;
   Frente := Frente^.Siguiente;
   Aux^.Correo.Free;
   Dispose(Aux);
 end;
 inherited Destroy;
end;

procedure TColaCorreos.Encolar(NuevoCorreo: TCorreo);
var
 NuevoNodo: PNodo;
begin
 New(NuevoNodo);
 NuevoNodo^.Correo := NuevoCorreo;
 NuevoNodo^.Siguiente := nil;

 if Final <> nil then
  Final^.Siguiente := NuevoNodo
 else
  Frente := NuevoNodo;

 Final := NuevoNodo;
 Inc(FCantidad);
end;

function TColaCorreos.Desencolar: TCorreo;
var
 Aux: PNodo;
begin
 if Frente = nil then
  Exit(nil);

 Aux := Frente;
 Result := Aux^.Correo;

 Frente := Frente^.Siguiente;
 if Frente = nil then
  Final := nil;

 Dispose(Aux);
 Dec(FCantidad);
end;

function TColaCorreos.GetFrente: PNodo;
begin
 Result := Frente;
end;

procedure TColaCorreos.GenerarDOT(const RutaArchivo: string);
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
  Writeln(Archivo, '  node [shape=record, style=filled, fillcolor=lightblue];');
  Writeln(Archivo, '  label="Cola de Correos (Programados)";');
  Writeln(Archivo, '  labelloc=top; fontsize=20;');

  Temp := Frente;
  Contador := 0;

  while Temp <> nil do
  begin
    NodoNombre := 'Nodo' + IntToStr(Contador);
    Writeln(Archivo, '  ', NodoNombre, ' [label="{Id: ', IntToStr(Temp^.Correo.GetId),
            '\nDestinatario: ', Temp^.Correo.GetDestinatario,
            '\nEstado: ', Temp^.Correo.GetEstado,
            '\nProgramado: ', Temp^.Correo.GetProgramado,
            '\nAsunto: ', Temp^.Correo.GetAsunto,
            '\nFecha: ', Temp^.Correo.GetFecha,
            '\nMensaje: ', Temp^.Correo.GetMensaje, '}"];');

    Temp := Temp^.Siguiente;
    Inc(Contador);
  end;

  Temp := Frente;
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

