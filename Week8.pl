% # SOKOBAN is a single user game described here. In this lab, we will see a simpler
% # version of the game, in which there is only one box and one target position. You are
% # given a file Sokoban.pl which contains the Prolog code of this simple game. You can
% # play the game by typing the query:

% # ?- play.
% # Some basic instructions will be displayed.
% # Note: For better display use courier font when you enter the SWI-Prolog runtime
% # environment.


% # L● It uses a fixed board 10x5.
% # ● The obstacles are in fixed positions for every game.
% # ● The target is in a fixed position (middle of the board) for every game.
% # ● The box is in a fixed position for every game.
% # ● Only the robot (R) is randomly positioned (see predicate place_robot/0).
% # ● When the robot free passes over the target, only one of the two is displayed.


% # Rewrite the initialise/0 predicate (you might want to write more subsequent
% # predicates) in order to:
% # ● Define the dimensions of the board by user input but no more than 15x10.
:-dynamic dimension/1.
define_dimensions:-
    retractall(dimension((_,_))),
    repeat,
    write('Please type your desired X dimension. Dimension X should be positive and cannot exceed 15.'),nl,
    read(DX),
    ((DX > 0 , DX =< 15) ->
        true ;
        (write('Invalid dimension X! Try again'), nl, fail)
    ),
    repeat,
    write('Please type your desired Y dimension. Dimension Y should be positive cannot exceed 10.'),nl,
    read(DY),
    ((DY > 0 , DY =< 10) ->
        true ;
        (write('Invalid dimension Y! Try again'), nl, fail)
    ),
    write('Confirmation: Your chosen dimension X is '),write(DX),nl,
    write('Confirmation: Your chosen dimension Y is '),write(DY),nl,
    assert(dimension((DX,DY))).

% # ● Place a number of obstacles in random positions (the number is determined by
% # the user input but should not exceed 10% of the board)
get_number_of_obstacles:-
	retractall(obstacle((_,_))),
	dimension((DX,DY)),
	Board_tiles is DX * DY,
	Limit is 0.1 * Board_tiles,
	repeat,
	write('Please type your desired number of obstacles. It should NOT exceed 10% of the board area, which in this case is 10% of '),write(Board_tiles),write(' = '),write(Limit),nl,
	read(Obstacle_number),
	(((Obstacle_number =< Limit), Obstacle_number > 0) ->
		true ;
		(write('Invalid obstacle number! Try again'), nl, fail)
	),
	place_obstacles(DX, DY, Obstacle_number, Obstacle_number).
	

place_obstacles(DX, DY, Obstacle_number, Counter):-
	repeat,
	random(1, DX, X),
	random(1, DY, Y),
	not(obstacle((X, Y))),%%% so there isnt an obstacle already there
	assert(obstacle((X, Y))),
	Counter_decremented is Counter - 1,
	(Counter_decremented == 0 -> %%all obstacles have been placed
		true ;
		(place_obstacles(DX, DY, Obstacle_number, Counter_decremented))
	).

    
% # ● Place the target in a random position which does not coincide with obstacles
place_target:-
	dimension((DX,DY)),
	retractall(target((_,_))),
	repeat,
	random(1, DX, X),
	random(1, DY, Y),
	not(obstacle((X, Y))),
	assert(target((X, Y))).
% # ● Place the box in a random position which is not next to the board boundaries
% # and does not coincide with obstacle or target positions.
place_box:-
	dimension((DX,DY)),
	retractall(box((_,_))),
	repeat,
	random(1, DX, X),
	random(1, DY, Y),
	in_boundaries((X,Y)),
	not(obstacle((X, Y))),
	not(target((X, Y))),
	assert(box((X, Y))).
% # You can test your program by using the following query:
% # ?- initialise, dimension((X,Y)), print_board(X,Y).
% # Note: In the portfolio you need to submit ONLY new or revised code (not the whole
% # game code), a few example queries as above.
% imitations of the current implementation (see predicate initialise/0):
% # 


