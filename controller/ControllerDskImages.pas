unit ControllerDskImages;

interface
uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      Un_Regra_Negocio, tblDskImages ,Un_MSg, System.Generics.Collections;

Type
  TListaImages = TObjectList<TDskImages>;

  TControllerDskImages = Class(TControllerBase)

  private

  public
    Registro : TDskImages;
    Lista : TListaImages;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    procedure getListTableId;
    procedure getList;

  End;

implementation

{ TControllerDskImages }

constructor TControllerDskImages.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDskImages.Create;
  Lista := TListaImages.Create;
end;

destructor TControllerDskImages.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerDskImages.getbyId;
begin
  _getByKey(Registro);
end;

procedure TControllerDskImages.getList;
Var
  LcQry : TSTQuery;
  LcItem : TDskImages;
begin
  LcQry := GeraQuery;
  Try
    with LcQry do
    Begin
      sql.Clear;
      sql.Add(CONCAT(
              'SELECT * ',
              'FROM TB_IMAGES '
      ));
      Active := True;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcItem := TDskImages.Create;
        get(LcQry,LcItem);
        Lista.Add(LcItem);
        next;
      End;
    End;
  Finally
    FinalizaQuery(LcQry);
  End;
end;

procedure TControllerDskImages.getListTableId;
Var
  LcQry : TSTQuery;
  LcItem : TDskImages;
begin
  LcQry := GeraQuery;
  Try
    with LcQry do
    Begin
      sql.Clear;
      sql.Add(CONCAT(
              'SELECT * ',
              'FROM TB_IMAGES ',
              ' WHERE (TABLE_ID =:TABLE_ID ) '
      ));
      ParamByName('TABLE_ID').AsInteger := Registro.VinculoTabela;
      Active := True;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcItem := TDskImages.Create;
        get(LcQry,LcItem);
        Lista.Add(LcItem);
        next;
      End;
    End;
  Finally
    FinalizaQuery(LcQry);
  End;

end;

end.
