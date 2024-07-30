unit Un_Fm_Cardapio;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Un_Fm_CardapioPanel, Data.DB, IBX.IBCustomDataSet, STQuery,
  Vcl.Menus, IBX.IBQuery;

type
  TFm_Cardapio = class(TFrame)
    Pg_Geral: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Fm_Sabor: TFm_CardapioPanel;
    Fm_CardapioPanel1: TFm_CardapioPanel;
    Qr_Tamanho: TSTQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
