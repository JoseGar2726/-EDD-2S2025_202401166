unit globals;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, listaUsuarios, usuario, log, fgl;

type
  TListaLogs = specialize TFPGObjectList<TLog>;

var
  ListaUsuariosGlobal: TListaUsuarios;
  UsuarioLogeado: TUsuario;
  LogActual: TLog;
  Logs: TListaLogs;

implementation

end.

