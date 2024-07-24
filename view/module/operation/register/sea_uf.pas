unit sea_uf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaUf = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Lb_BuscaDescricao: TLabel;
    Lb_BuscaCodigo: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaUf: TSeaUf;

implementation

{$R *.dfm}

end.
