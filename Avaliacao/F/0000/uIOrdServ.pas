unit uIOrdServ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Data.DB, DateUtils;

type
  TFrmIncOrdServ = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Código: TLabel;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdTit: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBComboBox1: TDBComboBox;
    Panel3: TPanel;
    BtConfirmar: TButton;
    BtCancelar: TButton;
    DS: TDataSource;
    DBMDesc: TDBMemo;
    procedure BtCancelarClick(Sender: TObject);
    procedure BtConfirmarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIncOrdServ: TFrmIncOrdServ;

implementation

{$R *.dfm}

uses uDM;

procedure TFrmIncOrdServ.BtCancelarClick(Sender: TObject);
begin
  if DS.DataSet.State in [dsEdit, dsInsert] then //Verifica se está em edição ou inserçao para poder cancelar registro
    DS.DataSet.Cancel;
  Close;
end;

procedure TFrmIncOrdServ.BtConfirmarClick(Sender: TObject);
var
  zOk: Boolean;
  zDia, zMes, zAno, zHora, zMin, zSeg, zMs: Word;
begin
  zOk := True;
  //
  //Manutenções urgentes não podem ser criadas (nem via edição) após as 13:00 das sextas-feiras.
  if (DS.DataSet.FieldByName('tipo').AsString = 'Manutenção Urgente') and
     (DayOfTheWeek(Now) >= 5) then begin
    DecodeDateTime(Now, zAno, zMes, zDia, zHora, zMin, zSeg, zMs);
    //
    if (DayOfTheWeek(Now) = 5) and ( Now >= EncodeDatetime(zAno, zMes, zDia, 13, 0, 0, 0) ) then
      zOk := False;
    //
    if (zOk) and ( (DayOfTheWeek(Now) > 5) or ((DayOfTheWeek(Now) = 0)) ) then
      zOk := False;

    if not zOk then
      ShowMessage('Manutenções urgentes não podem ser criadas (nem via edição) após as 13:00 das sextas-feiras');
  end;
  //
  //botão confirma, verifica antes se os campos obrigatórios estão preenchido
  if (zOk) and (Trim(DS.DataSet.FieldByName('titulo').AsString)='') then begin
    zOk := False;
    ShowMessage('Preencher título da atividade!');
    DBEdTit.SetFocus;
  end;
  //
  if (zOk) and (Trim(DS.DataSet.FieldByName('descricao').AsString)='') then begin
    zOk := False;
    ShowMessage('Preencher descrição da atividade!');
    DBMDesc.SetFocus;
  end;
  //
  if zOk then begin
    DS.DataSet.Post;
    Close;
  end;
end;

procedure TFrmIncOrdServ.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Para não deixar sair da tela de inclusão/Edição, feche a tela acidentamente
  if DS.DataSet.State in [dsEdit, dsInsert] then begin
    ShowMessage('Registro de atividade em Inserção/Edição! Confirmar ou Cancelar as alteraçoes!');
    CanClose := False;
  end;
end;

end.
