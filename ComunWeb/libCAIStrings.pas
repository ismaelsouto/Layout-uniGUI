{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11058: libCAIStrings.pas 
{
{   Rev 1.1    18/05/2017 8:58:18  Fran
}
{
{   Rev 1.0    17/02/2017 9:22:16  Supervisor
}
unit libCAIStrings;

interface
uses Classes;


type TSetOfChar = set of char;

// funcione Nombre_de_mes

// Numero de apariciones de un caracter en una cadena
function CAIStrRepeticiones(const ch: Char; const cadena: string): Integer;

// Elimina caracter #13 y #10
function CAIStrEliminaRetornos(s : string): string;

// Remplaza un conjunto de cadenas por otro
function CAIStrReemplazarCadenas(CadenaOrigen: string; FromText: array of string;
  ToText: array of string): string;overload;

function CAIStrReemplazarCadenas(CadenaOrigen: string; FromText: array of string;
  ToText: string): string;overload;


//  Elimina los caracteres indicados
function CAIStrEliminaCaracteres(CadenaOrigen: string; CadenasInvalidas: array of string): string;overload;
function CAIStrEliminaCaracteres(CadenaOrigen: string; InvalidChars : TSetOfChar = [#9, #10, #13]): string;overload;

function StrCadenaVaciaA(Cadena, SiVacia : string): string;

// Elimina en un TStringList las cadenas duplicadas
procedure StrEliminaDuplicados(var stringList : TStringList) ;


// Obtiene un nombre de fichero temporal, con la extension que se quiera. Ej. CAIStrGetTempFile('.doc')
function CAIStrGetTempFile(const Extension: string = '.TMP'): string;

// Genera una palatra aleatoria
function CAIStrPalabraAleatoria(Longitud: integer): string;

// Obtiene el directorio temporal de windows.
function CAIStrObtenerTempPath(): string;

// Trocea una cadena y devuelte un StringList
function CAIStrSplit(const fText: string; const fSep: Char; fTrim: Boolean = false; fQuotes: Boolean = false): TStringList;

function CAIStrObtenerElemento(Cadena: string; Indice: Integer; Separador: Char = ';'): string;     // Es un poco lento
function CAIStrObtenerIndice(Cadena: string; ElementoBusqueda: string; Separador: Char = ';'): integer;     // Es un poco lento
function CAIStrObtenerNumeroElementos(Cadena: string; Separador: Char = ';'): Integer;  // Es un poco lento
function CAIStrObtenerUltimoElemento(Cadena: string; Separador: Char = ';'): string;  // Es un poco lento


// Obtiene el nombre del fichero sin extension. ej. c:\prueba.exe -> prueba
function CAIStrObtenerSoloNombreFichero(NombreFichero: string): string;

//
function CAIStrLeft(Cadena: string; Longitud: Integer): string;
function CAIStrRight(Cadena: string; Longitud: Integer): string;

// Funciones para recortar
function CAIStrRecortar(Cadena: string; LongitudIzq, LongitudDch: Integer): string;

// Formato esperado 3.123,55
function CAIStrToFloatDef(Valor: string; Defecto: Double): Double;
function CAIStrToCurDef(Valor: string; Defecto: Currency): Currency;

// Rellenar
function CAIStrRellenar(Valor: string; LongitudMax: Integer; Caracter: Char; RellenarPor: Char = #68): string;

// Nombre del mes
function CAIStrNumeroMesToNombre(Mes: Integer; defecto: string = ''): string;

// Busca la ultima aparicion de una cadena
function CAISrtLastPos(SubStr, S: string): Integer;
function CAIStrPosEnd(Substr: string; S: string): Integer;      // Esta parece que no funciona muy bien.

// Recorre la lista de ficheros y elimina la ruta. Ej \Carpeta\Fichero1.pas -> Fichero1.Pas   con / o con \
procedure FTPEliminarRutasEnNombresFicheros(var Ficheros: TStringList);

// Igual a CharToOem
function CAICharToOem(Cadena: string): string;

function CAIStrTextoMesANumero(NombreMes: string): Integer;

// Mete una Cadena en un array
procedure CAIStrToArray(const Cadena: string; var Matriz: array of Char; VaciarArray: Boolean = False);

// Elimina los caracteres que no sean Numeros y Letras
function CAIStrSoloCaracteres(const Cadena: string;
  CaracteresPosibles: string = '1234567890abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ, '): string; // OJOOOO Por defecto no acepta acentos.

function CAIStrRemplazar(Cadena, CadenaOrigen, CadenaDestino: string): string;

function CAIStrQuotedStr(const S: string): string;

function CAIFechaToStr(Fecha: TDateTime; ValorVacio: string = '  /  /    '): string;

// Funciones para convertir cadenas ASCII 850 a ISO 8859-1 (1004)  y viceversa
function CAIStr850To1004(Cadena: string): string;
function CAIStr1004To850(Cadena: string): string;

function CAIStrGetUserName: string;
function CAIStrGetTempPath: string;

// Hace un Trim y devuelve una cadena de maximo caracteres
function CAIStrTrimYSize(valor: string; tamanho: integer): string;

function CAIStrEliminaCerosIzquierda(cadena : string) : string;

// Convierte un TStringList a una cadena separada por ;.
function CAIStrStringACadena(Cadenas : TStrings; Separador : string = ';') : string;

// Devuelve la cadena entre que se encuentra entre CadenaIzquierda y CadenaDerecha
function CAIStrEntreCaracteresV1( Cadena, CadenaIzquierda, CadenaDerecha : string) : string;    // Esta parece que no funciona muy bien
function CAIStrEntreCaracteres( Cadena, CadenaIzquierda, CadenaDerecha : string) : string;

// Peligro. Elimina Entre Desde la primera aparicion hasta la ultima...
function CAIStrEliminaEntreCadenasPrimeraYUltima( Cadena, CadenaIzquierda, CadenaDerecha : string) : string;

// Elimina las cadenas que estre entreo dos cadenas delimitadoras. Empleado por ejemplo para eliminar comentariosxml
function CAIStrEliminaEntreCadenas( CadenaXML, InicioCadena, FinCadena : string) : string;



function NombreDiaSemana(DiaSemana : integer; EnPlural : Boolean = false) : string;

procedure CAIWriteStringsToStream(Stream: TStream; Strings: TStrings);

//   De una cadena dada extrae una cadena de la parte izquierda y la devuelve
function CAIStrExtraeIzq( var Cadena : string; Longitud : Integer) : string;

//   Covierte una cadena de fecha AAAAMMDD a TDate
function CAIStrToFecha( Cadena : string; Formato : string = 'AAAAMMDD') : TDate;

function CAIStrVaciaDefecto(Texto, Defecto : string) :string;





{
  // Encriptacion / Desencriptacion
  function GeneratePWDSecutityString: string;
  function CAIStrEncripta(Data : string; SecurityString : string = '8jF1X7D+tsVzQ/GN'; MinV: Integer = 0;
        MaxV: Integer = 0): string;
  function CAIStrDesencripta(Data: string; SecurityString : string = '8jF1X7D+tsVzQ/GN'): string;
}

const
  CharsNumeros = '1234567890';
  CharsAlfabetoMayus = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';
  CharsAlfabetoMinus = 'abcdefghijklmnñopqrstuvwxyz';
  CharsAlfabetoMayusMinus = CharsAlfabetoMayus + CharsAlfabetoMinus;
  CharsAcentosMayus = 'ÁÉÍÓÚ';
  CharsAcentosMinus = 'áéíóú';
  CharsAlfabeto = CharsAlfabetoMayus + CharsAlfabetoMinus;
  CharsAlfNumAce = CharsNumeros + CharsAlfabeto + CharsAcentosMayus + CharsAcentosMinus + ', ';

implementation

uses StrUtils, SysUtils, Windows, DateUtils, Dialogs;

const
  Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
  CodesUTF8 = Codes64 + '-?:().,''';

//& (ampersand)
//&amp;
//< (menor que)
//&lt;
//> (mayor que)
//&gt;
//“ (dobles comillas)
//&quot;
//' (apóstrofe)
//&apos;


{
  Code1004 = #$A1#$A2#$A3#$BF#$C0#$C1#$C2#$C3#$C4#$C5#$C6#$C7#$C8#$C9#$CA#$CB#$CC#$CD#$CE#$CF#$D0 +
    #$D1#$D2#$D3#$D4#$D5#$D6#$D8#$D9#$DA#$DB#$DC#$DD#$DE#$DF#$E0#$E1#$E2#$E3#$E4#$E5#$E6 +
    #$E7#$E8#$E9#$EA#$EB#$EC#$ED#$EE#$EF#$F0#$F1#$F2#$F3#$F4#$F5#$F6#$F8#$F9#$FA#$FB#$FC +
    #$FD#$FE#$FF;

  Code850 = #$AD#$BD#$9C#$A8#$B7#$B5#$B6#$C7#$8E#$8F#$92#$80#$D4#$90#$D2#$D3#$DE#$D6#$D7#$D8#$D1 +
    #$A5#$D2#$D3#$D4#$E5#$99#$D8#$EB#$E9#$EA#$9A#$ED#$E8#$E1#$85#$A0#$83#$C6#$84#$86#$91 +
    #$87#$8A#$82#$88#$89#$8D#$A1#$8C#$8B#$D0#$A4#$95#$A2#$93#$E4#$94#$9B#$97#$A3#$96#$81 +
    #$EC#$E7#$98;
}
{
Code1004: AnsiString = AnsiString(#$D3#$A1#$#$A2#$#$A3#$#$BF#$#$C0#$#$C1#$#$C2#$#$C3#$#$C4#$C5#$#$C6
      #$#$C7#$#$C8#$#$C9#$#$CA#$#$CB#$#$CC#$#$CD#$#$CE#$#$CF#$#$D0#$D1#$#$D2#$#$D3#$#$D4
      #$#$D5#$#$D6#$#$D8#$#$D9#$#$DA#$#$DB#$#$DC#$#$DD#$DE#$#$DF#$#$E0#$#$E1#$#$E2#$#$E3
      #$#$E4#$#$E5#$#$E6#$E7#$#$E8#$#$E9#$#$EA#$#$EB#$#$EC#$#$ED#$#$EE#$#$EF#$#$F0#$#$F1
      #$#$F2#$#$F3#$F4#$#$F5#$#$F6#$#$F8#$#$F9#$#$FA#$#$FB#$#$FC#$#$FD#$#$FE#$#$FF);

Code850 = #$E0+ #$AD#$#$BD#$#$9C#$#$A8#$#$B7#$#$B5#$#$B6#$#$C7#$#$8E#$#$8F#$#$92 +
		  #$80#$#$D4#$#$90#$#$D2#$#$D3#$#$DE#$#$D6#$#$D7#$#$D8#$#$D1 +
      #$A5#$#$D2#$#$D3#$#$D4#$#$E5#$#$99#$#$D8#$#$EB#$#$E9#$#$EA#$#$9A +
		  #$ED#$#$E8#$#$E1#$#$85#$#$A0#$#$83#$#$C6#$#$84#$#$86#$#$91 +
      #$87#$#$8A#$#$82#$#$88#$#$89#$#$8D#$#$A1#$#$8C#$#$8B#$#$D0#$#$A4 +
		  #$95#$#$A2#$#$93#$#$E4#$#$94#$#$9B#$#$97#$#$A3#$#$96#$#$81 +
      #$EC#$#$E7#$#$98;
}

Code1004= #$D3#$A1#$A2#$A3#$BF#$C0#$C1#$C2#$C3#$C4#$C5#$C6#$C7#$C8#$C9#$CA#$CB#$CC#$CD#$CE#$CF#$D0#$D1#$D2#$D3#$D4#$D5#$D6#$D8#$D9#$DA#$DB#$DC#$DD#$DE#$DF#$E0#$E1#$E2#$E3#$E4#$E5#$E6#$E7#$E8#$E9#$EA#$EB#$EC#$ED#$EE#$EF#$F0#$F1#$F2#$F3#$F4#$F5#$F6#$F8#$F9#$FA#$FB#$FC#$FD#$FE#$FF;
Code850 = #$E0#$AD#$BD#$9C#$A8#$B7#$B5#$B6#$C7#$8E#$8F#$92#$80#$D4#$90#$D2#$D3#$DE#$D6#$D7#$D8#$D1#$A5#$D2#$D3#$D4#$E5#$99#$D8#$EB#$E9#$EA#$9A#$ED#$E8#$E1#$85#$A0#$83#$C6#$84#$86#$91#$87#$8A#$82#$88#$89#$8D#$A1#$8C#$8B#$D0#$A4#$95#$A2#$93#$E4#$94#$9B#$97#$A3#$96#$81#$EC#$E7#$98;


  {*******************************************************************************

    Remplaza un conjunto de cadenas por otro

    Ejemplo :

        CAIStrReemplazarCadenas('Hola juan y juan carlos', ['juan','carlos'], ['eva','maria'])

        Resultado :

        'Hola eva y eva maria'

  *******************************************************************************}

function CAIStrReemplazarCadenas(CadenaOrigen: string; FromText: array of string;
  ToText: array of string): string;
var
  i: Integer;
begin
  if Low(FromText) <> Low(ToText) then
    Exception.Create('CAIStrReemplazarCadenas. Numero de argumentos inválido.');

  if High(FromText) <> High(ToText) then
    Exception.Create('CAIStrReemplazarCadenas. Numero de argumentos inválido.');

  Result := CadenaOrigen;

  for i := Low(FromText) to High(FromText) do
    Result := AnsiReplaceStr(Result, FromText[i], ToText[i]);
end;

{*******************************************************************************
  Elimina los caracteres indicados
*******************************************************************************}
function CAIStrEliminaCaracteres(CadenaOrigen: string; CadenasInvalidas: array of string): string;overload;
var
  i: Integer;
begin
  Result := CadenaOrigen;

  for i := Low(CadenasInvalidas) to High(CadenasInvalidas) do
    Result := AnsiReplaceStr(Result, CadenasInvalidas[i], '');
end;


{*******************************************************************************

*******************************************************************************}
function CAIStrReemplazarCadenas(CadenaOrigen: string; FromText: array of string;
  ToText: string): string;overload;
var
  i: Integer;
begin
  Result := CadenaOrigen;

  for i := Low(FromText) to High(FromText) do
    Result := AnsiReplaceStr(Result, FromText[i], ToText);
end;

{*******************************************************************************
  Obtiene un nombre de fichero temporal, con la extension que se quiera
*******************************************************************************}

function CAIStrGetTempFile(const Extension: string = '.TMP'): string;
var
  DirTmpWindows: string;
begin
  DirTmpWindows := CAIStrObtenerTempPath();
  repeat
    Result := DirTmpWindows + CAIStrPalabraAleatoria(8) + Extension;
  until not FileExists(Result);
end;

{*******************************************************************************
  Genera una palabra Aleatoria
*******************************************************************************}

function CAIStrPalabraAleatoria(Longitud: integer): string;
const
  Letras = '01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  n: integer;
begin
  Result := '';
  for n := 1 to Longitud do
    Result := Result + Letras[1 + Random(Length(Letras))];
end;

{*******************************************************************************
  Obtiene el directorio temporal de windows
*******************************************************************************}

function CAIStrObtenerTempPath(): string;
var
   loTemp:    array[0..Max_Path]of char; // Buffer para llamar a GetTempPath
   loTempdir: string;
begin
   GetTempPath(MAX_PATH,loTemp); // Metemos en Temp el directorio temporal
   loTempdir := String(loTemp);   // Lo pasamos de Pchar a string

   Result := UpperCase(loTempdir);
end;


{*******************************************************************************

  El elemento 0 es el primero.

  Ejemplo :

    CAIStrObtenerElemento( 'Hola;Mundo', 0)

    Resultado :

      'Hola'

*******************************************************************************}

function CAIStrObtenerElemento(Cadena: string; Indice: Integer; Separador: Char = ';'): string;
var
  Dummy: TStrings;
begin
  if Separador = '' then
    raise exception.Create('No se ha especificado el caracter Separador. CAIStrObtenerElemento');

  Dummy := CAIStrSplit(Cadena, Separador);

  // Para solucionar el bug de si termina con el separador, devolveremos cadena vacia
//  if RightStr(Cadena,1) = Separador then
//    Result  := ''
//  else
  Result := Dummy.Strings[Indice];
end;

function CAIStrObtenerIndice(Cadena: string; ElementoBusqueda: string; Separador: Char = ';'): Integer;     // Es un poco lento
var
  Dummy: TStrings;
begin
  Result := -1;

  if Separador = '' then
    raise exception.Create('No se ha especificado el caracter Separador. CAIStrObtenerElemento');

  Dummy := CAIStrSplit(Cadena, Separador);

  Result := Dummy.IndexOf(ElementoBusqueda);
end;



{*******************************************************************************
   Devuelve el numero de elementos
  CAIStrObtenerNumeroElementos( 'Hola;Mundo', ';')   -> 2
*******************************************************************************}

function CAIStrObtenerNumeroElementos(Cadena: string; Separador: Char = ';'): Integer;
var
  Dummy: TStrings;
begin
  if Separador = '' then
    raise exception.Create('No se ha especificado el caracter Separador. CAIStrObtenerElemento');

  Dummy := CAIStrSplit(Cadena, Separador);

  Result := Dummy.Count;
end;

{*******************************************************************************

*******************************************************************************}
function CAIStrObtenerUltimoElemento(Cadena: string; Separador: Char = ';'): string;
begin
try
  Result :=  CAIStrObtenerElemento(Cadena, CAIStrObtenerNumeroElementos(Cadena, Separador) -1, Separador);
Except
  Result := '';
end;
end;



{*******************************************************************************

  Ejemplo :
    CAIStrSplit('Hola;Mundo', ';');

  Resultado :
    [0] := 'Hola';
    [1] := 'Mundo';

*******************************************************************************}

function CAIStrSplit(const fText: string; const fSep: Char; fTrim: Boolean = false; fQuotes: Boolean = false): TStringList;
var
  vI: Integer;
  vBuffer: string;
  vOn: Boolean;
begin
  Result := TStringList.Create;
  vBuffer := '';
  vOn := true;
  for vI := 1 to Length(fText) do
  begin
    if (fQuotes and (fText[vI] = fSep) and vOn) or (not (fQuotes) and (fText[vI] = fSep)) then
    begin
      if fTrim then vBuffer := Trim(vBuffer);
      if vBuffer = '' then vBuffer := fSep;
      if vBuffer[1] = fSep then
        vBuffer := Copy(vBuffer, 2, Length(vBuffer));
      Result.Add(vBuffer);
      vBuffer := '';
    end;
    if fQuotes then
    begin
      if fText[vI] = '"' then
      begin
        vOn := not (vOn);
        Continue;
      end;
      if (fText[vI] <> fSep) or ((fText[vI] = fSep) and (vOn = false)) then
        vBuffer := vBuffer + fText[vI];
    end
    else if fText[vI] <> fSep then
      vBuffer := vBuffer + fText[vI];
  end;
  if (vBuffer <> '') then
  begin
    if fTrim then vBuffer := Trim(vBuffer);
    Result.Add(vBuffer);
  end;

  // Para solucionar un bug, si termina la cadena con el separador
  if (vBuffer = '') and (RightStr(fText, 1) = fSep) then
    Result.Add(vBuffer);
end;

{*******************************************************************************
  Obtiene unicamente le nombre del fichero, sin extension
*******************************************************************************}

function CAIStrObtenerSoloNombreFichero(NombreFichero: string): string;
begin
  Result := ExtractFileName(NombreFichero);
  Result := Copy(Result, 0, Length(Result) - Length(ExtractFileExt(Result)));
end;

{*******************************************************************************

*******************************************************************************}

function CAIStrLeft(Cadena: string; Longitud: Integer): string;
begin
  Result := LeftStr(Cadena, Longitud);
end;

{*******************************************************************************

*******************************************************************************}

function CAIStrRight(Cadena: string; Longitud: Integer): string;
begin
  Result := RightStr(Cadena, Longitud);
end;

{*******************************************************************************

  Elimina caracteres del principio y del final

  Ejemplo :

      CAIStrRecortar('Hola juan y juan carlos', 3, 2)

      Resultado :

      'a juan y juan carl'

*******************************************************************************}

function CAIStrRecortar(Cadena: string; LongitudIzq, LongitudDch: Integer): string;
begin
  Result := Cadena;
  System.Delete(Result, 1, LongitudIzq);
  System.Delete(Result, Length(Result) - LongitudDch + 1, LongitudDch);
end;

{*******************************************************************************
  Formato esperado  : 3.123,56
*******************************************************************************}

function CAIStrToFloatDef(Valor: string; Defecto: Double): Double;
begin
  Valor := Trim(AnsiReplaceStr(Valor, '.', ''));
  Result := StrToFloatDef(Valor, Defecto);
end;

function CAIStrToCurDef(Valor: string; Defecto: Currency): Currency;
begin
  Valor := Trim(AnsiReplaceStr(Valor, '.', ''));
  try
    Result := StrToCurr(Valor);
  except
    Result := Defecto;
  end;
end;

{*******************************************************************************

  Defecto :
  Rellenar por la derecha D
*******************************************************************************}

function CAIStrRellenar(Valor: string; LongitudMax: Integer; Caracter: Char; RellenarPor: Char = #68): string;
begin
  Result := Valor;

  if UpCase(RellenarPor) = 'D' then
  begin
    if Length(Valor) < LongitudMax then
      Result := Result + DupeString(Caracter, LongitudMax - Length(Result));
    Result := LeftStr(Result, LongitudMax);
  end;

  if UpCase(RellenarPor) = 'I' then
  begin
    if Length(Valor) < LongitudMax then
      Result := DupeString(Caracter, LongitudMax - Length(Result)) + Result;
    Result := Rightstr(Result, LongitudMax);
  end;

end;

{*******************************************************************************
  Convierte un numero de mes a su nombre. Ej 1 -> Enero
*******************************************************************************}

function CAIStrNumeroMesToNombre(Mes: Integer; defecto: string = ''): string;
begin
  try
    Result := FormatDateTime('mmmm', EndOfAMonth(2000, Mes));
  except
    Result := defecto;
  end;
end;

{*******************************************************************************
  Busca la ultima aparicion de una cadena
*******************************************************************************}

function CAIStrPosEnd(Substr: string; S: string): Integer;
var
  ls: string;
  i: Integer;
begin
  ls := S;
  Result := Pos(Substr, lS);
  i := Pos(Substr, lS);
  while i > 0 do
  begin
    ls := Copy(lS, i + Length(SubStr), Length(s));
    i := Pos(Substr, lS);
    Result := Result + i;
  end;
end;

{*******************************************************************************

*******************************************************************************}

procedure FTPEliminarRutasEnNombresFicheros(var Ficheros: TStringList);
var
  i: Integer;
begin
  for i := 0 to Ficheros.Count - 1 do
    Ficheros[i] := ExtractFileName(AnsiReplaceStr(Ficheros[i], '/', '\'));
end;

{*******************************************************************************

*******************************************************************************}

function CAICharToOem(Cadena: string): string;
var
  llimpio: array[0..9999] of AnsiChar;
begin
//  CharToOem(PWideChar(Cadena), @llimpio[0]);
//  Result := llimpio;
  Result := Cadena;
end;

{*******************************************************************************
  V 1.1 Ahora permite meses en castellano y en gallego.
  Porque fallaba en Certificado de Empresa (salian vacios los meses del fichero XML)
*******************************************************************************}

function CAIStrTextoMesANumero(NombreMes: string): Integer;
const
  MesesCastellano: array[1..12] of string = (
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre');
  MesesGalego: array[1..12] of string = (
    'Xaneiro', 'Febreiro', 'Marzo', 'Abril', 'Maio', 'Xuño',
    'Xullo', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Decembro');
var
  i: Integer;
begin
  // Primero comprobamos en castellano...
  Result := 0;
  for i := 1 to 12 do
    if UpperCase(MesesCastellano[i]) = Uppercase(NombreMes) then
      Result := i;

  // Si no lo encontro probamos meses en galego
  if Result = 0 then
    for i := 1 to 12 do
      if UpperCase(MesesGalego[i]) = Uppercase(NombreMes) then
        Result := i;
end;

{*******************************************************************************
  Pasa una cadena a un array.

  Ej. Cadena = 'ASD'

  Resultado :
      Array[0] = 'A'
      Array[1] = 'A'
      Array[2] = 'A'

  Si VaciarArray entonces se rellena el resto con #0. Ej. Array[3] = #0

*******************************************************************************}

procedure CAIStrToArray(const Cadena: string; var Matriz: array of Char; VaciarArray: Boolean = False);
var
  i: Integer;
  j: Integer;
begin
  if VaciarArray then
    for i := Low(Matriz) to High(Matriz) do
      Matriz[i] := #0;

  j := 0; // El array no tiene porque empezar con [0], por eso esta variable
  for i := Low(Matriz) to High(Matriz) do
  begin
    if i > Length(Cadena) then break;

    Matriz[i] := Cadena[j];
    Inc(j);
  end;
end;

{
function GeneratePWDSecutityString: string;
var
  i, x: integer;
  s1, s2: string;
begin
  s1 := Codes64;
  s2 := '';
  for i := 0 to 15 do
  begin
    x  := Random(Length(s1));
    x  := Length(s1) - x;
    s2 := s2 + s1[x];
    s1 := Copy(s1, 1,x - 1) + Copy(s1, x + 1,Length(s1));
  end;
  Result := s2;
end;

function MakeRNDString(Chars: string; Count: Integer): string;
var
  i, x: integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
  begin
    x := Length(chars) - Random(Length(chars));
    Result := Result + chars[x];
    chars := Copy(chars, 1,x - 1) + Copy(chars, x + 1,Length(chars));
  end;
end;

function CAIStrEncripta(Data : string; SecurityString : string = '8jF1X7D+tsVzQ/GN'; MinV: Integer = 0;
  MaxV: Integer = 0): string;
var
  i, x: integer;
  s1, s2, ss: string;
begin
  if minV > MaxV then
  begin
    i := minv;
    minv := maxv;
    maxv := i;
  end;
  if MinV < 0 then MinV := 0;
  if MaxV > 100 then MaxV := 100;
  Result := '';
  if Length(SecurityString) < 16 then Exit;
  for i := 1 to Length(SecurityString) do
  begin
    s1 := Copy(SecurityString, i + 1,Length(securitystring));
    if Pos(SecurityString[i], s1) > 0
      then Exit;
    if Pos(SecurityString[i], Codes64) <= 0
      then Exit;
  end;
  s1 := Codes64;
  s2 := '';
  for i := 1 to Length(SecurityString) do
  begin
    x := Pos(SecurityString[i], s1);
    if x > 0 then s1 := Copy(s1, 1,x - 1) + Copy(s1, x + 1,Length(s1));
  end;
  ss := securitystring;
  for i := 1 to Length(Data) do
  begin
    s2 := s2 + ss[Ord(Data[i]) mod 16 + 1];
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
    s2 := s2 + ss[Ord(Data[i]) div 16 + 1];
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
  end;
  Result := MakeRNDString(s1, Random(MaxV - MinV) + minV + 1);
  for i := 1 to Length(s2) do Result := Result + s2[i] + MakeRNDString(s1,
      Random(MaxV - MinV) + minV);
end;

function CAIStrDesencripta(Data: string; SecurityString : string = '8jF1X7D+tsVzQ/GN'): string;
var
  i, x, x2: integer;
  s1, s2, ss: string;
begin
  Result := #1;
  if Length(SecurityString) < 16 then Exit;
  for i := 1 to Length(SecurityString) do
  begin
    s1 := Copy(SecurityString, i + 1,Length(securitystring));
    if Pos(SecurityString[i], s1) > 0 then Exit;
    if Pos(SecurityString[i], Codes64) <= 0 then Exit;
  end;
  s1 := Codes64;
  s2 := '';
  ss := securitystring;
  for i := 1 to Length(Data) do if Pos(Data[i], ss) > 0 then s2 := s2 + Data[i];
  Data := s2;
  s2   := '';
  if Length(Data) mod 2 <> 0 then Exit;
  for i := 0 to Length(Data) div 2 - 1 do
  begin
    x := Pos(Data[i * 2 + 1], ss) - 1;
    if x < 0 then Exit;
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
    x2 := Pos(Data[i * 2 + 2], ss) - 1;
    if x2 < 0 then Exit;
    x  := x + x2 * 16;
    s2 := s2 + chr(x);
    ss := Copy(ss, Length(ss), 1) + Copy(ss, 1,Length(ss) - 1);
  end;
  Result := s2;
end;
}

{*******************************************************************************
  Devuelve la cadena solo con los caracteres posibles
*******************************************************************************}

function CAIStrSoloCaracteres(const Cadena: string;
  CaracteresPosibles: string = '1234567890abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ, '): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Cadena) do
    if Pos(Cadena[i], CaracteresPosibles) > 0 then
      Result := Result + Cadena[i];
end;

{*******************************************************************************
  Remplaza todas las repeticiones.
  Lo hace repetidamente hasta que no se pueda reemplazar mas.
  Creo que tiene algun problemas con las barras en algun ordenador
*******************************************************************************}

function CAIStrRemplazar(Cadena, CadenaOrigen, CadenaDestino: string): string;
begin
  Result := Cadena;
  while Pos(CadenaOrigen, Result) > 0 do
  begin
    Result := AnsiReplaceStr(Result, CadenaOrigen, CadenaDestino);
  end;

end;

{*******************************************************************************

*******************************************************************************}
function CAIStr850To1004(Cadena: string): string;
var
  i, j: Integer;
begin
  Result := '';
  // Vamos procesando caracter a caracter porque con un StringReplace podriamos
  // recambiar el mismo caracter mas de 1 vez
  for i := 1 to Length(Cadena) do
  begin
    j := Pos(Cadena[i], Code850);
    if j = 0 then
      Result := Result + Cadena[i]
    else
      // Encontrato
      Result := Result + Char(Code1004[j]);
  end;
end;


{*******************************************************************************

*******************************************************************************}
function CAIStr1004To850(Cadena: string): string;
var
  i, j: Integer;
begin
  Result := '';
  // Vamos procesando caracter a caracter porque con un StringReplace podriamos
  // recambiar el mismo caracter mas de 1 vez
  for i := 1 to Length(Cadena) do
  begin
    j := Pos(Cadena[i], Code1004);
    if j = 0 then
      Result := Result + Cadena[i]
    else
      // Encontrato
      Result := Result + Char(Code850[j]);
  end;
end;

{*******************************************************************************
  Funcion identica a QuotedStr pero no inserta los apostrofes iniciales y finales
*******************************************************************************}

function CAIStrQuotedStr(const S: string): string;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do
    if Result[I] = '''' then Insert('''', Result, I);
  //  Result := '''' + Result + '''';
end;

{*******************************************************************************

*******************************************************************************}

function CAIFechaToStr(Fecha: TDateTime; ValorVacio: string = '  /  /    '): string;
begin
  if Fecha = 0 then
    Result := ValorVacio
  else
    Result := DateToStr(Fecha);
end;




{*******************************************************************************
  Devuelve el nombre del usuario de windows
*******************************************************************************}

function CAIStrGetUserName: string;
var
  pcUser: PChar;
  dwUSize: DWORD;
begin
  dwUSize := 21;
  GetMem(pcUser, dwUSize);
  try
    if Windows.GetUserName(pcUser, dwUSize) then
      Result := pcUser
  finally
    FreeMem(pcUser);
  end;
end;

{*******************************************************************************

*******************************************************************************}

function CAIStrGetTempPath: string;
var
  Temp: array[0..Max_Path] of char;
begin
  GetTempPath(MAX_PATH, Temp);
  Result := string(Temp);
end;

{*******************************************************************************

*******************************************************************************}

function CAIStrTrimYSize(valor: string; tamanho: integer): string;
begin
  Result := Copy(Trim(valor), 1, tamanho)
end;

{*******************************************************************************
  Numero de apariciones de un caracter en una cadena
*******************************************************************************}
function CAIStrRepeticiones(const ch: Char; const cadena: string): Integer;
var
  i, Count: Integer;
begin
  // caracteres de la cadena
  Count := Length(cadena);
  // Inicializar
  Result := 0;
  // Para cada caracter de la cadena
  for i := 1 to (Count) do
  begin
    // es el que buscamos....
    if (cadena[i] = ch) then
    begin
      Result := Result + 1;
    end; // if
  end; // for
end;

{*******************************************************************************
    Convierte una cadena del tipo '0000B36178485' a 'B36178485'
*******************************************************************************}
function CAIStrEliminaCerosIzquierda(cadena : string) : string;
var
  i : integer;
begin
  Result := '';

  for i := 1 to Length(cadena) do
    if cadena[i] <> '0' then
    begin
      Result := RightStr(Cadena, Length(cadena) - i + 1);
      Break;
    end;
end;



{*******************************************************************************
    Convierte un TStringList a una cadena separada por ;.
    Empleado para las rutas en el envio de ficheros por email
*******************************************************************************}
function CAIStrStringACadena(Cadenas : TStrings; Separador: string = ';') : string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to Cadenas.Count -1 do
    Result := Result + IfThen(Result <> '', Separador, '') + Cadenas.Strings[i];
end;

{*******************************************************************************

*******************************************************************************}
function CAIStrEliminaRetornos(s : string): string;
begin
  Result := ReplaceText(ReplaceText(s, #13,''), #10,'');
end;

{*******************************************************************************
  Devuelve la cadena entre que se encuentra entre CadenaIzquierda y CadenaDerecha

  Ej. CAIStrEntreCaracteres( 'Importe Total ( 12.3 )', '(', ')')

    ' 12. 3'

  Nota!!! Parece que tiene algunos problemas con algun caracter

*******************************************************************************}
function CAIStrEntreCaracteresV1( Cadena, CadenaIzquierda, CadenaDerecha : string) : string;
var
  PosI, PosD : Integer;
begin
  Result := '';

  PosI  := Pos(CadenaIzquierda, Cadena) + Length(CadenaIzquierda);

  PosD  := CAIStrPosEnd(CadenaDerecha, Cadena);


  if PosD > PosI then
    Result := Copy(Cadena, PosI, PosD-PosI);

end;


function CAIStrEntreCaracteres( Cadena, CadenaIzquierda, CadenaDerecha : string) : string;
var
  PosI, PosD : Integer;
begin
  Result := '';

  PosI  := Pos(CadenaIzquierda, Cadena) + Length(CadenaIzquierda);

  PosD  := CAISrtLastPos(CadenaDerecha, Cadena);


  if PosD > PosI then
    Result := Copy(Cadena, PosI, PosD-PosI);

end;


{*******************************************************************************

*******************************************************************************}
function CAISrtLastPos(SubStr, S: string): Integer;
var
  Found, Len, Pos: integer;
begin
  Pos := Length(S);
  Len := Length(SubStr);
  Found := 0;
  while (Pos > 0) and (Found = 0) do
  begin
    if Copy(S, Pos, Len) = SubStr then
      Found := Pos;
    Dec(Pos);
  end;
  result := Found;
end;

{*******************************************************************************
  Elimina el texto que esta entre 2 cadenas cadas. Tener en cuenta que es desde la primera etiqueta a la ultima encontrada. Si hay varias iguales borraria todas
  Ej.
    CadenaTemplateTmp = '<Inicio><Datos_Calendario>Esto es una prueba</Datos_Calendario></Inicio>'

    CAIStrEliminaEntreCadenasPrimeraYUltima(CadenaTemplateTmp, '<Datos_Calendario>', '</Datos_Calendario>')

                        '<Inicio><Datos_Calendario></Datos_Calendario></Inicio>'

*******************************************************************************}
function CAIStrEliminaEntreCadenasPrimeraYUltima( Cadena, CadenaIzquierda, CadenaDerecha : string) : string;
var
  PosI, PosD : Integer;
begin
  Result := Cadena;

  PosI  := Pos(CadenaIzquierda, Cadena) + Length(CadenaIzquierda);

  PosD  := CAIStrPosEnd(CadenaDerecha, Cadena);

  // Si encontro
  if( PosI <> 0) and (PosD > PosI) then
    Result := LeftStr(Cadena, PosI-1) + RightStr(Cadena, Length(Cadena) - PosD + 1) ;
end;


{*******************************************************************************

*******************************************************************************}
function NombreDiaSemana(DiaSemana : integer; EnPlural : Boolean = false) : string;
begin
  Result := '';
  case DiaSemana of
    1 : Result := 'LUNES';
    2 : Result := 'MARTES';
    3 : Result := 'MIERCOLES';
    4 : Result := 'JUEVES';
    5 : Result := 'VIERNES';
    6 : Result := 'SABADO' + IfThen(EnPlural, 'S', '');
    7 : Result := 'DOMINGO' + IfThen(EnPlural, 'S', '');
    else
      Result := '';
  end;
end;


{*******************************************************************************

*******************************************************************************}
 procedure CAIWriteStringsToStream(Stream: TStream; Strings: TStrings);
  var
      Tmp: TMemoryStream;
      Size: Integer;
  begin
      Tmp := TMemoryStream.Create;
      try
          Strings.SaveToStream(Tmp);
          Size := Tmp.Size;
          Stream.WriteBuffer(Size, Sizeof(Integer));
          Stream.CopyFrom(Tmp, 0);
      finally
          Tmp.Free;
      end;
  end;

{*******************************************************************************
  De una cadena dada extrae una cadena de la parte izquierda y la devuelve
  La cadena resultante queda recortada.

  Ej.
    Cadena := 'Hola':
    CAIStrExtraeIzq( Cadena, 2);  // Devuelve 'Ho'   y Cadena = 'la';

*******************************************************************************}
function CAIStrExtraeIzq( var Cadena : string; Longitud : Integer) : string;
begin
  Result := LeftStr(Cadena, Longitud);
  Cadena := CAIStrRecortar(Cadena, Longitud, 0);
end;


{*******************************************************************************
  Covierte una cadena de fecha AAAAMMDD a TDate
*******************************************************************************}
function CAIStrToFecha( Cadena: string; Formato : string = 'AAAAMMDD') : TDate;
begin
  Result := 0;
  if UpperCase(Formato)= 'AAAAMMDD' then
  begin
    if (Cadena <> '') and (Length(Cadena) = 8) then
    begin
      Result := EncodeDate(StrToIntDef(Copy(Cadena, 1, 4), 0), StrToIntDef(Copy(Cadena, 5, 2), 0), StrToIntDef(Copy(Cadena, 7, 2), 0));
    end;
  end
  else
    raise Exception.Create('CAIStrToFecha. Formato no soportado');
end;


{*******************************************************************************

*******************************************************************************}
function CAIStrVaciaDefecto(Texto, Defecto : string) : string;
begin
  Result := Texto;
  if Result = '' then
    Result := Defecto;
end;

{*******************************************************************************

*******************************************************************************}
function CAIStrEliminaCaracteres(CadenaOrigen: string; InvalidChars : TSetOfChar = [#9, #10, #13]): string;overload;
// const
//   InvalidChars : set of char = [#9, #10, #13];
//    [',','.','/','!','@','#','$','%','^','&','*','''','"',';','_','(',')',':','|','[',']'];
var
  i, Count: Integer;
begin
  SetLength(Result, Length(CadenaOrigen));
  Count := 0;
  for i := 1 to Length(CadenaOrigen) do
    if not (CadenaOrigen[i] in InvalidChars) then
    begin
      inc(Count);
      Result[Count] := CadenaOrigen[i];
    end;
  SetLength(Result, Count);
end;


{*******************************************************************************
    Ideal para eliminar comentarios en XML o HTML

    CAIStrEliminaEntreCadenas( CadenaXML, '<!--', '-->');

*******************************************************************************}
function CAIStrEliminaEntreCadenas( CadenaXML, InicioCadena, FinCadena : string) : string;
var
  PosIni, PosFin : Integer;
  s : String;
begin
  Result := CadenaXML;

  PosIni := Pos(InicioCadena, Result);
  PosFin := PosEx(FinCadena, Result, PosIni + Length(InicioCadena));

  while (PosIni > 0) and (PosFin > PosIni) do
  begin
    Result := LeftStr(Result,PosIni-1) + RightStr(Result, Length(Result) - PosFin - Length(FinCadena)+1);
    PosIni := Pos(InicioCadena, Result);
  PosFin := PosEx(FinCadena, Result, PosIni + Length(InicioCadena));
  end;
end;


{*******************************************************************************
  Para por ejemplo evitar el error StrToFloat('');
*******************************************************************************}
function StrCadenaVaciaA(Cadena, SiVacia : string): string;
begin
  Result := Cadena;
  if Cadena = '' then
    Result  := SiVacia;
end;


procedure StrEliminaDuplicados(var stringList : TStringList) ;
var
  Cadenas : TStringList;
  i : Integer;
begin
//
  Cadenas := TStringList.Create;
  try
    for I := 0 to stringList.Count - 1 do
      if Cadenas.IndexOf(stringList.Strings[i]) = -1 then
        Cadenas.Add(stringList.Strings[i]);

    stringList.Clear;
    stringList.Assign(Cadenas);
  finally
    Cadenas.Free;
  end;

end;
end.

