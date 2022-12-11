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

% Considerando a query:
% ?- adult(X).
%
%
%
% Imaginemos que temos a seguinte base de conhecimento:
% person(lara).
% age(lara,17).
% turtle(oldboy).
% age(oldboy,51).

% Estariamos á espera que ?- adult(X). resultasse em X = oldboy
% Mas se corressmos este exemplo obtemos false/no
%                   ?- adult(X)
%                      /
%                  person(X) -> Instancia pela ordem dos factos, X = Lara
%                     /
%                    ! -> Stop backtracking na instanciacao de X
%                    /
%                   age(lara,N) -> N = 17
%                   /
%                  17 >= 18 False  
%  tentamos dar backtracking na escolha de X mas não conseguimos  devido aquele cut logo temos que
%  adult(X) é false, coisa que não aconteceria se não tivesse lá o cut então é vermelho.

