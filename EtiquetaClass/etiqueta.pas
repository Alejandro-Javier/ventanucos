unit Etiqueta;

{$mode objfpc}{$H+}

interface

uses
      crt, strutils, convutils, constantes, sysutils;
Type
  TEtiqueta = Class(TObject)
    private
      Ftexto: string; // texto de la etiqueta a imprimir
      Fx,Fy : byte;   // Coordenadas de pantalla
      FColor: byte;   // Color de Fondo y Texto de la Etiqueta
      Fparpadeo: boolean; // Hacer Parpadear
      FVertical: boolean; // Si es TRUE Imprime el texto en vertical
      FAncho: Integer;   // Ancho que va a tener la Etiqueta
      FAlineacion: byte; // Alineacion: Der=1, Cen=2, Izq=3
    Public
      function AlineacionEs: byte;
      function EsIntermitente: boolean;
      function TextoEtiqueta: string;  // La funcion intermitente no funciona en linux
      function AnchoEtiqueta: integer;
      procedure SetAlineacion(Alin: byte);
      procedure SetIntermitente(intermitente: boolean);
      procedure SetAncho(Ancho: integer);
      procedure IngCoordenadas(XNueva, YNueva: byte);
      procedure IngTexto(mensaje: string);
      procedure Alinear;
      procedure IngColores(Txt, Fondo: byte);
      procedure Escribe;
      // Propiedades
      property Parpadeo: boolean read EsIntermitente write SetIntermitente; // Parpadeo:= True
      property Texto: string read TextoEtiqueta write IngTexto;             // Texto:= 'Cadena de la Etiqueta'
      property Ancho: integer read AnchoEtiqueta write SetAncho;            // Ancho:= 25 --> es un entero con el ancho total que tendra la cadena
      property Alineacion: byte read AlineacionEs write SetAlineacion;    // Alineacion:= CEN Ó DER Ó IZQ Byte 1,2 o 3
      property Vertical: boolean Read FVertical write FVertical;          // Vertical:= True --> Si es True imprime en vertical
  end;


implementation
function TEtiqueta.AlineacionEs: byte;
begin
  Result:=FAlineacion;
end;

function TEtiqueta.AnchoEtiqueta: integer;
begin
  Result:=FAncho;
end;

function TEtiqueta.TextoEtiqueta: String;
begin
  Result:=Ftexto;
end;

function TEtiqueta.EsIntermitente: boolean;
begin
  Result:=Fparpadeo;
end;

procedure TEtiqueta.Alinear;
begin
  case FAlineacion of
    IZQ : Ftexto:= PadRight(Trim(Ftexto),FAncho);    // La Funcion Trim esta en la Unit SysUtils
    CEN : Ftexto:= PadCenter(Trim(Ftexto),FAncho);   // Elimina los espacion y caracteres de control a Izq y Der
    DER : Ftexto:= PadLeft(Trim(Ftexto),FAncho);     // de una cadena, Tambien esta la funcion TrimLeft y TrimRigth
  end;
end;

procedure TEtiqueta.SetAlineacion(Alin: byte);
begin
  FAlineacion:=Alin;
end;

procedure TEtiqueta.SetAncho(Ancho: integer);
begin
  FAncho:=Ancho;
end;

procedure TEtiqueta.SetIntermitente(intermitente: boolean);
begin
  Fparpadeo:=intermitente;
end;

procedure TEtiqueta.IngCoordenadas(XNueva, YNueva: byte);
begin
  Fx:=XNueva;
  Fy:=YNueva;
end;

procedure TEtiqueta.IngTexto(mensaje: string);
begin
  Ftexto:=Trim(mensaje);
end;

procedure TEtiqueta.IngColores(Txt, Fondo: byte);
begin
  Fcolor := Txt+Fondo*16;
  if Fparpadeo then FColor:=FColor+128;
end;

procedure TEtiqueta.Escribe;
var
  x: integer;
begin
  Alinear;
  textAttr := Fcolor;
  GotoXY(Fx,Fy);
  if FVertical then
     Begin
       for x:=0 to Length(Ftexto) do
         begin
           GotoXY(Fx,Fy+x);
           Write(Ftexto[x+1]);
		 end;
	 end
  else Write(Ftexto);
end;

end.

