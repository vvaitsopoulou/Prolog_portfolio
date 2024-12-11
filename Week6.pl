/*------------------------------------------------------------------------
  CC2200 Logic Programming
  Help file for the purposes of labs

  string_to_listofletters/2: takes a string and transforms it
  into a list of lower case letters.

  Comments: 
  - It accepts only upper and lower case letters in the string
  - A space is left as a space
  - All other characters are marked as invalid.
------------------------------------------------------------------------*/

string_to_listofletters(String,ListOfLetters):-
	string_codes(String,AsciiList),		% built-in
	asciitoletters(AsciiList,ListOfLetters).
	
asciitoletters([],[]).
asciitoletters([32|AsciiT],[' '|T]):-		% a space
	asciitoletters(AsciiT,T).
asciitoletters([46|AsciiT],['.'|T]):-		% a dot . 
	asciitoletters(AsciiT,T).
asciitoletters([45|AsciiT],['-'|T]):-		% a a dash -
	asciitoletters(AsciiT,T).
asciitoletters([95|AsciiT],['_'|T]):-		% a underscore _
	asciitoletters(AsciiT,T).
asciitoletters([AsciiH|AsciiT],[H|T]):-		% a lower case
	AsciiH>=97, 
	AsciiH=<122,!,
	name(H,[AsciiH]),			% built-in
	asciitoletters(AsciiT,T).
asciitoletters([AsciiH|AsciiT],[H|T]):-		% an upper case
	AsciiH>=65, 
	AsciiH=<90,!,
	LowerAsciiH is AsciiH+32,
	name(H,[LowerAsciiH]),			% built-in	
	asciitoletters(AsciiT,T).
asciitoletters([_|AsciiT],[invalid|T]):-	% all others
	asciitoletters(AsciiT,T).

/*------------------------------------------------------------------------
  string_to_listofwords/2: takes a string and transforms it
  into a list of words which are lists of letters.

  Comments: 
  - It accepts only upper and lower case letters in the string
------------------------------------------------------------------------*/

string_to_listofwords(String,ListOfWords):-
	string_to_listofletters(String,ListOfLetters),
	letters_to_wordlists(ListOfLetters, ListOfWordsTemp),
	get_rid_of_spaces(ListOfWordsTemp,ListOfWords).

letters_to_wordlists(ListOfLetters, [Word|RestListOfWords]):-
	append(Word,[' '|Rest],ListOfLetters),!,
	letters_to_wordlists(Rest,RestListOfWords).	
letters_to_wordlists(X,[X]).

get_rid_of_spaces([],[]).			% get rid of []s
get_rid_of_spaces([[]|T],R):-
	get_rid_of_spaces(T,R).
get_rid_of_spaces([H|T],[H|R]):-
	H\=[],
	get_rid_of_spaces(T,R).



% 1.
% There are thousands of Morse code messages from the 20th century that have not yet been decrypted
% and might hide some important information for historical reasons. Define a Prolog program
% (more than one predicate may be needed) that given a sentence (list of separate Morse code symbols),
% it decrypts the sentence to English.  The English sentence should be returned as a list of letters
% and displayed as a full sentence on the screen. Provide queries and results. Can the program be used
% for the reverse operation, i.e. English to Morse code?

% by convention we only map out non capital letters in this exercise (no numbers)
morse_to_letter(['.', '-'], a).
morse_to_letter(['-', '.', '.', '.'], b).
morse_to_letter([ '-', '.', '-', '.'], c).
morse_to_letter([ '-', '.', '.'], d).
morse_to_letter([ '.'], e).
morse_to_letter([ '.', '.', '-', '.'], f).
morse_to_letter([ '-', '-', '.'], g).
morse_to_letter([ '.', '.', '.', '.'], h).
morse_to_letter([ '.', '.'], i).
morse_to_letter([ '.', '-', '-', '-'], j).
morse_to_letter([ '-', '.', '-'], k).
morse_to_letter([ '.', '-', '.', '.'], l).
morse_to_letter([ '-', '-'], m).
morse_to_letter([ '-', '.'], n).
morse_to_letter([ '-', '-', '-'], o).
morse_to_letter([ '.', '-', '-', '.'], p).
morse_to_letter([ '-', '-', '.', '-'], q).
morse_to_letter([ '.', '-', '.'], r).
morse_to_letter([ '.', '.', '.'], s).
morse_to_letter([ '-'], t).
morse_to_letter([ '.', '.', '-'], u).
morse_to_letter([ '.', '.', '.', '-'], v).
morse_to_letter([ '.', '-', '-'], w).
morse_to_letter([ '-', '.', '.', '-'], x).
morse_to_letter([ '-', '.', '-', '-'], y).
morse_to_letter([ '-', '-', '.', '.'], z).
morse_to_letter([' '], ' ').

