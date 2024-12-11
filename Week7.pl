% Write a Prolog program that implements a menu list and returns a valid choice among this list. 
% The behaviour of the predicate menu/2 predicate looks like:
% ?-menu(['Choice 1: aaa', 'Choice 2: bbb', 'Choice 3: ccc'], C).
% Choose one of the following:
% 1. Choice 1: aaa 
% 2. Choice 2: bbb
% 3. Choice 3: ccc
% Your choice: 4.
% There is no such option. Choose again! 
% Your choice: 2.
% You selected “Choice 2: bbb”
% C=2

/********************************************************************
QUERIES:
1.?-menu(['Choice 1: aaa', 'Choice 2: bbb', 'Choice 3: ccc'], C).
2.?-binary_search.
********************************************************************/


%recursive definition to display menu items depending on a list the query provides:
display_choices([], _):-
    write(''),nl.

display_choices([H|Tail], Counter):-
	NewCounter is Counter + 1,
    write(NewCounter), write('. '), write(H),nl,
    display_choices(Tail, NewCounter).

menu(ChoicesList, C):-
	write('Choose one of the following:'), nl,
    display_choices(ChoicesList, 0),repeat,
	read(C),
	write('Your choice: '), write(C),nl,
	length(ChoicesList,Length),
		((C =< Length, C > 0 )-> %if the choice number is smaller or equal to the choices list length it succeeds
		get_by_index(ChoicesList, Element, C),
		write('You have selected: '), write(Element),nl, 
        true ;
        (write('There is no such option. Choose again!'), nl, fail)
    ).


	%build a predicate to get a list element by index
	get_by_index([X|_], X, 1). %by convention we use 1-based index so we dont have to convert later
	get_by_index([H|T], X, Index):-
		IndexTail is Index - 1,
		get_by_index(T, X, IndexTail).


	
% Write a Prolog program that guesses an integer number between two numbers X and Y
% that are given by the user.  The user thinks of a number and gives the range.
% The program uses the divide-and-conquer technique by dividing ranges into halves.
% After a guess, the user only points out whether the guessed number is less or greater
% than the one the user thought. The program should be able to count the number of guesses it did. 

binary_search :-
    repeat,
    write('Provide the lower range:'), nl,
    read(X),
    write('Provide the upper range:'), nl,
    read(Y),
    (X < Y ->
        true ;
        (write('The lower range must be a smaller number than the upper range! Try again'), nl, fail)
    ),
    write('Think of a number between '), write(X), write(' and '), write(Y), write('.'), nl,
    write('I will now try to guess it.'), nl,
    guess(X, Y, 0). 

guess(X, Y, Counter) :-
    divide_and_conquer(X, Y, Middle),
    write('I am guessing '), write(Middle), write('.'), nl,
    write('If my guess is correct, type "1", otherwise type "0"'), nl,
    read(IsCorrect),
	counter_increment(Counter, Counter_up),
    (IsCorrect = 1 ->
        write('Guessed it!'),write('It only took me '), write(Counter_up), write(' guesses.'), true ;
        (
            write('I am going to guess again.'), nl,
            write('Is the number you are thinking of greater or lesser than '), write(Middle), write('?'), nl,
            write('Type "0" if it is lesser than '), write(Middle), write(', or type "1" if it is greater.'), nl,
            read(LesserOrGreater),
            (LesserOrGreater = 0 ->
                guess(X, Middle, Counter_up) ; 
                guess(Middle, Y, Counter_up)  
            )
        )
    ).

divide_and_conquer(X, Y, Middle) :-
    Middle is div(X + Y, 2). % We need integer division.

counter_increment(Previous, Incremented):-
	Incremented is Previous + 1.


