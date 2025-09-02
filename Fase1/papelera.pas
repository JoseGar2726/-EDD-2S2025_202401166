unit papelera;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Grids;

type

  { TForm11 }

  TForm11 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form11: TForm11;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm11 }

procedure TForm11.Button3Click(Sender: TObject);
begin
  Close
end;

procedure TForm11.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

procedure TForm11.FormShow(Sender: TObject);
begin

end;

end.

