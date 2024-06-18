unit ControllerCardapio;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblCardapio, ControllerGrupos,
      Un_MSg, ControllerMedida,ControllerPreco,ControllerEstoque;


Type
  TControllerCardapio = Class(TControllerBase)
  private
  public
    Registro : TCardapio;
    Grupos : TControllerGrupos;
    Medida : TControllerMedida;
    Preco : TControllerPreco;
    Estoque : TControllerEstoque;
    Old_Descricao : String;
    PrecoNormal : Real;
    PrecoPromocao : REal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function salva:boolean;
    function Insere:boolean;
    function Atualiza:boolean;
    Function delete:boolean;
    //Parte do Sabor
    function SalvaSaborPropagaTamanho:boolean;
    function SalvaSaborByD:Boolean;
    function InsereSaborMultploTamanho:boolean;
    function AlteraSaborMultploTamanho:boolean;
    //Parte do Tamanho
    Function getOneToCopyByGrupo:TCardapio;
    Function SalvaTamanhoPropagaSabor:Boolean;
    //Preco
    function SalvaTabelaPreco:boolean;
    function SalvaTabelaEstoque:boolean;
    procedure getbyId;
    procedure getbyDG;
    procedure getByDMG;
    function getIdByDMG(Descricao : String):Integer;
    procedure AtualizaPrecoTamanhoMultiplo;
    procedure AtualizaPrecoTamanhoMultiploSimples;
    Function Movimentacao:Boolean;
    Function deleteEstoqueSabor:Boolean;
    Function deletePrecoSabor:Boolean;
    Function deleteSabor:Boolean;
    Function hasBotao():Integer;

    Procedure AtualizaBotaoSabor(Botao,Sequencia : Integer);
    procedure InsereAutoBotaoNoSubgrupo(Produto:String;SubGrupo:Integer);
    procedure InsereBotao(Produto:Integer;
                          Botao:Integer;
                          Sequencia:Integer);
    procedure DeleteBotaodoProduto(ProdutoID:Integer);
    procedure DeleteBotao(Botao:Integer);
  End;

implementation

uses RN_Estoque, RN_Produto;

constructor TControllerCardapio.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TCardapio.Create;
  Grupos    := TControllerGrupos.Create(Self);
  Medida    := TControllerMedida.Create(Self);
  Preco     := TControllerPreco.Create(Self);
  Estoque   := TControllerEstoque.Create(Self);
end;


destructor TControllerCardapio.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerCardapio.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_PRODUTO');
  Registro.CodigoFabrica := IntToStr(Registro.Codigo);
  SaveObj(Registro);
end;

function TControllerCardapio.Insere:boolean;
begin
  Try
    Result := True;
    Registro.Codigo := Generator('GN_PRODUTO');
    Registro.CodigoFabrica := IntToStr(Registro.Codigo);
    InsertObj(Registro);
  Except
    Result := False
  End;
end;


function TControllerCardapio.Atualiza:boolean;
begin
  Try
    Result := True;
    UpdateObj(Registro);
  Except
    Result := False
  End;
end;

