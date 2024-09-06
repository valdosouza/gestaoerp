unit un_fm_lista_pet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_DM, Data.DB,
  STQuery, Vcl.DBCtrls, Vcl.Buttons, Vcl.StdCtrls,
  STDatabase, cad_pet, sea_pet, STTransaction, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TFm_ListaPet = class(TFrame)
    Label19: TLabel;
    Sb_Cadastro: TSpeedButton;
    Dblcb_Lista: TDBLookupComboBox;
    Qr_Lista: TSTQuery;
    DS_Lista: TDataSource;
    Sb_Pesquisa: TSpeedButton;
    IBT_Lista: TSTTransaction;
    procedure Sb_CadastroClick(Sender: TObject);
    procedure Sb_PesquisaClick(Sender: TObject);
    procedure Dblcb_ListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FCliente: Integer;
    procedure setFCliente(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    procedure Listar;
    property Cliente : Integer read FCliente write setFCliente;
  end;

implementation

{$R *.dfm}

{ TFm_ListaPet }

procedure TFm_ListaPet.Dblcb_ListaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Lista.KeyValue := Null;
      end;
    end;
end;

procedure TFm_ListaPet.Listar;
begin
  IF not IBT_Lista.InTransaction THEN IBT_Lista.StartTransaction;
  IF IBT_Lista.InTransaction THEN IBT_Lista.Commit;
  with Qr_Lista do
  Begin
    Active := False;
    SQL.Clear;
    SQL.add(concat(
                  ' SELECT * ',
                  ' FROM TB_PET ',
                  ' WHERE (ID IS NOT NULL) '
    ));
    if (FCliente > 0) then
      SQL.add('and TB_CUSTOMER_ID =:TB_CUSTOMER_ID ');

    SQL.Add(' ORDER BY NAME ');

    if (FCliente > 0) then
      ParamByName('TB_CUSTOMER_ID').AsInteger := FCliente;
    Active := true;
    FetchAll;
  end;
end;

procedure TFm_ListaPet.Sb_CadastroClick(Sender: TObject);
Var
  LcForm : TCadPet;
begin
  if Dblcb_Lista.Text <> '' then
  Begin
    try
      LcForm := TCadPet.Create(nil);
      LcForm.Cliente := Self.FCliente;
      LcForm.CodigoRegistro := Dblcb_Lista.KeyValue;
      LcForm.pet.Registro.Codigo := Dblcb_Lista.KeyValue;
      LcForm.ShowModal;
    finally
      LcForm.DisposeOf;
    end;
  End;
end;

procedure TFm_ListaPet.Sb_PesquisaClick(Sender: TObject);
Var
  LcForm : TSeaPet;
begin
  try
    LcForm := TSeaPet.Create(nil);
    LcForm.Cliente := Self.FCliente;
    LcForm.ShowModal;
    if LcForm.cds_searchID.AsInteger > 0 then
    Begin
      Listar;
      Dblcb_Lista.KeyValue := LcForm.cds_searchID.AsInteger;
    End;
  finally
    LcForm.DisposeOf;
  end;

end;

procedure TFm_ListaPet.setFCliente(const Value: Integer);
begin
  FCliente := Value;
end;

end.
