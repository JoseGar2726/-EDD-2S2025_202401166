unit verFavorito;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, globals Graphics, Dialogs, Grids, StdCtrls;

type

  { TForm18 }

  TForm18 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form18: TForm18;

implementation
uses verFavoritos;

{$R *.lfm}

{ TForm18 }

procedure TForm18.FormCreate(Sender: TObject);
begin

end;

procedure TForm18.Button2Click(Sender: TObject);
begin
  Close
end;

procedure TForm18.Button1Click(Sender: TObject);
var
  idCorreo: Integer;
begin
  idCorreo := StrToInt(Label1.Caption);
  if usuarioLogeado.GetbFavoritos.Buscar(idCorreo) <> nil then
  begin
    usuarioLogeado.GetbFavoritos.Eliminar(idCorreo);
    ShowMessage('Correo eliminado de Favoritos');
    Close;
  end
  else
    ShowMessage('El correo no se encuentra en Favoritos');
end;

procedure TForm18.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form17.Show;
end;

end.

