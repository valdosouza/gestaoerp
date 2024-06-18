unit ControllerExtintor;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblArquivo ,prmExtintores,
      Un_RL_ReportListExtintores;


Type
  TControllerExtintor = Class(TControllerBase)
  private
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure ReportListaExtintor(Operacao,Caminho: String;P : TParamExtintor);
  End;

implementation

uses Un_Excel;


constructor TControllerExtintor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TControllerExtintor.Destroy;
begin
  inherited;
end;


procedure TControllerExtintor.ReportListaExtintor(Operacao,Caminho: String;P : TParamExtintor);
Var
  Lc_Form : TRL_ReportListExtintores;
begin
  Try
    Lc_Form  := TRL_ReportListExtintores.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELAÇÃO DE EXINTORES';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

end.
