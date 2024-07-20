unit ControllerCtrlIcmsST;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,FireDAC.Stan.Param,
      tblCtrlIcmsST ,  Generics.Collections;


Type
  TListCtrlIcmsST = TObjectList<TCtrlIcmsST>;
  TControllerCtrlIcmsST = Class(TControllerBase)
  private

  public
    Registro : TCtrlIcmsST;
    Lista : TListCtrlIcmsST;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    function atualiza:Boolean;
    function insere:boolean;
    Function GetListByProduto:boolean;
    Function GetList:boolean;
    Function delete:boolean;
    Function deleteByOrigem:boolean;
    Function GetByDestino:boolean;
    function ChecarQtdeDisp:Integer;
    function AjustaLegado:Boolean;
  End;

implementation

{ TControllerCtrlIcmsST }

function TControllerCtrlIcmsST.ChecarQtdeDisp: Integer;
Var
  Lc_Qry : TSTQuery;
  LCItem : TCtrlIcmsST;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
          'SELECT *                                                 ',
          'FROM TB_CTRL_ICMS_ST                                     ',
          'WHERE (TB_INSTITUTION_ID=:TB_INSTITUTION_ID )            ',
          'AND   TB_PRODUTO_ID=:TB_PRODUTO_ID                       ',
          'AND  ( (ITF_DESTINO_ID IS NULL) OR (ITF_DESTINO_ID =0) ) '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      ParamByName('TB_PRODUTO_ID').AsInteger := Registro.Produto;
      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      Result := RecordCount;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCtrlIcmsST.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerCtrlIcmsST.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCtrlIcmsST.Create;
  Lista :=TListCtrlIcmsST.Create;
end;

function TControllerCtrlIcmsST.delete: boolean;
begin
  deleteObj(Registro)
end;

function TControllerCtrlIcmsST.deleteByOrigem: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
          'DELETE                                        ',
          'FROM TB_CTRL_ICMS_ST                          ',
          'WHERE (TB_INSTITUTION_ID=:TB_INSTITUTION_ID ) ',
          'AND   (ITF_ORIGEM_ID=:ITF_ORIGEM_ID)        '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      ParamByName('ITF_ORIGEM_ID').AsInteger := Registro.Origem;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerCtrlIcmsST.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

function TControllerCtrlIcmsST.GetByDestino: boolean;
Var
  Lc_Qry : TSTQuery;
  LCItem : TCtrlIcmsST;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
          'SELECT *                                                 ',
          'FROM TB_CTRL_ICMS_ST                                     ',
          'WHERE (TB_INSTITUTION_ID=:TB_INSTITUTION_ID )            ',
          'AND   (ITF_DESTINO_ID=:ITF_DESTINO_ID)                   '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      ParamByName('ITF_DESTINO_ID').AsInteger := Registro.Destino;
      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      if exist then
      Begin
        LCItem := TCtrlIcmsST.Create;
        LCItem.Estabelecimento := 0;
        LCItem.Codigo := 0;
        LCItem.AliqST := FieldByName('PST').AsFloat;
        while not eof do
        Begin
          LCItem.ValorBaseSTRetido    := LCItem.ValorBaseSTRetido   + FieldByName('VBCSTRET').AsFloat;
          LCItem.ValorICMSSubstituto  := LCItem.ValorICMSSubstituto + FieldByName('VICMSSUBSTITUTO').AsFloat;
          LCItem.ValorICMSSTRetido    := LCItem.ValorICMSSTRetido   + FieldByName('VICMSSTRET').AsFloat;
          Next;
        End;
        Registro := LCItem;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerCtrlIcmsST.GetList: boolean;
Var
  Lc_Qry : TSTQuery;
  LCItem : TCtrlIcmsST;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
          'SELECT *                                                 ',
          'FROM TB_CTRL_ICMS_ST                                     ',
          'WHERE (TB_INSTITUTION_ID=:TB_INSTITUTION_ID )            '
      ));
     ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
     Active := True;
     First;
     lista.Clear;
     while not eof do
     Begin
        LCItem := TCtrlIcmsST.Create;
        get(Lc_Qry,LCItem);
        Lista.Add(LCItem);
      Next;
     End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerCtrlIcmsST.GetListByProduto: boolean;
