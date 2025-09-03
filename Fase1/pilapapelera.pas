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


end.

