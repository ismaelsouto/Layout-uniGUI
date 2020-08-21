unit frm_Listados_Personalizados_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Listados, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, uniGUIBaseClasses,
  uniScreenMask, FireDAC.Comp.Client, ppDB, ppDBPipe, ppParameter, ppDesignLayer,
  ppBands, ppCache, ppClass, ppComm, ppRelatv, ppProd, ppReport, Data.DB,
  FireDAC.Comp.DataSet, uniToolBar, uniMemo,StrUtils, uniDateTimePicker, uniPanel,
  uniLabel, uniCheckBox, uniRadioGroup, uniBitBtn, uniButton, uniEdit,DateUtils,IniFiles,
  uniBasicGrid, uniStringGrid,Math, uniDBGrid, uniSplitter, uniScrollBox,
  FireDAC.DatS, FireDAC.DApt,FireDAC.Comp.ScriptCommands;

type
  TDato=(dFecha,dReal,dEntero,dCadena,dListaOculta);
//  TBotonAsociado = class(TIWImageButton)
//  public
//    Editor: TIWControl;
//    ConsultaSQL: string;
//    Titulo: TComponent;
//  end;
  TBotonSeleccion = class(TUniBitBtn)
  public
    ConsultaDeSeleccion: string;
    CampoDeEnlace:string;
    CampoOCulto:string;
    SentenciaAPasarPorDefecto:string;
    SentenciaGenerada:string;
    SentenciaAPasar:string;
  end;
  TfrmListadosPersonalizadosEditor = class(TListados)
    ADQuery1: TFDQuery;
    pnContenedor: TUniPanel;
    UniMemo1: TUniMemo;
    UniPanel1: TUniPanel;
    UniLabel1: TUniLabel;
    procedure UniFormShow(Sender: TObject);
    procedure UBImprimirClick(Sender: TObject);
    procedure ubExcelClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
  private
//    Conexion:TFDConnection;
    iTop: Integer;
    HacerExcel:boolean;
    Ordentabulacion,FID: integer;
    Parametros:Array of String;
    ControlesBuscadores:array of array of TUniControl;
    FEsProceso: boolean;
    ListaDeNombresCambiados:TStringList;
  procedure SetID(const Value: integer);
    procedure BotonSeleccionClick(Sender: TObject); //; EventParams: TStringList);
    function CreaCheckoRadio(Nombreparametro: string;var checkeado : boolean): string;
    function DaleValorAParametro(nombreparametro:string):string;override;
    function PrecargaValoresParametros(NombreParametro:string;var resultado:string):boolean;
    function ExtraeSubConsulta(NombreParametro: string):string;
    procedure SustituyeRutas(var Consulta:String);
    procedure SacaConsultaEnGrid;override;
    procedure SetEsProceso(const Value: boolean);
//    procedure RellenaConsultaConParametros(var consulta : string);
    { Private declarations }
  public
    { Public declarations }

    property ID:integer read FID write SetID;
    property EsProceso:boolean read FEsProceso write SetEsProceso;
    constructor Crear(qID:integer;qproceso:boolean;Conexion:TFDConnection);
  protected
    function ExportaAExcel(var titulo:string):boolean;override;
  end;

const
  QLeft=24;
  QTop=96;//32;
function frmListadosPersonalizadosEditor: TfrmListadosPersonalizadosEditor;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Funciones, Frm_Principal, Frm_Browse,
  frm_Resultados_LstWeb;

function frmListadosPersonalizadosEditor: TfrmListadosPersonalizadosEditor;
begin
  Result := TfrmListadosPersonalizadosEditor(UniMainModule.GetFormInstance(TfrmListadosPersonalizadosEditor));
end;

{ TListados1 }

procedure TfrmListadosPersonalizadosEditor.BotonSeleccionClick(Sender: TObject);
begin

end;

procedure TfrmListadosPersonalizadosEditor.SacaConsultaEnGrid;
begin
  if cdsConsulta.Active=false then
    cdsConsulta.Open;
  TfrmResultadosLstWeb.Crear(cdsConsulta).ShowModal;
