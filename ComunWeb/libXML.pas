{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11136: libXML.pas 
{
{   Rev 1.1    08/05/2017 8:57:38  Fran
}
{
{   Rev 1.0    17/02/2017 9:22:22  Supervisor
}
unit libXML;

interface

{ ********************************************************************************

  Validar XML desde XSD :

  http://www.utilities-online.info/xsdvalidation/#.Um_P6VMljAw


  Validar XML :

  http://www.xmlvalidation.com/
  http://www.mobilefish.com/services/sepa_xml_validation/sepa_xml_validation.php    Ver 1.1.3


  Formateador XML :

  http://www.freeformatter.com/xml-formatter.html#ad-output



  Utilidad para validar segun un XSD :

  http://www.freeformatter.com/xml-validator-xsd.html


  Notas :
  - Se distinguen entre mayusculas y minusculas
  - Recordar de guardar el fichero .fmt en UTF-8 y BOM

  ********************************************************************************** }

uses DBClient, Classes, DB, XMLIntf, XMLDOM, XMLDoc;

type
  TProcedimientoFormateo = procedure(Campo: TField; var Formateado: string);
  TProcedimientoFormateaTemplate = procedure(cdsDatos: TDataSet; var CadenaTemplateTmp: string);
  TProcedimientoRegistroProcesado = procedure(cdsDatos: TDataSet; var CadenaTemplateTmp: string);

procedure XMLGuarda(cdsXML: TClientDataSet; FicheroXSDConvertido, FicheroXML: String;
  FuncionFormatea: TProcedimientoFormateo = nil; FormateaTemplate: TProcedimientoFormateaTemplate = nil;
  FuncionRegistroProcesado: TProcedimientoRegistroProcesado = nil; EliminaComentarios : Boolean = True);

// procedure XMLCarga(cdsXML: TClientDataSet; FicheroFMT, FicheroXML: String);
// FuncionFormatea : TProcedimientoFormateo = nil; FormateaTemplate : TProcedimientoFormateaTemplate = nil);


// procedure XMLCarga(cdsXML: TClientDataSet; FicheroXSDConvertido, FicheroXML: String);

function XMLDetectarTipo_Certifica2(FicheroXML: String): Integer; // ; CertificadosXML: TXMLDocument

procedure ConvertirXSDBeta(FicheroXSD: string; var DocumentoSalida, Campos: TStrings);

function XMLEliminaEtiqueta(Cadena, Etiqueta: string): string;
function XMLEliminaEtiquetaComentario(Cadena, EtiquetaIni, EtiquetaFin: string): string;
// function XMLEliminaEtiquetaComentario(Cadena : string): string;override;

// ListaNodos := XMLSelectNodes(LDocument.DocumentElement, '//bookstore[*]/book/title[text()="The Bean Trees"]');
// '//Element[@attribute1="abc" and @attribute2="xyz" and text()="Data"]'
//
// Ejemplo :
// ListaNodosLiquidaciones := XMLSelectNodes(LDocument.documentElement, '//DCL/Liquidacion[*]/DatosCuerpoDCL/LineasDCL/LineaDCL[*]/DescripcionLDCL[text()="LIQUIDO DE TOTALES"]');
//
// Para acceder al nodo :
// ListaNodosLiquidaciones.Nodes[0].NodeName
// Para acceder al nodo Padre :
// ListaNodosLiquidaciones.Nodes[0].DOMNode.parentNode.nodeName

function XMLSelectNodes(xnRoot: IXmlNode; const nodePath: WideString): IXMLNodeList;
function XMLSelectNode(Padre: IXmlNode; Ruta: string): IXmlNode; // XMLLocalizaNodo

function XMLEliminaAtributos(RutaFichero: string; Etiquetas: array of string): IXMLDocument;

function XMLQuitarCamposVacios(LineaModelo: string): string;


// Formatea un fichero XML
procedure XMLFormateaFichero(const NombreFicheroXML:string; Encoding : string = '');

//
function XMLCambiarCaracteresReservados (texto : string) : string;

implementation

uses libCAIStrings, StrUtils, SysUtils, Dialogs, Diagnostics;

{ *******************************************************************************

  cdsXML :                  DataSet principal del que obtener datos. De este se recorreran los detalles
  FicheroXSDConvertido  :   Fichero fmt con la definicion del formato
  FicheroXML  :             Fichero de salida
  [FuncionFormatea] :       Funcion para formatear valores de los campos. P.e. Por si el formato de fecha es diferente
  [FormateaTemplate]  :     Funcion que retoca el template del DataSet que se sera procesando. Por si se quiere eliminar etiquetas o añadirlas segun alguna condicion
  [FuncionRegistroProcesado]  :     Funcion para hacer algo una vez procesado un registro. Por ejemplo actualizar un valor
  [EliminaComentarios];      Indica si se quiere eliminar los comentarios una vez finalizado la generación del fichero

  ******************************************************************************* }
procedure XMLGuarda(cdsXML: TClientDataSet; FicheroXSDConvertido, FicheroXML: String;
  FuncionFormatea: TProcedimientoFormateo = nil; FormateaTemplate: TProcedimientoFormateaTemplate = nil;
  FuncionRegistroProcesado: TProcedimientoRegistroProcesado = nil; EliminaComentarios : Boolean = True);
var
  DocumentoXML: TStringList;
  DocumentoSalida: TStringList;
  s: string;
  i: Integer;

  codificacion : string;
  inicio, fin : integer;

  function QuitarRetornoIzq(s: string): string;
  var
    i, p: Integer;
  begin
    Result := s;
    p := 0;
    for i := 0 to Length(Result) - 1 do

      if not(Result[i + 1] in [Char(10), Char(13)]) then
      begin
        p := i;
        break;
      end;

    if p <> 0 then
      Result := CAIStrRecortar(Result, p, 0);
  end;
  function QuitarRetornoDch(s: string): string;
  var
    i, p: Integer;
  begin
    Result := s;
    p := 0;
    for i := Length(Result) - 1 downto 0 do
      if not(Result[i + 1] in [Char(10), Char(13)]) then
      begin
        p := i;
        break;
      end;

    if p <> 0 then
      Result := Copy(Result, 1, p + 1);
  end;

  function Fusiona(CdsTmp: TDataSet): string;
  var
    i, j: Integer;
    sValor: string;
    CadenaTemplate: string;
    CadenaTemplateTmp: string;
    oDetails: TList;
  begin
    Result := '';

    oDetails := TList.Create;
    try
      // El Lefttrim extra, elimina los posibles retornos de carro al inicio y al fin del template
      CadenaTemplate := QuitarRetornoIzq(CAIStrEntreCaracteresV1(DocumentoXML.Text, '%' + CdsTmp.Name + '_Ini%', '%' + CdsTmp.Name + '_Fin%'));

      if (Trim(CadenaTemplate) <> '') then
      begin

        CdsTmp.First;
        while not CdsTmp.eof do
        begin
          CadenaTemplateTmp := CadenaTemplate;

          if assigned(FormateaTemplate) then
            FormateaTemplate(CdsTmp, CadenaTemplateTmp);

          for i := 0 to CdsTmp.FieldCount - 1 do
          begin
            // Tipo Fecha
            if CdsTmp.Fields.Fields[i].DataType = ftDate then
            begin
              if CdsTmp.Fields.Fields[i].AsDateTime <> 0 then
                sValor := FormatDateTime('yyyymmdd', CdsTmp.Fields.Fields[i].AsDateTime)
              else
                // Vacio
                sValor := '';
            end
            else
              // Entero
              if CdsTmp.Fields.Fields[i].DataType in [ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte] then
                sValor := CAIStrSoloCaracteres(CdsTmp.Fields.Fields[i].Text, CharsNumeros) // Empleamos la propiedades del Tfield para el formato
              else
                // Float
                if CdsTmp.Fields.Fields[i].DataType in [ftFloat, ftCurrency, ftBCD, ftExtended] then
                  sValor := CAIStrSoloCaracteres(CdsTmp.Fields.Fields[i].Text, CharsNumeros) // Empleamos la propiedades del Tfield para el formato
                else
                // Cadena
                begin
                  sValor := CdsTmp.Fields.Fields[i].AsString;
                  // No se si funciona o la fastidia totalmente             sValor := CAIStrReemplazarCadenas(CdsTmp.Fields.Fields[i].AsString, ['&','<', '>', '"'], ['&amp','&lt', '&gt', '&quot']);
                  {
                    & (ampersand)		&amp;
                    < (menor que)		&lt;
                    > (mayor que)		&gt;
                    “ (dobles comillas)	&quot;
                    ' (apóstrofe)		&apos;
                  }

                end;

            if assigned(FuncionFormatea) then
              FuncionFormatea(CdsTmp.Fields.Fields[i], sValor);

            CadenaTemplateTmp := AnsiReplaceStr(CadenaTemplateTmp, '%' + CdsTmp.Fields.Fields[i].FieldName + '%', sValor);
          end;

          // Tiene Detalles?
          CdsTmp.GetDetailDataSets(oDetails);
          if oDetails.Count > 0 then
          begin
            for j := 0 to oDetails.Count - 1 do
              CadenaTemplateTmp := AnsiReplaceStr(CadenaTemplateTmp, '%' + TDataSet(oDetails[j]).Name + '%', Fusiona(TDataSet(oDetails[j])));
          end;

          // Para hacer algo una vez procesado un registro. Por ejemplo actualizar un valor
          if assigned(FuncionRegistroProcesado) then
            FuncionRegistroProcesado(CdsTmp, CadenaTemplateTmp);

          Result := Result + CadenaTemplateTmp;

          CdsTmp.Next;
        end;
      end
      else
      begin
        // Comentado. Porque se podria necesitar que algun clientdataset detalle este enlazado y no lo utilicemos. Pasa en Laboral
        // ShowMessage('No encontrado template en fichero. Etiquetas ' + '%' + CdsTmp.Name + '_Ini% y %' + CdsTmp.Name + '_Fin%');
      end;

    finally
      oDetails.Free;
    end;

    Result := QuitarRetornoDch(Result);

  end;

begin

  DocumentoXML := TStringList.Create;
  DocumentoSalida := TStringList.Create;
  try
    DocumentoXML.LoadFromFile(FicheroXSDConvertido);

    // Cabecera Extra
    //
    s := Trim(CAIStrEntreCaracteresV1(DocumentoXML.Text, '%Cabecera_Ini%', '%Cabecera_Fin%'));


    if assigned(FormateaTemplate) then
      FormateaTemplate(nil, s);

    if s <> '' then
      DocumentoSalida.Add(s);

    // Cuerpo XML
    //
    DocumentoSalida.Add(Fusiona(cdsXML));

    // Pie Extra
    //
    s := Trim(CAIStrEntreCaracteresV1(DocumentoXML.Text, '%Pie_Ini%', '%Pie_Fin%'));

    if assigned(FormateaTemplate) then
      FormateaTemplate(nil, s);

    if s <> '' then
      DocumentoSalida.Add(s);

    // Borra Etiquetas Vacias
    DocumentoSalida.Text := XMLQuitarCamposVacios(DocumentoSalida.Text);

    // Eliminamos los caracteres chr(128). Esto se emplea para que la funcion anterior (XMLQuitarCamposVacios) no eliminera la etiqueta
    DocumentoSalida.Text := AnsiReplaceStr(XMLQuitarCamposVacios(DocumentoSalida.Text), char(128), '');

    // Borrar lineas en blanco
    for i := DocumentoSalida.Count - 1 downto 0 do
      if Trim(DocumentoSalida.Strings[i]) = '' then
        DocumentoSalida.Delete(i);

    // XMLFormateaFichero se borra la codificación UTF-8. Hay que pasarselo para que no la borre.
    s := DocumentoSalida.Text;
    Codificacion := '';
    inicio := System.Pos('encoding="', s) + length('encoding="');
    fin := PosEx('"', s, inicio);

    if (Inicio > 0) and (fin > 0) and (Inicio < fin)  then
      Codificacion := Copy(s,inicio , fin - Inicio);


//    s := XMLEliminaComentarios(s);



//  18/03/2016. Comentado momentaneamente hasta que se hagan pruebas buenas.
//    s := CAIStrEliminaEntreCadenas(s, '<!--', '-->');


    DocumentoSalida.Text  := s;


    DocumentoSalida.SaveToFile(FicheroXML);

    // Formatea
    XMLFormateaFichero(FicheroXML, Codificacion);

  finally
    DocumentoXML.Free;
    DocumentoSalida.Free;
  end;
end;

{ *******************************************************************************
  Para convertir de XSD a .FMT
  No hace todo el proceso... sino lo mas gordo
  Despues falta trocearlo, poner campos y variables %%, elimininar Cantidad=, ...
  Muy importente: Si se quiere tener dentado el codigo emplear tabs y ningun espacio. Ej. ProcedimientoERE.fmt

  http://www.freeformatter.com/xml-formatter.html#ad-output


  No funciona. Porque hay muchas variaciones del formato xsd
  ******************************************************************************* }

procedure ConvertirXSDBeta(FicheroXSD: string; var DocumentoSalida, Campos: TStrings);
var

  nosResultadoTmp: IDOMNodeList;
  iNodeTmp: IDOMNode;

  DocumentoXSD: TXMLDocument;
  DocumentoEntrada: TStringList; // , DocumentoSalida
  StreamEntrada: TMemoryStream;

  Node, NodoTmp, NodoPrincipal: IDOMNode;
  NodeList: IDOMNodeList;

  i: Integer;
  s: string;

  Sel: IDOMNodeSelect;

  // xml: TXMLDocument;
  noNodoDocumento: IDOMNodeSelect; // NodeSelect raiz del documento

  function BuscaNodoHijo(lNodo: IDOMNode; Nombre: string): IDOMNode;
  var
    k1: Integer;
  begin
    Result := nil;
    for k1 := 0 to lNodo.Childnodes.Length - 1 do
      if lNodo.Childnodes.item[k1].NodeName = Nombre then
        Result := lNodo.Childnodes.item[k1];
  end;

  procedure ProcesaElemento(sNodo: string); // ; NodoNombre: string = ''
  var
    i, j: Integer;
    s2: string;
    nosResultado, nosSequence: IDOMNodeList;
    iNode: IDOMNode;
    NodeTmp: IDOMNode;
    NodeListTmp: IDOMNodeList;
    sTmp: string;
  begin

    nosResultado := noNodoDocumento.selectNodes('//schema/*');
    nosResultado := noNodoDocumento.selectNodes('//schema');

    nosResultado := noNodoDocumento.selectNodes('/schema/*');
    nosResultado := noNodoDocumento.selectNodes('/schema');

    nosResultado := noNodoDocumento.selectNodes(sNodo + '/sequence/element');

    if (nosResultado.Length = 0) then
      nosResultado := noNodoDocumento.selectNodes(sNodo + '/sequence/choice');

    if (nosResultado.Length = 0) then
      nosResultado := noNodoDocumento.selectNodes(sNodo);

    if (nosResultado.Length = 0) then
      ShowMessage('No encontrado')
    else
      ShowMessage('Encontrado');

    {
      begin
      // Tipo Simple ?
      s2 := AnsiReplaceStr(sNodo, '//complexType', '//simpleType') + '/restriction';
      nosResultado := noNodoDocumento.selectNodes(s2);

      if (nosResultado.Length = 0) then
      begin
      ShowMessage('Busqueda no retorno resultado.' + s2);
      end
      else
      begin
      // Tipo simple
      //

      // DocumentoSalida.Add('%' + NodoNombre + '% Tipo :' + nosResultado[0].attributes.getNamedItem('base').NodeValue);

      // Propiedad pattern?
      sTmp := '';
      NodeTmp := BuscaNodoHijo(nosResultado[0], 'pattern');
      if NodeTmp <> nil then
      sTmp := ' Patron = ' + NodeTmp.attributes.getNamedItem('value').NodeValue;

      DocumentoSalida.Add('%' + '' + '% Tipo :' + nosResultado[0].attributes.getNamedItem('base').NodeValue
      + sTmp);
      end;
      end
      else
      begin
      // Tipo complejo. Tipo <Element
      for i := 0 to nosResultado.Length - 1 do
      begin

      // for j := 0 to nosResultado[i]. attributes.length - 1 do
      // ShowMEssage('Atributo : ' + nosResultado[i].attributes.item[j].nodeName + ' : ' + nosResultado[i].attributes.item[j].nodeValue);
      //
      //
      // for j := 0 to nosResultado[i].childNodes.length - 1 do
      // ShowMEssage('Nodos Hijos : ' + nosResultado[i].childNodes.item[j].nodeName + ' : ' + nosResultado[i].childNodes.item[j].nodeValue);
      //

      if Assigned(nosResultado[i].attributes.getNamedItem('name')) then
      begin

      // Tiene varios registros?

      s := '';
      if Assigned(nosResultado[i].attributes.getNamedItem('maxOccurs')) then
      s := ' Cantidad="' + nosResultado[i].attributes.getNamedItem('maxOccurs').NodeValue + '" ';

      if Assigned(nosResultado[i].attributes.getNamedItem('minOccurs')) then
      s := ' CantidadMin="' + nosResultado[i].attributes.getNamedItem('minOccurs').NodeValue + '" ';


      // maxOccurs="31"
      // maxOccurs="unbounded"

      DocumentoSalida.Add('<' + nosResultado[i].attributes.getNamedItem('name').NodeValue + s + '>');

      iNode := nosResultado[i];
      // Tipo definido
      if Assigned(iNode.attributes.getNamedItem('type')) then
      begin
      // Tipo type (complejo)
      // <<<
      // Max35Text
      // <xsd:complexType name="Party6Choice">

      // ProcesaElemento

      NodeListTmp := noNodoDocumento.selectNodes('//complexType[@name = "' + iNode.attributes.getNamedItem('type').NodeValue + '"]');
      if NodeListTmp <> nil then
      begin
      ProcesaElemento('//complexType[@name = "' + iNode.attributes.getNamedItem('type').NodeValue + '"]', nosResultado[i].attributes.getNamedItem('name').NodeValue);
      end
      else
      begin
      NodeListTmp := noNodoDocumento.selectNodes('//schema/complexType[@name = "' + iNode.attributes.getNamedItem('type').NodeValue + '"]');
      if NodeListTmp = nil then
      ShowMessage('No encontrato : ' + '//schema/complexType[@name = "' + iNode.attributes.getNamedItem('type').NodeValue + '"]');
      end;

      end
      else
      begin

      for j := 0 to iNode.Childnodes.Length - 1 do
      if iNode.Childnodes.item[j].NodeName = 'simpleType' then
      begin

      if Assigned(BuscaNodoHijo(iNode.Childnodes.item[j], 'restriction')) then // SelectSingleNode('
      begin

      // Propiedad pattern?
      sTmp := '';
      NodeTmp := BuscaNodoHijo(iNode.Childnodes.item[j], 'restriction');
      if NodeTmp <> nil then
      NodeTmp := BuscaNodoHijo(NodeTmp, 'pattern');

      if NodeTmp <> nil then
      sTmp := ' Patron = ' + NodeTmp.attributes.getNamedItem('value').NodeValue;




      // DocumentoSalida.Add('Tipo :' + BuscaNodoHijo(iNode.Childnodes.item[j], 'restriction').attributes.getNamedItem('base').NodeValue );

      DocumentoSalida.Add('Tipo :' + BuscaNodoHijo(iNode.Childnodes.item[j], 'restriction').attributes.getNamedItem('base').NodeValue
      + sTmp

      // ' Patron = ' + BuscaNodoHijo(
      // BuscaNodoHijo(iNode.Childnodes.item[j], 'restriction'), 'pattern' )
      // .attributes.getNamedItem('value').NodeValue
      //

      );

      // <xsd:restriction base="xsd:string">
      // <xsd:pattern value="(((19|20)\d\d(0[13456789]|1[012])(0[1-9]|[12][0-9]|3[01]))|((19|20)\d\d(02)(0[1-9]|[12][0-9])))"/>
      // </xsd:restriction>

      end;
      end;

      end;

      DocumentoSalida.Add('</' + nosResultado[i].attributes.getNamedItem('name').NodeValue + '>');
      end;
      end;
      end;
    }

  end;

begin
  DocumentoXSD := TXMLDocument.Create(nil);
  DocumentoEntrada := TStringList.Create();
  DocumentoSalida := TStringList.Create();
  Campos := TStringList.Create();
  StreamEntrada := TMemoryStream.Create();
  try

    // Eliminamos xsd: o xs:
    DocumentoEntrada.LoadFromFile(FicheroXSD);
    for i := 0 to DocumentoEntrada.Count - 1 do
    begin
      DocumentoEntrada.Strings[i] := AnsiReplaceStr(DocumentoEntrada.Strings[i], 'xsd:', '');
      DocumentoEntrada.Strings[i] := AnsiReplaceStr(DocumentoEntrada.Strings[i], 'xs:', '');
    end;
    DocumentoEntrada.SaveToStream(StreamEntrada);

    // Cargamos y procesamos
    DocumentoXSD.LoadFromStream(StreamEntrada);
    // noNodoDocumento := (DocumentoXSD.DOMDocument.documentElement as IDOMNodeSelect);


    // DocumentoXSD.DOMDocument.documentElement.

    noNodoDocumento := (DocumentoXSD.DOMDocument.documentElement as IDOMNodeSelect);
    nosResultadoTmp := noNodoDocumento.selectNodes('//schema');
    iNodeTmp := noNodoDocumento.selectNode('//schema');

    if nosResultadoTmp.Length = 0 then
      ShowMessage('No encontrado');

    if iNodeTmp = nil then
      ShowMessage('No encontrado');

    {
      <xsd:schema xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03" xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified" targetNamespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
      <!-- NIVEL 0 -->
      <!-- Definición del elemento raiz -->
      <xsd:element name="Procedimiento_ERE" type="ERE_TYPE"/>
    }

    // ProcesaElemento('//schema/element');

    // DocumentoSalida.SaveToFile(FicheroSalida);

  finally
    DocumentoXSD.Free;
    // DocumentoSalida.Free;
    DocumentoEntrada.Free;
    StreamEntrada.Free;
  end;

  ShowMessage('Terminado. Falta Formatear Documento. Añadir alguna cabecera y separa las etiquetas que tengan Cantidad, asignar tamaños a campos.');
end;

{ *******************************************************************************
  Detecta el tipo de fichero XML. Tipo de Certifica2
  ******************************************************************************* }
function XMLDetectarTipo_Certifica2(FicheroXML: String): Integer; // ; CertificadosXML: TXMLDocument
var
  NodoRaiz: IXmlNode;
  // CertificadosXML: TXMLDocument;
  CertificadosXML: IXMLDocument; // Si no se pasa el self en el create. hay que hacer en lugar de TXMLDocument un IXMLDocument
  i: Integer;
begin
  Result := -1;
  CertificadosXML := LoadXMLDocument(FicheroXML);
  try
    with CertificadosXML do
    begin

      NodoRaiz := documentElement;

      Result := 0;
      // CERTIFIC@2 - Certificado Empresa
      if UpperCase(NodoRaiz.LocalName) = 'CERTIFICADO_EMPRESA' then
        Result := 1
      else
        // CERTIFIC@2 - Periodo de Actividad
        if UpperCase(NodoRaiz.LocalName) = 'COMUNICACION_UNICA' then
          Result := 2
        else
          // CERTIFIC@2 - Procedimiento ERE
          if UpperCase(NodoRaiz.LocalName) = 'PROCEDIMIENTO_ERE' then
            Result := 3
          else
            // CERTIFIC@2 - Certificado Empresa
            if UpperCase(NodoRaiz.LocalName) = 'RESPUESTA_CERTIFICADO_EMPRESA' then
              Result := 129 // 128 + 1
            else
              // CERTIFIC@2 - Periodo de Actividad
              if UpperCase(NodoRaiz.LocalName) = 'RESPUESTA_COMUNICACION_UNICA' then
                Result := 130 // 128 + 2
              else
                // CERTIFIC@2 - Procedimiento ERE
                if UpperCase(NodoRaiz.LocalName) = 'RESPUESTA_PROCEDIMIENTO' then
                  Result := 131 // 128 + 3
                else
                  ShowMessage('Desconocido : ' + NodoRaiz.LocalName);
    end;
  finally
    CertificadosXML.Active := False;
  end;
end;

{ *******************************************************************************
  Localiza un nodo concreto a partir de una sección del XML.
  La Ruta tiene que se unica. Si hay varios Procedimiento_ERE y el primero no
  tiene Datos_Empresa/CIFNIF no lo localizaria.

  Distingue entre mayusculas y minusculas

  Ej.
  NodoTmp := XMLSelectNode(CertificadosXML.DocumentElement, 'Procedimiento_ERE/Datos_Empresa/CIFNIF');
  ******************************************************************************* }
function XMLSelectNode(Padre: IXmlNode; Ruta: string): IXmlNode;
var
  NodoTmp: IXmlNode;
  s: string;
begin
  NodoTmp := Padre.Childnodes.FindNode(CAIStrObtenerElemento(Ruta, 0, '/'));
  if assigned(NodoTmp) then
  begin
    if CAIStrObtenerNumeroElementos(Ruta, '/') > 1 then
    begin
      s := CAIStrRecortar(Ruta, Pos('/', Ruta), 0);
      Result := XMLSelectNode(NodoTmp, s);
    end
    else
      Result := NodoTmp;
  end;
end;

function XMLEliminaEtiqueta(Cadena, Etiqueta: string): string;
begin
  Result := Cadena;
  Result := CAIStrEliminaEntreCadenasPrimeraYUltima(Result, '<' + Etiqueta + '>', '</' + Etiqueta + '>');
  Result := AnsiReplaceStr(Result, '<' + Etiqueta + '></' + Etiqueta + '>', '');
end;

function XMLEliminaEtiquetaComentario(Cadena, EtiquetaIni, EtiquetaFin: string): string;
begin
  Result := Cadena;
  Result := CAIStrEliminaEntreCadenasPrimeraYUltima(Result, '<!--' + EtiquetaIni + '-->', '<!--' + EtiquetaFin + '-->');
  Result := AnsiReplaceStr(Result, '<!--' + EtiquetaIni + '--><!--' + EtiquetaFin + '-->', '');
end;

// function XMLEliminaEtiquetaComentario(Cadena : string): string;
// var
// i : Integer;
// begin
// Result := Cadena;
//
// i := Pos('<!--',Result);
// // Si existe <!-- y un --> posterior
// while (i > 0) and (Pos('-->',Copy(Result,i, StrLen(Result))) > 0) do
// begin
// str
//
// i := Pos('<!--',Result);
// end;
//
//
/// /  Result := CAIStrEliminaEntreCadenas(Result, '<!--' + EtiquetaIni + '-->', '<!--' + EtiquetaFin + '-->');
/// /  Result := AnsiReplaceStr(Result, '<!--' + EtiquetaIni + '--><!--' + EtiquetaFin + '-->', '');
// end;

{ *******************************************************************************

  ListaNodos : IXMLNodeList;

  ListaNodos := XMLSelectNodes(LDocument.DocumentElement, '//bookstore[*]/book/title[text()="The Bean Trees"]');
  '//Element[@attribute1="abc" and @attribute2="xyz" and text()="Data"]'

  iNodeListPeculiaridad := (NodoTmp3.DOMNode as IDomNodeSelect).selectNodes('InformacionAfiliacion/Peculiaridades/Peculiaridad[CodPec=23]');



  Nota. Diferencia entre mayusculas y minusculas

  Ejemplo. Localiza todas las 'Respuesta/Liquidaciones' y luego dentro de la primera localizad el nodo 'Ccc', valdria tambien 'Ccc/Regimen'

  ListaNodos2   := XMLSelectNodes(LDocument.DocumentElement, '//Respuesta/Liquidacion');
  ListaNodos  := XMLSelectNodes(ListaNodos2.Nodes[0], 'Ccc');


  Ejemplo 2 (Creta Calculos xml) :

    // Localiza los trabajadores cuyo Naf sea "111111111111" y que tenga un tramo con del mes 12
    Lista := XMLSelectNodes(LDocument.documentElement, '//Calculos/Liquidacion/Trabajadores/Trabajador[ Naf[text()="111111111111"] and Tramos/Tramo/FechaDesde/Mes[text()="12"]]');

    if Lista.Count > 0 then
    begin
      // Del primer trabajador obtiene los tramos del mes 12
      Lista2 := XMLSelectNodes(Lista.Nodes[0], 'Tramos/Tramo[FechaDesde/Mes[text()="12"]]');

      ShowMessage(IntToStr(Lista2.Count));

    end;

    ....
    // Se podria poner /.. al final para devolver el nodo Trabajadores
    Lista := XMLSelectNodes(LDocument.documentElement, '//Calculos/Liquidacion/Trabajadores/Trabajador[ Naf[text()="111111111111"] and Tramos/Tramo/FechaDesde/Mes[text()="12"]]/..');


  Ejemplo 3 : Localiza todos los //Calculos/Liquidacion/Trabajadores/Trabajador/Tramos/Tramo/CalculosTramo/DatoCalculado. Pero tiene que cumplir una seria de cosas, por ejemplo el Naf del trabajador
          s := '//Calculos/Liquidacion/Trabajadores/Trabajador[Naf[text()="' + dmCreta.cdsTrabajadoresNAF.AsString + '"]]'
          + '/Tramos/Tramo[FechaDesde/Anho[text()="' + IntToStr(dmCreta.FAno) + '"] and FechaDesde/Mes[text()="' + CAIStrRellenar(IntToStr(dmCreta.FMes), 2, '0', 'I') + '"]' + ']'
          + '/CalculosTramo/DatoCalculado[*]';

          ListaTrabajadores := XMLSelectNodes(LDocument.documentElement, s);


  ******************************************************************************* }
function XMLSelectNodes(xnRoot: IXmlNode; const nodePath: WideString): IXMLNodeList;
var
  intfSelect: IDOMNodeSelect;
  intfAccess: IXmlNodeAccess;
  dnlResult: IDOMNodeList;
  intfDocAccess: IXmlDocumentAccess;
  doc: TXMLDocument;
  i: Integer;
  dn: IDOMNode;
begin
  Result := nil;
  if not assigned(xnRoot)
    or not Supports(xnRoot, IXmlNodeAccess, intfAccess)
    or not Supports(xnRoot.DOMNode, IDOMNodeSelect, intfSelect) then
    Exit;

  dnlResult := intfSelect.selectNodes(nodePath);
  if assigned(dnlResult) then
  begin
    Result := TXmlNodeList.Create(intfAccess.GetNodeObject, '', nil);
    if Supports(xnRoot.OwnerDocument, IXmlDocumentAccess, intfDocAccess) then
      doc := intfDocAccess.DocumentObject
    else
      doc := nil;

    for i := 0 to dnlResult.Length - 1 do
    begin
      dn := dnlResult.item[i];
      Result.Add(TXmlNode.Create(dn, nil, doc));
    end;
  end;
end;

function XMLEliminaAtributos(RutaFichero: string; Etiquetas: array of string): IXMLDocument;
var
  i, j: Integer;
  DocumentoEntrada: TStringList; // , DocumentoSalida
  StreamEntrada: TMemoryStream;
  DocumentoSalida: TStringList;
begin
  Result := TXMLDocument.Create(nil);
  DocumentoEntrada := TStringList.Create();
  StreamEntrada := TMemoryStream.Create();
  try

    // Eliminamos xsd: o xs:
    DocumentoEntrada.LoadFromFile(RutaFichero);
    for i := 0 to DocumentoEntrada.Count - 1 do
    begin
      for j := Low(Etiquetas) to High(Etiquetas) do
        if Pos('<' + Etiquetas[j] + ' ', DocumentoEntrada.Strings[i]) > 0 then
          DocumentoEntrada.Strings[i] := '<' + Etiquetas[j] + '>';
    end;
    DocumentoEntrada.SaveToStream(StreamEntrada);

    // Cargamos y procesamos
    Result.LoadFromStream(StreamEntrada);
  finally
    if assigned(DocumentoEntrada) then
      FreeAndNil(DocumentoEntrada);

    if assigned(StreamEntrada) then
      FreeAndNil(StreamEntrada);

  end;
end;

{ *******************************************************************************
  ******************************************************************************* }
function XMLQuitarCamposVacios(LineaModelo: string): string;
var
  i: Integer;
  Pos1, Pos2: Integer;
begin
  // LineaModelo := CAIStrReemplazarCadenas(LineaModelo, [#9, #10, #13], '');
  LineaModelo := CAIStrEliminaCaracteres(LineaModelo); // Esta funcion mejora muchisimo la velocidad para cadenas grandes

  LineaModelo := CAIStrReemplazarCadenas(LineaModelo, ['>0.0000<', '>0.000<', '>0.00<', '>0.0<', '>0<'], '><');
  i := Pos('></', LineaModelo);
  while i > 0 do
  begin
    Pos1 := Pos('<', ReverseString(Copy(LineaModelo, 1, i - 1)));
    Pos2 := Pos('>', Copy(LineaModelo, i + 3, Length(LineaModelo) - i - 3 + 1));

    if Copy(LineaModelo, i + 3, Pos('>', Copy(LineaModelo, i + 3, Length(LineaModelo) - i - 3 + 1)) - 1) =
      Copy(LineaModelo, i - Pos1 + 1, Pos1 - 1) then
      LineaModelo := ReplaceText(LineaModelo
        , '<' + Copy(LineaModelo, i + 3, Pos2 - 1) + '></' + Copy(LineaModelo, i + 3, Pos2 - 1) + '>'
        , '')
    else
      LineaModelo := StuffString(LineaModelo, i, 3, 'ßßß');
    i := Pos('></', LineaModelo);
  end;
  LineaModelo := ReplaceText(LineaModelo, 'ßßß', '></');
  Result := LineaModelo;
end;


{*******************************************************************************

*******************************************************************************}
Procedure XMLFormateaFichero(const NombreFicheroXML:string; Encoding : string = '');
var
   oXml : IXMLDocument;
   EtiquetaXMLIni : string;
   inicio, fin : Integer;
   s : string;
begin
 oXml := TXMLDocument.Create(nil);
 try

   oXml.LoadFromFile(NombreFicheroXML);


   // Parece que la funcion FormatXMLData no funciona (da una exception si encuentra un comentario vacio tipo <!---->
   oXml.XML.Text  := AnsiReplaceStr(oXml.XML.Text,'<!---->','');

//   oXml.XML.Text  := AnsiReplaceStr(oXml.XML.Text,#9,'');
//   oXml.XML.Text  := AnsiReplaceStr(oXml.XML.Text,#10,'');
//   oXml.XML.Text  := AnsiReplaceStr(oXml.XML.Text,#13,'');
//   oXml.XML.Text  := AnsiReplaceStr(oXml.XML.Text,#13#10,'');
//   oXml.XML.Text  := AnsiReplaceStr(oXml.XML.Text,#10#13,'');

   // Formateamos
   oXml.XML.Text:=xmlDoc.FormatXMLData(oXml.XML.Text);


   oXml.Active := true;
   // Forzamos a guardar con codificacion. Parece ser que si es UTF-8 no se guarda salvo que se lo asignemos otra vez
   if Encoding <> '' then
     oXml.Encoding  := Encoding;
   oXml.SaveToFile(NombreFicheroXML);
 finally
   oXml := nil;
 end;
end;


{*******************************************************************************

*******************************************************************************}
function XMLCambiarCaracteresReservados (texto : string) : string;
var
  cadAux : string;
begin
  cadAux := texto;
  cadAux := AnsiReplaceStr(cadAux, '&', '&amp;');
  cadAux := AnsiReplaceStr(cadAux, '"', '&quot;');
  cadAux := AnsiReplaceStr(cadAux, '<', '&lt;');
  cadAux := AnsiReplaceStr(cadAux, '>', '&gt;');
  cadAux := AnsiReplaceStr(cadAux, chr(39), '&apos;');
  Result := cadAux;
end;



{*******************************************************************************

*******************************************************************************}







{
  if Copy(LineaModelo, i + 3,
  Pos('>', Copy(LineaModelo, i + 3, Length(LineaModelo) - i - 3 + 1))
  - 1) =
  Copy(LineaModelo, i -
  Pos('<', ReverseString(Copy(LineaModelo, 1, i - 1)))
  + 1,
  Pos('<', ReverseString(Copy(LineaModelo, 1, i - 1)))
  - 1) then
  LineaModelo := ReplaceText(LineaModelo, '<' + Copy(LineaModelo, i + 3,
  Pos('>', Copy(LineaModelo, i + 3, Length(LineaModelo) - i - 3 + 1))
  - 1) + '></' +
  Copy(LineaModelo, i + 3,
  Pos('>', Copy(LineaModelo, i + 3, Length(LineaModelo) - i - 3 + 1)) - 1) + '>', '')
}

{ *******************************************************************************

  ******************************************************************************* }

// procedure XMLCarga(cdsXML: TClientDataSet; FicheroFMT, FicheroXML: String);
// var
// oDetails: TList;
// i: Integer;
// DocumentoXML : TStringList;
// DocumentoFmt : TStringList;
//
//
// begin
//
// oDetails := TList.Create;
// DocumentoXML := TStringList.Create;
// DocumentoXML := TStringList.Create;
// try
// cdsXML.GetDetailDataSets(oDetails);
//
// // Vaciamos DataSets
// //
// cdsXML.EmptyDataSet;
// for i := 0 to oDetails.Count - 1 do
// if TDataSet(oDetails.Items[i]) is TClientDataSet then
// TClientDataSet(oDetails.Items[i]).EmptyDataSet;
//
// // Cargamos Ficheros
// DocumentoXML.LoadFromFile(FicheroXML);
// DocumentoFMT.LoadFromFile(FicheroFMT);
//
//
// Tener en cuenta :
// - Buscar nombre %clientdataset_Ini% y %clientdataset_Fin%
// - Puede haber repetidados varias cabeceras
// - Puede haber repetidados varias detalles
// - Puede haber repetidadas varias secciones de detalles
// - Ver un campo relacion. Rellenar con 1 si al obtener los datos no hay valor para la relacion.
//
// Detalles son los que ne la linea solo tienen %...%
//
//
// NO VALE ESTA FUNCION PORQUE EL RESULTADO QUE DEVUELVEN ELLOS NO SON TAN SENCILLOS Y ESTRUCTURADOS
//
//
//
//
// finally
// DocumentoXML.Free;
// DocumentoFMT.Free;
// oDetails.Free;
// end;
//
// end;



// Esto recorreria el elemento Respuesta_Procedimiento. Recorreria los elementos:
// - Procedimiento_ERE                   Tiene hijos
// - Fecha_Envio_Procedimiento_al_SEPE   Tiene Valor
// - Resultado                           Tiene Hijos
// - Huella_Digital                      Tiene valor
//
// for i := 0 to CertificadosXML.DocumentElement.ChildNodes.Count - 1 do
// begin
/// /      ShowMessage( CertificadosXML.DocumentElement.ChildNodes.Nodes[i].NodeName + ' = ' + CertificadosXML.DocumentElement.ChildNodes.Nodes[i].NodeValue);
// // Indica si simplemente es un valor y no tiene hijos
// if CertificadosXML.DocumentElement.ChildNodes.Nodes[i].IsTextElement then
// ShowMessage('IsTextElement');

// end;
// NodoCertificado_empresa := CertificadosXML.DocumentElement.ChildNodes.FindNode('CIFNIF');   // Busca en los hijos. No es recursivo

{

  procedure FicheroAnsiAutf8(Fichero:String);

  a b c d e f g h i j k l m n o p q r s t u v w x y z
  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
  0 1 2 3 4 5 6 7 8 9
  / - ? : ( ) . , ' +

  & (ampersand)		&amp;
  < (menor que)		&lt;
  > (mayor que)		&gt;
  “ (dobles comillas)	&quot;
  ' (apóstrofe)		&apos;
}
end.
