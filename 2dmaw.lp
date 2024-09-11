#const textlength=5.
#const texts=2.

1 { mawlength(M) : M = 1..textlength } 1.
%%% objective function
#minimize { M : mawlength(M) }. 

%text t(text-number, character-index, character)

t(1,1,"b").
t(1,2,"a").
t(1,3,"b").
t(1,4,"a").
t(1,5,"a").

t(2,1,"b").
t(2,2,"b").
t(2,3,"a").
t(2,4,"c").
t(2,5,"c").

% alphabet('a')
a("a").
a("b").

1 { maw(1,C) : a(C) } 1.

1 { maw(L+1,C) : a(C) } 1 :- maw(L,_), mawlength(M), L < M.

mismatch(K,J,L) :- t(K,J+L-1,C), maw(L,D), C != D, mawlength(M), J=1..textlength-M+1.
mismatch(J,L) :- texts { mismatch(K,J,L) : K=1..texts }, mawlength(M), L = 1..M, J=1..textlength-M+1.

:- { mismatch(J,L) } 0, mawlength(M), J=1..textlength-M+1.  

#show maw/2.
#show mismatch/3.
#show mismatch/2.

