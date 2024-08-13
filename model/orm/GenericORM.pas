unit GenericORM;

interface

Uses
  Db, Rtti, CAtribEntity, TypInfo, SysUtils, Classes, StrUtils, STQuery ;

type
  TGenericORM = class(TComponent)
    private
      class function GetTableName<T: class>(Obj: T): String;
      class function GetValues<T: class>(Obj: T;Prop: TRttiProperty):String;
      class procedure SetValues<T: class>(Obj: T;Prop: TRttiProperty;Qry:TSTQuery;Field:String);
    public
      class function _Select<T: class>(Obj: T; Fields:String):String;
      class function _Insert<T: class>(Obj: T):String;
      class function _Replace<T: class>(Obj: T):String;
      class function _Update<T: class>(Obj: T):String;
      class function _Delete<T: class>(Obj: T):String;
      class function _Clear<T: class>(Obj: T):String;
      class procedure _assign<T: class>(Source, Dest: T);
      class function _getNextByField<T: class>(Obj: T;Field:String):String;
      class function _getLastInsert<T: class>(Obj: T):String;
      class procedure _get<T: class>(Qry:TSTQuery;Obj: T);
      class Procedure _geralog(acesso : string);
  end;

implementation

class function TGenericORM.GetTableName<T>(Obj: T): String;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Atributo: TCustomAttribute;
  strTable: String;
begin
  Contexto := TRttiContext.Create;
  TypObj := Contexto.GetType(TObject(Obj).ClassInfo);
  for Atributo in TypObj.GetAttributes do
  begin
    if Atributo is TableName then
      Exit(TableName(Atributo).Name);
  end;
end;



class function TGenericORM.GetValues<T>(Obj: T;Prop: TRttiProperty):String;
Var
  lc_Data, Lc_Hora,Lc_Dia, Lc_Mes, Lc_Ano : String;
Begin
  Result := '';
  case Prop.GetValue(TObject(Obj)).Kind of
    tkWChar, tkLString,
    tkWString, tkString,
    tkChar, tkUString:
      Begin
        Result := Prop.GetValue(TObject(Obj)).AsString;
      end;
    tkInteger, tkInt64:
      Begin
        Result := IntToStr( Prop.GetValue(TObject(Obj)).AsInteger) ;
      end;
    tkFloat:
      Begin
        if (Prop.PropertyType.ToString = 'TDate') then
        Begin
          if ( Prop.GetValue(TObject(Obj)).AsExtended > 0) then
          Begin
            Result := formatdatetime('mm-dd-yyyy', Prop.GetValue(TObject(Obj)).AsExtended);
          End;
        End
        else
        Begin
          if (Prop.PropertyType.ToString = 'TDateTime') then
          Begin
            if ( Prop.GetValue(TObject(Obj)).AsExtended > 0) then
            Begin
              Result := formatdatetime('mm-dd-yyyy hh:nn:ss', Prop.GetValue(TObject(Obj)).AsExtended);
            End;
          End
          else
          Begin
            if (Prop.PropertyType.ToString = 'TTime') then
            Begin
              if ( Prop.GetValue(TObject(Obj)).AsExtended > 0) then
              Begin
                Result := formatdatetime('hh:nn:ss', Prop.GetValue(TObject(Obj)).AsExtended);
              End;
            End
            else
            Begin
              Result := FloatToStr(Prop.GetValue(TObject(Obj)).AsExtended) ;
              Result := ReplaceStr(Result,',','.');
            End;
          End;
        End;
      End;
    else
      raise Exception.Create('Tipo Não suportado = Não é possivel converter');
  end;
  result := QuotedStr(Result);
End;

class procedure TGenericORM.SetValues<T>(Obj: T; Prop: TRttiProperty;
  Qry: TSTQuery;Field:String);
Var
  lc_Data, Lc_Hora,Lc_Dia, Lc_Mes, Lc_Ano : String;
