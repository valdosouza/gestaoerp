unit reg_virtual_shop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls;

type
  TRegVirtualShop = class(TBaseRegistry)
    Pnl_Edicao: TPanel;
    Label54: TLabel;
    Label55: TLabel;
    Label40: TLabel;
    Label37: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Cb_TipoWebservice: TComboBox;
    E_Path_WebService: TEdit;
    E_Dir_Images: TEdit;
    Chbx_Internet: TCheckBox;
    chbx_Vitrine: TCheckBox;
    chbx_Dealer: TCheckBox;
    E_Id_Google_analytics: TEdit;
    E_Titulo_Site: TEdit;
    gbProxy: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label19: TLabel;
    E_Proxy_Path: TEdit;
    E_Proxy_Porta: TEdit;
    E_Proxy_User: TEdit;
    E_Proxy_Pws: TEdit;
    E_Site: TEdit;
    e_mail: TEdit;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    ComboBox1: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegVirtualShop: TRegVirtualShop;

implementation

{$R *.dfm}

end.
