unit Un_Fm_ListaMedida;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.DB, STQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFm_ListaMedida = class(TFrame)
    Dblcb_Medida: TDBLookupComboBox;
    Label21: TLabel;
    Sb_Recipiente_Medida_1: TSpeedButton;
    Qr_ListaMedida: TSTQuery;
    Ds_ListaMedida: TDataSource;
    procedure Sb_Recipiente_Medida_1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_ListaMedida(Pc_Especial,Descricao:String);
  end;

implementation

{$R *.dfm}

uses UN_Medida;



{ TFm_ListaMedida }

procedure TFm_ListaMedida.Pc_ListaMedida(Pc_Especial, Descricao: String);
begin
  with Qr_ListaMedida do
  Begin
    Active := False;
    Sql.Clear;
    SQl.add('SELECT * FROM TB_MEDIDA '+
            'WHERE (MED_CODIGO IS NOT NULL)');

    if (Length(Pc_Especial) > 0) then
    Begin
      SQl.add(' AND (MED_ESPECIAL is not null) ');
      if (Length(Descricao) > 0) then
        SQl.add(' AND (MED_ESPECIAL =:MED_ESPECIAL) ');
    End
    else
    BEgin
      SQl.add(' AND (MED_ESPECIAL is null) ');
    End;

    SQl.add(' ORDER BY MED_ABREVIATURA ');
    //passagem de parametros
    if (Length(Descricao) > 0) then
      ParamByName('MED_ESPECIAL').AsString := Descricao;
    Active := true;
    FetchAll;
  end;
end;

procedure TFm_ListaMedida.Sb_Recipiente_Medida_1Click(Sender: TObject);
Var
  Lc_Form : TFr_Medida;
begin
  Try
    Lc_Form := TFr_Medida.Create(nil);
    If trim(Dblcb_Medida.Text) <> '' THEN
      Lc_Form.It_Cd_Cadastro := Dblcb_Medida.KeyValue;
    Lc_Form.ShowModal;
  Finally
    Pc_ListaMedida('','');
    Dblcb_Medida.KeyValue := Lc_Form.It_Cd_Cadastro;
    Dblcb_Medida.SetFocus;
    Lc_Form.disposeOf;
  End;
end;

end.
