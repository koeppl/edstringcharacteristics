#const textlength=5.

1 { mawlength(M) : M = 1..textlength } 1.
%%% objective function
#minimize { M : mawlength(M) }. 


t(1,"b").
t(2,"a").
t(3,"b").
t(4,"a").
t(5,"a").

a("a").
a("b").

1 { maw(1,C) : a(C) } 1.

1 { maw(L+1,C) : a(C) } 1 :- maw(L,_), mawlength(M), L < M.

mismatch(J,L) :- t(J+L-1,C), maw(L,D), C != D, mawlength(M), L = 0..M-1, J=1..textlength-M+1.

:- { mismatch(J,L) } 0, mawlength(M), J=1..textlength-M+1.

% sub(I,C,1) :- t(I,C). 
% sub(I,C+D,L+1) :- sub(I,C,L), t(I+L,D). 

% " a(0,"a"). 
% " a(0,"ab"). 
