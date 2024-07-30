unit Un_Fm_ListaProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.Mask, RN_Produto, Un_Sistema, RN_Permissao, Un_Pesq_Produto ;

type
  TFm_ListaProdutos = class(TFrame)
    Label3: TLabel;
    Label8: TLabel;
    E_Cd_Produto: TMaskEdit;
    Sb_Produto: TSpeedButton;
    E_Busca_Produto: TEdit;
    procedure Sb_ProdutoClick(Sender: TObject);
    procedure E_Cd_ProdutoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

implementation

{$R *.dfm}

{ TFm_ListaProdutos }

procedure TFm_ListaProdutos.E_Cd_ProdutoExit(Sender: TObject);
begin
  If E_Cd_Produto.Text <> '' then
    E_Busca_Produto.Text := Fc_PegaProduto(E_Cd_Produto.Text,'');
end;


procedure TFm_ListaProdutos.Sb_ProdutoClick(Sender: TObject);
Var
  Lc_Form : TFr_Pesq_Produto;
begin
  Lc_Form := TFr_Pesq_Produto.Create(Self);
  Lc_Form.Pc_Tabelas_Disponiveis;
  Lc_Form.it_Modalidade_preco := 'A';
  Lc_Form.ShowModal;
  //Depois que Fecha o Relatorio
  if Lc_Form.It_Visualizar then
  Begin
    E_Cd_Produto.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_CODIGO').AsAnsiString;
    E_Busca_Produto.Text := Lc_Form.Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsAnsiString;
    E_Busca_Produto.SetFocus;
  end;
  FreeAndNil(Lc_Form) ;
end;

end.
