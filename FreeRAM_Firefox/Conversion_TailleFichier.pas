unit Conversion_TailleFichier;

interface

uses SysUtils;

const
  Un_GigaOctet=1073741824;
  Un_MegaOctet=1048576;
  Un_KiloOctet=1024;

function ConvertirTaille(TailleEnOctets:int64):string;

implementation

function ConvertirTaille(TailleEnOctets:int64):string;
begin
  if TailleEnOctets>Un_GigaOctet then
  begin
    Result:=IntToStr(TailleEnOctets div Un_GigaOctet)+' GB';
    exit;
  end;
  if TailleEnOctets>Un_MegaOctet then
  begin
    Result:=IntToStr(TailleEnOctets div Un_MegaOctet)+' MB';
    exit;
  end;
  Result:=IntToStr(TailleEnOctets div Un_KiloOctet)+' KB';
end;

end.
