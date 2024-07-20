unit UnFunctions;

interface
  uses zLib, System.Classes, Vcl.Forms, Winapi.Windows,System.SysUtils, System.DateUtils;

  function RemoveCaracterInformado(Str: String; Caracteres: Array of String): String;
  procedure GeralogCrashlytics(Origem,msg:String);
  function ZCompressString(aText: string; aCompressionLevel: TZCompressionLevel): string;
  function ZDecompressString(aText: string): string;
  function StrZero(Num : Real ; Zeros,Deci: integer): string;
  function StrTran(Entra: string ; Search: string ; Replace : string): string;
  function ValidaCPF_CNPJ(number:String):boolean;
  function CalculoCnpj(xCGC: string): Boolean;
  function CalculoCpf(xCPF: string): Boolean;
  procedure GeralogFile(Origem,msg:String);
  Function unMaskField(Text:String):String;
  function  ValidDocFiscal(doc:String):String;
  Function ConverteData(Data:TDate) : String;
  function GetMacAddress: string;
  function Fc_NomeComputador: string;
  function Fc_Day (Data : TDateTime) : Integer;
  function Fc_Month (Data : TDateTime) : Integer;
  function Fc_Year (Data : TDateTime) : Integer;
  Function Fc_BuscaTamArquivo(Lc_Arquivo : String) : Integer;

implementation

uses tblCrashlytics, REST.Json, un_sistema;

function RemoveCaracterInformado(Str: String; Caracteres: Array of String): String;
var
  I: Integer;
begin
  Result := Str;
  for I := 0 to High(Caracteres) do
  begin
    Result := StringReplace(Result,Caracteres[I],'',[rfReplaceAll,rfIgnoreCase]);
//    while Pos(Caracteres[I], Result) > 0 do
//      Delete(Result, Pos(Caracteres[I], Result), 1);
  end;
end;
procedure GeralogCrashlytics(Origem,msg:String);
//Var
//  LcCrash : TCrashlytics;
//  LcJson : String;
begin
//  Try
//    Try
//      LcCrash := TCrashlytics.Create;
//      LcCrash.Estabelecimento := StrToIntDef(Fc_Aq_Geral('L','SINCRONIA', 'estabelecimento','30'),0);
//      LcCrash.Usuario         := 0;
//      LcCrash.Origem          := origem;
//      LcCrash.Mensagem        := msg;
//      LcCrash.RegistroCriado  := Now;
//      LcCrash.RegistroAlterado  := Now;
//      LcJson := TJson.ObjectToJsonString(LcCrash);
//      DataCM.SMServicesClient.setCrashlytics(LcJson);
//    Except
//      on E: Exception do
//        GeralogFile('GeralogCrashlytics',E.Message);
//    End;
//  Finally
//    GeralogFile(origem,msg);
//    LcCrash.DisposeOf;
//
//  End;
end;

function ZCompressString(aText: string; aCompressionLevel: TZCompressionLevel): string;
var
  strInput,
  strOutput: TStringStream;
  Zipper: TZCompressionStream;
begin
  Result:= aText;
  exit;
  Result:= '';
  strInput:= TStringStream.Create(aText);
  strOutput:= TStringStream.Create;
  try
    Zipper:= TZCompressionStream.Create(strOutput);
    try
      Zipper.CopyFrom(strInput, strInput.Size);
    finally
      Zipper.Free;
    end;
    Result:= strOutput.DataString;
  finally
    strInput.Free;
    strOutput.Free;
  end;
end;

function ZDecompressString(aText: string): string;
var
  strInput,
  strOutput: TStringStream;
  Unzipper: TZDecompressionStream;
begin
  Result:= aText;
  exit;
  Result:= '';
  strInput:= TStringStream.Create(aText);
  strOutput:= TStringStream.Create;
  try
    Unzipper:= TZDecompressionStream.Create(strInput);
    try
      strOutput.CopyFrom(Unzipper, Unzipper.Size);
    finally
      Unzipper.Free;
    end;
    Result:= strOutput.DataString;
  finally
    strInput.Free;
    strOutput.Free;
  end;
