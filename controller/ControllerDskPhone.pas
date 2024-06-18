unit ControllerDskPhone;

interface
uses STDatabase,Classes, STQuery,  SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblPhone ,Un_MSg,
      Generics.Collections, Vcl.Forms;

Type
  TListaPhone = TObjectList<TPhone>;

  TControllerDskPhone = Class(TControllerBase)
    Lista : TListaPhone;
  private

  public
    Registro : TPhone;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:Boolean;
    procedure getbyId;
    Function delete:boolean;
    procedure SyncronizeAddress;
    procedure SyncronizeFoneUtil;
    procedure getList;
  End;

implementation

constructor TControllerDskPhone.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPhone.Create;
  Lista := TListaPhone.Create;
end;

function TControllerDskPhone.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerDskPhone.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil( Lista );
  inherited;
end;

function TControllerDskPhone.salva: boolean;
begin
  SaveObj(Registro);
end;


procedure TControllerDskPhone.SyncronizeAddress;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery();
    with Lc_Qry,Registro do
    Begin
      Sql.Add('select end_codemp, end_contato, end_tipo, end_fone, '+
              'end_fax, end_celular, end_portaria, end_comercial '+
              'from tb_endereco '+
              '  left outer Join tb_phone  '+
              '  on (end_codemp = ID) '+
              'where ID is null AND  CHARACTER_LENGTH(end_fone || end_fax || end_celular || end_portaria || end_comercial) > 0');
      Active := True;
      Fetchall;
      while not eof do
      Begin
        Codigo := FieldByName('end_codemp').AsInteger;
        Contato := FieldByName('end_contato').AsString;
        //Grava o primeiro numero sendo comercial ou residencial
        if ( Length( FieldByName('end_fone').AsString ) > 0 ) then
        Begin
          Tipo := 'PRINCIPAL';
          Numero := FieldByName('end_fone').AsString;
          salva;
        End;
        //Grava o FAX
        if ( Length( FieldByName('end_fax').AsString ) > 0 ) then
        Begin
          Tipo := 'FAX';
          Numero := FieldByName('end_fax').AsString;
          salva;
        End;
        //Grava o Celular
        if ( Length( FieldByName('end_celular').AsString ) > 0 ) then
        Begin
          Tipo := 'CELULAR';
          Numero := FieldByName('end_celular').AsString;
          salva;
        End;
        //Grava o Comercial
        if ( Length( FieldByName('end_comercial').AsString ) > 0 ) then
        Begin
          Tipo := 'COMERCIAL';
          Numero := FieldByName('end_comercial').AsString;
          salva;
        End;
        //Grava o Portaria
        if ( Length( FieldByName('end_portaria').AsString ) > 0 ) then
        Begin
          Tipo := 'PORTARIA';
          Numero := FieldByName('end_portaria').AsString;
          salva;
        End;
        next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskPhone.SyncronizeFoneUtil;
Var
  Lc_Qry : TSTQuery;
  Lc_Del : TSTQuery;
begin
  TRy
    Lc_Del := GeraQuery();
    with Lc_Del do
    Begin
      sql.Add('DELETE FROM TB_FONE_UTIL WHERE FNU_CODIGO=:FNU_CODIGO');
    End;

    Lc_Qry := GeraQuery();
    with Lc_Qry,Registro do
    Begin
      Sql.Add('SELECT FNU_CODIGO,FNU_NOME, FNU_FONE, FNU_FAX, FNU_CELULAR  FROM TB_FONE_UTIL');
      Active := True;
      Fetchall;
      while not eof do
      Begin
        Codigo := 0;
        Contato := FieldByName('FNU_NOME').AsString;
        //Grava o primeiro numero sendo comercial ou residencial
        if ( Length( FieldByName('FNU_FONE').AsString ) > 0 ) then
        Begin
          Tipo := 'PRINCIPAL';
          Numero := FieldByName('FNU_FONE').AsString;
          salva;
        End;
        //Grava o FAX
        if ( Length( FieldByName('FNU_FAX').AsString ) > 0 ) then
        Begin
          Tipo := 'FAX';
          Numero := FieldByName('FNU_FAX').AsString;
          salva;
        End;
        //Grava o Celular
        if ( Length( FieldByName('FNU_CELULAR').AsString ) > 0 ) then
        Begin
          Tipo := 'CELULAR';
          Numero := FieldByName('FNU_CELULAR').AsString;
          salva;
        End;
        Lc_Del.Active := False;
        Lc_Del.ParamByName('FNU_CODIGO').AsInteger := FieldByName('FNU_CODIGO').AsInteger;
        Lc_Del.ExecSQL;
        next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Del);
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskPhone.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerDskPhone.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TPhone;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_PHONE '
                    ));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPhone.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskPhone.migra: Boolean;
begin
  InsertObj(Registro);
end;


end.
