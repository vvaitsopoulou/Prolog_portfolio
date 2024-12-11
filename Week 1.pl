/*---------------------------------------------------------------------
Consider a network of computers. Each computer within this network has a number of
properties, such as a unique name or id, a CPU brand and type, a GPU card, RAM and
storage in GB, the operating system installed, etc.
●
All computers are also organised as groups (subnets with specific names). One
computer may belong to two different subnets. In addition, each processor type
comes with a recommended operating system, not necessarily the same that runs on
a specific computer of the network.

Generate the following tables:
● One that contains at least 10 computers with their properties, with random
values for each property.
● One that shows the possible connections between computers.
● One that shows which computer belongs to which subnet.
● One that shows which operating system is recommended for which type of
processor.
Note: You could use any GenAI tool for the above as long as you state the right
prompt.

a) Write a set of Prolog facts that represent the above tables and provide at least
10 queries that demonstrate how you can use the program to retrieve
information about this network of computers. Explain each query in English
within comments.

b) Write a Prolog rule which, given a subnet name, returns all computers (one by
one) that belong to this subnet. Provide a query and the output.
c) Write a Prolog rule which suggests (one by one) which computers need
upgrading, i.e. their current operating system is not the one that is
recommended by the processor type. Provide a query and the output.
d) Provide a query that returns all computers (one by one) that are linked to only
one other computer.
---------------------------------------------------------------------*/
 
/*
GENERATING TABLES:
● One that contains at least 10 computers with their properties, with random
values for each property.
For this step, GenAi was used in order to randomize the values for each property. Some values were arbitrarily chosen to be provided to the 
AI generator so as to retain some control in the selection process 
The prompt used was as follows:

"Consider a network of computers. Each computer has the following properties: 
a)a unique id which may be any 4-digit number for example 1134 b)a CPU brand with possible values: AMD, Intel, NVIDIA, Acer 
c)a CPU type with possible values Dual Core, Quad Core, Hexa Core, Octa Core, Deca Core, d) a GPU card with possible 
values GeForce RTX 4090, GeForce RTX 4080, Radeon RX 7900 XT, Intel Arc A770, e)RAM with possible values 8GB, 16GB, 32GB, 64GB 
f) storage with possible values 500GB, 1000GB, 2000GB, and 4000GB, g) operating system installed with possible values: 
Microsoft Windows, MacOS and Linux. I want you to build a table with 20 entries. Each entry (row) represents one computer 
and each computer has all of the properties listed above, with a completely random combination of values."



● One that shows the possible connections between computers.
For this step GenAi was used in order to randomize the connections between computers. The assumptions made were that
each computer must be connected to at least one other computer.

The prompt used was as follows:
Using the ID values from the above table, create a new table with 20 rows, each row having a first column that lists each unique computer id
and a second column named connections that lists the id's of all the other computers it is connected to. Some computers are connected to only one other computer,
others are connected to more, in a random number up to 4. If one computer with X ID from the first column is connected to a Y ID in the second column, then when the Y ID 
shows up in its own first column entry the X ID should show up in its corresponding connections column.



● One that shows which computer belongs to which subnet.
ASSUMPTIONS:
1.The overall number of subnets is arbitrary (but larger than or equal to two). For this prompt we assumed the existence of three subnets: A, B , C
2.Each computer may be connected to either one (as "all computers are organised as groups")
or two different subnets at the same time and no more than that.

The prompt used was as follows:
Suppose now that we have three subnets A, B, C. From this table, take each unique computer id in the first column and generate a new table 
assigning to each entry(ID) one or two subnets. the subnets assigned to each entry should be random but each entry should be assigned to at least one subnet and at maximum two.




● One that shows which operating system is recommended for which type of
processor.For this table the matching of processors to operating systems was done completely arbitrarily.
The prompt used was as follows:

You said:
for the CPU type with possible values Dual Core, Quad Core, Hexa Core, Octa Core, Deca Core, each processor type
comes with a recommended operating system. for Dual Core it is Linux, for Quad Core and Hexa Core it is Microsoft Windows, 
for Octa Core it is MacOS and for Deca Core it is Linux. 
generate a table representing this data, where each cpu type is matched to its recommended system.


*/