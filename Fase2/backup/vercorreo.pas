unit verCorreo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, globals, listaCorreos, correo, pilaPapelera, Grids, StdCtrls;

type

  { TForm10 }

  TForm10 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form10: TForm10;

implementation
uses bandejaEntrada;

{$R *.lfm}

{ TForm10 }

procedure TForm10.Button2Click(Sender: TObject);
begin
  Close
end;

procedure TForm10.Button1Click(Sender: TObject);
var
  correoPapelera: TCorreo;
begin
  correoPapelera := usuarioLogeado.GetCorreosRecibidos.Eliminar(StrToInt(Label1.Caption));
  if correoPapelera <> nil then
     begin
      ShowMessage('Mensaje Eliminado Correctamente');
      usuarioLogeado.GetPilaPapelera.Push(correoPapelera);
     end
  else
     ShowMessage('El Mensaje Ya Fue Eliminado')
end;

procedure TForm10.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form9.Show;
end;

end.