Begin
  if not Qry.FieldByName(Field).IsNull then
  Begin
    case Prop.GetValue(TObject(Obj)).Kind of
      tkWChar, tkLString,
      tkWString, tkString,
      tkChar, tkUString:
        Begin
          prop.SetValue(TObject(Obj), Qry.FieldByName(Field).AsString);
        end;
      tkInteger, tkInt64:
        Begin
          prop.SetValue(TObject(Obj),StrToIntDef( Qry.FieldByName(Field).AsString,0));
        end;
      tkFloat:
        Begin
          if (Prop.PropertyType.ToString = 'TDate') then
          Begin
            prop.SetValue(TObject(Obj), Qry.FieldByName(Field).AsDateTime);
          End
          else
          Begin
            if (Prop.PropertyType.ToString = 'TDateTime') then
            Begin
              prop.SetValue(TObject(Obj), Qry.FieldByName(Field).AsDateTime);
            End
            else
            Begin
              if (Prop.PropertyType.ToString = 'TTime') then
              Begin
                prop.SetValue(TObject(Obj), Qry.FieldByName(Field).AsDateTime);
              End
              else
                prop.SetValue(TObject(Obj), Qry.FieldByName(Field).AsFloat);
            End;
          End;
        End;
      else
        raise Exception.Create('Tipo Não suportado = Não é possivel converter');
    end;
  End;
end;

class function TGenericORM._Select<T>(Obj: T; Fields:String):String;
Var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  Atributo: TCustomAttribute;
  strSelect : String;
  strFields :String;
  strWhere : String;
  strKeyField, strKeyValue : String;
  Lc_IndKey : Integer;
Begin
  try
    strSelect := 'Select ';
    strFields := '';
    strWhere := ' Where ';
    strKeyField := '';
    strKeyValue := '';
    Lc_IndKey := 0;
    Contexto := TRttiContext.Create;
    TypObj := Contexto.GetType(TObject(Obj).ClassInfo);
    for Prop in TypObj.GetProperties do begin
      for Atributo in Prop.GetAttributes do begin
        if (not Prop.GetValue(TObject(Obj)).IsEmpty) then
        Begin
          if Atributo is KeyField then
          Begin
            strKeyField := FieldName(Atributo).Name;
            strKeyValue := TGenericORM.GetValues(Obj,Prop);
            if ( Lc_IndKey = 0 ) then
              strWhere := strWhere + '( ' + strKeyField + ' = ' + strKeyValue + ' )'
            else
              strWhere := strWhere + ' AND ( ' + strKeyField + ' = ' + strKeyValue + ' )';
            inc(Lc_IndKey);
          End else Begin
            if (Trim(Fields) = '') then Begin
              if Atributo is FieldName then
                strFields := strFields + FieldName(Atributo).Name + ',';
            End;
          End;
        end;
      end;
    end;
    if (Trim(Fields) = '') then
      strFields := Copy(strFields, 1, Length(strFields) - 1)
    else
      strFields := Fields;
    strSelect := strSelect + strFields + ' from ' + GetTableName(Obj);
    strSelect := strSelect + strWhere ;
    Result := strSelect;
  Except on E: Exception do
    _geralog(concat('GenericDao - Select ',E.Message));
  end;
End;

class function TGenericORM._Insert<T>(Obj: T):String;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  strInsert, strFields,strParams, strValues: String;
  Atributo: TCustomAttribute;
  Lc_Value : String;
