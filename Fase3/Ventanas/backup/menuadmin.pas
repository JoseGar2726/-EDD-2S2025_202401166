unit menuAdmin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, globals, crearComunidadad, relaciones, listaUsuarios, usuario, contactos, listaUsuariosCircular, listaCorreos, pilaPapelera, colaCorreos, avlBorradores, bFavoritos, correo, clogueo, merkleTree, fpjson, jsonparser, Process, grafoContactos;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
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

procedure TForm2.Button5Click(Sender: TObject);
begin
  Form14 := TForm14.Create(nil);
  Form14.Show;

  Self.Hide;
end;

procedure TForm2.Button6Click(Sender: TObject);
var
  ruta: string;
  SL: TStringList;
  JSONData: TJSONData;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  i, id, correosEnviados: Integer;
  remitente, destinatario, nombre, user, password, email, telefono, estado, asunto, mensaje, fecha, programado: string;
  receptor, emisor: TUsuario;
  Correo: TCorreo;
  contactoN, contactoE: TContacto;

begin
  //CARGA MASIVA CORREOS
  SL := TStringList.Create;
  if OpenDialog1.Execute then
  begin
    ruta := OpenDialog1.FileName;
    try
      SL.LoadFromFile(ruta);
      JSONData := GetJSON(SL.Text);

      JSONArray := JSONDATA.GetPath('correos') as TJSONArray;
      for i := 0 to JSONArray.Count -1 do
      begin
        JSONObject := JSONArray.Items[i] as TJSONObject;
        id := JSONObject.Get('id', 0);
        remitente := JSONObject.Get('remitente', '');
        destinatario := JSONObject.Get('destinatario', '');
        estado := JSONObject.Get('estado', '');
        asunto := JSONObject.Get('asunto', '');
        mensaje := JSONObject.Get('mensaje', '');
        fecha := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
        programado := 'No';

        if (ListaUsuariosGlobal.ExisteEmail(remitente)) and (ListaUsuariosGlobal.ExisteEmail(destinatario)) then
        begin
           Correo := TCorreo.Create(id,remitente,destinatario,estado,fecha,asunto,mensaje,programado);

           receptor := ListaUsuariosGlobal.Logearse(destinatario);
           //CONTACTO RECEPTOR
           id := receptor.GetId;
           nombre := receptor.GetNombre;
           user := receptor.GetUser;
           password := receptor.GetPassword;
           email := receptor.GetEmail;
           telefono := receptor.GetTelefono;
           correosEnviados := 0;
           contactoN := TContacto.Create(id,nombre,user,password,email,telefono,correosEnviados);

           emisor := ListaUsuariosGlobal.Logearse(remitente);

           if not emisor.GetContactos.ExisteContacto(contactoN.GetEmail) then
              emisor.GetContactos.Agregar(contactoN);
           receptor.GetCorreosRecibidos.AgregarCorreo(Correo);

           //SUMAR CORREOS
           contactoE := emisor.GetContactos.BuscarPorEmail(contactoN.GetEmail);
           contactoE.SetCorreosEnviados(contactoE.GetCorreosEnviados + 1);
        end;

      end;
    except
      on E: Exception do
         ShowMessage('Error')
    end;
    ShowMessage('Correos Cargados Correctamente')
  end;

end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  Form20 := TForm20.Create(nil);
  Form20.Show;

  Self.Hide;
end;

procedure TForm2.Button8Click(Sender: TObject);
var
  ruta: string;
  SL: TStringList;
  JSONData: TJSONData;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  ContactosArray: TJSONArray;
  i, j, idC, correosEnviadosC: Integer;
  usuarioActual, contactoActual: TUsuario;
  usuario, contacto: string;
  nombreC, userC, passwordC, emailC, telefonoC: string;
  nuevoContacto: TContacto;

begin
  //CARGA MASIVA
  SL := TStringList.Create;
  if OpenDialog1.Execute then
  begin
    ruta := OpenDialog1.FileName;
    try
      SL.LoadFromFile(ruta);
      JSONData := GetJSON(SL.Text);

      JSONArray := JSONDATA.GetPath('Usuarios') as TJSONArray;
      for i := 0 to JSONArray.Count -1 do
      begin
        JSONObject := TJSONObject(JSONArray.Items[i]);
        usuario := JSONObject.Strings['Usuario'];
        UsuarioActual := ListaUsuariosGlobal.LogearseUsuario(usuario);
        if usuarioActual <> nil then
        begin
          //LEER CONTACTOS Y AGREGAR
          ContactosArray := JSONObject.Arrays['Contactos'];
          for j := 0 to ContactosArray.Count - 1 do
          begin
            contacto := ContactosArray.Items[j].AsString;
            contactoActual := ListaUsuariosGlobal.LogearseUsuario(contacto);
            if (contactoActual <> nil) and (not usuarioActual.GetContactos.ExisteContacto(contactoActual.GetEmail)) then
            begin
              idC := contactoActual.GetId;
              nombreC := contactoActual.GetNombre;
              userC := contactoActual.GetUser;
              passwordC := contactoActual.GetPassword;
              emailC := contactoActual.GetEmail;
              telefonoC := contactoACtual.GetTelefono;
              correosEnviadosC := 0;
              nuevoContacto := TContacto.Create(idC, nombreC, userC, passwordC, emailC, telefonoC, correosEnviadosC);
              usuarioActual.GetContactos.Agregar(nuevoContacto);
            end;
          end;
        end;
      end;
      ShowMessage('Contactos añadidos correctamente');
    finally
      SL.Free;
    end;
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  ruta: string;
  SL: TStringList;
  JSONData: TJSONData;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  i, id, edad: Integer;
  nombre, user, password, email, telefono: string;
  Usuario: TUsuario;
  contactos: TListaUsuariosCircular;
  correosRecibidos: TListaCorreos;
  pilaPapelera: TPilaPapelera;
  colaCorreo: TColaCorreos;
  avlBorradores: TAvlBorradores;
  favoritos: TbFavoritos;
  tFavoritos: TMerkleTree;

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
        pilaPapelera := TPilaPapelera.Create;
        colaCorreo := TColaCorreos.Create;
        avlBorradores := TAvlBorradores.Create;
        favoritos := TbFavoritos.Create;
        tFavoritos := TMerkleTree.Create;

        if (not ListaUsuariosGlobal.ExisteId(id)) and (not ListaUsuariosGlobal.ExisteEmail(email)) then
        begin
           Usuario := TUsuario.Create(id,nombre,user,password,email,telefono,contactos,correosRecibidos, pilaPapelera, colaCorreo, avlBorradores, favoritos, tFavoritos);

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

