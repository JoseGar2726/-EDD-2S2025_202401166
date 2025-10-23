unit verPrivado;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, globals, merkletree, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm22 }

  TForm22 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  Form22: TForm22;

implementation
uses privados;

{$R *.lfm}

{ TForm22 }

procedure TForm22.Button2Click(Sender: TObject);
begin
  Close
end;

procedure TForm22.Button1Click(Sender: TObject);
begin
  usuarioLogeado.GettFavoritos.EliminarCorreo(StrToInt(Label1.Caption));
  Close
end;

procedure TForm22.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form21.Show;
end;

end.

