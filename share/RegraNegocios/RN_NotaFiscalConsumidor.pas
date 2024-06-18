unit RN_NotaFiscalConsumidor;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,System.Math,ControllerNotaFiscal;

  procedure Pc_AbreTelaPesqNF_65;
  procedure Pc_AbreTelaNotaFiscal65(Tipo:String;PC_Codigo:Integer);
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Fc_Sored_Procedures, Un_Pesq_NF_Pro, Un_NF_65;


procedure Pc_AbreTelaPesqNF_65;
Var
  Lc_Form : TFr_Pesq_NF_Pro;
begin
  try
    Lc_Form := TFr_Pesq_NF_Pro.Create(nil);
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;


procedure Pc_AbreTelaNotaFiscal65(Tipo:String;PC_Codigo:Integer);
Var
  Lc_Form: TFr_NF_65;
  LcNota : TControllerNotaFiscal;
Begin
  Try
    Lc_Form := TFr_NF_65.Create(nil);
    LcNota := TControllerNotaFiscal.create(nil);
    if ( Tipo = 'P' )  then
    Begin
      LcNota.Registro.CodigoPedido := Pc_Codigo;
      Pc_Codigo := LcNota.getCodigoNotaByPedido;
    End;
    Lc_Form.It_Cd_Nota := Pc_Codigo;
    Lc_Form.ShowModal;
  Finally
    Lc_Form.DisposeOf;
    LcNota.DisposeOf;
  End;
end;


end.
