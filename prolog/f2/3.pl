cargo(tecnico, eleuterio).
cargo(tecnico, juvenaldo).
cargo(analista, leonilde).
cargo(analista, marciliano).
cargo(engenheiro, osvaldo).
cargo(engenheiro, porfirio).
cargo(engenheiro, reginaldo).
cargo(supervisor, sisnando).
cargo(supervisor_chefe, gertrudes).
cargo(secretaria_exec, felismina).
cargo(diretor, asdrubal).

chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).


% a/b)
% i. | ?- chefiado_por(analista, X), cargo(X, sisnando).
%  O cargo do sisnando que é chefiado por um analista
%  supervisor
% ii. | ?- chefiado_por(tecnico, X), chefiado_por(X, Y).
%  Os cargos que chefeiam tecnico e que são chefiados por outros cargos
% X = engenheiro Y = supervisor
% iii. | ?- cargo(J, P), chefiado_por(J, supervisor).
%  Os cargos são chefiados por um supervisor  e as pessoas que tem esse cargo 
%  J = analista P = leonilde
% iv. | ?- chefiado_por(P, diretor), \+(cargo(P, felismina)).
% Os cargos chefiados pelo diretor e que não sejam ocupados pela felismina
% gertrudes


% c)
% i) A pessoa X é chefe da Pessoa Y
chefe(X,Y) :- cargo(Chefiado,Y),
              cargo(Chefe,X),
              chefiado_por(Chefiado,Chefe).

% ii) As pessoas X e Y são chefiadas por pessoas com o mesmo cargo?
chefesComMesmoCargo(X,Y) :- chefe(Chefe1,X),
                            chefe(Chefe2,Y),
                            cargo(Cargo,Chefe1),
                            cargo(Cargo,Chefe2).

% iii) Cargo X não é responsável por nenhum outro cargo
cargoSemChefiados(X) :- cargo(X,_),(\+ chefiado_por(_,X)).

% iv) Quem são as pessoas que não são chefiadas por ninguem.
cargoSemChefe(X) :- cargo(X,_), (\+ chefiado_por(X,_)).


% superior(?X,?Y)
% Pessoa X ocupa um cargo superior ao cargo da pessoa Y
superior(X,Y):- chefe(X,Y).
superior(X,Y):- chefe(X,Z),superior(Z,Y).

