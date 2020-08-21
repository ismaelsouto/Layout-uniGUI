(******************************************)
(* Conversión Número -> Letra             *)
(*                                        *)
(*                                        *)
(*                                        *)
(* dos funciones:                         *)
(*                                        *)
(* 1 -> NumLetra: Convierte a texto       *)
(* 2 -> EurosLetra: Convierte Euros       *)
(*      a letras en el formato correcto   *)
(*                                        *)
(******************************************)

unit ConvierteNomerosALetras;

interface

uses
  Sysutils;

(**************************************)
(* Conversión Número -> Letra         *)
(*                                    *)
(* Parámetros:                        *)
(*                                    *)
(*   mNum:    Número a convertir      *)
(*   iIdioma: Idioma de conversión    *)
(*            1 -> Castellano         *)
(*            2 -> Catalán            *)
(*   iModo:   Modo de conversión      *)
(*            1 -> Masculino          *)
(*            2 -> Femenino           *)
(*                                    *)
(* Restricciones:                     *)
(*                                    *)
(* - Redondeo a dos decimales         *)
(* - Rango: 0,00 a 999.999.999.999,99 *)
(*                                    *)
(**************************************)


// Convierte numeros a letras
function NumLetra(const mNum: Currency; const iIdioma, iModo: Smallint): String;

//Convierte euros a letras
function EurosLetra(Euros: Extended): String;
function EurosLetra_SinEuros(Euros: Extended): String;

implementation

function NumLetra(const mNum: Currency; const iIdioma, iModo: Smallint): String;
const
  iTopFil: Smallint = 6;
  iTopCol: Smallint = 10;
  aCastellano: array[0..5, 0..9] of PChar =
  ( ('UNA ','DOS ','TRES ','CUATRO ','CINCO ',
    'SEIS ','SIETE ','OCHO ','NUEVE ','UN '),
    ('ONCE ','DOCE ','TRECE ','CATORCE ','QUINCE ',
    'DIECISEIS ','DIECISIETE ','DIECIOCHO ','DIECINUEVE ',''),
    ('DIEZ ','VEINTE ','TREINTA ','CUARENTA ','CINCUENTA ',
    'SESENTA ','SETENTA ','OCHENTA ','NOVENTA ','VEINTI'),
    ('CIEN ','DOSCIENTAS ','TRESCIENTAS ','CUATROCIENTAS ','QUINIENTAS ',
    'SEISCIENTAS ','SETECIENTAS ','OCHOCIENTAS ','NOVECIENTAS ','CIENTO '),
    ('CIEN ','DOSCIENTOS ','TRESCIENTOS ','CUATROCIENTOS ','QUINIENTOS ',
    'SEISCIENTOS ','SETECIENTOS ','OCHOCIENTOS ','NOVECIENTOS ','CIENTO '),
    ('MIL ','MILLON ','MILLONES ','CERO ','Y ',
    'UN ','DOS ','CON ','','') );   //*******CAMBIE UNO POR UN EN ESTA LINEA*******
  aCatalan: array[0..5, 0..9] of PChar =
  ( ( 'UNA ','DUES ','TRES ','QUATRE ','CINC ',
    'SIS ','SET ','VUIT ','NOU ','UN '),
    ( 'ONZE ','DOTZE ','TRETZE ','CATORZE ','QUINZE ',
    'SETZE ','DISSET ','DIVUIT ','DINOU ',''),
    ( 'DEU ','VINT ','TRENTA ','QUARANTA ','CINQUANTA ',
    'SEIXANTA ','SETANTA ','VUITANTA ','NORANTA ','VINT-I-'),
    ( 'CENT ','DOS-CENTES ','TRES-CENTES ','QUATRE-CENTES ','CINC-CENTES ',
    'SIS-CENTES ','SET-CENTES ','VUIT-CENTES ','NOU-CENTES ','CENT '),
    ( 'CENT ','DOS-CENTS ','TRES-CENTS ','QUATRE-CENTS ','CINC-CENTS ',
    'SIS-CENTS ','SET-CENTS ','VUIT-CENTS ','NOU-CENTS ','CENT '),
    ( 'MIL ','MILIO ','MILIONS ','ZERO ','-',
    'UN ','DOS ','AMB ','','') );
