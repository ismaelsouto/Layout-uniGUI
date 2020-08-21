unit uActualizarBDGeneral;

interface

uses SysUtils, FireDAC.Comp.Client, Funciones, StrUtils;

function ActualizarBDGeneral(Conexion:TFDConnection):boolean;

const
  Version='01.64';

implementation

function ActualizarBDGeneral(Conexion:TFDConnection):boolean;
var
  VersionActual:Integer;
begin
  try
    with ConsultaAD(Conexion,'SELECT REPLACE(VERSION,''.'','''') FROM ASESORIA') do
      try
        VersionActual:=Fields.Fields[0].AsInteger
      finally
        Free;
      end;
    Result:=VersionActual=StrToInt(ReplaceText(Version,'.',''));
    if not Result then
    begin
      Conexion.ExecSQL('DELETE FROM MON$ATTACHMENTS WHERE MON$ATTACHMENT_ID<>CURRENT_CONNECTION');
      while VersionActual<StrToInt(ReplaceText(Version,'.','')) do
      begin
        Conexion.StartTransaction;
        try
          Inc(VersionActual);
          case VersionActual of
            156:;
            157:Conexion.ExecSQL('ALTER TABLE PAISES ADD TGSS INTEGER');
            158:Conexion.ExecSQL('ALTER TABLE REPRESEN ADD DOCUMENTACION VARCHAR(50),ADD TIPODOCUMENTACION VARCHAR(50)');
            159: begin
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =724 WHERE CLAVE=''ES''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =276 WHERE CLAVE=''DE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =40 WHERE CLAVE=''AT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =56 WHERE CLAVE=''BE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =100 WHERE CLAVE=''BG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =203 WHERE CLAVE=''CZ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =196 WHERE CLAVE=''CY''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =208 WHERE CLAVE=''DK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =703 WHERE CLAVE=''SK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =705 WHERE CLAVE=''SI''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =233 WHERE CLAVE=''EE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =246 WHERE CLAVE=''FI''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =250 WHERE CLAVE=''FR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =300 WHERE CLAVE=''GR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =348 WHERE CLAVE=''HU''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =372 WHERE CLAVE=''IE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =380 WHERE CLAVE=''IT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =428 WHERE CLAVE=''LV''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =440 WHERE CLAVE=''LT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =442 WHERE CLAVE=''LU''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =470 WHERE CLAVE=''MT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =528 WHERE CLAVE=''NL''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =616 WHERE CLAVE=''PL''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =620 WHERE CLAVE=''PT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =826 WHERE CLAVE=''UK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =642 WHERE CLAVE=''RO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =752 WHERE CLAVE=''SE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =4 WHERE CLAVE=''AF''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =8 WHERE CLAVE=''AL''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =20 WHERE CLAVE=''AD''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =24 WHERE CLAVE=''AO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =214 WHERE CLAVE=''DO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =218 WHERE CLAVE=''EC''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =818 WHERE CLAVE=''EG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =784 WHERE CLAVE=''AE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =232 WHERE CLAVE=''ER''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =231 WHERE CLAVE=''ET''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =234 WHERE CLAVE=''FO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =608 WHERE CLAVE=''PH''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =242 WHERE CLAVE=''FJ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =266 WHERE CLAVE=''GA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =270 WHERE CLAVE=''GM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =268 WHERE CLAVE=''GE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =239 WHERE CLAVE=''GS''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =288 WHERE CLAVE=''GH''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =292 WHERE CLAVE=''GI''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =308 WHERE CLAVE=''GD''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =304 WHERE CLAVE=''GL''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =316 WHERE CLAVE=''GU''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =320 WHERE CLAVE=''GT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =831 WHERE CLAVE=''GG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =324 WHERE CLAVE=''GN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =226 WHERE CLAVE=''GQ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =624 WHERE CLAVE=''GW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =328 WHERE CLAVE=''GY''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =332 WHERE CLAVE=''HT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =334 WHERE CLAVE=''HM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =340 WHERE CLAVE=''HN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =344 WHERE CLAVE=''HK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =356 WHERE CLAVE=''IN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =360 WHERE CLAVE=''ID''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =364 WHERE CLAVE=''IR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =368 WHERE CLAVE=''IQ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =833 WHERE CLAVE=''IM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =352 WHERE CLAVE=''IS''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =376 WHERE CLAVE=''IL''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =388 WHERE CLAVE=''JM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =392 WHERE CLAVE=''JP''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =832 WHERE CLAVE=''JE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =400 WHERE CLAVE=''JO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =398 WHERE CLAVE=''KZ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =404 WHERE CLAVE=''KE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =296 WHERE CLAVE=''KI''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =414 WHERE CLAVE=''KW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =418 WHERE CLAVE=''LA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =426 WHERE CLAVE=''LS''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =422 WHERE CLAVE=''LB''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =430 WHERE CLAVE=''LR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =434 WHERE CLAVE=''LY''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =438 WHERE CLAVE=''LI''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =446 WHERE CLAVE=''MO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =807 WHERE CLAVE=''MK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =450 WHERE CLAVE=''MG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =458 WHERE CLAVE=''MY''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =454 WHERE CLAVE=''MW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =462 WHERE CLAVE=''MV''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =466 WHERE CLAVE=''ML''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =238 WHERE CLAVE=''FK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =580 WHERE CLAVE=''MP''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =504 WHERE CLAVE=''MA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =584 WHERE CLAVE=''MH''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =480 WHERE CLAVE=''MU''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =478 WHERE CLAVE=''MR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =175 WHERE CLAVE=''YT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =581 WHERE CLAVE=''UM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =484 WHERE CLAVE=''MX''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =583 WHERE CLAVE=''FM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =498 WHERE CLAVE=''MD''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =492 WHERE CLAVE=''MC''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =496 WHERE CLAVE=''MN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =499 WHERE CLAVE=''ME''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =500 WHERE CLAVE=''MS''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =508 WHERE CLAVE=''MZ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =104 WHERE CLAVE=''MM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =516 WHERE CLAVE=''NA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =520 WHERE CLAVE=''NR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =162 WHERE CLAVE=''CX''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =524 WHERE CLAVE=''NP''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =558 WHERE CLAVE=''NI''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =562 WHERE CLAVE=''NE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =566 WHERE CLAVE=''NG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =570 WHERE CLAVE=''NU''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =574 WHERE CLAVE=''NF''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =578 WHERE CLAVE=''NO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =540 WHERE CLAVE=''NC''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =554 WHERE CLAVE=''NZ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =86 WHERE CLAVE=''IO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =512 WHERE CLAVE=''OM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =586 WHERE CLAVE=''PK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =585 WHERE CLAVE=''PW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =591 WHERE CLAVE=''PA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =598 WHERE CLAVE=''PG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =600 WHERE CLAVE=''PY''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =604 WHERE CLAVE=''PE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =612 WHERE CLAVE=''PN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =258 WHERE CLAVE=''PF''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =630 WHERE CLAVE=''PR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =634 WHERE CLAVE=''QA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =646 WHERE CLAVE=''RW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =90 WHERE CLAVE=''SB''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =222 WHERE CLAVE=''SV''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =882 WHERE CLAVE=''WS''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =16 WHERE CLAVE=''AS''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =659 WHERE CLAVE=''KN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =674 WHERE CLAVE=''SM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =666 WHERE CLAVE=''PM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =670 WHERE CLAVE=''VC''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =654 WHERE CLAVE=''SH''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =662 WHERE CLAVE=''LC''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =678 WHERE CLAVE=''ST''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =686 WHERE CLAVE=''SN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =688 WHERE CLAVE=''RS''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =690 WHERE CLAVE=''SC''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =694 WHERE CLAVE=''SL''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =702 WHERE CLAVE=''SG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =760 WHERE CLAVE=''SY''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =706 WHERE CLAVE=''SO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =144 WHERE CLAVE=''LK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =748 WHERE CLAVE=''SZ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =710 WHERE CLAVE=''ZA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =729 WHERE CLAVE=''SD''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =728 WHERE CLAVE=''SS''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =756 WHERE CLAVE=''CH''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =740 WHERE CLAVE=''SR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =764 WHERE CLAVE=''TH''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =158 WHERE CLAVE=''TW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =762 WHERE CLAVE=''TJ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =260 WHERE CLAVE=''TF''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =768 WHERE CLAVE=''TG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =772 WHERE CLAVE=''TK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =776 WHERE CLAVE=''TO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =780 WHERE CLAVE=''TT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =788 WHERE CLAVE=''TN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =796 WHERE CLAVE=''TC''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =795 WHERE CLAVE=''TM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =792 WHERE CLAVE=''TR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =798 WHERE CLAVE=''TV''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =804 WHERE CLAVE=''UA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =800 WHERE CLAVE=''UG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =548 WHERE CLAVE=''VU''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =336 WHERE CLAVE=''VA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =862 WHERE CLAVE=''VE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =704 WHERE CLAVE=''VN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =92 WHERE CLAVE=''VG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =876 WHERE CLAVE=''WF''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =887 WHERE CLAVE=''YE''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =262 WHERE CLAVE=''DJ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =894 WHERE CLAVE=''ZM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =716 WHERE CLAVE=''ZW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =826 WHERE CLAVE=''GB''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =300 WHERE CLAVE=''EL''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =660 WHERE CLAVE=''AI''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =10 WHERE CLAVE=''AQ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =28 WHERE CLAVE=''AG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =682 WHERE CLAVE=''SA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =12 WHERE CLAVE=''DZ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =32 WHERE CLAVE=''AR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =51 WHERE CLAVE=''AM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =533 WHERE CLAVE=''AW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =36 WHERE CLAVE=''AU''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =31 WHERE CLAVE=''AZ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =44 WHERE CLAVE=''BS''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =48 WHERE CLAVE=''BH''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =50 WHERE CLAVE=''BD''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =52 WHERE CLAVE=''BB''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =84 WHERE CLAVE=''BZ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =204 WHERE CLAVE=''BJ''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =60 WHERE CLAVE=''BM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =112 WHERE CLAVE=''BY''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =68 WHERE CLAVE=''BO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =70 WHERE CLAVE=''BA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =72 WHERE CLAVE=''BW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =74 WHERE CLAVE=''BV''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =76 WHERE CLAVE=''BR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =96 WHERE CLAVE=''BN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =108 WHERE CLAVE=''BI''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =64 WHERE CLAVE=''BT''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =132 WHERE CLAVE=''CV''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =136 WHERE CLAVE=''KY''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =116 WHERE CLAVE=''KH''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =120 WHERE CLAVE=''CM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =124 WHERE CLAVE=''CA''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =140 WHERE CLAVE=''CF''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =148 WHERE CLAVE=''TD''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =152 WHERE CLAVE=''CL''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =156 WHERE CLAVE=''CN''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =166 WHERE CLAVE=''CC''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =170 WHERE CLAVE=''CO''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =174 WHERE CLAVE=''KM''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =178 WHERE CLAVE=''CG''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =184 WHERE CLAVE=''CK''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =408 WHERE CLAVE=''KP''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =410 WHERE CLAVE=''KR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =384 WHERE CLAVE=''CI''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =188 WHERE CLAVE=''CR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =191 WHERE CLAVE=''HR''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =192 WHERE CLAVE=''CU''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =531 WHERE CLAVE=''CW''');
                    Conexion.ExecSQL('UPDATE PAISES SET TGSS =212 WHERE CLAVE=''DM''');
            end;
            // Actualizaciones de general
            160: begin
              Conexion.ExecSQL('ALTER TABLE CLIENTES ADD NOMBRCLI_1 VARCHAR(120),ADD PJURICLI_1 VARCHAR(120) , '+
                                         'ADD PFAP1CLI_1 VARCHAR(40) ,ADD PFAP2CLI_1 VARCHAR(40) ,ADD PFNOMCLI_1 VARCHAR(40) ,ADD CORRFCLI_1 VARCHAR(100),ADD CORRSCLI_1 VARCHAR(100)');

              Conexion.ExecSQL('ALTER TABLE REPRESEN ADD NOMBRREP_1 VARCHAR(120),ADD PJURIREP_1 VARCHAR(120) , '+
                                         'ADD PFAP1REP_1 VARCHAR(40) ,ADD PFAP2REP_1 VARCHAR(40) ,ADD PFNOMREP_1 VARCHAR(40)');

              Conexion.ExecSQL('ALTER TABLE DATOSFIS ADD NOMBRE_1 VARCHAR(120),ADD PJURIDIC_1 VARCHAR(120) , '+
                                         'ADD PFAPELL1_1 VARCHAR(40) ,ADD PFAPELL2_1 VARCHAR(40) ,ADD PFNOMBRE_1 VARCHAR(40) ');
            end;

            161: begin;
              Conexion.ExecSQL('UPDATE CLIENTES SET NOMBRCLI_1 =NOMBRCLI,PJURICLI_1=PJURICLI , '+
                                         'PFAP1CLI_1=PFAP1CLI ,PFAP2CLI_1=PFAP2CLI ,PFNOMCLI_1=PFNOMCLI ,CORRFCLI_1=CORRFCLI,CORRSCLI_1=CORRSCLI');

              Conexion.ExecSQL('UPDATE REPRESEN SET NOMBRREP_1 =NOMBRREP,PJURIREP_1=PJURIREP, '+
                                         'PFAP1REP_1=PFAP1REP ,PFAP2REP_1=PFAP2REP,PFNOMREP_1=PFNOMREP');


              Conexion.ExecSQL('UPDATE DATOSFIS SET NOMBRE_1 =NOMBRE ,PJURIDIC_1=PJURIDIC  , '+
                                         'PFAPELL1_1=PFAPELL1  ,PFAPELL2_1=PFAPELL2   ,PFNOMBRE_1=PFNOMBRE ');
            end;

            162: begin
              Conexion.ExecSQL('CREATE OR ALTER TRIGGER CLIENTES_AIC FOR CLIENTES '+
                                          'ACTIVE BEFORE INSERT OR UPDATE POSITION 0 '+
                                          'AS BEGIN '+
                                          '     IF (TRIM(COALESCE(NEW.NOMBRCLI_1,''''))='''') THEN BEGIN '+
                                          '       NEW.PJURICLI_1 = NEW.PJURICLI; '+
                                          '       NEW.PFAP1CLI_1 = NEW.PFAP1CLI; '+
                                          '       NEW.PFAP2CLI_1 = NEW.PFAP2CLI; '+
                                          '       NEW.PFNOMCLI_1 = NEW.PFNOMCLI; '+
                                          '       NEW.CORRFCLI_1 = NEW.CORRFCLI; '+
                                          '       NEW.CORRSCLI_1 = NEW.CORRSCLI; '+
                                          '       NEW.NOMBRCLI_1 = NEW.NOMBRCLI; '+
                                          '     END '+
                                          '    END ');


              Conexion.ExecSQL('CREATE OR ALTER TRIGGER REPRESEN_AIC FOR REPRESEN '+
                                          'ACTIVE BEFORE INSERT OR UPDATE POSITION 0 '+
                                          'AS '+
                                          ' BEGIN '+
                                          '   IF (TRIM(COALESCE(NEW.NOMBRREP_1,''''))='''') THEN BEGIN '+
                                          '     NEW.PJURIREP_1 = NEW.PJURIREP; '+
                                          '     NEW.PFAP1REP_1 = NEW.PFAP1REP; '+
                                          '     NEW.PFAP2REP_1 = NEW.PFAP2REP; '+
                                          '     NEW.PFNOMREP_1 = NEW.PFNOMREP; '+
                                          '     NEW.NOMBRREP_1= NEW.NOMBRREP; '+
                                          '   END '+
                                          ' END ');



              Conexion.ExecSQL('CREATE OR ALTER TRIGGER DATOSFIS_AI1C FOR DATOSFIS '+
                                        'ACTIVE BEFORE INSERT OR UPDATE POSITION 1 '+
                                        'AS '+
                                        ' BEGIN '+
                                        '   IF (TRIM(COALESCE(NEW.NOMBRE_1,''''))='''') THEN BEGIN '+
                                        '     NEW.PJURIDIC_1= NEW.PJURIDIC; '+
                                        '     NEW.PFAPELL1_1= NEW.PFAPELL1; '+
                                        '     NEW.PFAPELL2_1= NEW.PFAPELL2; '+
                                        '     NEW.PFNOMBRE_1= NEW.PFNOMBRE; '+
                                        '     NEW.NOMBRE_1= NEW.NOMBRE; '+
                                        '   END '+
                                        ' END ');




              Conexion.ExecSQL('CREATE OR ALTER TRIGGER CLIENTES_AI FOR CLIENTES '+
                                         'ACTIVE BEFORE INSERT OR UPDATE '+
                                         'POSITION 1 '+
                                         'AS '+
                                         'BEGIN '+
                                         '  NEW.PJURICLI = SUBSTRING(NEW.PJURICLI_1 FROM 1 FOR 40); '+
                                         '  NEW.PFAP1CLI = SUBSTRING(NEW.PFAP1CLI_1 FROM 1 FOR 15); '+
                                         '  NEW.PFAP2CLI = SUBSTRING(NEW.PFAP2CLI_1  FROM 1 FOR 15); '+
                                         '  NEW.PFNOMCLI = SUBSTRING(NEW.PFNOMCLI_1  FROM 1 FOR 10); '+
                                         '  NEW.CORRFCLI = SUBSTRING(NEW.CORRFCLI_1  FROM 1 FOR 40); '+
                                         '  NEW.CORRSCLI = SUBSTRING(NEW.CORRSCLI_1  FROM 1 FOR 40); '+
                                         '  IF (TRIM(COALESCE(NEW.PJURICLI,''''))<>'''') THEN BEGIN   '+
                                         '    NEW.NOMBRCLI=NEW.PJURICLI;   '+
                                         '  END   '+
                                         '  ELSE BEGIN '+
                                         '    NEW.NOMBRCLI=SUBSTRING(TRIM(SUBSTRING(COALESCE(NEW.PFAP1CLI_1,'''') FROM 1 FOR 15))||'' ''||TRIM(SUBSTRING(COALESCE(NEW.PFAP2CLI_1,'''')  FROM 1 FOR 15))||'',''||TRIM(SUBSTRING(COALESCE(NEW.PFNOMCLI_1,'''')  FROM 1 FOR 10))  FROM 1 FOR 40); '+
                                         '  END '+
                                         'END;  ');

              Conexion.ExecSQL('CREATE OR ALTER TRIGGER REPRESEN_AI FOR REPRESEN '+
                                         'ACTIVE BEFORE INSERT OR UPDATE '+
                                         'POSITION 1 '+
                                         'AS  '+
                                         'BEGIN   '+
                                         '  NEW.PJURIREP = SUBSTRING(NEW.PJURIREP_1 FROM 1 FOR 40);  '+
                                         '  NEW.PFAP1REP = SUBSTRING(NEW.PFAP1REP_1 FROM 1 FOR 15); '+
                                         '  NEW.PFAP2REP = SUBSTRING(NEW.PFAP2REP_1  FROM 1 FOR 15); '+
                                         '  NEW.PFNOMREP = SUBSTRING(NEW.PFNOMREP_1  FROM 1 FOR 10); '+
                                         '  IF (TRIM(COALESCE(NEW.PJURIREP,''''))<>'''') THEN BEGIN   '+
                                         '    NEW.NOMBRREP=NEW.PJURIREP;   '+
                                         '  END   '+
                                         '  ELSE BEGIN '+
                                         '    NEW.NOMBRREP=SUBSTRING(TRIM(SUBSTRING(COALESCE(NEW.PFAP1REP_1,'''') FROM 1 FOR 15))||'' ''||TRIM(SUBSTRING(COALESCE(NEW.PFAP2REP_1,'''')  FROM 1 FOR 15))||'',''||TRIM(SUBSTRING(COALESCE(NEW.PFNOMREP_1,'''')  FROM 1 FOR 10))  FROM 1 FOR 40); '+
                                         '  END '+
                                         'END; ');


              Conexion.ExecSQL('CREATE OR ALTER TRIGGER DATOSFIS_AI1 FOR DATOSFIS  '+
                                         'ACTIVE BEFORE INSERT OR UPDATE  '+
                                         'POSITION 2  '+
                                         'AS   '+
                                         'BEGIN   '+
                                         ' NEW.PJURIDIC=SUBSTRING(NEW.PJURIDIC_1 FROM 1 FOR 40);   '+
                                         ' NEW.PFAPELL1=SUBSTRING(NEW.PFAPELL1_1 FROM 1 FOR 15);   '+
                                         ' NEW.PFAPELL2=SUBSTRING(NEW.PFAPELL2_1  FROM 1 FOR 15); '+
                                         ' NEW.PFNOMBRE=SUBSTRING(NEW.PFNOMBRE_1  FROM 1 FOR 10);  '+
                                         '  IF (TRIM(COALESCE(NEW.PJURIDIC,''''))<>'''') THEN BEGIN   '+
                                         '    NEW.NOMBRE=NEW.PJURIDIC;   '+
                                         '  END   '+
                                         '  ELSE BEGIN '+
                                         '    NEW.NOMBRE=SUBSTRING(TRIM(SUBSTRING(COALESCE(NEW.PFAPELL1_1,'''') FROM 1 FOR 15))||'' ''||TRIM(SUBSTRING(COALESCE(NEW.PFAPELL2_1,'''')  FROM 1 FOR 15))||'',''||TRIM(SUBSTRING(COALESCE(NEW.PFNOMBRE_1,'''')  FROM 1 FOR 10))  FROM 1 FOR 40); '+
                                         '  END '+
                                         'END; ');
            end;

            163:;   // *** Sincroniza las versiones de WEB y local
            164:;   // *** Sincroniza las versiones de WEB y local

          end;
          Conexion.ExecSQL('UPDATE ASESORIA SET VERSION='+QuotedStr('0'+ReplaceText(FloatToStr(VersionActual/100),',','.')));
          Conexion.Commit;
        except
          Conexion.Rollback;
          Raise;
        end;
      end;
      Result:=True;
    end;
  except
    Result:=False;
    raise;
  end;
end;

end.
