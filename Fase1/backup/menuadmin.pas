unit menuAdmin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, globals, listaUsuarios, usuario, contactos, listaUsuariosCircular, listaCorreos, pilaPapelera, fpjson, jsonparser, Process;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form2: TForm2;

implementation

uses menuInicio;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button4Click(Sender: TObject);
begin
  Close
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  ruta: string;
  SL: TStringList;
  JSONData: TJSONData;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  i, id: Integer;
  nombre, user, password, email, telefono: string;
  Usuario: TUsuario;
  contactos: TListaUsuariosCircular;
  correosRecibidos: TListaCorreos;
  pilaPapelera: TPilaPapelera;

begin
  //CARGA MASIVA
  SL := TStringList.Create;
  if OpenDialog1.Execute then
  begin
    ruta := OpenDialog1.FileName;
    try
      SL.LoadFromFile(ruta);
      JSONData := GetJSON(SL.Text);

      JSONArray := JSONDATA.GetPath('usuarios') as TJSONArray;
      for i := 0 to JSONArray.Count -1 do
      begin
        JSONObject := JSONArray.Items[i] as TJSONObject;
        id := JSONObject.Get('id', 0);
        nombre := JSONObject.Get('nombre', '');
        user := JSONObject.Get('usuario', '');
        password := JSONObject.Get('password', '');
        email := JSONObject.Get('email', '');
        telefono := JSONObject.Get('telefono', '');
        contactos := TListaUsuariosCircular.Create;
        correosRecibidos := TListaCorreos.Create;
        pilaPapelera := TListaPilaPapelera.Create;

        if (not ListaUsuariosGlobal.ExisteId(id)) and (not ListaUsuariosGlobal.ExisteEmail(email)) then
        begin
           Usuario := TUsuario.Create(id,nombre,user,password,email,telefono,contactos,correosRecibidos, pilaPapelera);

           ListaUsuariosGlobal.Agregar(Usuario);
        end;

      end;
    except
      on E: Exception do
         ShowMessage('Error')
    end;
    ShowMessage('Usuarios Cargados Correctamente')
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  AProcess: TProcess;
begin
  //Graficar - Generar DOT
  ListaUsuariosGlobal.GenerarDOT('graficas/ListaSimpleUsuarios.dot');
  //Graficar - Generar PNG
  if FileExists('/home/JoseEdd/-EDD-2S2025_202401166/Fase1/graficas/ListaSimpleUsuarios.dot') then
  begin
    AProcess := TProcess.Create(nil);
    try
      AProcess.Executable := 'dot';
      AProcess.Parameters.Add('-Tpng');
      AProcess.Parameters.Add('/home/JoseEdd/-EDD-2S2025_202401166/Fase1/graficas/ListaSimpleUsuarios.dot');
      AProcess.Parameters.Add('-o');
      AProcess.Parameters.Add('/home/JoseEdd/-EDD-2S2025_202401166/Fase1/graficas/ListaSimpleUsuarios.png');
      AProcess.Options := [poWaitOnExit];
      AProcess.Execute;
      ShowMessage('Lista de Usuarios Graficada, Imagen Generada en la Carpeta Graficas');
    finally
      AProcess.Free;
    end;
  end
  else
    ShowMessage('Error: el archivo DOT no existe');
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form1.Show;
end;

end.

