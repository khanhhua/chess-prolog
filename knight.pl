:- module(knight, [knight/3]).

:- use_module(cells, [northward/2,
                      southward/2,
                      eastward/2,
                      westward/2,
                      neighbor_col/2]).

export(knight/3).

% RULES
% MOVES
knight(move, cell(Col, Row), Cells) :-
    bagof(cell(C, R),
        ( x2westward(Col, C)
        , northward(Row, R)
        ; x2westward(Col, C)
        , southward(Row, R)
        ; x2eastward(Col, C)
        , northward(Row, R)
        ; x2eastward(Col, C)
        , southward(Row, R)
        ; westward(Col, C)
        , x2northward(Row, R)
        ; eastward(Col, C)
        , x2northward(Row, R)
        ; westward(Col, C)
        , x2southward(Row, R)
        ; eastward(Col, C)
        , x2southward(Row, R)
    ), Cells).

% ATTACK
knight(attack, cell(Col, Row), Cells) :-
    bagof(cell(C, R),
        ( x2westward(Col, C)
        , northward(Row, R)
        ; x2westward(Col, C)
        , southward(Row, R)
        ; x2eastward(Col, C)
        , northward(Row, R)
        ; x2eastward(Col, C)
        , southward(Row, R)
        ; westward(Col, C)
        , x2northward(Row, R)
        ; eastward(Col, C)
        , x2northward(Row, R)
        ; westward(Col, C)
        , x2southward(Row, R)
        ; eastward(Col, C)
        , x2southward(Row, R)
    ), Cells).

x2westward(A, B) :-
    westward(A, West),
    westward(West, B).

x2eastward(A, B) :-
    eastward(A, East),
    eastward(East, B).

x2northward(A, B) :-
    northward(A, North),
    northward(North, B).

x2southward(A, B) :-
    southward(A, South),
    southward(South, B).
