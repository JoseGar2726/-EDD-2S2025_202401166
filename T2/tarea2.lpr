program tarea2;

uses Classes, SysUtils, Dialogs, fpjson, jsonparser, Process, Usuario, Arbol;

var
     ruta: String;
     JSONData: TJSONData;
     JSONArray: TJSONArray;
     JSONObject: TJSONObject;
     SL: TStringList;
     i, id: Integer;
     nombre, apellido, email: String;
     usuarios: TUsuario;
     arbolUsuarios: TArbol;

begin
     writeLn('Ingrese la ruta del archivo .json: ');
     readLn(ruta);
     arbolUsuarios := TArbol.Create;

     //LEER ARCHIVO
     SL := TStringList.Create;
     try
       SL.LoadFromFile(ruta);
       JSONData := GetJSON(SL.Text);

       JSONArray := TJSONArray(JSONData);
       for i := 0 to JSONArray.Count - 1 do
       begin
         JSONObject := JSONArray.Objects[i];
         id := JSONObject.Get('id', 0);
         nombre := JSONObject.Get('first_name', '');
         apellido := JSONObject.Get('last_name', '');
         email := JSONObject.Get('email', '');

         usuarios := TUsuario.Create(id,nombre,apellido, email);
         arbolUsuarios.Insertar(usuarios);

       end;
       //GENERAR DOT Y GRAFICAR
       writeLn('ESPERE UN MOMENTO');
       arbolUsuarios.generarDOT('ArbolBSTUsuarios.dot');
     except
        writeLn('RUTA INCORRECTA');
     end;
     writeLn('IMAGEN GENERADA CORRECTAMENTE EN LA RAIZ DEL PROYECTO CON NOMBRE: ArbolBSTUsuarios.png');
     writeLn('PULSE ENTER PARA CONTINUAR');
     readLn();
end.

