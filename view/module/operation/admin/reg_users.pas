unit reg_users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegUsers = class(TBaseRegistry)
    Panel1: TPanel;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    sb_reseta: TSpeedButton;
    sb_permissao: TSpeedButton;
    Label1: TLabel;
    E_Nome: TEdit;
    E_Login: TEdit;
    E_Senha: TEdit;
    E_Codigo: TEdit;
    CB_Nivel: TComboBox;
    DBChBx_Ativo: TCheckBox;
    pnl_auth_card: TPanel;
    Label15: TLabel;
    E_Auth_card: TEdit;
    RegUsers: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label3: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButton1: TSpeedButton;
    E_Srv_Smtp: TEdit;
    E_lgn_email: TEdit;
    E_pwd_email: TEdit;
    E_Usr_Mail: TEdit;
    E_Lbl_Name: TEdit;
    E_porta_email: TEdit;
    Cbx_Req_Autenticacao: TCheckBox;
    Cbx_Req_Con_ssl: TCheckBox;
    DBMemo1: TMemo;
    chbx_notifica_login: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegUsers: TRegUsers;

implementation

{$R *.dfm}

end.
