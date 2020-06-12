unit unitDataRoom;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, mysql56conn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids, ExtCtrls, Menus, fpsexport;

type

  { TFormDataRoom }

  TFormDataRoom = class(TForm)
    BTNReset: TButton;
    BTNSubmit: TButton;
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
  FormDataRoom: TFormDataRoom;

implementation
uses
  unitMain;

{$R *.lfm}

{ TFormDataRoom }


procedure TFormDataRoom.FormCreate(Sender: TObject);
begin
  BorderIcons := BorderIcons - [biMaximize];
  DBGrid1.Columns[0].Title.Caption:='Nomor';
  DBGrid1.Columns[1].Title.Caption:='Kode';
  DBGrid1.Columns[2].Title.Caption:='Nama';
  DBGrid1.Columns[3].Title.Caption:='Tanggal Buat';
  DBGrid1.Columns[4].Title.Caption:='Tanggal Ubah';
end;

procedure TFormDataRoom.Image1Click(Sender: TObject);
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
        SQLQuery2.Params.ParamByName('detail_name').AsString:='Data Ruangan';
        SQLQuery2.Params.ParamByName('file').AsString:=SaveDialog1.FileName;
        SQLQuery2.ExecSQL;
        SQLTransaction1.Commit;
        ENama.Text:='';
        SQLQuery1.Open;
        SQLQuery1.Refresh;
        end;
      except
        on E : Exception do
          ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
      end;
  end;
end;

procedure TFormDataRoom.Label1Click(Sender: TObject);
begin
  FormDataRoom.Hide;
  FormMain.Show;
end;

procedure TFormDataRoom.MenuItem1Click(Sender: TObject);
begin
      try
      SQLQuery2.Close;
      SQLQuery2.SQL.Clear;
      SQLQuery2.SQL.Text:='DELETE FROM tbl_rooms WHERE code = :code';
      SQLQuery2.Params.ParamByName('code').AsString:=EKode.Text;
      SQLQuery2.ExecSQL;
      SQLTransaction1.Commit;
      EKode.Text:='';
      ENama.Text:='';
      SQLQuery1.Open;
      SQLQuery1.Refresh;
      MessageDlg('Status', 'Data Berhasil Dihapus', mtInformation, [mbOK], 0, mbOK);
  except
    MessageDlg('Status', 'Data Gagal Dihapus', mtError, [mbOK], 0, mbOK)
  end;
end;

procedure TFormDataRoom.BTNSubmitClick(Sender: TObject);
begin
    try
    begin
    SQLQuery2.Close;
    SQLQuery2.SQL.Clear;
    SQLQuery2.SQL.Text:='INSERT INTO tbl_rooms (code, name) VALUES (:code, :name)';
    SQLQuery2.Params.ParamByName('code').AsString:=EKode.Text;
    SQLQuery2.Params.ParamByName('name').AsString:=ENama.Text;
    SQLQuery2.ExecSQL;
    SQLTransaction1.Commit;
    EKode.Text:='';
    ENama.Text:='';
    SQLQuery1.Open;
    SQLQuery1.Refresh;
    MessageDlg('Status', 'Data Berhasil Ditambahkan', mtInformation, [mbOK], 0, mbOK);
    end;
  except
    MessageDlg('Status', 'Data Gagal Ditambahkan', mtError, [mbOK], 0, mbOK)
  end;
end;

procedure TFormDataRoom.BTNResetClick(Sender: TObject);
begin
  EKode.Text:='';
  ENama.Text:='';
end;

procedure TFormDataRoom.BTNUbahClick(Sender: TObject);
begin
    try
    begin
    SQLQuery2.Close;
    SQLQuery2.SQL.Clear;
    SQLQuery2.SQL.Text:='UPDATE tbl_rooms SET name = :name WHERE code = :code';
    SQLQuery2.Params.ParamByName('code').AsString:=EKode.Text;
    SQLQuery2.Params.ParamByName('name').AsString:=ENama.Text;
    SQLQuery2.ExecSQL;
    SQLTransaction1.Commit;
    EKode.Text:='';
    ENama.Text:='';
    SQLQuery1.Open;
    SQLQuery1.Refresh;
    MessageDlg('Status', 'Data Berhasil Diubah', mtInformation, [mbOK], 0, mbOK);
    end;
  except
    MessageDlg('Status', 'Data Gagal Diubah', mtError, [mbOK], 0, mbOK)
  end;
end;

procedure TFormDataRoom.DBGrid1CellClick(Column: TColumn);
begin
  EKode.Text:=SQLQuery1.FieldByName('code').AsString;
  ENama.Text:=SQLQuery1.FieldByName('name').AsString;
end;



end.

