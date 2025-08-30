unit menu;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, usuarios, listaUsuarios, fpjson, jsonparser, Process, correos, listaCorreos;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
  if OpenDialog1.Execute then
  begin
    Edit1.Text:=OpenDialog1.FileName;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog2.Execute then
  begin
    Edit2.text:=OpenDialog2.FileName;
  end;
end;

var
    JSONData, JSONDataCorreos: TJSONData;
    JSONArray, JSONArrayCorreos, BandejaArray: TJSONArray;
    JSONObject, JSONObjectCorreos, CorreoObj: TJSONObject;
    i, j: Integer;
    id: Integer;
    Archivo: string;
    nombre, usuario, password, email, telefono: string;
    SL, SLCorreos: TStringList;
    Lista: TListaUsuarios;
    NuevoCorreo: TCorreo;
    UsuarioId: string;
    ListaCorreosS: TListaCorreos;

procedure TForm1.Button3Click(Sender: TObject);
begin
  //LEER RUTA1
  Lista := TListaUsuarios.Create;
  ListaCorreosS := TListaCorreos.Create;
  begin
    //LEER RUTA1
    Archivo := Edit1.text;
    SL := TStringList.Create;
    try
      SL.LoadFromFile(Archivo);
      JSONData := GetJSON(SL.Text);

      JSONArray := JSONDATA.GetPath('usuarios') as TJSONArray;

      for i := 0 to JSONArray.Count -1 do
      begin
        JSONObject := JSONArray.Items[i] as TJSONObject;
        id := JSONObject.Get('id', 0);
        nombre := JSONObject.Get('nombre', '');
        usuario := JSONObject.Get('usuario', '');
        password := JSONObject.Get('password', '');
        email := JSONObject.Get('email', '');
        telefono := JSONObject.Get('telefono', '');

        Lista.Agregar(IntToStr(id), nombre, usuario, password, email, telefono);

      end;
    except
      on E: Exception do
         ShowMessage('Error')
    end;
    Lista.GenerarDOT('ListaUsuarios.dot');
    if FileExists('ListaUsuarios.dot') then
       begin
            ExecuteProcess('dot', ['-Tpng', 'ListaUsuarios.dot', '-o', 'ListaUsuarios.png']);
            end
    else
        ShowMessage('Error');

    ShowMessage('Lista de Usuarios Graficada');

  //LEER RUTA2
  SLCorreos := TStringList.Create;
    try
      SLCorreos.LoadFromFile(Edit2.Text);
      JSONDataCorreos := GetJSON(SLCorreos.Text);

      JSONArrayCorreos := JSONDataCorreos.GetPath('correos') as TJSONArray;

      for i := 0 to JSONArrayCorreos.Count - 1 do
      begin
        JSONObjectCorreos := JSONArrayCorreos.Items[i] as TJSONObject;
        UsuarioId := JSONObjectCorreos.Get('usuario_id', 0).ToString;

        BandejaArray := JSONObjectCorreos.GetPath('bandeja_entrada') as TJSONArray;

        for j := 0 to BandejaArray.Count - 1 do
        begin
          correoObj := BandejaArray.Items[j] as TJSONObject;

          NuevoCorreo := TCorreo.Create(
                      UsuarioId,
                      CorreoObj.Get('id', 0).ToString,
                      CorreoObj.Get('remitente', ''),
                      CorreoObj.Get('estado', ''),
                      CorreoObj.Get('programado', ''),
                      CorreoObj.Get('asunto', ''),
                      CorreoObj.Get('fecha', ''),
                      CorreoObj.Get('mensaje', '')
          );
          ListaCorreosS.Agregar(NuevoCorreo);
        end;
      end;
    finally
      SLCorreos.Free;
      JSONDataCorreos.Free;
    end;
    ListaCorreosS.generarDOTCorreos(Lista,'ListaCorreos.dot');
  end;

end;


end.

