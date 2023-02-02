%-----------------------------------------------------
%                   Cenas uteis
%-----------------------------------------------------
% Adicionar um Elemento a uma lista
append_elem(Elem,[],[Elem]).
append_elem(Elem,[X|XS],[X|YS]):- append_elem(Elem,XS,YS).

% Concatenar duas listas
concat([],YS,YS).
concat([X|XS],YS,[X|Rest]):- concat(XS,YS,Rest).

list_length([],0).
list_length([_|XS],L):-
    list_length(XS,L1),
    L is L1 + 1.

%-----------------------------------------------------

%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).
flight(london,valpacos,folarAirlines,fl2022,1240,200).


% a) get_all_nodes(-ListOfAirports) que devolve uma lista com todos os
% aeroportos servidos pelos voos na base de dados, sem duplicados.
get_all_nodes(ListOfAirports):-
    setof(Airport,
    (Dest,Origin,C,CC,H,Dur)^
    (
        flight(Airport,Dest,C,CC,H,Dur);
        flight(Origin,Airport,C,CC,H,Dur)
    )
    ,ListOfAirports).

% b)most_diversified(-Company) que devolve em Company a
% operadora com um número de destinos mais diversificado.
most_diversified(C):-
    setof(C-Destinies,
    (Origin,Destination,Code,Hour,Duration)^
    (
        flight(Origin,Destination,C,Code,Hour,Duration),
        get_all_company_destinations(C,Destinies)
    ),[First|Rest]),
    most_diversified_(Rest,First,C-_List).

get_all_company_destinations(Company,Destinations):-
    setof(Destination,
    (Origin,Destination,Company,Code,Hour,Duration)^
    flight(Origin,Destination,Company,Code,Hour,Duration),
    Destinations).


% Retorna a Company-DestinationsList em que a lista é maior
most_diversified_([],Result,Result).
most_diversified_([_C-List|Rest],C1-List1,Result):-
    list_length(List,L),
    list_length(List1,L1),
    L1 > L,!,
    most_diversified_(Rest,C1-List1,Result).
most_diversified_([C-List|Rest],_,Result):- most_diversified_(Rest,C-List,Result).


% c)find_flights(+Origin, +Destination, -Flights), que devolve em Flights uma
% lista com um ou mais (códigos de) voos que permitam ligar Origin a
% Destination. Use pesquisa em profundidade, evitando ciclos
:- dynamic visited/1.
find_flights(Origin,Destination,Flights):- 
    % Fazer clean up aqui
    abolish(visited/1),
    find_flights(Origin,Destination,[],Flights).

%flight(origin, destination, company, code, hour, duration)
find_flights(Destination,Destination,Flights,Flights).
find_flights(Origin,Destination,CurrentFlights,Flights):-
    asserta(visited(Origin)),
    setof(Destiny-Code,(Origin,Company,Hour,Duration)^
    (
        flight(Origin,Destiny,Company,Code,Hour,Duration),
        \+ visited(Destiny)
    ),Destinies),
    find_flights_(Destinies,Destination,CurrentFlights,Flights).
% Este facto é só porque o setof está a falhar em vez de retornar [].
find_flights(_,_,_,[]).

find_flights_([],_,_,[]).
find_flights_([Destination-C|_],Destination,CurrentFlights,Flights):-
    append_elem(C,CurrentFlights,Flights).
find_flights_([Destiny-Code|Rest],Destination,PFlights,Result):-
    append_elem(Code,PFlights,ThisFlights),
    find_flights(Destiny,Destination,ThisFlights,Flights),
    (
        Flights \= [] -> Result = Flights;
        find_flights_(Rest,Destination,PFlights,Result)
    ).
% d)predicado find_flights_breadth(+Origin, +Destination, -Flights), com o
% mesmo significado que o predicado anterior, mas usando pesquisa em largura.
find_flights_breadth(Origin,Destination,Flights):-
    abolish(visited/1),
    find_flights_breadth([Origin-0],Destination,[],Flights).

find_flights_breadth(Level,Destination,CurrentFlights,Result):-
    destiny_in_children(Level,Destination,C),!,
    append_elem(C,CurrentFlights,Result).
find_flights_breadth(Level,Destination,CurrentFlights,Result):-
    get_next_level(Level,NextLevel),
    find_flights_breadth(NextLevel,Destination,CurrentFlights,Result).

% Gets the Next Level In The BFS
get_next_level([],[]).
get_next_level([Origin-_|Rest],Level):-
    get_next_level(Rest,RestLevel),
    asserta(visited(Origin)),
    (setof(Destiny-C, (Origin,Company,Hour,Duration)^
    (
        flight(Origin,Destiny,Company,C,Hour,Duration),
        \+ visited(Destiny)
    ),Destinies),!; Destinies = []),
    concat(Destinies,RestLevel,Level).

% Returns the code of the trip if the destination is in the level
destiny_in_children([Destination-C|_],Destination,C).
destiny_in_children([_|Rest],Destination,Code):- destiny_in_children(Rest,Destination,Code).

%e) find_all_flights (+Origin, +Destination, -ListOfFlights), que devolve em
% ListOfFlights uma lista com todas as possíveis formas de ligar Origin a
% Destination (cada uma representada como uma lista de [códigos de] voos).
find_all_flights_dfs(Origin,Destination,ListOfFlights):-
    setof(Flights,find_flights(Origin,Destination,Flights),ListOfFlights).

find_all_flights_bfs(Origin,Destination,ListOfFlights):-
    setof(Flights,find_flights_breadth(Origin,Destination,Flights),ListOfFlights).
