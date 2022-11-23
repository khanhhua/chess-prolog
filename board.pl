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
    maplist([(Piece, Cell, NextPositions)] >> (
        print_positions(Piece, Cell, NextPositions)
        ), PossibleMoves),

    next_possible_attacks(MyPieces, EnemyPieces, PossibleAttacks),
    maplist([(Piece, Cell, NextAttacks)] >> (
        print_attacks(Piece, Cell, NextAttacks)
        ), PossibleAttacks).

next_possible_moves(MyPieces, EnemyPieces, PossibleMoves) :-
    pieces_cells(MyPieces, MyCells),
    pieces_cells(EnemyPieces, EnemyCells),
    convlist([(Piece, Cell), Out] >> (
        functor(_, Piece, 3),
        call(Piece, move, Cell, LegalCells),
        
        exclude(call(Piece, block, MyCells, EnemyCells, Cell), LegalCells, AccessibleCells),
        Out = (Piece, Cell, AccessibleCells)
    ), MyPieces, PossibleMoves).

next_possible_attacks(MyPieces, EnemyPieces, PossibleAttacks) :-
    pieces_cells(MyPieces, MyCells),
    pieces_cells(EnemyPieces, EnemyCells),
    
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
    format("Piece ~w at ~w:\n", [Piece, Cell]),
    maplist(format("- Next move: to ~q\n"), Positions).

print_attacks(Piece, Cell, Attacks) :-
    format("Piece ~w at ~w:\n", [Piece, Cell]),
    maplist([(EnemyPiece, EnemyCell)] >>
        format("- Next attack: ~w at ~w\n", [EnemyPiece, EnemyCell]),
        Attacks).

identical(A, B) :-
    A = B.

pieces_cells(Pieces, Cells) :-
    convlist([(_Piece, Cell), Out] >> (Out = Cell), Pieces, Cells).