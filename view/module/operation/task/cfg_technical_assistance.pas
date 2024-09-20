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
    Btn_Ok_Local: TButton;
    Btn_Cn_Local: TButton;
    Btn_Ap_Local: TButton;
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
