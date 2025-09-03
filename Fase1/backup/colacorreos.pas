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
      function Desencolar: TCorreo;
      property Count: Integer read FCantidad;
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

end.

