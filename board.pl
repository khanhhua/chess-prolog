#!/usr/bin/env swipl -q -t main

:- use_module(cells, [cell/2]).
:- use_module(pawn, [pawn/3, pawn/4]).
:- use_module(knight, [knight/3, knight/4]).
:- use_module(rook, [rook/3, rook/4]).
:- use_module(bishop, [bishop/3, bishop/4]).

:- debug.

main :-
    assert(loc(white, pawn, cell(h, 2))),
    assert(loc(white, pawn, cell(b, 2))),
    assert(loc(white, pawn, cell(c, 2))),
    assert(loc(white, rook, cell(h, 1))),
    assert(loc(white, knight, cell(b, 1))),
    assert(loc(white, bishop, cell(c, 1))),
    bagof((Piece, Cell), loc(white, Piece, Cell), PiecesOnBoard),!,
    % length(Ps, Count),
    % format("Count ~w\n", [Count]),
    next_possible_moves(PiecesOnBoard, PossibleMoves),
    % length(Ass, Count),
    % format("Count ~w\n", [Count]),
    maplist([(Piece, Cell, NextPositions)] >> (
        format("Piece ~w at ~w:\n", [Piece, Cell]),
        maplist(format("- Next position: ~w\n"), NextPositions)
        ), PossibleMoves).

next_possible_moves(PiecesOnBoard, PossibleMoves) :-
    convlist([(Piece, Cell), Out] >> (
        functor(_, Piece, 3),
        call(Piece, move, Cell, LegalCells),
        
        exclude(call(Piece, block, PiecesOnBoard, Cell), LegalCells, AccessibleCells),
        Out = (Piece, Cell, AccessibleCells)
    ), PiecesOnBoard, PossibleMoves).

print_positions(Piece, Cell, Positions) :-
    maplist(print_p(Piece, Cell), Positions).

print_p(Piece, Cell, Position) :-
    format("Piece ~q at ~q moves to ~q", [Piece, Cell, Position]), nl.