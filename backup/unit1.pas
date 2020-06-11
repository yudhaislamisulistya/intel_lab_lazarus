unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, unitMain;

type

  { TFormLogin }

  TFormLogin = class(TForm)
    EUsername: TEdit;
    EPassword: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.lfm}

{ TFormLogin }

procedure TFormLogin.Label1Click(Sender: TObject);
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
            FormLogin.Hide;
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


end.

