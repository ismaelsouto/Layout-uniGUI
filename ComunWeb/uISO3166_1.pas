unit uISO3166_1;

interface

uses Windows;

type
  TEnumData = record
    GeoCode: string;
    GeoName: string;
    Success: Boolean;
  end;

  GEOID = type LONG;
  GEOTYPE = type DWORD;
  GEOCLASS = type DWORD;

  SYSGEOTYPE = (
    GEO_NATION = $0001,
    GEO_LATITUDE = $0002,
    GEO_LONGITUDE = $0003,
    GEO_ISO2 = $0004,
    GEO_ISO3 = $0005,
    GEO_RFC1766 = $0006,
    GEO_LCID = $0007,
    GEO_FRIENDLYNAME= $0008,
    GEO_OFFICIALNAME= $0009,
    GEO_TIMEZONES = $000A,
    GEO_OFFICIALLANGUAGES = $000B,
    GEO_ISO_UN_NUMBER = $000C,
    GEO_PARENT = $000D
  );

  SYSGEOCLASS = (
    GEOCLASS_NATION = 16,
    GEOCLASS_REGION = 14,
    GEOCLASS_ALL = 0
  );

  GEO_ENUMPROC = function(GeoId: GEOID): BOOL; stdcall;

  function EnumSystemGeoID(GeoClass: GEOCLASS;
    ParentGeoId: GEOID; lpGeoEnumProc: GEO_ENUMPROC): BOOL; stdcall;
    external kernel32 name 'EnumSystemGeoID';

  function GetGeoInfo(Location: GEOID; GeoType: GEOTYPE;
    lpGeoData: LPTSTR; cchData: Integer; LangId: LANGID): Integer; stdcall;
    external kernel32 name {$IFDEF UNICODE}'GetGeoInfoW'{$ELSE}'GetGeoInfoA'{$ENDIF};



  function TryGetGeoInfo(GeoId: GEOID; GeoType: GEOTYPE; out Value: string): Boolean;

  function TryGetISO2ToISO3(const ISO2: string; out ISO3: string): Boolean;
  function TryGetISO3ToISO2(const ISO3: string; out ISO2: string): Boolean;


implementation

uses SysUtils;

var
  EnumData: TEnumData;

function TryGetGeoInfo(GeoId: GEOID; GeoType: GEOTYPE; out Value: string): Boolean;
var
  Buffer: string;
  BufferLen: Integer;
begin
  Result := False;
  BufferLen := GetGeoInfo(GeoId, GeoType, LPTSTR(Buffer), 0, 0);
  if BufferLen <> 0 then
  begin
    SetLength(Buffer, BufferLen);
    Result := GetGeoInfo(GeoId, GeoType, LPTSTR(Buffer), BufferLen, 0) <> 0;
    if Result then
      Value := Trim(Buffer);
  end;
end;



function EnumGeoInfoProcISO2ToISO3(GeoId: GEOID): BOOL; stdcall;
var
  S: string;
begin
  Result := TryGetGeoInfo(GeoId, GEOTYPE(GEO_ISO2), S);
  if Result and (S = EnumData.GeoCode) then
  begin
    // stop the enumeration since we've found the country by its ISO code
    Result := False;
    // return the success flag and try to return the friendly name of the country to the
    // EnumData.GeoName record field; you can optionally query the GEO_OFFICIALNAME
    //    EnumData.Success := TryGetGeoInfo(GeoId, GEOTYPE(GEO_FRIENDLYNAME), EnumData.GeoName);
    EnumData.Success := TryGetGeoInfo(GeoId, GEOTYPE(GEO_ISO3), EnumData.GeoName);
  end;
end;


function EnumGeoInfoProcISO3ToISO2(GeoId: GEOID): BOOL; stdcall;
var
  S: string;
begin
  Result := TryGetGeoInfo(GeoId, GEOTYPE(GEO_ISO3), S);
  if Result and (S = EnumData.GeoCode) then
  begin
    // stop the enumeration since we've found the country by its ISO code
    Result := False;
    // return the success flag and try to return the friendly name of the country to the
    // EnumData.GeoName record field; you can optionally query the GEO_OFFICIALNAME
    //    EnumData.Success := TryGetGeoInfo(GeoId, GEOTYPE(GEO_FRIENDLYNAME), EnumData.GeoName);
    EnumData.Success := TryGetGeoInfo(GeoId, GEOTYPE(GEO_ISO2), EnumData.GeoName);
  end;
end;


function TryGetISO2ToISO3(const ISO2: string; out ISO3: string): Boolean;
begin
  // here is the brainless part using global record variable (because the function used
  // here with its callback does not support passing user data); no, you cannot tune it
  // up by making the callback function nested
  EnumData.GeoCode := ISO2;
  EnumData.Success := False;

  if not EnumSystemGeoID(GEOCLASS(GEOCLASS_NATION), 0, EnumGeoInfoProcISO2ToISO3) then
    RaiseLastOSError;

  Result := EnumData.Success;
  if Result then
    ISO3 := EnumData.GeoName;
end;


function TryGetISO3ToISO2(const ISO3: string; out ISO2: string): Boolean;
begin
  // here is the brainless part using global record variable (because the function used
  // here with its callback does not support passing user data); no, you cannot tune it
  // up by making the callback function nested
  EnumData.GeoCode := ISO3;
  EnumData.Success := False;

  if not EnumSystemGeoID(GEOCLASS(GEOCLASS_NATION), 0, EnumGeoInfoProcISO3ToISO2) then
    RaiseLastOSError;

  Result := EnumData.Success;
  if Result then
    ISO2 := EnumData.GeoName;
end;


end.
