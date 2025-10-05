unit verFavoritos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, bFavoritos, verFavorito, correo, globals, Graphics, Dialogs, Grids, StdCtrls;

type

  { TForm17 }

  TForm17 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  Form17: TForm17;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm17 }

procedure TForm17.Button1Click(Sender: TObject);
begin
  Close
end;

procedure TForm17.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

procedure TForm17.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount := 3;
  StringGrid1.RowCount := 1;

  StringGrid1.FixedRows := 1;
  StringGrid1.Cells[0, 0] := 'Id';
  StringGrid1.Cells[1, 0] := 'Asunto';
  StringGrid1.Cells[2, 0] := 'Remitente';

  StringGrid1.ColWidths[0] := 50;
  StringGrid1.ColWidths[1] := 120;
  StringGrid1.ColWidths[2] := 120;
end;

procedure TForm17.FormShow(Sender: TObject);
var
  fila: Integer;

  procedure RecorrerNodo(nodo: PNodoB);
  var
    i: Integer;
  begin
    if nodo = nil then Exit;
    for i := 0 to nodo^.n - 1 do
    begin
      if not nodo^.esHoja then
       RecorrerNodo(nodo^.Hijos[i]);

      StringGrid1.RowCount := StringGrid1.RowCount + 1;
      fila := StringGrid1.RowCount - 1;

      StringGrid1.Cells[0, fila] := IntToStr(nodo^.Datos[i].GetId);
      StringGrid1.Cells[1, fila] := nodo^.Datos[i].GetAsunto;
      StringGrid1.Cells[2, fila] := nodo^.Datos[i].GetRemitente;
      StringGrid1.Objects[0, fila] := TObject(nodo^.Datos[i]);
    end;

    if not nodo^.esHoja then
     RecorrerNodo(nodo^.Hijos[nodo^.n]);
  end;

begin
 StringGrid1.RowCount := 1;
 fila := 1;

 RecorrerNodo(usuarioLogeado.GetbFavoritos.GetRaiz);
 Button2.Caption := IntToStr(usuarioLogeado.GetbFavoritos.ContarCorreos);
end;

procedure TForm17.StringGrid1DblClick(Sender: TObject);
var
  fila: Integer;
  correo: TCorreo;
  ventana: TForm18;
begin
  fila := StringGrid1.Row;
  if fila > 0 then
  begin
    //CREAR VENTANA VER FAVORITO
    ventana := TForm18.Create(nil);

    ventana.StringGrid1.ColCount := 2;
    ventana.StringGrid1.RowCount := 4;

    correo := TCorreo(StringGrid1.Objects[0, fila]);

    ventana.StringGrid1.Cells[0, 0] := 'Remitente';
    ventana.StringGrid1.Cells[0, 1] := 'Asunto';
    ventana.StringGrid1.Cells[0, 2] := 'Fecha';
    ventana.StringGrid1.Cells[0, 3] := 'Mensaje';

    ventana.StringGrid1.Cells[1, 0] := correo.GetRemitente;
    ventana.StringGrid1.Cells[1, 1] := correo.GetAsunto;
    ventana.StringGrid1.Cells[1, 2] := correo.GetFecha;
    ventana.StringGrid1.Cells[1, 3] := correo.GetMensaje;
    ventana.Label1.Caption := IntToStr(correo.GetId);

    ventana.StringGrid1.ColWidths[0] := 120;
    ventana.StringGrid1.ColWidths[1] := 180;

    ventana.StringGrid1.RowHeights[0] := 60;
    ventana.StringGrid1.RowHeights[1] := 60;
    ventana.StringGrid1.RowHeights[2] := 60;
    ventana.StringGrid1.RowHeights[3] := 130;

    ventana.Show;

    Self.Hide;

  end;
end;

end.

