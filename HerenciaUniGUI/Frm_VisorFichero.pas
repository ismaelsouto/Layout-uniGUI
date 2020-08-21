unit Frm_VisorFichero;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniURLFrame, uniToolBar, uniGUIBaseClasses,
  Funciones,
  uniFileUpload, uniEdit, uniDBEdit,DB, uniImage, uniDBImage;

type
  TUbicacionFichero=(ufCarpetaCache,ufCarpetaFiles);
  TFrmVisorFichero = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBDescargar: TUniToolButton;
    UBSalir: TUniToolButton;
    UniURLFrame1: TUniURLFrame;
    UBEliminar: TUniToolButton;
    UniToolButton1: TUniToolButton;
    UBSubir: TUniToolButton;
    UniFileUpload1: TUniFileUpload;
    UniDBImage1: TUniDBImage;
    DataSource1: TDataSource;
    procedure UniFormCreate(Sender: TObject);
    procedure UBDescargarClick(Sender: TObject);
    procedure UBSalirClick(Sender: TObject);
    procedure UBEliminarClick(Sender: TObject);
    procedure UBSubirClick(Sender: TObject);
    procedure UniFileUpload1Completed(Sender: TObject; AStream: TFileStream);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniFormShow(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FESJPG : boolean;
    FCampo: TField;
    Extension:string;
    procedure ActualizaFrame;
    procedure SetEsJpg(const Value: boolean);
    procedure SetCampo(const Value: TField);
  public
    { Public declarations }
    FCallBack:TProcedimiento;
    FFichero:String;
    FUbicacionFichero:TUbicacionFichero;
    property ESJPG: boolean read FESJPG write SetEsJpg;
    property Campo:TField read FCampo write SetCampo;

  end;

implementation

uses
  uniGUIApplication, ServerModule,StrUtils, uniGUIDialogs;

{$R *.dfm}


procedure TFrmVisorFichero.ActualizaFrame;
var
  FicheroTMP:String;
begin
  FicheroTMP:=UniServerModule.LocalCachePath+FormatDateTime('yyyymmddhhnnsszzz',Now)+IFThen(ESJPG,Extension,'.pdf');
  CopyFile(PChar(FFichero),PChar(FicheroTMP),False);
  UniURLFrame1.URL:=ReplaceText(ReplaceText(FicheroTMP,UniServerModule.LocalCachePath,UniServerModule.LocalCacheURL),'\','/');
end;


procedure TFrmVisorFichero.UBDescargarClick(Sender: TObject);
begin
  UniSession.SendFile(FFichero);
end;

procedure TFrmVisorFichero.UBEliminarClick(Sender: TObject);
begin
  if not Assigned(FCampo) then
  begin
    DeleteFile(FFichero);
    UniURLFrame1.URL:='about:blank';
  end
  Else
    FCampo.Clear;
end;

procedure TFrmVisorFichero.UBSalirClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmVisorFichero.UBSubirClick(Sender: TObject);
begin
  UniFileUpload1.Execute;
end;

procedure TFrmVisorFichero.UniFileUpload1Completed(Sender: TObject;
  AStream: TFileStream);
begin
  Extension:=UpperCase(ExtractFileExt(AStream.FileName));
  if (FESJPG=false) and (not Sametext(UpperCase(ExtractFileExt(AStream.FileName)),'.PDF')) then
    uniGUIDialogs.ShowMessage('Sólo es posible subir ficheros en formato PDF')
  Else if (FESJPG=true) and ((not Sametext(UpperCase(ExtractFileExt(AStream.FileName)),'.JPG')) and
            (not Sametext(UpperCase(ExtractFileExt(AStream.FileName)),'.BMP')))
  then
    uniGUIDialogs.ShowMessage('Sólo es posible subir ficheros en formato JPG')
  else begin
    if not DirectoryExists(ExtractFilePath(FFichero)) then
      ForceDirectories(ExtractFilePath(FFichero));
    CopyFile(PChar(AStream.FileName),PChar(FFichero),False);
    ActualizaFrame;
  end;
end;

procedure TFrmVisorFichero.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if assigned(FCallBack) then
    FCallBack();

  Action:=caFree;
end;

procedure TFrmVisorFichero.UniFormCreate(Sender: TObject);
begin
  MonitorizarTeclas(Self,[VK_ESCAPE],False);
  FESJPG:=False;
end;

procedure TFrmVisorFichero.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    Self.Close;
end;

procedure TFrmVisorFichero.UniFormShow(Sender: TObject);
begin
  if not Assigned(FCampo) then
  begin
    if FileExists(FFichero) then
      ActualizaFrame;
  end;
end;

procedure TFrmVisorFichero.SetCampo(const Value: TField);
begin
  FCampo := Value;
  DataSource1.DataSet:=FCampo.DataSet;
  UniDBImage1.DataField:=FCampo.FieldName;
  UniDBImage1.Align:=alClient;
  UniURLFrame1.Visible:=False;
  UniDBImage1.Visible:=True;
  UBDescargar.Visible:=False;
  UBSubir.Visible:=False;
end;

procedure TFrmVisorFichero.SetEsJpg(const Value: boolean);
begin
  FESJPG:=Value;
  if FESJPG then
    UniFileUpload1.Title:='Subir fichero JPG';
end;

end.