begin
  Try
    strInsert := '';
    strParams := '';
    strInsert := 'INSERT INTO ' + GetTableName(Obj);
    Contexto := TRttiContext.Create;
    TypObj := Contexto.GetType(TObject(Obj).ClassInfo);

    for Prop in TypObj.GetProperties do
    begin
      for Atributo in Prop.GetAttributes do
      begin
        if Atributo is FieldName then
        begin
          //Monta o sql com campos preenchidos
          Lc_Value := TGenericORM.GetValues(Obj,Prop);
          if (Trim(Lc_Value) <> '''''') then
          Begin
            strFields := strFields + FieldName(Atributo).Name  + ',';
            strParams := strParams + Lc_Value + ',';
          End
          else
          Begin
            if (FieldName(Atributo).Name = 'created_at') or
               (FieldName(Atributo).Name = 'updated_at')  then
            Begin
               strFields := strFields + FieldName(Atributo).Name  + ',';
               strParams := strParams + ''''+formatdatetime('yyyy-mm-dd hh:nn:ss', Now)+'''' + ','
            End;

          End;
        end;
      end;
    end;
    strFields := Copy(strFields, 1, Length(strFields) - 1);
    strParams := Copy(strParams, 1, Length(strParams) - 1);
    strInsert := strInsert + ' ( ' + strFields + ' ) VALUES ( ' + strParams + ' )';
    REsult := strInsert;
  Except on E: Exception do
    _geralog(concat('GenericDao - Insert - ',E.Message));
  end;

end;


class function TGenericORM._Replace<T>(Obj: T): String;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  strReplace, strFields,strParams, strValues, StrKeys: String;
  Atributo: TCustomAttribute;
  Lc_Value : String;
  Lc_IndKey : Integer;
begin
  Try
    strReplace  := '';
    strParams   := '';
    StrKeys     := '';
    strReplace := ' UPDATE OR INSERT INTO  ' + GetTableName(Obj);
    Contexto := TRttiContext.Create;
    TypObj := Contexto.GetType(TObject(Obj).ClassInfo);
    Lc_IndKey   := 0;
    for Prop in TypObj.GetProperties do
    begin
      for Atributo in Prop.GetAttributes do
      begin
        if Atributo is KeyField then
        Begin
          if ( Lc_IndKey = 0 ) then
            StrKeys := FieldName(Atributo).Name
          else
            StrKeys := concat(StrKeys , ',' ,FieldName(Atributo).Name);
          inc(Lc_IndKey);
        End
        else
        BEgin
          if Atributo is FieldName then
          begin
            Lc_Value := TGenericORM.GetValues(Obj,Prop);
            if (Trim(Lc_Value) <> '''''') or (FieldName(Atributo).Name = 'updated_at') or (FieldName(Atributo).Name = 'created_at') then
            Begin
              if (FieldName(Atributo).Name = 'updated_at') or (FieldName(Atributo).Name = 'created_at')  then
              Begin
                strParams := ''''+ formatdatetime('yyyy-mm-dd hh:nn:ss', Now)+'''';
              End
              else
              Begin
                strFields := strFields + FieldName(Atributo).Name  + ',';
                strParams := strParams + Lc_Value + ',';
              End;
            End
            else
            Begin
              //Quando é branco enviaar null
              //PRecisamos desta parte por que o usuario deve ter a opção de hora informar um dado e outra hora retira-lo
              if not (FieldName(Atributo).Name = 'created_at') then
              Begin
                strFields := strFields + FieldName(Atributo).Name  + ',';
                strParams := strParams + ' null ,';
              End;
            End;
          end;
        End;
      end;
    end;
    strFields := Copy(strFields, 1, Length(strFields) - 1);
    strParams := Copy(strParams, 1, Length(strParams) - 1);
    strReplace := concat(strReplace , ' ( ' , strFields , ' ) VALUES ( ' , strParams , ' )');
    strReplace := concat(strReplace , ' MATCHING ( ' , StrKeys , ' );');
    REsult := strReplace;
  Except on E: Exception do
    _geralog(concat('GenericDao - Insert - ',E.Message));
  end;

end;

class function TGenericORM._Update<T>(Obj: T):String;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  strUpdate, strWhere: String;
  strKeyField, strKeyValue : String;
  Lc_IndKey : Integer; //vai controlar o numero de indices para incluir os os "AND"
  strFields, strParams : String;
  Atributo: TCustomAttribute;
  I:Integer;
  Lc_Value : String;
