unit listaUsuarios;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, usuarios, fpjson, jsonparser;

type
  PNodo = ^TNodo;
  TNodo = record
    Usuario: TUsuario;
    Siguiente: PNodo;
  end;

  TListaUsuarios = class
  private
    Cabeza: PNodo;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Agregar(const Id, Nombre, Usuario, Password, Email, Telefono: string);
    procedure GenerarDOT(const RutaArchivo: string);
  end;

implementation

constructor TListaUsuarios.Create;
begin
  Cabeza := nil;
end;

destructor TListaUsuarios.Destroy;
var
   actual, temp: PNodo;
begin
  actual := Cabeza;
  while actual <> nil do
  begin
    temp := actual^.siguiente;
    actual^.Usuario.Free;
    Dispose(actual);
    actual := temp;
  end;
  inherited Destroy;
end;

procedure TListaUsuarios.Agregar(const Id, Nombre, Usuario, Password, Email, Telefono: string);
var
   nuevo: PNodo;
begin
  New(nuevo);
  nuevo^.Usuario := TUsuario.Create(Id, Nombre, Usuario, Password, Email, Telefono);
  nuevo^.Siguiente := Cabeza;
  Cabeza := Nuevo
end;

procedure TListaUsuarios.GenerarDOT(const RutaArchivo: string);
var
  actual: PNodo;
  sl: TStringList;
  idNodo, idSiguiente, strLabel: string;
  contador: Integer;
  begin
    sl := TStringList.Create;
    try
      sl.Add('digraph G {');
      sl.Add('  node [shape=record];');

      actual := Cabeza;
      contador := 0;
      while actual <> nil do
      begin
        idNodo := 'Nodo' + IntToStr(contador); // identificador único

        strLabel := actual^.Usuario.Id + '\n' +
                    actual^.Usuario.Nombre + '\n' +
                    actual^.Usuario.Usuario + '\n' +
                    actual^.Usuario.Password + '\n' +
                    actual^.Usuario.Email + '\n' +
                    actual^.Usuario.Telefono;

        sl.Add(Format('  "%s" [label="%s"];', [idNodo, strLabel]));

        if actual^.Siguiente <> nil then
        begin
          idSiguiente := 'Nodo' + IntToStr(contador + 1);
          sl.Add(Format('  "%s" -> "%s";', [idNodo, idSiguiente]));
        end;

        actual := actual^.Siguiente;
        Inc(contador);
      end;

      sl.Add('}');
      sl.SaveToFile(RutaArchivo);
    finally
      sl.Free;
    end;
  end;





end.
