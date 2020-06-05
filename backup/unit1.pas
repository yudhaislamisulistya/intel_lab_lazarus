unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, unitMain;

type

  { TForm1 }

  TForm1 = class(TForm)
    EUsername: TEdit;
    EPassword: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Label1Click(Sender: TObject);
var
  username, password: String;
begin
  username:=EUsername.Text;
  password:=EPassword.Text;

  if (username = 'admin') AND (password = 'admin') then
     begin
       if MessageDlg('Account Correct', 'Status Login', mtInformation, [mbOK], 0, mbOK) = mrOK then
          begin
            FormMain := TFormMain.Create(Application);
            FormMain.Show;
            Form1.Hide;
          end
       else
           begin
             MessageDlg('Failed To Login', 'Status Login', mtError, [mbOK], 0, mbOK);
           end;
     end
  else
      begin
       MessageDlg('Account Incorrect', 'Status Login', mtError, [mbOK], 0, mbOK)
      end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.BorderIcons:= Form1.BorderIcons - [biMaximize];
end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;



end.

