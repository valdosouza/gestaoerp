unit sea_cfop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask;

type
  TSeaCfop = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCFOP: TLabel;
    E_BuscaDescricao: TMaskEdit;
    E_BuscaCFOP: TMaskEdit;
    Rg_Busca_Sentido: TRadioGroup;
    Rg_busca_Alcada: TRadioGroup;
    Rg_Busca_ativo: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaCfop: TSeaCfop;

implementation

{$R *.dfm}

end.
