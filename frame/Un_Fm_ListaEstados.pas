unit Un_Fm_ListaEstados;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Buttons,sea_uf, Data.DB, IBX.IBCustomDataSet, STQuery, IBX.IBQuery,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFm_ListaEstados = class(TFrame)
    Label23: TLabel;
    DBLCB_UF: TDBLookupComboBox;
    Sb_Uf: TSpeedButton;
    Qr_Uf: TSTQuery;
    Ds_Uf: TDataSource;

    procedure Sb_UfClick(Sender: TObject);
    procedure DBLCB_UFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Listar;
  end;

implementation

{$R *.dfm}

procedure TFm_ListaEstados.DBLCB_UFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_UF.KeyValue := 0;
      end;
    end;
end;

procedure TFm_ListaEstados.Pc_Listar;
begin
  with Qr_UF do
  Begin
    Active := False;
    Active := True;
    FetchAll;
  End;
end;

procedure TFm_ListaEstados.Sb_UfClick(Sender: TObject);
Var
  Form : TSeaUf;
begin
  Form := TSeaUf.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

end.
