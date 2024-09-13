unit sea_coating;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaCoating = class(TBaseSearch)
    E_BuscaDescricao: TEdit;
    L_BuscaDescricao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaCoating: TSeaCoating;

implementation

{$R *.dfm}

end.
