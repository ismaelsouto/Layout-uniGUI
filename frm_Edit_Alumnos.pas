unit frm_Edit_Alumnos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Main, Data.DB, uniEdit, uniDBEdit, uniLabel,
  uniGUIBaseClasses, uniButton;

type
  TfrmEditAlumnos = class(TUniForm)
    UniButton1: TUniButton;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniDBEdit1: TUniDBEdit;
    UniDBEdit2: TUniDBEdit;
    UniButton2: TUniButton;
    DataSource1: TDataSource;
    procedure UniButton1Click(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmEditAlumnos: TfrmEditAlumnos;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmEditAlumnos: TfrmEditAlumnos;
begin
  Result := TfrmEditAlumnos(UniMainModule.GetFormInstance(TfrmEditAlumnos));
end;

procedure TfrmEditAlumnos.UniButton1Click(Sender: TObject);
begin
  DataSource1.DataSet.Post;
  close;
end;

procedure TfrmEditAlumnos.UniButton2Click(Sender: TObject);
begin
  DataSource1.DataSet.Cancel;
  close;
end;

end.
