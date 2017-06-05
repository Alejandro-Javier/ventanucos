unit Ventana;

{$mode objfpc}{$H+}

interface

uses
      crt, Classes, SysUtils, Etiqueta;

Type

  { TVentana }

  TVentana = Class(TObject)
  private
    Fx1,Fy1,Fx2,Fy2 : byte;   // Coordenadas de la Ventana en la pantalla
    FColor: byte;   // Color de Fondo y Texto de la Ventana
    FTitulo: TEtiqueta;
    FTxtTitulo: string; // Este es el Titulo de la Ventana
    FTitColorTXT: byte;
    FTitColorFondo: byte;
    FtitAlineacion: byte;


  Public
    constructor Create();
    procedure IngCoordenadas(X1Nueva, Y1Nueva, X2Nueva, Y2Nueva : byte);
    procedure IngColores(Txt, Fondo: byte);
    procedure IngColoresTitulo(TXT, Fondo: Byte);
    procedure Escribe;

    property Titulo: string read FTxtTitulo write FTxtTitulo;
    Property TitAlineacion: byte read FtitAlineacion write FtitAlineacion;
  end;

implementation

{ TVentana }

constructor TVentana.Create;
begin
  FTitulo:=TEtiqueta.Create;
end;

procedure TVentana.IngCoordenadas(X1Nueva, Y1Nueva, X2Nueva, Y2Nueva: byte);
begin
  Fx1:=X1Nueva;
  Fy1:=Y1Nueva;
  Fx2:=X2Nueva;
  Fy2:=Y2Nueva;
end;

procedure TVentana.IngColores(Txt, Fondo: byte);
begin
  Fcolor := Txt+Fondo*16;
end;

procedure TVentana.IngColoresTitulo(TXT, Fondo: Byte);
begin
   FTitColorTXT:=TXT;
   FTitColorFondo:=Fondo;
end;

procedure TVentana.Escribe;
begin
  Window(Fx1,Fy1,Fx2,Fy2);
  TextAttr:=FColor;
  ClrScr;
  FTitulo.IngTexto(FTxtTitulo);
  FTitulo.Alineacion:=FtitAlineacion;
  FTitulo.IngCoordenadas(1,1);
  FTitulo.Ancho:=Fx2-Fx1+1;
  FTitulo.IngColores(FTitColorTXT, FTitColorFondo);
  FTitulo.Escribe;
  Window(Fx1,Fy1+1,Fx2,Fy2);
  TextAttr:=FColor;
  ClrScr;
//  GotoXY(1,1); Write(FTxtTitulo);
end;

end.

