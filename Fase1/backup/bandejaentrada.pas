unit bandejaEntrada;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, globals, listaCorreos, correo, verCorreo, Graphics, Dialogs, StdCtrls, Grids,
  ComCtrls;

type

  { TForm9 }

  TForm9 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  Form9: TForm9;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm9 }

procedure TForm9.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount := 3;
  StringGrid1.RowCount := 1;

  StringGrid1.FixedRows := 1;
  StringGrid1.Cells[0, 0] := 'Estado';
  StringGrid1.Cells[1, 0] := 'Asunto';
  StringGrid1.Cells[2, 0] := 'Remitente';

  StringGrid1.ColWidths[0] := 109;
  StringGrid1.ColWidths[1] := 109;
  StringGrid1.ColWidths[2] := 109;
end;

procedure TForm9.FormShow(Sender: TObject);
var
  nodo: PNodo;
  fila: Integer;
begin
  Button2.Caption:=IntToStr(usuarioLogeado.GetCorreosRecibidos.ContarCorreos());

  nodo := usuarioLogeado.GetCorreosRecibidos.Primero;
  fila := 1;

  StringGrid1.RowCount := usuarioLogeado.GetCorreosRecibidos.Count + 1;

  while nodo <> nil do
  begin
    StringGrid1.Cells[0, fila] := nodo^.Correo.GetEstado;
    StringGrid1.Cells[1, fila] := nodo^.Correo.GetAsunto;
    StringGrid1.Cells[2, fila] := nodo^.Correo.GetRemitente;

    StringGrid1.Objects[0, fila] := TObject(nodo^.Correo);

    nodo := nodo^.Siguiente;
    Inc(fila);
  end;

end;

procedure TForm9.StringGrid1DblClick(Sender: TObject);
var
  fila: Integer;
  correo: TCorreo;
  ventana: TForm10;
begin
  fila := StringGrid1.Row;
  if fila > 0 then
  begin
    //CREAR VENTANA VER CORREO
    ventana := TForm10.Create(nil);

    ventana.StringGrid1.ColCount := 2;
    ventana.StringGrid1.RowCount := 3;

    correo := TCorreo(StringGrid1.Objects[0, fila]);
    correo.SetEstado('L');
    StringGrid1.Cells[0, fila] := 'L';

    ventana.StringGrid1.Cells[0, 0] := 'Remitente';
    ventana.StringGrid1.Cells[0, 1] := 'Asunto';
    ventana.StringGrid1.Cells[0, 2] := 'Fecha';

    ventana.StringGrid1.Cells[1, 0] := correo.GetRemitente;
    ventana.StringGrid1.Cells[1, 1] := correo.GetAsunto;
    ventana.StringGrid1.Cells[1, 2] := correo.GetFecha;
    ventana.Memo1.Lines.Text := correo.GetMensaje;

    ventana.StringGrid1.ColWidths[0] := 120;
    ventana.StringGrid1.ColWidths[1] := 150;

    ventana.StringGrid1.RowHeights[0] := 37;
    ventana.StringGrid1.RowHeights[1] := 37;
    ventana.StringGrid1.RowHeights[2] := 37;

    ventana.Show;

    Self.Hide;

  end;
end;

procedure TForm9.Button3Click(Sender: TObject);
begin
  Close
end;

procedure TForm9.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

end.

