#!/usr/bin/env swipl -q -t main

:- use_module(pawn, [pawn/3]).

:- debug.

main :-
    assert(loc(pawn, cell_a2)),
    assert(loc(pawn, cell_b2)),
    assert(loc(pawn, cell_c2)),
    bagof((Piece, Cell), loc(Piece, Cell), Ps),!,
    % length(Ps, Count),
    % format("Count ~w\n", [Count]),
    convlist([(Piece, Cell), Out] >> (
        % format("Piece ~w at ~w\n", [Piece, Loc]),
        functor(_, Piece, 3),
        bagof(A, call(Piece, move, Cell, A), As),
        % print_positions(Piece, Cell, As),
        Out = (Piece, Cell, As)
    ), Ps, PossibleMoves),
    % length(Ass, Count),
    % format("Count ~w\n", [Count]),
    maplist([(Piece, Cell, NextPositions)] >> (
        format("Piece ~w at cell ~w:\n", [Piece, Cell]),
        maplist(format("- Next position: ~w\n"), NextPositions)
        ), PossibleMoves).

print_positions(Piece, Cell, Positions) :-
    maplist(print_p(Piece, Cell), Positions).

print_p(Piece, Cell, Position) :-
    format("Piece ~q at ~q moves to ~q", [Piece, Cell, Position]), nl.