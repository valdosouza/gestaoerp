unit reg_uf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, base_registry, Controlleruf, Datasnap.DBClient,
  Datasnap.Provider;

type
  TRegUf = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Sigla: TLabel;
    L_Sub_Tributario: TLabel;
    L_Aliq_Interna: TLabel;
    L_Aliq_Interstadual: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Sigla: TEdit;
    E_Sub_tributario: TEdit;
    E_Aliq_Interna: TEdit;
    E_Aliq_Interestadual: TEdit;
    Pg_Itens: TPageControl;
    tbs_st: TTabSheet;
    Pnl_ST: TPanel;
    tbs_FCP: TTabSheet;
    Pnl_FCP: TPanel;
    Dbg_MVA: TDBGrid;
    Dbg_Fcp: TDBGrid;
    Panel1: TPanel;
    Sb_Ins_Fcp: TSpeedButton;
    Sb_Grv_Fcp: TSpeedButton;
    Sb_Exc_Fcp: TSpeedButton;
    Panel2: TPanel;
    Sb_Ins_MVa: TSpeedButton;
    Sb_Grv_MVa: TSpeedButton;
    Sb_Exc_MVa: TSpeedButton;
    ds_MVA: TDataSource;
    cds_FCP: TClientDataSet;
    ds_FCP: TDataSource;
    cds_FCPTB_STATE_ID: TIntegerField;
    cds_FCPNCM: TWideStringField;
    cds_FCPALIQUOTA: TBCDField;
    Sb_Edit_Fcp: TSpeedButton;
    Sb_Can_Fcp: TSpeedButton;
    Sb_Edit_MVa: TSpeedButton;
    Sb_Can_MVa: TSpeedButton;
    cds_MVA: TClientDataSet;
    cds_MVAMUN_CODUFE: TIntegerField;
    cds_MVAMUN_CODIGONCM: TStringField;
    cds_MVAMUN_MR_VL_AGREGADO: TFloatField;
    cds_MVAMUN_ALIQ_INTERNA: TFloatField;
    cds_MVAMUN_CODMHA: TIntegerField;
    cds_MVAMUN_MVA_AJUSTADO: TFloatField;
    procedure Sb_Ins_MVaClick(Sender: TObject);
    procedure Sb_Grv_MVaClick(Sender: TObject);
    procedure Sb_Exc_MVaClick(Sender: TObject);
    procedure Sb_Ins_FcpClick(Sender: TObject);
    procedure Sb_Grv_FcpClick(Sender: TObject);
    procedure Sb_Edit_FcpClick(Sender: TObject);
    procedure Sb_Exc_FcpClick(Sender: TObject);
    procedure Sb_Edit_MVaClick(Sender: TObject);
    procedure Sb_Can_MVaClick(Sender: TObject);
    procedure Sb_Can_FcpClick(Sender: TObject);
  private
    EditionStateMVA : String;
    EditionStateFCP : String;
    //Aba MVA
    procedure FillMVAGrade;
    procedure InsertMVA;
    function existRegisterMVa:Boolean;
    function ValidaEditMVA:Boolean;
    procedure EditMVA;
    procedure SaveCds_MVA;
    procedure CancelCds_MVA;
    function ValidaDeleteMVA:Boolean;
    procedure DeleteMVA;
    //ABA FCP
    procedure FillFCPGrade;
    procedure InsertFCP;
    function existRegisterFCP:Boolean;
    function ValidaEditFCP:Boolean;
    procedure EditFCP;
    procedure SaveCds_FCP;
    procedure CancelCds_FCP;
    function ValidaDeleteFCP:Boolean;
    procedure DeleteFCP;
    //Finalização Gravando via controlller
    procedure SaveUF;
    procedure UpdateMVA;
    procedure UpdateFCP;
  protected
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure ImagemBotao;Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
    procedure EditionControl;Override;
    procedure Cancel;Override;
  public
    uf : TControllerUf;
  end;

var
  RegUf: TRegUf;

implementation

uses UN_MSG, Un_DM, env;

{$R *.dfm}

procedure TRegUf.Cancel;
begin
  EditionStateMVA := 'B';
  EditionStateFCP := 'B';
  inherited;
end;

procedure TRegUf.CancelCds_FCP;
begin
  EditionStateFCP := 'B';
  EditionControl;
  cds_FCP.Cancel;
end;

procedure TRegUf.CancelCds_MVA;
begin
  EditionStateMVA := 'B';
  EditionControl;
  cds_MVA.Cancel;

end;

