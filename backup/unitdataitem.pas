unit unitDataItem;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql56conn, sqldb, db, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, DBGrids, MaskEdit, Menus, fpsexport, lrSpreadSheetExp, fpDBExport;

type

  { TFormDataItem }

  TFormDataItem = class(TForm)
    BTNReset: TButton;
    BTNSubmit: TButton;
    BTNUbah: TButton;
    CBRuangan: TComboBox;
    CBBarang: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ENama: TEdit;
    FPSExport1: TFPSExport;
    Image1: TImage;
    METanggal: TEdit;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MenuItem1: TMenuItem;
    MySQL56Connection1: TMySQL56Connection;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    SQLDataRuangan: TSQLQuery;
    SQLDataKategori: TSQLQuery;
    SQLDataItems: TSQLQuery;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure BTNSubmitClick(Sender: TObject);
    procedure BTNUbahClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FPSExport1ExportRow(Sender: TObject; var AllowExport: Boolean);
    procedure Image1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
private

  public

  end;

var
  FormDataItem: TFormDataItem;
  id_item: Integer;

implementation
uses
  unitMain;

{$R *.lfm}

{ TFormDataItem }

procedure reloadData(sql : TSQLQuery; combobox : TComboBox);
var i: Integer;
begin
  sql.Open;
  i:=1;
  sql.First;
  while sql.EOF = False do
  begin
    combobox.AddItem(sql.Fields[0].AsString, nil);
    sql.Next;
    Inc(i);
  end;
end;

procedure TFormDataItem.FormCreate(Sender: TObject);
begin
  reloadData(SQLDataRuangan, CBRuangan);
  reloadData(SQLDataKategori, CBBarang);
  DBGrid1.Columns[0].Title.Caption:='Nomor';
  DBGrid1.Columns[1].Title.Caption:='Kode Ruangan';
  DBGrid1.Columns[2].Title.Caption:='Kode Kategori';
  DBGrid1.Columns[3].Title.Caption:='Detail Nama';
  DBGrid1.Columns[4].Title.Caption:='Urutan';
  DBGrid1.Columns[5].Title.Caption:='Tanggal';
  DBGrid1.Columns[6].Title.Caption:='Tanggal Buat';
  DBGrid1.Columns[7].Title.Caption:='Tanggal Ubah';
end;

procedure TFormDataItem.FPSExport1ExportRow(Sender: TObject;
  var AllowExport: Boolean);
begin

end;

procedure TFormDataItem.Image1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
       FPSExport1.FileName:=SaveDialog1.FileName;
       FPSExport1.Execute;
       try
        begin
        SQLQuery1.Close;
        SQLQuery1.SQL.Clear;
        SQLQuery1.SQL.Text:='INSERT INTO tbl_history_export (detail_name, file) VALUES (:detail_name, :file)';
        SQLQuery1.Params.ParamByName('detail_name').AsString:='Data Item';
        SQLQuery1.Params.ParamByName('file').AsString:=SaveDialog1.FileName;
        SQLQuery1.ExecSQL;
        SQLTransaction1.Commit;
        ENama.Text:='';
        SQLDataItems.Open;
        SQLDataItems.Refresh;
        end;
      except
        on E : Exception do
          ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
      end;
  end;
end;


procedure TFormDataItem.Label1Click(Sender: TObject);
begin
  FormDataItem.Hide;
  FormMain.Show;
end;

procedure TFormDataItem.MenuItem1Click(Sender: TObject);
begin
  try
      SQLQuery1.Close;
      SQLQuery1.SQL.Clear;
      SQLQuery1.SQL.Text:='DELETE FROM tbl_items WHERE id_items = :id_item';
      SQLQuery1.Params.ParamByName('id_item').AsInteger:=id_item;
      SQLQuery1.ExecSQL;
      SQLTransaction1.Commit;
      ENama.Text:='';
      SQLDataItems.Open;
      SQLDataItems.Refresh;
      MessageDlg('Status', 'Data Berhasil Dihapus', mtInformation, [mbOK], 0, mbOK);
  except
    MessageDlg('Status', 'Data Gagal Dihapus', mtError, [mbOK], 0, mbOK)
  end;
end;

procedure TFormDataItem.BTNSubmitClick(Sender: TObject);
begin
  try
    begin
    SQLQuery1.Close;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Text:='INSERT INTO tbl_items (code_room, code_category, detail_name, date) VALUES (:code_room, :code_category, :detail_name, :date)';
    SQLQuery1.Params.ParamByName('code_room').AsString:=CBRuangan.Text;
    SQLQuery1.Params.ParamByName('code_category').AsString:=CBBarang.Text;
    SQLQuery1.Params.ParamByName('detail_name').AsString:=ENama.Text;
    SQLQuery1.Params.ParamByName('date').AsString:=METanggal.Text;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
    ENama.Text:='';
    SQLDataItems.Open;
    SQLDataItems.Refresh;
    MessageDlg('Status', 'Data Berhasil Ditambahkan', mtInformation, [mbOK], 0, mbOK);
    end;
  except
    on E : Exception do
      ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
  end;
end;

procedure TFormDataItem.BTNUbahClick(Sender: TObject);
begin
  try
    begin
    SQLQuery1.Close;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Text:='UPDATE tbl_items SET code_room = :code_room, code_category = :code_category, detail_name = :detail_name WHERE id_items = :id_item';
    SQLQuery1.Params.ParamByName('code_room').AsString:=CBRuangan.Text;
    SQLQuery1.Params.ParamByName('code_category').AsString:=CBBarang.Text;
    SQLQuery1.Params.ParamByName('detail_name').AsString:=ENama.Text;
    SQLQuery1.Params.ParamByName('id_item').AsInteger:=id_item;
    METanggal.Enabled:=true;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
    ENama.Text:='';
    SQLDataItems.Open;
    SQLDataItems.Refresh;
    MessageDlg('Status', 'Data Berhasil Diubah', mtInformation, [mbOK], 0, mbOK);
    end;
  except
    MessageDlg('Status', 'Data Gagal Diubah', mtError, [mbOK], 0, mbOK)
  end;
end;

procedure TFormDataItem.DBGrid1CellClick(Column: TColumn);
begin
  ENama.Text:=SQLDataItems.FieldByName('detail_name').AsString;
  CBRuangan.Text:=SQLDataItems.FieldByName('code_room').AsString;
  CBBarang.Text:=SQLDataItems.FieldByName('code_category').AsString;
  METanggal.Text:=SQLDataItems.FieldByName('date').AsString;
  id_item:=SQLDataItems.FieldByName('id_items').AsInteger;
  METanggal.Enabled:=False;
end;


end.