morse_decode([], []). 

morse_decode([Morse_init | Rest_of_morse], [Letter_init | Rest_of_letters]) :-
    morse_to_letter(Morse_init, Letter_init),
    morse_decode(Rest_of_morse, Rest_of_letters).

morse_to_words(MorseList, LetterList, Word):-
	morse_decode(MorseList, LetterList), 
	wordtolist(Word, LetterList).

% QUERIES:
% ?- morse_to_words([['.', '-'],[ '-', '.'],[ '-', '.'],['.', '-']], Decoded_list, Decode).
% Decoded_list = [a, n, n, a],
% Decode = anna.

% ?- morse_to_words([['-', '.', '.', '.'],[ '.', '.'],[ '-', '-', '.', '.'],['.', '-'],[ '.', '-', '.'],[ '.', '-', '.'],[ '.']], Decoded_list, Decode).
% Decoded_list = [b, i, z, a, r, r, e],
% Decode = bizarre .

% ?- morse_to_words([[ '-', '-', '.', '.'],[ '-', '-', '-'],[ '-', '-', '-']], Decoded_list, Decode).
% Decoded_list = [z, o, o],
% Decode = zoo .

% ?- morse_to_words([['.', '.'],[' '],[ '.', '-', '-'],[ '.'],[ '-', '.'],[ '-'],[' '],[ '-'],[ '-', '-', '-'],[' '],[ '-'],[ '.', '.', '.', '.'],[ '.'],[' '],[ '-', '-', '.', '.'],[ '-', '-', '-'],[ '-', '-', '-']], Decoded_list, Decode).
% Decoded_list = [i, ' ', w, e, n, t, ' ', t, o|...],
% Decode = 'i went to the zoo' .

%can it be used in reverse?	
% it can using the predicate morse_decode but it cannot if we use morse_to_words

% if we use trace with ?- morse_to_words(MorseList, LetterList, word). , we get an infinite list of calls and exits
% like this:
%    Call: (12) morse_to_words(_22364, _22366, word) ? creep
%    Call: (13) morse_decode(_22364, _22366) ? creep
%    Exit: (13) morse_decode([], []) ? creep
%    Call: (13) wordtolist(word, []) ? creep
%    Call: (14) var(word) ? creep
%    Fail: (14) var(word) ? creep
%    Redo: (13) wordtolist(word, []) ? creep
%    Call: (14) var([]) ? creep
%    Fail: (14) var([]) ? creep
%    Fail: (13) wordtolist(word, []) ? creep
%    Redo: (13) morse_decode(_22364, _22366) ? creep
%    Call: (14) morse_to_letter(_31798, _31804) ? creep
%    Exit: (14) morse_to_letter(['.', -], a) ? creep
%    Call: (14) morse_decode(_31800, _31806) ? creep
%    Exit: (14) morse_decode([], []) ? creep
%    Exit: (13) morse_decode([['.', -]], [a]) ? creep
%    Call: (13) wordtolist(word, [a]) ? creep
%    Call: (14) var(word) ? creep
%    Fail: (14) var(word) ? creep
%    Redo: (13) wordtolist(word, [a]) ? creep
%    Call: (14) var([a]) ? creep
%    Fail: (14) var([a]) ? creep
%    Fail: (13) wordtolist(word, [a]) ? creep
%    Redo: (14) morse_decode(_31800, _31806) ? creep
%    Call: (15) morse_to_letter(_42336, _42342) ? creep
%    Exit: (15) morse_to_letter(['.', -], a) ? creep
%    Call: (15) morse_decode(_42338, _42344) ? creep
%    Exit: (15) morse_decode([], []) ? creep
%    Exit: (14) morse_decode([['.', -]], [a]) ? creep
%    Exit: (13) morse_decode([['.', -], ['.', -]], [a, a]) ? creep
%    Call: (13) wordtolist(word, [a, a]) ? creep
%    Call: (14) var(word) ? creep
%    Fail: (14) var(word) ? ...................................
% because we do not have the letterlist defined before the recursion and backtracking starts so all possible Morse codes for all possible letters are explored infinitely.
% to avoid this we can code the reverse operation encode() like this:
morse_encode([], []). 

