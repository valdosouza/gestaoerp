unit Un_Fm_ListaEmpresaEndereco;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons, Data.DB, IBX.IBCustomDataSet, STQuery, IBX.IBQuery;

type
  TFm_ListaEmpresaEndereco = class(TFrame)
    Label10: TLabel;
    DBLCB_Endereco: TDBLookupComboBox;
    E_Codigo: TEdit;
    Qr_Entrega: TSTQuery;
    Qr_EntregaEND_CODIGO: TIntegerField;
    Qr_EntregaENDERECO: TIBStringField;
    Qr_EntregaEMP_CODIGO: TIntegerField;
    Ds_Entrega: TDataSource;
    procedure E_CodigoChange(Sender: TObject);
    procedure DBLCB_EnderecoClick(Sender: TObject);
    procedure DBLCB_EnderecoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Listar;
  end;

implementation

{$R *.dfm}

{ TFm_ListaEmpresaEndereco }

procedure TFm_ListaEmpresaEndereco.DBLCB_EnderecoClick(Sender: TObject);
begin
  if ( DBLCB_Endereco.Text <> '' ) then
    E_Codigo.Text := IntToStr( DBLCB_Endereco.KeyValue )
  else
    E_Codigo.Clear;
end;

procedure TFm_ListaEmpresaEndereco.DBLCB_EnderecoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Endereco.KeyValue:=Null;
    end;
  end;
end;

procedure TFm_ListaEmpresaEndereco.E_CodigoChange(Sender: TObject);
begin
  DBLCB_Endereco.KeyValue := StrtoIntDef(E_Codigo.Text,0);
end;

procedure TFm_ListaEmpresaEndereco.Listar;
begin
  with Qr_Entrega do
  Begin
    Active := False;
    Active := True;
  End;
end;

end.