procedure TControllerCardapio.AtualizaPrecoTamanhoMultiplo;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Add('UPDATE TB_PRECO SET '+
              'PRC_VL_VDA =:PRC_VL_VDA '+
              'WHERE PRC_CODIGO IN ( '+
              'SELECT PRC_CODIGO '+
              'FROM TB_PRECO '+
              '  INNER JOIN TB_PRODUTO '+
              '  ON (PRO_CODIGO = PRC_CODPRO) '+
              '  INNER JOIN TB_MEDIDA '+
              '  ON (PRO_CODMED = MED_CODIGO) '+
              'WHERE (PRO_CODMED =:MED_CODIGO) '+
              '  AND (PRO_CODSBG =:SBG_CODIGO) '+
              '  AND (PRC_CODTPR =:TPR_CODIGO)) ');
      //Tabela 1 - normal
      ParamByName('PRC_VL_VDA').AsFloat := PrecoNormal;
      ParamByName('MED_CODIGO').AsInteger := Registro.MedidaComercial;
      ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubgrupo;
      ParamByName('TPR_CODIGO').AsInteger := 1;
      ExecSQL;
      //Tabela 1 - Promoção
      Active := False;
      ParamByName('PRC_VL_VDA').AsFloat := PrecoPromocao;
      ParamByName('MED_CODIGO').AsInteger := Registro.MedidaComercial;
      ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubgrupo;
      ParamByName('TPR_CODIGO').AsInteger := 2;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCardapio.AtualizaPrecoTamanhoMultiploSimples;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Add('UPDATE TB_PRECO SET '+
              'PRC_VL_VDA =:PRC_VL_VDA '+
              'WHERE PRC_CODIGO IN ( '+
              'SELECT PRC_CODIGO '+
              'FROM TB_PRECO '+
              '  INNER JOIN TB_PRODUTO '+
              '  ON (PRO_CODIGO = PRC_CODPRO) '+
              '  INNER JOIN TB_MEDIDA '+
              '  ON (PRO_CODMED = MED_CODIGO) '+
              'WHERE (PRO_DESCRICAO =:PRO_DESCRICAO) '+
              '  AND(PRO_CODMED =:MED_CODIGO) '+
              '  AND (PRO_CODSBG =:SBG_CODIGO) '+
              '  AND (PRC_CODTPR =:TPR_CODIGO)) ');
      //Tabela 1 - normal
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('PRC_VL_VDA').AsFloat := PrecoNormal;
      ParamByName('MED_CODIGO').AsInteger := Registro.MedidaComercial;
      ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubgrupo;
      ParamByName('TPR_CODIGO').AsInteger := 1;
      ExecSQL;
      //Tabela 1 - Promoção
      Active := False;
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('PRC_VL_VDA').AsFloat := PrecoPromocao;
      ParamByName('MED_CODIGO').AsInteger := Registro.MedidaComercial;
      ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubgrupo;
      ParamByName('TPR_CODIGO').AsInteger := 2;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCardapio.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerCardapio.deleteEstoqueSabor: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('DELETE  '+
              'FROM tb_ESTOQUE '+
              'WHERE EST_CODPRO IN ( '+
              'SELECT PRO_CODIGO '+
              'FROM TB_PRODUTO '+
              'WHERE ( PRO_DESCRICAO = :PRO_DESCRICAO ) '+
              'AND PRO_CODGRP=:GRP_CODIGO '+
              'AND PRO_CODSBG=:SBG_CODIGO )');
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('GRP_CODIGO').AsInteger := Registro.CodigoGrupo;
      ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubgrupo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

End;

function TControllerCardapio.deletePrecoSabor: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('DELETE  '+
              'FROM tb_PRECO '+
              'WHERE PRC_CODPRO IN ( '+
              'SELECT PRO_CODIGO '+
              'FROM TB_PRODUTO '+
              'WHERE ( PRO_DESCRICAO = :PRO_DESCRICAO ) '+
              'AND PRO_CODGRP=:GRP_CODIGO '+
              'AND PRO_CODSBG=:SBG_CODIGO )');
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('GRP_CODIGO').AsInteger := Registro.CodigoGrupo;
      ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubgrupo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;

