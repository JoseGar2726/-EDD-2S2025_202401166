unit usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TUsuario = class
  private
    FID: Integer;
    FNombre: string;
    FUser: string;
    FPassword: string;
    FEmail: string;
    FTelefono: string;
  public
    constructor Create(id: Integer; nombre: string; user: string; password: string; email: string; telefono: string);
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
  end;

implementation
{ TUsuario }

constructor TUsuario.Create(id: Integer; nombre: string; user: string; password: string; email: string; telefono: string);
begin
  FId := id;
  FNombre := nombre;
  FUser := user;
  FPassword := password;
  FEmail := email;
  FTelefono := telefono;
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
procedure TUsuario.SetPAssword(password: string);
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

function TUsuario.GetId: Integer;
begin
  Result := FId;
end;
function TUsuario.GetNombre: string;
begin
  Result := FNOmbre;
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

end.

