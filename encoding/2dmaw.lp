%% expected INPUT:
% t(text-number, character-index, character)
% a(character)

1 { mawlength(M) : M = 1..textlength } 1.
%%% objective function
#minimize { M : mawlength(M) }. 



1 { maw(1,C) : a(C) } 1.

1 { maw(L+1,C) : a(C) } 1 :- maw(L,_), mawlength(M), L < M.

mismatch(K,J,L) :- t(K,J+L-1,C), maw(L,D), C != D, mawlength(M), J=1..textlength-M+1.
mismatch(J,L) :- texts { mismatch(K,J,L) : K=1..texts }, mawlength(M), L = 1..M, J=1..textlength-M+1.

:- { mismatch(J,L) } 0, mawlength(M), J=1..textlength-M+1.  

#show maw/2.
#show mismatch/3.
#show mismatch/2.

