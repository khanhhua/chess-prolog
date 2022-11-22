:- module(cells, [ cell/2,
                    eastward/2,
                    westward/2,
                    northward/2,
                    southward/2,
                    neighbor_col/2,
                    vertical/2,
                    horizontal/2,
                    diagonals/3,
                    project/3]).
% Row 1
cell(a, 1).
cell(b, 1).
cell(c, 1).
cell(d, 1).
cell(e, 1).
cell(f, 1).
cell(g, 1).
cell(h, 1).
% Row 2
cell(a, 2).
cell(b, 2).
cell(c, 2).
cell(d, 2).
cell(e, 2).
cell(f, 2).
cell(g, 2).
cell(h, 2).
% Row 1
cell(a, 3).
cell(b, 3).
cell(c, 3).
cell(d, 3).
cell(e, 3).
cell(f, 3).
cell(g, 3).
cell(h, 3).
% Row 2
cell(a, 4).
cell(b, 4).
cell(c, 4).
cell(d, 4).
cell(e, 4).
cell(f, 4).
cell(g, 4).
cell(h, 4).
% Row 1
cell(a, 5).
cell(b, 5).
cell(c, 5).
cell(d, 5).
cell(e, 5).
cell(f, 5).
cell(g, 5).
cell(h, 5).
% Row 2
cell(a, 6).
cell(b, 6).
cell(c, 6).
cell(d, 6).
cell(e, 6).
cell(f, 6).
cell(g, 6).
cell(h, 6).
% Row 1
cell(a, 7).
cell(b, 7).
cell(c, 7).
cell(d, 7).
cell(e, 7).
cell(f, 7).
cell(g, 7).
cell(h, 7).
% Row 2
cell(a, 8).
cell(b, 8).
cell(c, 8).
cell(d, 8).
cell(e, 8).
cell(f, 8).
cell(g, 8).
cell(h, 8).

eastward(a, b).
eastward(b, c).
eastward(c, d).
eastward(d, e).
eastward(e, f).
eastward(f, g).
eastward(g, h).

westward(b, a).
westward(c, b).
westward(d, c).
westward(e, d).
westward(f, e).
westward(g, f).
westward(h, g).

northward(A, B) :-
    A < 8,
    B is A + 1.

southward(A, B) :-
    A > 1,
    B is A - 1.

neighbor_col(A, B) :-
    eastward(A, B);
    westward(A, B).

vertical(Col, Cells) :-
    bagof(cell(Col, Row), cell(Col, Row), Cells).

horizontal(Row, Cells) :-
    bagof(cell(Col, Row), cell(Col, Row), Cells).

project(cell(Col, Row), cell(ColZ, RowZ), Out) :-
    ( project_northward(cell(Col, Row), cell(ColZ, RowZ), [], Cells)
    ; project_southward(cell(Col, Row), cell(ColZ, RowZ), [], Cells)
    ; project_eastward(cell(Col, Row), cell(ColZ, RowZ), [], Cells)
    ; project_westward(cell(Col, Row), cell(ColZ, RowZ), [], Cells)
    ; project_ne_ward(cell(Col, Row), cell(ColZ, RowZ), [], Cells)
    ; project_se_ward(cell(Col, Row), cell(ColZ, RowZ), [], Cells)
    ; project_nw_ward(cell(Col, Row), cell(ColZ, RowZ), [], Cells)
    ; project_sw_ward(cell(Col, Row), cell(ColZ, RowZ), [], Cells)
    ),!,
    reverse(Cells, Out).

project_northward(cell(Col, Row), CellZ, Cells, Out) :-
    northward(Row, R),
    ( cell(Col, R) == CellZ -> Out = [cell(Col, R) | Cells]
    ; project_northward(cell(Col, R), CellZ, [cell(Col, R) | Cells], Out)
    ).

