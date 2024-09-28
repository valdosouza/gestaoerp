unit sea_customer_origin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaCustomerOrigin = class(TBaseSearch)
    L_BuscaCodigo: TLabel;
    E_BuscaCodigo: TEdit;
    L_BuscaDescricao: TLabel;
    E_BuscaDescricao: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaCustomerOrigin: TSeaCustomerOrigin;

implementation

{$R *.dfm}

end.
