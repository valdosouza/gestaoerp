unit sea_recives;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Mask;

type
  TSeaRecives = class(TBaseSearch)
    GroupBox4: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    E_BuscaValor: TMaskEdit;
    E_BuscaNumero: TMaskEdit;
    chck_dataBusca: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    e_nomebusca: TEdit;
    chck_buscaEmitente: TCheckBox;
    chck_buscaSacado: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaRecives: TSeaRecives;

implementation

{$R *.dfm}

end.