project_southward(cell(Col, Row), CellZ, Cells, Out) :-
    southward(Row, R),
    ( cell(Col, R) == CellZ -> Out = [cell(Col, R) | Cells]
    ; project_southward(cell(Col, R), CellZ, [cell(Col, R) | Cells], Out)
    ).

project_eastward(cell(Col, Row), CellZ, Cells, Out) :-
    eastward(Col, C),
    ( cell(C, Row) == CellZ -> Out = [cell(C, Row) | Cells]
    ; project_eastward(cell(C, Row), CellZ, [cell(C, Row) | Cells], Out)
    ).

project_westward(cell(Col, Row), CellZ, Cells, Out) :-
    westward(Col, C),
    ( cell(C, Row) == CellZ -> Out = [cell(C, Row) | Cells]
    ; project_westward(cell(C, Row), CellZ, [cell(C, Row) | Cells], Out)
    ).

project_ne_ward(cell(Col, Row), CellZ, Cells, Out) :-
    northward(Row, R),
    eastward(Col, C),
    ( cell(C, R) == CellZ -> Out = [cell(C, R) | Cells]
    ; project_ne_ward(cell(C, R), CellZ, [cell(C, R) | Cells], Out)
    ).
project_se_ward(cell(Col, Row), CellZ, Cells, Out) :-
    southward(Row, R),
    eastward(Col, C),
    ( cell(C, R) == CellZ -> Out = [cell(C, R) | Cells]
    ; project_se_ward(cell(C, R), CellZ, [cell(C, R) | Cells], Out)
    ).
project_nw_ward(cell(Col, Row), CellZ, Cells, Out) :-
    northward(Row, R),
    westward(Col, C),
    ( cell(C, R) == CellZ -> Out = [cell(C, R) | Cells]
    ; project_nw_ward(cell(C, R), CellZ, [cell(C, R) | Cells], Out)
    ).
project_sw_ward(cell(Col, Row), CellZ, Cells, Out) :-
    southward(Row, R),
    westward(Col, C),
    ( cell(C, R) == CellZ -> Out = [cell(C, R) | Cells]
    ; project_sw_ward(cell(C, R), CellZ, [cell(C, R) | Cells], Out)
    ).

do_diagonal_ne(cell(Col, Row), Cells, Out) :-
    ( northward(Row, R)
    , eastward(Col, C) -> do_diagonal_ne(cell(C, R), [cell(Col, Row) | Cells], Out)
    ; Out = [cell(Col, Row) | Cells]
    ).
do_diagonal_sw(cell(Col, Row), Cells, Out) :-
    ( southward(Row, R)
    , westward(Col, C) -> do_diagonal_sw(cell(C, R), [cell(Col, Row) | Cells], Out)
    ; Out = [cell(Col, Row) | Cells]
    ).

do_diagonal_nw(cell(Col, Row), Cells, Out) :-
    ( northward(Row, R)
    , westward(Col, C) -> do_diagonal_nw(cell(C, R), [cell(Col, Row) | Cells], Out)
    ; Out = [cell(Col, Row) | Cells]
    ).
do_diagonal_se(cell(Col, Row), Cells, Out) :-
    ( southward(Row, R)
    , eastward(Col, C) -> do_diagonal_se(cell(C, R), [cell(Col, Row) | Cells], Out)
    ; Out = [cell(Col, Row) | Cells]
    ).

diagonals(cell(C, R), AscendingCells, DescendingCells) :-
    bagof(CsOut, 
        ( do_diagonal_ne(cell(C, R), [], CsOut)
        ; do_diagonal_sw(cell(C, R), [], CsOut)
        ), AscendingBag),
    append(AscendingBag, AscendingUnsorted),
    sort(AscendingUnsorted, AscendingCells),
    bagof(CsOut, 
        ( do_diagonal_nw(cell(C, R), [], CsOut)
        ; do_diagonal_se(cell(C, R), [], CsOut)
        ), DescendingBag),
    append(DescendingBag, DescendingUnsorted),
    sort(DescendingUnsorted, DescendingCells).