//  frmResultadosLstWeb.ShowModal;
end;

procedure TfrmListadosPersonalizadosEditor.SetEsProceso(const Value: boolean);
begin
  FEsProceso := Value;
  EjecutarProceso:=Value;
end;

procedure TfrmListadosPersonalizadosEditor.SetID(const Value: integer);
var
  i: Integer;
  hay: Boolean;
  lista: TStringList;
begin
  FID := Value;
  FIDDeListado:=FID;
end;

procedure TfrmListadosPersonalizadosEditor.SustituyeRutas(var Consulta: String);
function RutaConexion(Programa,RutaFichero:String):String;
begin
  with TIniFile.Create(RutaFichero) do
    try
      result:=ReadString(Programa,'RUTA','');
    finally
      Free;
    end;
end;
var
  Secciones:TStringList;
  i:Integer;
  RutaProgramaINI:String;
begin
  RutaProgramaINI:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'..\PROGRAMA.INI';
  if (Pos('[',Consulta)>0) and (Pos(']',Consulta)>0) then
  begin
    with TIniFile.Create(RutaProgramaINI) do
      try
        Secciones:=TStringList.Create;
        try
          ReadSections(Secciones);
          for i:=0 to Secciones.Count-1 do
            Consulta:=ReplaceText(Consulta,'['+Secciones.Strings[i]+']',RutaConexion(Secciones.Strings[i],RutaProgramaINI));
        finally
          FreeAndNil(Secciones);
        end;
      finally
        Free;
      end;
  end;
end;

procedure TfrmListadosPersonalizadosEditor.ubExcelClick(Sender: TObject);
begin
  inherited;
  HacerExcel:=True;
  UBImprimirClick(UniToolButton2);
end;

procedure TfrmListadosPersonalizadosEditor.UBImprimirClick(Sender: TObject);
begin
  inherited;
  HacerExcel:=False;
end;

