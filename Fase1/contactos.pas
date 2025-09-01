unit contactos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  TContacto = class
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

{ TContacto }

constructor TContacto.Create(id: Integer; nombre: string; user: string; password: string; email: string; telefono: string);
begin
  FId := id;
  FNombre := nombre;
  FUser := user;
  FPassword := password;
  FEmail := email;
  FTelefono := telefono;
end;

procedure TContacto.SetId(id: Integer);
begin
  FId := id;
end;
procedure TContacto.SetNombre(nombre: string);
begin
  FNombre := nombre;
end;
procedure TContacto.SetUser(user: string);
begin
  FUser := user;
end;
procedure TContacto.SetPAssword(password: string);
begin
  FPassword := password;
end;
procedure TContacto.SetEmail(email: string);
begin
  FEmail := email;
end;
procedure TContacto.SetTelefono(telefono: string);
begin
  FTelefono := telefono;
end;

function TContacto.GetId: Integer;
begin
  Result := FId;
end;
function TContacto.GetNombre: string;
begin
  Result := FNombre;
end;
function TContacto.GetUser: string;
begin
  Result := FUser;
end;
function TContacto.GetPassword: string;
begin
  Result := FPassword;
end;
function TContacto.GetEmail: string;
begin
  Result := FEmail;
end;
function TContacto.GetTelefono: string;
begin
  Result := FTelefono;
end;

end.

