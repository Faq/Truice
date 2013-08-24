unit DBCfile;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

const
    FT_NA='x';                                              //not used or unknown, 4 byte size
    FT_NA_BYTE='X';                                         //not used or unknown, byte
    FT_STRING='s';                                          //char*
    FT_FLOAT='f';                                           //float
    FT_INT='i';                                             //uint32
    FT_BYTE='b';                                            //uint8
    FT_SORT='d';                                            //sorted by this field, field is not included
    FT_IND='n';                                             //the same,but parsed to data
    FT_LOGIC='l';                                           //Logical (boolean)

type
  PCardinal = array of Cardinal;
  PInteger = array of Integer;
  PArray = array of Char;

  PDBCFile = ^TDBCFile;
  TDBCFile = class
  public
    recordSize:   Cardinal;
    recordCount:  Cardinal;
    fieldCount:   Cardinal;
    stringSize:   Cardinal;
    fieldsOffset: PCardinal;
    data:         PAnsiChar;
    stringTable:  PAnsiChar;
    offset:       PAnsiChar;
    IsLocalized:  boolean;

    constructor Create;
    destructor Destroy; override;
    function Load(filename: WideString): boolean;

    procedure setRecord(id: Cardinal);

    function GetNumRows(): Cardinal;
    function GetCols(): Cardinal;
    function GetOffset(id: Cardinal): Cardinal;
    function IsLoaded(): boolean;

    function getFloat(field: Cardinal): Single;
    function getUInt(field: Cardinal): Cardinal;
    function getUInt8(field: Cardinal): Byte;
    function getPChar(field: Cardinal): PAnsiChar;
    function getString(field: Cardinal): string;
  end;

implementation

uses MyDataModule;

procedure assert(Expr: boolean);
begin
  if not Expr then raise Exception.Create('Incorrect field number');
end;

{ TDBCFile }

constructor TDBCFile.Create;
begin
  data := NIL;
  fieldsOffset := NIL;
  IsLocalized := true;
end;

destructor TDBCFile.Destroy;
begin
  if Assigned(data) then FreeMem(data);
  if Assigned(fieldsOffset) then SetLength(fieldsOffset,0);
  inherited;
end;

function TDBCFile.GetCols: Cardinal;
begin
  Result := fieldCount;
end;

function TDBCFile.GetNumRows: Cardinal;
begin
  Result := recordCount;
end;

function TDBCFile.GetOffset(id: Cardinal): Cardinal;
begin
  if (fieldsOffset <> nil) and (id<fieldCount) then
    Result := fieldsOffset[id]
  else
    Result := 0;
end;

procedure TDBCFile.setRecord(id: Cardinal);
begin
  offset := PAnsiChar(Cardinal(data) + id * recordSize);
end;

function TDBCFile.IsLoaded: boolean;
begin
  Result := data <> nil;
end;

function TDBCFile.Load(filename: WideString): boolean;
var
  header, i: Cardinal;
  f: Integer;
begin
  if Assigned(data) then
  begin
    FreeMem(data);
    data := nil;
  end;
  f := FileOpen(filename, fmOpenRead);
  if f = -1 then 
  begin
    Result := false;
    Exit;
  end;
  FileRead(f, header, 4);
  if header <> $43424457 then
  begin
    Result := false;
    Exit;
  end;
  FileRead(F, recordCount, 4);
  FileRead(F, fieldCount, 4);
  FileRead(F, recordSize, 4);
  FileRead(F, stringSize, 4);
  SetLength(fieldsOffset, fieldCount);
  fieldsOffset[0] := 0;
  for i := 1 to fieldCount - 1 do
  begin
    fieldsOffset[i] := fieldsOffset[i-1];
    inc(fieldsOffset[i],4);
  end;
  data := PAnsiChar(AllocMem(recordSize*recordCount + stringSize + 1));
  stringTable := pointer( Cardinal(data) + recordSize*recordCount);
  FileRead(F, data^, recordSize*recordCount+stringSize);
  FileClose(F);
  Result := True;
end;

{ TRecord }

function TDBCFile.getFloat(field: Cardinal): Single;
begin
  assert(field < fieldCount);
  CopyMemory(@Result, offset + GetOffset(field), SizeOf(Result));
end;

function TDBCFile.getPChar(field: Cardinal): PAnsiChar;
var
  stringOffset : Cardinal;
  fieldid: Cardinal;
  i: Cardinal;
begin
  if dmMain.DBCLocale < 16 then
  begin
    if IsLocalized then
      fieldid := field + dmMain.DBCLocale
    else
      fieldid := field;
    assert(fieldid < fieldCount);
    stringOffset := getUInt(fieldid);
    assert(stringOffset < stringSize);
    Result := stringTable + stringOffset;
  end
  else
  begin
    // Autodetect DBC Locale
    for I := 0 to 15 do
    begin
      fieldid := field + I;
      assert(fieldid < fieldCount);
      stringOffset := getUInt(fieldid);
      assert(stringOffset < stringSize);
      Result := stringTable + stringOffset;
      if Result<>'' then
      begin
        dmMain.DBCLocale := I;
        Exit;
      end;
    end;
  end;
end;

function TDBCFile.getString(field: Cardinal): string;
var
  s: PAnsiChar;
begin
  s := getPChar(field);
  Result := UTF8ToString(s);
end;

function TDBCFile.getUInt(field: Cardinal): Cardinal;
begin
  assert(field < fieldCount);
  CopyMemory(@Result, offset + GetOffset(field), sizeof(Result));
end;

function TDBCFile.getUInt8(field: Cardinal): Byte;
begin
  assert(field < fieldCount);
  CopyMemory(@Result, offset + GetOffset(field), SizeOf(Result));
end;

end.
