/*
Description: Each puzzle consists of a 9x9 grid containing given clues in various places. 
The object is to fill all empty squares so that the numbers 1 to 9 appear exactly once in each row, column and 3x3 box.
*/

:- use_module(library(clpfd)).
%Game Logic
sudoku(Table) :-
        length(Table, 9),                                                          /*check the number of Rows*/
	maplist(same_length(Table), Table),                               	   /*check the number of Columns*/
        append(Table, Vs), Vs ins 1..9,                           
        maplist(all_distinct, Table),                                              /*Set requirement: in each row, 1to 9 appear exactly once*/
        transpose(Table, Columns), maplist(all_distinct, Columns),		   /*Set requirement: in each column, 1to 9 appear exactly once*/
        Table = [Row1,Row2,Row3,Row4,Row5,Row6,Row7,Row8,Row9],                     
        box(Row1, Row2, Row3), box(Row4, Row5, Row6), box(Row7, Row8, Row9).	   /*Set requirement to each box 3x3*/

box([], [], []).
box([N1,N2,N3|NextBoxesRow1], [N4,N5,N6|NextBoxesRow2], [N7,N8,N9|NextBoxesRow3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        box(NextBoxesRow1, NextBoxesRow2, NextBoxesRow3).
		

%Table Printing
show([X1, X2, X3, X4, X5, X6, X7, X8, X9]) :-
	write('   -------------------'),nl,
    	showLine(X1),
    	showLine(X2),
    	showLine(X3),
	write('   |-----|-----|-----|'),nl,
    	showLine(X4),
    	showLine(X5),
    	showLine(X6),
	write('   |-----|-----|-----|'),nl,
    	showLine(X7),
    	showLine(X8),
    	showLine(X9),
	write('   -------------------').

showLine([X1, X2, X3, X4, X5, X6, X7, X8, X9]):-
  	write('   |'),showLine2([X1,X2,X3]),showLine2([X4,X5,X6]),showLine2([X7,X8,X9]),nl.
	
showLine2([X1, X2, X3]):-
    	write(X1),
	write(' '),
    	write(X2),
	write(' '),
    	write(X3),
	write('|').

%Examples
puzzle(P) :- 
        P = [[_,_,_,_,_,_,_,_,_],
             [_,9,3,6,2,8,1,4,_],
             [_,6,_,_,_,_,_,5,_],
             [_,3,_,_,1,_,_,9,_],
             [_,5,_,8,_,2,_,7,_],
             [_,4,_,_,7,_,_,6,_],
             [_,8,_,_,_,_,_,3,_],
             [_,1,7,5,9,3,4,2,_],
             [_,_,_,_,_,_,_,_,_]].
			 
?- puzzle(Table),sudoku(Table),show(Table).
