unit programarCorreo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, globals, contactos, correo, listaUsuariosCircular, StdCtrls;

type

  { TForm12 }

  TForm12 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form12: TForm12;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm12 }

procedure TForm12.Button2Click(Sender: TObject);
var
  id: Integer;
  remitente, destinatario, asunto, fecha, mensaje, estado: string;
  correoEnviar: TCorreo;
begin
  destinatario := Edit1.Text;
  asunto := Edit2.Text;
  fecha := Edit3.Text;
  mensaje := Memo1.Text;

  if (usuarioLogeado.GetContactos.ExisteContacto(destinatario)) then
     begin
          Randomize;
          id := Random(10000) + 1;
          remitente := usuarioLogeado.GetEmail;
          estado := 'NL';
          correoEnviar := TCorreo.Create(id,remitente,destinatario,estado,fecha,asunto,mensaje);
          usuarioLogeado.GetColaCorreo.Encolar(correoEnviar);
          ShowMessage('Mensaje Programado Correctamente')
     end
  else
     ShowMessage('Error Al Programar El Mensaje');
end;

procedure TForm12.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

procedure TForm12.FormShow(Sender: TObject);
begin
end;

procedure TForm12.Button1Click(Sender: TObject);
begin
  Close
end;

end.

