:- module(bishop, [bishop/3, bishop/5]).

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
bishop(attack, cell(Col, Row), EnemyPieces, LegalCells) :-
    diagonals(cell(Col, Row), Ascending, Descending),
    append([Ascending, Descending], RawList),
    intersection(RawList, EnemyPieces, LegalCells).

bishop(block, MyCells, EnemyCells, cell(Col, Row), cell(ColZ, RowZ)) :-
    append([MyCells, EnemyCells], OccupiedCells),
    project(cell(Col, Row), cell(ColZ, RowZ), Projection),
    intersection(OccupiedCells, Projection, Collision),
    proper_length(Collision, L),
    ( L == 1 -> not(member(cell(ColZ, RowZ), Collision))
    ; L > 1 % You gotta collide with the target, right?!
    ).

identical(A, B) :-
    A == B.