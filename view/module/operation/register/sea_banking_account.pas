unit sea_banking_account;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaBankingAccount = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Lb_BuscaAgencia: TLabel;
    Lb_BuscaConta: TLabel;
    Lb_BuscaBanco: TLabel;
    E_BuscaAgencia: TEdit;
    E_BuscaConta: TEdit;
    E_BuscaBanco: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaBankingAccount: TSeaBankingAccount;

implementation

{$R *.dfm}

end.
