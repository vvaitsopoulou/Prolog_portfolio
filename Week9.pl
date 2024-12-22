% :-['statistics.pl'].

p1([X],X).
p1([H|T],H):-
    p1(T,MT),
    H =< MT.
p1([H|T],MT):-
    p1(T,MT),
    H > MT.


p2([X],X).
p2([X|Tail],M) :-
    p2(Tail,Ml),
    min(X,Ml,M).

min(X,Y,X) :- X=<Y.
min(X,Y,Y) :- X>Y.

p3([H|T],Min) :-
    p3_aux(T,H,Min).

p3_aux([],Min,Min).
p3_aux([H|T],Temp,Min) :-
    min(H,Temp,Next),
    p3_aux(T,Next,Min).


p4([H|T],Min) :- 
    p4_aux(T,H,Min).

p4_aux([],MSF,MSF).
p4_aux([H|T],MSF,Min):-
    H < MSF,
    p4_aux(T,H,Min).
p4_aux([H|T],MSF,Min):-
    H >= MSF,
    p4_aux(T,MSF,Min).


p5([M],M).
p5([H1,H2|T],Min):-
    H1 > H2,
    p5([H2|T],Min).
p5([H1,H2|T],Min):-
    H1 =< H2,
    p5([H1|T],Min).


p6([M],M).
p6([H1,H2|T],Min):-
    min(H1,H2,M),
    p6([M|T],Min).


p7(List,Min):-
 member(Min,List),
 not((member(X,List), X < Min)).


p8(List,Min) :-
 setof(X,member(X,List),[Min|_]).

:-dynamic(temp_min/1).

p9([H|_T],_Min) :-
    assert(temp_min(H)), 
    fail.
p9(List,_Min) :-
    member(X,List),
    retract(temp_min(TmpMin)),
    min(X,TmpMin,NextMin),
    assert(temp_min(NextMin)),
    fail.
p9(_List,Min) :-
    retract(temp_min(Min)).

% a)	What does the predicate do in all nine versions?
/****************************************************************************************
In all nine versions the predicate has two arguments: A list and an Element. This element is arithmetically
the minimum amongst all elements of the list.

We can determine that most easily by examining p7 which is one of the most declarative predicate definitions
which makes it very easy to understand that:  
The predicate succeeds when the element (Min) is a member of the list (List) 
and when there isn't ΑΝΥ element X such that X is also a member of the same list
and X is lesser than Min. Thus, it is logical to conclude Min represents the minimum.

*****************************************************************************************/

% b)	For each of the predicates perform three tests with the same list of numbers:
% ●	one in ascending order
% ●	one in descending order 
% ●	one with randomly ordered numbers
% Run some tests using the test/5 predicate defined in statistics.pl file 
% and create a table for each predicate with results on cputime and inferences

/*--------------------------------------------------------------
	LAB#9: Statistics used for testing various predicates

	Solution by P.Kefalas
--------------------------------------------------------------*/

/*--------------------------------------------------------------
test/5:(+,+,+,+,-)
1st argument: cputime|inferences|localused|globalused|runtime 
2nd argument: nsort | isort | qsort (in case of sorting)
              p1|p2|p3|p4|p5|p6|p7|p8|p9 (in case of min list)
3rd argument: desc_order | asc_order | rand_order
4th argument: How many numbers in the list
5th argument: Result
--------------------------------------------------------------*/

test(What, Predicate, ListOrder, Elements, Result):-
	list(ListOrder,Elements,L),!,
	Call =.. [Predicate,L,Result],!,
	statistics(What,V1),!,
	Call,!,
	statistics(What,V2),!,
	V is V2-V1,!,
	write(What), write('='), write(V), nl,!.

list(desc_order,1,[1]).
list(desc_order,N,[N|R]):-
	N1 is N-1,
	list(desc_order,N1,R).

list(rand_order,0,[]).
list(rand_order,N,[X|R]):-
	random(1,100,X),
	N1 is N-1,
	list(rand_order,N1,R).
	
list(asc_order,N,L):-
	list(asc_order,1,N,L).

list(asc_order,N,N,[N]):-!.
list(asc_order,N,F,[N|R]):-
	N1 is N+1,
	list(asc_order,N1,F,R).	


/*--------------------------------------------------------------
SOLUTION: Table

-------------------------------------------------------------------------------------------------------------- 
           |Ascending order 1000 elements  |Descending order 1000 elements  |Random order 1000 elements      | 
           --------------------------------------------------------------------------------------------------- 
           |cpu time      | inferences     | cpu time      | inferences     | cpu time      | inferences     |
-------------------------------------------------------------------------------------------------------------- 
Predicate  |              |                |               |                |               |                |
-------------------------------------------------------------------------------------------------------------- 
p1         |              |                |               |                |               |                |
-------------------------------------------------------------------------------------------------------------- 
p2         |              |                |               |                |               |                |
-------------------------------------------------------------------------------------------------------------- 
p3         |              |                |               |                |               |                |
-------------------------------------------------------------------------------------------------------------- 
p4         |              |                |               |                |               |                |
-------------------------------------------------------------------------------------------------------------- 
p5         |              |                |               |                |               |                |
-------------------------------------------------------------------------------------------------------------- 
p7         |              |                |               |                |               |                |
-------------------------------------------------------------------------------------------------------------- 
p8         |              |                |               |                |               |                |
-------------------------------------------------------------------------------------------------------------- 
p9         |              |                |               |                |               |                |
-------------------------------------------------------------------------------------------------------------- 



--------------------------------------------------------------*/