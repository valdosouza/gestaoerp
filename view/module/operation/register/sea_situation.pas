unit sea_situation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaSituation = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCodigo: TLabel;
    L_BuscaModulos: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    Cb_BuscaModulos: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaSituation: TSeaSituation;

implementation

{$R *.dfm}

end.
