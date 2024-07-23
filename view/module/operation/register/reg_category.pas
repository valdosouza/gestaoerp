unit reg_category;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegCategory = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    Lb_CategoriaPai: TLabel;
    Lb_Atendimento: TLabel;
    Sb_Impressora: TSpeedButton;
    Lb_Impressora: TLabel;
    Lb_Interface: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    Dblcb_CategoriaPai: TComboBox;
    E_Abas: TEdit;
    Dblcb_Impressora: TComboBox;
    DBCB_Interface: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegCategory: TRegCategory;

implementation

{$R *.dfm}

end.
