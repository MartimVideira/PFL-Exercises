immature(X):- adult(X), !, fail.
immature(X).

% O primeiro cut é vermelho, sem o cut se adult(X) avaliar em falso,por
% backtracking vamos calhar na regra immature(X). que diz que tudo é imaturo
% suponhamos adult(lara).
%                 ?- immature(Lara).
%                    /
%  (True continuamos)X= Lara 
%                    |
%                    ! (Stop backtracking)
%                    |
%                    fail -> False  então com o cut se a Lara é adulta -> a Lara não é imatura
%
%                 ?- immature(Laura).
%                          /        \
%  (False então   adult(Laura)      imature(Laura). (True) -> Como laura não é adulta é imatura
%   backtracking)
%
%
%
% Imaginemos immature(X):- adult(X),fail. e outravez adult(lara).
%                   ?- immature(lara).
%                       /           \ 
%                   X= Lara         immature(lara).  -> se lara é adulta , sem o cut , lara é imatura.
%                       |                  True                     ou seja temos um red cut
%                      fail
%  Ou seja falso mas nada impede o backtracking


adult(X):- person(X), !, age(X, N), N >=18.
adult(X):- turtle(X), !, age(X, N), N >=50.
adult(X):- spider(X), !, age(X, N), N>=1.
adult(X):- bat(X), !, age(X, N), N >=5.

%  Neste conjunto de regras penso que o cut é verde SE E SÓ se garantirmos que
%  não temos seres que são pertencem a mais do que um grupo
%  (person,turtle,bat,spider...) por exemplo as tartarugas ninjas ou o spiderman
person("Peter Parker").
spider("Peter Parker").
age("Peter Parker",17).

person("Michelangelo").
turtle("Michelangelo").
age("Michelangelo",21).

% Sem o cut :
%  ?- adult("Peter Parker"). daria false e depois true.
%  ?- adult("Michelangelo"). daria true e depois false
