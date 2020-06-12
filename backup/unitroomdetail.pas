unit unitRoomDetail;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql56conn, sqldb, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Grids, fpsexport;

type

  { TFormDataRoomDetail }

  TFormDataRoomDetail = class(TForm)
    FPSExport1: TFPSExport;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    LTitle: TLabel;
    MySQL56Connection1: TMySQL56Connection;
    Panel1: TPanel;
    SaveDialog1: TSaveDialog;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private

  public
    queryStr: String;

  end;

var
  FormDataRoomDetail: TFormDataRoomDetail;

implementation

{$R *.lfm}

{ TFormDataRoomDetail }





procedure TFormDataRoomDetail.Image1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
       FPSExport1.FileName:=SaveDialog1.FileName;
       FPSExport1.Execute;
       try
        begin
        SQLQuery2.Close;
        SQLQuery2.SQL.Clear;
        SQLQuery2.SQL.Text:='INSERT INTO tbl_history_export (detail_name, file) VALUES (:detail_name, :file)';
        SQLQuery2.Params.ParamByName('detail_name').AsString:='Data Room Detail';
        SQLQuery2.Params.ParamByName('file').AsString:=SaveDialog1.FileName;
        SQLQuery2.ExecSQL;
        SQLTransaction1.Commit;
        end;
      except
        on E : Exception do
          ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
      end;
  end;
end;

procedure TFormDataRoomDetail.FormCreate(Sender: TObject);
begin
  BorderIcons := BorderIcons - [biMaximize]
  SQLQuery2.SQL.Text:=queryStr;
  SQLQuery2.Open;
  SQLQuery2.Active:=True;
end;

end.

