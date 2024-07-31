unit reg_situation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegSituation = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Situacao: TLabel;
    L_Color: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    cbx_situacao: TComboBox;
    Cb_Color: TColorBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegSituation: TRegSituation;

implementation

{$R *.dfm}

end.