//procedure TfrmListadosPersonalizadosEditor.UniFormCreate(Sender: TObject);
//  function TipoDato(Parametro: String): TDato;
//  begin
//    if (UpperCase(copy(trim(Parametro),length(Parametro)-1,2))='_F') or (Pos('_F#',Parametro)>0) then result:=dFecha
//    else if (UpperCase(copy(trim(Parametro),length(Parametro)-1,2))='_R') or (Pos('_R#',Parametro)>0) then result:=dReal
//    else if ((UpperCase(copy(trim(Parametro),length(Parametro)-1,2))='_N') or (Pos('_N#',Parametro)>0) or SameText(Parametro,'EMPRESA')) then result:=dEntero
//    else if (UpperCase(copy(trim(Parametro),length(Parametro)-2,3))='_LO') or (Pos('_LO#',Parametro)>0) then result:=dListaOculta
//    else result:=dCadena;
//  end;
//var
//  i: Integer;
//  j: Integer;
//  cParam:Array of String;
//
//  checkeado: Boolean;
//  s: string;
//  k: Integer;
//  EsCheckORadioGroup: string;
//  contenedor: TStringList;
//  z: Integer;
//  btn: TUniBitBtn;
//  tu: TUniLabel;
//  tud: TUniDateTimePicker;
//  tuc: TUniCheckBox;
//  tur: TUniRadioGroup;
//  Cadena: string;
//  iLeft: integer;
//  conten: TStringList;
//  dummy: string;
//  nombre: string;
//  valor: string;
//
//begin
//
//  inherited;
//  HacerExcel:=False;
//  SetLength(Parametros,0);
//  Ordentabulacion:=0;
//
//  With CDSRestFacturaGDB('SELECT SENTENCIA FROM LISTADOSCONDICIONALES WHERE IDLISTADOSCONDICIONALES='+IntTostr(ID)) do
//  try
//    //unimemo1.Text:=FieldByName('SENTENCIA').AsString;
//    AdQuery1.SQL.Text:=FieldByName('Sentencia').AsString;
//  finally
//    Free;
//  end;
//
//  if Pos('[EMPRESA]',AdQuery1.SQL.Text)>0 then AdQuery1.SQL.Text:='/* :Empresa */'+AdQuery1.SQL.Text;
//  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[EMPRESA]',':Empresa ');
//  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[FILTRO]',' ');
//  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[VERSION]',QuotedStr('ADVANCED'));
//  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[USUARIO]',IntToStr(UniMainModule.ADUsuariosID.AsInteger));
//  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[IDEMPRESA]',IntToStr(UniMainModule.IDEmpresa));
//
//  iLeft:=QLeft;
//  iTop:=QTop;
//  Ordentabulacion:=1;
//  for i:=0 to ADQuery1.Params.Count-1 do
//  begin
//    j:=0;
//    while (j<Length(Parametros)) and (Parametros[j]<>ADQuery1.Params.Items[i].Name) do j:=j+1;
//    if j=Length(Parametros) then
//    begin
//      btn:=nil;
//      SetLength(Parametros,length(Parametros)+1);
//      Parametros[length(Parametros)-1]:=ADQuery1.Params.Items[i].Name;
//      s:=Parametros[length(Parametros)-1];
//
//
//      nombre:=s;
//      valor:='';
//
//      if Pos('#',s)>0 then
//      begin
//        nombre:=copy(s,1,Pos('#',s)-1);
//        valor:=Copy(s,Pos('#',s)+1,length(s)-Pos('#',s)+1);
//      end;
//
//      if TipoDato(Parametros[length(Parametros)-1])=dFecha then
//      begin
//        With TUniLabel.Create(pnContenedor) do
//        begin
//          Parent:=pnContenedor;
//          Left:=iLeft;
//          Top:=iTop;
//          Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
//          if (RightStr(Caption,2)=' f') or (RightStr(Caption,2)=' f#') then
//            Caption:=LeftStr(Caption,Length(Caption)-IFThen(RightStr(Caption,2)=' f',2,3));
//        end;
//        iTop:=iTop+20;
//        With TUniDateTimePicker.Create(pnContenedor) do
//        begin
//          Parent:=pnContenedor;
//          TabStop:=True;
//          Name:=nombre;//Parametros[length(Parametros)-1];
//          Left:=iLeft;
//          Top:=iTop;
//          Width:=530;
//          TabOrder:=Ordentabulacion;
//          Inc(Ordentabulacion);
//          if valor<>'' then
//            Text:=valor
//          Else if PrecargaValoresParametros(Parametros[length(Parametros)-1],dummy)=True then
//            Text:=dummy;
//        end;
//        iTop:=iTop+30;
//      end
//      Else begin
//        checkeado:=False;
//        EsCheckORadioGroup:=CreaCheckoRadio(s,checkeado);
//        IF EsCheckORadioGroup<>'' then
//        begin
//          IF Copy(EsCheckORadioGroup,1,1)='C' then
//          begin
//            With TUniCheckBox.Create(pnContenedor) do
//            begin
//              Parent:=pnContenedor;
//              Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
//              Name:=nombre;//Parametros[length(Parametros)-1];
//              Left:=iLeft;
//              Top:=iTop;
//              Width:=530;
//              TabStop:=True;
//              TabOrder:=Ordentabulacion;
//              Inc(Ordentabulacion);
//              if valor<>'' then
//                Text:=valor
//              Else if PrecargaValoresParametros(Parametros[length(Parametros)-1],dummy)=True then
//                Text:=dummy;
//            end;
//            iTop:=iTop+30;
//          end
//          Else begin
//            With TUniRadioGroup.Create(pnContenedor) do
//            begin
//              Parent:=pnContenedor;
//              Name:=nombre;//Parametros[length(Parametros)-1];
//              Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
//              Left:=iLeft;
//              Top:=iTop;
//              Width:=530;
//              conten:=TStringList.Create;
//              conten.Delimiter:='$';
//              conten.DelimitedText:=Copy(EsCheckORadioGroup,2,Pos('*/',EsCheckORadioGroup)-2);
//              for z:=0 to conten.Count-1 do
//                Items.Add(ReplaceText(contenedor.Strings[z],'_',''));
//              TabOrder:=Ordentabulacion;
//              Inc(Ordentabulacion);
//            end;
//            iTop:=iTop+30;
//          end;
//        end
//        else begin
//          if (TipoDato(Parametros[length(Parametros)-1])=dReal) or
//            (TipoDato(Parametros[length(Parametros)-1])=dEntero) then
//          begin
//            With TUniLabel.Create(pnContenedor) do
//            begin
//              Parent:=pnContenedor;
//              Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
//              Left:=iLeft;
//              Top:=iTop;
//              if not SameText(Caption,'Empresa') then
//                Caption:=LeftStr(Caption,Length(Caption)-IFThen((RightStr(Caption,2)=' r') or (RightStr(Caption,2)=' n'),2,3));
//            end;
//            iTop:=iTop+20;
//            With TUniNumberEdit.Create(pnContenedor) do
//            begin
//              Parent:=pnContenedor;
//              Name:=nombre;//Parametros[length(Parametros)-1];
//              Left:=iLeft;
//              Top:=iTop;
//              Width:=530;
//              TabStop:=True;
//              TabOrder:=Ordentabulacion;
//              Inc(Ordentabulacion);
//              if valor<>'' then
//                Text:=valor
//              Else if PrecargaValoresParametros(Parametros[length(Parametros)-1],dummy)=True then
//                Text:=dummy;
//            end;
//            iTop:=iTop+30;
//          end
//          Else begin
//            IF TipoDato(Parametros[length(Parametros)-1])=dCadena then
//            begin
//              With TUniLabel.Create(pnContenedor) do
//              begin
//                Parent:=pnContenedor;
//                Left:=iLeft;
//                Top:=iTop;
//                Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
//              end;
//              iTop:=iTop+20;
//              With TUniEdit.Create(pnContenedor) do
//              begin
//                Parent:=pnContenedor;
//                Name:=nombre;//Parametros[length(Parametros)-1];
//                Left:=iLeft;
//                Top:=iTop;
//                Width:=530;
//                TabStop:=True;
//                TabOrder:=Ordentabulacion;
//                Inc(Ordentabulacion);
//                if valor<>'' then
//                  Text:=valor
//                Else if PrecargaValoresParametros(Parametros[length(Parametros)-1],dummy)=True then
//                  Text:=dummy;
//              end;
//              iTop:=iTop+30;
//            end;
//          end;
//        end;
//      end;
//    end;
//  end;
//end;

