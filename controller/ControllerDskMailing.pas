unit ControllerDskMailing;

interface

uses  Classes,ControllerBase, STQuery,tblMailing, System.SysUtils,
     Generics.Collections, FireDAC.Stan.Param;

type
  TListaMailing = TObjectList<TMailing>;
  TControllerDskMailing = class(TControllerBase)
    private { private declarations }
      FID : Integer;
      FEmail : String;
    protected { protected declarations }

    public { public declarations }
      Registro : TMailing;
      Lista : TListaMailing;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function ExistEmail():Boolean;
      procedure ListarEmailParaEnvio(Pc_cd_Empresa:String;Pc_Tipos: array of string);
    published { published declarations }
      property ID : Integer read FID write FID;
      property email : string read FEmail write FEmail;
  end;

implementation




constructor TControllerDskMailing.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Registro := TMailing.create;
  Lista := TListaMailing.create;
end;

destructor TControllerDskMailing.Destroy;
begin
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited Destroy;
end;

function TControllerDskMailing.ExistEmail():Boolean;
Begin
  Result := true;

End;


procedure TControllerDskMailing.ListarEmailParaEnvio(Pc_cd_Empresa: String;Pc_Tipos: array of string);
Var
  Lc_Qry : TSTQuery;
  Lc_I : Integer;
  Lc_SqlTxt : String;
  Lc_item : TMailing;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT DISTINCT MLG_EMAIL '+
                   'FROM TB_MAILING '+
                   'WHERE (MLG_CODEMP=:EMP_CODIGO) ';
      if (High(Pc_Tipos) =0) then
      Begin
        Lc_SqlTxt := Lc_SqlTxt + ' AND (MLG_TIPO like ''' + Pc_Tipos[0] + ''') ';
      end
      else
      Begin
        For Lc_I := 0 to High(Pc_Tipos) do
        Begin
          if (Lc_I =0) then
            Lc_SqlTxt := Lc_SqlTxt + ' AND ( (MLG_TIPO like ''' + Pc_Tipos[lc_I] + ''') '
          else
            Lc_SqlTxt := Lc_SqlTxt + ' OR  (MLG_TIPO like ''' + Pc_Tipos[lc_I] + ''') '
        end;
        Lc_SqlTxt := Lc_SqlTxt + ')';
      end;
      SQL.add(Lc_SqlTxt);
      ParamByName('EMP_CODIGO').AsString := Pc_cd_Empresa;
      Active := True;
      First;
      while not eof do
      Begin
        Lc_item := TMailing.Create;
        get(Lc_Qry,Lc_item);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

end.
