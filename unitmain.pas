unit unitMain;

{$mode objfpc}{$H+}

interface

uses
  ShellAPI, Classes, SysUtils, sqldb, db, mysql56conn, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus, DBGrids, StdCtrls, Grids, unitDataBarang, About;

type

  { TFormMain }

  TFormMain = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MySQL56Connection1: TMySQL56Connection;
    SGDataKategori: TStringGrid;
    SQLQueryDataCategory: TSQLQuery;
    SQLQueryDataLab: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SQLTransaction2: TSQLTransaction;
    TotalDataKategori: TLabel;
    TotalDataLab: TLabel;
    SGDataLab: TStringGrid;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private

  public

  end;

var
  FormMain: TFormMain;

implementation
uses Unit1, unitDataKategori, unitDataRoom, unitDataItem, unitDataHistoryExport, unitRoomDetail;

{$R *.lfm}

{ TFormMain }

procedure reloadData(sql : TSQLQuery; grid : TStringGrid; total: TLabel);
var i,j,fc : Integer;
begin
  sql.Open;
  total.Caption:=IntToStr(sql.RecordCount);
  grid.FixedCols:=0;
  grid.RowCount:=sql.RecordCount + 1;
  fc:=sql.FieldCount;
  i:=1;
  sql.First;
  while sql.EOF = False do
  begin
    grid.Row:=i;
    for j := 0 to fc-1 do
    begin
      grid.Cells[j, i] := sql.Fields[j].AsString;
    end;
    sql.Next;
    Inc(i);
  end;
end;

procedure dataLab(sql : TSQLQuery; grid : TStringGrid; sqltext: String);
var i,j,fc : Integer;
begin
  sql.SQL.Text:=sqltext;
  sql.Open;
  grid.FixedCols:=0;
  grid.RowCount:=sql.RecordCount + 1;
  fc:=sql.FieldCount;
  i:=1;
  sql.First;
  while sql.EOF = False do
  begin
    grid.Row:=i;
    for j := 0 to fc-1 do
    begin
      grid.Cells[j, i] := sql.Fields[j].AsString;
    end;
    sql.Next;
    Inc(i);
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  reloadData(SQLQueryDataLab, SGDataLab, TotalDataLab);
  reloadData(SQLQueryDataCategory, SGDataKategori, TotalDataKategori);
end;



procedure TFormMain.Image3Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(Application.ExeName), nil, nil, 1);
  Application.Terminate;
end;

procedure TFormMain.MenuItem19Click(Sender: TObject);
begin
  FormMain.Close;
end;

procedure TFormMain.MenuItem20Click(Sender: TObject);
begin
  FormDataKategori.Show;
end;

procedure TFormMain.MenuItem21Click(Sender: TObject);
begin
  FormDataItem.Show;
end;

procedure TFormMain.MenuItem23Click(Sender: TObject);
begin
  FormDataHistoryExport.Show;
end;

procedure TFormMain.MenuItem24Click(Sender: TObject);
begin
  FormDataRoom.Show;
end;

procedure TFormMain.MenuItem5Click(Sender: TObject);
begin
  FormAbout.Show;
end;

procedure TFormMain.MenuItem6Click(Sender: TObject);
begin
  FormMain.Hide;
  FormLogin.Show;
end;

procedure TFormMain.MenuItem7Click(Sender: TObject);
begin

end;

procedure TFormMain.MenuItem8Click(Sender: TObject);
var i,j,fc : Integer;
begin
  FormDataRoomDetail.LTitle.Caption:='Data Ruangan RPL';
  dataLab(FormDataRoomDetail.SQLQuery1, FormDataRoomDetail.StringGrid1, 'SELECT id_items, code_room, code_category, detail_name, date, created_at, updated_at FROM tbl_items WHERE code_room = "RPL"');
  FormDataRoomDetail.ShowModal;
end;

end.

