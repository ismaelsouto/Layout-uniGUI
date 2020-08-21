unit Frm_VisorPDF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniPanel, uniGUIBaseClasses, uniURLFrame,
  uniEdit, Funciones, uniGUIDialogs;

type
  TFrmVisorPDF = class(TUniForm)
    UniURLFrame1: TUniURLFrame;
    UniPDFFrame1: TUniPDFFrame;
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniURLFrame1FrameLoaded(Sender: TObject);
  private
    { Private declarations }
    FProcedimiento:TProcedimiento;
  public
    { Public declarations }
    procedure Mostrar(Fichero:String;CallBack:TUniDialogCallBackAnonProc=nil;Procedimiento:TProcedimiento=nil;tratarcomopdf:boolean=True);
  end;


implementation

uses ServerModule,StrUtils, uniGUIApplication;


{$R *.dfm}

procedure TFrmVisorPDF.Mostrar(Fichero: String;CallBack:TUniDialogCallBackAnonProc;Procedimiento:TProcedimiento;tratarcomopdf:boolean);
begin

  FProcedimiento:=Procedimiento;
  if Fichero='' then
  begin
    Close;
    uniGUIDialogs.ShowMessage('No existen datos');
  end
  else begin
    if EndsText('.PDF',UpperCase(Fichero)) and tratarcomopdf then
    begin
      UniURLFrame1.Hide;
//      FreeAndNil(UniURLFrame1);
      {$IFNDEF SIN_PDFFRAME}
      UniPDFFrame1.PdfURL:=ReplaceText(LowerCase(Fichero),LowerCase(UniServerModule.Servidor),'');
      {$ENDIF}
    end
    else begin
      {$IFNDEF SIN_PDFFRAME}
      UniPDFFrame1.Hide;
//      FreeAndNil(UniPDFFrame1);
      {$ENDIF}
      if Pos(LowerCase(UniServerModule.Servidor),LowerCase(Fichero))>0 then
        UniURLFrame1.URL:=ReplaceText(LowerCase(Fichero),LowerCase(UniServerModule.Servidor),'')
      else
        UniURLFrame1.URL:=Fichero;
    end;
    if assigned(CallBack) then
      ShowModal(CallBack);
  end;
end;


procedure TFrmVisorPDF.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFrmVisorPDF.UniFormCreate(Sender: TObject);
begin
  MonitorizarTeclas(Self,[VK_ESCAPE],False);
end;

procedure TFrmVisorPDF.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then Close;
end;

procedure TFrmVisorPDF.UniURLFrame1FrameLoaded(Sender: TObject);
begin
  if Assigned(FProcedimiento) then FProcedimiento;
end;

end.
