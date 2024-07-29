unit reg_measure;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegMeasure = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Abreviatura: TLabel;
    L_Escala: TLabel;
    L_Proporcao: TLabel;
    L_MedidaGrupo: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Abreviatura: TEdit;
    E_Escala: TEdit;
    E_Porporcao: TEdit;
    E_MedidaGRupo: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegMeasure: TRegMeasure;

implementation

{$R *.dfm}

end.
