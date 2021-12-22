unit uOrdServ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmAtividades = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    BtNovo: TButton;
    BtAlterar: TButton;
    BtFinalizar: TButton;
    BtExcluir: TButton;
    BtFechar: TButton;
    Panel4: TPanel;
    DBGAtividades: TDBGrid;
    Panel5: TPanel;
    CBSituacao: TComboBox;
    Label1: TLabel;
    BtConsultar: TButton;
    BtReabrir: TButton;
    DS: TDataSource;
    procedure BtFecharClick(Sender: TObject);
    procedure BtNovoClick(Sender: TObject);
    procedure BtAlterarClick(Sender: TObject);
    procedure BtConsultarClick(Sender: TObject);
    procedure CBSituacaoChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtExcluirClick(Sender: TObject);
    procedure BtReabrirClick(Sender: TObject);
    procedure BtFinalizarClick(Sender: TObject);
    procedure DSDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAtividades: TFrmAtividades;

implementation

{$R *.dfm}

uses uDM, uIOrdServ;

procedure TFrmAtividades.BtAlterarClick(Sender: TObject);
begin
  //Mostrar formulario de cadastro em modo edição
  FrmIncOrdServ := TFrmIncOrdServ.Create(Self);
  try
    DM.QyAtividades.Edit;
    FrmIncOrdServ.ShowModal;
   finally
    FrmIncOrdServ.Free;
  end;
end;

procedure TFrmAtividades.BtConsultarClick(Sender: TObject);
begin
  //Abre formuario de casdastro somente mostrando as informações na tela
  FrmIncOrdServ := TFrmIncOrdServ.Create(Self);
  try
    FrmIncOrdServ.BtConfirmar.Visible := False;
    FrmIncOrdServ.BtCancelar.Caption := 'Fechar';
    FrmIncOrdServ.ShowModal;
   finally
    FrmIncOrdServ.Free;
  end;
end;

procedure TFrmAtividades.BtExcluirClick(Sender: TObject);
var
  zOk: Boolean;
begin
  zOk := True;
  //
  if DS.DataSet.FieldByName('tipo').AsString = 'Manutenção Urgente' then begin
    zOk := False;
    ShowMessage('Atividades de manutenção urgente não podem ser removidas, apenas finalizadas!');
  end;
  //
  if (zOK) and (MessageDlg('Deseja excluir a Atividade selecionada?', TMsgDlgType.mtConfirmation, mbOkCancel, 0, mbCancel) = mrOk) then begin
    DM.QyAtividades.Delete;
  end;
end;

procedure TFrmAtividades.BtFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmAtividades.BtFinalizarClick(Sender: TObject);
var
  zOk, zLast: Boolean;
  zVoltar: TBookMark;
begin
  zOk := True;
  zLast := False;
  //
  if ( (DS.DataSet.FieldByName('tipo').AsString = 'Manutenção Urgente') or
       (DS.DataSet.FieldByName('tipo').AsString = 'Manutenção Urgente') ) then begin
    if Length(Trim(DS.DataSet.FieldByName('descricao').AsString)) < 50 then begin
      ShowMessage('Atividades de atendimento e manutenção urgente não podem ser finalizadas se a descrição estiver preenchida com menos de 50 caracteres!');
      zOk := False;
    end;
  end;
  //
  if (zOk) and (MessageDlg('Deseja Finalizar a Atividade selecionada?', TMsgDlgType.mtConfirmation, mbOkCancel, 0, mbCancel) = mrOk) then begin
    zVoltar := Ds.DataSet.Bookmark;
    Ds.DataSet.Edit;
    Ds.DataSet.FieldbyName('sit').AsString := 'F';
    Ds.DataSet.Post;
    //
    Ds.DataSet.Next;
    if Ds.DataSet.Eof then
      zLast := True; //Variavel zLast é usando para verificar se esta no ultimo registro,
                     //evitando erro de except ao retornar posição da tabela
    //
    Ds.DataSet.Close;
    Ds.DataSet.Open;
    //
    if (Ds.DataSet.RecordCount > 0) then begin
      if not zLast then
        Ds.DataSet.GotoBookmark(zVoltar)
       else
        Ds.DataSet.Last;
    end;
  end;
end;

procedure TFrmAtividades.BtNovoClick(Sender: TObject);
begin
  //Mostra formulario de casdastro em modo inserçao
  FrmIncOrdServ := TFrmIncOrdServ.Create(Self);
  try
    DM.QyAtividades.Append;
    FrmIncOrdServ.ShowModal;
   finally
    FrmIncOrdServ.Free;
  end;
end;

procedure TFrmAtividades.BtReabrirClick(Sender: TObject);
var
  zVoltar: TBookmark;
  zLast: Boolean;
begin
  if  MessageDlg('Deseja Reabrir a Atividade selecionada?', TMsgDlgType.mtConfirmation, mbOkCancel, 0, mbCancel) = mrOk then begin
    zVoltar := Ds.DataSet.Bookmark;
    zLast := False;
    Ds.DataSet.Edit;
    Ds.DataSet.FieldbyName('sit').AsString := 'A';
    Ds.DataSet.Post;
    //
    Ds.DataSet.Next;
    if Ds.DataSet.Eof then
      zLast := True; //Variavel zLast é usando para verificar se esta no ultimo registro,
                     //evitando erro de except ao retornar posição da tabela
    Ds.DataSet.Close;
    Ds.DataSet.Open;
    //
    if (Ds.DataSet.RecordCount > 0) then begin
      if not zLast then
        Ds.DataSet.GotoBookmark(zVoltar)
       else
        Ds.DataSet.Last;
    end;
  end;
end;

procedure TFrmAtividades.CBSituacaoChange(Sender: TObject);
begin
  //Selecionar os dados conforme o Index do combobox situação
  //Para todos, somente executa o sql da variavel zSQLAtividades
  DM.QyAtividades.Close;
  DM.QyAtividades.SQL.TExt := zSQLAtividades;
  if CBSituacao.ItemIndex = 0 then
    begin
      DM.QyAtividades.SQL.Add('WHERE sit = ''A'' ');
      BtFinalizar.Enabled := True;
      BtReabrir.Enabled := False;
    end
   else
    if CBSituacao.ItemIndex = 1 then
      begin
        DM.QyAtividades.SQL.Add('WHERE sit = ''F'' ');
        BtFinalizar.Enabled := False;
        BtReabrir.Enabled := True;
      end;
  DM.QyAtividades.SQL.Add('ORDER BY codigo ');
  DM.QyAtividades.Open;
end;

procedure TFrmAtividades.DSDataChange(Sender: TObject; Field: TField);
begin
  //Habilitar o botão de finalizar e reabrir conforme o registro selecionado
  BtFinalizar.Enabled := ds.DataSet.FieldByName('sit').AsString = 'A';
  BtReabrir.Enabled := ds.DataSet.FieldByName('sit').AsString = 'F';
end;

procedure TFrmAtividades.FormActivate(Sender: TObject);
begin
  //SQL para abrir os registros abertos
  DM.QyAtividades.Close;
  DM.QyAtividades.SQL.TExt := zSQLAtividades;
  DM.QyAtividades.SQL.Add('WHERE sit = ''A'' ');
  DM.QyAtividades.SQL.Add('ORDER BY codigo ');
  DM.QyAtividades.Open;
end;

procedure TFrmAtividades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.QyAtividades.Close;
  DM.Fdconnection1.Close;
end;

end.