var
  aTexto: array[0..5, 0..9] of PChar;
  cTexto, cNumero: String;
  iCentimos, iPos: Smallint;
  bHayCentimos, bHaySigni: Boolean;

  (*************************************)
  (* Cargar Textos según Idioma / Modo *)
  (*************************************)

  procedure NumLetra_CarTxt;
  var
    i, j: Smallint;
  begin
    (* Asignación según Idioma *)

    for i := 0 to iTopFil - 1 do
      for j := 0 to iTopCol - 1 do
        case iIdioma of
          1: aTexto[i, j] := aCastellano[i, j];
          2: aTexto[i, j] := aCatalan[i, j];
        else
          aTexto[i, j] := aCastellano[i, j];
        end;

    (* Asignación si Modo Masculino *)

    if (iModo = 1) then
    begin
      for j := 0 to 1 do
        aTexto[0, j] := aTexto[5, j + 5];

      for j := 0 to 9 do
        aTexto[3, j] := aTexto[4, j];
    end;
  end;

  (****************************)
  (* Traducir Dígito -Unidad- *)
  (****************************)

  procedure NumLetra_Unidad;
  begin
    if not( (cNumero[iPos] = '0') or (cNumero[iPos - 1] = '1')
     or ((Copy(cNumero, iPos - 2, 3) = '001') and ((iPos = 3) or (iPos = 9))) ) then
      if (cNumero[iPos] = '1') and (iPos <= 6) then
        cTexto := cTexto + aTexto[0, 9]
      else
        cTexto := cTexto + aTexto[0, StrToInt(cNumero[iPos]) - 1];

    if ((iPos = 3) or (iPos = 9)) and (Copy(cNumero, iPos - 2, 3) <> '000') then
      cTexto := cTexto + aTexto[5, 0];

    if (iPos = 6) then
      if (Copy(cNumero, 1, 6) = '000001') then
        cTexto := cTexto + aTexto[5, 1]
      else
        cTexto := cTexto + aTexto[5, 2];
  end;

  (****************************)
  (* Traducir Dígito -Decena- *)
  (****************************)

  procedure NumLetra_Decena;
  begin
    if (cNumero[iPos] = '0') then
      Exit
    else if (cNumero[iPos + 1] = '0') then
      cTexto := cTexto + aTexto[2, StrToInt(cNumero[iPos]) - 1]
    else if (cNumero[iPos] = '1') then
      cTexto := cTexto + aTexto[1, StrToInt(cNumero[iPos + 1]) - 1]
    else if (cNumero[iPos] = '2') then
      cTexto := cTexto + aTexto[2, 9]
    else
      cTexto := cTexto + aTexto[2, StrToInt(cNumero[iPos]) - 1]
        + aTexto[5, 4];
  end;

  (*****************************)
  (* Traducir Dígito -Centena- *)
  (*****************************)

  procedure NumLetra_Centena;
  var
    iPos2: Smallint;
  begin
    if (cNumero[iPos] = '0') then
      Exit;

    iPos2 := 4 - Ord(iPos > 6);

    if (cNumero[iPos] = '1') and (Copy(cNumero, iPos + 1, 2) <> '00') then
      cTexto := cTexto + aTexto[iPos2, 9]
    else
      cTexto := cTexto + aTexto[iPos2, StrToInt(cNumero[iPos]) - 1];
  end;

  (**************************************)
  (* Eliminar Blancos previos a guiones *)
  (**************************************)

  procedure NumLetra_BorBla;
  var
    i: Smallint;
  begin
    i := Pos(' -', cTexto);

    while (i > 0) do
    begin
      Delete(cTexto, i, 1);
      i := Pos(' -', cTexto);
    end;
  end;

