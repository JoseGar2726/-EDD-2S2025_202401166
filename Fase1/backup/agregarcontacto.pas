unit agregarContacto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,usuario, contactos, listaUsuariosCircular, listaUsuarios, globals;

type

  { TForm6 }

  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form6: TForm6;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm6 }

procedure TForm6.Button2Click(Sender: TObject);
begin
  Close
end;

procedure TForm6.Button1Click(Sender: TObject);
var
  contactoNuevo: TUsuario;
  contactoN: TContacto;
  id: Integer;
  nombre, password, email, telefono: string;
  user: string;
begin
  if (usuarioLogeado.GetEmail <> Edit1.text) and not (usuarioLogeado.GetContactos.ExisteContacto(Edit1.text)) then
  begin
    contactoNuevo := ListaUsuariosGlobal.Logearse(Edit1.text);
    if contactoNuevo <> nil then
    begin
         id := contactoNuevo.GetId;
         nombre := contactoNuevo.GetNombre;
         password := contactoNuevo.GetPassword;
         email := contactoNuevo.GetEmail;
         telefono := contactoNuevo.GetTelefono;
         contactoN := TContacto.Create(id,nombre,user,password,email,telefono);
         usuarioLogeado.GetContactos.Agregar(contactoN);
         ShowMessage('Contacto Registrado Correctamente');
         Edit1.text := '';
    end
  end
  else
  begin
    ShowMessage('Contacto Ya Registrado');
    Edit1.text := '';
  end
end;

procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

end.

