unit Functions;

interface

uses
  System.Classes, System.SysUtils;

function GenerateUniqueNameFromOwner(AOwner: TComponent; Name: string): string;

implementation

function GenerateUniqueNameFromOwner(AOwner: TComponent; Name: string): string;
var
  I: Integer;
begin
  I := 0;
  repeat
    Inc(I);
    Result := Name + '_' + IntToStr(I);
  until AOwner.FindComponent(Result) = nil;
end;

end.
