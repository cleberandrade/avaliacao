object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 316
  Width = 429
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=Trier'
      'User_Name=postgres'
      'Password=123'
      'Port='
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 72
    Top = 32
  end
  object QyAtividades: TFDQuery
    OnNewRecord = QyAtividadesNewRecord
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT Codigo,Titulo,Descricao, Tipo, Sit FROM atividades ')
    Left = 72
    Top = 80
    object QyAtividadescodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object QyAtividadestitulo: TWideStringField
      DisplayLabel = 'T'#237'tulo'
      FieldName = 'titulo'
      Size = 50
    end
    object QyAtividadesdescricao: TWideStringField
      DisplayLabel = 'Descricao'
      FieldName = 'descricao'
      Size = 250
    end
    object QyAtividadestipo: TWideStringField
      DisplayLabel = 'Tipo'
      FieldName = 'tipo'
    end
    object QyAtividadessit: TWideStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'sit'
      Size = 1
    end
  end
end
