type
cycle_query = 
record
    data:array[5..25] of char;
    front,rear:integer;
end;

procedure AddQ(var CQ:cycle_query;b:char);
var temp:integer;
begin
    temp:=CQ.rear+1;
    if temp = 26 then temp:=5;
    if CQ.front = temp then writeln('overflow')
    else 
    begin
        CQ.rear:=temp;
        CQ.data[CQ.rear]:=b;
    end;
    
end;

procedure DelQ(var CQ:cycle_query;var b:char);
var temp:integer;
begin
    temp:=CQ.front+1;
    if temp = 26 then temp:=5;
    if CQ.front = CQ.rear then writeln('underflow')
    else 
    begin
        CQ.front:=temp;
        b:=CQ.data[CQ.front];
        CQ.data[CQ.front]:=' ';
    end;
    
end;

var
CQ:cycle_query;
b:char;
i:integer;

begin
    CQ.front:=5;
    CQ.rear:=5;

    for i := 1 to 25 do
        AddQ(CQ,'a');
    
    for i := 1 to 5 do
    begin
        DelQ(CQ,b);
        writeln('b:',b);
    end;

    for i := 1 to 5 do
        AddQ(CQ,'a');

    for i := 5 to 25 do
        write(' ',CQ.data[i],' ');

    for i := 1 to 25 do
    begin
        DelQ(CQ,b);
        writeln('b:',b);
    end;
        
    for i := 5 to 25 do
        write(' ',CQ.data[i],' ');

end.