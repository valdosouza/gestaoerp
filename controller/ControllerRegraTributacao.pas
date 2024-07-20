unit ControllerRegraTributacao;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblRegraTRibutacao ,Un_MSg,Generics.Collections,
  Vcl.Dialogs;

Type
  TControllerRegraTributacao = Class(TControllerBase)

  private
    FMesmoEstado: Boolean;
    procedure setFMesmoEstado(const Value: Boolean);

  public
    Registro : TregraTRibutacao;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Insere:boolean;
    function DeleteAll:boolean;
    procedure getbyId;
    procedure getRegra;
    Function VerificaBeneficioICMS():Boolean;
    property MesmoEstado : Boolean read FMesmoEstado write setFMesmoEstado;
  End;


implementation

{ TControllerRegraTributacao }

constructor TControllerRegraTributacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TregraTRibutacao.create;
end;

function TControllerRegraTributacao.DeleteAll: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add('DELETE FROM TB_TRIBUTACAO');
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerRegraTributacao.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerRegraTributacao.getbyId;
begin
  _getByKey(Registro);
end;

procedure TControllerRegraTributacao.getRegra;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Sql.add('select TRB_CODIGO '+
              ',TRB_CODPRO '+
              ',TRB_ORIGEM '+
              ',tb_trib_icms_nr.tbi_grupo CST_ICMS '+
              ',tb_trib_icms_nr.tbi_codigo cst_CODIGO '+
              ',tb_mod_det_bc_icms.MDB_GRUPO MODAL_ICMS_NR '+
              ',tb_trib_icms_sn.tbi_grupo CSOSN_ICMS '+
              ',tb_trib_icms_sn.tbi_CODIGO CSOSN_CODIGO '+
              ',tb_mod_det_bc_icms_ST.MDB_GRUPO MODAL_ICMS_ST '+
              ',TRB_CODDSI_ICMS '+
              ',TRB_AQ_ICMS '+
              ',TRB_RD_AQ_ICMS '+
              ',TRB_RD_BS_ICMS '+
              ',tb_trib_ipi.tbi_grupo CST_IPI '+
              ',tb_trib_ipi.tbi_CODIGO CST_CODIGO_IPI '+
              ',TRB_AQ_IPI '+
              ',tb_trib_pis.tbp_grupo CST_PIS '+
              ',tb_trib_pis.tbp_CODIGO CST_CODIGO_PIS '+
              ',TRB_AQ_PIS '+
              ',tb_trib_cfs.tbc_grupo CST_COFINS '+
              ',tb_trib_cfs.tbc_CODIGO CST_CODIGO_CFS '+
              ',TRB_AQ_COFINS '+
              ',TRB_AQ_IRPJ '+
              ',TRB_AQ_CSLL '+
              ',TRB_AQ_SISCOMEX '+
              ',TRB_AQ_II '+
              ',TRB_ST_ICMS '+
              ',TRB_CONSUMIDOR '+
              ',TRB_MICRO '+
              ',TRB_DIFERIDO '+
              ',TRB_DESTAQUE '+
              ',TRB_CODOBS '+
              ',TRB_CODNAT '+
              ',TRB_ESTADO '+
              ',TRB_CODMHA '+
              ',TRB_SUB_TRI '+
              ',NAT_CODIGO '+
              ',NAT_DESCRICAO '+
              ',TRB_AQ_ISS '+
              ',NAT_CFOP '+
              ',NAT_RESUMIDO '+
              ',TRB_CODIGONCM '+
              ',TRB_RD_BS_ICMS_ST '+
              ',TRB_PRODUTO '+
              ',TRB_SENTIDO '+
              'from "TB_TRIBUTACAO" '+
              '    INNER JOIN TB_NATUREZA nat '+
              '    ON (nat.NAT_CODIGO = TRB_CODNAT) '+
              '    LEFT outer JOIN tb_trib_icms_nr '+
              '    ON (tb_trib_icms_nr.tbi_codigo = tb_tributacao.trb_codtbi_icms_nr) '+
              '    LEFT outer JOIN tb_trib_icms_sn '+
              '    ON (tb_trib_icms_sn.tbi_codigo = tb_tributacao.trb_codtbi_icms_sn) '+
              '    LEFT outer JOIN tb_trib_ipi '+
              '    ON (tb_trib_ipi.tbi_codigo = tb_tributacao.trb_codtbi_ipi) '+
              '    LEFT outer JOIN tb_trib_pis '+
              '    ON (tb_trib_pis.tbp_codigo = tb_tributacao.trb_codtbi_pis) '+
              '    LEFT outer JOIN tb_trib_cfs '+
              '    ON (tb_trib_cfs.tbc_codigo = tb_tributacao.trb_codtbi_cfs) '+
              '    LEFT outer JOIN tb_mod_det_bc_icms '+
              '    ON (tb_mod_det_bc_icms.mdb_codigo = tb_tributacao.TRB_CODMDB_ICMS_NR) '+
              '    LEFT outer JOIN tb_mod_det_bc_icms_st '+
              '    ON (tb_mod_det_bc_icms_st.mdb_codigo = tb_tributacao.trb_codmdb_icms_st) '+
              'WHERE ( ( TRB_CODPRO =:TRB_CODPRO ) OR ( TRB_CODPRO = 0 ) ) '+
              '   AND ( (TRB_CODIGONCM =:TRB_CODIGONCM) OR (TRB_CODIGONCM IS NULL) OR (TRB_CODIGONCM = '''') ) '+
              '   AND      ( TRB_ORIGEM =:TRB_ORIGEM ) '+
              '   AND      ( TRB_ST_ICMS = :TRB_ST_ICMS ) '+
              '   AND      ( TRB_CONSUMIDOR =:TRB_CONSUMIDOR ) '+
              '   AND      ( TRB_MICRO =:TRB_MICRO ) '+
              '   AND      ( TRB_CODMHA=:TRB_CODMHA ) '+
              '   AND      ( NAT_SENTIDO =:NAT_SENTIDO ) '+
              '   AND      ( TRB_PRODUTO =:TRB_PRODUTO) ');

      if ( Registro.CFOP > 0 ) then
        Sql.add(' AND  ( NAT_CODIGO =:NAT_CODIGO )' );


      if FMesmoEstado then
        Sql.add(' AND (TRB_ESTADO =:TRB_ESTADO) ')
      else
        Sql.add(' AND ( (TRB_ESTADO =:TRB_ESTADO) or (TRB_ESTADO = 0) OR (TRB_ESTADO IS NULL) ) ');
      Sql.add(' Order By TRB_CODIGONCM DESC ');

      ParamByName('TRB_CODMHA').AsInteger     := Registro.Estabelecimento;
      ParamByName('TRB_CODPRO').AsInteger     := Registro.Produto;
      ParamByName('TRB_CODIGONCM').AsString   := Registro.NCM;
      ParamByName('TRB_ORIGEM').AsString      := Registro.Origem;
      ParamByName('NAT_SENTIDO').AsString     := Registro.Sentido;
      if (Registro.CFOP > 0) then
      Begin
        //Por ser Ajuste de Estoque informar o CFOP e finalidade de tributação  =0
        ParamByName('NAT_CODIGO').AsInteger   := Registro.CFOP;
        ParamByName('TRB_PRODUTO').AsString   := '0';
      end
      else
      Begin
        ParamByName('TRB_PRODUTO').AsInteger   := Registro.Finalidade;
      end;
      ParamByName('TRB_ST_ICMS').AsString     := Registro.ProdutoComST;
      ParamByName('TRB_ESTADO').AsInteger     := Registro.Estado;
      ParamByName('TRB_CONSUMIDOR').AsString  := Registro.Consumidor;
      ParamByName('TRB_MICRO').AsString       := Registro.OptantePeloSimples;

      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerRegraTributacao.Insere: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_TRIBUTACAO');
  Try
    Try
      InsertObj(Registro);
    except
      on E : Exception do
       ShowMessage(E.ClassName+' Erro ' + E.Message);


    End;
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerRegraTributacao.setFMesmoEstado(const Value: Boolean);
begin
  FMesmoEstado := Value;
end;

function TControllerRegraTributacao.VerificaBeneficioICMS: Boolean;
begin
  Result := False;
  if self.exist then
  Begin
    if ( REgistro.REducaoBaseICMS > 0 ) or
       ( Registro.ReducaoAliqICMS > 0 ) then
    Begin
      Result := True;
    End;
  End;

end;

end.
