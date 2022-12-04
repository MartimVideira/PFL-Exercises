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
