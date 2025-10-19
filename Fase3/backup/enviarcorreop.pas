unit enviarCorreoP;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, globals, colaCorreos, correo, usuario, Dialogs, StdCtrls, Grids;

type

  { TForm13 }

  TForm13 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form13: TForm13;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm13 }

procedure TForm13.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm13.Button1Click(Sender: TObject);
var
  correoEnviado: TCorreo;
  usuarioEnviar: TUsuario;
  i: Integer;
  Nodo: PNodo;
begin
  correoEnviado := usuarioLogeado.GetColaCorreo.Desencolar;
  if (correoEnviado <> nil) then
  begin
   usuarioEnviar := ListaUsuariosGlobal.Logearse(correoEnviado.GetDestinatario);
   correoEnviado.SetEstado('NL');
   usuarioEnviar.GetCorreosRecibidos.AgregarCorreo(correoEnviado);
   //SUMAR CORREOS AL CONTACTO
   ShowMessage('Mensaje Enviado Correctamente')
  end
  else
   ShowMessage('No Quedan Mensajes Por Enviar');

  //Actualizar Tabla
  StringGrid1.ColCount:=3;
  StringGrid1.RowCount:=usuarioLogeado.GetColaCorreo.Count + 1;

  StringGrid1.Cells[0, 0] := 'Asunto';
  StringGrid1.Cells[1, 0] := 'Remitente';
  StringGrid1.Cells[2, 0] := 'Fecha Envio';

  StringGrid1.ColWidths[0] := 135;
  StringGrid1.ColWidths[1] := 135;
  StringGrid1.ColWidths[2] := 160;

  Nodo := usuarioLogeado.GetColaCorreo.GetFrente;
  i := 1;
  while Nodo <> nil do
  begin
    StringGrid1.Cells[0, i] := Nodo^.Correo.GetAsunto;
    StringGrid1.Cells[1, i] := Nodo^.Correo.GetRemitente;
    StringGrid1.Cells[2, i] := Nodo^.Correo.GetFecha;
    Nodo := Nodo^.Siguiente;
    Inc(i);
  end;
end;

procedure TForm13.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

procedure TForm13.FormShow(Sender: TObject);
var
   i: Integer;
   Nodo: PNodo;
begin
  StringGrid1.ColCount:=3;
  StringGrid1.RowCount:=usuarioLogeado.GetColaCorreo.Count + 1;

  StringGrid1.Cells[0, 0] := 'Asunto';
  StringGrid1.Cells[1, 0] := 'Remitente';
  StringGrid1.Cells[2, 0] := 'Fecha Envio';

  StringGrid1.ColWidths[0] := 135;
  StringGrid1.ColWidths[1] := 135;
  StringGrid1.ColWidths[2] := 160;

  Nodo := usuarioLogeado.GetColaCorreo.GetFrente;
  i := 1;
  while Nodo <> nil do
  begin
    StringGrid1.Cells[0, i] := Nodo^.Correo.GetAsunto;
    StringGrid1.Cells[1, i] := Nodo^.Correo.GetRemitente;
    StringGrid1.Cells[2, i] := Nodo^.Correo.GetFecha;
    Nodo := Nodo^.Siguiente;
    Inc(i);
  end;
end;

end.

