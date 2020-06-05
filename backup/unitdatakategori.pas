unit unitDataKategori;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, Buttons, TAStyles;

type

  { TFormDataKategori }

  TFormDataKategori = class(TForm)
    BTNSubmit: TButton;
    BTNReset: TButton;
    EKode: TEdit;
    ENama: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    SGDataKetegori: TStringGrid;
    procedure BTNResetClick(Sender: TObject);
    procedure BTNSubmitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
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

end;

procedure TFormDataKategori.BTNSubmitClick(Sender: TObject);
begin

end;

procedure TFormDataKategori.BTNResetClick(Sender: TObject);
begin

end;

procedure TFormDataKategori.Label1Click(Sender: TObject);
begin
  FormDataKategori.Hide;
  FormMain.Show;
end;

end.

