unit actualizarPerfil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, usuario, globals, listaUsuarios;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm5 }

procedure TForm5.Button2Click(Sender: TObject);
begin
  Close
end;

procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
end;

procedure TForm5.FormShow(Sender: TObject);
var
  actualizarUsuario: TUsuario;
begin
  Edit1.Text:= UsuarioLogeado.GetNombre;
  Edit2.Text:= UsuarioLogeado.GetUser;
  Edit3.Text:= UsuarioLogeado.GetEmail;
  Edit4.Text:= UsuarioLogeado.GetTelefono;

  actualizarUsuario := TUsuario.Create(UsuarioLogeado.GetId,Edit1.Text,Edit2.Text,UsuarioLogeado.GetPassword,Edit3.Text,Edit4.Text);

end;

end.

