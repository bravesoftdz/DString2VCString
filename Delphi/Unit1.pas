unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  { C++ String ���ڴ�ṹ ��С��24�ֽ� }
  VCString = record
    strMem: PDWORD;    // �ַ���ָ��
    R1, R2, R3: DWORD; // δ֪
    len: DWORD;        // �ַ�������
    R4: DWORD;         // ��ֵ = $0000002F
  end;

{ Delphi String ת��Ϊ C++ String }
function DelphiString2VCString(strFileName: string): VCString;
var
  vcs: AnsiString;
begin
  FillChar(Result, SizeOf(VCString), #0);   // �ÿ�
  vcs           := AnsiString(strFileName); // ���ֽ�ת��Ϊ���ֽ�
  Result.strMem := @vcs[1];                 // �ַ���ָ��
  Result.len    := Length(vcs);             // �ַ�������
  Result.R4     := $0000002F;               // ��ֵ
end;

procedure TestVCString(strValue: VCString); stdcall; external 'VC02.dll';

procedure TForm1.FormCreate(Sender: TObject);
var
  vcs: VCString;
begin
  vcs := DelphiString2VCString('F:\Github\dbImage\bin\Win32\test.jpg');
  TestVCString(vcs);
end;

end.
