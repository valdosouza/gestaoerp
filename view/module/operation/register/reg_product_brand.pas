unit reg_product_brand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TRegProductBrand = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Fornecedor: TLabel;
    Sb_Fornecedor: TSpeedButton;
    Sb_Pesq_Cliente: TSpeedButton;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    DBLCB_Fornecedor: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegProductBrand: TRegProductBrand;

implementation

{$R *.dfm}

end.