function TControllerCardapio.deleteSabor: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('DELETE  '+
              'FROM tb_PRODUTO '+
              'WHERE PRO_CODIGO IN ( '+
              'SELECT PRO_CODIGO '+
              'FROM TB_PRODUTO '+
              'WHERE ( PRO_DESCRICAO = :PRO_DESCRICAO ) '+
              'AND PRO_CODGRP=:GRP_CODIGO '+
              'AND PRO_CODSBG=:SBG_CODIGO )');
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('GRP_CODIGO').AsInteger := Registro.CodigoGrupo;
      ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubgrupo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCardapio.SalvaSaborPropagaTamanho:boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('SELECT MED_CODIGO '+
              'FROM TB_MEDIDA '+
              'WHERE ( MED_ESPECIAL =:MED_ESPECIAL ) ');
      ParamByName('MED_ESPECIAL').AsString := Grupos.Registro.Descricao;
      Active := True;
      First;
      while not eof do
      Begin
        Registro.MedidaComercial := FieldByname('MED_CODIGO').AsInteger;
        if (Trim(Old_Descricao) = '' ) then
          Old_Descricao := Registro.Descricao;
        Registro.Codigo := getIdByDMG(Old_Descricao);
        if (Registro.Codigo > 0 ) then
          Atualiza
        else
          Insere;
        //Salva a Tabela de Preco
        SalvaTabelaPreco;
        //Salva a Tabela de estoque
        SalvaTabelaEstoque;
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;

function TControllerCardapio.SalvaSaborByD:boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('UPDATE TB_PRODUTO SET '+
              'PRO_CODIGONCM =:PRO_CODIGONCM, '+
              'PRO_CEST =:PRO_CEST, '+
              'PRO_DESCRICAO =:PRO_DESCRICAO, '+
              'PRO_TRIBUTACAO =:PRO_TRIBUTACAO,' +
              'PRO_SUB_TRIB =:PRO_SUB_TRIB, '+
              'PRO_ATIVO =:PRO_ATIVO '+
              'WHERE ( PRO_DESCRICAO =:OLD_PRO_DESCRICAO ) '+
              ' AND ( PRO_CODGRP =:GRP_CODIGO ) '+
              ' AND ( PRO_CODSBG =:SBG_CODIGO ) ');

      ParamByName('PRO_CODIGONCM').AsString := Registro.CodigoNCM;
      ParamByName('PRO_CEST').AsString := Registro.CEST;
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('PRO_TRIBUTACAO').AsString := Registro.FinalidadeTributacao;
      ParamByName('PRO_SUB_TRIB').AsString := Registro.SubsTrib;
      ParamByName('PRO_ATIVO').AsString := Registro.Ativo;
      ParamByName('OLD_PRO_DESCRICAO').AsString := Old_Descricao;
      ParamByName('GRP_CODIGO').AsInteger := Registro.CodigoGrupo;
      ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubgrupo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;



function TControllerCardapio.InsereSaborMultploTamanho:boolean;
Begin
  Registro.Codigo := getIdByDMG(Old_Descricao);
  if (Registro.Codigo > 0 ) then
    Atualiza
  else
    Insere;
  //Salva a Tabela de Preco
  SalvaTabelaPreco;
  //Salva a Tabela de estoque
  SalvaTabelaEstoque;
End;

procedure TControllerCardapio.InsereAutoBotaoNoSubgrupo(Produto: String; SubGrupo: Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_Botao : Integer;
  Lc_Sequencia : Integer;
Begin
  //Cria a consulta local para Inserir Sabores
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select pro_codigo, BT.ibt_codbtn, bt.ibt_sequencia ',
                'from tb_produto ',
                '  left outer join tb_itens_btn bt ',
                '  on (pro_codigo = bt.ibt_codpro) ',
                'where PRO_DESCRICAO =:PRO_DESCRICAO ',
                'and (PRO_CODSBG=:SBG_CODIGO) ',
                'ORDER by ibt_codbtn DESC '
      ));
      ParamByName('PRO_DESCRICAO').AsString := Produto;
      ParamByName('SBG_CODIGO').AsInteger := SubGrupo;
      Active := True;
      First;
      Lc_Botao := 0;
      while not eof do
      Begin
        if bof then
        BEgin
          Lc_Botao      := FieldByname('ibt_codbtn').asinteger;
          Lc_Sequencia  := FieldByname('ibt_sequencia').asinteger;
        End
        else
        BEgin
          if Lc_Botao > 0 then
          Begin
            if StrToIntDef(FieldByname('ibt_codbtn').AsString,0)=0 then
            begin
              InsereBotao(FieldByname('pro_codigo').AsInteger,
                          Lc_Botao,
                          Lc_Sequencia);
            End;
          End
          else
          Begin
            break;
          End;
        End;
        Next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCardapio.AlteraSaborMultploTamanho:boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT PRO_CODIGO, PRO_CODMED '+
              'FROM TB_PRODUTO '+
              'WHERE PRO_DESCRICAO =:PRO_DESCRICAO '+
              ' AND (PRO_CODGRP=:GRP_CODIGO) '+
              ' AND (PRO_TIPO = ''A'') ');

      ParamByName('PRO_DESCRICAO').AsString := sELF.Old_Descricao;
      ParamByName('GRP_CODIGO').AsInteger := Registro.CodigoGrupo;
      Active := True;
      First;
      while not eof do
      Begin
        Registro.Codigo := FieldByname('PRO_CODIGO').AsInteger;
        Registro.MedidaComercial := FieldByname('PRO_CODMED').AsInteger;
        Atualiza;
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;

