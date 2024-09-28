unit cfg_technical_assistance;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TCfgTechnicalAssistance = class(TBaseRegistry)
    L_ModeloImpressao: TLabel;
    Cbx_ModeloImpressao: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CfgTechnicalAssistance: TCfgTechnicalAssistance;

implementation

{$R *.dfm}

end.
