#!/usr/bin/env swipl -q -t main

:- use_module(cells, [cell/2]).
:- use_module(pawn, [white_pawn/3, white_pawn/5]).
:- use_module(knight, [knight/3, knight/5]).
:- use_module(rook, [rook/3, rook/5]).
:- use_module(bishop, [bishop/3, bishop/5]).

:- debug.

main :-
    assert(loc(black, black_pawn, cell(a, 7))),
    assert(loc(black, black_pawn, cell(c, 3))),
    % assert(loc(white, white_pawn, cell(h, 2))),
    % assert(loc(white, white_pawn, cell(b, 2))),
    % assert(loc(white, white_pawn, cell(c, 2))),
    % assert(loc(white, rook, cell(h, 1))),
    % assert(loc(white, bishop, cell(c, 1))),
    assert(loc(white, rook, cell(a, 1))),
    assert(loc(white, knight, cell(b, 1))),

    % length(Ps, Count),
    % format("Count ~w\n", [Count]),
    bagof((Piece, Cell), loc(white, Piece, Cell), MyPieces),
    bagof((Piece, Cell), loc(black, Piece, Cell), EnemyPieces),!,

    next_possible_moves(MyPieces, EnemyPieces, PossibleMoves),
    % length(Ass, Count),
    % format("Count ~w\n", [Count]),
    maplist([(Piece, Cell, NextPositions)] >> (
        format("Piece ~w at ~w:\n", [Piece, Cell]),
        maplist(format("- Next position: ~w\n"), NextPositions)
        ), PossibleMoves),

    next_possible_attacks(MyPieces, EnemyPieces, PossibleAttacks),
    maplist([(Piece, Cell, NextAttacks)] >> (
        format("Piece ~w at ~w:\n", [Piece, Cell]),
        maplist([(EnemyPiece, EnemyCell)]>>format("- Next attack: ~w at ~w\n", [EnemyPiece, EnemyCell]), NextAttacks)
        ), PossibleAttacks).

next_possible_moves(MyPieces, EnemyPieces, PossibleMoves) :-
    convlist([(Piece, Cell), Out] >> (Out = Cell), MyPieces, MyCells),
    convlist([(Piece, Cell), Out] >> (Out = Cell), EnemyPieces, EnemyCells),
    convlist([(Piece, Cell), Out] >> (
        functor(_, Piece, 3),
        call(Piece, move, Cell, LegalCells),
        
        exclude(call(Piece, block, MyCells, EnemyCells, Cell), LegalCells, AccessibleCells),
        Out = (Piece, Cell, AccessibleCells)
    ), MyPieces, PossibleMoves).

next_possible_attacks(MyPieces, EnemyPieces, PossibleAttacks) :-
    convlist([(Piece, Cell), Out] >> (Out = Cell), MyPieces, MyCells),
    convlist([(Piece, Cell), Out] >> (Out = Cell), EnemyPieces, EnemyCells),

    % format('OccupiedCells: ~w', [OccupiedCells]),nl,
    % format('EnemyPieces: ~w', [EnemyPieces]),nl,
    % format('PiecesOnBoard: ~w', [PiecesOnBoard]),nl,
    % convlist([(_, Cell), Out] >> (Out = Cell), EnemyPieces, EnemyCells),!,
    % format('MyCells: ~w', [MyCells]),nl,
    % format('EnemyCells: ~w', [EnemyCells]),nl,
    
    convlist([(Piece, Cell), Out] >> (
        functor(_, Piece, 3),
        % TODO bagof all AttackCells...
        bagof((EnemyPiece, AttackCell),
            ( member(AttackCell, EnemyCells)
            , call(Piece, attack, Cell, AttackCell)
            , not(call(Piece, block, MyCells, EnemyCells, Cell, AttackCell))
            , member((EnemyPiece, AttackCell), EnemyPieces)
            ), AccessibleCells),
        Out = (Piece, Cell, AccessibleCells)    
    ), MyPieces, PossibleAttacks).

print_positions(Piece, Cell, Positions) :-
    maplist(print_p(Piece, Cell), Positions).

print_p(Piece, Cell, Position) :-
    format("Piece ~q at ~q moves to ~q", [Piece, Cell, Position]), nl.

identical(A, B) :-
    A = B.