begin
  (* Control de Argumentos *)

  if (mNum < 0.00) or (mNum > 999999999999.99) or (iIdioma < 1) or (iIdioma > 2)
    or (iModo < 1) or (iModo > 2) then
  begin
    Result := 'ERROR EN ARGUMENTOS';
    Abort;
  end;

  (* Cargar Textos según Idioma / Modo *)

  NumLetra_CarTxt;

  (* Bucle Exterior -Tratamiento Céntimos-     *)
  (* NOTA: Se redondea a dos dígitos decimales *)

  cNumero := Trim(Format('%12.0f', [Int(mNum)]));
  cNumero := StringOfChar('0', 12 - Length(cNumero)) + cNumero;
  iCentimos := Trunc((Frac(mNum) * 100) + 0.5);

  repeat
    (* Detectar existencia de Céntimos *)

    if (iCentimos <> 0) then
      bHayCentimos := True
    else
      bHayCentimos := False;

    (* Bucle Interior -Traducción- *)

    bHaySigni := False;

    for iPos := 1 to 12 do
    begin
      (* Control existencia Dígito significativo *)

      if not(bHaySigni) and (cNumero[iPos] = '0') then
        Continue
      else
        bHaySigni := True;

      (* Detectar Tipo de Dígito *)

      case ((iPos - 1) mod 3) of
        0: NumLetra_Centena;
        1: NumLetra_Decena;
        2: NumLetra_Unidad;
      end;
    end;

    (* Detectar caso 0 *)

    if (cTexto = '') then
      cTexto := aTexto[5, 3];

    (* Traducir Céntimos -si procede- *)

    if (iCentimos <> 0) then
    begin
      cTexto := cTexto + aTexto[5, 7];
      cNumero := Trim(Format('%.12d', [iCentimos]));
      iCentimos := 0;
    end;
  until not (bHayCentimos);

  (* Eliminar Blancos innecesarios -sólo Catalán- *)

  if (iIdioma = 2) then
    NumLetra_BorBla;

  (* Retornar Resultado *)

  Result := Trim(cTexto);
end;


function EurosLetra(Euros: Extended): String;
var
  cadEntera,
  cadDecimal,
  Cadena: string;

  Entera,
  Decimal: Int64;
begin
  CadEntera:='';
  CadDecimal:='';
  result:='';

  cadena:=FormatFloat('0.00',Euros);

  // separa parte entera de decimal
  Entera:=StrToInt(Copy(cadena,1,Pos(',',cadena)-1));

  Decimal:=StrToInt(Copy(cadena,Pos(',',cadena)+1,Length(cadena)));

  // Obtiene en letra parte entera
  if Entera<>0
     then begin
            CadEntera:=NumLetra(Entera,1,1);

            // pone sufijo de la parte entera
            if Entera=1
               then CadEntera:=CadEntera+' EURO'
               else if (Entera=1000000) or (Entera=1000000000000)
                       then CadEntera:=CadEntera+' DE EUROS'
                       else CadEntera:=CadEntera+' EUROS';

          end;

  // Obtiene en letra parte decimal
  if Decimal<>0
     then begin
            CadDecimal:=NumLetra(Decimal,1,1);

            // pone sufijo de la parte decimal
            if Decimal=1
               then CadDecimal:=CadDecimal+' CENTIMO'
               else CadDecimal:=CadDecimal+' CENTIMOS';

            if Entera=0
               then CadDecimal:=CadDecimal+' DE EURO';
          end;


  // Devuleve el resultado
  if (Trim(CadEntera)<>'') and (Trim(CadDecimal)<>'')
     then result:=CadEntera+' CON '+CadDecimal
     else result:=Trim(CadEntera+CadDecimal);
end;

function EurosLetra_SinEuros(Euros: Extended): String;
var
  cadEntera,
  cadDecimal,
  Cadena: string;

  Entera,
  Decimal: Int64;
begin
  CadEntera:='';
  CadDecimal:='';
  result:='';

  cadena:=FormatFloat('0.00',Euros);

  // separa parte entera de decimal
  Entera:=StrToInt(Copy(cadena,1,Pos(',',cadena)-1));

  Decimal:=StrToInt(Copy(cadena,Pos(',',cadena)+1,Length(cadena)));

  // Obtiene en letra parte entera
  if Entera<>0
     then begin
            CadEntera:=NumLetra(Entera,1,1);
          end;

  // Obtiene en letra parte decimal
  if Decimal<>0
     then begin
            CadDecimal:=NumLetra(Decimal,1,1);

            // pone sufijo de la parte decimal
            if Decimal=1
               then CadDecimal:=CadDecimal+' CENTIMO'
               else CadDecimal:=CadDecimal+' CENTIMOS';
          end;


  // Devuleve el resultado
  if (Trim(CadEntera)<>'') and (Trim(CadDecimal)<>'')
     then result:=CadEntera+' CON '+CadDecimal
     else result:=Trim(CadEntera+CadDecimal);
end;


end.
