unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  IniFiles, Dialogs, Forms;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    QyAtividades: TFDQuery;
    QyAtividadescodigo: TIntegerField;
    QyAtividadestitulo: TWideStringField;
    QyAtividadesdescricao: TWideStringField;
    QyAtividadestipo: TWideStringField;
    QyAtividadessit: TWideStringField;
    procedure QyAtividadesNewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

  zSQLAtividades: WideString = 'SELECT Codigo,Titulo,Descricao, Tipo, Sit FROM atividades ';

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  zIni: TIniFile;
  zServidor, zBanco, zPorta, zUsuario, zSenha: String;
begin
  FDConnection1.Close;
  zIni := TIniFile.Create(ExtractFilePath(ParamStr(0))+'config.ini');
  zServidor := zIni.ReadString('CONFIGURACAO', 'SERVIDOR', '');
  zBanco := zIni.ReadString('CONFIGURACAO', 'BANCO', '');
  zPorta := zIni.ReadString('CONFIGURACAO', 'PORTA', '');
  zUsuario := zIni.ReadString('CONFIGURACAO', 'USUARIO', '');
  zSenha := zIni.ReadString('CONFIGURACAO', 'SENHA', '');

  if Trim(zServidor)<> '' then
    FDConnection1.Params.Values['Server'] := zServidor;

  if Trim(zPorta)<> '' then
    FDConnection1.Params.Values['Port'] := zPorta;

  if Trim(zBanco)<> '' then
    FDConnection1.Params.Values['Database'] := zBanco;

  if Trim(zUsuario)<> '' then
    FDConnection1.Params.Values['UserName'] := zUsuario;

  if Trim(zSenha)<> '' then
    FDConnection1.Params.Values['Password'] := zSenha;

  try
    FDConnection1.Open;
   except
    on E: Exception do begin
      ShowMessage('Erro ao conectar no banco de dados: ' + E.Message);
      Application.Terminate;
    end;
  end;

end;

procedure TDM.QyAtividadesNewRecord(DataSet: TDataSet);
begin
  //Campos que necessitam ser preenchdiso automaticos ao incluir novo registro na tabela
  with TFDQuery.Create(Self) do try
    Connection := FDConnection1;
    SQL.Text := 'SELECT MAX(codigo) FROM atividades';
    Open;
    QyAtividadescodigo.AsInteger := Fields[0].AsInteger + 1;
    Close;
   finally
    Free;
  end;
  QyAtividadessit.AsString := 'A';
  QyAtividadestipo.AsString := 'Desenvolvimento';
end;

end.

{ Scritp da Tabela

	create Table atividades (
	Codigo Integer not null,
	Titulo Varchar(50),
	Descricao Varchar(250),
	Tipo Varchar(20) not null,
	Sit Varchar(1) Not null,
	Primary Key (Codigo));

}