/*-----------------------------------------------------------------------
 An implementation of a simple SOKOBAN game. The goal is to put a box
 in its designated target. A robot can only move up, right, down, left
 if the position is free. It can also push the box if it is next to the
 box and the position next to the box is free. 
 
 The program is intentionally incomplete for the purposes of the course.
-----------------------------------------------------------------------*/

/*-----------------------------------------------------------------------
 All perdicates below can be retracted and asserted.
-----------------------------------------------------------------------*/
:-dynamic robot/1.
:-dynamic box/1.
:-dynamic moves/1.
:-dynamic target/1.
:-dynamic obstacle/1.

/*-----------------------------------------------------------------------
 Fixed dimension of the board (X,Y)
-----------------------------------------------------------------------*/

% dimension((10,5)). %%original code commented out for exercise purposes

/*-----------------------------------------------------------------------
 play/0: 	initiates the game
 initialise/0: 	initialised the board
 finish/0: 	checks if the game has finiihed (box is in target)
 place_robot/0:	places the robot randomly in a free position.
-----------------------------------------------------------------------*/

play:-
	nl,write('Use COURIER font for better diplay of the board'),nl,nl,
	write('R:robot, B:box, X:target, O:obstacle'),nl,nl,
	write('The legal actions you can use are:'),nl,
	write('FREE MOVES: moveup, movedown, moveleft, moveright'),nl,
	write('PUSH BOX MOVES: pushup, pushdown, pushleft, pushright'),nl,
	write('CONTROL: stop (aborts the game)'),nl,nl,
	initialise,
	dimension((DX,DY)),
	repeat,
	print_board(DX,DY),
	write('ACTION> '),
	read(A),
	action(A),
	finish.
	
finish:-
	box((BX,BY)),
	target((BX,BY)),
	nl,write('YOU MADE IT!! THE BOX IS IN ITS TARGET!!!'),nl,
	dimension((DX,DY)),
	print_board(DX,DY),
	moves(M),
	length(M,NumberOfMoves),
	write(M),nl,
	write('Number of moves: '),
	write(NumberOfMoves),nl,
	!.
	
	
initialise:-
	abolish(robot/1), 
	abolish(box/1),
	abolish(moves/1),
	abolish(target/1),
	abolish(obstacle/1),
	define_dimensions,
	get_number_of_obstacles,
	place_target,
	place_box,
	% assert(box((3,4))), --------original code commented out 
	% assert(target((5,3))),
	assert(moves([])),
	% assert(obstacle((1,1))),
	% assert(obstacle((2,2))),
	% assert(obstacle((5,4))),
	% assert(obstacle((4,2))),
	% assert(obstacle((4,1))),
	% assert(obstacle((2,4))),
	% assert(obstacle((7,3))),
	% assert(obstacle((8,5))),
	place_robot.


place_robot:-
	dimension((DX,DY)),
	repeat,
	random(1,DX,X),
	random(1,DY,Y),
	not(obstacle((X,Y))),
	not(box((X,Y))),
	not(target((X,Y))),
	assert(robot((X,Y))),
	!.	

/*-----------------------------------------------------------------------
 action/1: defines all possible 9 actions. Any other input is illegal.
 -----------------------------------------------------------------------*/

action(moveup):-
	robot((X,Y)),
	Y1 is Y+1,
	valid_free_move((X,Y1)),
	update(robot((X,Y)),robot((X,Y1)),[moveup]),!.

action(movedown):-
	robot((X,Y)),
	Y1 is Y-1,
	valid_free_move((X,Y1)),
	update(robot((X,Y)),robot((X,Y1)),[movedown]),!.
	
action(moveleft):-
	robot((X,Y)),
	X1 is X-1,
	valid_free_move((X1,Y)),
	update(robot((X,Y)),robot((X1,Y)),[movedown]),!.
	
