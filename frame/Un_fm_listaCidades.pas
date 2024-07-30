unit Un_fm_listaCidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  IBX.IBCustomDataSet, STQuery, Vcl.DBCtrls, Vcl.Buttons, Vcl.StdCtrls,
  IBX.IBQuery;

type
  TFmListaCidades = class(TFrame)
    Municipio: TLabel;
    Sb_Cidade: TSpeedButton;
    DBLCB_CIDADE: TDBLookupComboBox;
  private
    { Private declarations }
    Qr_Cidade: TSTQuery;
    Ds_Cidade: TDataSource;
  public
    { Public declarations }
    Estado : String;
    procedure Pc_Listar;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TFmListaCidades.Pc_Listar;
begin
  with Qr_Cidade do
  Begin
    Active := False;
    sql.Clear;
    sql.Add(concat(
          'SELECT * ',
          'FROM TB_CIDADES ',
          'WHERE CDD_UF =:CDD_UF '
    ));
    ParamByName('CDD_UF').AsString := Estado;
    Active := True;
    FetchAll;
  End;
end;

end.