procedure TRegUf.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegUf.CriarVariaveis;
begin
  inherited;
  uf := TControllerUf.create(self);
end;

procedure TRegUf.Delete;
begin
  uf.delete;
  inherited;
end;

procedure TRegUf.DeleteFCP;
begin
  cds_FCP.Delete;
  EditionStateFCP := 'B';
  EditionControl;
end;

procedure TRegUf.DeleteMVA;
begin
  cds_MVA.Delete;
  EditionStateMVA := 'B';
  EditionControl;
end;

procedure TRegUf.EditFCP;
begin
  EditionStateFCP := 'E';
  EditionControl;
  if not cds_FCP.Active then  cds_FCP.CreateDataSet;
  cds_FCP.Edit;
end;

procedure TRegUf.EditionControl;
begin
  inherited;
  //MVA
  Sb_Ins_MVa.Enabled  := ( EditionStateMVA = 'B' );
  Sb_Edit_MVa.Enabled := ( EditionStateMVA = 'B' ) and (cds_MVA.RecordCount > 0);
  Sb_Exc_MVa.Enabled  := ( EditionStateMVA = 'B' ) and (cds_MVA.RecordCount > 0);
  Sb_Grv_MVa.Enabled  := ( EditionStateMVA = 'I' ) or ( EditionStateMVA = 'E' );
  Sb_Can_MVa.Enabled  := ( EditionStateMVA = 'I' ) or ( EditionStateMVA = 'E' );
  //ds_MVA.AutoEdit     := ( EditionStateMVA = 'I' ) or ( EditionStateMVA = 'E' );

  //FCP
  Sb_Ins_Fcp.Enabled  := ( EditionStateFCP = 'B' );
  Sb_Edit_FCP.Enabled := ( EditionStateFCP = 'B' ) and (cds_FCP.RecordCount > 0);
  Sb_Exc_FCP.Enabled  := ( EditionStateFCP = 'B' ) and (cds_FCP.RecordCount > 0);
  Sb_Grv_Fcp.Enabled  := ( EditionStateFCP = 'I' ) or ( EditionStateFCP = 'E' );
  Sb_Can_Fcp.Enabled  := ( EditionStateFCP = 'I' ) or ( EditionStateFCP = 'E' );
  //ds_FCP.AutoEdit     := ( EditionStateFCP = 'I' ) or ( EditionStateFCP = 'E' );

end;

procedure TRegUf.EditMVA;
begin
  EditionStateMVA := 'E';
  if not cds_mva.Active then  cds_mva.CreateDataSet;
  EditionControl;
  cds_MVA.Edit;
end;

function TRegUf.existRegisterFCP: Boolean;
begin
  Result := True;
  if cds_FCP.RecordCount = 0 then
  begin
    TMsgSetes.PararExecucao('Registros não encontrado');
    Result := False;
    Exit;
  end;
end;

function TRegUf.existRegisterMVa: Boolean;
begin
  Result := True;
  if cds_MVA.RecordCount = 0 then
  begin
    TMsgSetes.PararExecucao('Registros não encontrado');
    Result := False;
    Exit;
  end;
end;

procedure TRegUf.FillFCPGrade;
Var
  I : Integer;
begin
  uf.FCP.Parametros.FieldName.CodigoUf := uf.Registro.Codigo;
  uf.FCP.Search;
  if not cds_FCP.Active then  cds_FCP.CreateDataSet;
  cds_FCP.EmptyDataSet;
  cds_FCP.DisableControls;
  for i := 0 to Pred(uf.FCP.Lista.Count) do
    cds_FCP.AppendRecord([uf.FCP.Lista[I].CodigoUF,
                          uf.FCP.Lista[I].NCM,
                          uf.FCP.Lista[I].Aliquota
                          ]);
  cds_FCP.EnableControls;
  cds_FCP.MergeChangeLog;
  EditionStateFCP := 'B';
end;

procedure TRegUf.FillMVAGrade;
Var
  I : Integer;