begin
  Try
    strUpdate := 'UPDATE ' + GetTableName(Obj) + ' SET ';
    strWhere := ' Where ';
    Contexto := TRttiContext.Create;
    TypObj := Contexto.GetType(TObject(Obj).ClassInfo);
    Lc_IndKey := 0;
    for Prop in TypObj.GetProperties do
    begin
      for Atributo in Prop.GetAttributes do
      begin
        if (not Prop.GetValue(TObject(Obj)).IsEmpty) then
        Begin
          if Atributo is KeyField then
          Begin
            strKeyField := FieldName(Atributo).Name;
            strKeyValue := TGenericORM.GetValues(Obj,Prop);
            if ( Lc_IndKey = 0 ) then
              strWhere := strWhere + '( ' + strKeyField + ' = ' + strKeyValue + ' )'
            else
              strWhere := strWhere + ' AND ( ' + strKeyField + ' = ' + strKeyValue + ' )';
            inc(Lc_IndKey);
          End
          else
          Begin
            if Atributo is FieldName then
            begin
              Lc_Value := TGenericORM.GetValues(Obj,Prop);
              if (Trim(Lc_Value) <> '''''') or (FieldName(Atributo).Name = 'updated_at') then
              Begin
                strFields := FieldName(Atributo).Name;
                if (FieldName(Atributo).Name = 'updated_at') then
                  strParams := ''''+ formatdatetime('yyyy-mm-dd hh:nn:ss', Now)+''''
                else
                  strParams := Lc_Value;
                strUpdate := strUpdate + strFields + ' = ' + strParams + ',';
              End
              else
              Begin
                //Quando é branco enviaar null
                //PRecisamos desta parte por que o usuario deve ter a opção de hora informar um dado e outra hora retira-lo
                if not (FieldName(Atributo).Name = 'created_at') then
                Begin
                  strFields := FieldName(Atributo).Name;
                  strParams := Lc_Value;
                  strUpdate := strUpdate + strFields + ' = null ,';
                End;
              End;
            End
          End;
        end;
      end;
    end;
    strUpdate := Copy(strUpdate, 1, Length(strUpdate) - 1);
    strUpdate := strUpdate + strWhere;
    Result := strUpdate;
  Except on E: Exception do
    _geralog(concat('GenericDao - Update - ',E.Message));
  end;
end;


class function TGenericORM._Delete<T>(Obj: T):String;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  strDelete, strWhere: String;
  strKeyField, strKeyValue : String;
  Lc_IndKey : Integer; //vai controlar o numero de indices para incluir os os "AND"
  strFields, strParams : String;
  Atributo: TCustomAttribute;
  I:Integer;
begin
  Try
    strDelete := 'DELETE FROM ' + GetTableName(Obj) ;
    strWhere := ' Where ';
    Contexto := TRttiContext.Create;
    TypObj := Contexto.GetType(TObject(Obj).ClassInfo);
    Lc_IndKey := 0;
    for Prop in TypObj.GetProperties do begin
      for Atributo in Prop.GetAttributes do begin
        if (not Prop.GetValue(TObject(Obj)).IsEmpty) then Begin
          if Atributo is KeyField then Begin
            strKeyField := FieldName(Atributo).Name;
            strKeyValue := TGenericORM.GetValues(Obj,Prop);
            if ( Lc_IndKey = 0 ) then
              strWhere := strWhere + '( ' + strKeyField + ' = ' + strKeyValue + ' )'
            else
              strWhere := strWhere + ' AND ( ' + strKeyField + ' = ' + strKeyValue + ' )';
            inc(Lc_IndKey);
          End
        end;
      end;
    end;
    strDelete := strDelete + strWhere;
    Result := strDelete;
  Except on E: Exception do
    _geralog(concat('GenericDao - Delete - ',E.Message));
  end;

end;

