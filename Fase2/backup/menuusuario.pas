unit menuUsuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, actualizarPerfil, agregarContacto, verContactos, enviarCorreo, bandejaEntrada, papelera, programarCorreo, enviarCorreoP, globals, Process;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Label1: TLabel;
    procedure Button10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation
uses menuInicio;

{$R *.lfm}

{ TForm4 }

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form1.Show;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin

end;

procedure TForm4.FormShow(Sender: TObject);
begin
  Label1.Caption := 'Bienvenido ' + usuarioLogeado.GetUser;
end;

procedure TForm4.Button10Click(Sender: TObject);
begin
  Close
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  Form9 := TForm9.Create(nil);
  Form9.Show;

  Self.Hide;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form8 := TForm8.Create(nil);
  Form8.Show;

  Self.Hide;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  Form11 := TForm11.Create(nil);
  Form11.Show;

  Self.Hide;
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  Form12 := TForm12.Create(nil);
  Form12.Show;

  Self.Hide;
end;

procedure TForm4.Button5Click(Sender: TObject);
begin
  Form13 := TForm13.Create(nil);
  Form13.Show;

  Self.Hide;
end;

procedure TForm4.Button6Click(Sender: TObject);
begin
  Form6 := TForm6.Create(nil);
  Form6.Show;

  Self.Hide;
end;

procedure TForm4.Button7Click(Sender: TObject);
begin
  Form7 := TForm7.Create(nil);
  Form7.Show;

  Self.Hide;
end;

procedure TForm4.Button8Click(Sender: TObject);
begin
  Form5 := TForm5.Create(nil);
  Form5.Show;

  Self.Hide;
end;

procedure TForm4.Button9Click(Sender: TObject);
var
  nombreReporte, usuarioReporte, direccion: string;
  AProcess: TProcess;
begin
  nombreReporte := usuarioLogeado.GetNombre;
  usuarioReporte := usuarioLogeado.GetUser;
  direccion := nombreReporte + ' - ' + usuarioReporte + ' - ' + 'Reportes';
  ForceDirectories(direccion);
  //Graficar - Generar DOT - Correos
  usuarioLogeado.GetCorreosRecibidos.GenerarDOT(direccion + '/ListaCorreos.dot');
  //Graficar - Generar PNG - Correos
  direccion := '/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase1/' + nombreReporte + ' - ' + usuarioReporte + ' - ' + 'Reportes';
  if FileExists(direccion + '/ListaCorreos.dot') then
  begin
    AProcess := TProcess.Create(nil);
    try
      AProcess.Executable := 'dot';
      AProcess.Parameters.Add('-Tpng');
      AProcess.Parameters.Add(direccion + '/ListaCorreos.dot');
      AProcess.Parameters.Add('-o');
      AProcess.Parameters.Add(direccion + '/ListaCorreos.png');
      AProcess.Options := [poWaitOnExit];
      AProcess.Execute;
      ShowMessage('Reportes De Usuario Generados Correctamente');
    finally
      AProcess.Free;
    end;
  end
  else
    ShowMessage('Error Al Generar Reportes');
  //--------------------------------------------------------------------------------------------------------------------------------
  nombreReporte := usuarioLogeado.GetNombre;
  usuarioReporte := usuarioLogeado.GetUser;
  direccion := nombreReporte + ' - ' + usuarioReporte + ' - ' + 'Reportes';
  ForceDirectories(direccion);
  //Graficar - Generar DOT - PAPELERA
  usuarioLogeado.GetPilaPapelera.GenerarDOT(direccion + '/Papelera.dot');
  //Graficar - Generar PNG - PAPELERA
  direccion := '/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase1/' + nombreReporte + ' - ' + usuarioReporte + ' - ' + 'Reportes';
  if FileExists(direccion + '/ListaCorreos.dot') then
  begin
    AProcess := TProcess.Create(nil);
    try
      AProcess.Executable := 'dot';
      AProcess.Parameters.Add('-Tpng');
      AProcess.Parameters.Add(direccion + '/Papelera.dot');
      AProcess.Parameters.Add('-o');
      AProcess.Parameters.Add(direccion + '/Papelera.png');
      AProcess.Options := [poWaitOnExit];
      AProcess.Execute;
    finally
      AProcess.Free;
    end;
  end;
  //--------------------------------------------------------------------------------------------------------------------------------
  nombreReporte := usuarioLogeado.GetNombre;
  usuarioReporte := usuarioLogeado.GetUser;
  direccion := nombreReporte + ' - ' + usuarioReporte + ' - ' + 'Reportes';
  ForceDirectories(direccion);
  //Graficar - Generar DOT - PROGRAMADOS
  usuarioLogeado.GetColaCorreo.GenerarDOT(direccion + '/CorreosProgramados.dot');
  //Graficar - Generar PNG - PROGRAMADOS
  direccion := '/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase1/' + nombreReporte + ' - ' + usuarioReporte + ' - ' + 'Reportes';
  if FileExists(direccion + '/ListaCorreos.dot') then
  begin
    AProcess := TProcess.Create(nil);
    try
      AProcess.Executable := 'dot';
      AProcess.Parameters.Add('-Tpng');
      AProcess.Parameters.Add(direccion + '/CorreosProgramados.dot');
      AProcess.Parameters.Add('-o');
      AProcess.Parameters.Add(direccion + '/CorreosProgramados.png');
      AProcess.Options := [poWaitOnExit];
      AProcess.Execute;
    finally
      AProcess.Free;
    end;
  end;
  //--------------------------------------------------------------------------------------------------------------------------------
  nombreReporte := usuarioLogeado.GetNombre;
  usuarioReporte := usuarioLogeado.GetUser;
  direccion := nombreReporte + ' - ' + usuarioReporte + ' - ' + 'Reportes';
  ForceDirectories(direccion);
  //Graficar - Generar DOT - CONTACTOSS
  usuarioLogeado.GetContactos.GenerarDOT(direccion + '/Contactos.dot');
  //Graficar - Generar PNG - CONTACTOS
  direccion := '/home/JoseEdd/-EDD-2S2025_202401166_nuevo/Fase1/' + nombreReporte + ' - ' + usuarioReporte + ' - ' + 'Reportes';
  if FileExists(direccion + '/Contactos.dot') then
  begin
    AProcess := TProcess.Create(nil);
    try
      AProcess.Executable := 'dot';
      AProcess.Parameters.Add('-Tpng');
      AProcess.Parameters.Add(direccion + '/Contactos.dot');
      AProcess.Parameters.Add('-o');
      AProcess.Parameters.Add(direccion + '/Contactos.png');
      AProcess.Options := [poWaitOnExit];
      AProcess.Execute;
    finally
      AProcess.Free;
    end;
  end
end;

end.

