unit base_frame_list;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, STQuery, STTransaction;

type
  TBaseFrameList = class(TFrame)
    L_Carteira: TLabel;
    pnl_linha_1: TPanel;
    Dblcb_Lista: TDBLookupComboBox;
    Sb_Carteira: TSpeedButton;
    Qr_Lista: TSTQuery;
    Ds_Lista: TDataSource;
    IBT_Lista: TSTTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses un_dm;

end.
