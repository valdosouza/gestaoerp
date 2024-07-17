unit sea_printers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaPrinters = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Label28: TLabel;
    E_BuscaImpressora: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaPrinters: TSeaPrinters;

implementation

{$R *.dfm}

end.
