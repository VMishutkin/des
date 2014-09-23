unit DES;



interface
        uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, StdCtrls;

 function ConToBin(Num:Byte; l:integer):string ;
 function ConToInt(str:string):integer;
 function MakePerest1(block:string):string;
 function MakePerest2(block:string):string;
 function GetHighPart(block:string):string;
 function GetLowPart(block:string):string;
 function MakeXOR(blk1,blk2:string; l:integer):string;
 procedure MakeSubKeys(Key:string);
 function ShiftLeft(blk:string; n:integer):string;
 function F(X,SK:string):string;
 function StrToBin(str:string):string;
 function BinToStr(bin:string):string;
 function CodeDES(Str,Key:string):string;
 function DEcodeDES(Str,Key:string):string;

 var
 K:array [1..16] of string;

const
//изначальная перестановка исходного текста
 IP1:array [1..64] of integer=(58,50,42,34,26,18,10,2,60,52,44,36,28,20,12,4,
                                62,54,46,38,30,22,14,6,64,56,48,40,32,24,16,8,
                                57,49,41,33,25,17,9,1,59,51,43,35,27,19,11,3,
                                61,53,45,37,29,21,13,5,63,55,47,39,31,23,15,7);
 //обратная перестановка
 IP2:array [1..64] of integer=(40,8,48,16,56,24,64,32,39,7,47,15,55,23,63,31,
                                38,6,46,14,54,22,62,30,37,5,45,13,53,21,61,29,
                                36,4,44,12,52,20,60,28,35,3,43,11,51,19,59,27,
                                34,2,42,10,50,18,58,26,33,1,41,9,49,17,57,25);
 //Расширение ключа из 32 бит в 48
 E:array [1..48] of integer=( 32,1,2,3,4,5,
                              4,5,6,7,8,9,
                              8,9,10,11,12,13,
                              12,13,14,15,16,17,
                              16,17,18,19,20,21,
                              20,21,22,23,24,25,
                              24,25,26,27,28,29,
                              28,29,30,31,32,1);

  // Первая перестановка в f функции
 P:array [1..32] of integer=(16,7,20,21,29,12,28,17,
                              1,15,23,26,5,18,31,10,
                              2,8,24,14,32,27,3,9,
                              19,13,30,6,22,11,4,25);
 //Преобразования в f функции
 S:array [1..8,0..63] of integer=(
                                  (14,0,4,15,13,7,1,4,2,14,15,2,11,13,8,1,
                                    3,10,10,6,6,12,12,11,5,9,9,5,0,3,7,8,
                                    4,15,1,12,14,8,8,2,13,4,6,9,2,1,11,7,
                                    15,5,12,11,9,3,7,14,3,10,10,0,5,6,0,13),

                                  (15,3,1,13,8,4,14,7,6,15,11,2,3,8,4,14,
                                    9,12,7,0,2,1,13,10,12,6,0,9,5,11,10,5,
                                    0,13,14,8,7,10,11,1,10,3,4,15,13,4,1,2,
                                    5,11,8,6,12,7,6,12,9,0,3,5,2,14,15,9),

                                  (10,13,0,7,9,0,14,9,6,3,3,4,15,6,5,10,
                                    1,2,13,8,12,5,7,14,11,12,4,11,2,15,8,1,
                                    13,1,6,10,4,13,9,0,8,6,15,9,3,8,0,7,
                                    11,4,1,15,2,14,12,3,5,11,10,5,14,2,7,12),

                                  (7,13,13,8,14,11,3,5,0,6,6,15,9,0,10,3,
                                    1,4,2,7,8,2,5,12,11,1,12,10,4,14,15,9,
                                    10,3,6,15,9,0,0,6,12,10,11,1,7,13,13,8,
                                    15,9,1,4,3,5,14,11,5,12,2,7,8,2,4,14),

                                  (2,14,12,11,4,2,1,12,7,4,10,7,11,13,6,1,
                                    8,5,5,0,3,15,15,10,13,3,0,9,14,8,9,8,
                                    4,11,2,8,1,12,11,7,10,1,13,14,7,2,8,13,
                                    15,6,9,15,12,0,5,9,6,10,3,4,0,5,14,3),

                                  (12,10,1,15,10,4,15,2,9,7,2,12,6,9,8,5,
                                    0,6,13,1,3,13,4,14,14,0,7,11,5,3,11,8,
                                    9,4,14,3,15,2,5,12,2,9,8,5,12,15,3,10,
                                    7,11,0,14,4,1,10,7,1,6,13,0,11,8,6,13),

                                  (4,13,11,0,2,11,14,7,15,4,0,9,8,1,13,10,
                                    3,14,12,3,9,5,7,12,5,2,10,15,6,8,1,6,
                                    1,6,4,11,11,13,13,8,12,1,3,4,7,10,14,7,
                                    10,9,15,5,6,0,8,15,0,14,5,2,9,3,2,12),

                                  (13,1,2,15,8,13,4,8,6,10,15,3,11,7,1,4,
                                    10,12,9,5,3,5,14,11,5,0,0,14,12,9,7,2,
                                    7,2,11,1,4,14,1,7,9,4,12,10,14,8,2,13,
                                    0,15,6,12,10,9,13,0,15,3,3,5,5,6,8,11));
 //Левая часть ключа
 C0:array [1..28] of integer=(57,49,41,33,25,17,9,
                              1,58,50,42,34,26,18,
                              10,2,59,51,43,35,27,
                              19,11,3,60,52,44,36);
 //Правая часть ключа
 D0:array [1..28] of integer=(63,55,47,39,31,23,15,
                              7,62,54,46,38,30,22,
                              14,6,61,53,45,37,29,
                              21,13,5,28,20,12,4);
 //число сдвигов
 R:array [1..16] of integer=(1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1);
  //перестановка битов ключа
 PC2:array [1..48] of integer=(14,17,11,24,1,5,
                                3,28,15,6,21,10,
                                23,19,12,4,26,8,
                                16,7,27,20,13,2,
                                41,22,31,37,47,55,
                                30,40,51,45,33,48,
                                44,49,39,56,34,53,
                                46,42,50,36,29,32);



