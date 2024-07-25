unit reg_kind_profit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegKindProfit = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegKindProfit: TRegKindProfit;

implementation

{$R *.dfm}

end.
