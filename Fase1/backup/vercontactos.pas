unit verContactos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, listaUsuariosCircular, globals, StdCtrls;

type

  { TForm7 }

  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    nodoActual: PNodo;
  public

  end;

var
  Form7: TForm7;

implementation
uses menuUsuario;

{$R *.lfm}

{ TForm7 }

procedure TForm7.Button3Click(Sender: TObject);
begin
  Close
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  //SIGUIENTE
  if nodoActual <> nil then
  begin
       nodoActual := nodoActual^.Siguiente;
       Edit1.Text:=nodoActual^.Datos.GetNombre;
       Edit2.Text:=nodoActual^.Datos.GetUser;
       Edit3.Text:=nodoActual^.Datos.GetEmail;
       Edit4.Text:=nodoActual^.Datos.GetTelefono;
  end;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
  //Anterior
  if nodoActual <> nil then
  begin
       nodoActual := nodoActual^.Anterior;
       Edit1.Text:=nodoActual^.Datos.GetNombre;
       Edit2.Text:=nodoActual^.Datos.GetUser;
       Edit3.Text:=nodoActual^.Datos.GetEmail;
       Edit4.Text:=nodoActual^.Datos.GetTelefono;
  end;
end;

procedure TForm7.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form4.Show;
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  nodoActual := usuarioLogeado.GetContactos.Primero;
  if nodoActual <> nil then
  begin
       Edit1.Text:=nodoActual^.Datos.GetNombre;
       Edit2.Text:=nodoActual^.Datos.GetUser;
       Edit3.Text:=nodoActual^.Datos.GetEmail;
       Edit4.Text:=nodoActual^.Datos.GetTelefono;
  end;
end;

end.

