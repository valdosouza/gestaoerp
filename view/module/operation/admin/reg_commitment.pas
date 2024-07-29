unit reg_commitment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ComCtrls;

type
  TRegCommitment = class(TBaseRegistry)
    w: TMemo;
    E_Data: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    E_Hora: TDateTimePicker;
    Dblcb_Usuario: TComboBox;
    Label4: TLabel;
    Label1: TLabel;
    Chbx_Dia: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegCommitment: TRegCommitment;

implementation

{$R *.dfm}

end.
