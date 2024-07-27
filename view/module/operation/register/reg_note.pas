unit reg_note;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegNote = class(TBaseRegistry)
    Panel1: TPanel;
    L_Name: TLabel;
    L_Descricao: TLabel;
    L_Diferido: TLabel;
    Label4: TLabel;
    L_TipoObs: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    DBCB_Diferido: TComboBox;
    Cb_Tipo_Obs: TComboBox;
    MM_Detalhe: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegNote: TRegNote;

implementation

{$R *.dfm}

end.
