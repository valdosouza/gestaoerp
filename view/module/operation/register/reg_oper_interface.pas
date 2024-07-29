unit reg_oper_interface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegOperInterface = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    Sb_Path_Botao: TSpeedButton;
    L_Path_Imagem: TLabel;
    Sb_Carrega: TSpeedButton;
    Sb_Descarrega: TSpeedButton;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Path_Imagem: TEdit;
    GroupBox1: TGroupBox;
    Sb_Amostra: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegOperInterface: TRegOperInterface;

implementation

{$R *.dfm}

end.
