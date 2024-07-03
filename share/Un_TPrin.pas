Unit Un_TPrin;

Interface

Uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,IniFiles,Math;//, SevFun;
Const
  FormFeed = #12;
  _PR_ON  = True;
  _PR_OFF = False;
Type
  TPrin = Class(TComponent)
  Private
    FCol,
    FRow:LongInt;
    Bitmap: TBitmap;
    Ini:TIniFile;
    Lst:TextFile;
  Protected
    Constructor Create(AOwner: TComponent);Override;
    Destructor Destroy;Override;
  Public
    Porta:string;
    Procedure TextOutCL(nCol,nRow:LongInt;Text:String);
    Procedure TextOutLC(nRow,nCol:LongInt;Text:String);
    Procedure Initialize(Porta:String);
    Procedure Finalize;
    Function PRow:LongInt;
    Function PCol:LongInt;
    Procedure NewPage;
    Procedure Eject;
    Procedure Reset;
    Procedure Sextos;
    Procedure Oitavos;
    Procedure SeteTetentaEDoisAvos;
    Procedure CPI_10;
    Procedure CPI_12;
    Procedure Condensa(bCondensa:Boolean);
    Procedure Negrito(bNegrito:Boolean);
    Procedure Beep;
    Procedure ComprimentoDeNota;
    Procedure ComprimentoDeDoc;
    Procedure AlimentaLinha;
    Procedure ComprimentoPorLinha;
    Procedure ComprimentoPorPolegada;
    procedure Expandido(Pc_Ativa : Boolean);
    procedure AcionaModoDraft;
    //Procedure Proprias
    function CentralizaTexto(Fc_Texto:String; fc_Coluna:Integer;Fc_Extra:String):String;
    function Pad(AValue: String; const ALength: Integer; const ASide: TAlignment): String;
    function PadL(AValue: String; const ALength: Integer): String;
    function PadR(AValue: String; const ALength: Integer): String;
  End;

Implementation




Constructor TPrin.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);
  Bitmap := TBitmap.Create;
  Bitmap.Handle := LoadBitmap(HInstance, 'TPrin');
End;

Destructor TPrin.Destroy;
Begin
  Bitmap.Free;
  Inherited Destroy;
End;

Procedure TPrin.NewPage;
Begin
  Write(Lst,FormFeed);
  FRow:=1;
  FCol:=1;
End;

Procedure TPrin.Eject;
Begin
  NewPage;
End;

Procedure TPrin.Finalize;
Begin
  CloseFile(Lst);
End;

Function TPrin.PRow:LongInt;
Begin
  Result:=FRow;
End;

Function TPrin.PCol:LongInt;
Begin
  Result:=FCol;
End;

Procedure TPrin.Initialize(Porta:String);
Begin
  FRow:=1;
  FCol:=1;
  AssignFile(Lst,Porta);
  Rewrite(Lst);
{InLine($8B/$1E/Lst/$B8/$00/$44/$CD/$21/$80/$CA/$20/$B6/$00/$B8/$01/$44/$CD/$21);}
End;

Procedure TPrin.TextOutCL(nCol,nRow:LongInt;Text:String);
  Var xRow,xCol:LongInt;
Begin
  {Teste de próxima página}
  If nRow=FRow Then
    Begin
      For xCol:=1 To nCol-FCol Do
      Begin
        Write(Lst,' ');
        Inc(FCol);
      End
    End
  Else
    Begin
      FCol:=1;
      For xRow:=1 To nRow-FRow Do
      Begin
        WriteLn(Lst,' ');
        Inc(FRow);
      End;
      For xCol:=1 To nCol Do
      Begin
        If xCol>FCol Then
        Begin
          Write(Lst,' ');
          Inc(FCol);
        End;
      End
    End;
  Inc(FCol,Length(Text));
  Write(Lst,Text);
End;

Procedure TPrin.TextOutLC(nRow,nCol:LongInt;Text:String);
  Var xRow,xCol:LongInt;
Begin
  {Teste de próxima página}
  If nRow=FRow Then
  Begin
    For xCol:=1 To nCol-FCol Do
    Begin
      Write(Lst,' ');
      Inc(FCol);
    End
  end
  Else
  Begin
    FCol:=1;
    For xRow:=1 To nRow-FRow Do
    Begin
      WriteLn(Lst,'');
      Inc(FRow);
    End;
    For xCol:=1 To nCol Do
    Begin
      If xCol>FCol Then
      Begin
        Write(Lst,' ');
        Inc(FCol);
      End;
    End
  End;
  Inc(FCol,Length(Text));
  Write(Lst,Text);
