unit fm_itens_importa_xml;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Un_Fm_ListaEstoques;

type
  TFmItensImportaXml = class(TFrame)
    E_Nr_ITem: TLabeledEdit;
    E_Descricao_Produto: TLabeledEdit;
    E_Unidade: TLabeledEdit;
    E_Quantidade: TLabeledEdit;
    E_ValorUnitario: TLabeledEdit;
    E_ValorTotal: TLabeledEdit;
    E_Valor_Desconto: TLabeledEdit;
    E_Cod_Item_Nota: TLabeledEdit;
    E_Cod_Item_Interno: TLabeledEdit;
    E_Cod_Barras: TLabeledEdit;
    E_Descricao_Vinculado: TLabeledEdit;
    Fm_ListaEstoques: TFm_ListaEstoques;
    e_NCM: TLabeledEdit;
    E_Origem: TLabeledEdit;
    E_ST: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