begin
  uf.MVA.Parametros.FieldName.CodigoUf := uf.Registro.Codigo;
  uf.MVA.Parametros.FieldName.Estabelecimento := Gb_CodMha;
  uf.MVA.Search;
  if not cds_mva.Active then  cds_mva.CreateDataSet;
  cds_MVA.EmptyDataSet;
  cds_MVA.DisableControls;
  for i := 0 to Pred(uf.MVA.Lista.Count) do
  BEgin
    cds_MVA.Append;
    cds_MVAMUN_CODUFE.AsInteger       := uf.MVA.Lista[I].CodigoUf;
    cds_MVAMUN_CODIGONCM.AsString     := uf.MVA.Lista[I].NCM;
    cds_MVAMUN_MR_VL_AGREGADO.AsFloat := uf.MVA.Lista[I].MVA;
    cds_MVAMUN_ALIQ_INTERNA.AsFloat   := uf.MVA.Lista[I].AliqInterna;
    cds_MVAMUN_CODMHA.AsInteger       := uf.MVA.Lista[I].Estabelecimento;
    cds_MVAMUN_MVA_AJUSTADO.AsFloat   := uf.MVA.Lista[I].MvaAjustado;
  End;
  cds_MVA.EnableControls;
  cds_MVA.MergeChangeLog;
  EditionStateMVA := 'B';
end;

procedure TRegUf.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(uf);
end;

procedure TRegUf.ImagemBotao;
begin
  inherited;
  //Inclusão de NCM
  CarregaImagemBotao(Sb_Ins_MVa,'INSERIR');
  CarregaImagemBotao(SB_Edit_MVa,'ALTERAR');
  CarregaImagemBotao(SB_Grv_MVa,'GRAVAR');
  CarregaImagemBotao(SB_Can_MVa,'CANCELAR');
  CarregaImagemBotao(SB_Exc_MVa,'EXCLUIR');
  //Inclusão de fcp
  CarregaImagemBotao(Sb_Ins_Fcp,'INSERIR');
  CarregaImagemBotao(SB_Edit_FCP,'ALTERAR');
  CarregaImagemBotao(SB_Grv_Fcp,'GRAVAR');
  CarregaImagemBotao(SB_Can_Fcp,'CANCELAR');
  CarregaImagemBotao(SB_Exc_Fcp,'EXCLUIR');

end;

procedure TRegUf.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    uf.Registro.Codigo := Self.CodigoRegistro;
    uf.getbyId;

    FillMVAGrade;
    FillFCPGrade;

  End;
  inherited;
end;

procedure TRegUf.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegUf.InsertFCP;
begin
  EditionStateFCP := 'I';
  EditionControl;
  if not cds_FCP.Active then  cds_FCP.CreateDataSet;
  Dbg_FCP.SetFocus;
  cds_FCP.Append;
  cds_FCPTB_STATE_ID.AsInteger := uf.Registro.Codigo;
  Dbg_MVA.SelectedIndex := 1;

end;

procedure TRegUf.InsertMVA;
begin
  EditionStateMVA := 'I';
  EditionControl;
  if not cds_MVA.Active then  cds_MVA.CreateDataSet;
  Dbg_MVA.SetFocus;
  cds_MVA.Append;
  cds_MVAMUN_CODUFE.AsInteger := UF.Registro.Codigo;
  cds_MVAMUN_CODMHA.AsInteger := Gb_CodMha;
  Dbg_MVA.SelectedIndex := 2;
end;

procedure TRegUf.Save;
begin
  SaveUF;
  UpdateMVA;
  UpdateFCP;
  CodigoRegistro := uf.Registro.Codigo;
  EditionStateMVA := 'B';
  EditionStateFCP := 'B';
  inherited;
end;

procedure TRegUf.SaveCds_FCP;
begin
  EditionStateFCP := 'B';
  EditionControl;
  cds_FCP.Post;
end;

procedure TRegUf.SaveCds_MVA;
begin
  EditionStateMVA := 'B';
  EditionControl;
  cds_MVA.Post;
  cds_MVA.EnableControls;
end;

procedure TRegUf.UpdateFCP;
Var
  cds_temp : TClientDataSet;
begin
  if cds_FCP.ChangeCount > 0 then
  Begin
    Try
      cds_temp := TClientDataSet.Create(nil);
      cds_temp.Data := cds_FCP.Delta;
      cds_temp.First;
      //Trata somente os dados deletados
      while not cds_temp.eof do
      Begin
        UF.FCP.Registro.CodigoUf  := cds_FCP.FieldByName('TB_STATE_ID').AsInteger;
        UF.FCP.Registro.NCM       := cds_FCP.FieldByName('NCM').AsString;
        UF.FCP.Registro.Aliquota  := cds_FCP.FieldByName('ALIQUOTA').AsInteger;
        case cds_temp.UpdateStatus of
          usModified: UF.FCP.update;
          usInserted: UF.FCP.insert;
          usDeleted:UF.FCP.delete;
        end;
        cds_temp.Next;
      end;
    Finally
      cds_temp.Close;
      FreeAndNil(cds_temp);
    End;
  End;
