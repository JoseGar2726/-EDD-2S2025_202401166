unit usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, listaUsuariosCircular, listaCorreos, pilaPapelera;

type

  TUsuario = class
  private
    FID: Integer;
    FNombre: string;
    FUser: string;
    FPassword: string;
    FEmail: string;
    FTelefono: string;
    FContactos: TListaUsuariosCircular;
    FCorreosRecibidos: TListaCorreos;
    FPilaPapelera: TPilaPapelera;
  public
    constructor Create(id: Integer; nombre: string; user: string; password: string; email: string; telefono: string; contactos: TListaUsuariosCircular; correosRecibidos: TListaCorreos; pilaPapelera: TPilaPapelera);
    procedure SetId(id: Integer);
    function GetId: Integer;
    procedure SetNombre(nombre: string);
    function GetNombre: string;
    procedure SetUser(user: string);
    function GetUser: string;
    procedure SetPassword(password: string);
    function GetPassword: string;
    procedure SetEmail(email: string);
    function GetEmail: string;
    procedure SetTelefono(telefono: string);
    function GetTelefono: string;
    procedure SetContactos(contactos: TListaUsuariosCircular);
    function GetContactos: TListaUsuariosCircular;
    procedure SetCorreosRecibidos(correosRecibidos: TListaCorreos);
    function GetCorreosRecibidos: TListaCorreos;
    procedure SetPilaPapelera(pilaPapelera: TPilaPapelera);
    function GetPilaPapelera: TPilaPapelera;
  end;

implementation

{ TUsuario }

constructor TUsuario.Create(id: Integer; nombre: string; user: string; password: string; email: string; telefono: string; contactos: TListaUsuariosCircular; correosRecibidos: TListaCorreos; pilaPapelera: TPilaPapelera);
begin
  FId := id;
  FNombre := nombre;
  FUser := user;
  FPassword := password;
  FEmail := email;
  FTelefono := telefono;
  FContactos := contactos;
  FCorreosRecibidos := correosRecibidos;
  FPilaPapelera := pilaPapelera;
end;

procedure TUsuario.SetId(id: Integer);
begin
  FId := id;
end;
procedure TUsuario.SetNombre(nombre: string);
begin
  FNombre := nombre;
end;
procedure TUsuario.SetUser(user: string);
begin
  FUser := user;
end;
procedure TUsuario.SetPassword(password: string);
begin
  FPassword := password;
end;
procedure TUsuario.SetEmail(email: string);
begin
  FEmail := email;
end;
procedure TUsuario.SetTelefono(telefono: string);
begin
  FTelefono := telefono;
end;
procedure TUsuario.SetContactos(contactos: TListaUsuariosCircular);
begin
  FContactos := contactos;
end;
procedure TUsuario.SetCorreosRecibidos(correosRecibidos: TListaCorreos);
begin
  FCorreosRecibidos := correosRecibidos;
end;
procedure TUsuario.SetPilaPapelera(pilaPapelera: TPilaPapelera);
begin
  FPilaPapelera := pilaPapelera;
end;

function TUsuario.GetId: Integer;
begin
  Result := FId;
end;
function TUsuario.GetNombre: string;
begin
  Result := FNombre;
end;
function TUsuario.GetUser: string;
begin
  Result := FUser;
end;
function TUsuario.GetPassword: string;
begin
  Result := FPassword;
end;
function TUsuario.GetEmail: string;
begin
  Result := FEmail;
end;
function TUsuario.GetTelefono: string;
begin
  Result := FTelefono;
end;
function TUsuario.GetContactos: TListaUsuariosCircular;
begin
  Result := FContactos;
end;
function TUsuario.GetCorreosRecibidos: TListaCorreos;
begin
  Result := FCorreosRecibidos;
end;
function TUsuario.GetPilaPapelera: TPilaPapelera;
begin
  Result := FPilaPapelera;
end;

end.

