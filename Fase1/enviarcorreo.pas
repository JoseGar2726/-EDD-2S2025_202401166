unit enviarCorreo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, usuario, contactos, correo, listaUsuariosCircular, globals, StdCtrls;

type

  { TForm8 }

  TForm8 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form8: TForm8;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm8 }

procedure TForm8.Button2Click(Sender: TObject);
begin
  Close
end;

procedure TForm8.Button1Click(Sender: TObject);
var
  destinatario,remitente,asunto,mensaje, estado, fecha, programado: string;
  destinatarioU: TUsuario;
  id: Integer;
  fechaActual: TDateTime;
  correoEnviar: TCorreo;
  contactoE: TContacto;
begin
  destinatario := Edit1.Text;
  if usuarioLogeado.GetContactos.ExisteContacto(destinatario) then
     //EnviarCorreo
     begin
        destinatarioU := ListaUsuariosGlobal.Logearse(destinatario);
        Randomize;
        id := Random(10000) + 1;
        remitente := usuarioLogeado.GetEmail;
        destinatario := Edit1.Text;
        estado := 'NL';
        programado := 'No';
        fechaActual := Now;
        fecha := FormatDateTime('dd/mm/yyyy hh:nn:ss', fechaActual);
        asunto := Edit2.Text;
        mensaje := Memo1.Text;
        contactoE := usuarioLogeado.GetContactos.BuscarPorEmail(destinatario);
        correoEnviar := TCorreo.Create(id,remitente,destinatario,estado,fecha,asunto,mensaje,programado);
        destinatarioU.GetCorreosRecibidos.AgregarCorreo(correoEnviar);
        contactoE.SetCorreosEnviados(contactoE.GetCorreosEnviados + 1);
        ShowMessage('Correo Enviado');
        Edit1.Text:= '';
        Edit2.Text:= '';
        Memo1.Text:= '';
     end
  else
     ShowMessage('Correo No Enviado')
end;

procedure TForm8.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

end.

