unit reg_subgroup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegSubgroup = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Codigo_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegSubgroup: TRegSubgroup;

implementation

{$R *.dfm}

end.
