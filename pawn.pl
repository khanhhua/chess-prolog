:- module(pawn, [pawn/3]).

export(pawn/3).

% FACTS
% MOVES
pawn(move, cell_a2, cell_a3).
pawn(move, cell_a3, cell_a4).
pawn(move, cell_a4, cell_a5).
pawn(move, cell_a5, cell_a6).
pawn(move, cell_a6, cell_a7).
pawn(move, cell_a7, cell_a8).

pawn(move, cell_b2, cell_b3).
pawn(move, cell_b3, cell_b4).
pawn(move, cell_b4, cell_b5).
pawn(move, cell_b5, cell_b6).
pawn(move, cell_b6, cell_b7).
pawn(move, cell_b7, cell_b8).

pawn(move, cell_c2, cell_c3).
pawn(move, cell_c3, cell_c4).
pawn(move, cell_c4, cell_c5).
pawn(move, cell_c5, cell_c6).
pawn(move, cell_c6, cell_c7).
pawn(move, cell_c7, cell_c8).
% ATTACK
pawn(attack, cell_a2, cell_b3).
pawn(attack, cell_a3, cell_b4).
pawn(attack, cell_a4, cell_b5).
pawn(attack, cell_a5, cell_b6).
pawn(attack, cell_a6, cell_b7).
pawn(attack, cell_a7, cell_b8).

pawn(attack, cell_b2, cell_a3).
pawn(attack, cell_b2, cell_c3).
pawn(attack, cell_b3, cell_a4).
pawn(attack, cell_b3, cell_c4).
pawn(attack, cell_b4, cell_a5).
pawn(attack, cell_b4, cell_c5).
pawn(attack, cell_b5, cell_a6).
pawn(attack, cell_b5, cell_c6).
pawn(attack, cell_b6, cell_a7).
pawn(attack, cell_b6, cell_c7).
pawn(attack, cell_b7, cell_a8).
pawn(attack, cell_b7, cell_c8).