unit correos;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils;

type
  {Clase Correos}
  TCorreo = class
    private
      FIdUser: string;
      FId: string
      FRemitente: string;
      FEstado: string;
      FProgramado: string;
      FAsunto: string;
      FFecha: string;
      FMensaje: string;
    public
      constructor Create(const AIdUser, AId, ARemitente, AEstado, AProgramado, AAsunto, AFecha, AMensaje: string);
      property IdUser: string read FIdUser write FIdUser;
      property Id: string read FId write FId;
      property Remitente: string read FRemitente write FRemitente;
      property Estado: string read FEstado write FEstado;
      property Programado: string read FProgramado write FProgramado;
      property Asunto: string read FAsunto write FAsunto;
      property Fecha: string read FFecha write FFecha;
      property Mensaje: string read FMensaje write FMensaje;
  end;

implementation

constructor TCorreo.Create(const AIdUser, AId, ARemitente, AEstado, AProgramado, AAsunto, AFecha, AMensaje: string);
begin
  FIdUser := AIdUser;
  FId := AId;
  FRemitente := ARemitente;
  FEstado := AEstado;
  FProgramado := AProgramado;
  FAsunto := AAsunto;
  FFecha := AFecha;
  FMensaje := AMensaje;
end;

end.

