unit reg_coating;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TBaseRegistry1 = class(TBaseRegistry)
    E_Descricao: TEdit;
    L_Descricao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseRegistry1: TBaseRegistry1;

implementation

{$R *.dfm}

end.
