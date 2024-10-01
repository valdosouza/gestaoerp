unit reg_category;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.ComCtrls, ControllerCategory,
   Data.DB, un_dm;

type
  TRegCategory = class(TBaseRegistry)
    Lb_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    Trw_Cadastro: TTreeView;
    E_posicao: TEdit;
    Label1: TLabel;
    procedure Trw_CadastroClick(Sender: TObject);
  protected
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
    procedure EditionControl; Override;
  private
    category : TControllerCategory;
    It_Nivel : String;
    bInsert: boolean;

    procedure CarregarCategoria;
    function Fc_NivelHierarquico(const fc_s: String): integer;
    procedure Pc_PreencherTreeView(Pc_Query : TDataset; Pc_tv: TTreeView; Pc_Pai: TTreeNode);
    function Fc_PosicionaNoCategoria(Fc_Tipo: Byte; Fc_Tree: TTreeView;
      Fc_Value: Integer; Fc_Visible: Boolean): TTreeNode;
    procedure Pc_DefineNivel;
  end;
var
  RegCategory: TRegCategory;

implementation

uses UN_MSG, Env;

{$R *.dfm}

procedure TRegCategory.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCategory.ClearAllFields;
begin
  inherited;
  category.clear;
end;

procedure TRegCategory.CriarVariaveis;
begin
  inherited;
  category := TControllercategory.create(self);
end;

procedure TRegCategory.Delete;
begin
  category.delete;
  inherited;
end;

procedure TRegCategory.EditionControl;
begin
  inherited;
  Trw_Cadastro.Enabled := EditionState = 'B';
end;

procedure TRegCategory.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(category);
end;

procedure TRegCategory.IniciaVariaveis;
begin
  bInsert := False;
  CarregarCategoria;
  if Self.CodigoRegistro > 0 then
  Begin
    category.Registro.Codigo := Self.CodigoRegistro;
    category.getbyId;
  End;
  inherited;
end;

procedure TRegCategory.Insert;
Var
  Lc_Escolha : Integer;
begin
  inherited;

  bInsert := True;

  Lc_Escolha := MensagemPadrao(
    TITULO_CONFIRMACAO,
    'Infome o tipo de Operação.'+EOLN+EOLN,
    ['Nivel', 'SubNível', 'Cancelar'],
    [bNormal, bNormal, bEscape], mpConfirmacao, clBtnFace);

  if (Lc_Escolha <2) then      //mantendo codigo legado
  Begin
    if (Lc_Escolha =0) then
      It_Nivel := EmptyStr;

    E_Descricao.SetFocus;
  end;
end;

procedure TRegCategory.Save;
begin
  with category do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Institute := Gb_CodMha;
    Registro.Tipo := 'P';

    category.Registro.Codigo := ProximoCodigo;
    Pc_DefineNivel; //mantendo codigo legado
    registro.posicao := E_posicao.Text;

    salva;
  End;
  CodigoRegistro := category.Registro.Codigo;

  inherited;
  IniciaVariaveis;
end;

procedure TRegCategory.ShowData;
begin
  with category do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    E_posicao.Text := Registro.Posicao;
  End;
  inherited;
end;

procedure TRegCategory.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

procedure TRegCategory.Trw_CadastroClick(Sender: TObject);
begin
  if Trw_Cadastro.Selected.ImageIndex > 0 then
  begin
    category.Registro.Codigo := Trw_Cadastro.Selected.ImageIndex;
    category.getbyId;
    It_Nivel := category.Registro.Posicao;
    ShowData;
  End;
end;

function TRegCategory.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegCategory.ValidateSave: boolean;
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

procedure TRegCategory.CarregarCategoria;
Var
  i : Integer;
begin
  for i:= Trw_Cadastro.Items.Count - 1 downto 0 do
    Trw_Cadastro.Items.Item[i].Delete;

  DM.qr_category.Active := False;
  DM.qr_category.Active := True;

  Pc_PreencherTreeView(DM.qr_category, Trw_Cadastro, nil);

  Fc_PosicionaNoCategoria(1,Trw_Cadastro, Self.CodigoRegistro, TRUE);

  //Trw_Cadastro.Enabled := True;
end;

procedure TRegCategory.Pc_PreencherTreeView(Pc_Query : TDataset; Pc_tv : TTreeView; Pc_Pai : TTreeNode );
var
  Lc_NivelAtual, Lc_NovoNivel, Lc_I : Byte;
  Lc_Descricao : ShortString;
  Lc_NovoNo : TTreeNode;
begin

  Lc_NivelAtual := Fc_NivelHierarquico( Pc_Query.Fields[3].AsAnsiString ); //Pc_Query.Fields[3].AsAnsiString - category.lista[0].Posicao
  repeat
    Lc_Descricao := Pc_Query.Fields[2].AsAnsiString; //Pc_Query.Fields[2].AsAnsiString - category.lista[i].Descricao
    Lc_NovoNivel := Fc_NivelHierarquico( Pc_Query.Fields[3].AsAnsiString );  //Pc_Query.Fields[3].AsAnsiString - category.lista[i].Posicao
    if Lc_NovoNivel = Lc_NivelAtual then
    begin
      Lc_NovoNo := Pc_tv.Items.AddChild( Pc_Pai, lc_Descricao );
      Lc_NovoNo.ImageIndex := Pc_Query.Fields[0].AsInteger;   //Pc_Query.Fields[0].AsInteger - category.lista[i].Codigo;
      Lc_NovoNo.SelectedIndex := Lc_NivelAtual * 2;
    end
    else
    begin
      if ( Lc_NovoNivel < Lc_NivelAtual ) then
      begin
        for Lc_I := 1 to Lc_NivelAtual - Lc_NovoNivel do
          Pc_Pai := Pc_Pai.Parent
      end
      else
      begin
        Pc_Pai := Lc_NovoNo;
      end;
      Pc_PreencherTreeView( Pc_Query, Pc_tv, Pc_Pai );
    end;
    Pc_Query.Next;
    Application.ProcessMessages;
  until Pc_Query.EOF;
end;

function TRegCategory.Fc_NivelHierarquico( const fc_s : String ) : integer;
Var
  Lc_Teste : integer;
begin
  Lc_Teste :=Length( StringReplace( fc_s, '.', '', [rfReplaceAll]));
  Result := Length( fc_s )- Lc_Teste ;
end;

Function TRegCategory.Fc_PosicionaNoCategoria (Fc_Tipo: Byte;Fc_Tree : TTreeView; Fc_Value:Integer; Fc_Visible: Boolean): TTreeNode;
var
  Node: TTreeNode;
begin
  Result := nil;
  if Fc_Tree.Items.Count = 0 then
    Exit;

  Node := Fc_Tree.Items[0];
  while Node <> nil do
  begin
    if (Fc_Value = Node.ImageIndex)  then
    begin
      Result := Node;
      if Visible then
      begin
        Result.MakeVisible;
        Result.Selected := True;
      end;
      if Fc_Tipo > 0 then
        Break;
    end;
    Node := Node.GetNext;
  end;
end;

Procedure TRegCategory.Pc_DefineNivel;
Var
  Lc_Nivel : String;
Begin
  Lc_Nivel := Format('%.3d', [category.Registro.Codigo]);

  if bInsert then
  begin
    if Trim(It_Nivel) = EmptyStr then
      It_Nivel := Lc_Nivel
    else
      It_Nivel := It_Nivel + '.' + Lc_Nivel;
  end;
  E_posicao.Text := It_Nivel;
end;

end.
