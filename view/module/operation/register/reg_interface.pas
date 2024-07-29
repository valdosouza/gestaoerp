unit reg_interface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Mask;

type
  TRegInterface = class(TBaseRegistry)
    Pn_Fundo: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_FormName: TLabel;
    L_Menu: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    GroupBox1: TGroupBox;
    ChkBx_Permissao: TCheckListBox;
    DBRadioGroup1: TRadioGroup;
    E_FormName: TEdit;
    DBLCB_Menu: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegInterface: TRegInterface;

implementation

{$R *.dfm}

end.
