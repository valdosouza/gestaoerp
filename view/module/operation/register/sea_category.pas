unit sea_category;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaCategory = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Label28: TLabel;
    Label3: TLabel;
    SeaCategory: TEdit;
    E_BuscaCodigo: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaCategory: TSeaCategory;

implementation

{$R *.dfm}

end.
