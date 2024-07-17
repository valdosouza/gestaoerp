unit sea_ext_motive;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaExtMotive = class(TBaseSearch)
    Label3: TLabel;
    CB_BuscaTipo: TComboBox;
    Label28: TLabel;
    E_BuscaDescricao: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaExtMotive: TSeaExtMotive;

implementation

{$R *.dfm}

end.
