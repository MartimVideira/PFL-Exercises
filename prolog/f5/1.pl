% a) map(+Pred, +List1, ?List2)
map(_,[],[]).
map(F,[X|XS],[Y|YS]):-
    call(F,X,Y),
    map(F,XS,YS).

% b) fold(+Pred, +StartValue, +List, ?FinalValue), neste caso é um foldr
fold(_,StartValue,[],StartValue).
fold(Pred, StartValue,[X|XS], FinalValue):-
    fold(Pred,StartValue,XS,PartialValue),
    call(Pred,X,PartialValue,FinalValue).

%c) separate(+List, +Pred, -Yes, -No) que recebe uma lista de elementos e um
%predicado, devolvendo em Yes e No os elementos de List que tornam o predicado
%Pred verdadeiro ou falso, respetivamente.
separate([],_,[],[]).
separate([X|XS],Pred,[X|Yes],No):-
    call(Pred,X),!,
    separate(XS,Pred,Yes,No).
separate([X|XS],Pred,Yes,[X|No]):-
    separate(XS,Pred,Yes,No).

% d) ask_execute/0 que lê da consola um objetivo e executa-o suspeito que seja só isto
ask_execute:-
    write('Insira o que deseja executar\n'),
    read(Ordem),
    call(Ordem).

% Par testar os predicados de cima
double(X,Y):- Y is X*2.
sum(X,Y,Z):- Z is X + Y.
even(X):- 0 =:= X mod 2.
