object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 318
  Width = 281
  object IBD_Gestao: TSTDatabase
    Params.Strings = (
      'Database=D:\Modelos\HbAutocenter\Database\IBGCOM.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=127.0.0.1'
      'Protocol=TCPIP'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    LoginPrompt = False
    DatabaseName = 'NOTEVALDO/3050:D:\Modelos\HbAutocenter\Database\IBGCOM.FDB'
    Left = 36
    Top = 6
  end
  object IB_Transacao: TSTTransaction
    Connection = IBD_Gestao
    Left = 36
    Top = 73
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 216
    Top = 16
  end
  object DriverLink: TFDPhysFBDriverLink
    Left = 128
    Top = 16
  end
end