procedure TForm2.Button2Click(Sender: TObject);
var
  AProcess: TProcess;
  usuarioActual: PnodoUsuario;
  contactoActual: PNodoContacto;
  matriz: TRelaciones;
begin
  //MatrizDispersa
  matriz := TRelaciones.Create;
  usuarioActual := ListaUsuariosGlobal.GetCabeza;
  while usuarioActual <> nil do
  begin
    contactoActual := usuarioActual^.Datos.GetContactos.Primero;
    if contactoActual <> nil then
    begin
      repeat
        matriz.Insertar(usuarioActual^.Datos.GetNombre, contactoActual^.Datos.GetNombre, contactoActual^.Datos.GetCorreosEnviados);
        contactoActual := contactoActual^.Siguiente;
      until contactoActual = usuarioActual^.Datos.GetContactos.Primero;
    end;

    usuarioActual := usuarioActual^.Siguiente;
  end;
  matriz.GenerarDOT('Reporte/Relaciones.dot');

  //GENERAR PNG
  if FileExists('/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase3/Reporte/Relaciones.dot') then
  begin
    AProcess := TProcess.Create(nil);
    try
      AProcess.Executable := 'dot';
      AProcess.Parameters.Add('-Tpng');
      AProcess.Parameters.Add('/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase3/Reporte/Relaciones.dot');
      AProcess.Parameters.Add('-o');
      AProcess.Parameters.Add('/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase3/Reporte/Relaciones.png');
      AProcess.Options := [poWaitOnExit];
      AProcess.Execute;
      ShowMessage('Imagen Generada en la Carpeta Reporte');
    finally
      AProcess.Free;
    end;
  end
  else
    ShowMessage('Error: el archivo DOT no existe');


end;

procedure TForm2.Button3Click(Sender: TObject);
var
  AProcess: TProcess;
  usuarioActual: PnodoUsuario;
  contactoActual: PNodoContacto;
  GrafoContactos: TGrafoContactos;
  idUsuario, idContacto: Integer;
begin
  ForceDirectories('Reporte');
  //Graficar - Generar DOT
  ListaUsuariosGlobal.GenerarDOT('Reporte/ListaSimpleUsuarios.dot');
  //Graficar - Generar PNG
  if FileExists('/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase3/Reporte/ListaSimpleUsuarios.dot') then
  begin
    AProcess := TProcess.Create(nil);
    try
      AProcess.Executable := 'dot';
      AProcess.Parameters.Add('-Tpng');
      AProcess.Parameters.Add('/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase3/Reporte/ListaSimpleUsuarios.dot');
      AProcess.Parameters.Add('-o');
      AProcess.Parameters.Add('/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase3/Reporte/ListaSimpleUsuarios.png');
      AProcess.Options := [poWaitOnExit];
      AProcess.Execute;
      ShowMessage('Lista de Usuarios Graficada, Imagen Generada en la Carpeta Reporte');
    finally
      AProcess.Free;
    end;
  end
  else
    ShowMessage('Error: el archivo DOT no existe');

  //REPORTE CONTACTOS
  GrafoContactos := TGrafoContactos.Create;
  try
    usuarioActual := ListaUsuariosGlobal.GetCabeza;
    while usuarioActual <> nil do
    begin

      idUsuario := usuarioActual^.Datos.GetId;
      GrafoContactos.AgregarNodo(idUsuario, usuarioActual^.Datos.GetUser);

      if usuarioActual^.Datos.GetContactos.Primero <> nil then
      begin
        contactoActual := usuarioActual^.Datos.GetContactos.Primero;
        repeat
          idContacto := contactoActual^.Datos.GetId;

          GrafoContactos.AgregarNodo(idContacto, contactoActual^.Datos.GetUser);

          GrafoContactos.ConectarNodos(idUsuario, idContacto);

          contactoActual := contactoActual^.siguiente;
        until contactoActual = usuarioActual^.Datos.GetContactos.Primero;
      end;

      usuarioActual := usuarioActual^.siguiente;
    end;
  finally
  end;

  //GRAFICAR
  //Graficar - Generar DOT
  grafoContactos.GenerarDOT('Reporte/GrafoContactos.dot');
  //Graficar - Generar PNG
  if FileExists('/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase3/Reporte/GrafoContactos.dot') then
  begin
    AProcess := TProcess.Create(nil);
    try
      AProcess.Executable := 'dot';
      AProcess.Parameters.Add('-Tpng');
      AProcess.Parameters.Add('/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase3/Reporte/GrafoContactos.dot');
      AProcess.Parameters.Add('-o');
      AProcess.Parameters.Add('/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase3/Reporte/GrafoContactos.png');
      AProcess.Options := [poWaitOnExit];
      AProcess.Execute;
      ShowMessage('Grafo de Contactos Graficado, Imagen Generada en la Carpeta Reporte');
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

