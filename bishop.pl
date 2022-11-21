:- module(bishop, [bishop/3]).

:- use_module(cells, [diagonals/3]).

export(bishop/3).

% RULES
% MOVES
bishop(move, cell(Col, Row), Out) :-
    diagonals(cell(Col, Row), Ascending, Descending),
    append([Ascending, Descending], RawList),
    exclude(identical(cell(Col, Row)), RawList, Out).

% ATTACK
bishop(attack, cell(Col, Row), Cells) :-
    diagonals(cell(Col, Row), Ascending, Descending),
    append([Ascending, Descending], RawList),
    exclude(identical(cell(Col, Row)), RawList, Out).

identical(A, B) :-
    A == B.