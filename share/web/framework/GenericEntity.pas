unit GenericEntity;

interface

uses
  System.Classes, System.SysUtils, System.DateUtils;

Type
  TGenericEntity = class//class(TPersistent)
  private

  protected
    function JSONDate_To_Datetime(JSONDate: string): TDatetime;
  public

  end;

implementation


{ TGenericEntity }

function TGenericEntity.JSONDate_To_Datetime(JSONDate: string): TDatetime;
var Year, Month, Day, Hour, Minute, Second, Millisecond: Word;
begin
  Year        := StrToInt(Copy(JSONDate, 1, 4));
  Month       := StrToInt(Copy(JSONDate, 6, 2));
  Day         := StrToInt(Copy(JSONDate, 9, 2));
  Hour        := StrToInt(Copy(JSONDate, 12, 2));
  Minute      := StrToInt(Copy(JSONDate, 15, 2));
  Second      := StrToInt(Copy(JSONDate, 18, 2));
  Millisecond := Round(StrToFloat(Copy(JSONDate, 19, 4)));

  Result := EncodeDateTime(Day,Month, Year, Hour, Minute, Second, Millisecond);

end;

end.

