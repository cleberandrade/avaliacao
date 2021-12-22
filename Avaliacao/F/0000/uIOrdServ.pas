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
    C�digo: TLabel;
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
  if DS.DataSet.State in [dsEdit, dsInsert] then //Verifica se est� em edi��o ou inser�ao para poder cancelar registro
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
  //Manuten��es urgentes n�o podem ser criadas (nem via edi��o) ap�s as 13:00 das sextas-feiras.
  if (DS.DataSet.FieldByName('tipo').AsString = 'Manuten��o Urgente') and
     (DayOfTheWeek(Now) >= 5) then begin
    DecodeDateTime(Now, zAno, zMes, zDia, zHora, zMin, zSeg, zMs);
    //
    if (DayOfTheWeek(Now) = 5) and ( Now >= EncodeDatetime(zAno, zMes, zDia, 13, 0, 0, 0) ) then
      zOk := False;
    //
    if (zOk) and ( (DayOfTheWeek(Now) > 5) or ((DayOfTheWeek(Now) = 0)) ) then
      zOk := False;

    if not zOk then
      ShowMessage('Manuten��es urgentes n�o podem ser criadas (nem via edi��o) ap�s as 13:00 das sextas-feiras');
  end;
  //
  //bot�o confirma, verifica antes se os campos obrigat�rios est�o preenchido
  if (zOk) and (Trim(DS.DataSet.FieldByName('titulo').AsString)='') then begin
    zOk := False;
    ShowMessage('Preencher t�tulo da atividade!');
    DBEdTit.SetFocus;
  end;
  //
  if (zOk) and (Trim(DS.DataSet.FieldByName('descricao').AsString)='') then begin
    zOk := False;
    ShowMessage('Preencher descri��o da atividade!');
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
  //Para n�o deixar sair da tela de inclus�o/Edi��o, feche a tela acidentamente
  if DS.DataSet.State in [dsEdit, dsInsert] then begin
    ShowMessage('Registro de atividade em Inser��o/Edi��o! Confirmar ou Cancelar as altera�oes!');
    CanClose := False;
  end;
end;

end.
