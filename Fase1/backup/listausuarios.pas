unit listaUsuarios;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, usuario;

type
  PNodo = ^TNodo;
  TNodo = record
        Datos: TUsuario;
        Siguiente: PNodo;
  end;

  TListaUsuarios = class
  private
    Cabeza: PNodo;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Agregar(Usuario: TUsuario);
    function ExisteId(id: Integer): Boolean;
  end;

implementation

{ TListaUsuarios }

constructor TListaUsuarios.Create;
begin
  Cabeza := nil;
end;

destructor TListaUsuarios.Destroy;
var
   Aux: PNodo;
begin
  while Cabeza <> nil do
  begin
       Aux := Cabeza;
       Cabeza := Cabeza^.Siguiente;
       Aux^.Datos.Free;
       Dispose(Aux);
  end;
  inherited Destroy;
end;

procedure TListaUsuarios.Agregar(Usuario: TUsuario);
var
   Nuevo, Temp: PNodo;
begin
  New(Nuevo);
  Nuevo^.Datos := Usuario;
  Nuevo^.Siguiente := nil;

  if Cabeza = nil then
     Cabeza := Nuevo
  else
  begin
    Temp := Cabeza;
    while Temp^.Siguiente <> nil do
          Temp := Temp^.Siguiente;
    Temp^.Siguiente := Nuevo;
  end;
end;

function TListaUsuarios.ExisteId(id: Integer): Boolean;
var
   Temp: PNodo;
begin
  Result := False;
  Temp := Cabeza;

  while Temp <> nil do
  begin
       if Temp^.Datos.GetId = id then
       begin
         Result := True;
         Exit;
       end;
       Temp := Temp^.Siguiente;
  end;
end;

end.

