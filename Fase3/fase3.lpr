program fase3;

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
  listaUsuarios, listaUsuariosCircular, relaciones, Comunidades, avlBorradores,
  borradores, verBorrador, bFavoritos, verFavoritos, verFavorito, 
mensajesComunidad, bstComunidades, clogueo, merkletree, bcCorreo, 
grafoContactos, privados, verPrivado, bChain;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm15, Form15);
  Application.CreateForm(TForm16, Form16);
  Application.CreateForm(TForm17, Form17);
  Application.CreateForm(TForm18, Form18);
  Application.CreateForm(TForm19, Form19);
  Application.CreateForm(TForm20, Form20);
  Application.CreateForm(TForm21, Form21);
  Application.CreateForm(TForm22, Form22);
  Application.Run;
end.

