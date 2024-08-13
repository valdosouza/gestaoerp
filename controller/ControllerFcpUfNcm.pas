unit ControllerFcpUfNcm;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblFcpufNcm, prm_fcp_uf_ncm;

Type
  TListaFCP = TObjectList<TFcpufNcm>;

  TControllerFcpUfNcm = Class(TControllerBase)

  private
    FParametros: TPrmFcpUFNcm;
    procedure setFParametros(const Value: TPrmFcpUFNcm);

  protected

  public
    Registro : TFcpufNcm;
    Lista : TListaFCP;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure getbyId;
    procedure insert;
    procedure update;
    procedure save;
    procedure delete;
    procedure clear;
    procedure Search;
    property Parametros : TPrmFcpUFNcm read FParametros write setFParametros;
  End;


implementation

{ TControllerFcpUfNcm }

procedure TControllerFcpUfNcm.clear;
begin

end;

constructor TControllerFcpUfNcm.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TFcpufNcm.create;
  Lista := TListaFCP.create;
  FParametros := TPrmFcpUFNcm.Create;
end;

procedure TControllerFcpUfNcm.delete;
begin
  Deleteobj(Registro)
end;

destructor TControllerFcpUfNcm.Destroy;
begin
  FreeAndNil( Registro );
  FreeAndNil( Lista );
  FreeAndNil( FParametros );
  inherited;
end;


procedure TControllerFcpUfNcm.getbyId;
begin
  _getByKey(Registro);
end;


procedure TControllerFcpUfNcm.insert;
begin
  InsertObj(Registro);
end;

procedure TControllerFcpUfNcm.save;
begin
  SaveObj(Registro);
end;

procedure TControllerFcpUfNcm.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TFcpUfNcm;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.add(concat(
                'SELECT * ',
                'FROM TB_FCP_UF_NCM ',
                'WHERE TB_STATE_ID=:TB_STATE_ID '
      ));
      ParamByName('TB_STATE_ID').AsInteger := FParametros.FieldName.CodigoUF;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TFcpUfNcm.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFcpUfNcm.setFParametros(const Value: TPrmFcpUFNcm);
begin
  FParametros := Value;
end;

procedure TControllerFcpUfNcm.update;
begin
  updateObj(Registro);
end;

end.
