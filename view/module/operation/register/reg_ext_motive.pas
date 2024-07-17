unit reg_ext_motive;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegExtMotive = class(TBaseRegistry)
    Label2: TLabel;
    E_Descricao: TEdit;
    Label1: TLabel;
    DBCb_Tipo: TComboBox;
    E_Norma: TEdit;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegExtMotive: TRegExtMotive;

implementation

{$R *.dfm}

end.
