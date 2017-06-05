unit menuTXT;

{$mode objfpc}{$H+}

interface

uses
      Crt, Classes, sysutils, constantes;
type

  { TmenuTXT }

  TmenuTXT = Class(TObject)
    private
       Fnro_opc: integer;
       Factual: integer;
       FX, FY: Integer;
       Fcolor_fondo, Fcolor_txt: Integer;
       Fesvertical: boolean;
       FOpciones: array [1..10] of string;
//	   PonVertical: Boolean;
    Public
       function Vertical: boolean;
       procedure MnuVertical;  // ******
	   procedure MnuHorizontal;  // ******
       procedure Escribe; // ******
	   procedure navegacion;
       procedure PonVertical(Ver:bolean);
       procedure PonCoor(Xnueva, YNueva: byte);
       procedure PonOpc(Opc: array of string);
       // Propiedades
       property EsVertical: Boolean read Vertical write PonVertical;
  end;


implementation

function TmenuTXT.Vertical: boolean;
begin
  result:=Fesvertical;
end;

procedure TmenuTXT.PonVertical(Ver:bolean);
begin
  Fesvertical:=Ver;
end;

procedure TmenuTXT.PonCoor(Xnueva, YNueva: byte);
begin
  FX:=Xnueva;
  FY:=YNueva;
end;

procedure TmenuTXT.PonOpc(Opc: array of string);
begin
  for i:=1 to Length(Opc) do FOpciones[i]:=Opc[i];
end;

procedure TmenuTXT.MnuVertical;
var
 yy, i: integer;
begin
  yy:=FY;
  for i := 1 to Length(FOpciones) do
     begin
         gotoxy(FX,yy);
         if i = Factual then
         begin
           textcolor(FCOLOR_FONDO);
           TextBackground(FCOLOR_TXT);
         end
         else
         begin
             textcolor(FCOLOR_TXT);
             TextBackground(FCOLOR_FONDO);
         end;
         write(FOpciones[i]);
         yy:=FY+i;
     end;
end;

procedure TmenuTXT.MnuHorizontal;
var
 offset: byte;
 xx, i: integer;
begin
  offset:=0;
  xx:=FX;
  for i := 1 to Length(FOpciones) do
     begin
         gotoxy(xx,FY);
         if i = Factual then
            begin
              TextColor(FCOLOR_FONDO);
              TextBackground(FCOLOR_TXT);
            end
         else
            begin
             TextColor(FCOLOR_TXT);
             TextBackground(FCOLOR_FONDO);
            end;
         write(opciones[i]);
         xx:=xx+Length(Fopciones[i])+offset;
     end;
end;

procedure TmenuTXT.Escribe;
begin
  if Fesvertical then MnuVertical else MnuHorizontal;
end;

procedure TmenuTXT.navegacion;
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
end.