implementation


    //Перевод числа в его двоичный вид
function ConToBin(Num:Byte; l:integer):string;
var
 h:string;
 t:string;
 i:integer;
begin
 h:=inttohex(Num,l);//Встроенная функция перевода, вместо 00-255 получаем 00-ff
 t:='';
 for i:=1 to Length(h) do
 begin
  case h[i] of
   '0': t:=t+'0000';
   '1': t:=t+'0001';
   '2': t:=t+'0010';
   '3': t:=t+'0011';
   '4': t:=t+'0100';
   '5': t:=t+'0101';
   '6': t:=t+'0110';
   '7': t:=t+'0111';
   '8': t:=t+'1000';
   '9': t:=t+'1001';
   'A': t:=t+'1010';
   'B': t:=t+'1011';
   'C': t:=t+'1100';
   'D': t:=t+'1101';
   'E': t:=t+'1110';
   'F': t:=t+'1111';
  end;
 end;
 ConToBin:=t;
end;


 //Перевод из двоичной в 10ричный вид
function ConToInt(str:string):integer;
var
 i:integer;
 t:integer;
begin
 t:=0;
 for i:=1 to Length(str) do
  t:=t+strtoint(Copy(str,i,1))*round(power(2,Length(str)-i));

 ConToInt:=t;
end;//конец contoint
 //начальная перестановка текста по таблице
function MakePerest1(block:string):string;
var
 t:string;
 i:integer;
begin
 t:=StringOfChar('0',64);
 for i:=1 to 64 do t[i]:=block[IP1[i]];
 MakePerest1:=t;
end;
 //конечная перестановка  по таблице
function MakePerest2(block:string):string;
var
 t:string;
 i:integer;
begin
 t:=StringOfChar('0',64);
 for i:=1 to 64 do t[i]:=block[IP2[i]];
 MakePerest2:=t;
end;

//Разделение 64 битовой строки на 32битовые
function GetHighPart(block:string):string;
begin
 GetHighPart:=Copy(block,1,32);
end;

function GetLowPart(block:string):string;
begin
 GetLowPart:=Copy(block,33,32);
end;

//функция сложения по модулю 2,
function MakeXOR(blk1,blk2:string; l:integer):string;
var
 i:integer;
 t:string;
begin
 t:=StringOfChar('0',l);
 for i:=1 to l do
  if ((blk1[i]='0') and (blk2[i]='1')) or ((blk1[i]='1') and (blk2[i]='0')) then t[i]:='1' else t[i]:='0';
 MakeXOR:=t;
