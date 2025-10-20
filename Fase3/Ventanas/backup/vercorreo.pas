unit verCorreo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Generics.Collections, Controls, Graphics, Dialogs, globals, bFavoritos, listaCorreos, correo, pilaPapelera, Grids, StdCtrls;

type

  { TForm10 }

  TForm10 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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

procedure TForm10.Button3Click(Sender: TObject);
var
  correoFavorito: TCorreo;
begin
  correoFavorito := usuarioLogeado.GetCorreosRecibidos.Buscar(StrToInt(Label1.Caption));
  if correoFavorito <> nil then
  begin
     if usuarioLogeado.GetbFavoritos.Buscar(correoFavorito.GetId) <> nil then
        ShowMessage('Mensaje Ya Fue Añadido a la Lista de Favoritos')
     else
     begin
        usuarioLogeado.GetbFavoritos.Insertar(correoFavorito);
        usuarioLogeado.GettFavoritos.AgregarCorreo(correoFavorito);
        ShowMessage('Mensaje Añadido a la Lista de Favoritos');
     end;
  end
  else
     ShowMessage('El Mensaje No Existe');
end;

procedure TForm10.Button4Click(Sender: TObject);
var
  idCorreo: Integer;
  correoDescargar: TCorreo;
  diccionario: specialize TDictionary<string, Integer>;
  salida: specialize TList<Integer>;
  mensaje, nombreReporte, usuarioReporte, direccion: string;
  s, c, sc: string;
  codigo, i: Integer;
  carpeta: string;
begin
  //Crear Carpeta
  nombreReporte := usuarioLogeado.GetNombre;
  usuarioReporte := usuarioLogeado.GetUser;
  direccion := nombreReporte + ' - ' + usuarioReporte + ' - ' + 'Reportes';
  ForceDirectories(direccion);
  carpeta := '/CorreosDescargados';
  direccion := direccion + carpeta;
  ForceDirectories(direccion);


  idCorreo := StrToInt(Label1.Caption);
  correoDescargar := usuarioLogeado.GetCorreosRecibidos.Buscar(idCorreo);

  mensaje := correoDescargar.GetMensaje;

  diccionario := specialize TDictionary<string, Integer>.Create;
  salida := specialize TList<Integer>.Create;
  try
    for i := 0 to 255 do
      diccionario.Add(Char(i), i);

    codigo := 256;
    s := '';

    for i := 1 to Length(mensaje) do
    begin
      c := mensaje[i];
      sc := s + c;

      if diccionario.ContainsKey(sc) then
        s := sc
      else
      begin
        if s <> '' then
          salida.Add(diccionario[s]);

        diccionario.Add(sc, codigo);
        Inc(codigo);
        s := c;
      end;
    end;

    if s <> '' then
      salida.Add(diccionario[s]);

    // Guardar en archivo
    with TStringList.Create do
    try
      for i := 0 to salida.Count - 1 do
        Add(IntToStr(salida[i]));
      SaveToFile(direccion + '/Correo_' + IntToStr(correoDescargar.GetId) + '.txt');
    finally
      Free;
    end;

    ShowMessage('Correo comprimido guardado correctamente');

  finally
    diccionario.Free;
    salida.Free;
  end;
end;

procedure TForm10.Button1Click(Sender: TObject);
var
  correoPapelera: TCorreo;
  idCorreo: Integer;
begin
  idCorreo := StrToInt(Label1.Caption);
  if usuarioLogeado.GetbFavoritos.Buscar(idCorreo) <> nil then
  begin
    usuarioLogeado.GetbFavoritos.Eliminar(idCorreo);
    ShowMessage('Correo eliminado de Favoritos');
  end;
  correoPapelera := usuarioLogeado.GetCorreosRecibidos.Eliminar(StrToInt(Label1.Caption));
  if correoPapelera <> nil then
     begin
      correoPapelera.SetEstado('Eliminado');
      ShowMessage('Mensaje Eliminado Correctamente');
      usuarioLogeado.GetPilaPapelera.Push(correoPapelera);
      Close;
     end
  else
     ShowMessage('El Mensaje Ya Fue Eliminado')
end;

procedure TForm10.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form9.Show;
end;

end.

