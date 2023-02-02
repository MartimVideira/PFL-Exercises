% a) Element exists_in List

:- op(900,xfx,exists_in).

exists_in(Elem,[Elem|_]):-!.
exists_in(Elem,[X|XS]):-
    Elem \= X,!,
    exists_in(Elem,XS).


% b) append A to B results C

++([],XS,XS).
++([X|XS],YS,[X|ZS]):- ++(XS,YS,ZS).

results(Functor,Result):-
    call(Functor,Result).

:- op(600,xfx,++).
:- op(700,yfx,results).
% c) remove Elem from List results Result

remove(Elem,[Elem|XS],XS).
remove(Elem,[X|XS],[X|YS]):- remove(Elem,XS,YS).

from(OnList,List,Result):-
    call(OnList,List,Result).

:-op(600,fx,remove).
:-op(650,xfx,from).


mais(X,Y,Z):- Z is  X + Y.
:-op(500,yfx,mais).
