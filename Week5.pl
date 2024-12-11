/*
Write a definition of a recursive Prolog program (more than one predicate may be
needed) 
that given a list of positive numbers (check validity of input is required),

it returns the average of odd or even numbers (whichever is greater) 
together with an atom whether this average is from odd or even numbers.
you must also display which are the numbers that participate in the calculation of the average. Provide the
appropriate queries and results.
*/

/*
breaking the problem down it seems the following steps will be required:
is_list_positive(H|T) which checks validity of provided list


odd(N), even(N) which check if a number is odd or even
then count_odd(H|T, X), count_even(H|T, X) which count the number of odd and the number of even elements in a list respectively

average(H|T) which returns the average of the numbers of a list 

then build_odds_list() build_evens_list() which will give as an output a list with only the odd or even numbers
of the original respectively

and the final predicate where everything is combined.
*/

/*****************************************************************************
is_list_positive/1(+/-):
Recursively, a list of numbers is positive if the tail is positive.
We make assumption that 0 is excluded.
As a base case, a list of numbers is positive if it only has one element and that element is positive.
*****************************************************************************/
is_list_positive([Element]):-
	Element > 0.

is_list_positive([H|T]):-
	H > 0,
	is_list_positive(T).	

/******************************************
A number N is odd if it is NOT divisible by 2, i.e. if 1 is N mod 2.	
*******************************************/
is_odd(N):-
	1 is N mod 2.

count_odd([],0).

count_odd([H|T], X):-
	is_odd(H),
	count_odd(T, X1),
	X is X1 + 1.

count_odd([H|T], X):-
	\+(is_odd(H)), 
	count_odd(T, X).	

/******************************************
A number N is even if it is NOT odd.
by convention we consider 0 an even number.	
*******************************************/	
is_even(N):-
	\+(is_odd(N)).

count_even([],0).

count_even([H|T], X):-
	is_even(H),
	count_even(T, X1),
	X is X1 + 1.

count_even([H|T], X):-
	\+(is_even(H)), 
	count_even(T, X).	

/******************************************
In order to find the average of the numbers of a list we must first find the sum of a list 
and then divide it by the number of elements included in the list. (which should be non zero)
*******************************************/

sum([], 0).

sum([H|T], Sum):-
	sum(T, S1),
	Sum is S1 + H.	

count_elements([], 0).

count_elements([_|T], Number):-
	count_elements(T, Number2),
	Number is Number2 + 1.

average([H|T], Average):-
	count_elements([_|T], Number),
	Number \= 0,
	sum([H|T], Sum),
	Average is Sum / Number.

build_odds_list([], []).

build_odds_list([H|T], [H|OddsTail]):- %%%head is odd
	is_odd(H), %%%if the head is odd, it will be the head of the odds list
	build_odds_list(T, OddsTail). %%%if the head of the tail is also odd, it will be the head of the odds lists tail


build_odds_list([H|T], OddsList):- %%%head is not odd
	\+ (is_odd(H)), %%%if the head is not odd, it will be ignored and we check the case for the tail again
	build_odds_list(T, OddsList).



build_evens_list([], []).

build_evens_list([H|T], [H|EvensTail]):- %%%head is even
	is_even(H), %%%if the head is even, it will be the head of the evens list
	build_evens_list(T, EvensTail). %%%if the head of the tail is also even, it will be the head of the evens lists tail


build_evens_list([H|T], EvensList):- %%%head is not even
	\+ (is_even(H)), %%%if the head is not even, it will be ignored and we check the case for the tail again
	build_evens_list(T, EvensList).
 

find_greater_average(List, odd, OddAverage, OddsList):-
	is_list_positive(List),
	build_odds_list(List, OddsList),
	build_evens_list(List, EvensList),
	average(OddsList, OddAverage),
	average(EvensList, EvenAverage),
	OddAverage >= EvenAverage.

	

find_greater_average(List, even, EvenAverage, EvensList):-
	is_list_positive(List),
	build_odds_list(List, OddsList),
	build_evens_list(List, EvensList),
	average(OddsList, OddAverage),
	average(EvensList, EvenAverage),
	OddAverage < EvenAverage.	


/******************************************
Queries and Results:
1. ?-find_greater_average([], X, C, V).
false. 
as expected because it fails the is_list_positive() test.

2. ?-find_greater_average([1,2,3,4,5], Odd_or_even, Average, NumbersList).
Odd_or_even = odd,
Average = 3,
NumbersList = [1, 3, 5] .

3. ?- find_greater_average([1,2,3,4,5,6], Odd_or_even, Average, NumbersList).
Odd_or_even = even,
Average = 4,
NumbersList = [2, 4, 6] .
*******************************************/	



