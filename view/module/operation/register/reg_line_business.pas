unit reg_line_business;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegLineBusiness = class(TBaseRegistry)
    E_Descricao: TEdit;
    E_Codigo: TEdit;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegLineBusiness: TRegLineBusiness;

implementation

{$R *.dfm}

end.