end;

function StrZero(Num : Real ; Zeros,Deci: integer): string;
var tam,z : integer;
    res,zer : string;
    lc_negativo : boolean;
begin
   //verifica se o numero é negativo
   Lc_Negativo := False;
   if Num < 0 then
   begin
      Lc_Negativo := True;
      Num := Num * -1;
   end;
   Str(Num:Zeros:Deci, res);
   res := trim(res);
   tam := Length(res);
   zer := '';
   for z := 1 to (Zeros-tam) do
   begin
      //se for numero negativo coloca sinha negativo
      If (Lc_Negativo) and (z = (Zeros-tam)) then
         zer := '-' + zer
      else
         zer := zer + '0';
   end;
   Result := zer+res;
   If Deci <> 0 then
      Result := StrTran(Result,'.',',');
end;
{Fim de StrZero}


{-----------------------------
 Função : StrTran
 Descrição : Procura pelas ocorrencias de um caracter numa
             string e troca por outro valor.
------------------------------}
function StrTran(Entra: string ; Search: string ; Replace : string): string;
var
   tamanho,
   Count : Integer;
   StrTemp,
   Sai : string;
begin
  If Pos(Search,Entra) = 0 Then
  Begin
    Result := Entra;
    Exit;
  End;
  tamanho := length(Search);
  Sai := '';
  for count := 1 to length(Entra) do
  begin
      StrTemp := StrTemp + Entra[count];

      if length (StrTemp) = tamanho then
      begin
          if AnsiCompareText (StrTemp,Search) = 0 then
          begin
              if Replace <> '' then
              begin
                  Sai := Sai + Replace;
              end;
              StrTemp := '';
         end
         else
         begin
            Sai := Sai + StrTemp[1];
            Strtemp := copy (StrTemp,2,tamanho - 1);
         end;
      end;
  end;
  Sai := Sai + StrTemp;

  Result := Sai;
end;
{fim de StrTran}

function ValidaCPF_CNPJ(number:String):boolean;
Begin
  Result := True;
  if ( Length(number) = 14 ) then
    result := CalculoCNPJ(number)
  else
    result := CalculoCPF(number);

End;


function CalculoCnpj(xCGC: string): Boolean;
{Testa se o CGC é válido ou não}
var
   d1, d4, xx, nCount, fator, resto, digito1, digito2: Integer;
   Check: string;
begin
  xCGC := StringReplace(xCGC, ' ', EmptyStr, [rfReplaceAll]);

  if Trim(xCGC) = '' then
  Begin
    Result := False;
    Exit;
  End;

  if (Length(Trim(xCGC)) < 14 ) then
  Begin
    Result := False;
    Exit;
  End;

 if (xCGC = '11111111111111') or (xCGC = '22222222222222') or (xCGC = '33333333333333') or (xCGC = '44444444444444') or
    (xCGC = '55555555555555') or (xCGC = '66666666666666') or (xCGC = '77777777777777') or (xCGC = '88888888888888') or
    (xCGC = '99999999999999') OR  (TRIM(xCGC) = '') or (xCGC = '00000000000000')then
     begin
     Result := False;
     Exit;
     end;
   d1 := 0;
   d4 := 0;
   xx := 1;
   for nCount := 1 to Length(xCGC) - 2 do
   begin
      if Pos(Copy(xCGC, nCount, 1), '/-.') = 0 then
      begin
         if xx < 5 then
         begin
            fator := 6 - xx;
         end
         else
         begin
            fator := 14 - xx;
         end;
         d1 := d1 + StrToInt(Copy(xCGC, nCount, 1)) * fator;
         if xx < 6 then
         begin
            fator := 7 - xx;
         end
         else
         begin
            fator := 15 - xx;
         end;
         d4 := d4 + StrToInt(Copy(xCGC, nCount, 1)) * fator;
         xx := xx + 1;
      end;
   end;
   resto := (d1 mod 11);
   if resto < 2 then
   begin
      digito1 := 0;
   end
   else
   begin
      digito1 := 11 - resto;
   end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
   begin
      digito2 := 0;
   end
   else
   begin
      digito2 := 11 - resto;
   end;

   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCGC, succ(length(xCGC) - 2), 2) then
   begin
      Result := False;
   end
   else
   begin
      Result := True;
   end;
