unit reg_package;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegPackage = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    Lb_Abreviatura: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Abreviatura: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegPackage: TRegPackage;

implementation

{$R *.dfm}

end.
