unit Un_Especie_Doc;

interface

uses
  Winapi.Windows, Winapi.Messages, base_registry, Vcl.StdCtrls, Vcl.Menus,
  Vcl.Controls, Vcl.Buttons, Classes, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls, ControllerEspecieDoc,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Graphics, SysUtils ;

type
  TFr_Especie_Doc = class(TBaseRegistry)
    Label7: TLabel;
    E_Descricao: TEdit;
    Label1: TLabel;
    E_Numero: TEdit;
    Label2: TLabel;
    E_Sigla: TEdit;
    procedure ShowNoData;Override;
    procedure ShowData;Override;
    procedure IniciaVariaveis;Override;
    procedure Insert;Override;
    procedure Change;Override;
    function ValidateDelete:Boolean;Override;
    procedure Delete;Override;
    function ValidateSave:Boolean;Override;
    procedure Save;Override;
    function ValidateCancel:Boolean;Override;
    procedure Cancel;Override;
    procedure FormCreate(Sender: TObject);
  private
      { Private declarations }
  protected
    procedure EditionControl;Override;
  public
      { Public declarations }
      EspecieDoc : TControllerEspecieDoc;
  end;

var
  Fr_Especie_Doc: TFr_Especie_Doc;

implementation

{$R *.dfm}

uses Un_Msg;

{ TBaseRegistry }

procedure TFr_Especie_Doc.Change;
begin
  inherited;
  EditionState := 'E';
  EditionControl;
  E_Numero.SetFocus;
end;

procedure TFr_Especie_Doc.Cancel;
begin
  inherited;
  if ( EditionState = 'I' ) then
  Begin
    Close;
  End
  else
  Begin
    EditionState := 'B';
    EditionControl;
  End;
end;


procedure TFr_Especie_Doc.Delete;
begin
  EspecieDoc.delete;
  Close;
end;

procedure TFr_Especie_Doc.EditionControl;
begin
  inherited;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TFr_Especie_Doc.Save;
begin
  with EspecieDoc.Registro do
  Begin
    Numero := E_Numero.Text;
    Sigla := E_Sigla.Text;
    Descricao := E_Descricao.Text;
  End;
  EspecieDoc.salva;
  EditionState := 'B';
  CodigoRegistro := EspecieDoc.Registro.Codigo;
  EditionControl;
end;

procedure TFr_Especie_Doc.ShowNoData;
Begin
  E_Numero.Clear;
  E_Sigla.Clear;
  E_Descricao.Clear;
End;

procedure TFr_Especie_Doc.ShowData;
Begin
  with EspecieDoc.Registro do
  Begin
    E_Numero.Text := Numero;
    E_Sigla.Text := Sigla ;
    E_Descricao.Text := Descricao;
  End;
End;

procedure TFr_Especie_Doc.IniciaVariaveis;
Begin
  if CodigoRegistro > 0 then
  Begin
    EspecieDoc.Registro.Codigo := Self.CodigoRegistro;
    EspecieDoc.getbyId;
  End;
  inherited;
End;

procedure TFr_Especie_Doc.Insert;
begin
  ShowNoData;
  EditionState := 'I';
  EditionControl;
  E_Numero.SetFocus;
end;

function TFr_Especie_Doc.ValidateCancel: Boolean;
begin
  inherited;
  //
end;

function TFr_Especie_Doc.ValidateDelete: Boolean;
begin
  inherited;
  if (Mensagem('Mensagem de Confirmação',
                     'Excluir este registro de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     ['Sim', 'Não'], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  begin
    Result := False;
    Exit;
  end;

  if not ( EspecieDoc.Registro.Codigo > 0 ) then
  Begin
    Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Não há registro para excluir.'+EOLN+
                   'Verifique e tente novamente.'  +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  End;
end;

function TFr_Especie_Doc.ValidateSave: Boolean;
begin
  Result := True;
  if ( Trim(E_Numero.Text) = '' ) then
  Begin
    Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Campo número não preenchido.'+EOLN+
                   'Verifique e tente novamente.'  +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    E_Numero.SetFocus;
    Result := False;
    Exit;
  End;

  if ( Trim(E_Sigla.Text) = '' ) then
  Begin
    Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Campo sigla não preenchido.'+EOLN+
                   'Verifique e tente novamente.'  +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    E_Sigla.SetFocus;
    Result := False;
    Exit;
  End;

  if ( Trim(E_Descricao.Text) = '' ) then
  Begin
    Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Campo descrição não preenchido.'+EOLN+
                   'Verifique e tente novamente.'  +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    E_Descricao.SetFocus;
    Result := False;
    Exit;
  End;
end;

procedure TFr_Especie_Doc.FormCreate(Sender: TObject);
begin
  inherited;
  EspecieDoc := TControllerEspecieDoc.Create(Self);
end;

end.