procedure TfrmListadosPersonalizadosEditor.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  IF Assigned(ListaDeNombresCambiados) then
    FreeAndNil(ListaDeNombresCambiados);
end;

procedure TfrmListadosPersonalizadosEditor.UniFormShow(Sender: TObject);
  function TipoDato(Parametro: String): TDato;
  begin
    if (UpperCase(copy(trim(Parametro),length(Parametro)-1,2))='_F') or (Pos('_F#',Parametro)>0) then result:=dFecha
    else if (UpperCase(copy(trim(Parametro),length(Parametro)-1,2))='_R') or (Pos('_R#',Parametro)>0) then result:=dReal
    else if ((UpperCase(copy(trim(Parametro),length(Parametro)-1,2))='_N') or (Pos('_N#',Parametro)>0) or SameText(Parametro,'EMPRESA')) then result:=dEntero
    else if (UpperCase(copy(trim(Parametro),length(Parametro)-2,3))='_LO') or (Pos('_LO#',Parametro)>0) then result:=dListaOculta
    else result:=dCadena;
  end;
var
  i: Integer;
  j: Integer;
  cParam:Array of String;

  checkeado: Boolean;
  s: string;
  k: Integer;
  EsCheckORadioGroup: string;
  contenedor: TStringList;
  z: Integer;
  btn: TUniBitBtn;
  tu: TUniLabel;
  tud: TUniDateTimePicker;
  tuc: TUniCheckBox;
  tur: TUniRadioGroup;
  Cadena: string;
  iLeft: integer;
  conten: TStringList;
  dummy: string;
  nombre: string;
  valor: string;
  lpos: Integer;
  nantiguo: string;
