program Ventanucos;

{$mode objfpc}{$H+}
// {$APPTYPE CONSOLE}
{$codepage utf8}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, sysutils, strutils, Crt, LeeClass, Etiqueta, Ventana, constantes,
  MnuClass, barraclass;

var
 Etiqueta1: TEtiqueta;
 Etiqueta2: TEtiqueta;
 Ingreso: TLeeClass;
 Input2: TLeeClass;
 Ventana1: TVentana;
 Mnu1: TMnu;
 Barra: TBar;
 opcionesMenu1: array [1..8] of string;
 ColoresPantalla: byte;
 i: integer;

begin

 // SetConsoleOutputCP(CP_UTF8);

  opcionesMenu1[1]:=' Primero ';
  opcionesMenu1[2]:=' Anterior ';
  opcionesMenu1[3]:=' Siguiente ';
  opcionesMenu1[4]:=' Ultimo ';
  opcionesMenu1[5]:=' Insertar ';
  opcionesMenu1[6]:=' Borrar ';
  opcionesMenu1[7]:=' Editar ';
  opcionesMenu1[8]:=' Guardar ';

  ColoresPantalla:=TextAttr;   // Guardamos los colores originales de la pantalla
  ClrScr;

  // *************************************
  // Escribimos una regleta en la pantalla
  // *************************************
  GotoXY(1,2);
  Write('12345678901234567890123456789012345678901234567890123456789012345678901234567890');
  TextColor(Red);
  GotoXY(10,2); write('0');
  gotoxy(20,2); Write('0');
  gotoxy(30,2); Write('0');
  gotoxy(40,2); Write('0');
  gotoxy(50,2); Write('0');
  gotoxy(60,2); Write('0');
  gotoxy(70,2); Write('0');
  gotoxy(80,2); Write('0');
  // *************************************

  Mnu1:=TMnu.Create;
  Mnu1.IngColor(Black,Red);
  Mnu1.EsVertical:=False;
  // Mnu1.NroOpc:=8;
  Mnu1.PosCursor:=2;
  Mnu1.IngCoordenadas(1,1);
  Mnu1.PonOpc(opcionesMenu1);
  Mnu1.Escribe;



  Etiqueta1:=TEtiqueta.Create;
  Etiqueta2:=TEtiqueta.Create;
  Etiqueta1.IngCoordenadas(1,4);
  Etiqueta2.IngCoordenadas(1,3);
  Etiqueta1.Texto:='Titulo Principal';
  Etiqueta2.Texto:='Segundo Titulo:';
  Etiqueta1.IngColores(Blue,White);
  Etiqueta2.IngColores(Green,White);
  //Etiqueta2.Parpadeo:=True;
  Etiqueta1.Ancho:=30;
  Etiqueta2.Ancho:=30;
  Etiqueta1.Alineacion:=CEN;
  Etiqueta2.Alineacion:=DER;

  Etiqueta1.Escribe;
  Etiqueta2.Escribe;

  Ingreso:=TLeeClass.Create;
  Ingreso.IngColores(Black,White);
  Ingreso.IngCoordenadas(31,3);
  Ingreso.Ancho:=15;
  Ingreso.CarRelleno:=char(177);
  Ingreso.Texto:='Hola';

  Input2:=TLeeClass.Create;
  Input2.IngColores(White,Blue);
  Input2.IngCoordenadas(31,4);
  Input2.Ancho:=20;
  Input2.CarRelleno:=char(178);

  Ingreso.Escribe;
//  ReadKey;
  Input2.Escribe;
  Ingreso.LeerDato;
  Input2.LeerDato;

  Etiqueta1.Texto:=Ingreso.Texto;
  Etiqueta1.Escribe;

  Mnu1.Navegacion;

  writeln();
  writeln('Usted eligio: '+opcionesMenu1[Mnu1.PosCursor]);


  // Ventana
  Ventana1:=TVentana.Create;
  Ventana1.IngColores(DarkGray,Blue);
  Ventana1.IngColoresTitulo(Yellow,Green);
  Ventana1.Titulo:='Titulo de Ventana';
  Ventana1.IngCoordenadas(15,8,55,20);
  Ventana1.TitAlineacion:=CEN;
  Ventana1.Escribe;

  Etiqueta2.Alineacion:=IZQ;
  Etiqueta2.IngCoordenadas(3,4);
  Etiqueta2.Vertical:=true;
  Etiqueta2.Texto:='Vertical';
  Etiqueta2.Ancho:=8;

  Etiqueta2.Escribe;
  GotoXY(1,2);
  write('['+DupeString(char(177),20)+']');

  // Barra Config
  Barra:=TBar.Create;
  Barra.AnchoBar:=25;
  Barra.CarLimitador:='[]';
  Barra.CarBarra:='*';
  Barra.EtiquetaTotal:='100%';
  Barra.EtiquetaValor:='00%';
  Barra.IngColor(Blue,White);
  Barra.IngCoordenadas(5,6);

  Barra.MaxValor:=500;
  for i:=0 to Barra.MaxValor do
    begin
      Barra.ValActual:=i;
      Barra.Escribe;
      Delay(5);
	end;




  ReadKey;
  TextAttr:=ColoresPantalla;   // Restauramos los colores Originales de la Pantala
//  ClrScr;

  Input2.Free;
  Ingreso.Free;
  Mnu1.Free;
  Etiqueta1.Free;
  Etiqueta2.Free;
end.

