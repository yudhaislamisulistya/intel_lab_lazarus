unit unitDataHistoryExport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql56conn, sqldb, db, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, DBGrids;

type

  { TFormDataHistoryExport }

  TFormDataHistoryExport = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    MySQL56Connection1: TMySQL56Connection;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  FormDataHistoryExport: TFormDataHistoryExport;

implementation
uses
  unitMain;

{$R *.lfm}

{ TFormDataHistoryExport }

procedure TFormDataHistoryExport.Label1Click(Sender: TObject);
begin
  FormDataHistoryExport.Hide;
  FormMain.Show;
end;

procedure TFormDataHistoryExport.FormCreate(Sender: TObject);
begin
  BorderIcons := BorderIcons - [biMaximize]
end;

end.

