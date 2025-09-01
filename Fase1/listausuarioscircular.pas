unit listaUsuariosCircular;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, contactos;

type
  PNodo = ^TNodo;
  TNodo = record
    Datos: TContacto;
    Siguiente: PNodo;
    Anterior: PNodo;
  end;

  TListaUsuariosCircular = class
  private
    Cabeza: PNodo;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Agregar(Contacto: TContacto);
    function ExisteContacto(email: string): Boolean;
    function Primero: PNodo;
  end;

implementation

{ TListaUsuariosCircular }

constructor TListaUsuariosCircular.Create;
begin
  Cabeza := nil;
end;

destructor TListaUsuariosCircular.Destroy;
var
  Aux, Temp: PNodo;
begin
  if Cabeza <> nil then
  begin
    Temp := Cabeza^.Siguiente;
    while Temp <> Cabeza do
    begin
      Aux := Temp;
      Temp := Temp^.Siguiente;
      Dispose(Aux);
    end;
    Dispose(Cabeza);
  end;
  inherited Destroy;
end;

procedure TListaUsuariosCircular.Agregar(Contacto: TContacto);
var
  Nuevo, Ultimo: PNodo;
begin
  New(Nuevo);
  Nuevo^.Datos := Contacto;

  if Cabeza = nil then
  begin
    Cabeza := Nuevo;
    Nuevo^.Siguiente := Cabeza;
    Nuevo^.Anterior := Cabeza;
  end
  else
  begin
    Ultimo := Cabeza^.Anterior;

    Nuevo^.Siguiente := Cabeza;
    Nuevo^.Anterior := Ultimo;

    Ultimo^.Siguiente := Nuevo;
    Cabeza^.Anterior := Nuevo;

  end;
end;

function TListaUsuariosCircular.ExisteContacto(email: string): Boolean;
var
  Temp: PNodo;
begin
  Result := False;

  if Cabeza = nil then
   Exit;

  Temp := Cabeza;
  repeat
    if Temp^.Datos.GetEmail = email then
    begin
      Result := True;
      Exit;
    end;
    Temp := Temp^.Siguiente;
  until Temp = Cabeza;
end;

function TListaUsuariosCircular.Primero: PNodo;
begin
  Result := Cabeza;
end;

end.


