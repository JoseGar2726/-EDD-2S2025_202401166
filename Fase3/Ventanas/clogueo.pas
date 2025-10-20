unit clogueo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, globals, log;

type

  { TForm20 }

  TForm20 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form20: TForm20;

implementation
uses menuAdmin;

{$R *.lfm}

{ TForm20 }

procedure TForm20.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form2.Show;
end;

procedure TForm20.FormShow(Sender: TObject);
var
  i: Integer;
begin
  StringGrid1.ColWidths[0] := 80;
  StringGrid1.ColWidths[1] := 180;
  StringGrid1.ColWidths[2] := 180;

  StringGrid1.RowCount := 1;
  StringGrid1.ColCount := 3;
  StringGrid1.Cells[0,0] := 'Usuario';
  StringGrid1.Cells[1,0] := 'Entrada';
  StringGrid1.Cells[2,0] := 'Salida';

  for i := 0 to Globals.Logs.Count - 1 do
  begin
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
    StringGrid1.Cells[0, StringGrid1.RowCount-1] := Logs[i].GetUser;
    StringGrid1.Cells[1, StringGrid1.RowCount-1] := Logs[i].GetEntrada;
    StringGrid1.Cells[2, StringGrid1.RowCount-1] := Logs[i].GetSalida;
  end;
end;

procedure TForm20.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm20.Button1Click(Sender: TObject);
var
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  i: Integer;
  carpeta, ruta: string;
  archivo: TStringList;
begin
  JSONArray := TJSONArray.Create;
  try
    for i := 0 to Logs.Count - 1 do
    begin
      JSONObject := TJSONObject.Create;
      JSONObject.Add('usuario', Logs[i].GetUser);
      JSONObject.Add('entrada', Logs[i].GetEntrada);
      JSONObject.Add('salida', Logs[i].GetSalida);
      JSONArray.Add(JSONObject);
    end;

    archivo := TStringList.Create;

    carpeta := ExtractFilePath(ParamStr(0)) + 'Reporte/';
    if not DirectoryExists(carpeta) then
       ForceDirectories(carpeta);

    ruta := carpeta + 'Reporte_Logs.json';

    archivo.Text := JSONArray.AsJSON;
    archivo.SaveToFile(ruta);
    showMessage('Archivo JSON generado en carpeta Reporte en la raiz del proyecto');
  finally
    JSONArray.Free;
  end;
end;

end.

