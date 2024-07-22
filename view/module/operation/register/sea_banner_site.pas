unit sea_banner_site;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaBannerSite = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    E_BuscaCodigo: TEdit;
    E_Busca_Produto: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaBannerSite: TSeaBannerSite;

implementation

{$R *.dfm}

end.
