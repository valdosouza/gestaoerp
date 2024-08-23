unit api_route_cep;

interface

uses windows,forms,Graphics,InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, Dialogs,
      STQuery,Un_DM,Classes,XMLDoc,XMLIntf,Wininet,shellapi,EncdDecd,synacode, acbrcep,
  System.SysUtils;

  type TCependereco = Record
      FCep : String;
      FCd_UF : Integer;
      FUF : String;
      FCd_Cidade : Integer;
      FCidade : String;
      FLogradouro : String;
      FBairro : String;
  end;

  function Fc_BuscaPorCep(Fc_Cep:String):TCependereco;

implementation

uses un_msg, RN_Estados, Un_Regra_Negocio, env;

function Fc_BuscaPorCep(Fc_Cep:String):TCependereco;
Var
  cep : TAcbrCep;
Begin
  cep := TAcbrCep.Create(Application);
  with cep DO
  Begin
    WebService := wsViaCep;
    TRY
      BuscarPorCEP( Fc_CEP);
    Except
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Veriique a conexão com internet.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      exit;
    END;
    if Enderecos.Count > 0 then
    Begin
      with Enderecos[0] do
      Begin
        Result.FCep := Fc_Cep;
        Result.FCd_UF  := Fc_BuscaCodigoEstado(UF);
        Result.FUF  := UF;
        Result.FCd_Cidade := Fc_BuscaCodigoCidade(0,Municipio,UF);
        Result.FCidade := Municipio;
        if (Trim(Tipo_Logradouro) <> '') then
          Result.FLogradouro := Trim(Tipo_Logradouro) + ' ' + Logradouro
        else
          Result.FLogradouro := Logradouro;
        Result.FBairro := Bairro;
      End;
    End
    else
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Cep Não Encontrado.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpInformacao);
    End;
  end;
  FreeAndNil(Cep);
end;

end.
