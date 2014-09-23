unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, StdCtrls, DES;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    txtKey: TEdit;
    cmdCode: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label6: TLabel;
    InText: TEdit;
    OutText: TEdit;
    Memo1: TEdit;
    Memo2: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cmdCodeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 //ShowMessage(DecodeDES(CodeDES('1       ','12345678'),'12345678'));
end;

procedure TForm1.cmdCodeClick(Sender: TObject);
var
 i:integer;
begin
Label8.Caption:=IntToStr(Length(InText.text) );
if Length(txtKey.Text)<>8 then
  Begin
  MessageBox(Handle,
  'Ключ должен состоять из 8 символов',
  Nil,MB_ICONSTOP);
  Exit;
  End;
(* if (Length(InText.Text)=1) or (Length(InText.Text)=2) then
 //begin
  //OutText.Text:=CodeDES(InText.Text+StringOfChar(' ',8-Length(InText.Text)),txtKey.Text);
  //exit;
 //end;  *)

 if Length(InText.Text) mod 8<>0 then InText.Text:=InText.Text+StringOfChar(' ',8*(Length(InText.Text) div 8+1)-Length(InText.Text));
 OutText.Text:='';
 for i:=1 to Length(InText.Text) div 8 do
 begin
  //ShowMessage(Copy(InText.Text,8*(i-1)+1,8)+' '+inttostr(Length(Copy(InText.Text,8*(i-1)+1,8))));
  Label8.Caption:=IntToStr(Length(InText.text) )+ ' символа(ов)';
  OutText.Text:=OutText.Text+CodeDES(Copy(InText.Text,8*(i-1)+1,8),txtKey.Text);
 end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 i:integer;
begin
if Length(Edit1.Text)<>8 then
  Begin
  MessageBox(Handle,
  'Ключ должен состоять из 8 символов',
  Nil,MB_ICONSTOP);
  Exit;
  End;
 Memo2.Text:='';
 for i:=1 to Length(Memo1.Text) div 8 do
 begin
  Memo2.Text:=Memo2.Text+DecodeDES(Copy(Memo1.Text,8*(i-1)+1,8),Edit1.Text);
 end;
end;

end.
