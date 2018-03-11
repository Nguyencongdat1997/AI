/*
Problem: The task is to place N queens on an N×N chessboard in such a way that none of the queens is under attack. 
Solution:
Number N Queens as [Q1,...,Qn]
Call the coordinate of Queen i-th is : [Qi.Row,Qi.Col].
Put each Queen in a Row so that: Qi.Row = i.                                                (*1)                  
The problem will be solved if for each Queen i-th & Queen j-th: 
      Qi.Col != Qj.Col          (Qi and Qj are not in the same column)                      (*2)
 and |Qi.Col-Qj.Col| != |i-j|  (Qi and Qj are not in the diagonal line of any square)       (*3)
*/
:- use_module(library(clpfd)).

%Logic to put N  Queens
nqueens(N, Queens):-
	create(N,Queens).   %Now each queen has been number and aumatically, their row will be that number as said in (*1)	

%Number the queens:
create(N, Queens):-
	length(Queens, N),
        Queens ins 1..N,
	checkCol(Queens,1).

%Check Col of each pair of Queen so that (*2) and (*3) are met
checkCol(_,[],_,_):- !.
checkCol(Qi,[Qj|RestQueens],I,J):-
	Qi #\= Qj,
	abs(Qi - Qj) #\= abs(I - J),
	NextJ #= J + 1,
	checkCol(Qi,RestQueens,I,NextJ).
checkCol([],_):- !.
checkCol([Qi|RestQueens],I):-
	NextI #= I + 1,
	checkCol(Qi,RestQueens,I,NextI),
	checkCol(RestQueens,NextI).

%Show N-queens in the talbe:
writeColumnHeader(N):-
	write(''),
	writeColumnHeader(N,1),
	nl.
writeColumnHeader(N,N):-
	write(' '),
	write(N).
writeColumnHeader(N,I):-
	write(' '),
	write(I),
	NextI #= I+1,
	writeColumnHeader(N,NextI).

show(_,[]):-!.
show(N,[QueenPosInCurrentRow|Queens]):-
	showLine(QueenPosInCurrentRow,N,1),nl,
	show(N,Queens).
showLine(QueenPosInCurrentRow,N,N):-
	(
	QueenPosInCurrentRow #= N,
	write(' Q');
	write(' _')
	).
showLine(QueenPosInCurrentRow,N,I):-
	(
	QueenPosInCurrentRow #= I,
	write(' Q');
	write(' _')
	),
	NextI #= I +1,
	showLine(QueenPosInCurrentRow,N,NextI).

%Main funtion:
main:-	write('Input N ='), nl,
	read(N),
	nqueens(N,Queens),	
	labeling([ff], Queens),
	writeColumnHeader(N),
	show(N,Queens).
	
test(N):- nqueens(N,Q), labeling([ff],Q),write(Q).