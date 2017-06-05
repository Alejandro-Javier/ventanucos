unit MnuClass;

{$mode objfpc}{$H+}

interface

uses
      Crt, Classes, SysUtils, constantes;

Type

  { TMnu }

  TMnu = Class(TObject)
    Private
      FNro_Opc: Integer;  // Nro de Opciones que tiene el Menu
      FActual: integer;   // Posicion e donde se encuentra el Cursor en el Menu
      FX, FY: Integer;    // Coordenadas Donde se imprime el menu
      FColor, FColorInv: Byte;   // Atributo de color que tendra el Menu
      FEsVertical: boolean;      // Boolean que nos afirma si es el menu es Vertical
      FOpciones: array[1..20] of string;  // Lista de las opciones del Menu

    Public
      procedure Escribe;
      procedure MnuVertical;
      Procedure MnuHorizontal;
      procedure Navegacion;
      procedure IngColor(TXTColor, ColFondo: Byte);
      procedure IngCoordenadas(X,Y: Integer);
      procedure PonOpc(Opc: array of string);

      property EsVertical: boolean read FEsVertical write FEsvertical;
      property PosCursor: Integer read FActual write FActual;
      property NroOpc: Integer read FNro_Opc write FNro_Opc;
  end;

implementation

{ TMnu }

procedure TMnu.Escribe;
begin
  if Fesvertical then MnuVertical else MnuHorizontal;
end;

procedure TMnu.MnuVertical;
var
 yy, i: integer;
begin
  yy:=FY;
  for i := 1 to Length(FOpciones) do
     begin
         gotoxy(FX,yy);
         if i = Factual then TextAttr:=FColorInv else TextAttr:=FColor;
         write(FOpciones[i]);
         yy:=FY+i;
     end;
end;

procedure TMnu.MnuHorizontal;
var
 offset: byte;
 xx, i: integer;
begin
  offset:=0;
  xx:=FX;
  for i := 1 to Length(FOpciones) do
     begin
         gotoxy(xx,FY);
         if i = Factual then TextAttr:=FColorInv else TextAttr:=FColor;
         write(Fopciones[i]);
         xx:=xx+Length(Fopciones[i])+offset;
     end;
end;

procedure TMnu.Navegacion;
var
 tecla: char;
begin
repeat
   { Escribo opciones }
     Escribe;

    { Espero tecla }
    tecla := readkey;

    { Segun la tecla, subo, bajo o salgo }
    if tecla = chr(0) then { Si es tecla especial }
       tecla := readkey; { tengo que ver el 2do byte }

    { Las teclas de cursor serían 72, 75, 77 y 80 (después de leer un #0).}
    if Fesvertical then
       begin      // Si es vertical usa las teclas arriba y abajo para movernos
         if (tecla = FLECHA_ARRIBA) and (Factual > 1) then Factual := Factual - 1;
         if (tecla = FLECHA_ABAJO) and (Factual < Fnro_opc) then Factual := Factual + 1;
       end
    else
        begin    // Si es Horizontal nos movemos con las teclas Izquierda y Derecha
          if (tecla = FLECHA_IZQ) and (Factual > 1) then Factual := Factual - 1;
          if (tecla = FLECHA_DER) and (Factual < Fnro_opc) then Factual := Factual + 1;
        end;

until tecla = ENTER; { Hasta pulsar ENTER }
end;

procedure TMnu.IngColor(TXTColor, ColFondo: Byte);
begin
  Fcolor := TXTColor+ColFondo*16;
  FColorInv:= ColFondo+TXTColor*16;
end;

procedure TMnu.IngCoordenadas(X, Y: Integer);
begin
  FX:=X;
  FY:=Y;
end;

procedure TMnu.PonOpc(Opc: array of string);
var
 i: integer;
begin
  for i:=1 to Length(Opc) do FOpciones[i]:=Opc[i-1];
  FNro_Opc:= Length(Opc);
end;

end.

