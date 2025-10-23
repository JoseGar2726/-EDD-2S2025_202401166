unit privados;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, verPrivado, merkleTree, correo, globals, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm21 }

  TForm21 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
  private

  public

  end;

var
  Form21: TForm21;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm21 }

procedure TForm21.Button1Click(Sender: TObject);
begin
  Close
end;

procedure TForm21.Button2Click(Sender: TObject);
begin

end;

procedure TForm21.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

procedure TForm21.FormCreate(Sender: TObject);
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

procedure TForm21.FormShow(Sender: TObject);
var
  fila: Integer;

  procedure AgregarCorreoNodo(Node: TMerkleNode);
  var
    correo: TCorreo;
  begin
    if Node = nil then Exit;

    if Assigned(Node.Correo) then
    begin
      correo := Node.Correo;
      StringGrid1.RowCount := StringGrid1.RowCount + 1;
      fila := StringGrid1.RowCount - 1;

      StringGrid1.Cells[0, fila] := IntToStr(correo.GetId);
      StringGrid1.Cells[1, fila] := correo.GetAsunto;
      StringGrid1.Cells[2, fila] := correo.GetRemitente;
      StringGrid1.Objects[0, fila] := correo;
    end;

    AgregarCorreoNodo(Node.Left);
    AgregarCorreoNodo(Node.Right);
  end;

begin
  StringGrid1.RowCount := 1;

  if (usuarioLogeado.GettFavoritos <> nil) and (usuarioLogeado.GettFavoritos.GetRoot <> nil) then
  begin
    AgregarCorreoNodo(usuarioLogeado.GettFavoritos.GetRoot);
    Button2.Caption := IntToStr(usuarioLogeado.GettFavoritos.ContarCorreos);
  end
  else
    ShowMessage('No hay correos guardados en el árbol.');
end;

procedure TForm21.StringGrid1DblClick(Sender: TObject);
var
  fila: Integer;
  correo: TCorreo;
  ventana: TForm22;
begin
  fila := StringGrid1.Row;
  if fila > 0 then
  begin
    //CREAR VENTANA VER PRIVADO
    ventana := TForm22.Create(nil);

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

