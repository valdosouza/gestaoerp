unit reg_printers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegPrinters = class(TBaseRegistry)
    SeaPrinters: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Caminho: TEdit;
    Chbx_Tipo: TCheckBox;
    E_Salto: TEdit;
    E_Vias: TEdit;
    E_Colunas: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegPrinters: TRegPrinters;

implementation

{$R *.dfm}

end.
