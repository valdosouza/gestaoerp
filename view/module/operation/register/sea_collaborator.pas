unit sea_collaborator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls;

type
  TSeaCollaborator = class(TBaseSearch)
    GroupBox1: TGroupBox;
    Lb_CPF: TLabel;
    Lb_Nome: TLabel;
    Lb_Cargo: TLabel;
    E_BuscaCPF: TEdit;
    E_BuscaNome: TEdit;
    E_BuscaCargo: TEdit;
    Chbx_Demitidos: TCheckBox;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaCollaborator: TSeaCollaborator;

implementation

{$R *.dfm}

end.
