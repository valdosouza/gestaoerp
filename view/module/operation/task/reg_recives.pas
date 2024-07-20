unit reg_recives;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegRecives = class(TBaseRegistry)
    Panel1: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label28: TLabel;
    Label2: TLabel;
    E_Numero: TEdit;
    E_Vl_Recibo: TEdit;
    E_Emitente: TEdit;
    E_Sacado: TEdit;
    E_Referencia: TMemo;
    Tpk_Data: TDateTimePicker;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegRecives: TRegRecives;

implementation

{$R *.dfm}

end.
