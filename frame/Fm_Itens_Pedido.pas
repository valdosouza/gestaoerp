unit Fm_Itens_Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Data.DB,
  IBX.IBCustomDataSet, STQuery, IBX.IBQuery;

type
  TFrame1 = class(TFrame)
    StringGrid1: TStringGrid;
    Qr_ItensNota: TSTQuery;
  private
    { Private declarations }
    procedure Pc_FormataTela;
    procedure Pc_AtivaTabela;
    procedure Pc_PreencheGrade;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TFrame1.Pc_AtivaTabela;
begin

end;

procedure TFrame1.Pc_FormataTela;
begin

end;

procedure TFrame1.Pc_PreencheGrade;
begin

end;

end.
