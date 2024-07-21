unit RN_Endereco;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,FireDAC.Stan.Param,
  StdCtrls,classes,db, ControllerEndereco, UnFunctions;

  function Fc_GravaEndereco(Fc_CODIGO: integer;
                             Fc_CODEMP: integer;
                             Fc_CNPJ: string;
                             Fc_TIPO: string;
                             Fc_ENDER: string;
                             Fc_COMPLEM: string;
                             Fc_BAIRRO: string;
                             Fc_CEP: string;
                             Fc_CONTATO: string;
                             Fc_FONE: string;
                             Fc_FAX: string;
                             Fc_CELULAR: string;
                             Fc_COMERCIAL: String;
                             Fc_PORTARIA: String;
                             Fc_REGIAO: string;
                             Fc_NUMERO: string;
                             Fc_PAIS: string;
                             Fc_CODCDD: integer;
                             Fc_CODUFE: integer;
                             Fc_PRINCIPAL: string;
                             fc_whatsup:Boolean):Integer;

  procedure Pc_InativaEndereco(Pc_Codigo: Integer);

implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, ControllerBase,  Un_Regra_Negocio;

function Fc_GravaEndereco(Fc_CODIGO: integer;
                           Fc_CODEMP: integer;
                           Fc_CNPJ: string;
                           Fc_TIPO: string;
                           Fc_ENDER: string;
                           Fc_COMPLEM: string;
                           Fc_BAIRRO: string;
                           Fc_CEP: string;
                           Fc_CONTATO: string;
                           Fc_FONE: string;
                           Fc_FAX: string;
                           Fc_CELULAR: string;
                           Fc_COMERCIAL: String;
                           Fc_PORTARIA: String;
                           Fc_REGIAO: string;
                           Fc_NUMERO: string;
                           Fc_PAIS: string;
                           Fc_CODCDD: integer;
                           Fc_CODUFE: integer;
                           Fc_PRINCIPAL: string;
                           fc_whatsup:Boolean):Integer;
var
   Endereco : TControllerEndereco;
begin
  Endereco := TControllerEndereco.create(Application);
  with Endereco do
  Begin
    Registro.CodigoEmpresa := Fc_CODEMP;
    Registro.Codigo := getPrincipal;
    if ( Registro.Codigo > 0 ) AND (Registro.Codigo <> Fc_CODIGO)  AND (Fc_PRINCIPAL ='S') then
    Begin
      Fc_PRINCIPAL := 'N';
    end
    else
    Begin
      if (Registro.Codigo = 0) then
      Begin
        Fc_PRINCIPAL := 'S';
      end;
    end;
    //Gera o Sql

    with Endereco.Registro do
    Begin
      //Procura endereço
      Codigo := Fc_CODIGO;
      CodigoEmpresa := Fc_CODEMP;
      Cnpj := Fc_CNPJ;
      Tipo := Fc_TIPO;
      Logradouro := Fc_ENDER;
      NumeroPredial := Fc_NUMERO;
      Complemento := Copy(Fc_COMPLEM,1,25);
      EnderecoPrincipal := Fc_PRINCIPAL;
      cep := Fc_CEP;
      Bairro := Fc_BAIRRO;
      Contato := Fc_CONTATO;
      Regiao := Fc_REGIAO;
      Fone := RemoveCaracterInformado(Fc_FONE, ['(',')','-','-',' ']);
      Celular := RemoveCaracterInformado(Fc_CELULAR,  ['(',')','-','-',' ']);
      Fax := RemoveCaracterInformado(Fc_FAX,  ['(',')','-','-',' ']);
      FoneComercial := RemoveCaracterInformado(Fc_COMERCIAL,  ['(',')','-','-',' ']);
      FonePortaria := RemoveCaracterInformado(Fc_PORTARIA, ['(',')','-','-',' ']);
      CodigoPais := StrToInt( Fc_PAIS );
      CodigoCidade := Fc_CODCDD;
      CodigoEstado := Fc_CODUFE;
      if fc_whatsup then
        PossuiWhatsapp := 'S'
      else
        PossuiWhatsapp := 'N';
      Endereco.salva;
      Result := Endereco.Registro.Codigo;
    End;
    FreeAndNil(Endereco);
  end;
end;

procedure Pc_InativaEndereco(Pc_Codigo: Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : sTRING;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'UPDATE TB_ENDERECO SET   ' +
                   'END_PRINCIPAL = ''I'' '+
                   'WHERE  END_CODIGO =:END_CODIGO  ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('END_CODIGO').AsInteger := Pc_Codigo;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


end.
