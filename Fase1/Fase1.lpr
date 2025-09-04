program Fase1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, actualizarPerfil, agregarContacto, bandejaEntrada, crearComunidadad,
  enviarCorreo, enviarCorreoP, menuAdmin, menuCrearCuenta, menuInicio,
  menuUsuario, papelera, programarCorreo, verContactos, verCorreo, contactos,
  correo, usuario, globals, listaCorreos, pilaPapelera, colaCorreos,
  listaUsuarios, listaUsuariosCircular, relaciones, Comunidades;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

