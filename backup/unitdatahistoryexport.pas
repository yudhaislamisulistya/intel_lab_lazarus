unit unitDataHistoryExport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TFormDataHistoryExport }

  TFormDataHistoryExport = class(TForm)
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
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

end.

