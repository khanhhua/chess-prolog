:- module(rook, [rook/3, rook/4]).

:- use_module(cells, 
    [ cell/2
    , horizontal/2
    , vertical/2
    , project/3
    ]).

export(rook/3).

% RULES
% MOVES
rook(move, cell(Col, Row), Out) :-
    bagof(Cells,
        ( horizontal(Row, Cells)
          ; vertical(Col, Cells)
        ), Bag),
    append(Bag, RawList),
    exclude(identical(cell(Col, Row)), RawList, Out).

% ATTACK
rook(attack, cell(Col, Row), Out) :-
    bagof(Cells,
        ( horizontal(Row, Cells)
        ; vertical(Col, Cells)
        ), Bag),
    append(Bag, RawList),
    exclude(identical(cell(Col, Row)), RawList, Out).

rook(block, Locations, cell(Col, Row), cell(Col, RowZ)) :-
    member((_, BlockingCell), Locations),
    project(cell(Col, Row), cell(Col, RowZ), Projection),
    member(BlockingCell, Projection),!.
rook(block, Locations, cell(Col, Row), cell(ColZ, Row)) :-
    member((_, BlockingCell), Locations),
    project(cell(Col, Row), cell(ColZ, Row), Projection),
    member(BlockingCell, Projection),!.

identical(A, B) :-
    A == B.