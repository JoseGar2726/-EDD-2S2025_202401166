unit mensajesComunidad;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, bstComunidades, globals, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm19 }

  TForm19 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form19: TForm19;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm19 }

procedure TForm19.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm19.Button1Click(Sender: TObject);
var
 txtComunidadInput_entry, txtMensajeInput_entry: Pchar;
 response: Boolean;
 FechaActual: TDateTime;
 FechaFormateada: string;
begin
 FechaActual := Now;
 FechaFormateada := FormatDateTime('dd-mm-yyyy', FechaActual);
 txtComunidadInput_entry := Pchar(Edit1.Text);
 txtMensajeInput_entry := Pchar(Memo1.Text);

 response := insertEmails(txtComunidadInput_entry, usuarioLogeado.GetEmail, txtMensajeInput_entry, FechaFormateada);

 if response then
  begin
   ShowMessage('La publicacion fue creada exitosamente');
  end
 else
  begin
   ShowMessage('Verifica que el nombre de la comunidad exista');
  end;
end;

procedure TForm19.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

end.

