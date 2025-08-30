unit usuarios;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils;

type
  {Clase Usuario}
  TUsuario = class
    private
      FId: string;
      FNombre: string;
      FUsuario: string;
      FPassword: string;
      FEmail: string;
      FTelefono: string;
    public
      constructor Create(const AId, ANombre, AUsuario, APassword, AEmail, ATelefono: string);
      property Id: string read FId write FId;
      property Nombre: string read FNombre write FId;
      property Usuario: string read FUsuario write FId;
      property Password: string read FPassword write FId;
      property Email: string read FEmail write FId;
      property Telefono: string read FTelefono write FId;
  end;

implementation

constructor TUsuario.Create(const AId, ANombre, AUsuario, APassword, AEmail, ATelefono: string);
begin
  FId := AId;
  FNombre := ANombre;
  FUsuario := AUsuario;
  FPassword := APassword;
  FEmail := AEmail;
  FTelefono := ATelefono;
end;

end.
