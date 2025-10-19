unit papelera;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, globals, pilaPapelera, Dialogs, StdCtrls, ComCtrls,
  Grids;

type

  { TForm11 }

  TForm11 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form11: TForm11;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm11 }

procedure TForm11.Button3Click(Sender: TObject);
begin
  Close
end;

procedure TForm11.Button2Click(Sender: TObject);
var
  i: Integer;
  Nodo: PNodo;
begin
  if (usuarioLogeado.GetPilaPapelera.Pop <> nil) then
   begin
    StringGrid1.ColCount := 3;
    StringGrid1.RowCount := usuarioLogeado.GetPilaPapelera.Count + 1;

    StringGrid1.Cells[0, 0] := 'Asunto';
    StringGrid1.Cells[1, 0] := 'Remitente';
    StringGrid1.Cells[2, 0] := 'Mensaje';


    ShowMessage('Mensaje Eliminado');
    Nodo := usuarioLogeado.GetPilaPapelera.GetTope;
    i := 1;
    while Nodo <> nil do
    begin
      StringGrid1.Cells[0, i] := Nodo^.Correo.GetAsunto;
      StringGrid1.Cells[1, i] := Nodo^.Correo.GetRemitente;
      StringGrid1.Cells[2, i] := Nodo^.Correo.GetMensaje;
      Nodo := Nodo^.Siguiente;
      Inc(i);
    end;
   end
  else
   ShowMessage('No Hay Mensajes a Eliminar');
end;

procedure TForm11.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

procedure TForm11.FormShow(Sender: TObject);
var
  i: Integer;
  Nodo: PNodo;
begin
  StringGrid1.ColCount:=3;
  StringGrid1.RowCount:=usuarioLogeado.GetPilaPapelera.Count + 1;

  StringGrid1.Cells[0, 0] := 'Asunto';
  StringGrid1.Cells[1, 0] := 'Remitente';
  StringGrid1.Cells[2, 0] := 'Mensaje';

  StringGrid1.ColWidths[0] := 83;
  StringGrid1.ColWidths[1] := 83;
  StringGrid1.ColWidths[2] := 200;

  Nodo := usuarioLogeado.GetPilaPapelera.GetTope;
  i := 1;
  while Nodo <> nil do
  begin
    StringGrid1.Cells[0, i] := Nodo^.Correo.GetAsunto;
    StringGrid1.Cells[1, i] := Nodo^.Correo.GetRemitente;
    StringGrid1.Cells[2, i] := Nodo^.Correo.GetMensaje;
    Nodo := Nodo^.Siguiente;
    Inc(i);
  end;

end;

end.

