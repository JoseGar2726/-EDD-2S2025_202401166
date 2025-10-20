unit log;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  TLog = class
  private
    FUser: string;
    FEntrada: string;
    FSalida: string;
  public
    constructor Create(user: string; entrada: string; salida: string);
    procedure SetUser(user: string);
    function GetUser: string;
    procedure SetEntrada(entrada: string);
    function GetEntrada: string;
    procedure SetSalida(salida: string);
    function GetSalida: string;
  end;

implementation

{ TLog }

constructor TUsuario.Create(user: string; entrada: string; salida: string);
begin
  FUser := user;
  FEntrada := entrada;
  FSalida := salida;
end;

procedure TLog.SetUser(user: string);
begin
  FUser := user;
end;
procedure TLog.SetEntrada(entrada: string);
begin
  FEntrada := entrada;
end;
procedure TLog.SetSalida(salida: string);
begin
  FSalida := salida;
end;

function TLog.GetUser: string;
begin
  Result := FUser;
end;
function TLog.GetEntrada: string;
begin
  Result := FEntrada;
end;
function TLog.GetSalida: string;
begin
  Result := FSalida;
end;

end.
