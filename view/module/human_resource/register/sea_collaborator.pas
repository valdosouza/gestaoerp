unit sea_collaborator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, ControllerColaborador, ControllerEmpresa;

type
  TSeaCollaborator = class(TBaseSearch)
    GroupBox1: TGroupBox;
    Lb_CPF: TLabel;
    Lb_Nome: TLabel;
    Lb_Cargo: TLabel;
    E_BuscaCPF: TEdit;
    E_BuscaNome: TEdit;
    E_BuscaCargo: TEdit;
    Chbx_Demitidos: TCheckBox;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TComboBox;
    cds_searchnome: TStringField;
    cds_searchcodigo: TIntegerField;
    cds_searchCargoDescricao: TStringField;
    cds_searchCPFCNPJ: TStringField;
    procedure chbx_EmpresasClick(Sender: TObject);
  private
    procedure MontaComboBoxEmpresa;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    colaborador : TControllerColaborador;
    Empresa: TControllerEmpresa;
  end;

var
  SeaCollaborator: TSeaCollaborator;

{$R *.dfm}

implementation

uses reg_collaborator;

procedure TSeaCollaborator.chbx_EmpresasClick(Sender: TObject);
begin
  inherited;
  //  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
end;

procedure TSeaCollaborator.CriarVariaveis;
begin
  inherited;
  colaborador := TControllerColaborador.create(self);
  Empresa := TControllerEmpresa.create(Self);
  MontaComboBoxEmpresa;
end;

procedure TSeaCollaborator.FinalizaVariaveis;
begin
  inherited;
  colaborador.DisposeOf;
  Empresa.DisposeOf;
end;

procedure TSeaCollaborator.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaCollaborator.openRegister(pCodigo: Integer);
var
 Lc_form : TRegCollaborator;
begin
  Lc_form := TRegCollaborator.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaCollaborator.Search;
var
  i: Integer;
begin
  colaborador.Clear;

  //chbx_Empresas //--ajustar
  //colaborador.Parametros.FieldName. := Dblcb_Mha_Empresa    //--ajustar
  colaborador.Parametros.FieldName.CPFCNPJ := E_BuscaCPF.Text;
  colaborador.Parametros.FieldName.Nome := E_BuscaNome.Text;
  colaborador.Parametros.FieldName.CargoDescricao := E_BuscaCargo.Text;
  colaborador.Parametros.FieldName.Demitidos := Chbx_Demitidos.Checked;

  colaborador.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(colaborador.Lista.Count) do
    cds_search.AppendRecord([colaborador.Lista[i].CODIGO, colaborador.Lista[i].Nome, colaborador.Lista[i].CPFCNPJ, colaborador.Lista[i].CargoDescricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaCollaborator.SetRegister;
begin
  openRegister(0);
end;

procedure TSeaCollaborator.MontaComboBoxEmpresa;
var
  i : Integer;
begin
  with Empresa do
  Begin
    search;
    Dblcb_Mha_Empresa.Items.Clear;
    for i := 0 to Pred(lista.Count) do
      Dblcb_Mha_Empresa.Items.Add(lista[I].NumeroNome);
  End;
end;

end.
