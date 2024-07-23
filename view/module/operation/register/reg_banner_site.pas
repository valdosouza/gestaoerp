unit reg_banner_site;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TRegBannerSite = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Sb_Carr_Imagem: TSpeedButton;
    Lb_Caminho: TLabel;
    Lb_link: TLabel;
    E_PathIMG: TEdit;
    Rg_ImageTarget: TRadioGroup;
    E_link: TEdit;
    img_amostra: TImage;
    Image1: TImage;
    Image2: TImage;
    Panel2: TPanel;
    Sb_First: TSpeedButton;
    Sb_Next: TSpeedButton;
    Sb_Prior: TSpeedButton;
    Sb_Last: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegBannerSite: TRegBannerSite;

implementation

{$R *.dfm}

end.
