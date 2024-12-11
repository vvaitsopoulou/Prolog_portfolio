/*
a) Write a Prolog predicate which, given two numbers X and Y where X<Y and
another positive number N, returns the product of:
Y N *(Y-1) N *(Y-2) N *...*(X+1) N *X N .

QUESTION: are we supposed to assume these numbers are both positive
*/

/*
The mathematical relationship describes the product of the nth power of numbers starting from X
and incrementing the base each time by one until it is equal to Y

Mathematically we write:
Yn *(Y-1)n *(Y-2)n *...*(X+1)n *Xn =

= a. (base case)for X = Y, this relationship becomes equivalent to X to the power of N
  b. (recursive definition) Y raised to the power of N * (product_of(Y - 1, X))
*/

/*
we will also be needing the recursive definition of the nth power for this one

*/
power(_, 0, 1).

power(B, E, R):-
	E > 0,
	E1 is E - 1,
	power(B, E1, R1),
	R is R1 * B.

power(B, E, R):-
	E < 0,
	E1 is -E,
	power(B, E1, R1),
	R is 1 / R1.


/******************************************************
product_of/4:(+-/+-/+-/+-)
*******************************************************/
product_of(X, X, N, Power):-
	power(X, N, Power).

product_of(X,Y,N,R):-
	N > 0, 
	Y > X,
	Y2 is Y -1,
	product_of(X, Y2, N, R2),
	power(Y, N, Power_y),
	R is R2 * Power_y.


	/*
	b) Arithmetic expressions which contain 0 and 1 can be simplified further. For example, 
	the expression a*1+b*0-c/1+0^d can be simplified to a-c. Write a number of facts which
	corresponds to the following simplification rules.
	X*1=X
	X+0=X
	X-0=X
	X*0=0

	X/1=X
	X/X=1

	0/X=X

	X^1=X
	X^0=1

	1^X=1
	0^X=0

	and the reverse (where it applies). ////
	*/

	simplification(X*1, X).
	simplification(1*X, X).

	simplification(X+0, X).
	simplification(0+X, X).
	
	simplification(X-0, X).

	simplification(X*0, 0).
	simplification(0*X, 0).

	simplification(X/1, X).

	simplification(X/X, 1):-
		X \= 0.

	simplification(0/X, X):-
		X \= 0.
 
	simplification(X^1,X).
	simplification(X^0,1).
	simplification(1^X, 1).
	simplification(0^X, 0).

	/*
	Write a recursive definition of a Prolog predicate that simplifies more complex expressions, 
	e.g. like the one provided above. Give at least five queries and answers. 
	*/

	/*
	The simplification rule will necessarily have two arguments: Initial and Simplified expression
	*/

	simplification(X+Y, X1+Y1):-
		simplification(X, X1),
		simplification(Y, Y1).

	simplification(X-Y, X1-Y1):-
		simplification(X, X1),
		simplification(Y, Y1).

	simplification(X*Y, X1*Y1):-
		simplification(X, X1),
		simplification(Y, Y1).

	simplification(X/Y, X1/Y1):-
		simplification(X, X1),
		simplification(Y, Y1).

	simplification(X^Y, X1^Y1):-
		simplification(X, X1),
		simplification(Y, Y1).

	simplification(Initial, Initial). %we put this in the end in case nothing of the above applies 


% Give at least five queries and answers.
% Here we have to use prefix notation? error otherwise

% 1. ?-simplification(+(a*3, -(b/1, c^1)), Simplified).
% Simplified = a*3+(b-c) .

% 2. ?-simplification(+(a-0, -(4*b, +(c*0, +(d^1,0)))), Simplified).
