unit Un_Fm_CentroCusto;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  QEdit_Setes, Vcl.DBCtrls, Vcl.Buttons, Data.DB,
  STQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFm_CentroCusto = class(TFrame)
    Grb_Cta_CentroCusto: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Sb_Plano: TSpeedButton;
    DBLCB_Plano: TDBLookupComboBox;
    Qr_PlanoContas: TSTQuery;
    Ds_PlanoContas: TDataSource;
    E_Codigo_Plano: TEdit_Setes;
    procedure Sb_PlanoClick(Sender: TObject);
    procedure DBLCB_PlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_PlanoExit(Sender: TObject);
    procedure E_Codigo_PlanoExit(Sender: TObject);
  private
    { Private declarations }
      FFiltrar : boolean;
  public
    { Public declarations }
    procedure Pc_ListaParaUsar;
    procedure Pc_ListaParaFiltrar;
  end;

implementation

{$R *.dfm}

uses Un_PlanoContas, Un_DM, RN_PlanoContas, UN_Sistema, UN_Principal,env;

procedure TFm_CentroCusto.DBLCB_PlanoExit(Sender: TObject);
begin
  if ( DBLCB_Plano.Text <> '' ) then
  Begin
    //Edit_Setes
    E_Codigo_Plano.Text := DBLCB_Plano.KeyValue
  End;
end;

procedure TFm_CentroCusto.DBLCB_PlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Plano.KeyValue:=Null;
    E_Codigo_Plano.Clear;
    end;
  end;
end;

procedure TFm_CentroCusto.E_Codigo_PlanoExit(Sender: TObject);
begin
  DBLCB_Plano.KeyValue := StrToIntDef(E_Codigo_Plano.Text,0);
end;

procedure TFm_CentroCusto.Pc_ListaParaUsar;
Var
  Lc_Descricao : String;
begin
  FFiltrar := FAlse;
  with Qr_PlanoContas do
  Begin
    Active:=false;
    SQL.Clear;
    if (Fc_Tb_Geral('L','GRL_G_PLCTA_USA_CLASSI','G') = 'S') then
      Lc_Descricao := '  PLC_CODPLANO || '' - '' || PLC_DESCRICAO COMPLETO, '
    else
      Lc_Descricao := '  PLC_DESCRICAO COMPLETO, ';

    SQL.Add(concat(
           'SELECT DISTINCT ',
            '  PLC_CODIGO, ',
            '  PLC_CODPLANO, ',
            '  PLC_DESCRICAO, ',
            Lc_Descricao ,
            '  PLC_NATUREZA, ',
            '   PLC_TIPO ',
            'FROM TB_PLANOCONTAS ',
            'WHERE (PLC_NIVEL = ''A'') and (PLC_TIPO = ''C'')',
            ' AND (PLC_CODMHA =:PLC_CODMHA)',
            'ORDER BY 4 '
    ));
     ParamByName('PLC_CODMHA').AsInteger := Gb_Codmha;
    Active:=true;
    FetchAll;
    DBLCB_Plano.KeyField := 'PLC_CODIGO';
  end;
end;

procedure TFm_CentroCusto.Pc_ListaParaFiltrar;
Var
  Lc_Descricao : String;
begin
  FFiltrar := TRue;
  with Qr_PlanoContas do
  Begin
    Active:=false;
    SQL.Clear;
    if (Fc_Tb_Geral('L','GRL_G_PLCTA_USA_CLASSI','G') = 'S') then
      Lc_Descricao := '  PLC_CODPLANO || '' - '' || PLC_DESCRICAO COMPLETO, '
    else
      Lc_Descricao := '  PLC_DESCRICAO COMPLETO, ';

    SQL.Add('SELECT DISTINCT '+
            '  PLC_CODIGO, '+
            '  PLC_CODPLANO, '+
            '  PLC_DESCRICAO, '+
            Lc_Descricao +
            '  PLC_NATUREZA, '+
            '   PLC_TIPO '+
            'FROM TB_PLANOCONTAS '+
            'WHERE (PLC_TIPO = ''C'')'+
            ' AND (PLC_CODMHA =:PLC_CODMHA)'+
            'ORDER BY 4 ');
    ParamByName('PLC_CODMHA').AsInteger := Gb_Codmha;
    Active:=true;
    FetchAll;
    DBLCB_Plano.KeyField := 'PLC_CODIGO';
  end;


end;

procedure TFm_CentroCusto.Sb_PlanoClick(Sender: TObject);
Var
  Lc_Form : TFr_PlanoContas;
begin
  TRy
    Lc_Form := TFr_PlanoContas.Create(nil);
    Lc_Form.ShowModal;
    if FFiltrar then
      Pc_ListaParaFiltrar
    else
      Pc_ListaParaUsar;
    E_Codigo_Plano.Text := Lc_Form.It_Cd_Plano.ToString;
    E_Codigo_PlanoExit(Self);
  Finally
    Lc_Form.DisposeOf;
  End;

end;

end.
