% a) add_person/0 questiona o utilizador sobre uma nova pessoa (male vs female,
% e nome), e acrescenta-a à base de conhecimento.
add_person(MaleOrFemale,Name):-
    (MaleOrFemale = male; MaleOrFemale = female),
    C=..[MaleOrFemale,Name],
    asserta(C).
add_person:-
    write('male vs female:'),
    read(MaleOrFemale),
    write('Name:'),
    read(Name),
    add_person(MaleOrFemale,Name).

% b) add_parents(+Person) questiona o utilizador sobre os progenitores de
% Person, acrescentando depois essa informação à base de conhecimento.
add_parents(Person):-
    write('Dad:'),
    read(Dad),
    write('Mom:'),
    read(Mom),
    asserta(parent(Mom,Person)),
    asserta(parent(Dad,Person)).

% c) remove_person/0 questiona o utilizador sobre uma pessoa a remover da base
% de conhecimento, removendo-o, e a quaisquer relações em que a pessoa esteja
% envolvida.
remove_person:-
    write('Pessoa a remover:'),
    read(Person),
    setof(Predicado,current_predicate(Predicado),Predicados)
    retractall(male(Person)),
    retractall(female(Person)),
    retractall(parent(Person,_)),
    retractall(person(_,Person)).

