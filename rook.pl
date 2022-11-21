:- module(rook, [rook/3]).

:- use_module(cells, [cell/2, horizontal/2, vertical/2]).

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
rook(attack, cell(Col, Row), Cells) :-
    bagof(Cells,
        ( horizontal(Row, Cells)
        ; vertical(Col, Cells)
        ), Bag),
    append(Bag, RawList),
    exclude(identical(cell(Col, Row)), RawList, Out).

identical(A, B) :-
    A == B.