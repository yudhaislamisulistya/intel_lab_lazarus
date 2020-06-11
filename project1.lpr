program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, Unit1, unitMain, About,
  unitDataKategori, unitDataRoom, unitDataItem, unitDataHistoryExport, unitRoomDetail;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormDataKategori, FormDataKategori);
  Application.CreateForm(TFormDataRoom, FormDataRoom);
  Application.CreateForm(TFormDataItem, FormDataItem);
  Application.CreateForm(TFormDataHistoryExport, FormDataHistoryExport);
  Application.CreateForm(TFormDataRoomDetail, FormDataRoomDetail);
  Application.Run;
end.

