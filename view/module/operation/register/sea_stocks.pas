unit sea_stocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaStocks = class(TBaseSearch)
    L_BuscaDescricao: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    L_BuscaCodigo: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaStocks: TSeaStocks;

implementation

{$R *.dfm}

end.