end;

function CalculoCpf(xCPF: string): Boolean;
{Testa se o CPF é válido ou não}
var
   d1, d4, xx, nCount, resto, digito1, digito2: Integer;
   Check: string;
begin
  xCPF := StringReplace(xCPF, ' ', EmptyStr, [rfReplaceAll]);

  if Trim(xCPF) = '' then
  Begin
    Result := False;
    Exit;
  End;

  if (Length(Trim(xCPF)) < 11 ) then
  Begin
    Result := False;
    Exit;
  End;

  if (xCPF = '11111111111') or (xCPF = '22222222222') or (xCPF = '33333333333') or (xCPF = '44444444444') or
    (xCPF = '55555555555') or (xCPF = '66666666666') or (xCPF = '77777777777') or (xCPF = '88888888888') or
    (xCPF = '99999999999') OR  (TRIM(xCPF) = '')or (xCPF = '00000000000000') then
     begin
     Result := False;
     Exit;
     end;

   if (xCPF = '00000000000') then
     begin
     Result := False;
     Exit;
     end;


   d1 := 0; d4 := 0; xx := 1;
   for nCount := 1 to Length(xCPF) - 2 do
   begin
      if Pos(Copy(xCPF, nCount, 1), '/-.') = 0 then
      begin
         d1 := d1 + (11 - xx) * StrToInt(Copy(xCPF, nCount, 1));
         d4 := d4 + (12 - xx) * StrToInt(Copy(xCPF, nCount, 1));
         xx := xx + 1;
      end;
   end;
   resto := (d1 mod 11);
   if resto < 2 then
   begin
      digito1 := 0;
   end
   else
   begin
      digito1 := 11 - resto;
   end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
   begin
      digito2 := 0;
   end
   else
   begin
      digito2 := 11 - resto;
   end;
   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCPF, succ(length(xCPF) - 2), 2) then
   begin
      Result := False;
   end
   else
   begin
      Result := True;
   end;
end;

procedure GeralogFile(Origem,msg:String);
var
  Lc_File: TextFile;
  Lc_PathFileName : String;
  Lc_DateTime : String;
begin
  Try
    Lc_PathFileName := ExtractFilePath(Application.ExeName) + 'log_api_data.txt';
    AssignFile(Lc_File, Lc_PathFileName);
    if FileExists(Lc_PathFileName) then
      Append(Lc_File)
    else
      Rewrite(Lc_File);
    Lc_DateTime := DateTimeToStr(Now);
    Writeln(Lc_File, concat(Lc_DateTime , ' - ' , Origem , ' - ' , msg));
    Flush(Lc_File);  { ensures that the text was actusally written to file }
                    { insert code here that would require a Flush before closing the file }
  Finally
    CloseFile(Lc_File);
  End;
end;

Function unMaskField(Text:String):String;
Begin
  Result := Text;
  Result := stringReplace(Result, '-', '', []);
  Result := stringReplace(Result, '-', '', []);
  Result := stringReplace(Result, '(', '', []);
  Result := stringReplace(Result, ')', '', []);
  Result := stringReplace(Result, '.', '', []);
  Result := stringReplace(Result, '.', '', []);
  Result := stringReplace(Result, '/', '', []);
  Result := stringReplace(Result, '-', '', []);
  Result := stringReplace(Result, ' ', '', []);
End;

