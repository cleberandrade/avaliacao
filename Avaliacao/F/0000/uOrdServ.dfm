object FrmAtividades: TFrmAtividades
  Left = 0
  Top = 0
  Caption = 'Controle de Atividades'
  ClientHeight = 458
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 563
    Top = 0
    Width = 89
    Height = 417
    Align = alRight
    TabOrder = 0
    object BtNovo: TButton
      Left = 6
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 0
      OnClick = BtNovoClick
    end
    object BtAlterar: TButton
      Left = 6
      Top = 39
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = BtAlterarClick
    end
    object BtFinalizar: TButton
      Left = 6
      Top = 70
      Width = 75
      Height = 25
      Caption = 'Finalizar'
      TabOrder = 2
      OnClick = BtFinalizarClick
    end
    object BtExcluir: TButton
      Left = 6
      Top = 132
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 3
      OnClick = BtExcluirClick
    end
    object BtFechar: TButton
      Left = 6
      Top = 195
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 4
      OnClick = BtFecharClick
    end
    object BtConsultar: TButton
      Left = 6
      Top = 164
      Width = 75
      Height = 25
      Caption = 'Consultar'
      TabOrder = 5
      OnClick = BtConsultarClick
    end
    object BtReabrir: TButton
      Left = 6
      Top = 101
      Width = 75
      Height = 25
      Caption = 'ReAbrir'
      TabOrder = 6
      OnClick = BtReabrirClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 417
    Width = 652
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 563
    Height = 417
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 561
      Height = 56
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 169
        Height = 56
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 41
          Height = 13
          Caption = 'Situa'#231#227'o'
        end
        object CBSituacao: TComboBox
          Left = 8
          Top = 24
          Width = 145
          Height = 21
          TabOrder = 0
          Text = 'Abertas'
          OnChange = CBSituacaoChange
          Items.Strings = (
            'Abertas'
            'Finalizadas'
            'Todas')
        end
      end
    end
    object DBGAtividades: TDBGrid
      Left = 1
      Top = 57
      Width = 561
      Height = 359
      Align = alClient
      DataSource = DS
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = BtConsultarClick
      Columns = <
        item
          Expanded = False
          FieldName = 'codigo'
          Width = 38
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sit'
          Title.Caption = 'Sit'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tipo'
          Width = 97
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'titulo'
          Width = 350
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Width = 600
          Visible = True
        end>
    end
  end
  object DS: TDataSource
    DataSet = DM.QyAtividades
    OnDataChange = DSDataChange
    Left = 176
    Top = 8
  end
end
