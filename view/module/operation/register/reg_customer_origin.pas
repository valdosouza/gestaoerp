unit reg_customer_origin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegCustomerOrigin = class(TBaseRegistry)
    L_Codigo: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    L_Descricao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegCustomerOrigin: TRegCustomerOrigin;

implementation

{$R *.dfm}

end.
