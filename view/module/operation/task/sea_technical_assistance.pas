unit sea_technical_assistance;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TSeaTechnicalAssistance = class(TBaseSearch)
    E_BuscaNumero: TMaskEdit;
    L_BuscaNumero: TLabel;
    ChBx_Busca_Nome: TCheckBox;
    E_BuscaCliente: TMaskEdit;
    ChBx_Busca_Fantasia: TCheckBox;
    L_BuscaSituacao: TLabel;
    DBLCB_BuscaSituacao: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaTechnicalAssistance: TSeaTechnicalAssistance;

implementation

{$R *.dfm}

end.