End;

Procedure TPrin.Condensa(bCondensa:Boolean);
Begin
  If bCondensa Then
     Write(Lst,#15)
  Else
     Write(Lst,#18);
End;
Procedure TPrin.Negrito(bNegrito:Boolean);
Begin
    if bNegrito then
        Write(Lst,#27#71)
    else
        Write(Lst,#27#72);
end;

Procedure TPrin.Reset;
Begin
  Write(Lst,#27+'@');
End;

Procedure TPrin.Sextos;
Begin
  Write(Lst,#27+'2');
End;

Procedure TPrin.Oitavos;
Begin
  Write(Lst,#27+'0');
End;

Procedure TPrin.SeteTetentaEDoisAvos;
Begin
  Write(Lst,#27+'1');
End;

Procedure TPrin.CPI_10;
Begin
  Write(Lst,#27+'P');
End;

Procedure TPrin.CPI_12;
Begin
  Write(Lst,#27+'M');
End;

Procedure TPrin.Beep;
Begin
  Write(Lst,#7);
End;

Procedure TPrin.ComprimentoPorLinha;
Begin
  Write(Lst,#27+'C');
End;

Procedure TPrin.ComprimentoPorPolegada;
Begin
  Write(Lst,#27+'C'+'0');
End;

Procedure TPrin.ComprimentoDeNota;
Begin
  Write(Lst,#27+'2'); //sextos
  Write(Lst,#27+'C'+' '); // comprimento por polegada
  Write(Lst,#27+'P'); //10 cpi
End;

Procedure TPrin.ComprimentoDeDoc;
Begin
  Write(Lst,#27+#48); //sextos
  Write(Lst,#27+#67+' '); //comprimento por polegada
  Write(Lst,#27+#77); // seleciona 12 cpi

// Este chegou mais perto!!!
{
  Write(Lst,#27+#48); //oitavos
//  Write(Lst,#27+#67); //comprimento por linha
  Write(Lst,#27+#67+' '); //comprimento por polegada
  Write(Lst,#27+#77); // seleciona 12 cpi
}
End;

Procedure TPrin.AlimentaLinha;
Begin
  Write(Lst,#27+#10);
End;

procedure TPrin.Expandido(Pc_Ativa : Boolean);
Begin
  if Pc_Ativa then
    Write(Lst,#27+'W1')
  else
    Write(Lst,#27+'W0');
end;

Procedure TPrin.AcionaModoDraft;
Begin
  Write(Lst,#27#120#0);
end;

function TPrin.CentralizaTexto(Fc_Texto:String; fc_Coluna:Integer;Fc_Extra:String):String;
Var
  Lc_I : Integer;
  Lc_Final : Real;
  Lc_string : String;
Begin
  //Nome a ser impresso no cupom
  Lc_string := Fc_Texto;
  Lc_Final := ((fc_coluna -Length(Lc_string))/2) - 2;
  Lc_string := '';
  For Lc_I := 1 to Floor(Lc_Final) do
    Lc_string := Lc_string + Fc_Extra;
  Lc_string := Lc_string + ' ' + Fc_Texto + ' ';
  For Lc_I := 1 to (fc_coluna-Length(Lc_string)) do
      Lc_string := Lc_string + Fc_Extra;
  Result := Lc_string;
end;

function TPrin.Pad(AValue: String; const ALength: Integer; const ASide: TAlignment): String;
begin
  AValue := Trim(AValue);
  if Length(AValue) > ALength then AValue := Copy(AValue,1,ALength);
  case ASide of
    taLeftJustify:
      while Length(AValue) < ALength do AValue := AValue + ' ';
    taRightJustify:
      while Length(AValue) < ALength do AValue := ' ' + AValue;
    taCenter:
      while Length(AValue) < ALength do
        if (Length(AValue) mod 2)=0 then
          AValue := AValue + ' '
        else
          AValue := ' ' + AValue;
  end;
  Result := AValue;
end;


function TPrin.PadL(AValue: String; const ALength: Integer): String;
begin
  Result := Pad(AValue, ALength, taLeftJustify);
end;

function TPrin.PadR(AValue: String; const ALength: Integer): String;
begin
  Result := Pad(AValue, ALength, taRightJustify);
end;

End.
