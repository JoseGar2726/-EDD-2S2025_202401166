unit listaUsuariosCircular;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, contactos;

type
  PNodoContacto = ^TNodoContacto;
  TNodoContacto = record
    Datos: TContacto;
    Siguiente: PNodoContacto;
    Anterior: PNodoContacto;
  end;

  TListaUsuariosCircular = class
  private
    Cabeza: PNodoContacto;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Agregar(Contacto: TContacto);
    procedure GenerarDOT(const RutaArchivo: string);
    function ExisteContacto(email: string): Boolean;
    function BuscarPorEmail(const email: string): TContacto;
    function Primero: PNodoContacto;
  end;

implementation

{ TListaUsuariosCircular }

constructor TListaUsuariosCircular.Create;
begin
  Cabeza := nil;
end;

destructor TListaUsuariosCircular.Destroy;
var
  Aux, Temp: PNodoContacto;
begin
  if Cabeza <> nil then
  begin
    Temp := Cabeza^.Siguiente;
    while Temp <> Cabeza do
    begin
      Aux := Temp;
      Temp := Temp^.Siguiente;
      Dispose(Aux);
    end;
    Dispose(Cabeza);
  end;
  inherited Destroy;
end;

procedure TListaUsuariosCircular.Agregar(Contacto: TContacto);
var
  Nuevo, Ultimo: PNodoContacto;
begin
  New(Nuevo);
  Nuevo^.Datos := Contacto;

  if Cabeza = nil then
  begin
    Cabeza := Nuevo;
    Nuevo^.Siguiente := Cabeza;
    Nuevo^.Anterior := Cabeza;
  end
  else
  begin
    Ultimo := Cabeza^.Anterior;

    Nuevo^.Siguiente := Cabeza;
    Nuevo^.Anterior := Ultimo;

    Ultimo^.Siguiente := Nuevo;
    Cabeza^.Anterior := Nuevo;

  end;
end;

function TListaUsuariosCircular.ExisteContacto(email: string): Boolean;
var
  Temp: PNodoContacto;
begin
  Result := False;

  if Cabeza = nil then
   Exit;

  Temp := Cabeza;
  repeat
    if Temp^.Datos.GetEmail = email then
    begin
      Result := True;
      Exit;
    end;
    Temp := Temp^.Siguiente;
  until Temp = Cabeza;
end;

function TListaUsuariosCircular.Primero: PNodoContacto;
begin
  Result := Cabeza;
end;

function TListaUsuariosCircular.BuscarPorEmail(const email: string): TContacto;
var
  Temp: PNodoContacto;
begin
  Result := nil;

  if Cabeza <> nil then
  begin
    Temp := Cabeza;
    repeat
      if Temp^.Datos.GetEmail = email then
      begin
        Result := Temp^.Datos;
        Exit;
      end;
      Temp := Temp^.Siguiente;
    until Temp = Cabeza;
  end;
end;

procedure TListaUsuariosCircular.GenerarDOT(const RutaArchivo: string);
var
  Archivo: TextFile;
  Temp: PNodoContacto;
  NodoNombre, SiguienteNombre: string;
  Contador, Total: Integer;
begin
  AssignFile(Archivo, RutaArchivo);
  Rewrite(Archivo);

  Writeln(Archivo, 'digraph G {');
  Writeln(Archivo, '  rankdir=LR;');
  Writeln(Archivo, '  node [shape=record, style=filled, fillcolor=lightgreen];');
  Writeln(Archivo, '  label="Lista Circular de Contactos";');
  Writeln(Archivo, '  labelloc=top; fontsize=20;');

  if Cabeza <> nil then
  begin
    Temp := Cabeza;
    Contador := 0;
    repeat
      NodoNombre := 'Nodo' + IntToStr(Contador);
      Writeln(Archivo, '  ', NodoNombre, ' [label="{ID: ', IntToStr(Temp^.Datos.GetId),
              '\nNombre: ', Temp^.Datos.GetNombre,
              '\nUsuario: ', Temp^.Datos.GetUser,
              '\nEmail: ', Temp^.Datos.GetEmail,
              '\nTelefono: ', Temp^.Datos.GetTelefono, '}"];');

      Temp := Temp^.Siguiente;
      Inc(Contador);
    until Temp = Cabeza;
    Total := Contador;

    for Contador := 0 to Total - 2 do
    begin
      NodoNombre := 'Nodo' + IntToStr(Contador);
      SiguienteNombre := 'Nodo' + IntToStr(Contador + 1);
      Writeln(Archivo, '  ', NodoNombre, ' -> ', SiguienteNombre, ' [dir=both];');
    end;

    if Total > 1 then
      Writeln(Archivo, '  Nodo', Total - 1, ' -> Nodo0 [dir=both];');
  end;

  Writeln(Archivo, '}');
  CloseFile(Archivo);
end;


end.