morse_encode([Letter_init | Rest_of_letters],[Morse_init | Rest_of_morse]):-
	morse_to_letter(Morse_init, Letter_init),
	morse_encode( Rest_of_letters, Rest_of_morse).

words_to_morse(MorseList, LetterList, Word):-
	wordtolist(Word, LetterList), %it is very important this happens before the recursive rule call.
	morse_encode(LetterList, MorseList).

% Now this query works:
% ?- words_to_morse(MorseList, LetterList, word).
% MorseList = [['.', -, -], [-, -, -], ['.', -, '.'], [-, '.', '.']],
% LetterList = [w, o, r, d].

% Consider the exercise above where a program finds whether a word has a missing letter. 
% We would like to develop a spell checker that identifies more errors. 
% Use the files Lab06 Spell-Check-Help-File.pl and SentenceToListOfLettersOrWords.pl. 
% a) Increase the number of facts that represent the correct words, say 20 facts. 

word([p,r,o,l,o,g]).
word([w,i,s,e]).
word([p,o,t,i,o,n]).
word([a,d,v,e,n,t,u,r,e]).
word([d,r,a,g,o,n]).
word([e,l,f]).
word([s,w,o,r,d]).
word([t,a,v,e,r,n]).
word([h,o,r,s,e]).
word([m,e,l,e,e]).
word([c,r,o,w,n]).
word([t,h,r,o,n,e]).
word([c,o,u,n,c,i,l]).
word([p,a,r,a,p,e,t,s]).
word([c,a,s,t,l,e]).
word([s,a,t,c,h,e,l]).
word([m,e,a,l]).
word([c,o,u,r,t,y,a,r,d]).
word([a,s,t,r,o,n,o,m,e,r]).
word([s,p,e,l,l]).


% b) Define Prolog predicates for the following spelling errors: 
% ● transposition of two letters only, e.g. talbe instead of table 


missing_letter(Error_word, Missing_letter):-
	word(Correct_word),
	select(Missing_letter, Correct_word, Error_word).

/****************************************************
transposition/2(+-/+-)
******************************************************/
transposition(Error_word, Correct_word):-
	word(Correct_word),
	append(First_half, [X, Y | Common_tail], Correct_word),
	append(First_half, [Y, X | Common_tail], Error_word).    
% ● one wrong letter, e.g. tible instead of table 
one_wrong_letter(Error_word, Correct_word):-
	word(Correct_word),
	select(X, Correct_word, Result),
	select(Y, Error_word, Result),
	X \= Y.   
% ● one extra letter, e.g. taible instead of table 
one_extra_letter(Error_word, Correct_word):-
	word(Correct_word),
	append(First_half, Common_tail, Correct_word),
	append(First_half, [X | Common_tail], Error_word).
% c) Define a predicate that, given a sentence as input, displays warning for each of the spelling errors
%  or “unknown word” for any word that cannot be found correct or with a spelling error. 

% Provide queries and results.

/*--------------------------------------------------------------
SPELL CHECKER HELP FILE
--------------------------------------------------------------*/

