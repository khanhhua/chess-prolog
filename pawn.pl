:- module(pawn,
    [ white_pawn/3
    , white_pawn/5
    , black_pawn/3
    , black_pawn/5
    ]).

:- use_module(cells,
    [ northward/2
    , eastward/2
    , westward/2
    ]).

export(white_pawn/3).

% RULES
% MOVES
white_pawn(move, cell(Col, Row), Cells) :-
    northward(Row, R),
    Cells = [cell(Col, R)].

black_pawn(move, cell(Col, Row), Cells) :-
    southward(Row, R),
    Cells = [cell(Col, R)].
% ATTACK
white_pawn(attack, cell(Col, Row), EnemyPieces, LegalCells) :-
    northward(Row, R),
    bagof(cell(C, R),
        ( ( eastward(Col, C)
          ; westward(Col, C)
          ), member(cell(C, R), EnemyPieces)
        ),
        LegalCells).

white_pawn(block, MyCells, EnemyCells, cell(Col, Row), cell(Col, RowZ)) :-
    append([MyCells, EnemyCells], OccupiedCells),
    member(cell(Col, RowZ), OccupiedCells),
    Row < RowZ.

black_pawn(attack, cell(Col, Row), EnemyPieces, LegalCells) :-
    southward(Row, R),
    bagof(cell(C, R),
        ( ( eastward(Col, C)
          ; westward(Col, C)
          ), member(cell(C, R), EnemyPieces)
        ),
        LegalCells).

black_pawn(block, MyCells, EnemyCells, cell(Col, Row), cell(Col, RowZ)) :-
    append([MyCells, EnemyCells], OccupiedCells),
    member(cell(Col, RowZ), OccupiedCells),
    Row > RowZ.
