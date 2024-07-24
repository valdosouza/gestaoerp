unit reg_config_tag;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegConfigTag = class(TBaseRegistry)
    Panel1: TPanel;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    GroupBox2: TGroupBox;
    Lb_Superior: TLabel;
    Lb_Inferior: TLabel;
    Lb_Direita: TLabel;
    Lb_Esquerda: TLabel;
    E_Superior: TEdit;
    E_Inferior: TEdit;
    E_Direita: TEdit;
    E_Esquerda: TEdit;
    GroupBox3: TGroupBox;
    Lb_Alt_Etiq: TLabel;
    Lb_Lar_Etiq: TLabel;
    Lb_Type_e_Size_Fonte: TLabel;
    Lb_N_Coluna: TLabel;
    Lb_Dist_Coluna: TLabel;
    E_Alt_Etiq: TEdit;
    E_Lar_Etiq: TEdit;
    E_N_Coluna: TEdit;
    E_TypeFonte: TEdit;
    E_SizeFonte: TEdit;
    E_Dist_Coluna: TEdit;
    GroupBox4: TGroupBox;
    Lb_Pg_Altura: TLabel;
    L_Pg_Largura: TLabel;
    E_Pg_Altura: TEdit;
    E_Pg_Largura: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegConfigTag: TRegConfigTag;

implementation

{$R *.dfm}

end.
