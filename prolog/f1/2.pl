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