Function TControllerCardapio.getOneToCopyByGrupo:TCardapio;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Result := TCardapio.Create;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('select first 1 p.* '+
              'from tb_produto p '+
              '  inner join tb_grupos g '+
              '  on (g.grp_codigo = p.pro_codgrp) '+
              'where g.grp_codigo = :GRP_CODIGO ');
      ParamByName('GRP_CODIGO').AsInteger := Grupos.Registro.Codigo;
      Active := True;
      if ( RecordCount > 0 ) then
      Begin
        get(Lc_Qry,Result);
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;


function TControllerCardapio.hasBotao: Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT DISTINCT tb_itens_btn.ibt_codbtn '+
              'FROM TB_PRODUTO tb_produto '+
              '   INNER JOIN TB_ITENS_BTN tb_itens_btn '+
              '   ON (tb_itens_btn.IBT_CODPRO = tb_produto.PRO_CODIGO) '+
              'WHERE PRO_DESCRICAO =:PRO_DESCRICAO '+
              ' AND (PRO_ATIVO = ''S'')' );
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByname('ibt_codbtn').AsInteger
      else
        Result := 0;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

Function TControllerCardapio.SalvaTamanhoPropagaSabor:boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('select DISTINCT p.pro_descricao, PRO_CODSBG '+
              'from TB_PRODUTO P '+
              'WHERE (PRO_CODGRP =:GRP_CODIGO) ');
      ParamByName('GRP_CODIGO').AsInteger := Registro.CodigoGrupo;
      Active := True;
      FetchAll;
      if ( RecordCount > 0 ) then
      Begin
        //Pega um registro do grupo para efetuar as copias
        Registro := getOneToCopyByGrupo;
        First;
        while not eof do
        Begin
          Registro.Codigo := 0;
          Registro.Descricao := FieldByName('PRO_DESCRICAO').AsString;
          Self.Old_Descricao := Registro.Descricao;
          Registro.CodigoSubgrupo := FieldByName('PRO_CODSBG').AsInteger;
          Registro.MedidaComercial := Medida.Registro.Codigo;
          getByDMG;
          if not exist then
          Begin
            Registro.Ativo := 'S';
            Insere;
            //Salva a Tabela de Preco
            SalvaTabelaPreco;
            //Salva a Tabela de estoque
            SalvaTabelaEstoque;
          End;
          next;
        End;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;

