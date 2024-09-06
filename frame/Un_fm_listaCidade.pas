unit Un_fm_listaCidade;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  STQuery, Vcl.DBCtrls, Vcl.Buttons, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFmListaCidades = class(TFrame)
    Municipio: TLabel;
    Sb_Cidade: TSpeedButton;
    DBLCB_CIDADE: TDBLookupComboBox;
    Qr_Cidade: TSTQuery;
    Ds_Cidade: TDataSource;
    procedure DBLCB_CIDADEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    Estado : String;
    procedure Pc_Listar;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TFmListaCidades.DBLCB_CIDADEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Cidade.KeyValue := Null;
      end;
    end;
end;

procedure TFmListaCidades.Pc_Listar;
begin
  with Qr_Cidade do
  Begin
    Active := False;
    ParamByName('CDD_UF').AsString := Estado;
    Active := True;
    FetchAll;
  End;
end;

end.
