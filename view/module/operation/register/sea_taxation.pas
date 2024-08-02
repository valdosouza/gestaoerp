unit sea_taxation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaTaxation = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_Busca_NCM: TLabel;
    CHBX_BUSCA_CONSUMIDOR: TCheckBox;
    E_Busca_NCM: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaTaxation: TSeaTaxation;

implementation

{$R *.dfm}

end.
