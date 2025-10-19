unit verBorrador;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, correo, contactos, usuario, globals, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm16 }

  TForm16 = class(TForm)
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
  Form16: TForm16;

implementation
uses borradores;

{$R *.lfm}

{ TForm16 }

procedure TForm16.Button2Click(Sender: TObject);
var
  idBorrador: Integer;
  nuevoBorrador: TCorreo;
begin
  //ACTUALIZAR BORRADOR
  idBorrador := StrToInt(Label1.Caption);
  nuevoBorrador := usuarioLogeado.GetAvlBorradores.Busca(idBorrador);
  nuevoBorrador.SetDestinatario(Edit1.Text);
  nuevoBorrador.SetAsunto(Edit2.Text);
  nuevoBorrador.SetMensaje(Memo1.Lines.Text);
  nuevoBorrador.SetFecha(DateTimeToStr(Now));
  usuarioLogeado.GetAvlBorradores.Editar(nuevoBorrador);
  ShowMessage('El Mensaje Fue Editado');
  Close;
end;

procedure TForm16.Button1Click(Sender: TObject);
var
  idBorrador: Integer;
  nuevoBorrador: TCorreo;
  destinatario: String;
  destinatarioU: TUsuario;
  contactoE: TContacto;
begin
  //ACTUALIZAR BORRADOR Y ENVIAR
  idBorrador := StrToInt(Label1.Caption);
  nuevoBorrador := usuarioLogeado.GetAvlBorradores.Busca(idBorrador);
  nuevoBorrador.SetDestinatario(Edit1.Text);
  nuevoBorrador.SetAsunto(Edit2.Text);
  nuevoBorrador.SetMensaje(Memo1.Lines.Text);
  nuevoBorrador.SetFecha(DateTimeToStr(Now));
  usuarioLogeado.GetAvlBorradores.Editar(nuevoBorrador);

  //ENVIAR
  destinatario := Edit1.Text;
  if usuarioLogeado.GetContactos.ExisteContacto(destinatario) then
     //EnviarCorreo
     begin
        destinatarioU := ListaUsuariosGlobal.Logearse(destinatario);
        destinatarioU.GetCorreosRecibidos.AgregarCorreo(nuevoBorrador);
        contactoE := usuarioLogeado.GetContactos.BuscarPorEmail(destinatario);
        contactoE.SetCorreosEnviados(contactoE.GetCorreosEnviados + 1);
        ShowMessage('Correo Enviado');
        //ELIMINAR DEL ARBOL


        Edit1.Text:= '';
        Edit2.Text:= '';
        Memo1.Text:= '';
        Close;
     end
  else
     ShowMessage('Correo No Enviado (El Contacto No Existe)')
end;

procedure TForm16.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form15.Show;
end;

end.

