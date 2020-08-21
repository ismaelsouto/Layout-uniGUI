unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniPanel,
  uniPageControl, uniImageList, uniLabel, Vcl.Menus, uniMainMenu, uniTreeView,
  uniTreeMenu, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, uniBasicGrid, uniDBGrid,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, uniButton, uniGUIDialogs,
  uniChart, ppCtrls, ppPrnabl, ppClass, ppBands, ppCache, ppDB, ppDesignLayer,
  ppParameter, ppDBPipe, ppComm, ppRelatv, ppProd, ppReport, uniCalendarPanel,
  ppChrt, ppChrtDP, uniMultiItem, uniListBox, uniGUISessionManager, uniImage,
  uniURLFrame, uniHTMLFrame, uniEdit, uniDBEdit, Datasnap.DBClient, Dialogs,
  ServerModule,
  Datasnap.Provider, uniComboBox, uniBitBtn, uniStatusBar, uniToolBar,
  uniCalendar, uniTimer;

type
  TMainForm = class(TUniForm)
    UniPanel1: TUniPanel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniContainerPanel1: TUniContainerPanel;
    UniContainerPanel2: TUniContainerPanel;
    UniTreeMenu1: TUniTreeMenu;
    UniPageControl1: TUniPageControl;
    Inicio: TUniTabSheet;
    Alumnos: TUniTabSheet;
    Profesores: TUniTabSheet;
    Cards: TUniTabSheet;
    UniLabel3: TUniLabel;
    UniLabel5: TUniLabel;
    UniDBGrid2: TUniDBGrid;
    UniDBGrid1: TUniDBGrid;
    UniLabel4: TUniLabel;
    UniChart1: TUniChart;
    UniButton1: TUniButton;
    UniLabel6: TUniLabel;
    UniImage1: TUniImage;
    UniButton2: TUniButton;
    UniButton3: TUniButton;
    UniHTMLFrame1: TUniHTMLFrame;
    buscador: TUniEdit;
    UniContainerPanel7: TUniContainerPanel;
    UniContainerPanel8: TUniContainerPanel;
    UniContainerPanel9: TUniContainerPanel;
    UniContainerPanel10: TUniContainerPanel;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    FDQuery3: TFDQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    UniMenuItems1: TUniMenuItems;
    Aadir1: TUniMenuItem;
    Editar1: TUniMenuItem;
    Eliminar1: TUniMenuItem;
    N1: TUniMenuItem;
    Salir1: TUniMenuItem;
    UniNativeImageList1: TUniNativeImageList;
    FDQuery1ID_ALUMNO: TIntegerField;
    FDQuery1NOMBRE_ALUMNO: TStringField;
    FDQuery1APELLIDO_ALUMNO: TStringField;
    FDQuery2ID_PROFESOR: TIntegerField;
    FDQuery2NOMBRE_PROFESOR: TStringField;
    FDQuery2APELLIDO_PROFESOR: TStringField;
    FDQuery3NOMBRE_ALUMNO: TStringField;
    FDQuery3CONTADOR: TLargeintField;
    UniLabel9: TUniLabel;
    UniLabel10: TUniLabel;
    UniLabel11: TUniLabel;
    UniHTMLFrame2: TUniHTMLFrame;
    UniContainerPanel3: TUniContainerPanel;
    UniLabel7: TUniLabel;
    UniImage2: TUniImage;
    UniLabel8: TUniLabel;
    UniContainerPanel4: TUniContainerPanel;
    UniLabel12: TUniLabel;
    UniImage3: TUniImage;
    ClientDataSet1: TClientDataSet;
    Web: TUniTabSheet;
    UniContainerPanel5: TUniContainerPanel;
    UniMainMenu1: TUniMainMenu;
    Archivos1: TUniMenuItem;
    Favoritos1: TUniMenuItem;
    Salir2: TUniMenuItem;
    httpwwwuniguicom1: TUniMenuItem;
    UniURLFrame1: TUniURLFrame;
    UniStatusBar1: TUniStatusBar;
    UniComboBox1: TUniComboBox;
    UniBitBtn1: TUniBitBtn;
    UniBitBtn2: TUniBitBtn;
    UniBitBtn3: TUniBitBtn;
    UniBitBtn4: TUniBitBtn;
    N2: TUniMenuItem;
    N3: TUniMenuItem;
    N4: TUniMenuItem;
    N5: TUniMenuItem;
    N6: TUniMenuItem;
    N7: TUniMenuItem;
    Calendario: TUniTabSheet;
    UniContainerPanel6: TUniContainerPanel;
    UniCalendarPanel1: TUniCalendarPanel;
    UniTimer1: TUniTimer;
    UniToolBar1: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UniCalendar1: TUniCalendar;
    procedure clickAdd(Sender: TObject);
    procedure UniLabel4Click(Sender: TObject);
    procedure inicializacion(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Eliminar1Click(Sender: TObject);
    procedure Submenu11Click(Sender: TObject);
    procedure Submenu21Click(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure Menu1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
    procedure UniButton3Click(Sender: TObject);
    procedure UniBitBtn1Click(Sender: TObject);
    procedure buscar(Sender: TObject);
    procedure UniBitBtn3Click(Sender: TObject);
    procedure UniBitBtn4Click(Sender: TObject);
    procedure UniComboBox1Select(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure UniBitBtn2Click(Sender: TObject);
    procedure FavClick(Sender: TObject);
    procedure UniURLFrame1FrameLoaded(Sender: TObject);
    procedure UniComboBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniToolButton1Click(Sender: TObject);
    procedure UniToolButton2Click(Sender: TObject);
    procedure UniToolButton3Click(Sender: TObject);
    procedure UniCalendarPanel1DateChange(Sender: TUniCalendarPanel;
      AStartDate, AViewStart, AViewEnd: TDateTime);
    procedure UniCalendarPanel1EventClick(Sender: TUniCalendarPanel;
      AEventId: Integer; AEvent: TUniCalendarEvent);
    procedure UniCalendarPanel1RangeSelect(Sender: TUniCalendarPanel;
      AStartDate, AEndDate: TDateTime);

  private
    procedure GoURL(AURL: string);
    { Private declarations }
  public
    ListaDeSesiones: array of TMainForm;
    ListaArchivos: TStringList; // Lista de los archivos en la carpeta
    NumArchivo: Integer; // Numero del archivo mostrado actualmente

    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses uniGUIVars, uniGUIApplication, frm_Add_Alumnos,
  frm_Add_Profesores,
  frm_Edit_Alumnos, frm_Edit_Profesor, Frm_Profesores_Browse,
  Frm_Profesores_Editor, login_frm, MainModule, EventModuleUnit;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.buscar(Sender: TObject);
begin
  ClientDataSet1.Filter := 'NOMBRE_PROFESOR LIKE ''%' + buscador.Text +
    '%'' or APELLIDO_PROFESOR LIKE ''%' + buscador.Text + '%''';
end;

procedure TMainForm.clickAdd(Sender: TObject);
begin

  if UniPageControl1.ActivePage.PageIndex = 0 then
  begin
    ShowMessage('Para añadir un alumno o profesor accede a su pestaña.');
  end;

  if UniPageControl1.ActivePage.PageIndex = 1 then
  begin
    frmAdd.ShowModal;
    DataSource1.DataSet.Append;
    // UniDBGrid2.DataSource.DataSet.Post;
  end;

  if UniPageControl1.ActivePage.PageIndex = 2 then
  begin
    frmAdd_Profesores.ShowModal;
    ClientDataSet1.Insert;
    // UniDBGrid1.DataSource.DataSet.Post;
  end;

end;

procedure TMainForm.Eliminar1Click(Sender: TObject);
begin
  if UniPageControl1.ActivePage.PageIndex = 0 then
  begin
    ShowMessage('Para eliminar un alumno o profesor accede a su pestaña.');
  end;

  if UniPageControl1.ActivePage.PageIndex = 1 then
  begin
    if MessageDlg('¿Estas seguro?', mtConfirmation, [mbYes, mbNo]) = mrYes then
    begin
      DataSource1.DataSet.Delete;
    end;
  end;

  if UniPageControl1.ActivePage.PageIndex = 2 then
  begin
    if MessageDlg('¿Estas seguro?', mtConfirmation, mbYesNo) = mrYes then
    begin
      DataSource2.DataSet.Delete;
    end;
  end;
end;

procedure TMainForm.inicializacion(Sender: TObject);
var
  sr: TSearchRec;
  E: TUniCalendarEvent;

begin

  UniToolBar1.Color := TColor(RGB(243, 239, 224));


  UniCalendar1.Date := Date;
  UniCalendarPanel1.StartDate := Date;

  E := UniCalendarPanel1.Events.Add;
  E.CalendarId := 1;
  E.Title := 'Reunión';
  E.StartDate := Date;
  E.EndDate := E.StartDate;
  E.IsAllDay := True;

  E := UniCalendarPanel1.Events.Add;
  E.CalendarId := 2;
  E.Title := 'Reunión-2';
  E.StartDate := Date + 1;
  E.EndDate := E.StartDate;
  E.IsAllDay := True;

  E := UniCalendarPanel1.Events.Add;
  E.CalendarId := 3;
  E.Title := 'Reunión-3';
  E.StartDate := Date + 1.0 + StrToTime('15:30');
  E.EndDate := Date + 1.0 + StrToTime('16:30');

  E := UniCalendarPanel1.Events.Add;
  E.CalendarId := 4;
  E.Title := 'Reunión-4';
  E.StartDate := Date + 2.0 + StrToTime('10:00');
  E.EndDate := Date + 2.0 + StrToTime('12:00');

  E := UniCalendarPanel1.Events.Add;
  E.CalendarId := 5;
  E.Title := 'Reunión-5';
  E.IsAllDay := True;
  E.StartDate := Date + 3.0;
  E.EndDate := E.StartDate;

  { --------------------------- }

  if VCLMode then
    UniComboBox1.OnKeyUp := UniComboBox1KeyUp;

  FDQuery1.open;
  FDQuery2.open;
  UniChart1.Color := TColor(RGB(243, 239, 224));
  UniChart1.Legend.Visible := false;

  { --------------------------- }

  ClientDataSet1.FilterOptions := [foCaseInsensitive];
  ClientDataSet1.Filtered := True;

  { --------------------------- }
  ListaArchivos := TStringList.Create;

  UniImage1.Picture.LoadFromFile
    ('C:\Users\Ismael\Programas_Delphi\Layout_uniGUI\colegios\1.jpg');

  if FindFirst('C:\Users\Ismael\Programas_Delphi\Layout_uniGUI\colegios\*',
    faArchive, sr) = 0 then

  begin

    repeat

      ListaArchivos.Append
        ('C:\Users\Ismael\Programas_Delphi\Layout_uniGUI\colegios\' + sr.Name);

    until FindNext(sr) <> 0;

    FindClose(sr);

  end;

  NumArchivo := 0;

end;

procedure TMainForm.Menu1Click(Sender: TObject);
begin
  TFrmProfesoresBrowse.crear(TFrmDialogo2, '', 'APELLIDO_PROFESOR DESC', nil,
    '', nil, false, True).Show;
end;

procedure TMainForm.Modificar1Click(Sender: TObject);
begin
  if UniPageControl1.ActivePage.PageIndex = 0 then
  begin
    ShowMessage('Para editar un alumno o profesor accede a su pestaña.');
  end;

  if UniPageControl1.ActivePage.PageIndex = 1 then
  begin
    frmEditAlumnos.ShowModal;
    DataSource1.DataSet.Edit;
  end;

  if UniPageControl1.ActivePage.PageIndex = 2 then
  begin
    frmEditProfesores.ShowModal;
    DataSource2.DataSet.Edit;
  end;
end;

procedure TMainForm.Salir1Click(Sender: TObject);
begin
  Main.MainForm.Close;
  Main.MainForm.Visible := false;
  login_frm.UniLoginForm1.Visible := True;
end;

procedure TMainForm.Submenu11Click(Sender: TObject);
begin
  ShowMessage('Submenu 1');
end;

procedure TMainForm.Submenu21Click(Sender: TObject);
begin
  ShowMessage('Submenu 2');
end;

procedure TMainForm.UniButton1Click(Sender: TObject);
begin
  ShowMessage('Datos no disponibles');
end;

procedure TMainForm.UniButton2Click(Sender: TObject);
begin
  if NumArchivo > 0 then
  begin
    dec(NumArchivo);
    UniImage1.Picture.LoadFromFile(ListaArchivos.Strings[NumArchivo]);
    UniImage1.Width := 1033;
    UniImage1.Height := 633;
  end

  else
  begin
    NumArchivo := ListaArchivos.Count - 1;
    UniImage1.Picture.LoadFromFile(ListaArchivos.Strings[NumArchivo]);
  end;
end;

procedure TMainForm.UniButton3Click(Sender: TObject);
begin
  if NumArchivo < ListaArchivos.Count then
  begin
    UniImage1.Picture.LoadFromFile(ListaArchivos.Strings[NumArchivo]);
    inc(NumArchivo);
    UniImage1.Width := 1033;
    UniImage1.Height := 633;
  end

  else
  begin
    UniImage1.Picture.LoadFromFile(ListaArchivos.Strings[0]);
    NumArchivo := 0;
  end;
end;

procedure TMainForm.UniLabel4Click(Sender: TObject);
begin
  UniTreeMenu1.Micro := not UniTreeMenu1.Micro;
  if UniTreeMenu1.Micro then
  begin
    UniPanel1.Width := 50;
    UniPanel1.Height := 65;
    UniTreeMenu1.Top := 65;
    UniLabel2.Visible := false;
    UniLabel1.Visible := false;
    UniPageControl1.Left := UniPageControl1.Left - 246;
  end
  else
  begin
    UniPanel1.Width := 313;
    UniPanel1.Height := 161;
    UniTreeMenu1.Top := 158;
    UniLabel2.Visible := True;
    UniLabel1.Visible := True;
    UniPageControl1.Left := UniPageControl1.Left + 246;
  end;
end;

procedure TMainForm.UniToolButton1Click(Sender: TObject);
begin
  UniCalendarPanel1.Events.Clear;
end;

procedure TMainForm.UniToolButton2Click(Sender: TObject);
var
  FName: string;
begin
  FName := UniServerModule.LocalCachePath + 'Events.dat';
  if FileExists(FName) then
  begin
    UniCalendarPanel1.Events.LoadFromFile(FName);
    ShowMessage('Cargado de: ' + FName);
  end
  else
    ShowMessage('¡Debes guardar los datos primero!');
end;

procedure TMainForm.UniToolButton3Click(Sender: TObject);
var
  FName: string;
begin
  FName := UniServerModule.LocalCachePath + 'Events.dat';
  UniCalendarPanel1.Events.SaveToFile(FName);
  ShowMessage('Guardado en: ' + FName);
end;

{ ------------------------------------------------------------------------------ }

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.GoURL(AURL: string);
begin
  UniStatusBar1.Panels[0].Text := 'Loading...';
  UniURLFrame1.URL := AURL;

  if UniComboBox1.Items.IndexOf(AURL) < 0 then
    UniComboBox1.Items.Add(AURL);
end;

procedure TMainForm.FavClick(Sender: TObject);
var
  sURL: string;
begin
  sURL := TMenuItem(Sender).Caption;
  sURL := StringReplace(sURL, '&', '', [rfReplaceAll]);
  UniComboBox1.Text := sURL;
  GoURL(sURL);
end;

procedure TMainForm.UniBitBtn1Click(Sender: TObject);
begin
  GoURL(UniComboBox1.Text);
end;

procedure TMainForm.UniBitBtn4Click(Sender: TObject);
begin
  GoURL('https://');
  UniComboBox1.Text := 'https://';
end;

procedure TMainForm.UniBitBtn3Click(Sender: TObject);
begin
  GoURL(UniComboBox1.Text);
end;

procedure TMainForm.UniBitBtn2Click(Sender: TObject);
var
  M: TUniMenuItem;
begin
  M := TUniMenuItem.Create(Self);
  M.ImageIndex := 0;
  M.Caption := UniComboBox1.Text;
  M.OnClick := FavClick;
  Favoritos1.Add(M);
end;

procedure TMainForm.UniCalendarPanel1DateChange(Sender: TUniCalendarPanel;
  AStartDate, AViewStart, AViewEnd: TDateTime);
begin
  UniCalendar1.Date := UniCalendarPanel1.StartDate;
end;

procedure TMainForm.UniCalendarPanel1EventClick(Sender: TUniCalendarPanel;
  AEventId: Integer; AEvent: TUniCalendarEvent);
begin
  if not EventEditForm.Visible then
  begin
    EventEditForm.Calendar := UniCalendarPanel1;
    EventEditForm.SetEvent(AEvent);
    EventEditForm.ShowModal;
  end;
end;

procedure TMainForm.UniCalendarPanel1RangeSelect(Sender: TUniCalendarPanel;
  AStartDate, AEndDate: TDateTime);
begin
  if not EventEditForm.Visible then
  begin
    EventEditForm.Calendar := UniCalendarPanel1;
    EventEditForm.ClearEvent;
    EventEditForm.SetDate(AStartDate, AEndDate);
    EventEditForm.ShowModal;
  end;
end;

procedure TMainForm.UniComboBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    GoURL(UniComboBox1.Text);
end;

procedure TMainForm.UniComboBox1Select(Sender: TObject);
begin
  GoURL(UniComboBox1.Text);
end;



procedure TMainForm.UniURLFrame1FrameLoaded(Sender: TObject);
begin
  UniStatusBar1.Panels[0].Text := 'Completado';
end;

initialization

RegisterAppFormClass(TMainForm);

end.
