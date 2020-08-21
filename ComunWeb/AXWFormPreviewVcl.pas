unit AXWFormPreviewVcl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Printers, AXWComponent.VCL,
  AXWPreviewVcl, AXWLogEditor;

type
  TfrmPreview = class(TForm)
    Panel1: TPanel;
    btnClose: TButton;
    btnPrint: TButton;
    dlgPrint: TPrintDialog;
    Button1: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPreview: TAXWPreviewVcl;
  public
    procedure Execute(ADoc: TAXWLogDocEditor);
  end;

implementation

{$R *.dfm}

{ TTfrmPreview }

procedure TfrmPreview.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPreview.btnPrintClick(Sender: TObject);
var
  AXWPrint: TAXWPrintVcl;
begin
  AXWPrint := TAXWPrintVcl.Create(Nil);
  try
    AXWPrint.Document := FPreview.Document;
    AXWPrint.Print;
  finally
    AXWPrint.Free;
  end;
end;

procedure TfrmPreview.Button1Click(Sender: TObject);
begin
  dlgPrint.Execute;
end;

procedure TfrmPreview.Execute(ADoc: TAXWLogDocEditor);
begin
  FPreview.Document := ADoc;

  ShowModal;
end;

procedure TfrmPreview.FormCreate(Sender: TObject);
begin
  FPreview := TAXWPreviewVcl.Create(Owner);
  FPreview.Parent := Self;
  FPreview.Align := alClient;
end;

end.
