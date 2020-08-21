object UniMainModule: TUniMainModule
  OldCreateOrder = False
  Theme = 'material'
  MonitoredKeys.Keys = <>
  Height = 446
  Width = 372
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=LOCALHOST/3050:C:\Users\Ismael\Programas_Delphi\Layout_' +
        'uniGUI\LAYOUT_BD.GDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvGeneratorName, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields, uvAutoCommitUpdates]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.GeneratorName = 'ALUMNOS_GENERATOR'
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.AutoCommitUpdates = True
    Connected = True
    Left = 87
    Top = 48
  end
  object ADusuarios: TFDQuery
    Connection = FDConnection1
    Left = 88
    Top = 128
  end
  object ADConexionCAI: TFDConnection
    Left = 168
    Top = 208
  end
  object ADConexionGeneral: TFDConnection
    Left = 176
    Top = 296
  end
end
