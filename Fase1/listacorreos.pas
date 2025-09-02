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

end.

