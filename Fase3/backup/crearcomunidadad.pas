unit crearComunidadad;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Comunidades, Process, StdCtrls;

type

  { TForm14 }

  TForm14 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form14: TForm14;

implementation
uses menuAdmin;

{$R *.lfm}

{ TForm14 }

procedure TForm14.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm14.Button4Click(Sender: TObject);
var
  SL: TStringList;
  dotContent: string;
  dotFile, pngFile: string;
  AProcess: TProcess;
begin

  dotFile := 'Reporte/comunidades.dot';
  pngFile := 'Reporte/comunidades.png';

  if not DirectoryExists('Reporte') then
    CreateDir('Reporte');

  dotContent := generateGrafComunidades();

  SL := TStringList.Create;
  try
    SL.Text := dotContent;
    SL.SaveToFile(dotFile);
  finally
    SL.Free;
  end;

  AProcess := TProcess.Create(nil);
  try
    AProcess.Executable := 'dot';
    AProcess.Parameters.Add('-Tpng');
    AProcess.Parameters.Add(dotFile);
    AProcess.Parameters.Add('-o');
    AProcess.Parameters.Add(pngFile);
    AProcess.Options := AProcess.Options + [poWaitOnExit];
    AProcess.Execute;
  finally
    AProcess.Free;
  end;

  ShowMessage('Reporte Comunidades Generado);

end;

procedure TForm14.Button1Click(Sender: TObject);
var
  txtComunidadInput_entry : Pchar;
  response: Boolean;
begin
  txtComunidadInput_entry := Pchar(Edit1.Text);
  response := InsertarComunidad(txtComunidadInput_entry);
  if response then
       ShowMessage('La comunidad ha sido creada con exito')
  else
       ShowMessage('Ya existe una comunidad con ese nombre. Intenta con otro nombre' );
end;

procedure TForm14.Button2Click(Sender: TObject);
var
   txtComunidadInput_entry, txtUsuarioInput_entry : Pchar;
   response: Boolean;
begin
   txtComunidadInput_entry := Pchar(Edit2.Text);
   txtUsuarioInput_entry := Pchar(Edit3.Text);

   response := InsertarUsuario(txtComunidadInput_entry, txtUsuarioInput_entry);

   if response then
       ShowMessage('El usuario ha sido agregado a la comunidad correctamente')
   else
       ShowMessage('Verifica que el nombre de la comunidad exista o que el usuario ingresado exista o ya este ingresado');

end;

procedure TForm14.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form2.Show;
end;

end.

