unit Arbol;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Usuario, Process;

type
  TipoDato = TUsuario;
  Puntero = ^TipoBase;
  TipoBase = record
    dato: TipoDato;
    hijoIzq: Puntero;
    hijoDer: Puntero;
  end;

  TArbol = class
    public
      Nodo: Puntero;
      constructor Create;
      procedure Insertar(valor: TipoDato);
      procedure generarDOT(const RutaArchivo: string);
    private
      procedure InsertarNodo(var punt: Puntero; valor: TipoDato);
  end;

implementation

constructor TArbol.Create;
begin
   Nodo := nil;
end;

procedure TArbol.Insertar(valor: TipoDato);
begin
     InsertarNodo(Nodo, valor);
end;

procedure TArbol.InsertarNodo(var punt: Puntero; valor: TipoDato);
begin
   if punt = nil then
   begin
     new(punt);
     punt^.dato := valor;
     punt^.hijoIzq := nil;
     punt^.hijoDer := nil;
   end
   else
     if punt^.dato.id > valor.Id then
        InsertarNodo(punt^.hijoIzq, valor)
     else
        InsertarNodo(punt^.hijoDer, valor)
end;

procedure TArbol.generarDOT(const RutaArchivo: string);
var
  sl: TStringList;

procedure nodosDOT(punt: puntero);
var
  idStr, name, lname, correo: string;
begin
   if punt <> nil then
   begin
      nodosDOT(punt^.hijoIzq);
      idStr := IntToStr(punt^.dato.Id);
      name := punt^.dato.Nombre;
      lname := punt^.dato.Apellido;
      correo := punt^.dato.Email;
      sl.Add('  ' + idStr + ' [label="ID: ' + idStr + '\nNombre: ' + name + '\nApellido: ' + lname + '\nEmail: ' + correo + '"];');
      nodosDOT(punt^.hijoDer);
   end;
end;

procedure conexionesDOT(punt: puntero);
var
  idStr, idStrI, idStrD: string;
begin
   if punt <> nil then
   begin
      idStr := IntToStr(punt^.dato.Id);
      if punt^.hijoIzq <> nil then
      begin
         idStrI := IntToStr(punt^.hijoIzq^.dato.Id);
         sl.Add('  ' + idStr + ' -> ' + idStrI);
      end;

      if punt^.hijoDer <> nil then
      begin
         idStrD := IntToStr(punt^.hijoDer^.dato.Id);
         sl.Add('  ' + idStr + ' -> ' + idStrD);
      end;
      conexionesDOT(punt^.hijoIzq);
      conexionesDOT(punt^.hijoDer);
   end;
end;

  begin
     sl := TStringList.Create;
     //ENCABEZADO
     sl.Add('digraph Arbol {');
     sl.Add('  node [shape=rectangle, style=filled, color=lightblue];');
     sl.Add('  rankdir=TB');
     sl.Add('  splines=false');
     //NODOS
     nodosDOT(Nodo);
     //CONEXIONES
     conexionesDOT(Nodo);
     //GENERAR
     sl.Add('}');
     sl.SaveToFile(RutaArchivo);
     RunCommand('dot', ['-Tpng','ArbolBSTUsuarios.dot','-o','ArbolBSTUsuarios.png']);

  end;

end.