/*--------------------------------------------------------------
spell_check/0 reads a sentence from the keyboard and transforms
it into a list (words) of lists (letters for each word).
--------------------------------------------------------------*/

spell_check(Sentence):- 
	string_to_listofwords(Sentence,ListofWords),
	write(ListofWords),nl,
	check(ListofWords),!.

/*--------------------------------------------------------------
check/1 calls check_word in order to check spelling for each 
word in a sentence.
--------------------------------------------------------------*/

check([]).
check([WordLetters|Rest]):-
	check_word(WordLetters),
	check(Rest).

/*--------------------------------------------------------------
check_word/1 checks various types of errors in a word and prints
out the appropriate message. 
--------------------------------------------------------------*/

check_word(WL):- 
	missing_letter(WL,X),		% as defined in Lab 6.6
	wordtolist(W,WL),
	writelist([W,' has a missing letter ', X]), nl.
/*--------------------------------------------------------------
  Put the rest of the errors here	
--------------------------------------------------------------*/
check_word(Error_word_list):-
	transposition(Error_word_list, Correct_word_list),
	wordtolist(EW, Error_word_list),
	wordtolist(CW, Correct_word_list),
	writelist(['Instead of ', EW, ' did you mean ', CW, '?']),nl.

check_word(Error_word_list):-
	one_wrong_letter(Error_word_list, Correct_word_list),
	wordtolist(EW, Error_word_list),
	wordtolist(CW, Correct_word_list),
	writelist(['Instead of ', EW, ' did you mean ', CW, '?']),nl.

check_word(Error_word_list):-
	one_extra_letter(Error_word_list, Correct_word_list),
	wordtolist(EW, Error_word_list),
	wordtolist(CW, Correct_word_list),
	writelist(['Instead of ', EW, ' did you mean ', CW, '?']),nl.

check_word(Error_word_list):-	
	word(Error_word_list),
	writelist(['No typos detected']),nl.	

check_word(Error_word_list):-	
	writelist(['Unknown error']),nl.

% missing_letter(WL,X):- ...


/*--------------------------------------------------------------
  Converts a word (atom) to a list of letters and vice-versa.
  ?- wordtolist(prolog, WordLetters).
  WordLetters = [p,r,o,l,o,g]
  ?- wordtolist(Word, [p,r,o,l,o,g]).
  Word = prolog
--------------------------------------------------------------*/

wordtolist(W,L):- var(W),!, ltow(W,L).
wordtolist(W,L):- var(L),!, wtol(W,L).

wtol(W,L):- name(W,ASCII),asciitoletter(ASCII,L).

ltow(W,L):- asciitoletter(ASCII,L), name(W,ASCII).

asciitoletter([],[]).
asciitoletter([ASCIIH|ASCIIT],[H|T]):-
	name(H,[ASCIIH]),!,
	asciitoletter(ASCIIT,T).

%Definition of writelist was missing from the original file so I wrote it myself
writelist([]):-
	write(' ').	

writelist([H|T]):-
	write(H),
	write(' '),
	writelist(T).

%	queries and results:
% ?- spell_check('horse hors hosre horbe horsed hodfjjd'). 
% [[h,o,r,s,e],[h,o,r,s],[h,o,s,r,e],[h,o,r,b,e],[h,o,r,s,e,d],[h,o,d,f,j,j,d]]
% No typos detected  
% hors  has a missing letter  e  
% Instead of  hosre  did you mean  horse ?  
% Instead of  horbe  did you mean  horse ?  
% Instead of  horsed  did you mean  horse ?  
% Unknown error  
% true.

% ?- spell_check('dragon dagon draogn drafon sdragon drff').
% [[d,r,a,g,o,n],[d,a,g,o,n],[d,r,a,o,g,n],[d,r,a,f,o,n],[s,d,r,a,g,o,n],[d,r,f,f]]
% No typos detected  
% dagon  has a missing letter  r  
% Instead of  draogn  did you mean  dragon ?  
% Instead of  drafon  did you mean  dragon ?  
% Instead of  sdragon  did you mean  dragon ?  
% Unknown error  
% true.