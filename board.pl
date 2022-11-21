#!/usr/bin/env swipl -q -t main

:- use_module(cells, [cell/2]).
:- use_module(pawn, [pawn/3]).

:- debug.

main :-
    assert(loc(white, pawn, cell(a, 2))),
    assert(loc(white, pawn, cell(b, 2))),
    assert(loc(white, pawn, cell(c, 2))),
    bagof((Piece, Cell), loc(white, Piece, Cell), Ps),!,
    % length(Ps, Count),
    % format("Count ~w\n", [Count]),
    next_possible_moves(Ps, PossibleMoves),
    % length(Ass, Count),
    % format("Count ~w\n", [Count]),
    maplist([(Piece, Cell, NextPositions)] >> (
        format("Piece ~w at cell ~w:\n", [Piece, Cell]),
        maplist(format("- Next position: ~w\n"), NextPositions)
        ), PossibleMoves).

next_possible_moves(PieceAtCells, PossibleMoves) :-
    convlist([(Piece, Cell), Out] >> (
        functor(_, Piece, 3),
        call(Piece, move, Cell, NextCells),
        % print_positions(Piece, Cell, As),
        Out = (Piece, Cell, NextCells)
    ), PieceAtCells, PossibleMoves).

print_positions(Piece, Cell, Positions) :-
    maplist(print_p(Piece, Cell), Positions).

print_p(Piece, Cell, Position) :-
    format("Piece ~q at ~q moves to ~q", [Piece, Cell, Position]), nl.