function  ValidDocFiscal(doc:String):String;
Var
  Lc_Doc : String;
Begin
  Result := 'OK';
  Lc_Doc := TRIM(unMaskField(Doc));
  if ( Length(Lc_Doc) = 11 ) then
  begin
    if not (CalculoCpf(Lc_Doc)) then
    begin
      Result := 'Número de C.P.F. Inválido.';
      exit;
    end;
  end
  else
  begin
    if not (CalculoCnpj(Lc_Doc)) then
    begin
      Result := 'Número de C.N.P.J. Inválido.';
      exit;
    end;
  end;
End;


Function ConverteData(Data:TDate) : String;
begin
  Result := concat(IntToStr(YearOf(Data)) , '-' , IntToStr(MonthOf(Data)) , '-' + IntToStr(DayOf(data)));
end;
function GetMacAddress: string;
var
  Lib: Cardinal;
  Func: function(GUID: PGUID): Longint; stdcall;
  GUID1, GUID2: TGUID;
begin
  Result := '';
  Lib := LoadLibrary('rpcrt4.dll');
  if Lib <> 0 then
  begin
    @Func := GetProcAddress(Lib, 'UuidCreateSequential');
    if Assigned(Func) then
    begin
      if (Func(@GUID1) = 0) and
         (Func(@GUID2) = 0) and
         (GUID1.D4[2] = GUID2.D4[2]) and
         (GUID1.D4[3] = GUID2.D4[3]) and
         (GUID1.D4[4] = GUID2.D4[4]) and
         (GUID1.D4[5] = GUID2.D4[5]) and
         (GUID1.D4[6] = GUID2.D4[6]) and
         (GUID1.D4[7] = GUID2.D4[7]) then
      begin
        Result :=
          IntToHex(GUID1.D4[2], 2) + '-' +
          IntToHex(GUID1.D4[3], 2) + '-' +
          IntToHex(GUID1.D4[4], 2) + '-' +
          IntToHex(GUID1.D4[5], 2) + '-' +
          IntToHex(GUID1.D4[6], 2) + '-' +
          IntToHex(GUID1.D4[7], 2);
      end;
    end;
  end;
end;

function Fc_NomeComputador: string;
var
  c: array[0..127] of Char;
  sz: dword;
begin
  sz := SizeOf(c);
  GetComputerName(c, sz);
  Result := c;
end;

{--------
 Funcao : Retorna o dia de uma determinada data
 --------}
function Fc_Day (Data : TDateTime) : Integer;
begin
   Result := StrToIntDef(Copy(DateToStr(Data),1,2),1);
end;

{--------
 Funcao : Retorna o mes de uma determinada data
 --------}
function Fc_Month (Data : TDateTime) : Integer;
begin
   Result := StrToIntDef(Copy(DateToStr(Data),4,2),1);
end;

{--------
 Funcao : Retorna o ano de uma determinada data
 --------}
function Fc_Year (Data : TDateTime) : Integer;
begin
   Result := StrToIntDef(Copy(DateToStr(Data),7,4),1);
end;

function Fc_BuscaTamArquivo(Lc_Arquivo : String) : Integer;
var
  Lc_NomeArquivo : File of Byte;
begin
   Result:=-1;

   If FileExists(Lc_Arquivo)  then
   begin
      AssignFile(Lc_NomeArquivo,Lc_Arquivo);
      // garante q o arquivo está fechado, então tenta fecha-lo,
      // e se não estiver aberto dá erro então deixa dentro do Try-Except
      try
         Reset(Lc_NomeArquivo);
         Result:=FileSize(Lc_NomeArquivo);
         CloseFile(Lc_NomeArquivo);
      except
         Try
            CloseFile(Lc_NomeArquivo);
            Reset(Lc_NomeArquivo);
            Result:=FileSize(Lc_NomeArquivo);
            CloseFile(Lc_NomeArquivo);
         except
            Result:=-1;
        end;
      end;
   end;
end;



end.
