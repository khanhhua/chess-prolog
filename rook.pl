:- module(rook, [rook/3, rook/5]).

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
rook(attack, cell(Col, Row), cell(C, R)) :-
    bagof(Cells,
        ( horizontal(Row, Cells)
        ; vertical(Col, Cells)
        ), Bag),
    append(Bag, RawList),
    member(cell(C, R), RawList).

rook(block, MyCells, EnemyCells, cell(Col, Row), cell(ColZ, RowZ)) :-
    append([MyCells, EnemyCells], OccupiedCells),
    project(cell(Col, Row), cell(ColZ, RowZ), Projection),
    intersection(OccupiedCells, Projection, Collision),
    proper_length(Collision, L),
    ( L == 1 -> not(member(cell(ColZ, RowZ), Collision))
    ; L > 1 % You gotta collide with the target, right?!
    ).

identical(A, B) :-
    A == B.