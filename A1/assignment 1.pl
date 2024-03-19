/* PART A


a.)*/

% Base case for reflexivity
is_in_ref_trans_closure(A, B, _, _) :- A = B.

% Recursive case for transitivity
is_in_ref_trans_closure(A, B, R, S) :-
    member((A, X), R),
    member(X, S),
    is_in_ref_trans_closure(X, B, R, S).


member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

/*

is_in_ref_trans_closure(1, 1, [(1,2), (2,3)], [1, 2, 3]).

is_in_ref_trans_closure(1, 3, [(1,2), (2,3)], [1, 2, 3]).

is_in_ref_trans_closure(1, 4, [(1,2), (2,3)], [1, 2, 3, 4]).

is_in_ref_trans_closure(1, 4, [(1,2), (2,3), (3,4)], [1, 2, 3, 4]).

is_in_ref_trans_closure(1, 5, [(1,2), (2,3)], [1, 2, 3]).

is_in_ref_trans_closure(1, 2, [(1,2), (2,1)], [1, 2]).

is_in_ref_trans_closure(1, 1, [], []).

is_in_ref_trans_closure(1, 2, [], []). */


/* b */

% Base case for reflexivity
is_in_ref_sym_trans_closure(A, B, _, _) :- A = B.

% Recursive case for symmetry and transitivity
is_in_ref_sym_trans_closure(A, B, R, S) :-
    member(X, S),

    (   member((A, X), R); member((X, A), R) ),
    is_in_ref_sym_trans_closure(X, B, R, S).

/* PART B

1. Assuming no duplicates in S1, S2

here is an implementation of union of S1, S2 */



unionI([ ], S2, S2) :- !.

unionI(S1, [ ], S1) :- !.

unionI([X|R], S2, [X|Z]) :- del(X, S2, S3),  unionI(R, S3, Z).



/* 1. a) 

?- unionI([1, 2, 3], [2, 3, 4], Union).
Union = [1, 2, 3, 4]

?- unionI([], [1, 2, 3], Union).
Union = [1, 2, 3]

?- unionI([1, 2, 3], [], Union).
Union = [1, 2, 3]

?- unionI([1], [2], Union).
Union = [1, 2]

?- unionI([1, 2, 3], [4, 5, 6], Union).
Union = [1, 2, 3, 4, 5, 6]
*/


/* append(L1, L2, L3) -- append lis  L1 to list L2 to get list  L3 */

append( [ ], L, L).

append( [X|R], L, [X|Z]) :- append(R, L, Z).

/* mapcons(X,L1, L2) --  cons the element X to each list in L1 to get L2 */

mapcons(X, [ ], [ ]) :- !.

mapcons(X, [Y|R], [ [X|Y] | Z ]) :- mapcons(X, R, Z).



/*  powerI( S, P1): Here is an implementation of powerset of S */

powerI([ ], [ [ ] ]) :- !.

powerI([X|R], P) :- powerI(R, P1),  mapcons(X, P1, P2), append(P2, P1, P).

/* 1. b) 

?- powerI([], P).
P = [[]].


?- powerI([1], P).
P = [[], [1]].


?- powerI([1, 2], P).
P = [[], [2], [1], [1, 2]].

?- powerI([1, 2, 3], P).
P = [[], [3], [2], [2, 3], [1], [1, 3], [1, 2], [1, 2, 3]].

?- powerI([a, b], P).
P = [[], [b], [a], [a, b]].

*/


/* 2.

?- unionI([1, 2, 3], [2, 3, 4], Union).
?- unionI([1, 2, 3], [1, 2, 3], Union).
?- unionI([1, 2], [1, 2, 3, 4], Union).
?- unionI([1, 2, 3], [4, 5, 6], Union).
?- unionI([], [], Union).

*/


/* 3. Assuming no duplicates in lists representing S1 and S2, write a PROLOG program  interI(S1, S2, S3) that implements intersection of two finite sets. */


interI([], _, []).
interI([X|R], S2, [X|Z]) :- member(X, S2), !, interI(R, S2, Z).
interI([_|R], S2, Z) :- interI(R, S2, Z).


/* 4. Assuming no duplicates in lists representing S1 and S2, write a PROLOG program  diffI(S1, S2, S3) that implements set-difference of two finite sets. */


diffI([], _, []).
diffI([X|R], S2, Z) :- member(X, S2), !, diffI(R, S2, Z).
diffI([X|R], S2, [X|Z]) :- diffI(R, S2, Z).


/* 5. Assuming no duplicates in lists representing S1 and S2, write a PROLOG program  cartesianI(S1, S2, S3) that implements cartesian of two finite sets. */


pairWith(_, [], []).
pairWith(X, [Y|R], [[X,Y]|Z]) :- pairWith(X, R, Z).

cartesianI([], _, []).
cartesianI([X|R], S2, Z) :- pairWith(X, S2, Z1), cartesianI(R, S2, Z2), append(Z1, Z2, Z).



/* 6. Provide sufficient test cases examples to demonstrate your implementations are correct.

?- interI([1, 2, 3], [2, 3, 4], Intersection).
Intersection = [2, 3].


?- interI([1, 2], [3, 4], Intersection).
Intersection = [].

?- interI([], [1, 2, 3], Intersection).
Intersection = [].

?- interI([1, 2, 3], [], Intersection).
Intersection = [].

?- interI([], [], Intersection).
Intersection = [].

?- diffI([1, 2, 3], [2, 3, 4], Difference).
Difference = [1].

?- diffI([1, 2], [3, 4], Difference).
Difference = [1, 2].

?- diffI([], [1, 2, 3], Difference).
Difference = [].

?- diffI([1, 2, 3], [], Difference).
Difference = [1, 2, 3].

?- diffI([], [], Difference).
Difference = [].

?- cartesianI([1, 2], [3, 4], CartesianProduct).
CartesianProduct = [[1, 3], [1, 4], [2, 3], [2, 4]].

?- cartesianI([], [1, 2], CartesianProduct).
CartesianProduct = [].

?- cartesianI([1, 2], [], CartesianProduct).
CartesianProduct = [].

?- cartesianI([], [], CartesianProduct).
CartesianProduct = [].


*/


/* 7 Suggest a way to check that the powersets obtained from the implementation of two different valid representations of a set (elements given in different order) are equal. 

    we can write a predict to sort each subset in the powerset.

    then we can sort the entire powerset. we will get ourt subset in a consistent order.
    then we will compare tow powersets, sort each using the predicate,  then will check if they are identical.



*/












