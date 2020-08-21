unit AXWFormDocStructVcl;

{$B-}
{$H+}
{$R-}
{$I AxCompilers.inc}
{$I AXW.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Math, AXWDefs, AXWUtils, AXWCharRun, AXWLogParas,
  AXWDocProps, AXWLogEditor, AXWPhyRow, AXWGraphicTypes, AXWGraphics, AXWFields;

type
  TfrmDocStruct = class(TForm)
    tvStruct: TTreeView;
    lbDocProps: TListBox;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbSubDocs: TComboBox;
    Label4: TLabel;
    cbStyles: TComboBox;
    btnViewStyle: TButton;
    btnRows: TButton;
    procedure Button1Click(Sender: TObject);
    procedure cbSubDocsChange(Sender: TObject);
    procedure btnViewStyleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tvStructChange(Sender: TObject; Node: TTreeNode);
    procedure btnRowsClick(Sender: TObject);
  private
     FDoc      : TAXWLogDocEditor;
     FTempLines: TStringList;

     procedure BeginMemLines;
     procedure AddMemLine(S1,S2: string);
     procedure EndMemLines;
     procedure FillAlignment(AAlignment: TAXWPapTextAlign);
     procedure FillCHPX(ACHPX: TAXWCHPX);
     procedure FillPAPX(APAPX: TAXWPAPX);
     procedure FillTabStops(ATabs: TAXWTabStops);
     procedure FillNumbering(ANumbering: TAXWNumbering);
     procedure FillBorder(ASide: string; ABorder: TAXWDocPropBorder);
     procedure FillTAPX(ATAPX: TAXWTAPX);
     procedure FillCellProps(AProps: TAXWTableCellProps);
     procedure FillTreeTable(AItem: TTreeNode; ATable: TAXWTable);
     procedure FillGraphics(AGraphics: TAXWGraphicObjList);
     procedure FillSEP(ASEP: TAXWSEP);
     procedure FillRow(ARow: TAXWPhyRow);
     procedure FillTreeRows(AItem: TTreeNode; ARows: TAXWPhyRows);
     procedure FillTreeCharRuns(AItem: TTreeNode; ARuns: TAXWCharRuns);
     procedure FillTreeParas(AItem: TTreeNode; AParas: TAXWLogParas);
     procedure FillTree(ADoc: TAXWLogDocEditor);
     procedure FillStyles;
     procedure FillRevision(ARev: TAXWRevisionData);
  public
     procedure Execute(ADoc: TAXWLogDocEditor);
  end;

implementation

{$R *.dfm}

{ TfrmDocStruct }

procedure TfrmDocStruct.AddMemLine(S1, S2: string);
begin
  FTempLines.AddObject(S1 + ':' + S2,TObject(Length(S1)));
end;

procedure TfrmDocStruct.BeginMemLines;
begin
  FTempLines.Clear;
end;

procedure TfrmDocStruct.btnRowsClick(Sender: TObject);
var
  Item : TTreeNode;
begin
  Item := tvStruct.Selected;
  if (Item <> Nil) and (TObject(Item.Data) is TAXWLogPara) then
    FillTreeRows(Item,TAXWLogPara(Item.Data).Rows);
end;

procedure TfrmDocStruct.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmDocStruct.btnViewStyleClick(Sender: TObject);
var
  Style: TAXWStyle;
begin
  BeginMemLines;

  if cbStyles.ItemIndex >= 0 then begin
    Style := TAXWStyle(cbStyles.Items.Objects[cbStyles.ItemIndex]);
    case Style.Type_ of
      astPara     : AddMemLine('###### Paragraph Style',Style.Name);
      astCharRun  : AddMemLine('###### Character Style',Style.Name);
      astTable    : AddMemLine('###### Table Style',Style.Name);
    end;

    AddMemLine('Id',Style.Id);
    if Style.BasedOn <> Nil then
      AddMemLine('Based on',Style.BasedOn.Name);
    AddMemLine('Default',BoolToStr(Style.Default,True));
    AddMemLine('Priority',IntToStr(Style.Priority));
    AddMemLine('Hidden',BoolToStr(Style.Hidden,True));

    case Style.Type_ of
      astPara     : begin
        FillPAPX(TAXWParaStyle(Style).PAPX);
        FillCHPX(TAXWParaStyle(Style).CHPX);
      end;
      astCharRun  : begin
        FillCHPX(TAXWCharStyle(Style).CHPX);
      end;
      astTable    : begin
        FillPAPX(TAXWTableStyle(Style).PAPX);
        FillTAPX(TAXWTableStyle(Style).TAPX);
      end;
      astNumbering: ;
    end;
  end;

  EndMemLines;
end;

procedure TfrmDocStruct.cbSubDocsChange(Sender: TObject);
begin
  FillTree(TAXWLogDocEditor(cbSubDocs.Items.Objects[cbSubDocs.ItemIndex]));
end;

procedure TfrmDocStruct.EndMemLines;
var
  i: integer;
  S1,S2: AxUCString;
  L: integer;
begin
  L := 0;
  for i := 0 to FTempLines.Count - 1 do
    L := Max(L,Integer(FTempLines.Objects[i]));

  Inc(L,2);

  lbDocProps.Clear;
  for i := 0 to FTempLines.Count - 1 do begin
    S2 := FTempLines[i];
    S1 := SplitAtChar(':',S2);
    S1 := S1 + StringOfChar(' ',L - Length(S1));
    lbDocProps.Items.Add(S1 + ': ' + S2);
  end;
end;

procedure TfrmDocStruct.Execute(ADoc: TAXWLogDocEditor);
begin
  FDoc := ADoc;

  FillStyles;

  cbSubDocs.Items.AddObject('Main doc',FDoc);
  if FDoc.Footnotes.Paras.Count > 0 then
    cbSubDocs.Items.AddObject('Footnotes',FDoc.Footnotes);
  if FDoc.Endnotes.Paras.Count > 0 then
    cbSubDocs.Items.AddObject('Endnotes',FDoc.Endnotes);
  cbSubDocs.ItemIndex := 0;

  if FDoc.Headers.Default_ <> Nil then
    cbSubDocs.Items.AddObject('Header - default',FDoc.Headers.Default_);
  if FDoc.Headers.First <> Nil then
    cbSubDocs.Items.AddObject('Header - first',FDoc.Headers.First);
  if FDoc.Headers.Even <> Nil then
    cbSubDocs.Items.AddObject('Header - even',FDoc.Headers.Even);

  if FDoc.Footers.Default_ <> Nil then
    cbSubDocs.Items.AddObject('Footer - default',FDoc.Footers.Default_);
  if FDoc.Footers.First <> Nil then
    cbSubDocs.Items.AddObject('Footer - first',FDoc.Footers.First);
  if FDoc.Footers.Even <> Nil then
    cbSubDocs.Items.AddObject('Footer - even',FDoc.Footers.Even);

  FillTree(FDoc);

  ShowModal;
end;

procedure TfrmDocStruct.FillAlignment(AAlignment: TAXWPapTextAlign);
begin
  case AAlignment of
    axptaLeft   : AddMemLine('Alignment','Left');
    axptaCenter : AddMemLine('Alignment','Center');
    axptaRight  : AddMemLine('Alignment','Right');
    axptaJustify: AddMemLine('Alignment','Justify');
  end;
end;

procedure TfrmDocStruct.FillBorder(ASide: string; ABorder: TAXWDocPropBorder);
begin
  AddMemLine('Border',ASide);
  AddMemLine(' Width',Format('%.2fpt',[ABorder.Width]));
  AddMemLine(' Color',Format('%.6X',[ABorder.Color]));
  AddMemLine(' Style',TST_BorderStr[ABorder.Style]);
  AddMemLine(' Space',Format('%.2fpt',[ABorder.Space]));
end;

procedure TfrmDocStruct.FillCellProps(AProps: TAXWTableCellProps);
begin
  AddMemLine('####### Cell properties','');

  AddMemLine('Fill color',Format('%.6X',[AProps.FillColor]));
  if AProps.Borders.Left   <> Nil then FillBorder('Left',AProps.Borders.Left);
  if AProps.Borders.Top    <> Nil then FillBorder('Top',AProps.Borders.Top);
  if AProps.Borders.Right  <> Nil then FillBorder('Right',AProps.Borders.Right);
  if AProps.Borders.Bottom <> Nil then FillBorder('Bottom',AProps.Borders.Bottom);
end;

procedure TfrmDocStruct.FillCHPX(ACHPX: TAXWCHPX);
var
  S: string;
begin
  AddMemLine('####### CHPX','');

//  BeginMemLines;

  if ACHPX <> Nil then begin
    S := '';

    AddMemLine('Font name',ACHPX.FontName);
    AddMemLine('Font size',Format('%.1f pt',[ACHPX.Size]));

    if ACHPX.Bold then
      S := 'Bold ';
    if ACHPX.Italic then
      S := 'Italic ';
    if ACHPX.StrikeThrough then
      S := 'Strike through';

    if S <> '' then
      AddMemLine('Style',S);

    S := '';
    case ACHPX.Underline of
      axcuSingle         : S := 'Single';
      axcuWords          : S := 'Words';
      axcuDouble         : S := 'Double';
      axcuThick          : S := 'Thick';
      axcuDotted         : S := 'Dotted';
      axcuDottedHeavy    : S := 'DottedHeavy';
      axcuDash           : S := 'Dash';
      axcuDashedHeavy    : S := 'DashedHeavy';
      axcuDashLong       : S := 'DashLong';
      axcuDashLongHeavy  : S := 'DashLongHeavy';
      axcuDotDash        : S := 'DotDash';
      axcuDashDotHeavy   : S := 'DashDotHeavy';
      axcuDotDotDash     : S := 'DotDotDash';
      axcuDashDotDotHeavy: S := 'DashDotDotHeavy';
      axcuWave           : S := 'Wave';
      axcuWavyHeavy      : S := 'WavyHeavy';
      axcuWavyDouble     : S := 'WavyDouble';
    end;
    if S <> '' then begin
      AddMemLine('Underline',S);
      AddMemLine('Underline color',Format('%.6X',[ACHPX.UnderlineColor]));
    end;

    case ACHPX.SubSuperscript of
      axcssSubscript  : AddMemLine('Subscript','True');
      axcssSuperscript: AddMemLine('Superscript','True');
    end;

    AddMemLine('Color',Format('%.6X',[ACHPX.Color]));
    if ACHPX.FillColor <> AXW_COLOR_AUTOMATIC then
      AddMemLine('Fill color',Format('%.6X',[ACHPX.FillColor]));
    AddMemLine('Color HLink hoover',Format('%.6X',[ACHPX.ColorHLinkHoover]));
    AddMemLine('Color HLink visited',Format('%.6X',[ACHPX.ColorHLinkVisited]));

    if ACHPX.HighlightColor <> ahcNone then
      AddMemLine('Highlight color',Format('%.6X',[AXWHighlighColorVals[ACHPX.HighlightColor]]));

    if ACHPX.Style <> Nil then
      AddMemLine('Style',ACHPX.Style.Name);

    if ACHPX.Border <> Nil then
      AddMemLine('Border','Color=' + Format('%.8X',[ACHPX.Border.Color]));

    if ACHPX.Misspelled then
      AddMemLine('Misspelled','Yes');

    if ACHPX.Revision <> Nil then
      FillRevision(ACHPX.Revision);

  end
  else
    AddMemLine('No CHPX','');

//  EndMemLines;
end;

procedure TfrmDocStruct.FillGraphics(AGraphics: TAXWGraphicObjList);
var
  i: integer;
begin
  AddMemLine('####### Graphics','');

  for i := 0 to AGraphics.Count - 1 do begin
    case AGraphics[i].Type_ of
      agtUnknown  : AddMemLine('Type','Unknown');
      agtLine     : AddMemLine('Type','Line');
      agtRotate   : begin
        AddMemLine('Type','Rotate');
        if TAXWGraphicRotate(AGraphics[i]).TextBox <> Nil then begin
          case TAXWGraphicRotate(AGraphics[i]).TextBox.Type_ of
            atbtNormal: AddMemLine('  TextBox','Normal');
            atbtFrame : AddMemLine('  TextBox','Frame');
            atbtTable : AddMemLine('  TextBox','Table');
          end;
        end;
      end;
      agtShape    : AddMemLine('Type','Shape');
      agtPicture  : AddMemLine('Type','Picture');
      agtBarcode  : AddMemLine('Type','Barcode');
      agtRectangle: AddMemLine('Type','Rectangle');
      agtHorizLine: AddMemLine('Type','HorizLine');
      agtRoundRect: AddMemLine('Type','RoundRect');
      agtEllipse  : AddMemLine('Type','Ellipse');
    end;
  end;
end;

procedure TfrmDocStruct.FillNumbering(ANumbering: TAXWNumbering);
var
  S: string;
begin
  AddMemLine('####### Numbering','');
//  BeginMemLines;
  AddMemLine('Id',IntToStr(ANumbering.Id));
  AddMemLine('Level',IntToStr(ANumbering.Level));
  case ANumbering.Style of
    anstNone       : S := 'None';
    anstBullet     : S := 'Bullet';
    anstDecimal    : S := 'Decimal';
    anstDecimalParen: S := 'Decimal)';
    anstLowerRoman : S := 'LowerRoman';
    anstUpperRoman : S := 'UpperRoman';
    anstLowerLetter: S := 'LowerLetter';
    anstLowerLetterParen: S := 'LowerLetter)';
    anstUpperLetter: S := 'UpperLetter';
  end;
  AddMemLine('Style',S);
  AddMemLine('Text',ANumbering.Text);
  case ANumbering.Align of
    axptaLeft   : S := 'aLeft';
    axptaCenter : S := 'aCenter';
    axptaRight  : S := 'aRight';
    axptaJustify: S := 'aJustify';
  end;
  AddMemLine('Align',S);
  if ANumbering.Picture <> Nil then
    AddMemLine('Picture','YES');
//  EndMemLines;

  FillCHPX(ANumbering.CHPX);
  FillPAPX(ANumbering.PAPX);
end;

procedure TfrmDocStruct.FillPAPX(APAPX: TAXWPAPX);
begin
  AddMemLine('####### PAPX','');

//  BeginMemLines;
  if APAPX <> Nil then begin
    case APAPX.Alignment of
      axptaLeft   : AddMemLine('Alignment','Left');
      axptaCenter : AddMemLine('Alignment','Center');
      axptaRight  : AddMemLine('Alignment','Right');
      axptaJustify: AddMemLine('Alignment','Justify');
    end;

    if APAPX.IndentLeft <> 0 then
      AddMemLine('Indent left',Format('%.1f',[APAPX.IndentLeft]));
    if APAPX.IndentRight <> 0 then
      AddMemLine('Indent right',Format('%.1f',[APAPX.IndentRight]));
    if APAPX.IndentFirstLine <> 0 then
      AddMemLine('Indent first line',Format('%.1f',[APAPX.IndentFirstLine]));
    if APAPX.IndentHanging <> 0 then
      AddMemLine('Indent hanging',Format('%.1f',[APAPX.IndentHanging]));

    AddMemLine('Line spacing',Format('%.2f',[APAPX.LineSpacing]));
    AddMemLine('Space before',Format('%.2f',[APAPX.SpaceBefore]));
    AddMemLine('Space after',Format('%.2f',[APAPX.SpaceAfter]));
    if APAPX.BorderLeft <> Nil then   FillBorder('Left',APAPX.BorderLeft);
    if APAPX.BorderTop <> Nil then    FillBorder('Top',APAPX.BorderTop);
    if APAPX.BorderRight <> Nil then  FillBorder('Right',APAPX.BorderRight);
    if APAPX.BorderBottom <> Nil then FillBorder('Bottom',APAPX.BorderBottom);

    AddMemLine('Color',Format('%.8X',[APAPX.Color]));

    if APAPX.Numbering <> Nil then begin
      AddMemLine('--- NUMBERING ---','');
      FillNumbering(APAPX.Numbering);
      AddMemLine('-----------------','');
    end;

    if APAPX.Style <> Nil then
      AddMemLine('Style',APAPX.Style.Name);

    if APAPX.Revision <> Nil then
      FillRevision(APAPX.Revision);
  end
  else
    AddMemLine('No PAXP','');

  if APAPX.CHPX <> Nil then
    FillCHPX(APAPX.CHPX);

//  EndMemLines;
end;

procedure TfrmDocStruct.FillRevision(ARev: TAXWRevisionData);
var
  S: string;
begin
  AddMemLine('**** Revision ****','');
  if ARev <> Nil then begin
    case ARev.RevType of
      artInsert    : S := 'Insert';
      artDelete    : S := 'Delete';
      artMoveFrom  : S := 'Move from';
      artMoveTo    : S := 'Move to';
      artFormatCHPX: S := 'CHPX';
      artFormatPAPX: S := 'PAPX';
    end;

    AddMemLine('Id',IntToStr(ARev.Id));
    AddMemLine('Type',S);
    AddMemLine('Name',ARev.Name);
    AddMemLine('Author',ARev.Author);
    AddMemLine('Date',DateTimeToStr(ARev.Date));
    if ARev.Enabled then
      AddMemLine('Enabled','True')
    else
      AddMemLine('Enable','False');

    AddMemLine('Color',Format('%.6X',[ARev.Color]));
  end
  else
    AddMemLine('[Nil]','');
end;

procedure TfrmDocStruct.FillRow(ARow: TAXWPhyRow);
begin
  AddMemLine('####### Row','');
  AddMemLine('Height',FloatToStr(ARow.Height));
  AddMemLine('Ascent',FloatToStr(ARow.Ascent));
  AddMemLine('Descent',FloatToStr(ARow.Descent));
  AddMemLine('LineHeight',FloatToStr(ARow.LineHeight));
  AddMemLine('BreakCharEx',FloatToStr(ARow.BreakCharExtra));
  AddMemLine('Col',IntToStr(ARow.Col));
  AddMemLine('ColX',FloatToStr(ARow.ColX));
  AddMemLine('Width',FloatToStr(ARow.Width));
  AddMemLine('PagWidth',FloatToStr(ARow.PagWidth));
  AddMemLine('X',FloatToStr(ARow.X));
  AddMemLine('XOffs',FloatToStr(ARow.XOffset));
  AddMemLine('Y',FloatToStr(ARow.Y));
  AddMemLine('Y1',FloatToStr(ARow.Y1));
  AddMemLine('Y2',FloatToStr(ARow.Y2));
  AddMemLine('CR1',IntToStr(ARow.CR1.Index));
  AddMemLine('CR2',IntToStr(ARow.CR2.Index));
  AddMemLine('CRPos1',IntToStr(ARow.CRPos1));
  AddMemLine('CRPos2',IntToStr(ARow.CRPos2));
end;

procedure TfrmDocStruct.FillSEP(ASEP: TAXWSEP);
begin
  lbDocProps.Items.Add('---------------------------');
  lbDocProps.Items.Add('SEP');

  lbDocProps.Items.Add('Columns          : ' + IntToStr(ASEP.Cols.Count));
end;

procedure TfrmDocStruct.FillStyles;
begin
  FDoc.Styles.GetAllStyles(cbStyles.Items);
end;

procedure TfrmDocStruct.FillTabStops(ATabs: TAXWTabStops);
var
  i: integer;
  S: string;
begin
  AddMemLine('####### Tab Stops','');
  for i := 0 to ATabs.Count - 1 do begin
    S := Format('Pos: %.1f',[ATabs[i].Position]);

    S := S + ' Align: ';
    case ATabs[i].Alignment of
      atsaClear  : S := S + 'Clear';
      atsaLeft   : S := S + 'Left';
      atsaCenter : S := S + 'Center';
      atsaRight  : S := S + 'Right';
      atsaDecimal: S := S + 'Decimal';
      atsaNum    : S := S + 'Num';
    end;
    AddMemLine(' Tab# ' + IntToStr(i),S);
  end;
end;

procedure TfrmDocStruct.FillTAPX(ATAPX: TAXWTAPX);
begin
  AddMemLine('####### TAPX','');

  FillAlignment(ATAPX.Alignment);

  if ATAPX.Style <> Nil then
    AddMemLine('Style',ATAPX.Style.Name);

  if ATAPX.Indent <> 0 then
    AddMemLine('Indent',Format('%.1f',[ATAPX.Indent]));

  AddMemLine('Width',Format('%.1f',[ATAPX.Width]));

  case ATAPX.WidthType of
    atwtAuto   : AddMemLine('Width type','Automatic');
    atwtPercent: AddMemLine('Width type','Percent');
    atwtPoints : AddMemLine('Width type','Points');
  end;

  if ATAPX.HasBorders then begin
    if ATAPX.BorderLeft   <> Nil then FillBorder('Left',ATAPX.BorderLeft);
    if ATAPX.BorderTop    <> Nil then FillBorder('Top',ATAPX.BorderTop);
    if ATAPX.BorderRight  <> Nil then FillBorder('Right',ATAPX.BorderRight);
    if ATAPX.BorderBottom <> Nil then FillBorder('Bottom',ATAPX.BorderBottom);
  end;

  if ATAPX.Style <> Nil then
    AddMemLine('Style',ATAPX.Style.Name);
end;

procedure TfrmDocStruct.FillTree(ADoc: TAXWLogDocEditor);
begin
  tvStruct.Items.Clear;

  FillTreeParas(tvStruct.Items.AddChildFirst(Nil,''),ADoc.Paras);

  tvStruct.FullExpand;
end;

procedure TfrmDocStruct.FillTreeCharRuns(AItem: TTreeNode; ARuns: TAXWCharRuns);
var
  i: integer;
  S: string;
  CR: TAXWCharRun;
  Item: TTreeNode;
begin
  for i := 0 to ARuns.Count - 1 do begin
    CR := ARuns[i];
    Item := tvStruct.Items.AddChild(AItem,'');
    Item.Data := CR;

    case CR.Type_ of
      acrtText       : Item.Text := 'Char run, CP=' + IntToStr(CR.StartPos) + '] "' + CR.RawText + '"';
      acrtTab        : Item.Text := '[Tab]';
      acrtBreak      : Item.Text := 'Break, ' + XWCharRunBreakTypeName[TAXWCharRunBreak(CR).BreakType] + ']';
      acrtGraphic    : Item.Text := 'Graphic]';
      acrtHyperlink  : Item.Text := 'Hyperlink] ' + TAXWCharRunHyperlink(CR).Hyperlink.Address + ' "' + CR.RawText + '"';
      acrtSimpleField: Item.Text := 'Simple field: ' + TAXWCharRunSimpleField(CR).SimpField.InstrText + '] "' + CR.RawText + '"';
      acrtFootnote,
      acrtFootnoteRef: Item.Text := 'Footnote # ' + CR.RawText + ']';
      acrtLinked     : begin
        case TAXWCharRunLinked(CR).LinkedType of
          acrltBookmark    : begin
            if TAXWCharRunLinked(CR).AsBookmark <> Nil then
              S:= 'Bookmark "' + TAXWCharRunLinked(CR).AsBookmark.Name + '"'
            else
              S:= 'Bookmark "???"';
          end;
          acrltComment     : S := 'Comment';
          acrltRevision    : begin
            if TAXWCharRunLinked(CR).AsPara <> Nil then
              S := 'Revision, para: ' + Copy(TAXWLogPara(TAXWCharRunLinked(CR).AsPara).PlainText,1,10)
            else
              S := 'Revision, para: ???';
          end;
          acrltComplexField: begin
            if TAXWCharRunLinked(CR).Position in [acrlpSingle,acrlpFirst]  then
              S:= 'Complex: ' + TAXWCharRunLinked(CR).AsComplex.InstrText
            else
              S:= 'Complex';
          end;
        end;
        case TAXWCharRunLinked(CR).Position of
          acrlpSingle:  Item.Text := 'Linked ' + S + '], Single';
          acrlpFirst :  Item.Text := 'Linked ' + S + '], First ->';
          acrlpMiddle:  Item.Text := 'Linked ' + S + '], <- Middle ->';
          acrlpLast  :  Item.Text := 'Linked ' + S + '], <- Last';
        end;
      end;
    end;

    if CR.Revision <> Nil then begin
      S := 'Rev,';

      case CR.Revision.RevType of
        artInsert    : S := 'Rev(' + IntToStr(CR.Revision.Id) + '), I ';
        artDelete    : S := 'Rev(' + IntToStr(CR.Revision.Id) + '), D ';
        artMoveFrom  : S := 'Rev(' + IntToStr(CR.Revision.Id) + '), MF ';
        artMoveTo    : S := 'Rev(' + IntToStr(CR.Revision.Id) + '), MT ';
        artFormatCHPX: S := 'Rev(' + IntToStr(CR.Revision.Id) + '), F,CHPX ';
        artFormatPAPX: S := 'Rev(' + IntToStr(CR.Revision.Id) + '), F,PAPX ';
      end;
    end
    else
      S := '';

    Item.Text := S + '[' + IntToStr(i) + ' ' + Item.Text;
  end;
end;

procedure TfrmDocStruct.FillTreeParas(AItem: TTreeNode; AParas: TAXWLogParas);
var
  i: integer;
  P: TAXWLogParaItem;
  Item: TTreeNode;
begin
  for i := 0 to AParas.Count - 1 do begin
    P := AParas.Items[i];

    Item := tvStruct.Items.AddChild(AItem,'');
    case P.Type_ of
      alptPara: begin
        Item.Text := 'Para ' + IntToStr(P.Index) + ' ' + Copy(P.PlainText,1,30) + '...';
        Item.Data := P;

        FillTreeCharRuns(Item,TAXWLogPara(P).Runs);
      end;
      alptTable: begin
        Item.Text := Format('Table,W = %.2f, Rows = %d',[TAXWTable(P).CalculatedWidth,TAXWTable(P).Count]);
        Item.Data := TAXWTable(P);

        FillTreeTable(Item,TAXWTable(P));
      end;
    end;

  end;
end;

procedure TfrmDocStruct.FillTreeRows(AItem: TTreeNode; ARows: TAXWPhyRows);
var
  i: integer;
  R: TAXWPhyRow;
  Item: TTreeNode;
begin
  for i := 0 to ARows.Count - 1 do begin
    R := ARows[i];

    Item := tvStruct.Items.AddChild(AItem,'');

    Item.Text := Format('Row: %d, "%s"',[i,R.PlainText]);
    Item.Data := R;
  end;
end;

procedure TfrmDocStruct.FillTreeTable(AItem: TTreeNode; ATable: TAXWTable);
var
  S  : string;
  R,C: integer;
  Row: TAXWTableRow;
  Cell: TAXWTableCell;
  RowItem: TTreeNode;
  ColItem: TTreeNode;
begin
  for R := 0 to ATable.Count - 1 do begin
    Row := ATable[R];
    RowItem := tvsTruct.Items.AddChild(AItem,'');
    RowItem.Text := Format('Row %d, height %.1fpt',[R,Row.Height]);

    for C := 0 to Row.Count - 1 do begin
      ColItem := tvStruct.Items.AddChild(RowItem,'');

      S := '';
      Cell := Row[C];
      if Cell.MergedRoot then
        S := S + 'MergedRoot ';
      if Cell.Merged then
        S := S + 'Merged ';
      if Cell.MergedLast then
        S := S + 'MergedLast ';
      if S <> '' then
        S := ' [ ' + S + ']';
      ColItem.Text := Format('Col %d, width %.1fpt%s',[C,Cell.Width,S]);
      ColItem.Data := Cell;

      FillTreeParas(ColItem,Row[C].Paras);
    end;
  end;
end;

procedure TfrmDocStruct.FormCreate(Sender: TObject);
begin
  FTempLines := TStringList.Create;
end;

procedure TfrmDocStruct.FormDestroy(Sender: TObject);
begin
  FTempLines.Free;
end;

procedure TfrmDocStruct.tvStructChange(Sender: TObject; Node: TTreeNode);
var
  Item : TTreeNode;
begin
  BeginMemLines;

  btnRows.Enabled := False;

  Item := tvStruct.Selected;
  if TObject(Item.Data) is TAXWLogPara then begin
    FillPAPX(TAXWLogPara(Item.Data).PAPX);
    if TAXWLogPara(Item.Data).TabStops <> Nil then
      FillTabStops(TAXWLogPara(Item.Data).TabStops);
    if TAXWLogPara(Item.Data).SEP <> Nil then
      FillSEP(TAXWLogPara(Item.Data).SEP);
    if TAXWLogPara(Item.Data).Graphics <> Nil then
      FillGraphics(TAXWLogPara(Item.Data).Graphics);

    btnRows.Enabled := True;
  end
  else if TObject(Item.Data) is TAXWCharRun then begin
    FillCHPX(TAXWCharRun(Item.Data).CHPX);

    if TObject(Item.Data) is TAXWCharRunLinked then begin
      case TAXWCharRunLinked(Item.Data).LinkedType of
        acrltBookmark    : ;
        acrltComment     : ;
        acrltComplexField: ;
        acrltRevision    : begin
//          if TAXWCharRunLinked(Item.Data).Revision <> Nil then
//            FillRevision(TAXWRevisionData(TAXWCharRunLinked(Item.Data).Revision));
        end;
      end;
    end;

    if TAXWCharRun(Item.Data).Revision <> Nil then
      FillRevision(TAXWCharRun(Item.Data).Revision);
  end;
  if TObject(Item.Data) is TAXWTable then begin
    if TAXWTable(Item.Data).TAPX <> Nil then
      FillTAPX(TAXWTable(Item.Data).TAPX);
  end
  else if TObject(Item.Data) is TAXWTableCell then begin
    if TAXWTableCell(Item.Data).Props <> Nil then
      FillCellProps(TAXWTableCell(Item.Data).Props);
  end
  else if TObject(Item.Data) is TAXWPhyRow then
    FillRow(TAXWPhyRow(Item.Data));
  EndMemLines;
end;

end.