begin
  HacerExcel:=False;
  SetLength(Parametros,0);
  Ordentabulacion:=0;

  With CDSRestFacturaGDB('SELECT SENTENCIA,DESCRIPCION FROM LISTADOSCONDICIONALES WHERE IDLISTADOSCONDICIONALES='+IntTostr(ID)) do
  try
    //unimemo1.Text:=FieldByName('SENTENCIA').AsString;
    AdQuery1.SQL.Text:=FieldByName('Sentencia').AsString;
    UniMemo1.Lines.Text:=FieldByName('DESCRIPCION').AsString;
  finally
    Free;
  end;

  if Pos('[EMPRESA]',AdQuery1.SQL.Text)>0 then AdQuery1.SQL.Text:='/* :Empresa */'+AdQuery1.SQL.Text;
  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[EMPRESA]',':Empresa ');
  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[FILTRO]',' ');
  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[VERSION]',QuotedStr('ADVANCED'));
  {$ifdef CAIFAC}
  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[NUMEMP]',UniMainModule.sEstaEmpresa);
  {$endif}
  {$ifdef CAICONTA}
  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[USUARIO]',IntToStr(UniMainModule.ADUsuariosID.AsInteger));
  {$endif}
  {$ifdef CAILAB}
  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[USUARIO]',QuotedStr(UniMainModule.ADUsuariosID.AsString));
  {$endif}
  {$ifdef CAISOC}
  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[IDEMPRESA]',IntToStr(UniMainModule.ADEmpresaEMPRESA.AsInteger));
  {$endif}
  {$ifdef CAIGeRH}
  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[USUARIO]',IntToStr(UniMainModule.ADQUsuariosINTERNO.AsInteger));
  {$else}
  {$if not defined(CAISOC) and not defined(CAIFIS) and not defined(CAIREN)}
  AdQuery1.SQL.Text:=ReplaceText(AdQuery1.SQL.Text,'[IDEMPRESA]',IntToStr(UniMainModule.IDEmpresa));
  {$ifend}
  {$endif}



  iLeft:=QLeft;
  iTop:=QTop;
  Ordentabulacion:=1;
  ListaDeNombresCambiados:=TStringList.Create;

  for i:=0 to ADQuery1.Params.Count-1 do
  begin
    j:=0;
    while (j<Length(Parametros)) and (Parametros[j]<>ADQuery1.Params.Items[i].Name) do j:=j+1;
    if j=Length(Parametros) then
    begin
      btn:=nil;
      SetLength(Parametros,length(Parametros)+1);
      Parametros[length(Parametros)-1]:=ADQuery1.Params.Items[i].Name;
      s:=Parametros[length(Parametros)-1];


      nombre:=s;
      valor:='';

      if Pos('#',s)>0 then
      begin
        nombre:=copy(s,1,Pos('#',s)-1);
        valor:=Copy(s,Pos('#',s)+1,length(s)-Pos('#',s)+1);
      end;

      // Si tiene una mascara para darle nombre al componente lo cojo
      lpos:=Pos('/*COMP#'+nombre,ADQuery1.SQL.Text);
      IF lpos>0 then
      begin
        nantiguo:=nombre;
        nombre:=Copy(ADQuery1.SQL.Text,lPos+6+Length(nombre)+1,50);
        Delete(nombre,Pos('*',nombre),50);
        if ListaDeNombresCambiados.IndexOf(nombre+nantiguo)=-1 then
          ListaDeNombresCambiados.add(nombre+nantiguo);
      end;

      if TipoDato(Parametros[length(Parametros)-1])=dFecha then
      begin
        With TUniLabel.Create(pnContenedor) do
        begin
          Parent:=pnContenedor;
          Left:=iLeft;
          Top:=iTop;
          if lpos<>0 then
            Caption:=nantiguo
          Else begin
            Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
            if (RightStr(Caption,2)=' f') or (RightStr(Caption,2)=' f#') then
              Caption:=LeftStr(Caption,Length(Caption)-IFThen(RightStr(Caption,2)=' f',2,3));
          end
        end;
        iTop:=iTop+20;
        With TUniDateTimePicker.Create(pnContenedor) do
        begin
          Parent:=pnContenedor;
          TabStop:=True;
          Name:=nombre;//Parametros[length(Parametros)-1];
          Left:=iLeft;
          Top:=iTop;
          Width:=530;
          TabOrder:=Ordentabulacion;
          Inc(Ordentabulacion);
          if valor<>'' then
            Text:=valor
          Else if PrecargaValoresParametros(Parametros[length(Parametros)-1],dummy)=True then
            Text:=dummy;
        end;
        iTop:=iTop+30;
      end
      Else begin
        checkeado:=False;
        EsCheckORadioGroup:=CreaCheckoRadio(s,checkeado);
        IF EsCheckORadioGroup<>'' then
        begin
          IF Copy(EsCheckORadioGroup,1,1)='C' then
          begin
            With TUniCheckBox.Create(pnContenedor) do
            begin
              Parent:=pnContenedor;
              if lpos<>0 then
                Caption:=nantiguo
              Else
                Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
              Name:=nombre;//Parametros[length(Parametros)-1];
              Left:=iLeft;
              Top:=iTop;
              Width:=530;
              TabStop:=True;
              TabOrder:=Ordentabulacion;
              Inc(Ordentabulacion);
              if valor<>'' then
                Text:=valor
              Else if PrecargaValoresParametros(Parametros[length(Parametros)-1],dummy)=True then
                Text:=dummy;
            end;
            iTop:=iTop+30;
          end
          Else begin
            With TUniRadioGroup.Create(pnContenedor) do
            begin
              Parent:=pnContenedor;
              Name:=nombre;//Parametros[length(Parametros)-1];
              if lpos<>0 then
                Caption:=nantiguo
              Else
                Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
              Left:=iLeft;
              Top:=iTop;
              Width:=530;
              conten:=TStringList.Create;
              conten.Delimiter:='$';
              conten.DelimitedText:=Copy(EsCheckORadioGroup,2,Pos('*/',EsCheckORadioGroup)-2);
              for z:=0 to conten.Count-1 do
                Items.Add(ReplaceText(contenedor.Strings[z],'_',''));
              TabOrder:=Ordentabulacion;
              Inc(Ordentabulacion);
            end;
            iTop:=iTop+30;
          end;
        end
        else begin
          if (TipoDato(Parametros[length(Parametros)-1])=dReal) or
            (TipoDato(Parametros[length(Parametros)-1])=dEntero) then
          begin
            With TUniLabel.Create(pnContenedor) do
            begin
              Parent:=pnContenedor;
              if lpos<>0 then
                Caption:=nantiguo
              Else
                Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
              Left:=iLeft;
              Top:=iTop;
              if not SameText(Caption,'Empresa') then
                Caption:=LeftStr(Caption,Length(Caption)-IFThen((RightStr(Caption,2)=' r') or (RightStr(Caption,2)=' n'),2,3));
            end;
            iTop:=iTop+20;
            With TUniNumberEdit.Create(pnContenedor) do
            begin
              Parent:=pnContenedor;
              Name:=nombre;//Parametros[length(Parametros)-1];
              Left:=iLeft;
              Top:=iTop;
              Width:=530;
              TabStop:=True;
              TabOrder:=Ordentabulacion;
              Inc(Ordentabulacion);
              if valor<>'' then
                Text:=valor
              Else if PrecargaValoresParametros(Parametros[length(Parametros)-1],dummy)=True then
                Text:=dummy;
            end;
            iTop:=iTop+30;
          end
          Else begin
            IF TipoDato(Parametros[length(Parametros)-1])=dCadena then
            begin
              With TUniLabel.Create(pnContenedor) do
              begin
                Parent:=pnContenedor;
                Left:=iLeft;
                Top:=iTop;
                if lpos<>0 then
                  Caption:=nantiguo
                Else
                  Caption:=ReplaceStr(UpperCase(Copy(Parametros[length(Parametros)-1],1,1))+LowerCase(Copy(Parametros[length(Parametros)-1],2,Length(Parametros[length(Parametros)-1]))),'_',' ');
              end;
              iTop:=iTop+20;
              With TUniEdit.Create(pnContenedor) do
              begin
                Parent:=pnContenedor;
                Name:=nombre;//Parametros[length(Parametros)-1];
                Left:=iLeft;
                Top:=iTop;
                Width:=530;
                TabStop:=True;
                TabOrder:=Ordentabulacion;
                Inc(Ordentabulacion);
                if valor<>'' then
                  Text:=valor
                Else if PrecargaValoresParametros(Parametros[length(Parametros)-1],dummy)=True then
                  Text:=dummy;
              end;
              iTop:=iTop+30;
            end;
          end;
        end;
      end;
    end;
  end;
  Self.Top:=UniToolBar1.Height;
  Self.Height:=UniToolBar1.Height+Itop+100;

