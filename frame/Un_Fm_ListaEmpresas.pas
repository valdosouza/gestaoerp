unit Un_Fm_ListaEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFm_ListaEmpresas = class(TFrame)
    DBLCB_Empresa: TDBLookupComboBox;
    E_Cd_Empresa: TMaskEdit;
    SB_Empresas: TSpeedButton;
    Sb_Pesq_Empresa: TSpeedButton;
    Panel1: TPanel;
    Label2: TLabel;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure SB_EmpresasClick(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_EmpresaClick(Sender: TObject);
    procedure Sb_Pesq_EmpresaClick(Sender: TObject);
    procedure E_Cd_EmpresaExit(Sender: TObject);
    procedure E_Cd_EmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure DBLCB_EmpresaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TipoEmpresa : Integer;
    procedure Pc_AtivaEmpresa(Pc_Tipo:Integer);
  end;

implementation

{$R *.dfm}

uses RN_Empresa, UN_TabelasEmListas;

{ TFm_ListaEmpresas }

procedure TFm_ListaEmpresas.Pc_AtivaEmpresa(Pc_Tipo:Integer);
Begin
  TipoEmpresa := Pc_Tipo;
  case TipoEmpresa of
     0:DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaEstabelecimento;
     1:DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaCliente;
     2:DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaFornecedor;
     3:DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaTransportadora;
    else
      DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaEmpresa;
  end;
  if ChBx_Fantasia.checked then
    Pc_ListaEmpresaDbLookUpComboBox(TipoEmpresa,'EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
  else
    Pc_ListaEmpresaDbLookUpComboBox(TipoEmpresa,'EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa);
End;

procedure TFm_ListaEmpresas.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(TipoEmpresa,'EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFm_ListaEmpresas.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(TipoEmpresa,'EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFm_ListaEmpresas.DBLCB_EmpresaClick(Sender: TObject);
begin
  IF trim(DBLCB_Empresa.Text) <> '' THEN
  begin
    E_Cd_Empresa.Text := IntToStr(DBLCB_Empresa.KeyValue);
  end
  else
  Begin
    E_Cd_Empresa.Clear;
  end;
end;

procedure TFm_ListaEmpresas.DBLCB_EmpresaExit(Sender: TObject);
begin
  E_Cd_Empresa.Clear;
  IF trim(DBLCB_Empresa.Text) <> '' THEN
  begin
    E_Cd_Empresa.Text := DBLCB_Empresa.KeyValue;
  end;
end;

procedure TFm_ListaEmpresas.DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        DBLCB_Empresa.KeyValue := Null;
        E_Cd_Empresa.Clear;
      end;
    end;
end;

procedure TFm_ListaEmpresas.E_Cd_EmpresaExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_Cd_Empresa.Text,0);
  If DBLCB_Empresa.CanFocus then DBLCB_Empresa.SetFocus;
end;

procedure TFm_ListaEmpresas.E_Cd_EmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TFm_ListaEmpresas.SB_EmpresasClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  If trim(DBLCB_Empresa.Text) <> '' then
  Begin
    Lc_Retorno := Fc_AbreTelaEmpresa(DBLCB_Empresa.KeyValue);
    if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
    begin
      E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
      DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
    end;
  end;
end;

procedure TFm_ListaEmpresas.Sb_Pesq_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(-1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
  end;
end;

end.
