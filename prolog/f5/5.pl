% a) flight tp1949 from porto to lisbon at 16:15

:- op(600,yfx,at).
:- op(550,xfy,to).
:- op(500,xfy,from).
:- op(450,fx,flight).


% b) if X then Y else Z

:- op(450,fx,if).
:- op(550,xfy,then).
:- op(600,yfx,else).

if(Condition):- Condition.
then(IfCond,Do):-
    call(IfCond),!,
    call(Do).
else(CondBlock,_):-
    call(CondBlock),!.
else(_,Do):-
    call(Do).
        
o_menor_e(X):- format('O menor é ~d\n',[X]).
ola(Y):-
    write_canonical(
    if (0 is X mod 3) then
        if (0 is X mod 5) then
            write('3 e 5')
        else
            write('3')
    else 
        write('N')).

