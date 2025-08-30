unit listaCorreos;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, correos, Classes, Forms, Controls, Graphics, Dialogs, StdCtrls, listaUsuarios;

type
  PCorreoNodo = ^TCorreoNodo;
  TCorreoNodo = record
    Correo: TCorreo;
    Siguiente: PCorreoNodo;
    Anterior: PCorreoNodo;
  end;

  TListaCorreos = class
  private
    Cabeza: PCorreoNodo;
    Cola: PCorreoNodo;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Agregar(Correo: TCorreo);
    procedure GenerarDOTCorreos(Usuarios: TListaUsuarios;Archivo: string);
  end;

implementation

{ TListaCorreos }

constructor TListaCorreos.Create;
begin
  Cabeza := nil;
  Cola := nil;
end;

destructor TListaCorreos.Destroy;
var
  Actual: PCorreoNodo;
  Temp: PCorreoNodo;
begin
  Actual := Cabeza;
  while Actual <> nil do
  begin
    Temp := Actual^.Siguiente;
    Actual^.Correo.Free;
    Dispose(Actual);
    Actual := Temp;
  end;
  inherited Destroy;
end;

procedure TListaCorreos.Agregar(Correo: TCorreo);
var
  NodoNuevo: PCorreoNodo;
begin
  New(NodoNuevo);
  NodoNuevo^.Correo := Correo;
  NodoNuevo^.Siguiente := nil;
  NodoNuevo^.Anterior := Cola;

  if Cabeza = nil then
    Cabeza := NodoNuevo
  else
    Cola^.Siguiente := NodoNuevo;

  Cola := NodoNuevo;
end;

procedure TListaCorreos.GenerarDOTCorreos(Usuarios: TListaUsuarios; Archivo: string);
var
  SL: TStringList;
  NodoUsuario: PNodo;
  NodoCorreo: PCorreoNodo;
  CorreoPrev: PCorreoNodo;
  UsuarioId: string;
begin
  SL := TStringList.Create;
  try
    SL.Add('digraph G {');
    SL.Add('  rankdir=LR;');
    SL.Add('  node [shape=record];');

    NodoUsuario := Usuarios.Cabeza;
    while NodoUsuario <> nil do
    begin
      UsuarioId := NodoUsuario^.Usuario.Id;

      SL.Add(Format('  subgraph cluster_%s {', [UsuarioId]));
      SL.Add(Format('    label="Correos de %s";', [NodoUsuario^.Usuario.Nombre]));

      CorreoPrev := nil;
      NodoCorreo := Cabeza;
      while NodoCorreo <> nil do
      begin
        if NodoCorreo^.Correo.IdUser = UsuarioId then
        begin
          SL.Add(Format('    "U%s_C%s" [label="Asunto: %s\nFecha: %s"];',
            [UsuarioId, NodoCorreo^.Correo.Id, NodoCorreo^.Correo.Asunto, NodoCorreo^.Correo.Fecha]));

          if (CorreoPrev <> nil) then
          begin
            SL.Add(Format('    "U%s_C%s" -> "U%s_C%s";',
              [UsuarioId, CorreoPrev^.Correo.Id, UsuarioId, NodoCorreo^.Correo.Id]));
            SL.Add(Format('    "U%s_C%s" -> "U%s_C%s";',
              [UsuarioId, NodoCorreo^.Correo.Id, UsuarioId, CorreoPrev^.Correo.Id]));
          end;

          CorreoPrev := NodoCorreo;
        end;
        NodoCorreo := NodoCorreo^.Siguiente;
      end;

      SL.Add('  }');
      NodoUsuario := NodoUsuario^.Siguiente;
    end;

    SL.Add('}');
    SL.SaveToFile(Archivo);
  finally
    SL.Free;
  end;
end;




end.


