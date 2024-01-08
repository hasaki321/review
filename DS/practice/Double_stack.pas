type
double_stack = 
record
    data:array[1..20] of char;
    i:0..20;
    j:1..21;
end;

procedure Double_push(var A:double_stack;n:integer;b:char);
begin
    if A.i +1 = A.j then 
    begin
        writeln('stack overflow');
        exit;
    end
    else if n=1 then
    begin
        A.i:=A.i+1;
        A.data[A.i]:=b;
    end
    else if n=2 then
    begin
        A.j:=A.j-1;
        A.data[A.j]:=b;
    end
    else writeln('invalid stack');
end;

procedure Double_pop(var A:double_stack;n:integer;var b:char);
begin
    if n=1 then
    begin
        if A.i = 0 then 
        begin
            writeln('underflow');
            exit;
        end
        else
        begin
            b:=A.data[A.i];
            A.data[A.i]:=' ';
            A.i:=A.i-1;
        end;
    end
    else if n=2 then
    begin
        if A.j = 21 then 
        begin
            writeln('underflow');
            exit;
        end
        else
        begin
            b:=A.data[A.j];
            A.data[A.j]:=' ';
            A.j:=A.j+1;
        end;
    end
    else writeln('invalid stack');
end;


var 
Stack:double_stack;
i,j:integer;
b:char;
begin
    Stack.data[1]:='a';
    Stack.data[20]:='b';
    Stack.i:=1;
    Stack.j:=20;

    for j := 1 to 11 do 
    begin
        Double_push(Stack,1,'a');
        Double_push(Stack,2,'b');
    end;

    for i := 1 to 20 do
        write(' ',Stack.data[i],' ');

    for j := 1 to 11 do 
    begin
        Double_pop(Stack,1,b);
        writeln('b1:',b);
        Double_pop(Stack,2,b);
        writeln('b2:',b);
    end;

    for i := 1 to 20 do
        write(' ',Stack.data[i],' ');
end.