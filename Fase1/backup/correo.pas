unit correo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  TCorreo = class
  private
    FID: Integer;
    FRemitente: string;
    FDestinatario: string;
    FEstado: string;
    FFecha: string;
    FAsunto: string;
    FMensaje: string;
    FProgramado: string;
  public
    constructor Create(id: Integer; remitente: string; destinatario: string; estado: string; fecha: string; asunto: string; mensaje: string; programado: string);
    procedure SetId(id: Integer);
    function GetId: Integer;
    procedure SetRemitente(remitente: string);
    function GetRemitente: string;
    procedure SetDestinatario(destinatario: string);
    function GetDestinatario: string;
    procedure SetEstado(estado: string);
    function GetEstado: string;
    procedure SetFecha(fecha: string);
    function GetFecha: string;
    procedure SetAsunto(asunto: string);
    function GetAsunto: string;
    procedure SetMensaje(mensaje: string);
    function GetMensaje: string;
    procedure SetProgramado(mensaje: string);
    function GetProgramado: string;
  end;

implementation

{ TCorreo }

constructor TCorreo.Create(id: Integer; remitente: string; destinatario: string; estado: string; fecha: string; asunto: string; mensaje: string; programado: string);
begin
  FId := id;
  FRemitente := remitente;
  FDestinatario := destinatario;
  FEstado := estado;
  FFecha := fecha;
  FAsunto := asunto;
  FMensaje := mensaje;
  FProgramado := programado;
end;

procedure TCorreo.SetId(id: Integer);
begin
  FId := id;
end;
procedure TCorreo.SetRemitente(remitente: string);
begin
  FRemitente := remitente;
end;
procedure TCorreo.SetDestinatario(destinatario: string);
begin
  FDestinatario := destinatario;
end;
procedure TCorreo.SetEstado(estado: string);
begin
  FEstado := estado;
end;
procedure TCorreo.SetFecha(fecha: string);
begin
  FFecha := fecha;
end;
procedure TCorreo.SetAsunto(asunto: string);
begin
  FAsunto := asunto;
end;
procedure TCorreo.SetMensaje(mensaje: string);
begin
  FMensaje := mensaje;
end;
procedure TCorreo.SetProgramado(programado: string);
begin
  FProgramado := programado;
end;

function TCorreo.GetId: Integer;
begin
  Result := FId;
end;
function TCorreo.GetRemitente: string;
begin
  Result := FRemitente;
end;
function TCorreo.GetDestinatario: string;
begin
  Result := FDestinatario;
end;
function TCorreo.GetEstado: string;
begin
  Result := FEstado;
end;
function TCorreo.GetFecha: string;
begin
  Result := FFecha;
end;
function TCorreo.GetAsunto: string;
begin
  Result := FAsunto;
end;
function TCorreo.GetMensaje: string;
begin
  Result := FMensaje;
end;
function TCorreo.GetProgramado: string;
begin
  Result := FProgramado;
end;

end.
