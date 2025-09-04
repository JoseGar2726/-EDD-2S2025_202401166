unit Comunidades;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, listaUsuarios, usuario, globals;

type
   TUsuarioData = record
       correo: string;
   end;


   TComunidadData = record
       nombre: string;
   end;


function InsertarUsuario(nombreComunidad,email: string): Boolean;
function InsertarComunidad(nombre: string): Boolean;
function generateGrafComunidades(): string;

implementation

   type
       PUsuarioCell = ^TUsuarioCell;
       TUsuarioCell = record
           correo: string;
           next: PUsuarioCell;
       end;


       PComunidadHeader = ^TComunidadHeader;
       TComunidadHeader = record
           nombre: string;
           listaUsuarios: PUsuarioCell;
           next: PComunidadHeader;
       end;
   var
       Head: PComunidadHeader = nil;



   function InsertarComunidad(nombre: string): Boolean;
   var
       nuevaComunidad, actual: PComunidadHeader;
    begin
       New(nuevaComunidad);
       nuevaComunidad^.nombre := Trim(nombre);
       nuevaComunidad^.listaUsuarios := nil;
       nuevaComunidad^.next := nil;


       if Head = nil then
       begin
           Head := nuevaComunidad;
           Result := True;
           Exit;
       end
       else
       begin
           actual := Head;
           while actual <> nil do
           begin
               if SameText(actual^.nombre, nuevaComunidad^.nombre) then
               begin
                   Dispose(nuevaComunidad);
                   Result := False;
                   Exit;
               end;

               actual := actual^.next;
           end;


           actual := Head;
           while actual^.next <> nil do
           begin
               actual := actual^.next;
           end;
           actual^.next := nuevaComunidad;
       end;
   end;


function InsertarUsuario(nombreComunidad,email: string): Boolean;
   var
       comunidadActual: PComunidadHeader;
       nuevoUsuario, usuarioActual: PUsuarioCell;
       user: TUsuario;
   begin

       comunidadActual := Head;
        while (comunidadActual  <> nil ) and (comunidadActual^.nombre <> Trim(nombreComunidad)) do
       begin
           comunidadActual := comunidadActual^.next;
       end;


       if comunidadActual = nil then
       begin
           Result := False;
           Exit;
       end;
       user := ListaUsuariosGlobal.Logearse(email);
       if user.getEmail <> '' then
       begin

           New(nuevoUsuario);
           nuevoUsuario^.correo := Trim(email);
           nuevoUsuario^.next := nil;


           if comunidadActual^.listaUsuarios = nil then
           begin
               comunidadActual^.listaUsuarios := nuevoUsuario;
           end
           else
           begin
               usuarioActual := comunidadActual^.listaUsuarios;

               while (usuarioActual^.next <> nil)  do
               begin
                   usuarioActual := usuarioActual^.next;
               end;
               if SameText(usuarioActual^.correo, Trim(email)) then
               begin
                   Dispose(nuevoUsuario);
                   Result := False;
                   Exit;
               end
               else
               begin
                   usuarioActual^.next := nuevoUsuario;
                   Result := True;
                   Exit;
               end;
           end;
       end
       else
       begin
           Result := False;
           Exit;
       end;
   end;
   function EscapeDotString(const S: string): string;
   var
       Res: string;
       i: integer;
   begin
       Res := '';
       for i := 1 to Length(S) do
       begin
           case S[i] of
               '"': Res := Res + '\"';
               '\': Res := Res + '\\';
               '|': Res := Res + '\|';
               '{': Res := Res + '\{';
               '}': Res := Res + '\}';
               #10: Res := Res + '\n';
               #13: Res := Res + '\n';
           else
               Res := Res + S[i];


           end;
       end;


       Result := Res;
   end;




   function generateGrafComunidades(): string;
   var
       SL: TStringList;
       comunidadActual: PComunidadHeader;
       usuarioActual: PUsuarioCell;
       contadorComunidad, contadorUsuarios: Integer;
       nodoComunidad, nodoUsuario, nodoSig: string;
       resultT: string;
   begin
       SL := TStringList.Create;


       SL.Add('digraph Comunidades {');
       SL.Add('  rankdir=LR;');
       SL.Add('  nodesep=0.5;');
       SL.Add('  edge[arrowhead=normal];');
       SL.Add('  node [shape=box, style=filled, fillcolor=lightblue];');
       SL.Add('');


       if Head = nil then
       begin
           SL.Add('      null [label="LISTAVACIA", shape=plaintext];');
       end
       else
       begin
           contadorComunidad := 0;
           comunidadActual := Head;


           while comunidadActual <> nil do
           begin
               nodoComunidad := Format('comunidad%d', [contadorComunidad]);
               SL.Add(Format(' %s [label="%s", fillcolor=lightgreen];', [nodoComunidad, EscapeDotString(comunidadActual^.nombre)]));


               if comunidadActual^.next <> nil then
               begin
                   nodoSig := Format('comunidad%d', [contadorComunidad + 1]);
                   SL.Add(Format(' %s -> %s;', [nodoComunidad,nodoSig]));
               end;


               if comunidadActual^.listaUsuarios <> nil then
               begin
                   contadorUsuarios := 0;
                   usuarioActual := comunidadActual^.listaUsuarios;
                   nodoUsuario := Format('usuario%d_%d', [contadorComunidad, contadorUsuarios]);
                    SL.Add(Format('   %s -> %s;', [nodoComunidad, nodoUsuario]));


                   while usuarioActual <> nil do
                   begin
                       nodoUsuario := Format('usuario%d_%d', [contadorComunidad, contadorUsuarios]);
                       SL.Add(Format('    %s [label="%s"];' , [nodoUsuario, EscapeDotString(usuarioActual^.correo)]));


                       if usuarioActual^.next <> nil then
                       begin
                           nodoSig := Format('usuario%d_%d', [contadorComunidad, contadorUsuarios + 1]);
                           SL.Add(Format('    %s -> %s; ', [nodoUsuario, nodoSig]));
                       end;


                       Inc(contadorUsuarios);
                       usuarioActual := usuarioActual^.next;
                   end;


                   SL.Add('{rank=same; ' + nodoComunidad);
                   for contadorUsuarios := 0 to contadorUsuarios - 1 do
                   begin
                       SL.Add(' ' + Format('usuario%d_%d', [contadorComunidad, contadorUsuarios]));
                   end;
                   SL.Add(' }');
               end;
               Inc(contadorComunidad);
               comunidadActual := comunidadActual^.next;
           end;
       end;


       SL.Add('}');
       resultT := SL.Text;
       SL.Free;


       Result := resultT;
   end;
end.


