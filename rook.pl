:- module(rook, [rook/3]).

:- use_module(cells, [horizontal/2, vertical/2]).

export(rook/3).

% RULES
% MOVES
rook(move, cell(Col, Row), Cells) :-
    bagof(Cells_,
        ( horizontal(Row, Cells_)
        ; vertical(Col, Cells_)
        ), Bag),
    append(Bag, Cells).

% ATTACK
rook(attack, cell(Col, Row), Cells) :-
    bagof(Cells_,
        ( horizontal(Row, Cells_)
        ; vertical(Col, Cells_)
        ), Bag),
    append(Bag, Cells).