action(moveright):-
	robot((X,Y)),
	X1 is X+1,
	valid_free_move((X1,Y)),
	update(robot((X,Y)),robot((X1,Y)),[moveright]),!.

action(pushup):-
	robot((X,Y)),
	Y1 is Y+1,
	box((X,Y1)),
	Y2 is Y1+1,
	valid_push((X,Y2)),
	update(robot((X,Y)),robot((X,Y1)),[pushup]),
	update(box((X,Y1)),box((X,Y2)),[]),!.

action(pushdown):-
	robot((X,Y)),
	Y1 is Y-1,
	box((X,Y1)),
	Y2 is Y1-1,
	valid_push((X,Y2)),
	update(robot((X,Y)),robot((X,Y1)),[pushdown]),
	update(box((X,Y1)),box((X,Y2)),[]),!.
	
action(pushleft):-
	robot((X,Y)),
	X1 is X-1,
	box((X1,Y)),
	X2 is X1-1,
	valid_push((X2,Y)),
	update(robot((X,Y)),robot((X1,Y)),[pushdown]),
	update(box((X1,Y)),box((X2,Y)),[]),!.
	
action(pushright):-
	robot((X,Y)),
	X1 is X+1,
	box((X1,Y)),
	X2 is X1+1,
	valid_push((X2,Y)),
	update(robot((X,Y)),robot((X1,Y)),[pushright]),
	update(box((X1,Y)),box((X2,Y)),[]),!.

action(stop):-
	abort.

action(_):-
	write('ILLEGAL ACTION'),nl.

/*-----------------------------------------------------------------------
 valid_free_move/1: checks if a free move action is possible
 valid_push/1: checks if a push box action is possible
 -----------------------------------------------------------------------*/


valid_free_move((X,Y)):-
	in_boundaries((X,Y)),
	not(obstacle((X,Y))),
	not(box((X,Y))),!.
	
valid_push((X,Y)):-
	in_boundaries((X,Y)),
	not(obstacle((X,Y))).
	
/*-----------------------------------------------------------------------
 update/3: By using assert and retract updates:
           the position of the robot
           the position of the box
           the moves made by player so far (it adds a new move)
-----------------------------------------------------------------------*/

update(Previous,New,Action):-
	retract(Previous),
	assert(New),
	retract(moves(M)),
	append(M,Action,NewMoves),
	assert(moves(NewMoves)),!.

/*-----------------------------------------------------------------------

 in_boundaries:1: checks if coordinates are within the board dimensions
-----------------------------------------------------------------------*/
in_boundaries((X,Y)):-
	dimension((DX,DY)),
	X>=1,X=<DX,
	Y>=1,Y=<DY,!.
	
/*-----------------------------------------------------------------------
print_board(DimX,DimY) displays a DimX by DimY board with:
- space as an an empty cell
- R the position of the Robot
- O the position of an Obstacle
- X the target position
-----------------------------------------------------------------------*/

print_board(X,0):-!,
	nl,line(X).
print_board(X,Y):-
	nl,line(X),
	print_row(X,Y),
	NewY is Y-1,
	print_board(X,NewY).


print_row(0,_):-
	write('|'),
	!.

print_row(X,Y):-
	robot((X,Y)),!,
	NewX is X-1,
	print_row(NewX,Y),
	write('R|').
	
print_row(X,Y):-
	obstacle((X,Y)),!,
	NewX is X-1,
	print_row(NewX,Y),
	write('O|').
	
print_row(X,Y):-
	box((X,Y)),!,
	NewX is X-1,
	print_row(NewX,Y),
	write('B|').

print_row(X,Y):-
	target((X,Y)),!,
	NewX is X-1,
	print_row(NewX,Y),
	write('X|').


print_row(X,Y):-
	NewX is X-1,
	print_row(NewX,Y),
	write(' |').	
	
	
line(0):-!,
	write('+'),nl.
line(X):-
	write('+-'),
	X1 is X-1,
	line(X1).