unit Un_Fm_ListaEspecieDoc;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  IBX.IBCustomDataSet, STQuery, Vcl.DBCtrls, Vcl.Buttons, Vcl.StdCtrls,
  IBX.IBQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFm_ListaEspecieDoc = class(TFrame)
    L_Especie_Doc: TLabel;
    Sb_EspecieDoc: TSpeedButton;
    Dblcb_Especie_Doc: TDBLookupComboBox;
    Qr_EspecieDoc: TSTQuery;
    Ds_EspecieDoc: TDataSource;
    procedure Sb_EspecieDocClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Listar;
  end;

implementation

{$R *.dfm}

uses Un_DM, Un_Especie_Doc;

procedure TFm_ListaEspecieDoc.Pc_Listar;
begin
  with Qr_EspecieDoc do
  Begin
    Active := False;
    Active := True;
  End;

end;

procedure TFm_ListaEspecieDoc.Sb_EspecieDocClick(Sender: TObject);
Var
  Form : TFr_Especie_Doc;
begin
  Try
    Form := TFr_Especie_Doc.Create(nil);
    if ( Dblcb_Especie_Doc.Text <> '') then
      Form.CodigoRegistro := Dblcb_Especie_Doc.KeyValue
    else
      Form.CodigoRegistro := 0;
    Form.ShowModal;
  Finally
    Pc_Listar;
    Dblcb_Especie_Doc.KeyValue := Form.EspecieDoc.Registro.Codigo;
    Form.DisposeOf;
  End;
end;

end.
