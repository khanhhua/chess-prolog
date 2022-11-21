:- module(pawn, [pawn/3]).

:- use_module(cells, [northward/2,
                        eastward/2,
                        westward/2]).

export(pawn/3).

% RULES
% MOVES
pawn(move, cell(Col, Row), Cells) :-
    northward(Row, R),
    Cells = [cell(Col, R)].

% ATTACK
pawn(attack, cell(Col, Row), Cells) :-
    northward(Row, R),
    bagof(cell(C, R),
        ( eastward(Col, C)
        ; westward(Col, C)
        ),
        Cells).
