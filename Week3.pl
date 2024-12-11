 /*
 Consider an e-shop that keeps a record of available products in a form such as:
product(
...brand…,
…product id…,
type(...the type of the product…),
price(...the price in euros…)
).
For example, the first argument is the brand, e.g. apple, the second argument is a six
digit product id, e.g. 657892, the third argument is the type of the product, e.g.
mobilephone and the fourth product the price, say 1250 euros. The e-shop also keeps
a record of all user purchases in a form such as:
purchase(
user(... the name of the user …),
bought(... brand… , …product id…),
date(... the date in day, month, year …)
).
 */

/*------------------------------------------------------------
a) Write down at least ten product/4 Prolog facts representing products of type
mobilephone and clothing.

-----------------------
product/4:(+-/+-/+-/+-)
----------------------*/
product(apple,100001,type(mobilephone), price(1267)).
product(samsung,100002,type(mobilephone),price(1332)).
product(samsung,100003,type(mobilephone),price(785)).
product(xiaomi,100004,type(mobilephone),price(672)).
product(apple,100005,type(mobilephone),price(999)).
product(apple,100006,type(mobilephone),price(1561)).
product(luisvuitton,200001,type(clothing),price(432) ).
product(gucci,200002,type(clothing),price(567)).
product(burberry,200003,type(clothing),price(321)).
product(balenciaga,200004,type(clothing),price(1221)).
product(burberry,200005,type(clothing),price(1887)).
product(gucci,200006,type(clothing),price(854)).
product(gucci,200007,type(clothing),price(541)).
product(luisvuitton,200008,type(clothing),price(799)).

/*------------------------------------------------------------
b) Write down at least five purchase/3 facts representing the purchases by some
users (not necessarily all different).

-----------------------
purchase/3:(+-/+-/+-)
----------------------*/

purchase(user(katerina),bought(xiaomi,100004),date(13,4,2021)).
purchase(user(katerina),bought(gucci,200007),date(22,10,2021)).
purchase(user(anna),bought(samsung,100002),date(30,8,2023)).
purchase(user(anna),bought(burberry,200003),date(1,12,2024)).
purchase(user(anna),bought(luisvuitton,200008),date(5,12,2024)).
purchase(user(marios),bought(apple,100005),date(7,7,2022)).
purchase(user(kostas),bought(gucci,200007),date(6,3,2021)).

/*------------------------------------------------------------
c) Define a predicate, which, if called with the name of the buyer, it recommends
products of the same type as those bought in the past. The output should be a
term of the form buy(... brand …, … product id …, …price…). 
Provide queries
and output.

-----------------------
recommend/2:(+-/+-)
----------------------*/
recommend(Name, buy(Brand, Id, Price)):-
	purchase(user(Name), bought(_,Xid),_),
	product(_,Xid,type(Type),_),
	product(Brand, Id, type(Type), price(Price)),
	Id \= Xid. 
	/*so that it doesn't recommend the exact same product that was bought in the past. */

/*
we run the queries 
recommend(anna,X).
recommend(katerina,X).
recommend(marios,X).
recommend(kostas,X).
*/

/*------------------------------------------------------------
d) Define a predicate which, if called with the name of the buyer and a year, it
outputs all products (one by one) bought only in that year. Provide queries and
output. 

ASSUMPTION: With the way this is phrased we assume the meaning is "it
outputs all products (one by one) bought only in that year BY THAT PARTICULAR buyer(otherwise no point in providing buyer)"
-----------------------
past_purchases/3:(+-/+-/+-)
----------------------*/
past_purchases(Name, Year, product_sold(Brand, Id, Type, Price)):-
	purchase(user(Name),bought(_,Id),date(_,_,Year)),
	product(Brand, Id, Type, Price).

/*
we run the queries 
?-past_purchases(katerina, 2021, What).
?-past_purchases(katerina, 2020, What).
?-past_purchases(anna, 2023, What).
?-past_purchases(anna, 2024, What).
?-past_purchases(marios, 2024, What).
?-past_purchases(marios, 2022, What).
?-past_purchases(kostas, 2021, What).
*/

/*
e) Define (another?) predicate which, if called with a specific year, outputs all buyers 
*/

/*------------------------------------------------------------
we define buyers_per_year/2 as follows
-----------------------
buyers_per_year/2:(+-/+-)
----------------------*/
buyers_per_year(Name, Year):-
	past_purchases(Name, Year, _).

/*
we query:
?-buyers_per_year(Who, 2021).
?-buyers_per_year(Who, 2022,).
?-buyers_per_year(Who, 2023,).
?-buyers_per_year(Who, 2024,).

*/

