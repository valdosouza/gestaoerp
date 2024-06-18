unit QEdit_Setes;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls, DB, Buttons,
   jpeg, IniFiles, Menus;

type
  TEdit_Setes = class(TMaskEdit)
  private
    { Private declarations }
    FAlignment: TAlignment;
    FIsFone:Boolean;
    FIsCodigo:Boolean;
    procedure SetAlignment(Value: TAlignment);

  protected
    { Protected declarations }
    procedure Enter(Sender: TObject);
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published

    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property IsFone: Boolean read FIsFone write FIsFone
      default false;
    property IsCodigo: Boolean read FIsCodigo write FIsCodigo
      default false;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TEdit_Setes]);
end;

procedure TEdit_Setes.Enter(Sender: TObject);
begin
  TEdit_Setes(Sender).SelectAll;
end;

procedure TEdit_Setes.KeyPress(var Key: Char);
var
  tText: string;
begin
  if SelLength <> Length(Text) then
    tText := Text
  else
    tText := EmptyStr;
  if IsCodigo then
  Begin
    if Key in ['0'..'9',#08,#13] then
      inherited KeyPress(Key)
    else
      Key := #0;
  end
  else
  Begin
    if (key in ['0'..'9',',',#8,#$D]) then
      inherited KeyPress(Key)
    else
      Key := #0;
  end;
end;

procedure TEdit_Setes.KeyUp(var Key: Word; Shift: TShiftState);
var
  Lc_Text: string;
begin
  if FIsFone then
  BEgin
    Lc_Text := Text;
    Lc_Text := stringReplace(Lc_Text, '-', '', []);
    Lc_Text := stringReplace(Lc_Text, '-', '', []);
    Lc_Text := stringReplace(Lc_Text, '(', '', []);
    Lc_Text := stringReplace(Lc_Text, ')', '', []);
    Lc_Text := stringReplace(Lc_Text, ' ', '', []);
    if (Copy(Lc_Text,1,4) = '0800')OR (Copy(Lc_Text,1,4) = '0300') then
    Begin//0800-41-1910
      MaxLength := 13;
      case Length(Lc_Text) of
        5..6:Text := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,2);
        7..10:Text := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,2) + '-' + Copy(Lc_Text,7,4);
        11:Text := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,3) + '-' + Copy(Lc_Text,8,4);
      else
        Text := Lc_Text;
      end;
    end
    else
    Begin
      MaxLength := 15;
      case Length(Lc_Text) of
        5..8:   Begin
                  case Length(Lc_Text) of
                    5:Text := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,1);
                    6:Text := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,2);
                    7:Text := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,3);
                    8:Text := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,4);
                  end;
                end;
        9:      Begin
                  Text := Copy(Lc_Text,1,5) + '-' + Copy(Lc_Text,6,4);
                end;
        10..11: Begin
                  case Length(Lc_Text) of
                    10:Text := '(' + Copy(Lc_Text,1,2) + ') ' + Copy(Lc_Text,3,4) + '-' + Copy(Lc_Text,7,4);
                    11:Text := '(' + Copy(Lc_Text,1,2) + ') ' + Copy(Lc_Text,3,5) + '-' + Copy(Lc_Text,8,4);
                  end;
               end;
      end;
    end;
    SelStart := Length(Text);
  end;
end;


procedure TEdit_Setes.CreateParams(var Params: TCreateParams);
const
  Alignments: array [TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'MASKEDIT');
  Params.Style := Params.Style and
    not (ES_AUTOVSCROLL or ES_AUTOHSCROLL) or ES_MULTILINE or
      Alignments[FAlignment];
end;

constructor TEdit_Setes.Create(AOwner: TComponent);
begin
  FAlignment := taLeftJustify;
  inherited Create(AOwner);
end;

procedure TEdit_Setes.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
    begin
    FAlignment := Value;
    RecreateWnd;
    end;
end;

end.
