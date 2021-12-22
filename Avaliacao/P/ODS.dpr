program ODS;

uses
  Vcl.Forms,
  uOrdServ in '..\F\0000\uOrdServ.pas' {FrmAtividades},
  uDM in '..\F\0000\uDM.pas' {DM: TDataModule},
  uIOrdServ in '..\F\0000\uIOrdServ.pas' {FrmIncOrdServ};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmAtividades, FrmAtividades);
  Application.CreateForm(TFrmIncOrdServ, FrmIncOrdServ);
  Application.Run;
end.
