unit unitDataKategori;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, mysql56conn, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Grids, Buttons, DBGrids, Menus, fpsexport, TAStyles;

type

  { TFormDataKategori }

  TFormDataKategori = class(TForm)
    BTNSubmit: TButton;
    BTNReset: TButton;
    BTNUbah: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    EKode: TEdit;
    ENama: TEdit;
    FPSExport1: TFPSExport;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MenuItem1: TMenuItem;
    MySQL56Connection1: TMySQL56Connection;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SQLTransaction2: TSQLTransaction;
    procedure BTNResetClick(Sender: TObject);
    procedure BTNSubmitClick(Sender: TObject);
    procedure BTNUbahClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private

  public

  end;

var
  FormDataKategori: TFormDataKategori;

implementation
uses unitMain;

{$R *.lfm}

{ TFormDataKategori }


procedure TFormDataKategori.FormCreate(Sender: TObject);
begin
  BorderIcons := BorderIcons - [biMaximize];
  DBGrid1.Columns[0].Title.Caption:='Nomor';
  DBGrid1.Columns[1].Title.Caption:='Kode';
  DBGrid1.Columns[2].Title.Caption:='Nama';
  DBGrid1.Columns[3].Title.Caption:='Tanggal Buat';
  DBGrid1.Columns[4].Title.Caption:='Tanggal Ubah';
end;

procedure TFormDataKategori.Image1Click(Sender: TObject);
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
        SQLQuery1.Params.ParamByName('detail_name').AsString:='Data Kategori';
        SQLQuery1.Params.ParamByName('file').AsString:=SaveDialog1.FileName;
        SQLQuery1.ExecSQL;
        SQLTransaction1.Commit;
        ENama.Text:='';
        SQLQuery2.Open;
        SQLQuery2.Refresh;
        end;
      except
        on E : Exception do
          ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
      end;
  end;
end;



procedure TFormDataKategori.BTNSubmitClick(Sender: TObject);
begin
  try
    begin
    SQLQuery1.Close;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Text:='INSERT INTO tbl_categories (code, name) VALUES (:code, :name)';
    SQLQuery1.Params.ParamByName('code').AsString:=EKode.Text;
    SQLQuery1.Params.ParamByName('name').AsString:=ENama.Text;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
    EKode.Text:='';
    ENama.Text:='';
    SQLQuery2.Open;
    SQLQuery2.Refresh;
    MessageDlg('Status', 'Data Berhasil Ditambahkan', mtInformation, [mbOK], 0, mbOK);
    end;
  except
    MessageDlg('Status', 'Data Gagal Ditambahkan', mtError, [mbOK], 0, mbOK)
  end;
end;

procedure TFormDataKategori.BTNUbahClick(Sender: TObject);
begin
  try
    begin
    SQLQuery1.Close;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Text:='UPDATE tbl_categories SET name = :name WHERE code = :code';
    SQLQuery1.Params.ParamByName('code').AsString:=EKode.Text;
    SQLQuery1.Params.ParamByName('name').AsString:=ENama.Text;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
    EKode.Text:='';
    ENama.Text:='';
    SQLQuery2.Open;
    SQLQuery2.Refresh;
    MessageDlg('Status', 'Data Berhasil Diubah', mtInformation, [mbOK], 0, mbOK);
    end;
  except
    MessageDlg('Status', 'Data Gagal Diubah', mtError, [mbOK], 0, mbOK)
  end;
end;

procedure TFormDataKategori.DBGrid1CellClick(Column: TColumn);
begin
  EKode.Text:=SQLQuery2.FieldByName('code').AsString;
  ENama.Text:=SQLQuery2.FieldByName('name').AsString;
end;




procedure TFormDataKategori.BTNResetClick(Sender: TObject);
begin
  EKode.Text:='';
  ENama.Text:='';
end;

procedure TFormDataKategori.Label1Click(Sender: TObject);
begin
  FormDataKategori.Hide;
  FormMain.Show;
end;

procedure TFormDataKategori.MenuItem1Click(Sender: TObject);
begin
    try
      SQLQuery1.Close;
      SQLQuery1.SQL.Clear;
      SQLQuery1.SQL.Text:='DELETE FROM tbl_categories WHERE code = :code';
      SQLQuery1.Params.ParamByName('code').AsString:=EKode.Text;
      SQLQuery1.ExecSQL;
      SQLTransaction1.Commit;
      EKode.Text:='';
      ENama.Text:='';
      SQLQuery2.Open;
      SQLQuery2.Refresh;
      MessageDlg('Status', 'Data Berhasil Dihapus', mtInformation, [mbOK], 0, mbOK);
  except
    MessageDlg('Status', 'Data Gagal Dihapus', mtError, [mbOK], 0, mbOK)
  end;
end;

end.

