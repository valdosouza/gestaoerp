unit sea_banking_history;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaBankingHistory = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Label28: TLabel;
    Label3: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    DBGrid2: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaBankingHistory: TSeaBankingHistory;

implementation

{$R *.dfm}

end.
