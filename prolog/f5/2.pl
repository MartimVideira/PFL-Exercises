%a) my_arg/3 e my_functor/3 (com funcionamento idêntico aos predicados arg e functor) usando o =.. (univ).
atN(0,[X|_],X).
atN(N,[_|XS],X):-
    N > 0,
    N1 is N - 1,
    atN(N1,XS,X).

len([],0).
len([_|XS],Len):-
    len(XS,Len1),
    Len is Len1 + 1.

my_arg(Index,Term,Arg):-
   NaoComecaEm0 is Index - 1,
   Term =..[_Functor|Args], 
   atN(NaoComecaEm0,Args,Arg),!.

my_functor(Term,Functor,Arity):-
    Term =.. [Functor|Args],
    len(Args,Arity),!.

% b) univ/2 com base nos predicados arg/3 e functor/3
univ(Term,[Functor|Args]):-
    findall(Arg,arg(Index,Term,Arg),Args),
    functor(Term,Functor,Arity).

% c) Defina univ/2 como um operador infixo.)
set_univ_as_operator:-
    % Desta forma n fica hardcoded a precedencia do univ
    current_op(Precedence,xfx,'=..'),
    op(Precedence,xfx,univ).

:- set_univ_as_operator.