function TControllerCardapio.SalvaTabelaPreco:boolean;
Begin
  //codigo do Produto
  Preco.Registro.CodigoProduto := Registro.Codigo;
  //Tabela de Preço 1
  Preco.Registro.CodigoTabela := 1;
  Preco.Registro.Valor := self.PrecoNormal;
  Preco.Registro.Codigo := Preco.getIdByTabelaProduto;
  if Preco.Registro.Codigo > 0 then
    Preco.update
  else
    Preco.Insert;
  //Tabela de Preço 2
  Preco.Registro.CodigoTabela := 2;
  Preco.Registro.Valor := self.PrecoPromocao;
  Preco.Registro.Codigo := Preco.getIdByTabelaProduto;
  if Preco.Registro.Codigo > 0 then
    Preco.update
  else
    Preco.Insert;
End;

function TControllerCardapio.SalvaTabelaEstoque:boolean;
Begin
  //codigo do Produto
  Estoque.Registro.CodigoProduto := Registro.Codigo;
  //Tabela 1
  Estoque.Registro.CodigoEstoque := Gb_Estoque;
  Estoque.Registro.QtdeDisp := 0;
  Estoque.Registro.Codigo := Estoque.getIdByEstoqueProduto;
  if Estoque.Registro.Codigo > 0 then
    Estoque.Update
  else
    Estoque.Insert;
End;

procedure TControllerCardapio.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerCardapio.getbyDG;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      sql.Add('SELECT * '+
              'FROM TB_PRODUTO '+
              'WHERE PRO_DESCRICAO =:PRO_DESCRICAO '+
              ' AND (PRO_TIPO = ''A'')' +
              'AND (PRO_CODGRP=:GRP_CODIGO)');
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('GRP_CODIGO').AsInteger   := Registro.CodigoGrupo;
      Active := True;
      First;
      if RecordCount > 0 then
      Begin
        exist := True;
        get(Lc_Qry,Registro);
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCardapio.getbyDMG;
var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_PRODUTO '+
              'WHERE ( ( PRO_DESCRICAO=:PRO_DESCRICAO ) or ( PRO_DESCRICAO=:OLD_PRO_DESCRICAO ) ) '+
              ' AND PRO_CODMED =:MED_CODIGO '+
              ' AND (PRO_TIPO = ''A'') '+
              ' AND (PRO_CODGRP=:GRP_CODIGO) ');
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('OLD_PRO_DESCRICAO').AsString := Self.Old_Descricao;
      ParamByName('MED_CODIGO').AsInteger   := Registro.MedidaComercial;
      ParamByName('GRP_CODIGO').AsInteger   := Registro.CodigoGrupo;
      Active := True;
      FetchAll;
      First;
      if RecordCount > 0 then
      Begin
        exist := True;
        get(Lc_Qry,Registro);
      End;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

function TControllerCardapio.getIdByDMG(Descricao : String):Integer;
var
  Lc_Qry :TSTQuery;
begin
  try
    //DMG - Descricao - Medida - GRupo
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      SQL.Add('SELECT PRO_CODIGO '+
              'FROM TB_PRODUTO '+
              'WHERE PRO_DESCRICAO=:PRO_DESCRICAO '+
              ' AND PRO_CODMED =:MED_CODIGO '+
              ' AND (PRO_TIPO = ''A'') '+
              ' AND (PRO_CODGRP=:GRP_CODIGO) '+
              ' AND (PRO_CODSBG=:SBG_CODIGO) ');
      ParamByName('PRO_DESCRICAO').AsString := Descricao;
      ParamByName('MED_CODIGO').AsInteger   := Registro.MedidaComercial;
      ParamByName('GRP_CODIGO').AsInteger   := Registro.CodigoGrupo;
      ParamByName('SBG_CODIGO').AsInteger   := Registro.CodigoSubGrupo;
      Active := True;
      FetchAll;
      First;
      if RecordCount > 0 then
        Result := FieldByname('PRO_CODIGO').AsInteger
      else
        Result := 0;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

Procedure TControllerCardapio.AtualizaBotaoSabor(Botao,Sequencia : Integer);
Var
  Lc_Qry : TSTQuery;
