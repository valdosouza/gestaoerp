unit Un_Base;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Data.Db, Vcl.Menus,Vcl.DBCtrls,
  STDataSet, STQuery, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Mask, QEdit_Setes, ACBrGIF,ControllerGeral;

type
  TFr_Base = class(TForm)
    Menu: TMainMenu;
    arefas1: TMenuItem;
    Sair1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure CarregaImagemBotao(Sb: TSpeedButton;Fc_Operacao: String);
    procedure Sair1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    Pf_Inserir , Pf_Alterar, Pf_Excluir,Pf_Visualizar : Boolean;
    EditionState : String;
    Config : TControllerGeral;
    function ExecConfig(Fc_Tipo: char; Fc_CAmpo: string; Fc_Conteudo: string): string;
    procedure ImagemBotao;Virtual;
    procedure CriarVariaveis;Virtual;
    procedure IniciaVariaveis;Virtual;
    procedure FinalizaVariaveis;Virtual;
    procedure setPerfil;Virtual;
    procedure FormataTela;Virtual;
    procedure AtivaTabelas;Virtual;
    procedure ClearFields(T: TComponent);
    procedure EditionControler(T: TComponent);

    procedure execShorCutKeyF1;Virtual;
    procedure execShorCutKeyF2;Virtual;
    procedure execShorCutKeyF3;Virtual;
    procedure execShorCutKeyF4;Virtual;
    procedure execShorCutKeyF5;Virtual;
    procedure execShorCutKeyF6;Virtual;
    procedure execShorCutKeyF7;Virtual;
    procedure execShorCutKeyF8;Virtual;
    procedure execShorCutKeyF9;Virtual;
    procedure execShorCutKeyF10;Virtual;
    procedure execShorCutKeyF11;Virtual;
    procedure execShorCutKeyF12;Virtual;
    procedure execShorCutEsc;Virtual;
    procedure IniciaProcesso;
    procedure FinalizaProcesso;
  private
    { Private declarations }

  public
    { Public declarations }
    CodigoRegistro : Integer;
    pfMenu : String;
  end;

var
  Fr_Base: TFr_Base;

implementation

{$R *.dfm}

uses ControllerBase, Un_DM,main;

{ TFr_Base }

procedure TFr_Base.EditionControler(T: TComponent);
Var
  I,J:Integer;
begin
  with T do
  Begin
    for I := 0 to ((ComponentCount)-1) do
    begin
      if (Components[I].ClassName = 'TEdit') then
      Begin
        if TEdit (Components[I]).Name = 'E_ID' then
          TEdit (Components[I]).ReadOnly := True
        else
          TEdit (Components[I]).ReadOnly := ( EditionState = 'B' );
      End;

      if (Components[I].ClassName = 'TMaskEdit') then
      Begin
        if TMaskEdit (Components[I]).Name = 'E_ID' then
          TMaskEdit (Components[I]).ReadOnly := True
        else
          TMaskEdit (Components[I]).ReadOnly := ( EditionState = 'B' );
      End;

      if (Components[I].ClassName = 'TDBLookupComboBox') then
        TDBLookupComboBox (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TMemo') then
        TMemo (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TCheckBox') then
        TCheckBox (Components[I]).Enabled := ( EditionState <> 'B' );

      if (Components[I].ClassName = 'TComboBox') then
        TComboBox (Components[I]).Enabled := ( EditionState <> 'B' );

      if (Components[I].ClassName = 'TRadioGroup') then
        TRadioGroup (Components[I]).Enabled := ( EditionState <> 'B' );

      if (Components[I].ClassName = 'TDateTimePicker') then
        TDateTimePicker (Components[I]).Enabled := ( EditionState <> 'B' );

      if (Components[I].ClassName = 'TTreeView') then
        TTreeView (Components[I]).Enabled := ( EditionState = 'B' );

//      if (Components[I].ClassName = 'TDBGrid') then
//        TDBGrid (Components[I]).ReadOnly := ( EditionState = 'B' );

      if (Components[I].ClassName = 'TSpeedButton') then
        TSpeedButton (Components[I]).Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );

      if (Components[I].ClassName = 'TButton') then
        TButton (Components[I]).Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );

    end;
  End;
end;

function TFr_Base.ExecConfig(Fc_Tipo: char; Fc_CAmpo,
  Fc_Conteudo: string): string;
begin
  with Config do
  Begin
    Registro.Campo := Fc_CAmpo;
    Registro.Conteudo := Fc_Conteudo;
    Registro.CodigoEstabelecimento := Gb_CodMha;
    if Fc_Tipo = 'G' then
    Begin
      salva;
    End
    else
    Begin
      getById;
      if not exist then salva;
    End;
    Result := Registro.Conteudo;
  End;
end;

procedure TFr_Base.execShorCutEsc;
begin

end;

procedure TFr_Base.execShorCutKeyF1;
begin

end;

procedure TFr_Base.execShorCutKeyF10;
begin

end;

procedure TFr_Base.execShorCutKeyF11;
begin

end;

procedure TFr_Base.execShorCutKeyF12;
begin

end;

procedure TFr_Base.execShorCutKeyF2;
begin

end;

procedure TFr_Base.execShorCutKeyF3;
begin

end;

