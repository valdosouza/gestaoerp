unit reg_button_image;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegButtonImage = class(TBaseRegistry)
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
    E_codigo: TEdit;
    L_Path_Botao: TLabel;
    E_Path_Botao: TEdit;
    Sb_Load: TSpeedButton;
    Sb_Path_Botao: TSpeedButton;
    Sb_unload: TSpeedButton;
    E_Sequencia: TEdit;
    L_Sequencia: TLabel;
    UpDown1: TUpDown;
    E_Mrg_Botao: TEdit;
    L_Mrg_Botao: TLabel;
    L_Largura: TLabel;
    L_Altura: TLabel;
    E_Altura: TEdit;
    E_Largura: TEdit;
    GroupBox1: TGroupBox;
    Sb_Amostra: TSpeedButton;
    E_Label: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegButtonImage: TRegButtonImage;

implementation

{$R *.dfm}

end.
