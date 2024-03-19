:- use_module(library(lists)).

% Base cases for literals and variables
hastype(_, num(N), intT) :- integer(N).
hastype(_, B, boolT) :- member(B, [true, false]).
hastype(G, var(X), T) :- member((X, T), G).

% Arithmetic operations
hastype(G, add(E1, E2), intT) :-
    hastype(G, E1, intT), hastype(G, E2, intT).
hastype(G, sub(E1, E2), intT) :-
    hastype(G, E1, intT), hastype(G, E2, intT).
hastype(G, mul(E1, E2), intT) :-
    hastype(G, E1, intT), hastype(G, E2, intT).
hastype(G, div(E1, E2), intT) :-
    hastype(G, E1, intT), hastype(G, E2, intT), E2 \= num(0).
hastype(G, mod(E1, E2), intT) :-
    hastype(G, E1, intT), hastype(G, E2, intT).

% Boolean operations
hastype(G, and(E1, E2), boolT) :-
    hastype(G, E1, boolT), hastype(G, E2, boolT).
hastype(G, or(E1, E2), boolT) :-
    hastype(G, E1, boolT), hastype(G, E2, boolT).
hastype(G, not(E), boolT) :-
    hastype(G, E, boolT).

% Comparison operations
hastype(G, eq(E1, E2), boolT) :-
    hastype(G, E1, intT), hastype(G, E2, intT).
hastype(G, gt(E1, E2), boolT) :-
    hastype(G, E1, intT), hastype(G, E2, intT).
hastype(G, lt(E1, E2), boolT) :-
    hastype(G, E1, intT), hastype(G, E2, intT).
hastype(G, neq(E1, E2), boolT) :-
    hastype(G, E1, intT), hastype(G, E2, intT).

% If-then-else expressions (assuming the branches have the same type)
hastype(G, if(E, E1, E2), T) :-
    hastype(G, E, boolT),
    hastype(G, E1, T),
    hastype(G, E2, T).

% Let expressions
hastype(G, let(X, E1, E2), T) :-
    hastype(G, E1, T1),
    hastype([(X, T1)|G], E2, T).

% Unit type for expressions that do not return a value
hastype(_, unit, unitT).