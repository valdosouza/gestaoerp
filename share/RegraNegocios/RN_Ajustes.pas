unit RN_Ajustes;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db;

  procedure Pc_AbreTelaConsultaAjuste(Pc_Nr_Pedido:String);
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
    Un_Regra_Negocio, Un_Clta_Ajts;



procedure Pc_AbreTelaConsultaAjuste(Pc_Nr_Pedido:String);
Var
  Lc_Form : TFr_Clta_Ajts;
Begin
  Lc_Form := TFr_Clta_Ajts.Create(Application);
  Lc_Form.E_Nr_Pedido.Text := PC_Nr_Pedido;
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;


end.