end;

//сдвиг влева
function ShiftLeft(blk:string; n:integer):string;
begin
 ShiftLeft:=Copy(blk,n+1,Length(blk)-n)+Copy(blk,1,n);
 end;

 //формируем 16 подключей
procedure MakeSubKeys(Key:string);
var
 i:integer;
 Hi:string;
 Lo:string;
 OHi:string;
 OLo:string;
 t:string;
 j:integer;
begin
 Hi:=StringOfChar('0',28);
 Lo:=StringOfChar('0',28);
 OHi:=StringOfChar('0',28);
 OLo:=StringOfChar('0',28);

 for i:=1 to 16 do k[i]:=StringOfChar('0',48);

 for i:=1 to 28 do
 begin
  OHi[i]:=Key[C0[i]];
  OLo[i]:=Key[D0[i]];
 end;

 for i:=1 to 16 do
 begin

  Hi:=ShiftLeft(OHi,R[i]);    //???
  Lo:=ShiftLeft(OLo,R[i]);
  t:=Hi+Lo;
  for j:=1 to 48 do k[i][j]:=t[PC2[j]];
  OHi:=Hi;
  OLo:=Lo;
 end;
end;

//E расширение, Xor(E(T),K),S преобразование, P перестановка
function F(X,SK:string):string;
var
 T:string;
 i:integer;
 H:string;
 XS:string;
begin
 T:=StringOfChar('0',48);
 for i:=1 to 48 do T[i]:=X[E[i]];

 H:=MakeXOR(T,SK,48);
 T:='';
 for i:=1 to 8 do
  T:=T+ConToBin(S[i,ConToInt(Copy(H,8*(i-1)+1,8))],1);

 XS:=StringOfChar('0',32);
 for i:=1 to 32 do XS[i]:=T[P[i]];
 F:=XS;
end;


function StrToBin(str:string):string;
var
 t:string;
 i:integer;
begin
  //Функция Перводит строку в 0 и 1
 t:='';
 for i:=1 to Length(str) do
 begin
 //ConToBin передаем число по аски, получаем эквивалентное выражение из 0 и 1
  t:=t+ConToBin(ord(str[i]),2); //ord-возвращает целочисленное значение для символа
 end;
 StrToBin:=t;
end;

function BinToStr(bin:string):string;
var
 i:integer;
 t:string;
begin
 t:=StringOfChar('0',Length(bin) div 8);
 for i:=1 to Length(bin) div 8 do
 begin
  t[i]:=chr(ConToInt(Copy(bin,8*(i-1)+1,8)));
 end;
 BinToStr:=t;
end;

function CodeDES(Str,Key:string):string;
var
 i:integer;
 T:string;
 TZ:string;
 H,L:string;
 OH,OL:string;
 BinKey:string;
begin
//переводим ключ и текст в строки из 0 и 1
 T:=StrToBin(Str);
 BinKey:=StrToBin(Key);
 TZ:=StringOfChar('0',64); //TZ- строка после изначальной перестановки

 //for i:=1 to 64 do TZ[i]:=T[IP1[i]];
 TZ:=MakePerest1(T);

 H:=GetHighPart(TZ);
 L:=GetLowPart(TZ);
 MakeSubKeys(BinKey);

 for i:=1 to 16 do
 begin
  OH:=H;
  OL:=L;
  L:=MakeXOR(OH,F(OL,k[i]),32);
  H:=OL;
 end;

 T:=MakePerest2(L+H);
 CodeDES:=BinToStr(T);
end;

function DEcodeDES(Str,Key:string):string;
var
 i:integer;
 T:string;
 TZ:string;
 H,L:string;
 OH,OL:string;
 BinKey:string;
begin
 T:=StrToBin(Str);
 BinKey:=StrToBin(Key);
 TZ:=StringOfChar('0',64);

 for i:=1 to 64 do TZ[i]:=T[IP1[i]];

 H:=GetHighPart(TZ);
 L:=GetLowPart(TZ);
 MakeSubKeys(BinKey);

 for i:=1 to 16 do
 begin
  OH:=H;
  OL:=L;
  L:=MakeXOR(OH,F(OL,k[17-i]),32);
  H:=OL;
 end;

 T:=MakePerest2(L+H);
 DecodeDES:=BinToStr(T);
end;

end.//конец contobin
