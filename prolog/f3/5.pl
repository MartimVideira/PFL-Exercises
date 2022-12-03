female("Grace").
female("DeDe").
female("Gloria").
female("Barb").
female("Claire").
female("Cameron").
female("Bo").
female("Haley").
female("Lily").
female("Poppy").

male("Rexford").
male("George").
male("Calhoun").
male("Alex").
male("Luke").
male("Dylan").
male("Pameron").
male("Mitchell").
male("Joe").
male("Many").
male("Phil").
male("Javier").
male("Merle").
male("Jay").
male("Frank").

% a is b's parent 
parent("Grace","Phil").
parent("Frank","Phil").
parent("DeDe","Claire").
parent("Jay","Claire").
parent("Jay","Mitchell").
parent("DeDe","Mitchell").
parent("Jay","Joe").
parent("Gloria","Joe").
parent("Gloria","Many").
parent("Javier","Many").
parent("Barb","Cameron").
parent("Merle","Cameron").
parent("Barb","Pameron").
parent("Merle","Pameron").
parent("Phil","Haley").
parent("Claire","Haley").
parent("Phil","Alex").
parent("Claire","Alex").
parent("Phil","Luke").
parent("Claire","Luke").
parent("Mitchell","Lily").
parent("Cameron","Lily").
parent("Mitchell","Rexford").
parent("Cameron","Rexford").
parent("Bo","Calhoun").
parent("Pameron","Calhoun").
parent("Dylan","George").
parent("Haley","George").
parent("Dylan","Poppy").
parent("Haley","Poppy").


% b)
% i) ?- female("Haley").
% ii) ?- male("Gil").
% iii) ?- parent("Frank","Phil").
% iv) ?- parent(X,"Claire").o
% v) ?- parent("Gloria",X).
% vi) ?- parent("Jay",Y),parent(Y,X).
% vii) ?-parent(X,Y),parent(Y,"Lily").
% viii) ?- parent("Alex",X).
% ix) ?- parent("Jay",X),\+ parent("Gloria",X).

%c

% X is Y's father
father(X,Y) :- parent(X,Y), male(X).

% X is Y'father
mother(X,Y) :-  parent(X,Y), female(X).

% X is Y's grandparent
grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

% X is Y's grandmother
grandmother(X,Y) :- grandparent(X,Y), female(X).

% X is Y's grandfather
grandfather(X,Y) :- grandparent(X,Y), male(X).

sameMother(X,Y) :- mother(M,X), mother(M,Y).
sameFather(X,Y) :- father(F,X), father(F,Y).

% X and Y are siblings
siblings(X,Y) :- sameMother(X,Y) ,sameFather(X,Y),X\=Y.

%X and Y are halfsiblings
% if could use the not operator
% halfsiblings(X,Y) :- \+ siblings(X,Y), (sameMother(X,Y);sameFather(X,Y)).
halfsiblings(X,Y) :- sameMother(X,Y), father(Z,X),father(W,Y), Z\=W.
halfsiblings(X,Y) :- sameFather(X,Y), mother(Z,X), mother(W,Y), Z\=W.

% X and Y are cousins
cousins(X,Y) :- parent(W,X),parent(Z,Y),siblings(W,Z).

% X is Y's uncle
uncle(X,Y) :- male(X),parent(Z,Y),siblings(X,Z).

% X is Y's aunt
aunt(X,Y) :- female(Y),parent(Z,Y), siblings(X,Z).

% d) 
% ?- cousins("Haley","Lily").
% ?- father(X,"Luke").
% ?- uncle(X,"Lily").
% ?- grandmother(X,_).
% ?- siblings(X,Y).
% ?- halfsiblings(X,Y).

%e)
% X married Y in Z
married("Jay","Gloria",2008).
married("Jay","DeDe",1968).

% X divorced Y in Z
divorced("Jay","DeDe",2003).

% ---------------------------------------------------------------------
%                       Exercicio 5 Ficha 3 
% ---------------------------------------------------------------------
%a) children(+Person, -Children), que devolve no segundo argumento uma lista
%com todos os filhos de Person.
children(Person,Children):- findall(Child,parent(Person,Child),Children).

%b) children_of(+ListOfPeople, -ListOfPairs), que devolve no segundo
%argumento uma lista com pares no formato P-C, em que P é elemento de ListOfPeople, e C é
%uma lista com os seus filhos.
children_of([],[]).
children_of([Person|People],[Person-Children|Rest]):-
    children(Person,Children),
    children_of(People,Rest).
%c) family(-F) que devolve uma lista com todas as pessoas da família.
% X and Y are related
connected(P1, P2) :- parent(P1, P2); parent(P2, P1).
family(F) :- setof(Person, Relative^connected(Relative, Person), F).

%d) Implemente o predicado couple(?C), que unifica C com um par de pessoas (X-Y) que têm
%pelo menos um filho (descendente) em comum. Ex.:
couple(Soy-Sauce):- parent(Soy,Bean),parent(Sauce,Bean),Soy \= Sauce.

%e) Implemente o predicado couples(-List) que devolve em List uma lista com todos os casais
%que tiveram filhos, evitando resultados duplicados.
couples(List):- setof(Couple,couple(Couple),List).

%f) Implemente o predicado spouse_children(+Person -SC) que devolve em SC um par
%Spouse/Children com um cônjuge e filhos de Person e Spouse.
spouse_children(Person,Spouse/Children):-couple(Person-Spouse),children(Spouse,Children).

%g) Implemente o predicado immediate_family(+Person, -PC) que devolve em PC um par A-B
%em que A é uma lista com os progenitores de Person, e B é uma lista com os cônjuges e
%respetivos filhos de Person
parents(Person,Parents):- findall(Parent,parent(Parent,Person),Parents).
immediate_family(Person,Parents-SpousesChildren):-
    parents(Person,Parents),
    setof(SpouseChildren,spouse_children(Person,SpouseChildren),SpousesChildren).

% h)parents_of_two(-Parents) que devolve em Parents a lista de todas as pessoas
% que tiveram pelo menos dois filhos.
two_children(Parent):- parent(Parent,X),parent(Parent,Y),X\=Y.
parents_of_two(Parents):-setof(Person,two_children(Person),Parents).
%parents_of_two(Parents):-setof(Person,parent(Parent,X),parent(Parent,Y),X\=Y.,Parents).
