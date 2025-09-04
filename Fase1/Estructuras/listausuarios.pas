unit listaUsuarios;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, usuario;

type
  PNodoUsuario = ^TNodoUsuario;
  TNodoUsuario = record
        Datos: TUsuario;
        Siguiente: PNodoUsuario;
  end;

  TListaUsuarios = class
  private
    Cabeza: PNodoUsuario;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Agregar(Usuario: TUsuario);
    procedure GenerarDOT(const RutaArchivo: string);
    procedure EditarUsuario(email: string; nuevoUser: string; nuevoTelefono: string);
    function ExisteId(id: Integer): Boolean;
    function ExisteEmail(email: string): Boolean;
    function Logearse(email: string): TUsuario;
    function GetCabeza: PNodoUsuario;
  end;

implementation

{ TListaUsuarios }

constructor TListaUsuarios.Create;
begin
  Cabeza := nil;
end;

destructor TListaUsuarios.Destroy;
var
   Aux: PNodoUsuario;
begin
  while Cabeza <> nil do
  begin
       Aux := Cabeza;
       Cabeza := Cabeza^.Siguiente;
       Aux^.Datos.Free;
       Dispose(Aux);
  end;
  inherited Destroy;
end;

procedure TListaUsuarios.Agregar(Usuario: TUsuario);
var
   Nuevo, Temp: PNodoUsuario;
begin
  New(Nuevo);
  Nuevo^.Datos := Usuario;
  Nuevo^.Siguiente := nil;

  if Cabeza = nil then
     Cabeza := Nuevo
  else
  begin
    Temp := Cabeza;
    while Temp^.Siguiente <> nil do
          Temp := Temp^.Siguiente;
    Temp^.Siguiente := Nuevo;
  end;
end;

function TListaUsuarios.ExisteId(id: Integer): Boolean;
var
   Temp: PNodoUsuario;
begin
  Result := False;
  Temp := Cabeza;

  while Temp <> nil do
  begin
       if Temp^.Datos.GetId = id then
       begin
         Result := True;
         Exit;
       end;
       Temp := Temp^.Siguiente;
  end;
end;

function TListaUsuarios.ExisteEmail(email: string): Boolean;
var
   Temp: PNodoUsuario;
begin
  Result := False;
  Temp := Cabeza;

  while Temp <> nil do
  begin
       if Temp^.Datos.GetEmail = email then
       begin
         Result := True;
         Exit;
       end;
       Temp := Temp^.Siguiente;
  end;
end;

function TListaUsuarios.Logearse(email: string): TUsuario;
var
   Temp: PNodoUsuario;
begin
  Result := nil;
  Temp := Cabeza;

  while Temp <> nil do
  begin
       if Temp^.Datos.GetEmail = email then
       begin
         Result := Temp^.Datos;
         Exit;
       end;
       Temp := Temp^.Siguiente;
  end;
end;

procedure TListaUsuarios.EditarUsuario(email, nuevoUser, nuevoTelefono: string);
var
  Temp: PNodoUsuario;
begin
  Temp := Cabeza;

  while Temp <> nil do
  begin
    if Temp^.Datos.GetEmail = email then
    begin
      Temp^.Datos.SetUser(nuevoUser);
      Temp^.Datos.SetTelefono(nuevoTelefono);
      Exit;
    end;
    Temp := Temp^.Siguiente;
  end;
end;

function TListaUsuarios.GetCabeza: PNodoUsuario;
begin
  Result := Cabeza;
end;

procedure TListaUsuarios.GenerarDOT(const RutaArchivo: string);
var
  Archivo: TextFile;
  Temp: PNodoUsuario;
  NodoNombre: string;
  Contador: Integer;
begin
  AssignFile(Archivo, RutaArchivo);
  Rewrite(Archivo);

  Writeln(Archivo, 'digraph G {');
  Writeln(Archivo, '  rankdir=LR;');
  Writeln(Archivo, '  node [shape=record, style=filled, fillcolor=lightblue];');
  Writeln(Archivo, '  label="Lista Simplemente Enlazada: Usuarios";');
  Writeln(Archivo, '  labelloc=top; fontsize=20;');

  Temp := Cabeza;
  Contador := 0;

  while Temp <> nil do
  begin
    NodoNombre := 'Nodo' + IntToStr(Contador);
    Writeln(Archivo, '  ', NodoNombre, ' [label="Id: ', Temp^.Datos.GetId,
            '\nNombre: ', Temp^.Datos.GetNombre,
            '\nUsuario: ', Temp^.Datos.GetUser,
            '\nEmail: ', Temp^.Datos.GetEmail,
            '\nTelefono: ', Temp^.Datos.GetTelefono, '"];');

    Temp := Temp^.Siguiente;
    Inc(Contador);
  end;

  Temp := Cabeza;
  Contador := 0;
  while (Temp <> nil) and (Temp^.Siguiente <> nil) do
  begin
    Writeln(Archivo, '  Nodo', Contador, ' -> Nodo', Contador + 1, ';');
    Temp := Temp^.Siguiente;
    Inc(Contador);
  end;

  Writeln(Archivo, '}');
  CloseFile(Archivo);
end;



end.

