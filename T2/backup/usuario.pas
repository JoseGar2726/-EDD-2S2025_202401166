unit Usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  { Clase Usuario }
  TUsuario = class
    private
      FId: Integer;
      FNombre: string;
      FApellido: string;
      FEmail: string;
    public
      constructor Create(AId: Integer, ANombre, AApellido, AEmail: string);
      property Id: Integer read FId write FId;
      property Nombre: string read FNombre write FNombre;
      property Apellido: string read FApellido write FApellido;
      property Email: string read FEmail write FEmail;
  end;

implementation

constructor TUsuario.create(AId: Integer, ANombre, AApellido, AEmail: string);
begin
  FId := AId;
  FNombre := ANombre;
  FApellido := AApellido;
  FEmail := AEmail;
end;

end.

