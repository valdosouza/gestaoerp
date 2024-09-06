unit Un_Fm_ListaUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Data.DB, STQuery, UN_Usuario, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFm_ListaUsuarios = class(TFrame)
    Label19: TLabel;
    Sb_Medida: TSpeedButton;
    Dblcb_Lista: TDBLookupComboBox;
    Qr_Lista: TSTQuery;
    DS_Lista: TDataSource;
    procedure Sb_MedidaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Listar;
  end;

implementation

{$R *.dfm}

uses RN_Permissao, Un_Regra_Negocio, UN_Sistema, UN_Principal, env;

procedure TFm_ListaUsuarios.Pc_Listar;
begin
  with Qr_Lista do
  Begin
    Active := False;
    Active := true;
    FetchAll;
  end;
end;

procedure TFm_ListaUsuarios.Sb_MedidaClick(Sender: TObject);
Var
  Lc_Form : TFr_Usuario;
begin
  if Fc_VerificaPermissao('Fr_Usuario','Cadastro de Usuários','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_Form := TFr_Usuario.Create(Self);
    Lc_Form.ShowModal;
    Pc_Listar;
    FreeAndNil(Lc_Form);
  End;

end;

end.
