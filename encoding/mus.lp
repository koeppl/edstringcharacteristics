%% expected INPUT:
% t(text-number, character-index, character)
% a(character) : selectable characters from the alphabet (not required for MUS)
% #const r=maximum size of a symbol
% #const n=length of each input text

% select the length of X[1..x], i.e., the output we want to model
1 { len(X) : X = 1..n } 1. %% (LENX)

% optimization: shorten the length x as much as possible
#minimize { X : len(X) }. %% (MINX)

% select the position p of the first character of the output matching the text
1 { pos(P) : P = 1..n } 1. %% (POSP)

% select X[l] from the list T[p+l-1] for every l
1 { x(L,C) : t(K,P+L-1,C) } 1 :- len(X), pos(P), L = 1..X. %% (SELX)

% see MAW encoding
m(K,T,L) :- t(K,T+L-1,C), x(L,D), C != D, len(X), T=1..n-X+1. %% (M)
m(T,L) :- r { m(K,T,L) : K=1..r }, len(X), L = 1..X, T=1..n-X+1. %% (M')

% unlike to (CONS) in MAW, we omit the constraint for t = p
:- { m(T,L) } 0, len(X), pos(P), T=1..n-X+1, T != P.  %% (CONS)

% show the computed MUS
#show x/2.

% #show m/3. 
% #show m/2. 