class procedure TGenericORM._assign<T>(Source, Dest: T);
const
  SKIP_PROP_TYPES = [tkUnknown, tkInterface, tkClass, tkClassRef, tkPointer, tkProcedure];
var
  ctx: TRttiContext;
  rType: TRttiType;
  rProp: TRttiProperty;
  AValue, ASource, ATarget: TValue;
begin
  Assert( Assigned(Source) and Assigned(Dest) , 'Both objects must be assigned');
  ctx := TRttiContext.Create;
  rType := ctx.GetType(Source.ClassInfo);
  ASource := TValue.From<T>(Source);
  ATarget := TValue.From<T>(Dest);

  for rProp in rType.GetProperties do
  begin
    if (rProp.IsReadable) and (rProp.IsWritable) and not (rProp.PropertyType.TypeKind in SKIP_PROP_TYPES) then
    begin
      //when copying visual controls you must skip some properties or you will get some exceptions later
      if SameText(rProp.Name, 'Name') or (SameText(rProp.Name, 'WindowProc')) then
        Continue;
      AValue := rProp.GetValue(ASource.AsObject);
      rProp.SetValue(ATarget.AsObject, AValue);
    end;
  end;
end;

class function TGenericORM._Clear<T>(Obj: T):String;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  Atributo: TCustomAttribute;
  Lc_Value : TValue;
begin
  Contexto := TRttiContext.Create;
  TypObj := Contexto.GetType(TObject(Obj).ClassInfo);
  Lc_Value.Empty;
  for Prop in TypObj.GetProperties do
  begin
    for Atributo in Prop.GetAttributes do
    begin
      if Atributo is FieldName then
        Prop.SetValue(TObject(Obj),Lc_Value);
    end;
  end;
end;

class function TGenericORM._getNextByField<T>(Obj: T; Field: String): String;
var
  strSelect: String;
begin
  strSelect := concat(
                'SELECT MAX(',Field,') ', Field,
                ' FROM ' + GetTableName(Obj)
                );
  Result := strSelect;
end;


class procedure TGenericORM._geralog(acesso: string);
var
  Arq : TextFile;
  Data : String;
  LcArq : String;
  LcDir : String;
begin
  {$IFNDEF ANDROID}
  Data := DateToStr(Now);
  Data := StringReplace(Data,'/','-',[rfReplaceAll]);
  LcDir := Concat(ExtractFilePath(ParamStr(0)),'log\');
  IF not (DirectoryExists(LcDir)) then ForceDirectories(LcDir);
  LcArq := Concat(LcDir,Data ,'.log');
  AssignFile(Arq, LcArq );
  if not FileExists( LcArq ) then
    Rewrite(arq, LcArq)
  else
    Append(arq);
  Writeln(Arq, concat(DateTimeToStr(Now),acesso));
  Writeln(Arq, '');
  CloseFile(Arq);
  {$ENDIF ANDROID}
end;

class function TGenericORM._getLastInsert<T>(Obj: T):String;
var
  strSelect: String;
begin
  strSelect := 'SELECT MAX(id) id FROM ' + GetTableName(Obj) ;
  Result := strSelect;
end;

class procedure TGenericORM._get<T>(Qry:TSTQuery;Obj: T);
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  Atributo: TCustomAttribute;
  Lc_Field : String;
begin
  Try
    Contexto := TRttiContext.Create;
    TypObj := Contexto.GetType(TObject(Obj).ClassInfo);
    for Prop in TypObj.GetProperties do
    begin
      for Atributo in Prop.GetAttributes do
      begin
        if Atributo is FieldName then
        begin
          Lc_Field := FieldName(Atributo).Name;
          //Monta o sql com campos preenchidos
          TGenericORM.SetValues(Obj,Prop,Qry,Lc_Field);
        end;
      end;
    end;
  Except on E: Exception do
    _geralog(concat('GenericDao - get - ',E.Message));
  end;
end;

end.


