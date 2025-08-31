unit menuCrearCuenta;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, usuario, listaUsuarios, globals;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form3: TForm3;

implementation

uses menuInicio;

{$R *.lfm}

{ TForm3 }

procedure TForm3.Button2Click(Sender: TObject);
begin
  Close
end;

procedure TForm3.Button1Click(Sender: TObject);
var
   Usuario: TUsuario;
   id: Integer;
   nombre,user,password,email,telefono: string;
begin
  Randomize;
  id := Random(1000) + 1;
  nombre := Edit1.Text;
  user := Edit2.Text;
  password := Edit3.Text;
  email := Edit4.Text;
  telefono := Edit5.Text;
  if ListaUsuariosGlobal.ExisteId(id) then
     showMessage('Id Existente')
  else
  begin
    Usuario := TUsuario.Create(id,nombre,user,password,email,telefono);
    ListaUsuariosGlobal.Agregar(Usuario);
    Edit1.Text := '';
    Edit2.Text := '';
    Edit3.Text := '';
    Edit4.Text := '';
    Edit5.Text := '';
    showMessage('Usuario Creado Correctamente');
  end;
end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form1.Show;
end;

end.