Begin
  //Cria a consulta local para Inserir Sabores
  Try
    Lc_Qry := GeraQuery;
    with LC_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT PRO_CODIGO '+
              'FROM TB_PRODUTO tb_produto '+
              'WHERE (PRO_CODGRP =:GRP_CODIGO) '+
              ' AND (PRO_CODSBG =:SBG_CODIGO) '+
              ' AND (PRO_DESCRICAO =:PRO_DESCRICAO ) ');
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('GRP_CODIGO').AsInteger := Registro.CodigoGrupo;
      ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubGrupo;
      Active := True;
      FetchAll;
      First;
      DeleteBotao(Botao);
      while not eof do
      begin
        DeleteBotaodoProduto(FieldbyName('PRO_CODIGO').AsInteger);
        InsereBotao(FieldbyName('PRO_CODIGO').AsInteger,
                    Botao,
                    Sequencia);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCardapio.InsereBotao(Produto:Integer;
                                          Botao:Integer;
                                          Sequencia:Integer);
Var
  Lc_Qry : TSTQuery;
Begin
  //Cria a consulta local para Inserir Sabores
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
            'UPDATE OR INSERT INTO TB_ITENS_BTN (IBT_CODBTN, IBT_CODPRO, IBT_SEQUENCIA)',
            '                            VALUES (:IBT_CODBTN, :IBT_CODPRO, :IBT_SEQUENCIA)',
            '                          MATCHING (IBT_CODBTN, IBT_CODPRO)'

      ));
      ParamByName('IBT_CODBTN').AsInteger := Botao;
      ParamByName('IBT_CODPRO').AsInteger := Produto;
      ParamByName('IBT_SEQUENCIA').AsInteger := Sequencia;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCardapio.DeleteBotao(Botao:Integer);
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    //Cria a consulta local para Inserir Sabores
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      sql.Add('DELETE FROM TB_ITENS_BTN '+
              'WHERE (IBT_CODBTN =:BTN_CODIGO ) ');
      ParamByName('BTN_CODIGO').AsInteger := Botao;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCardapio.DeleteBotaodoProduto(ProdutoID: Integer);
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    //Cria a consulta local para Inserir Sabores
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      sql.Add('DELETE FROM TB_ITENS_BTN '+
              'WHERE (IBT_CODPRO =:PRO_CODIGO ) ');
      ParamByName('PRO_CODIGO').AsInteger := ProdutoID;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerCardapio.Movimentacao: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('SELECT COUNT(ITF_CODIGO) REG '+
              'FROM tb_itens_nfl '+
              'WHERE ITF_CODPRO IN ( '+
              'SELECT PRO_CODIGO '+
              'FROM TB_PRODUTO '+
              'WHERE ( PRO_CODIGO IS NOT NULL ) ');
      if (Registro.Codigo > 0) then
      Begin
        sql.Add(' AND ( PRO_CODIGO = :PRO_CODIGO ) ) ');
        ParamByName('PRO_CODIGO').AsInteger := Registro.Codigo;
      End
      else
      Begin
        //Incrementa o SQL
        if (Trim(Registro.Descricao) <> '') then
          sql.Add(' AND ( PRO_DESCRICAO = :PRO_DESCRICAO ) ');
        if (Registro.CodigoGrupo > 0) then
          sql.Add(' AND ( PRO_CODGRP=:GRP_CODIGO )');
        if (Registro.CodigoGrupo > 0) then
          sql.Add(' AND ( PRO_CODSBG=:SBG_CODIGO )');
        sql.add(')');
        //Passa Parametros
        if (Trim(Registro.Descricao) <> '') then
          ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
        if (Registro.CodigoGrupo > 0) then
          ParamByName('GRP_CODIGO').AsInteger := Registro.CodigoGrupo;
        if (Registro.CodigoGrupo > 0) then
          ParamByName('SBG_CODIGO').AsInteger := Registro.CodigoSubgrupo;
      End;
      Active := True;
      FetchAll;
      Result := (FieldbyName('REG').AsInteger > 0 )
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
