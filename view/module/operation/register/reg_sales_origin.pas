unit reg_sales_origin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegSalesOrigin = class(TBaseRegistry)
    L_Codigo: TLabel;
    E_Codigo: TEdit;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegSalesOrigin: TRegSalesOrigin;

implementation

{$R *.dfm}

end.
