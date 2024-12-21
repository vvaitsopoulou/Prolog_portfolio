% 1. Write the Prolog definition for the predicate is_sorted/1, which given a list
% verifies whether the list is sorted or not. For example:
% ?- is_sorted([1,5,8,10]).
% true.
% ?- is_sorted([1,9,8,10]).
% false.

is_sorted([_]).
is_sorted([H|[Tailhead|Tt]]):-
	H < Tailhead,
	is_sorted([Tailhead|Tt]).

% Write the Prolog definition for the predicate insert/3, which given a number and
% a sorted list, inserts the number in the appropriate position of the sorted list so
% that the result list is also sorted. For example:
% ?-insert(4, [1,2,6,7,9], L).
% L = [1,2,4,6,7,9]	

insert(Element, [], [Element]).

insert(Element, [H|Tail], [Element|[H|Tail]]):-
	Element < H.

insert(Element, [H|Tail], [H|Tail2]):-
	Element >= H,
	insert(Element, Tail, List).
