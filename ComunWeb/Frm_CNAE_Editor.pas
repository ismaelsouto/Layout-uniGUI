unit Frm_CNAE_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Dialogo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uniToolBar, uniGUIBaseClasses, uniPanel, uniLabel, uniEdit, uniDBEdit,
  Funciones, FireDAC.DatS, FireDAC.DApt;

type
  TFrmCNAEEditor = class(TFrmDialogo)
    ADClienteCNAE: TStringField;
    ADClienteNOMBRE: TStringField;
    CNAE: TUniDBEdit;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    NOMBRE: TUniDBEdit;
    ADClienteNIVEL: TIntegerField;
    ADClienteRAIZ: TStringField;
    procedure ADClienteAfterInsert(DataSet: TDataSet);
    procedure ADClienteUpdateRecord(ASender: TDataSet;
      ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
      AOptions: TFDUpdateRowOptions);
  private
    { Private declarations }
    function AntesdeGrabar:boolean; Override;
  public
    { Public declarations }
  end;

function FrmCNAEEditor: TFrmCNAEEditor;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils, Math, UniGuiDialogs, Frm_CNAE_Browse;

function FrmCNAEEditor: TFrmCNAEEditor;
begin
  Result := TFrmCNAEEditor(UniMainModule.GetFormInstance(TFrmCNAEEditor));
end;

procedure TFrmCNAEEditor.ADClienteAfterInsert(DataSet: TDataSet);
begin
  inherited;
  CNAE.Color:=clWindow;
  CNAE.ReadOnly:=False;
  CNAE.SetFocus;
end;

procedure TFrmCNAEEditor.ADClienteUpdateRecord(ASender: TDataSet;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
begin
  inherited;
  case ARequest of
    arInsert:with TFDQuery.Create(nil) do
               try
                 Connection:=UniMainModule.ADConexionGeneral;
                 case Length(ASender.FieldByName('CNAE').AsString) of
                   1:SQL.Text:='INSERT INTO CNAE_NIVEL_1(CNAE,NOMBRE) VALUES (:CNAE,:NOMBRE)';
                   2:SQL.Text:='INSERT INTO CNAE_NIVEL_2(CNAE,NOMBRE,NIVEL_1) VALUES (:CNAE,:NOMBRE,:RAIZ)';
                   3:SQL.Text:='INSERT INTO CNAE_NIVEL_3(CNAE,NOMBRE,NIVEL_2) VALUES (:CNAE,:NOMBRE,:RAIZ)';
                 else
                   SQL.Text:='INSERT INTO CNAE_NIVEL_5(CNAE,NOMBRE,NIVEL_3) VALUES (:CNAE,:NOMBRE,:RAIZ)';
                 end;
                 ParamByName('NOMBRE').AsString:=ASender.FieldByName('NOMBRE').CurValue;
                 ParamByName('CNAE').AsString:=ASender.FieldByName('CNAE').CurValue;
                 if Assigned(FindParam('RAIZ')) then
                   ParamByName('RAIZ').AsString:=IfThen(Length(ASender.FieldByName('CNAE').AsString)=2,
                                                        ASender.FieldByName('RAIZ').AsString,
                                                        copy(ASender.FieldByName('CNAE').CurValue,1,IfThen(Length(ASender.FieldByName('CNAE').AsString)=3,2,3)));
                 ExecSQL;
                 AAction:=eaApplied;
               finally
                 Free;
               end;
    arUpdate:begin
               UniMainModule.ADConexionGeneral.ExecSQL('UPDATE CNAE_NIVEL_'+VarToStr(ASender.FieldByName('NIVEL').OldValue)+' SET NOMBRE='+QuotedStr(ASender.FieldByName('NOMBRE').CurValue)+' WHERE CNAE='+QuotedStr(VarToStr(ASender.FieldByName('CNAE').OldValue)));
               AAction:=eaApplied;
             end;
  end;
end;

function TFrmCNAEEditor.AntesdeGrabar: boolean;
begin
  Result:=ADCliente.State<>dsInsert;
  if not Result then
  begin
    result:=Length(ADClienteCNAE.AsString) in [1,2,3,4];
    if not Result then
      UniGuiDialogs.ShowMessage('El número de dígitos del CNAE es incorrecto')
    else begin
      With ConsultaAD(UniMainModule.ADConexionGeneral,
                     'SELECT FIRST 1 CNAE FROM CNAE_NIVEL_'+IfThen(Length(ADClienteCNAE.AsString)=4,'5',IntToStr(Length(ADClienteCNAE.AsString)))+' WHERE CNAE='+QuotedStr(ADClienteCNAE.AsString)) do
        try
          Result:=IsEmpty;
        finally
          Free;
       end;
      if not Result then
        UniGuiDialogs.ShowMessage('CNAE duplicado')
      else begin
        Result:=(Length(ADClienteCNAE.AsString)<>2) or (not ADClienteRAIZ.IsNull);
        if not Result then
          UniGuiDialogs.ShowMessage('Ha de seleccionar el CNAE de nivel 1 al que pertenece',
                                    procedure (Sender: Tcomponent;AResult:Integer)
                                    begin
                                      TFrmCNAEBrowse.Crear(TFrmCNAEEditor,'NIVEL=1','',ADClienteRAIZ,'CNAE',
                                                           procedure(Campo:TField)
                                                           begin
                                                             UBAceptarClick(nil);
                                                           end).ShowModal;
                                    end);
      end;
    end;
  end;
end;

end.
