unit Un_Fm_ListaMultiEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, STDatabase, STTransaction,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  base_frame_list;

type
  TFm_ListaMultiEmpresa = class(TBaseFrameList)
    chbx_Empresas: TCheckBox;
    procedure chbx_EmpresasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Listar(Order:String);
    Procedure HabilitarMultiEmpresa;
  end;

implementation

{$R *.dfm}

uses Un_DM, env;

procedure TFm_ListaMultiEmpresa.Listar(Order:String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_Lista do
  Begin
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                 ' EMP_CODIGO, '+
                 ' EMP_NOME, '+
                 ' EMP_FANTASIA, '+
                 ' EMP_CODVDOR, '+
                 ' EMP_DT_FUNDA, '+
                 ' EMP_MULTIPLICADOR, '+
                 ' EMP_CONSUMIDOR '+
                 'FROM TB_EMPRESA '+
                  'WHERE (EMP_ATIVA = ''S'') and (EMP_TIPO = ''0'') ';

    IF Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
    Dblcb_Lista.KeyValue := Gb_CodMha;
  end;
end;

Procedure TFm_ListaMultiEmpresa.HabilitarMultiEmpresa;
Var
  Lc_Nivel : Integer;
begin
  IF chbx_Empresas.Checked then
  Begin
    Dblcb_Lista.KeyValue := Null;
    Dblcb_Lista.Enabled := False;
  end
  else
  Begin
    Listar('EMP_NOME');
    Dblcb_Lista.Enabled := True;
    Dblcb_Lista.KeyValue := Gb_CodMha;
  End;
end;

procedure TFm_ListaMultiEmpresa.chbx_EmpresasClick(Sender: TObject);
begin
  HabilitarMultiEmpresa;
end;

end.
