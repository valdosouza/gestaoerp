unit base_registry;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.DBCtrls, main;

type
  TBaseRegistry = class(TFr_Base)
    pnl_botao: TPanel;
    pnl_fundo: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    SB_Gravar: TSpeedButton;
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_alterarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_gravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
  private

  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;
    //Teclas de atalhos
    procedure execShorCutKeyF2;Override;
    procedure execShorCutKeyF3;Override;
    procedure execShorCutKeyF4;Override;
    procedure execShorCutKeyF5;Override;
    procedure execShorCutKeyF6;Override;
    procedure execShorCutEsc;Override;

    procedure ShowData;Virtual;
    procedure ShowNoData;Virtual;
    procedure ClearAllFields;Virtual;
    //inserir
    function ValidaInsert():boolean;Virtual;
    procedure Insert;Virtual;
    //Editar
    function ValidateChange():boolean;Virtual;
    procedure Change;Virtual;
    //Deletar
    function ValidateDelete():boolean;Virtual;
    procedure Delete;Virtual;
    //Salvar
    function ValidateSave():boolean;Virtual;
    procedure Save;Virtual;
    //Cancelar
    function ValidateCancel():boolean;Virtual;
    procedure Cancel;Virtual;

    procedure EditionControler(T: TComponent);
    procedure EditionControl;Virtual;

  public
    EditionState : String;


  end;

var
  BaseRegistry: TBaseRegistry;

implementation

{$R *.dfm}

uses  RN_Permissao, UN_Sistema, un_msg, env;


procedure TBaseRegistry.Change;
begin
  EditionState := 'E';
  EditionControl;
end;

procedure TBaseRegistry.Cancel;
begin
  if (EditionState = 'I') then
  Begin
    ClearAllFields;
    Self.Close;
  End
  else
  Begin
    ShowData;
  End;
end;

procedure TBaseRegistry.EditionControler(T: TComponent);
Var
  I:Integer;
begin
  with T do
  Begin
    for I := 0 to ((ComponentCount)-1) do
    begin
      if (Components[I].ClassName = 'TEdit') then
      Begin
        if TEdit (Components[I]).Name = 'E_ID' then
          TEdit (Components[I]).ReadOnly := True
        else
          TEdit (Components[I]).ReadOnly := ( EditionState = 'B' );
      End;

      if (Components[I].ClassName = 'TDBLookupComboBox') then
        TDBLookupComboBox (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TMemo') then
        TMemo (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TTreeView') then
        TTreeView (Components[I]).Enabled := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TDBGrid') then
        TDBGrid (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TSpeedButton') then
        TSpeedButton (Components[I]).Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );

    end;
  End;
end;

procedure TBaseRegistry.execShorCutEsc;
begin
  inherited;
  if SB_Sair_0.Enabled then Sb_Sair_0Click(Self);
end;

procedure TBaseRegistry.execShorCutKeyF2;
begin
  if SB_Inserir.Enabled then SB_InserirClick(Self);
end;

procedure TBaseRegistry.execShorCutKeyF3;
begin
  if SB_Alterar.Enabled then SB_AlterarClick(Self);
end;

procedure TBaseRegistry.execShorCutKeyF4;
begin
  if SB_Excluir.Enabled then SB_excluirClick(Self);
end;

procedure TBaseRegistry.execShorCutKeyF5;
begin
  if SB_Gravar.Enabled then SB_GRavarClick(Self);
end;

procedure TBaseRegistry.execShorCutKeyF6;
begin
  if SB_Cancelar.Enabled then SB_CancelarClick(Self);
end;

procedure TBaseRegistry.EditionControl;
begin
  EditionControler(Self);
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Inserir.Enabled := ( EditionState = 'B' ) and Pf_Inserir ;
  SB_Alterar.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 ) and Pf_Alterar;
  SB_Excluir.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 ) and Pf_Excluir;
  SB_gravar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Cancelar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Sair_0.Enabled := ( EditionState = 'B' );
end;

procedure TBaseRegistry.Delete;
begin
  Close;
end;

procedure TBaseRegistry.FormataTela;
begin
  inherited;

end;


procedure TBaseRegistry.showData;
begin
  //A implementação será feita na descendencia
end;

procedure TBaseRegistry.showNoData;
begin
  ClearAllFields;
end;

procedure TBaseRegistry.Save;
begin
  EditionState := 'B';
  EditionControl;
end;

procedure TBaseRegistry.IniciaVariaveis;
begin
  if ( CodigoRegistro > 0 ) then
    ShowData
  else
    ShowNoData;
  EditionState := 'B';
  EditionControl;
end;

procedure TBaseRegistry.Insert;
begin
  ClearAllFields;
  EditionState := 'I';
  EditionControl;
end;

function TBaseRegistry.ValidateChange: boolean;
begin
  Result := True;
end;

function TBaseRegistry.ValidateCancel: boolean;
begin
  Result := True;
end;

function TBaseRegistry.ValidateDelete: boolean;
begin
  Result := True;
  if (TMsgSetes.Excluir = mrBotao2) then
  Begin
    Result := False;
    exit;
  End;
end;

function TBaseRegistry.ValidateSave: boolean;
begin
  Result := True;
end;

procedure TBaseRegistry.ClearAllFields;
Begin
  ClearFields(self);
End;

procedure TBaseRegistry.CriarVariaveis;
begin
  inherited;

end;

function TBaseRegistry.ValidaInsert: boolean;
begin
  Result := True;
end;

procedure TBaseRegistry.SB_alterarClick(Sender: TObject);
begin
  if ValidateChange then
  Begin
    EditionState := 'E';
    EditionControl;
    Change;
  End;
end;

procedure TBaseRegistry.SB_CancelarClick(Sender: TObject);
begin
  if ValidateCancel then
  Begin
    Cancel;
    EditionState := 'B';
    EditionControl;
  End;
end;

procedure TBaseRegistry.SB_ExcluirClick(Sender: TObject);
begin
  if ValidateDelete then
  Begin
    Delete;
    EditionState := 'B';
    EditionControl;
  End;
end;

procedure TBaseRegistry.SB_gravarClick(Sender: TObject);
begin
  if ValidateSave then
  Begin
    Save;
    EditionState := 'B';
    EditionControl;
  End;
end;

procedure TBaseRegistry.SB_InserirClick(Sender: TObject);
begin
  if ValidaInsert then
  Begin
    EditionState := 'I';
    EditionControl;
    Insert;
  End;
end;


procedure TBaseRegistry.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TBaseRegistry.ImagemBotao;
begin
  CarregaImagemBotao(SB_Inserir,'INSERIR');
  CarregaImagemBotao(SB_Alterar,'ALTERAR');
  CarregaImagemBotao(SB_Excluir,'EXCLUIR');
  CarregaImagemBotao(SB_Gravar,'GRAVAR');
  CarregaImagemBotao(SB_Cancelar,'CANCELAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TBaseRegistry.setPerfil;
begin
  inherited;
  if Gb_Nivel = 1 then
  begin
    Pf_Inserir:= True;
    Pf_Alterar:=True;
    Pf_Excluir:=True;
    Pf_Visualizar:=True;
  end
  else
  begin
    Pf_Inserir    := Fc_HabilitaPermissao(pfMenu,'INSERIR','S');
    Pf_Alterar    := Fc_HabilitaPermissao(pfMenu,'ALTERAR','S');
    Pf_Excluir    := Fc_HabilitaPermissao(pfMenu,'EXCLUIR','S');
  end;

end;

end.
