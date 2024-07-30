unit Un_Fm_ListaUnidades;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.StdCtrls;

type
  TFm_ListaUnidades = class(TFrame)
    Label19: TLabel;
    DBLCB_Medida: TDBLookupComboBox;
    Sb_Medida: TSpeedButton;
    procedure Sb_MedidaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UN_Medida, UN_TabelasEmListas;

procedure TFm_ListaUnidades.Sb_MedidaClick(Sender: TObject);
Var
  Lc_Form : TFr_Medida;
begin
  Lc_Form := TFr_Medida.Create(Self);
  if (Trim(DBLCB_Medida.Text) <> '') then
    Lc_Form.It_Cd_Cadastro := DBLCB_Medida.KeyValue;
  Lc_Form.ShowModal;
  DM_ListaConsultas.Pc_ListaMedida('','');
  DBLCB_Medida.KeyValue := TFr_Medida(Lc_Form).It_Cd_Cadastro;
  FreeAndNil(Lc_Form);
end;

end.