end;

function TfrmListadosPersonalizadosEditor.CreaCheckoRadio(Nombreparametro: string;var checkeado : boolean): string;
var
  inicio: Integer;
  subconsulta: string;
//  BotonAsociado: TBotonAsociado;
//  MiConsulta:TSqlDataSet;
begin
  Result:='';
  subconsulta:='';
  inicio:=Pos(UpperCase('/*$'+ReplaceText(NombreParametro,' ','_')),UpperCase(ADQuery1.SQL.Text));
  if inicio=0 then
    Exit;
//  inicio:=inicio+Length(NombreParametro)+4;
  inicio:=inicio+3;
  subconsulta:=Copy(ADQuery1.SQL.Text,inicio,Length(ADQuery1.SQL.Text));
  subconsulta:=Copy(subconsulta,1,Pos('*/',subconsulta)-1);
  IF pos('$',subconsulta)=0 then
  begin
    checkeado:=False;
    // si tengo una consulta para dar valor la ejecuto
    subconsulta:=TRIM(Copy(subconsulta,Length(NombreParametro)+1,Length(subconsulta)));
    IF subconsulta<>'' then
    begin
      // Intento darle valor a todos los parametros que encuentre
      // En cada elemento del array controles hay un valor que consultar
      try
        //RellenaConsultaConParametros(subconsulta);
        With ConsultaAD(Conexion,subconsulta) do
          try
            IF Fields.Fields[0].AsString='S' then
              checkeado:=True;
          finally
            Free;
          end;
      except
      end;
    end;
    Result:='C'
  end
  Else
    Result:='R'+subconsulta;
