unit menuInicio;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, menuAdmin, menuCrearCuenta, listaUsuarios, globals;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
    if (Edit1.Text = 'root') and (Edit2.Text = '1234') then
       begin
            showMessage('Sesion Iniciada Como Admin');
            Form2 := TForm2.Create(nil);
            Form2.Label1.Caption := Edit1.Text;
            Edit1.Text := '';
            Edit2.Text := '';
            Form2.Show;
            Self.Hide;
       end
    else
        begin
             showMessage('Credenciales Incorrectas');
        end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Form3.Show;
   Self.Hide;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ListaUsuariosGlobal := TListaUsuarios.Create;
end;

end.
