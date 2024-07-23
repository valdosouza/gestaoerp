unit reg_category;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegCategory = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Sb_Impressora: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
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
