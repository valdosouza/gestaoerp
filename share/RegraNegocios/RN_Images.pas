unit RN_Images;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,JPEG,Un_JPEGImageExt;

{
  id,
  tb_institution_id,
  kind,
  target,
  table_id,
  file_name,
  extension,
  content,
  link
}
  function Fc_AtualizaImages(id,
                            tb_institution_id,
                            kind,
                            target,
                            table_id,
                            file_name,
                            extension,
                            path,
                            link:String;
                            redimensiona:Boolean):integer;
  function Fc_RetiraCapaImages(table_id:String):integer;
implementation

uses Un_DM, RN_Crud, Un_Regra_Negocio, UN_Sistema;


function Fc_AtualizaImages(id,
                          tb_institution_id,
                          kind,
                          target,
                          table_id,
                          file_name,
                          extension,
                          path,
                          link:String;
                          redimensiona:Boolean):integer;
Var
  Lc_Qry:TSTQuery;
  imgProduto: TJPEGImageExt;
  Jp_IMage: TJpegImage;
Begin
  TRy
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry do
    Begin
      Lc_Qry.Database := DM.IBD_Gestao;
      Lc_Qry.Transaction := DM.IB_Transacao;
      ForcedRefresh := True;
      CachedUpdates := True;
      Active := False;
      SQL.Clear;
      if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
      if (StrToIntDef(TStringList(Fc_VerificaRegistro('TB_IMAGES',['ID'],[ID],['ID'])).Strings[0],0) > 0) then
      Begin //Atualiza
        SQL.Add('update tb_images set '+
                '  tb_institution_id=:tb_institution_id, '+
                '  kind=:kind, '+
                '  target=:target, '+
                '  table_id=:table_id, '+
                '  file_name=:file_name, '+
                '  extension=:extension, ');
        if (trim(path) <> '') and (trim(file_name) <> '') then
          SQL.Add('  content=:content, ');
        SQL.Add('  link=:link '+
                'where id =:id ');
      end
      else
      Begin//Insere
        SQL.Add('insert into tb_images( '+
                '  id, '+
                '  tb_institution_id, '+
                '  kind, '+
                '  target, '+
                '  table_id, '+
                '  file_name, '+
                '  extension, ');
        if (trim(path) <> '') and (trim(file_name) <> '') then
          SQL.Add('  content, ');
        SQL.Add('  link) '+
                'Values( '+
                '  :id, '+
                '  :tb_institution_id, '+
                '  :kind, '+
                '  :target, '+
                '  :table_id, '+
                '  :file_name, '+
                '  :extension, ');
        if (trim(path) <> '') and (trim(file_name) <> '') then
          SQL.Add(' :content, ');
        SQL.Add('  :link) ') ;
        id := IntToStr(Fc_Generator('GN_IMAGES','TB_IMAGES','ID'));
      end;
      //Tratamento de Algumas Variaveis

      //Passagem de Parametros

        ParamByName('id').AsAnsiString :=  id;
        ParamByName('tb_institution_id').AsAnsiString :=  tb_institution_id;
        ParamByName('kind').AsAnsiString :=  kind;
        ParamByName('target').AsAnsiString := target;
        ParamByName('table_id').AsAnsiString :=  table_id;
        //guarda o nome do arquivo já renomeado com o codigo do produto
        ParamByName('file_name').AsAnsiString := id + '_' + table_id + '.' + extension;
        ParamByName('extension').AsAnsiString := extension;
        if (trim(path) <> '') and (trim(file_name) <> '') then
          ParamByName('content').LoadFromFile(path + '\' + file_name , ftBlob);
        ParamByName('link').AsAnsiString := link;

        Try
          ExecSQL;
          if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
          Result := StrToInt(Id);
        except
          if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
          Result := 0;
        end;
    end;
  Finally
    Lc_Qry.Close;
    Lc_Qry.Disposeof;
  End;

end;


function Fc_RetiraCapaImages(table_id:String):integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('update tb_images set '+
            '  target=:target '+
            'where table_id=:table_id and target = ''cover''');
      //Tratamento de Algumas Variaveis

      //Passagem de Parametros
      ParamByName('target').AsAnsiString := 'normal';
      ParamByName('table_id').AsAnsiString :=  table_id;
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        Result := 0;
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;


end.
