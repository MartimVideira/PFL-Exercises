:- use_module(library(clpfd)).
% a) print_n(+S, +N) que imprime N vezes na consola o símbolo S.
print_n(_,0):-!.
print_n(S,N):-N1 is N -1, write(S),print_n(S,N1).

% b) print_text(+Text, +Symbol, +Padding) que imprime o texto presente no
% primeiro argumento (usando aspas) com o padding indicado no terceiro
% argumento (número de espaços antes e depois do texto)
print_text(Text,Symbol,Padding):- 
    write(Symbol),
    print_n(' ',Padding),
    print_string(Text),
    print_n(' ',Padding),
    write(Symbol).

% c) print_banner(+Text, +Symbol, +Padding) 
print_banner(Text, Symbol, Padding):- 
    string_length(Text,TextLen),
    TotalLen #= TextLen + 2 + Padding + Padding,
    TotalSpace #= TotalLen - 2,
    print_n(Symbol,TotalLen),nl,
    write(Symbol),print_n(' ',TotalSpace),write(Symbol),nl,
    print_text(Text,Symbol,Padding),nl,
    write(Symbol),print_n(' ',TotalSpace),write(Symbol),nl,
    print_n(Symbol,TotalLen).


% d) o read_number(-X) que lê um número da entrada padrão, dígito a dígito.
% from_code_to_digit(+Code,?Digit).
% Converts the a code to the corresponding digit
from_code_to_digit(Code,Digit):-
    char_code('0',ZeroCode),
    Digit is Code - ZeroCode,
    Digit  <10,
    Digit >=0.

read_number(X):- read_number(0,X).
read_number(X,X):- peek_code(10),get_code(10),!.
read_number(Total,X):- 
    get_code(NextCode),
    from_code_to_digit(NextCode,Digit),
    NewTotal is Total*10 + Digit,
    read_number(NewTotal,X).

% e) read_until_between(+Min,+Max,-Value)  que peça ao utilizador para inserir
% um inteiro entre Min e Max, e retorne apenas quando o valor inserido estiver
% entre esses limites
read_until_between(Min,Max,Value):- 
    read_number(Value),
    format("Read:~d, it must be in [~d,~d]\n",[Value,Min,Max]),
    Value >= Min,
    Value =< Max,!.
read_until_between(Min,Max,Value):- read_until_between(Min,Max,Value).

% f) read_string(-X) que lê uma cadeia de caracteres da entrada padrão, caráter
% a caráter, devolvendo uma string (ie, uma lista de códigos ASCII).
read_string([]):- peek_code(10),get_code(10),!.
read_string([NextCode|Rest]):- get_code(NextCode),read_string(Rest).
                
print_string([]).
print_string([Code|Codes]):-put_code(Code),print_string(Codes).
% g)  banner que pede ao utilizador os argumentos a usar numa chamada ao predicado  print_banner e o executa
% print_string(+X). prints string X and X is a list of codes

banner:- write("Banner's Text:"),
         read_string(TextCodes),
         string_codes(Text,TextCodes),
         write("Banner's Symbol:"),
         get_char(Symbol),get_char(_Trash),
         write("Banner's Padding:"),
         read_until_between(0,10,Padding),nl,
         print_banner(Text,Symbol,Padding).

% h) print_multi_banner(+ListOfTexts, +Symbol, +Padding) que imprime várias
% linhas de texto no formato de um banner, usando a linha de maior comprimento
% para cálculo do padding a usar nas restantes.

max_len_rec([],X,X).
max_len_rec([S|SS],N,X):- length(S,N1),N1 > N,!, max_len_rec(SS,N1,X).
max_len_rec([_|SS],N,X):- max_len_rec(SS,N,X).
max_len(SS,N):- max_len_rec(SS,0,N).

% Como vamos meter o padding dos dois lados se a diferenca de comprimento entre o texto maior e um qualuqer texto não for par
% vamos ter um problema de alinhamento podemos fazer um pequeno hack de acrescentar um espaco para corrigir
adjusted_text(Text,MaxLen,Text):- 
    length(Text,TextLen),
    0 is (MaxLen - TextLen) mod 2,
    !.
adjusted_text(Text,_,[32|Text]).


print_multi_banner([],_Symbol,_Padding,_MaxLen).
print_multi_banner([T|TS],Symbol,Padding,MaxLen):-
    adjusted_text(T,MaxLen,AdjustedT),
    length(AdjustedT,AdjustedLen),
    TruePadding is (MaxLen - AdjustedLen + 2 * Padding) div 2,
    print_text(AdjustedT,Symbol,TruePadding),nl,
    print_multi_banner(TS,Symbol,Padding,MaxLen).

print_multi_banner(ListOfTexts,Symbol,Padding):-
    max_len(ListOfTexts,MaxLen),
    format("Max Len is ~d\n",[MaxLen]),
    TotalLen is MaxLen + Padding*2 + 2,
    TotalSpace is TotalLen - 2,
    print_n(Symbol,TotalLen),nl,
    write(Symbol),print_n(' ',TotalSpace),write(Symbol),nl,
    print_multi_banner(ListOfTexts,Symbol,Padding,MaxLen),
    write(Symbol),print_n(' ',TotalSpace),write(Symbol),nl,
    print_n(Symbol,TotalLen).


% i) oh_christmas_tree(+N) imprime a árvore de tamanho N
%                                     *
%                       *            ***     
%             *        ***          *****    
%      *     ***      *****        *******   
%  *  ***   *****    *******      *********  
%  *   *      *         *             *      
                                  
% Ver o Padrao e  traduzir o padrao para o prolog

down_grade([[*]],[[*]]).
down_grade([[*,*|Columns]|Lines],[Columns|LinesPurged]):-down_grade(Lines,LinesPurged).

oh_christmas_tree(1,[[*],[*]]).
oh_christmas_tree(N,[[*]|Rest]):-
    N1 is N -1,
    down_grade(Rest,Rest1),
    oh_christmas_tree(N1,Rest1),!.
                
print_christmas_tree(_,[]).
print_christmas_tree(N,[Level|Levels]):-
    length(Level,Len),
    Padding is N - ((Len -1) div 2),
    print_text(Level,' ',Padding),nl,
    print_christmas_tree(N,Levels).

oh_christmas_tree(N):-
    oh_christmas_tree(N,Tree),!,
    print_christmas_tree(N,Tree).

