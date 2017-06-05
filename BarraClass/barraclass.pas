unit BarraClass;

{$mode objfpc}{$H+}

interface

uses
      Crt, Classes, SysUtils, strutils;

type
  TBar =  Class(TObject)
    Private
       FEtiVal: string;
       FEtiTot: string;
       FCarLim: string;
       FCarBar: char;
       FMaxVal: LongInt;
       FValActual: LongInt;
       FAnchoBar: integer;
       FColor: Byte;
       FX, FY: Byte;

    Public
       procedure CalcAnchoBar;
       procedure IngColor(TXTColor, ColFondo: Byte);
       procedure IngCoordenadas(X,Y: Integer);
       procedure Escribe;

       property EtiquetaValor: string Read FEtiVal    write FEtiVal;
       property EtiquetaTotal: string Read FEtiTot    write FEtiTot;
       property CarLimitador: String  Read FCarLim    Write FCarLim;
       property CarBarra: char        Read FCarBar    Write FCarBar;
       Property MaxValor: LongInt     Read FMaxVal    Write FMaxVal;
       Property ValActual: LongInt    Read FValActual Write FValActual;
       Property AnchoBar: integer     Read FAnchoBar  Write FAnchoBar;

  end;

implementation

Var
  Bar: String;

procedure TBar.IngColor(TXTColor, ColFondo: Byte);
begin
  Fcolor := TXTColor+ColFondo*16;
end;

procedure TBar.IngCoordenadas(X, Y: Integer);
begin
  FX:=X;
  FY:=Y;
end;

procedure TBar.CalcAnchoBar;
var
  ValAct, ValActCar: LongInt;
Begin
  ValAct:=(FValActual*100) div FMaxVal;
  ValActCar:=(ValAct*FAnchoBar) div 100;
  FEtiVal:=IntToStr(ValAct)+'%';
  Bar:=PadRight(DupeString(FCarBar,ValActCar),FAnchoBar);
end;

procedure TBar.Escribe;
begin
  CalcAnchoBar;
  textAttr := Fcolor;
  GotoXY(FX,FY);
  Write(FEtiVal);
  Write(copy(FCarLim,1,1));
  Write(Bar);
  Write(copy(FCarLim,2,1));
  Write(FEtiTot);
end;

end.

