unit unitRoomDetail;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql56conn, sqldb, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Grids;

type

  { TFormDataRoomDetail }

  TFormDataRoomDetail = class(TForm)
    Image2: TImage;
    Label1: TLabel;
    LTitle: TLabel;
    MySQL56Connection1: TMySQL56Connection;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    StringGrid1: TStringGrid;
  private

  public

  end;

var
  FormDataRoomDetail: TFormDataRoomDetail;

implementation

{$R *.lfm}

{ TFormDataRoomDetail }





end.

