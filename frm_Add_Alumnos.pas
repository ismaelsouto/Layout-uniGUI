unit frm_Add_Alumnos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Main, Data.DB, uniEdit, uniButton,
  uniGUIBaseClasses, uniLabel, uniDBEdit;

type
  TfrmAdd = class(TUniForm)
    UniButton1: TUniButton;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    DataSource1: TDataSource;
    UniDBEdit1: TUniDBEdit;
    UniDBEdit2: TUniDBEdit;
    UniButton2: TUniButton;
    procedure UniButton1Click(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
    // procedure deshacerCambios(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmAdd: TfrmAdd;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmAdd: TfrmAdd;
begin
  Result := TfrmAdd(UniMainModule.GetFormInstance(TfrmAdd));
end;

procedure TfrmAdd.UniButton1Click(Sender: TObject);
begin
  DataSource1.DataSet.Post;
  close;
end;

procedure TfrmAdd.UniButton2Click(Sender: TObject);
begin
  DataSource1.DataSet.Delete;
  close;
end;

end.
