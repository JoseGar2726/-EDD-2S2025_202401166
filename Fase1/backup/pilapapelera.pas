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
     public
       constructor Create;
       destructor Destroy; override;

       procedure Push(NuevoCorreo: TCorreo);
       function Pop: TCorreo;
   end;

implementation

constructor TPilaPapelera.Create;
begin
  Tope := nil;
end;

destructor TPilaPapelera.Destroy;
var
 Aux := PNodo;
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
end;


end.

