unit borradores;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, correo, avlBorradores, verBorrador, globals, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm15 }

  TForm15 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
  private
    procedure llenarPreOrden(nodo: PNodo; var fila: Integer);
    procedure llenarInOrden(nodo: PNodo; var fila: Integer);
    procedure llenarPostOrden(nodo: PNodo; var fila: Integer);
  public

  end;

var
  Form15: TForm15;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm15 }

procedure TForm15.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.show;
end;

procedure TForm15.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount := 3;
  StringGrid1.RowCount := 1;

  StringGrid1.FixedRows := 1;
  StringGrid1.Cells[0, 0] := 'Destinatario';
  StringGrid1.Cells[1, 0] := 'Asunto';
  StringGrid1.Cells[2, 0] := 'Mensaje';

  StringGrid1.ColWidths[0] := 122;
  StringGrid1.ColWidths[1] := 122;
  StringGrid1.ColWidths[2] := 122;
end;

procedure TForm15.llenarPreOrden(nodo: PNodo; var fila: Integer);
begin
  if nodo = nil then
     Exit;

  StringGrid1.Cells[0, fila] := nodo^.Datos.GetDestinatario;
  StringGrid1.Cells[1, fila] := nodo^.Datos.GetAsunto;
  StringGrid1.Cells[2, fila] := nodo^.Datos.GetMensaje;

  StringGrid1.Objects[0, fila] := TObject(nodo^.Datos);

  Inc(fila);

  llenarPreOrden(nodo^.Izquierda, fila);
  llenarPreOrden(nodo^.Derecha, fila);
end;

procedure TForm15.llenarInOrden(nodo: PNodo; var fila: Integer);
begin
  if nodo = nil then
     Exit;

  llenarInOrden(nodo^.Izquierda, fila);

  StringGrid1.Cells[0, fila] := nodo^.Datos.GetDestinatario;
  StringGrid1.Cells[1, fila] := nodo^.Datos.GetAsunto;
  StringGrid1.Cells[2, fila] := nodo^.Datos.GetMensaje;

  StringGrid1.Objects[0, fila] := TObject(nodo^.Datos);

  Inc(fila);

  llenarInOrden(nodo^.Derecha, fila);
end;

procedure TForm15.llenarPostOrden(nodo: PNodo; var fila: Integer);
begin
  if nodo = nil then
     Exit;

  llenarPostOrden(nodo^.Izquierda, fila);
  llenarPostOrden(nodo^.Derecha, fila);

  StringGrid1.Cells[0, fila] := nodo^.Datos.GetDestinatario;
  StringGrid1.Cells[1, fila] := nodo^.Datos.GetAsunto;
  StringGrid1.Cells[2, fila] := nodo^.Datos.GetMensaje;

  StringGrid1.Objects[0, fila] := TObject(nodo^.Datos);

  Inc(fila);

end;

procedure TForm15.FormShow(Sender: TObject);
var
  fila: Integer;
begin

  fila := 1;
  StringGrid1.RowCount := usuarioLogeado.GetAvlBorradores.Count + 1;

  llenarPreOrden(usuarioLogeado.GetAvlBorradores.GetRaiz, fila);

end;

procedure TForm15.StringGrid1Click(Sender: TObject);
begin

end;

procedure TForm15.StringGrid1DblClick(Sender: TObject);
var
  fila: Integer;
  correo: TCorreo;
  ventana: TForm16;
begin
  fila := StringGrid1.Row;
  //CREAR VENTANA VER BORRADOR
  ventana := TForm16.Create(nil);

  correo := TCorreo(StringGrid1.Objects[0, fila]);

  ventana.Memo1.Lines.Text := correo.GetMensaje;
  ventana.Edit1.Text := correo.getDestinatario;
  ventana.Edit2.Text := correo.getAsunto;
  ventana.Label1.Caption := IntToStr(correo.GetId);

  ventana.Show;

  Self.Hide;
end;

procedure TForm15.Button4Click(Sender: TObject);
begin
  Close
end;

procedure TForm15.Button1Click(Sender: TObject);
var
  fila: Integer;
begin

  fila := 1;
  StringGrid1.RowCount := usuarioLogeado.GetAvlBorradores.Count + 1;

  llenarPreOrden(usuarioLogeado.GetAvlBorradores.GetRaiz, fila);

end;

procedure TForm15.Button2Click(Sender: TObject);
var
  fila: Integer;
begin

  fila := 1;
  StringGrid1.RowCount := usuarioLogeado.GetAvlBorradores.Count + 1;

  llenarInOrden(usuarioLogeado.GetAvlBorradores.GetRaiz, fila);

end;

procedure TForm15.Button3Click(Sender: TObject);
var
  fila: Integer;
begin

  fila := 1;
  StringGrid1.RowCount := usuarioLogeado.GetAvlBorradores.Count + 1;

  llenarPostOrden(usuarioLogeado.GetAvlBorradores.GetRaiz, fila);

end;

end.

