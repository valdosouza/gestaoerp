unit reg_stocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegStocks = class(TBaseRegistry)
    ChBx_Estoque: TCheckBox;
    E_Codigo: TEdit;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
    Sb_Pesquisar: TSpeedButton;
    Sb_Iten_Estoque: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegStocks: TRegStocks;

implementation

{$R *.dfm}

end.
