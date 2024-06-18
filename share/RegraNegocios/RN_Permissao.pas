unit RN_Permissao;

interface

uses

  Un_DM,  UN_MSG, STQuery,SysUtils,MD5,ControllerUsuario, Un_stored_procedures,
  UnFunctions;

  Function Fc_VerificaPermissao(Fc_Interface,Fc_Descricao,Fc_Privilegio:String;Fc_cd_Usuario:Integer;Fc_Msg:String):Boolean;
  function Fc_AutenticaUsuario(Fc_Usuario,Fc_Senha:String): Boolean;
implementation

uses main, ControllerBase;

Function Fc_VerificaPermissao(Fc_Interface,Fc_Descricao,Fc_Privilegio:String;Fc_cd_Usuario:Integer;Fc_Msg:String):Boolean;
var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  Try
    Result := True;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT 1 '+
                   'FROM TB_INTERFACE IFC '+
                   'WHERE (IFC_SISTEMA = ''S'') AND (IFC.IFC_FR_NAME=:IFC_FR_NAME) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('IFC_FR_NAME').AsAnsiString := Fc_Interface;
      Active := True;
      FetchAll;

      if (RecordCount = 0) then
      Begin
        MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       'A interface '+ Fc_Interface + ' foi desabilitada do teu sistema.' + EOLN +
                       'Verique junto a Setes a liberação.' + EOLN+
                       'Interface: ' + Fc_Interface + EOLN+
                       'Privilégio: ' + Fc_Privilegio + EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Result := False;
      end
      else
      Begin
        //Verifica se não é adminsitrador
        if (Gb_Nivel = 0) then
        Begin
          Active := False;
          SQL.Clear;
          Lc_SqlTxt := 'SELECT DISTINCT OPF.OPF_CODIGO, OPF.OPF_DESCRICAO '+
                       'FROM TB_INTERFACE IFC '+
                       '   INNER JOIN TB_ITENS_IFC IIF '+
                       '   ON (IIF.IIF_CODIFC = IFC.IFC_CODIGO) '+
                       '   INNER JOIN TB_PERMISSAO PER '+
                       '   ON (PER.PER_CODIIF = IIF.IIF_CODIGO) '+
                       '   INNER JOIN TB_OPER_INTERFACE OPF '+
                       '   ON (OPF.OPF_CODIGO = IIF.IIF_CODOPF)    '+
                       'WHERE (IFC_SISTEMA = ''S'') '+
                       ' AND (PER.PER_CODUSU=:PER_CODUSU) '+
                       ' AND (IFC.IFC_FR_NAME=:IFC_FR_NAME) '+
                       ' AND OPF.OPF_DESCRICAO=:OPF_DESCRICAO  ';
          SQL.Add(Lc_SqlTxt);
          ParamByName('PER_CODUSU').AsInteger := Fc_cd_Usuario;
          ParamByName('IFC_FR_NAME').AsAnsiString := Fc_Interface;
          ParamByName('OPF_DESCRICAO').AsAnsiString := Fc_Privilegio;
          Active := True;
          FetchAll;
          if (Fc_Interface <> 'Fr_Nota_Fiscal_3_X') then
          Begin
            if (RecordCount = 0)  then
            Begin
              if (Fc_Msg = 'S') then
              Begin
                MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                               'Usuário não tem permissão.' + EOLN +
                               'Consulte o administrador da Empresa.' + EOLN+
                               'Interface: ' + Fc_Interface + EOLN+
                               'Privilégio: ' + Fc_Privilegio + EOLN,
                               ['OK'], [bEscape], mpAlerta);
              end;
              Result := False;
            end;

          end;
        end;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;
function Fc_AutenticaUsuario(Fc_Usuario,Fc_Senha:String): Boolean;
var
  Lc_Autentica: string;
  Lc_Senha: string;
  Lc_Qry : TSTQuery;
  Lc_usuario : TControllerUsuario;
begin
  Try
    Result := False;
    Lc_usuario := TControllerUsuario.create(nil);
    Lc_usuario.Registro.Login := Fc_Usuario;
    Lc_usuario.Registro.Senha := Fc_Senha;
    Lc_usuario.Autentica;
    if Lc_usuario.exist then
    Begin
      Result := True;
      Gb_Cd_Usuario := Lc_usuario.Registro.Codigo;
      Gb_Nivel := StrToIntDef( Lc_usuario.Registro.nivel,0);
      GB_Nm_Usuario := Lc_usuario.Registro.Nome;
      Gb_Senha := Lc_usuario.Registro.Senha;
      Lc_Usuario.Colaborador.Registro.USuario := Lc_Usuario.Registro.Codigo;
      Lc_Usuario.Colaborador.GetByUser;
      if Lc_Usuario.Colaborador.exist then
      Begin
        Gb_Cd_Vendedor := Lc_Usuario.Colaborador.Registro.Codigo;
      end;
      Gb_Liberado := (Gb_Nivel = 1);
      //Registra quem entrou no sistema
      Pc_Log_Sistema(
                Gb_CodMha,
                Gb_Cd_Usuario,
                (Now),
                'Tela principal',
                Lc_Usuario.Registro.Codigo,
                'Login no Sistema', 'Logado');
    end
    else
    begin
      DM.Qr_ListaUsuario.Active := True;
      DM.Qr_ListaUsuario.First;
      if ( DM.Qr_ListaUsuario.Locate('USU_LOGIN',Fc_Usuario, [])) then
      Begin
        Pc_Log_Sistema( Gb_CodMha,
                         DM.Qr_ListaUsuario.FieldByName('USU_CODIGO').AsInteger,
                        (Now),
                        'Tela principal',
                        DM.Qr_ListaUsuario.FieldByName('USU_CODIGO').AsInteger,
                        'Tentativa de Login no Sistema', concat('Falha no Login no pc: ',Fc_NomeComputador));
      End;
      MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                     'Senha ou Login Incorretos. Verifique' + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  Finally
    Lc_usuario.DisposeOf;
  End;
end;

end.
