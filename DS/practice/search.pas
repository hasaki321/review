type
str=array[1..20] of char;
kmp_next=array[1..4] of integer;

procedure Brute_search(var S,P:str;var i:integer);
var k,j:integer;
begin
    i:=0;
    j:=1;
    while i<Length(S) do
    begin
        i:=i+1;k:=i;j:=1; 
        while S[k]=P[j] do
        begin
            if j=3 then 
            begin
               writeln('success');
               exit; 
            end
            else if k=Length(S) then 
            begin
               writeln('fail');
               exit; 
            end
            else 
            begin
                k:=k+1;
                j:=j+1;
            end;
            
        end; 
    end;
    writeln('fail');    
end;

procedure KMP(var S,P:str;next:kmp_next);
var i,j:integer;
begin
    i:=1;
    j:=1;
    while i <= 7 do
    begin
        while (j>1) and (S[i]<>P[j]) do j:=next[j];
        if j=4 then 
        begin
            writeln('success');
            exit;
        end
        else 
        begin
            i:=i+1;
            j:=j+1;
        end;
    end;
    writeln('fail');
end;

procedure KMPnext(S:str;var next:kmp_next);
var 
j,k:integer;
begin
    next[1]:=0;
    j:=2;
    while j<=4 do 
    begin
        
        k:=next[j-1];
        while (k<>0) and (S[k]<>S[j-1]) do 
        begin
            k:=next[k];
            writeln(k);
        end;
        
        next[j]:=k+1;
        j:=j+1;
    end;
end;

var 
S,P:str;
i:integer;
N:kmp_next;
begin
   S:='aaabdad';
   P:='aabd';
   KMPnext(P,N);
   for i:=1 to 4 do
        writeln(N[i]); 
   KMP(S,P,N);
end.