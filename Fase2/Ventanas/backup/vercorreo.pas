unit verCorreo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, globals, bFavoritos, listaCorreos, correo, pilaPapelera, Grids, StdCtrls;

type

  { TForm10 }

  TForm10 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
        ShowMessage('Mensaje Añadido a la Lista de Favoritos');
     end;
  end
  else
     ShowMessage('El Mensaje No Existe');
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
  end
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

