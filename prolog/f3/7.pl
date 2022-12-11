%class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '1 Seg', 11, 1).
class(pfl, t, '4 Qui', 10, 1).
class(pfl, tp, '2 Ter', 10.5, 2).
class(lbaw, t, '1 Seg', 8, 2).
class(lbaw, tp, '3 Qua', 10.5, 2).
class(ltw, t, '1 Seg', 10, 1).
class(ltw, t, '4 Qui', 11, 1).
class(ltw, tp, '5 Sex', 8.5, 2).
class(fsi, t, '1 Seg', 12, 1).
class(fsi, t, '4 Qui', 12, 1).
class(fsi, tp, '3 Qua', 8.5, 2).
class(rc, t, '4 Qui', 8, 2).
class(rc, tp, '5 Sex', 10.5, 2).

% a) same_day(+UC1,+UC2) que sucede se existem aulas de UC1 e UC2 que decorrem no
% mesmo dia
same_day(UC1,UC2):- class(UC1,_,Day,_,_),class(UC2,_,Day,_,_),UC1 \=UC2.

% b) daily_courses(+Day,-Courses) recebe um dia da semana e devolve uma lista com
% todas as UCS que têm aulas nesse dia.
daily_courses(Day,Courses):- setof(UC,(Day,T,H,D)^class(UC,T,Day,H,D),Courses).

% c) short_classes(-L) que devolve em L uma lista de todas as aulas com duração
% inferior a 2h (listas de termos no formato UC-Dia/Hora)
short_classes(L):- findall(UC-Dia/Hora,(class(UC,_,Dia,Hora,Time),Time < 2),L).

% d) course_classes(+Course,-Classes) 
% recebe uma UC e devolve uma lista com todas as aulas dessa UC (Dia/Hora-Tipo)
course_classes(Course,Classes):- findall(Dia/Hora-Tipo,class(Course,Tipo,Dia,Hora,_),Classes).

% e) courses(-L)
% Devolve uma lista com todas as UCs existentes sem repetidos
courses(L):- setof(UC,(T,D,H,DD)^class(UC,T,D,H,DD),L).

% f) schedule/0  Tive que implementar tudo de Raiz :(
% imprime todas as aulas por ordem de ocorrencia na semana.

% classes(-L) devolve em L todas as aulas em formato UC-Tipo/Dia:Hora-Duracao
classes(L):- findall(UC-Tipo/Dia:Hora-Duracao,class(UC,Tipo,Dia,Hora,Duracao),L).

% Imprime uma aula no formato de cima
print_class(UC-Tipo/Dia:Hora-Duracao):-
    traducao(Dia,DiaTraduzido),
    write("Dia:"),write(DiaTraduzido),
    Final is Hora + Duracao,
    write(" "),write(Hora),write("-"),write(Final),nl,
    write("Aula "),write(Tipo),
    write(" de "),write(UC),nl.

print_classes([]).
print_classes([X|XS]):- print_class(X),print_classes(XS).

% Para usar como parametro do quickSort para ordenar aulas por dias
atom_number(Atom,Number):- atom_chars(Atom, Y), number_chars(Number, Y).
keyByDay(_-_/X:_-_,_-_/Y:_-_):- 
    sub_atom(X,Space1,_,_,' '),
    sub_atom(X,0,Space1,_,Day1Atom),
    sub_atom(Y,Space2,_,_,' '),
    sub_atom(Y,0,Space2,_,Day2Atom),
    atom_number(Day1Atom,Day1),
    atom_number(Day2Atom,Day2),
    Day1 >= Day2.

% Para usar como parametro do quickSort para orderar aulas por hora
keyByHour(_-_/_:Hour1-_,_-_/_:Hour2-_):- Hour1 < Hour2.

% Concatena duas listas
concat([],L2,L2).
concat([X|XS],L2,[X|L3]):- concat(XS,L2,L3).

% Retorna os elementos que obdecem à Key especificada
smallerOrEqual(_,[],[],_):-!.
smallerOrEqual(X,[Y|YS],[Y|Rest],Key):- call(Key,X,Y),!,smallerOrEqual(X,YS,Rest,Key).
smallerOrEqual(X,[_|YS],Rest,Key):- smallerOrEqual(X,YS,Rest,Key).

% Retorna os elementos que não obdecem à key especificada
greaterThan(_,[],[],_):-!.
greaterThan(X,[Y|YS],[Y|Rest],Key):- \+ call(Key,X,Y),!,greaterThan(X,YS,Rest,Key).
greaterThan(X,[_|YS],Rest,Key):-greaterThan(X,YS,Rest,Key).


% QuickSort com uma Sorting Key
quickSort([],[],_).
quickSort([X|XS],Sorted,Key):- 
    smallerOrEqual(X,XS,Menores,Key),
    greaterThan(X,XS,Maiores,Key),
    quickSort(Menores,MenoresOrdenados,Key),
    quickSort(Maiores,MaioresOrdenados,Key),
    concat(MenoresOrdenados,[X|MaioresOrdenados],Sorted).

% Finalmente a funcao pedida :(
schedule:-
    classes(L),
    quickSort(L,OrderedHour,keyByHour),
    quickSort(OrderedHour,Ordered,keyByDay),
    print_classes(Ordered).

% g) traducao(?Interno,?Externo)
traducao('1 Seg',seg).
traducao('2 Ter',ter).
traducao('3 Qua',qua).
traducao('4 Qui',qui).
traducao('5 Sex',sex).

% h) Pergunta ao user por um dia e uma hora e retorna as aulas que estao a
% decorrer ou a comecar nessa hora.
find_class:-
    write("Desborir que aula esta a decorrer!\nDigite um dia(seg,ter,qua,qui,sex): "),
    read(DayExterno),
    write("Digite um hora: "),
    read(Hora),
    traducao(DayInterno,DayExterno),
    findall(UC/HoraInicio-Duracao,
    (class(UC,_,DayInterno,HoraInicio,Duracao),
    Hora >= HoraInicio,
    HoraFinal is HoraInicio + Duracao,
    Hora =< HoraFinal),AulasAgora),
    write(AulasAgora).


