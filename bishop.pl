:- module(bishop, [bishop/3, bishop/4]).

:- use_module(cells, 
    [ diagonals/3
    , project/3
    ]).

export(bishop/3).

% RULES
% MOVES
bishop(move, cell(Col, Row), Out) :-
    diagonals(cell(Col, Row), Ascending, Descending),
    append([Ascending, Descending], RawList),
    exclude(identical(cell(Col, Row)), RawList, Out).

% ATTACK
bishop(attack, cell(Col, Row), Out) :-
    diagonals(cell(Col, Row), Ascending, Descending),
    append([Ascending, Descending], RawList),
    exclude(identical(cell(Col, Row)), RawList, Out).

bishop(block, Locations, cell(Col, Row), cell(ColZ, RowZ)) :-
    member((_, BlockingCell), Locations),
    project(cell(Col, Row), cell(ColZ, RowZ), Projection),
    member(BlockingCell, Projection),!.

identical(A, B) :-
    A == B.