end;


constructor TfrmListadosPersonalizadosEditor.Crear(qID: integer;qproceso:boolean;Conexion:TFDConnection);
begin
  inherited Create(uniGUIApplication.UniApplication);

  Self.Conexion:=Conexion;
  AdQuery1.Connection:=Conexion;
  cdsConsulta.Connection:=Conexion;//.ADConexionCAICONTA;
  Self.ID:=qID;
  Self.EsProceso:=qProceso;
  if qProceso then
    ubExcel.Visible:=False;

end;

function TfrmListadosPersonalizadosEditor.DaleValorAParametro(
  nombreparametro: string): string;
var
  i: Integer;
begin
  if Pos('#',nombreparametro)>0 then
    nombreparametro:=copy(nombreparametro,1,Pos('#',nombreparametro)-1);

  for i := 0 to pnContenedor.ComponentCount-1 do
    if not (pnContenedor.Components[i] is TUniLabel) then
      if SameText(pnContenedor.Components[i].Name,nombreparametro) or (ListaDeNombresCambiados.IndexOf(pnContenedor.Components[i].Name+nombreparametro)<>-1) then
      begin
        if pnContenedor.Components[i] is TUniDateTimePicker then
          Result:=FormatDateTime('mm/dd/yyyy',TUniDateTimePicker(pnContenedor.Components[i]).DateTime)
        Else if pnContenedor.Components[i] is TUniNumberEdit then
          Result:=ReplaceText(FloatToStr(StrToFloatDef(TUniNumberEdit(pnContenedor.Components[i]).Text,0)),',','.')
        Else if pnContenedor.Components[i] is TUniCheckBox then
          Result:=IFThen(TUniCheckBox(pnContenedor.Components[i]).Checked,'S','N')
        Else
          Result:=TUniEdit(pnContenedor.Components[i]).Text;
        Break;
      end;
