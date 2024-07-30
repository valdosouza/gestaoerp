unit Un_fm_ListaTributacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  IBX.IBCustomDataSet, STQuery, Vcl.StdCtrls, Vcl.DBCtrls, Un_DM, IBX.IBQuery;

type
  Tfm_ListaTributacao = class(TFrame)
    Dblcb_Lista: TDBLookupComboBox;
    Label1: TLabel;
    Qr_Lista: TSTQuery;
    Ds_Lista: TDataSource;
    Qr_ListaTRB_CODIGO: TIntegerField;
    Qr_ListaCFOP_COMPLETE: TIBStringField;
    Qr_ListaNAT_CFOP: TIBStringField;
    procedure Dblcb_ListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    Estado : Integer;
    Sentido : String;
    procedure Listar;
  end;

implementation

{$R *.dfm}

{ Tfm_ListaTributacao }

procedure Tfm_ListaTributacao.Dblcb_ListaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Lista.KeyValue := Null;
      end;
    end;
end;

procedure Tfm_ListaTributacao.Listar;
begin
  with Qr_Lista do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    Active := False;
    sql.Clear;
    sql.Add(concat(
              'Select tb.trb_codigo, (nt.nat_cfop || '' - '' || nt.nat_descricao) CFOP_COMPLETE, nt.nat_cfop ',
              'from tb_tributacao tb ',
              '  inner join tb_natureza nt ',
              '  on (nt.nat_codigo = tb.trb_codnat) ',
              'where tb.trb_codigo is not null ',
              '  and tb.trb_estado=:trb_estado ',
              '  and tb.trb_sentido=:trb_sentido '
    ));
    ParamByName('trb_estado').AsInteger := Estado;
    ParamByName('trb_sentido').AsString := Sentido;
    Active := True;
    FetchAll;
  End;
end;

end.
