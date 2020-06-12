unit unitDataLabel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql56conn, sqldb, db, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, DBGrids, Menus, fpsexport;

type

  { TFormDataLabel }

  TFormDataLabel = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FPSExport1: TFPSExport;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    MenuItem1: TMenuItem;
    MySQL56Connection1: TMySQL56Connection;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private

  public

  end;

var
  FormDataLabel: TFormDataLabel;
  code_room: String;
  code_category: String;

implementation

{$R *.lfm}

{ TFormDataLabel }

procedure TFormDataLabel.MenuItem1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
       FPSExport1.FileName:=SaveDialog1.FileName;
       FPSExport1.Execute;
       try
        begin
        SQLQuery2.Close;
        SQLQuery2.SQL.Clear;
        SQLQuery2.SQL.Text:='INSERT INTO tbl_history_label (name) VALUES (:name)';
        SQLQuery2.Params.ParamByName('name').AsString:=SaveDialog1.FileName;
        SQLQuery2.ExecSQL;
        SQLTransaction1.Commit;
        ShowMessage('Data Berhasil di Generate');
        end;
      except
        on E : Exception do
          ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
      end;
  end;
end;

procedure TFormDataLabel.DBGrid1CellClick(Column: TColumn);
begin
  code_room:=SQLQuery1.FieldByName('code_room').AsString;
  code_category:=SQLQuery1.FieldByName('code_category').AsString;
  SQLQuery3.SQL.Text:='SELECT "LABFIK", code_room, code_category, order_by, SUBSTRING(date, 1, 4) FROM tbl_items WHERE code_room = :code_room AND code_category = :code_category';
  SQLQuery3.Params.ParamByName('code_room').AsString:=code_room;
  SQLQuery3.Params.ParamByName('code_category').AsString:=code_category;
  SQLQuery3.Open;
  SQLQuery3.Active:=True;
end;

procedure TFormDataLabel.FormCreate(Sender: TObject);
begin
  BorderIcons := BorderIcons - [biMaximize];
end;

end.