Var
  Lc_Qry : TSTQuery;
  LCItem : TCtrlIcmsST;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
          'SELECT *                                                 ',
          'FROM TB_CTRL_ICMS_ST                                     ',
          'WHERE (TB_INSTITUTION_ID=:TB_INSTITUTION_ID )            ',
          'AND   TB_PRODUTO_ID=:TB_PRODUTO_ID                       ',
          'AND  ((ITF_DESTINO_ID IS NULL) OR (ITF_DESTINO_ID =0) OR (ITF_DESTINO_ID=:ITF_DESTINO_ID) ) '
      ));
     ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
     ParamByName('TB_PRODUTO_ID').AsInteger := Registro.Produto;
     ParamByName('ITF_DESTINO_ID').AsInteger := Registro.Destino;
     Active := True;
     First;
     lista.Clear;
     while not eof do
     Begin
        LCItem := TCtrlIcmsST.Create;
        get(Lc_Qry,LCItem);
        Lista.Add(LCItem);
      Next;
     End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCtrlIcmsST.insere: boolean;
begin
  Try
    REsult := True;
    if registro.codigo = 0 then
      registro.codigo := Generator('GN_CTRL_ICMS_ST');
    InsertObj(Registro);
  Except
    REsult := False
  End;
end;

function TControllerCtrlIcmsST.AjustaLegado: Boolean;
Var
  Lc_Qry : TSTQuery;
  LCItem : TCtrlIcmsST;
  I,F : Integer;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    Lc_Qry.sql.Clear;
    Lc_Qry.sql.Add(concat(
                  'select                                                                       ',
                  '0 ID,                                                                        ',
                  'nfl_codmha TB_INSTITUTION_ID,                                                ',
                  'i.itf_codigo ITF_ORIGEM_ID,                                                  ',
                  'i.itf_codpro TB_PRODUTO_ID,                                                  ',
                  'ic.icm_vl_bc_st VBCSTRET,                                                    ',
                  'ic.icm_aq_st PST,                                                            ',
                  'ic.icm_vl_nr VICMSSUBSTITUTO,                                                ',
                  'ic.icm_vl_st VICMSSTRET,                                                     ',
                  ' 0 ITF_DESTINO_ID,                                                           ',
                  'i.ITF_QTDE                                                                   ',
                  'from tb_itens_nfl i                                                          ',
                  '  inner join tb_pedido p                                                     ',
                  '  on (p.ped_codigo = i.itf_codped)                                           ',
                  '  inner join tb_nota_fiscal n                                                ',
                  '  on (n.nfl_codigo = i.itf_codnfl)                                           ',
                  '  inner join tb_itens_icms ic                                                ',
                  '  on (ic.icm_coditf = i.itf_codigo)                                          ',
                  '  LEFT OUTER JOIN tb_ctrl_icms_st st                                         ',
                  '  on (st.itf_origem_id = i.itf_codigo)                                       ',
                  'where ( (ped_tipo = 2) or ( (ped_tipo = 3) AND (N.nfl_tipo LIKE ''E%'') ) )  ',
                  'and icm_vl_bc_st > 0                                                         ',
                  'and st.itf_origem_id is null                                                 '
      ));
    Lc_Qry.Active := True;
    Lc_Qry.First;
    lista.Clear;
    while not Lc_Qry.eof do
    Begin
      F := Trunc(Lc_Qry.FieldByName('ITF_QTDE').AsFloat);
      for I := 1 to F do
      Begin
        LCItem := TCtrlIcmsST.Create;
        LCItem.Estabelecimento     := Lc_Qry.FieldByName('TB_INSTITUTION_ID').AsInteger;
        LCItem.codigo              := Generator('GN_CTRL_ICMS_ST');
        LCItem.Origem              := Lc_Qry.FieldByName('ITF_ORIGEM_ID').AsInteger;
        LCItem.Produto             := Lc_Qry.FieldByName('TB_PRODUTO_ID').AsInteger;
        LCItem.ValorBaseSTRetido   := Lc_Qry.FieldByName('VBCSTRET').AsFloat / F;
        LCItem.AliqST              := Lc_Qry.FieldByName('PST').AsFloat;
        LCItem.ValorICMSSubstituto := Lc_Qry.FieldByName('VICMSSUBSTITUTO').AsFloat / F;
        LCItem.ValorICMSSTRetido   := Lc_Qry.FieldByName('VICMSSTRET').AsFloat / F;
        LCItem.Destino             := 0;
        insertObj(LCItem);
      End;
      Lc_Qry.Next;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCtrlIcmsST.atualiza:Boolean;
begin
  Try
    REsult := True;
    updateObj(Registro);
  Except
    REsult := False
  End;
end;

end.