end;

function TfrmListadosPersonalizadosEditor.ExportaAExcel(
  var titulo: string): boolean;
begin
  Result:=HacerExcel;
end;

function TfrmListadosPersonalizadosEditor.ExtraeSubConsulta(
  NombreParametro: string): string;
var
  inicio: Integer;
  subconsulta: string;
begin
  result:='';
  inicio:=Pos(UpperCase('/*#'+NombreParametro),UpperCase(ADQuery1.Sql.Text));
  if inicio=0 then
    Exit;
  inicio:=inicio+Length(NombreParametro)+4;
  subconsulta:=Copy(ADQuery1.Sql.Text,inicio,Length(ADQuery1.Sql.Text));
  if Pos('[EMPRESA]',subconsulta)>0 then subconsulta:='/* :Empresa */'+subconsulta;
  subconsulta:=ReplaceText(subconsulta,'[EMPRESA]',':Empresa ');
  subconsulta:=ReplaceText(subconsulta,'[FILTRO]',' ');
  subconsulta:=ReplaceText(subconsulta,'[VERSION]',QuotedStr('ADVANCED'));
  {$ifdef CAICONTA}
  subconsulta:=ReplaceText(subconsulta,'[USUARIO]',IntToStr(UniMainModule.ADUsuariosID.AsInteger));
  {$endif}
  {$ifdef CAILAB}
  subconsulta:=ReplaceText(subconsulta,'[USUARIO]',QuotedStr(UniMainModule.ADUsuariosID.AsString));
  {$endif}
  {$ifdef CAISOC}
  subconsulta:=ReplaceText(subconsulta,'[IDEMPRESA]',IntToStr(UniMainModule.ADEmpresaEMPRESA.AsInteger));
  {$endif}
  {$ifdef CAIGeRH}
  subconsulta:=ReplaceText(subconsulta,'[USUARIO]',IntToStr(UniMainModule.ADQUsuariosINTERNO.AsInteger));
  {$else}
  {$if not defined(CAISOC) and not defined(CAIFIS) and not defined(CAIREN)}
  subconsulta:=ReplaceText(subconsulta,'[IDEMPRESA]',IntToStr(UniMainModule.IDEmpresa));
  {$ifend}
  {$endif}



  result:=Copy(subconsulta,1,Pos('*/',subconsulta)-1);

end;

function TfrmListadosPersonalizadosEditor.PrecargaValoresParametros(NombreParametro: string;var resultado:string):boolean;
var
  TextoSQL:string;
begin
  // Si el valor predefinido viene de una consulta,la localiza en general y obtiene el valor
  Result:=False;
  Resultado:='';
  TextoSQL:=ExtraeSubconsulta(NombreParametro);
  SustituyeRutas(TextoSQL);

  if Trim(TextoSQL)<>'' then
  begin
    try
      with ConsultaAD(Conexion,TextoSQL) do
        try
          Resultado:=Fields.Fields[0].AsString;
          Result:=True;
        finally
          Free;
        end;
    except
//      raise exception.create('Error al cargar datos desde subconsulta.'+#13+TextoSQL);
    end;
  end;
end;


end.
