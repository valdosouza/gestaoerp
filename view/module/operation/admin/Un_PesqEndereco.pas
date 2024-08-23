unit Un_PesqEndereco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, STQuery, StdCtrls, Buttons, Mask, Grids,
  DBGrids, ExtCtrls, DBCtrls, ComCtrls,XMLIntf,XMLDoc,acbrCep ;

type
  TFr_PesqEndereco = class(TForm)
    Panel3: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    E_busca_Endereco: TMaskEdit;
    E_busca_Cidade: TMaskEdit;
    DBLCB_busca_Estado: TDBLookupComboBox;
    StrGrd_Logradouro: TStringGrid;
    Panel4: TPanel;
    Sb_ok: TBitBtn;
    Sb_Cancela: TBitBtn;
    Sb_Busca: TBitBtn;
    Label1: TLabel;
    E_Busca_Tipo: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Sb_BuscaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    Procedure Pc_AtivarTabelas;
    Procedure Pc_FormataTela;
    Procedure Pc_BuscarInternet;
    procedure Pc_MontaGradeLogradouro;
  end;

var
  Fr_PesqEndereco: TFr_PesqEndereco;

implementation

uses UN_Sistema, Un_DM,  UN_MSG, Un_Regra_Negocio, env;

{$R *.dfm}


procedure TFr_PesqEndereco.Pc_MontaGradeLogradouro;
Begin
  StrGrd_Logradouro.ColWidths[0]:=17;
  StrGrd_Logradouro.ColWidths[1]:=63;
  StrGrd_Logradouro.ColWidths[2]:=280;
  StrGrd_Logradouro.ColWidths[3]:=184;
  StrGrd_Logradouro.ColWidths[4]:=298;
  StrGrd_Logradouro.ColWidths[5]:=25;
  StrGrd_Logradouro.Cols[1].Add('Cep');
  StrGrd_Logradouro.Cols[2].Add('Logradouro');
  StrGrd_Logradouro.Cols[3].Add('Bairro');
  StrGrd_Logradouro.Cols[4].Add('Cidade');
  StrGrd_Logradouro.Cols[5].Add('UF');
end;

Procedure TFr_PesqEndereco.Pc_AtivarTabelas;
Begin
  DM.Qr_UF.Active := true;
  DM.Qr_Cidades.Active := true;
end;

Procedure TFr_PesqEndereco.Pc_FormataTela;
begin

end;




Procedure TFr_PesqEndereco.Pc_BuscarInternet;
Var
  Lc_I : Integer;
  Lc_Registro : Integer;
  cep : TAcbrCep;
Begin
  Application.ProcessMessages;
  //Insere o Xml dentro do Componente
  if (Length(Trim(E_busca_Endereco.Text))<=1) then
    Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Por favor preencha o Logradouro com pelo menos com duas letras.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
    exit;
    end;

  if Trim(E_busca_Cidade.Text) = '' then
    Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Por favor preencha o nome da Cidade.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
    exit;
  end;

  if Trim(DBLCB_busca_Estado.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Por favor preencha o Estado.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
    exit;
  end;
  Try
    cep := TAcbrCep.Create(nil);
    with cep DO
    Begin
      WebService := wsViaCep;
      BuscarPorLogradouro(E_busca_Cidade.Text,
                          E_Busca_Tipo.Text,
                          E_busca_Endereco.Text,
                          DBLCB_busca_Estado.Text,
                          '');
      //Preenche o Registro
      if Enderecos.Count > 0 then
      Begin
        StrGrd_Logradouro.RowCount := Enderecos.Count + 1;
        For Lc_I := 0 to Enderecos.Count-1 do
        begin
          with Enderecos[Lc_I],StrGrd_Logradouro do
          begin
            Cells[1,Lc_I + 1] := Cep;
            Cells[2,Lc_I + 1] := UpperCase(Tipo_Logradouro+ ' ' +Logradouro);
            Cells[3,Lc_I + 1] := UpperCase(Bairro);
            Cells[4,Lc_I + 1] := UpperCase(Municipio);
            Cells[5,Lc_I + 1] := UpperCase(UF);
          end ;
        end ;
      End;
    end;
  Finally
    cep.Disposeof;
  End;

end;

procedure TFr_PesqEndereco.FormShow(Sender: TObject);
begin
  Pc_AtivarTabelas;
  Pc_FormataTela;

end;


procedure TFr_PesqEndereco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_RETURN : Sb_Ok.Click;
      VK_ESCAPE : Sb_Cancela.Click;
      VK_F7 : if Sb_Busca.Enabled then Sb_BuscaClick(Sender);
    end;
  end;
end;

procedure TFr_PesqEndereco.FormCreate(Sender: TObject);
begin
  Pc_MontaGradeLogradouro;
end;

procedure TFr_PesqEndereco.Sb_BuscaClick(Sender: TObject);
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_BuscarInternet;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.Activate;
    Self.BringToFront;
  end;
end;

end.