procedure TFr_Base.execShorCutKeyF4;
begin

end;

procedure TFr_Base.execShorCutKeyF5;
begin

end;

procedure TFr_Base.execShorCutKeyF6;
begin

end;

procedure TFr_Base.execShorCutKeyF7;
begin

end;

procedure TFr_Base.execShorCutKeyF8;
begin

end;

procedure TFr_Base.execShorCutKeyF9;
begin

end;

procedure TFr_Base.ClearFields(T: TComponent);
Var
  I,J:Integer;
begin
  with T do
  Begin
    for I := 0 to ((ComponentCount)-1) do
    begin
      if (Components[I].ClassName = 'TEdit') then
        TEdit (Components[I]).Clear;

      if (Components[I].ClassName = 'TEdit_Setes') then
        TEdit_Setes(Components[I]).Clear;

      if (Components[I].ClassName = 'TMemo') then
        TMemo (Components[I]).Clear;

      if (Components[I].ClassName = 'TCheckBox') then
      Begin
        if ( TCheckBox (Components[I]).name = 'chbx_cad_active' ) then
          TCheckBox (Components[I]).Checked := true
        else
        if ( TCheckBox (Components[I]).name = 'ChBx_Periodo' ) then
          TCheckBox (Components[I]).Checked := true
        else
          TCheckBox (Components[I]).Checked := False;
      End;

      if (Components[I].ClassName = 'TComboBox') then
        TComboBox (Components[I]).ItemIndex := 0;

      if (Components[I].ClassName = 'TDBLookupComboBox') then
        TDBLookupComboBox(Components[I]).KeyValue := Null;

      if (Components[I].ClassName = 'TRadioGroup') then
        TRadioGroup (Components[I]).ItemIndex := 0;

      if (Components[I].ClassName = 'TDateTimePicker') then
        TDateTimePicker (Components[I]).DateTime := Now;

      if (Components[I].ClassName = 'TTreeView') then
        TTreeView (Components[I]).Items.Clear;

       // Desativado em 18/08/17 fechando dbgrid ao inserir na Compossição
      //if (Components[I].ClassName = 'TDBGrid') then
        //TDBGrid (Components[I]).DataSource.DataSet.Close;
    end;
  End;

end;

procedure TFr_Base.CarregaImagemBotao(Sb: TSpeedButton;Fc_Operacao: String);
Var
  St_Image:TStream;
  St_BMP :TBitmap;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(Concat(
                'SELECT OPF_IMAGEM ',
                'FROM TB_OPER_INTERFACE ',
                'WHERE OPF_DESCRICAO =:OPF_DESCRICAO '
      ));
      ParamByName('OPF_DESCRICAO').AsAnsiString :=  Fc_Operacao;
      Active := True;
      FetchAll;
      First;
      if recordCount > 0 then
      Begin
        St_Image := CreateBlobStream(FieldByName('OPF_IMAGEM'),bmRead);
        if St_Image.Size > 0 then
        begin
          St_BMP := TBitmap.Create;
          St_BMP.LoadFromStream(St_Image);
          Sb.Glyph.Assign(St_BMP);
          St_BMP.disposeOf;
        end;
        St_Image.disposeOf;
      End;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure TFr_Base.CriarVariaveis;
begin
  Config := TControllerGeral.create(Self);
end;

procedure TFr_Base.AtivaTabelas;
begin
  //Será implementado nas classes Filhas
end;

procedure TFr_Base.IniciaProcesso;
begin
end;

procedure TFr_Base.IniciaVariaveis;
begin
  //Será implementado nas classes Filhas
end;

procedure TFr_Base.Sair1Click(Sender: TObject);
begin
  Close
end;

procedure TFr_Base.setPerfil;
begin

end;

procedure TFr_Base.FinalizaProcesso;
begin
end;

procedure TFr_Base.FinalizaVariaveis;
begin

end;

procedure TFr_Base.FormataTela;
begin
  //Será implementado nas classes Filhas
end;

procedure TFr_Base.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinalizaVariaveis;
end;

procedure TFr_Base.FormCreate(Sender: TObject);
begin
  CriarVariaveis;
end;

procedure TFr_Base.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
  begin
    case Key of
      VK_F1:execShorCutKeyF1;
      VK_F2:execShorCutKeyF2;
      VK_F3:execShorCutKeyF3;
      VK_F4:execShorCutKeyF4;
      VK_F5:execShorCutKeyF5;
      VK_F6:execShorCutKeyF6;
      VK_F7:execShorCutKeyF7;
      VK_F8:execShorCutKeyF8;
      VK_F9:execShorCutKeyF9;
      VK_F10:execShorCutKeyF10;
      VK_F11:execShorCutKeyF11;
      VK_F12:execShorCutKeyF12;
      VK_Escape:execShorCutEsc;
    end;
  end;
end;

procedure TFr_Base.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not ( (ActiveControl is TDBMemo) or (ActiveControl is TMemo) ) then
   Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TFr_Base.ImagemBotao;
Begin
  //Será implementado nas classes Filhas
end;

procedure TFr_Base.FormShow(Sender: TObject);
begin
  setPerfil;
  IniciaVariaveis;
  AtivaTabelas;
  FormataTela;
  ImagemBotao;
end;


end.
