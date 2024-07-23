unit sea_config_tag;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaConfigTag = class(TBaseSearch)
    GroupBox1: TGroupBox;
    Lb_Descricao: TLabel;
    Lb_Codigo: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaConfigTag: TSeaConfigTag;

implementation

{$R *.dfm}

end.
