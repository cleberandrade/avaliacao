object FrmIncOrdServ: TFrmIncOrdServ
  Left = 0
  Top = 0
  ActiveControl = DBComboBox1
  BorderIcons = [biSystemMenu]
  Caption = 'Incluir Atividades'
  ClientHeight = 281
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 397
    Height = 242
    Align = alClient
    TabOrder = 0
    object Código: TLabel
      Left = 16
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label1: TLabel
      Left = 16
      Top = 59
      Width = 26
      Height = 13
      Caption = 'T'#237'tulo'
    end
    object Label2: TLabel
      Left = 16
      Top = 102
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label3: TLabel
      Left = 64
      Top = 16
      Width = 83
      Height = 13
      Caption = 'Tipo da Atividade'
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 32
      Width = 33
      Height = 21
      DataField = 'codigo'
      DataSource = DS
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdTit: TDBEdit
      Left = 16
      Top = 75
      Width = 370
      Height = 21
      DataField = 'titulo'
      DataSource = DS
      TabOrder = 2
    end
    object DBComboBox1: TDBComboBox
      Left = 64
      Top = 32
      Width = 161
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'tipo'
      DataSource = DS
      Items.Strings = (
        'Desenvolvimento'
        'Atendimento'
        'Manuten'#231#227'o'
        'Manuten'#231#227'o Urgente')
      TabOrder = 1
    end
    object DBMDesc: TDBMemo
      Left = 16
      Top = 119
      Width = 370
      Height = 89
      DataField = 'descricao'
      DataSource = DS
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 242
    Width = 397
    Height = 39
    Align = alBottom
    TabOrder = 1
    object Panel3: TPanel
      Left = 212
      Top = 1
      Width = 184
      Height = 37
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object BtConfirmar: TButton
        Left = 7
        Top = 5
        Width = 75
        Height = 25
        Caption = 'Confirmar'
        TabOrder = 0
        OnClick = BtConfirmarClick
      end
      object BtCancelar: TButton
        Left = 95
        Top = 5
        Width = 75
        Height = 25
        Caption = 'Cancelar'
        TabOrder = 1
        OnClick = BtCancelarClick
      end
    end
  end
  object DS: TDataSource
    AutoEdit = False
    DataSet = DM.QyAtividades
    Left = 232
    Top = 16
  end
end
