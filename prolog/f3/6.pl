% professor leciona cadeira
% leciona(cadeira,professor)
leciona("Algoritmos","Adalberto").
leciona("Base De Dados","Bernardete").
leciona("Estatística","Diógenes").
leciona("Redes","Ermelinda").

% Aluno frequenta cadeira
% frequenta(cadeira,aluno)

% "Algoritmos"
frequenta("Algoritmos","Alberto").
frequenta("Algoritmos","Bruna").
frequenta("Algoritmos","Cristina").
frequenta("Algoritmos","Diogo").
frequenta("Algoritmos","Eduarda").

% "Base de Dados"
frequenta("Base De Dados","António").
frequenta("Base De Dados","Bruno").
frequenta("Base De Dados","Cristina").
frequenta("Base De Dados","Duarte").
frequenta("Base De Dados","Eduardo").

% "Compiladores"
frequenta("Compiladores","Alberto").
frequenta("Compiladores","Bernardo").
frequenta("Compiladores","Clara").
frequenta("Compiladores","Diana").
frequenta("Compiladores","Eurico").

% "Estatística"
frequenta("Estatística","António").
frequenta("Estatística","Bruna").
frequenta("Estatística","Cláudio").
frequenta("Estatística","Duarte").
frequenta("Estatística","Eva").

% "Redes"
frequenta("Redes","Álvaro").
frequenta("Redes","Beatriz").
frequenta("Redes","Cláudio").
frequenta("Redes","Diana").
frequenta("Redes","Eduardo").

% b)
% i) leciona(X,"Diógenes").
% ii)leciona(X,"Felismina").
% iii)frequenta(X,"Cláudio").
% iv)frequenta(X,"Dalmindo").
% v)leciona(Z,"Bernardete"),frequenta(Z,"Eduarda").
% vi)frequenta(X,"Alberto"),frequenta(X,"Álvaro").

% c)
% i) X é aluno do professor Y
aluno(X,Y) :- leciona(Z,Y), frequenta(Z,X).

professor(X,Y) :- aluno(Y,X).
% iii) Quem são os professores do aluno X
%professoresDe(X) :- aluno(X,Y).

% iv) Quem é aluno do professor X e do professor Y
%alunosDeEDe(X,Y) :- aluno(Z,X) ,aluno(Z,Y).

colegas(X,Y) :- leciona(_,X) , leciona(_,Y), Y\=X.
colegas(X,Y) :- aluno(X,Z), aluno(Y,Z), Y\=X.

% vi) Alunos que frequentam Mais de uma UC
maisDeUmaUC(X):- frequenta(UC,X) , frequenta(UC1,X), UC\=UC1.
% ---------------------------------------------------------------------
%                       Exercicio 6 Ficha 3 
% ---------------------------------------------------------------------

% a)teachers(-T) que devolve uma lista com todos os professores
% b) Se com setof evitamos o problema dos repetidos.
teachers(TS):- setof(P,C^leciona(C,P),TS).

% c) students_of(+T,-S) devolve lista S com todos os estudantes odo professor T
students_of(T,S):- setof(Aluno,aluno(Aluno,T),S).

% d) teachers_of(+S,-T) devolve uma lista com todos os professores do estudante S.
teachers_of(S,T):- setof(Professor,professor(Professor,S),T).

% e) common_courses(+S1,+S2,-C) devolve uma lista de todas as unidades
% curriculares frequentadas por ambos os estudantes S1 e S2.
common_courses(S1,S2,C):-
    setof(Cadeira,(S1,S2)^(frequenta(Cadeira,S1),frequenta(Cadeira,S2)),C).

% f) more_than_one_course(-L) devolve uma lista com todos os estudantes que
% frequentam mais de 1 UC
more_than_one_course(L):-
    setof(S,(C1,C2)^(frequenta(C1,S),frequenta(C2,S),C1\=C2),L).

% g) strangers(-L) devolve uma lista de todos os pares de estudantes que não se
% conhecem, não frequentam nenhuma cadeira em comum.
% Para remover casos como "Alberto"-"Joao" "Joao"-"Alberto" que o setof não remove
remove_switched(XS,YS):- remove_switched(XS,YS,[]).
remove_switched([],[],_).
remove_switched([X-X1|XS],[X-X1|YS],Acc):- \+ member(X1-X,Acc),!,remove_switched(XS,YS,[X-X1|Acc]).
remove_switched([_Elem|XS],YS,Acc):- remove_switched(XS,YS,Acc).

strangers(Res):- setof(S1-S2,(A,B,C)^(frequenta(A,S1),frequenta(B,S2),S1\=S2,\+ common_courses(S1,S2,C)),L),
        remove_switched(L,Res).

% h) good_groups(L) devolve uma lista com todos os pares de estudantes qeu frequentam mais de uma UC em comum
good_groups(Res):-
    setof(S1-S2,(A,B,C,N)^(frequenta(A,S1),frequenta(B,S2),S1\=S2,common_courses(S1,S2,C),length(C,N),N >1),L),
    remove_switched(L,Res).