end;

procedure TRegUf.UpdateMVA;
Var
  cds_temp : TClientDataSet;
begin
  if cds_MVA.ChangeCount > 0 then
  Begin
    cds_temp := TClientDataSet.Create(nil);
    Try
      cds_temp.Data := cds_MVA.Delta;
      cds_temp.First;
      //Trata somente os dados Inseridos ou Alterados
      while not cds_temp.eof do
      Begin
        with UF.MVA.Registro do
        Begin
          CodigoUf        := cds_temp.FieldByName('MUN_CODUFE').AsInteger;
          NCM             := cds_temp.FieldByName('MUN_CODIGONCM').AsString;
          Estabelecimento := cds_temp.FieldByName('MUN_CODMHA').AsInteger;
          MVA             := cds_temp.FieldByName('MUN_MR_VL_AGREGADO').AsFloat;
          AliqInterna     := cds_temp.FieldByName('MUN_ALIQ_INTERNA').AsFloat;
          MvaAjustado     := cds_temp.FieldByName('MUN_MVA_AJUSTADO').AsFloat;
          case cds_temp.UpdateStatus of
            usModified: UF.MVA.update;
            usInserted: UF.MVA.insert;
            usDeleted:  UF.MVA.delete;
          end;
        End;
        cds_temp.next;
      End;
    Finally
      cds_temp.Close;
      FreeAndNil(cds_temp);
    End;
    cds_mva.MergeChangeLog;
  End;
end;

procedure TRegUf.saveUF;
begin
  with uf do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Sigla := E_Sigla.Text;
    registro.AliquotaInterna := StrToFloatDef(E_Aliq_Interna.Text , 0);
    registro.AliquotaInterEstadual := StrToFloatDef(E_Aliq_Interestadual.Text , 0);
    registro.IncricaoSubstituto := E_Sub_tributario.Text;

    salva;
  End;
end;

procedure TRegUf.Sb_Edit_MVaClick(Sender: TObject);
begin
  if ValidaEditMVA then
    EditMVA;
end;

procedure TRegUf.Sb_Can_FcpClick(Sender: TObject);
begin
  CancelCds_FCP;
end;

procedure TRegUf.Sb_Can_MVaClick(Sender: TObject);
begin
  CancelCds_MVA;
end;

procedure TRegUf.Sb_Edit_FcpClick(Sender: TObject);
begin
  if ValidaEditFCP then
    EditFCP;
end;

procedure TRegUf.Sb_Exc_FcpClick(Sender: TObject);
begin
  if ValidaDeleteFCP then
     DeleteFCP;
end;

procedure TRegUf.Sb_Exc_MVaClick(Sender: TObject);
begin
  if ValidaDeleteMVA then
    DeleteMVA
end;

procedure TRegUf.Sb_Grv_FcpClick(Sender: TObject);
begin
  SaveCds_FCP;
end;

procedure TRegUf.Sb_Grv_MVaClick(Sender: TObject);
begin
  SaveCds_MVA;
end;

procedure TRegUf.Sb_Ins_FcpClick(Sender: TObject);
begin
  InsertFCP;
end;

procedure TRegUf.Sb_Ins_MVaClick(Sender: TObject);
begin
  InsertMVA;
end;

procedure TRegUf.ShowData;
begin
  with uf do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    E_Sigla.Text  := Registro.Sigla;
    E_Aliq_Interna.Text := FloatToStrF(Registro.AliquotaInterna, ffFixed, 10, 2);
    E_Aliq_Interestadual.Text := FloatToStrF(Registro.AliquotaInterEstadual, ffFixed, 10, 2);
    E_Sub_tributario.Text := registro.IncricaoSubstituto;
  End;
  inherited;
end;

procedure TRegUf.ShowNoData;
begin
  //E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegUf.ValidaDeleteFCP: Boolean;
begin
  Result := True;
  if not existRegisterFCP then
  Begin
    Result := False;
    exit
  End;

  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;

end;

function TRegUf.ValidaDeleteMVA: Boolean;
begin
  Result := True;
  if not existRegisterMVA then
  Begin
    Result := False;
    exit
  End;

  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;

end;

function TRegUf.ValidaEditFCP: Boolean;
begin
  Result := True;
  if not existRegisterFCP then
  Begin
    Result := False;
    exit
  End;
end;

function TRegUf.ValidaEditMVA: Boolean;
begin
  Result := True;
  if not existRegisterMVA then
  Begin
    Result := False;
    exit
  End;
end;

function TRegUf.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegUf.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.
