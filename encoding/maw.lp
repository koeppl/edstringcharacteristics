%% expected INPUT:
% t(text-number, character-index, character)
% a(character) : selectable characters from the alphabet (not required for MUS)
% #const r=maximum size of a symbol
% #const n=length of each input text

% select the length of X[1..x], i.e., the output we want to model
1 { len(X) : X = 1..n } 1. %% (LENX)

% optimization: shorten the length x as much as possible
#minimize { X : len(X) }. %% (MINX)

% set X[l] = c for a character c from the alphabet A
1 { x(L,C) : a(C) } 1 :- len(X), L=1..X. %% (SETX)

% if X[l] = d != c = T[j+l-1][k], then count this mismatch in M[k,t,l]
m(K,T,L) :- t(K,T+L-1,C), x(L,D), C!=D, len(X), T=1..n-X+1. %% (M)

% if X[l] mismatches with all r elements in T[j+l-1], then count this mismatch in M[t,l]
m(T,L) :- r { m(K,T,L) : K=1..r }, len(X), L = 1..X, T=1..n-X+1. %% (M')

% check that we have a mismatch for all text positions
:- { m(T,L) } 0, len(X), T=1..n-X+1. %% (CONS)

% show the computed MAW
#show x/2.

% #show m/3. 
% #show m/2. 
