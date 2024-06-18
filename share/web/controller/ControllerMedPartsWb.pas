unit ControllerMedPartsWb;

interface
uses System.Classes, System.SysUtils,BaseController,
      tblMedPartsWb, FireDAC.Comp.Client,FireDAC.Stan.Param,
      Datasnap.DBClient,Data.DB,  System.Generics.Collections,
  ControllerMedPriceListOL;


Type
  TListaMedPartsWb = TObjectList<TMedPartsWb>;

  TControllerMedPartsWb = Class(TBaseController)
    Lista: TListaMedPartsWb;
    procedure clear;
  private

  protected


  public
    Registro : TMedPartsWb;
    Tabela : TControllerMedPriceListOL;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    Function getList:Boolean;
    function update:boolean;
  End;


implementation

{ TControllerMedPartsWb}

procedure TControllerMedPartsWb.clear;
begin
  clearObj(Registro);
end;

constructor TControllerMedPartsWb.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMedPartsWb.Create;
  Tabela :=TControllerMedPriceListOL.Create(self);
  Lista := TListaMedPartsWb.Create;
 end;

function TControllerMedPartsWb.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMedPartsWb.Destroy;
begin
  Lista.DisposeOf;
  Tabela.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerMedPartsWb.insert: boolean;
begin
  Try
    insertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMedPartsWb.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerMedPartsWb.update: boolean;
begin
  Result := updateObj(Registro);
end;



function TControllerMedPartsWb.getByKey: Boolean;
begin
  _getByKey(Registro);
end;

function TControllerMedPartsWb.getList: Boolean;
var
  Qry : TFDQuery;
  LITem : TMedPartsWb;
begin
  try
    Qry := createQuery;
    with Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_med_parts_wb wb ',
                      'WHERE tb_institution_id =:tb_institution_id ',
                      ' AND tb_order_id =:tb_order_id ',
                      ' ORDER BY id '));

      ParamByName('tb_institution_id').AsInteger := Registro.Estabelecimento;
      ParamByName('tb_order_id').AsInteger := Registro.Ordem;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMedPartsWb.Create;
        get(Qry,LITem);
        Lista.add(LITem);
        next;
      end;
      Close;
    end;
  finally
    Qry.Close;
    FreeAndNil(Qry);
  end;
end;

end.
