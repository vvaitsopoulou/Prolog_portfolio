/*---------------------------------------------------------------------
NOTE TO SELF: MAKE ALL THE CIRCUITS REFERENCED BELOW IN CIRCUITVERSE.ORG


---------------------------------------------------------------------*/

/*
a. Provide Prolog facts for the NAND gate.
*/

/*--------------------
nand/3:(+-/+-/+-)
----------------------*/
nand(0,0,1).
nand(0,1,1).
nand(1,0,1).
nand(1,1,0).
 
/*
b. Every logic gate, e.g. and, or, not, xor etc,
can be constructed through the logic gate NAND.
Write Prolog rules for implementing the and, or, not, xor gates
through a NAND gate only and verify that these output the correct truth table for each gate.
*/

/*--------------------
b1: NOT from NAND:
From computer systems architecture one NOT logic gate is implemented with the use of one NAND gate *insert graph in msword here*
therefore not/2 can be implemented as:
----------------------*/
not(A,B):-
	nand(A,A,B).

/*--------------------
b2: AND from NAND:
From computer systems architecture one AND logic gate is implemented with the use of one NAND gate followed 
by another NAND gate *insert graph in msword here* - the letters match my handwritten notes on notebook diagram
therefore and/3 can be implemented as:
----------------------*/	
and(A,B,Y):-
	nand(A,B,Z),
	nand(Z,Z,Y).

/*--------------------
b3: OR from NAND:
From computer systems architecture one OR logic gate is implemented with the use of three NAND gates *insert graph in msword here*
therefore or/3 can be implemented as:
----------------------*/

or(A,B,C):-
	nand(A,A,Z),
	nand(B,B,Y),
	nand(Z,Y,C).

/*--------------------
b4: XOR from NAND:
From computer systems architecture one OR logic gate is implemented with the use of four NAND gates *insert graph in msword here*
therefore xor/3 can be implemented as:
----------------------*/

xor(A,B,C):-
	nand(A,B,X),
	nand(A,X,Y),
	nand(B,X,Z),
	nand(Y,Z,C).

/*------------------------
verify that these output the correct truth table for each gate.
For this, we post the truth tables and then we will need to query every gate for each possible combination of inputs and cross check
the output is the desired one(alternatively we can also query with all inputs/outputs provided and see if the truth value swi prolog
returns is true)
-----------------------*/	

/*
Should the definitions for half-adder and full-adder change?

Since we have just proved that the NAND based implementation outputs the correct truth table for each gate the half-adder and full-adder
definitions do not need to change. this is the advantage of top down approach, since said definitions only rely on the behavior of and 
xor and or gates (as demonstrated by the truth tables) without being affected by the underlying implementation of these gates themselves.


*/

/*
d) from Computer Systems Architecture we recognise this as the logical circuit design of a decoder.

textbook citation : A decoder is a combinational circuit that converts binary information from n input lines to a maximum of 2n unique output lines.
also page 152 textbook CSA Truth Table of a Three-to-Eight-Line Decoder 
For each possible input combination, there are seven outputs that are equal to 0 and
only one that is equal to 1. The output whose value is equal to 1 represents the minterm
equivalent of the binary number currently available in the input lines.*/

decoder(input(A0, A1, A2),output(Z0,Z1,Z2,Z3,Z4,Z5,Z6,Z7)):-
	
/*An encoder is a digital circuit that performs the inverse operation of a decoder. An
encoder has 2n

(or fewer) input lines and n output lines. The output lines, as an aggregate,
generate the binary code corresponding to the input value. An example of an encoder
is the octal-to-binary encoder whose truth table is given in Table 4.7 . It has eight inputs
(one for each of the octal digits) and three outputs that generate the corresponding
binary number. It is assumed that only one input has a value of 1 at any given time.
The encoder can be implemented with OR gates whose inputs are determined
directly from the truth table. Output z is equal to 1 when the input octal digit is 1, 3, 5,
or 7. Output y is 1 for octal digits 2, 3, 6, or 7, and output x is 1 for digits 4, 5, 6, or 7. These
conditions can be expressed by the following Boolean output functions:

z = D1 + D3 + D5 + D7
y = D2 + D3 + D6 + D7
x = D4 + D5 + D6 + D7
The encoder can be implemented with three OR gates.
*/