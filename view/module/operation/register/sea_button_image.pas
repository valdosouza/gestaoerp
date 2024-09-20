unit sea_button_image;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaButtonImage = class(TBaseSearch)
    E_BuscaCodigo: TEdit;
    L_buscaCodigo: TLabel;
    L_BuscaDescricao: TLabel;
    E_BuscaDescricao: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaButtonImage: TSeaButtonImage;

implementation

{$R *.dfm}

end.
