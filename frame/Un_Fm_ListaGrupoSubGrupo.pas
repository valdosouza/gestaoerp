unit Un_Fm_ListaGrupoSubGrupo;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Data.DB, STQuery, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFm_ListaGrupoSubGrupo = class(TFrame)
    Label12: TLabel;
    Label13: TLabel;
    SB_Grupos: TSpeedButton;
    DBLCB_Grupo: TDBLookupComboBox;
    DBLCB_SubGrupo: TDBLookupComboBox;
    Qr_Grupo: TSTQuery;
    Qr_SubGrupo: TSTQuery;
    Ds_Grupo: TDataSource;
    Ds_SubGrupo: TDataSource;
    procedure Qr_SubGrupoAfterScroll(DataSet: TDataSet);
    procedure DBLCB_GrupoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Listar(Cardapio:Boolean);
  end;

implementation

{$R *.dfm}

uses Un_DM;

{ TFm_ListaGrupoSubGrupo }

procedure TFm_ListaGrupoSubGrupo.DBLCB_GrupoExit(Sender: TObject);
begin
  Qr_SubGrupo.Active := False;
  Qr_SubGrupo.Active := True;
end;

procedure TFm_ListaGrupoSubGrupo.Listar(Cardapio:Boolean);
begin
  Qr_Grupo.Active := False;
  Qr_Grupo.SQL.Clear;
  Qr_Grupo.SQL.Add('select * from TB_GRUPOS ');
  if Cardapio then
    Qr_Grupo.SQL.Add('where GRP_COMPOSICAO IS NOT NULL ')
  else
    Qr_Grupo.SQL.Add('where GRP_COMPOSICAO IS NULL ');

  Qr_Grupo.SQL.Add('ORDER BY GRP_DESCRICAO ');
  Qr_Grupo.Active := True;
  Qr_Grupo.FetchAll;

  Qr_SubGrupo.Active := False;
  Qr_SubGrupo.Active := True;
  Qr_SubGrupo.FetchAll;
end;

procedure TFm_ListaGrupoSubGrupo.Qr_SubGrupoAfterScroll(DataSet: TDataSet);
begin
  Qr_SubGrupo.FetchAll;
end;

end.
