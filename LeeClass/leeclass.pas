unit LeeClass;

{$mode objfpc}{$H+}

interface

uses
      Classes, SysUtils, Crt, strutils, constantes;
Type

  { TLeeClass }

  TLeeClass = Class(TObject)
    private
      Fx,Fy : byte;   // Coordenadas de pantalla
      FColor: byte;   // Color de Fondo y Texto de la Etiqueta
      FAncho: Integer;   // Ancho que va a tener la Etiqueta
      Ftexto: string; // Texto donde se guarda la entrada
      FRelleno: char;
    public
      procedure LeerDato;
      function TextoEntrada: string;
      function AnchoCampo: integer;
      procedure Escribe;
      procedure SetAncho(Ancho: integer);
      procedure IngTexto(mensaje: string);
      procedure IngColores(Txt, Fondo: byte);
      procedure IngCoordenadas(XNueva, YNueva: byte);
      // Propiedades
      property Texto: string read TextoEntrada write IngTexto;
      property Ancho: integer read AnchoCampo write SetAncho;
      property CarRelleno: char read FRelleno write FRelleno;
  end;

implementation

function TLeeClass.AnchoCampo: integer;
begin
  result:=FAncho;
end;

procedure TLeeClass.Escribe;
begin
  TextAttr:=FColor;
  GotoXY(Fx,Fy);
  write('['+Ftexto+DupeString(FRelleno,FAncho-Length(Ftexto))+']');
end;

procedure TLeeClass.SetAncho(Ancho: integer);
begin
  FAncho:=Ancho;
end;

function TLeeClass.TextoEntrada: string;
begin
  result:= Ftexto;
end;

procedure TLeeClass.IngTexto(mensaje: string);
begin
  Ftexto:=mensaje;
end;

procedure TLeeClass.IngColores(Txt, Fondo: byte);
begin
  Fcolor := Txt+Fondo*16;
end;

procedure TLeeClass.IngCoordenadas(XNueva, YNueva: byte);
begin
  Fx:=XNueva;
  Fy:=YNueva;
end;

procedure TLeeClass.LeerDato;
var
  TextAux: string;
  Caracter: char;
  i: integer;
begin
  Escribe;
  i:=length(Ftexto)+1;
  TextAux:=Ftexto;
  repeat
    GotoXY(Fx+i,Fy);
	caracter:=ReadKey;

    if Caracter=BACKSPC then
    begin
      if i>1 then i:=i-1;
      GotoXY(Fx+i,Fy);
      write(FRelleno);
      Delete(TextAux,Length(TextAux),1);
	end
	else
      begin
        i:=i+1;
        TextAux:=TextAux+Caracter;
	  end;

    Write(caracter);

  until (caracter=ENTER) or (i>FAncho);
  Ftexto:=Trim(TextAux);
end;

end.

