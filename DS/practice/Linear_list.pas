type 
sqlist=
record
    data:array[1..10] of integer;
    n:1..10;
end;

procedure InsSQList(var A:sqlist;b,i:integer);
var j:integer;
begin
    if (i<1) or (i>A.n+1) then 
    begin
        writeln('i error');
        exit;
    end;
    if i=10 then writeln('no insert');
        
    A.n:=A.n+1;
    for j := A.n downto i+1 do
        A.data[j]:=A.data[j-1];
    A.data[i]:=b;
end;

procedure AddSQList(var A:sqlist;b:integer);
begin
    if A.n>=10 then writeln('over max len')
    else
    begin
        A.n := A.n + 1;
    A.data[A.n] := b;
    end;
end;


var
List:sqlist;
a,b,c,i:integer;
begin
    a:=1;
    b:=2;
    c:=3;
    List.n:=0;
    AddSQList(List,a);
    AddSQList(List,b);
    InsSQList(List,c,1);
    for i := 1 to List.n do
    begin
        writeln(List.data[i]);
    end;
        
end.