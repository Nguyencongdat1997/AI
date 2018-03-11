%List searching
%TODO: This function will search if an 'Item' is on a List
search(Item,[Item|Rest]).
search(Item,[Head|Tail]):-
	search(Item,Tail).
%Test example: ?-search(a,[a,b]). -> True


%List appending
%TODO: This function will combine 2 lists
append([],List,List).
append([Head|Tail],List2,[Head|Result]):-
	append(Tail,List2,Result).
%Test example:	?- append([a,b,c],[one,two,three],Result). -> Result = [a,b,c,one,two,three].


%List removing
%TODO: This function will input a List and an Item return the List without that Item
remove([],Item,[]):- !.
remove([Item|Tail],Item,Result):-
	remove(Tail,Item,Result).	
remove([Head|Tail],Item,[Head|Result]):-
	remove(Tail,Item,Result).
%Test example: ?- remove([a,b,c],c,Result). -> Result = [a, b].


%List repalcing
%TODO: This function will input a List and two Items(Item1 and Item2) return the List in which Item1 has been replaced by Item2
replace([],Item1,Item2,[]):- !.
replace([Item1|Tail],Item1,Item2,[Item2|Result]):-
	replace(Tail,Item1,Item2,Result).
replace([Head|Tail],Item1,Item2,[Head|Result]):-
	replace(Tail,Item1,Item2,Result).
	
%Test example: ?- replace([a,b,c,c,d],c,e,Result). -> Result = [a, b, e, e, d].