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
a)a unique id which may be any 4-digit number for example 1134 
b)a CPU brand with possible values: AMD, Intel, NVIDIA, Acer 
c)a CPU type with possible values Dual Core, Quad Core, Hexa Core, Octa Core, Deca Core, 
d) a GPU card with possible values GeForce RTX 4090, GeForce RTX 4080, Radeon RX 7900 XT, Intel Arc A770, 
e)RAM with possible values 8GB, 16GB, 32GB, 64GB 
f) storage with possible values 500GB, 1000GB, 2000GB, and 4000GB, 
g) operating system installed with possible values: 
Microsoft Windows, MacOS and Linux. I want you to build a table with 20 entries. Each entry (row) represents one computer 
and each computer has all of the properties listed above, with a completely random combination of values."

************************************************************************************************/
device(id(1134),cpu_brand('Intel'),cpu_type('Quad Core'),gpu_card('GeForce RTX 4090'),ram_in_gb(32),storage_in_gb(1000),operating_system('Microsoft Windows')).
device(id(2278),cpu_brand('AMD'),cpu_type('Octa Core'),gpu_card('Radeon RX 7900 XT'),ram_in_gb(8),storage_in_gb(500),operating_system('Linux')).
device(id(3249),cpu_brand('NVIDIA'),cpu_type('Dual Core'),gpu_card('Intel Arc A770'),ram_in_gb(16),storage_in_gb(2000),operating_system('MacOS')).
device(id(4423),cpu_brand('Intel'),cpu_type('Hexa Core'),gpu_card('GeForce RTX 4080'),ram_in_gb(64),storage_in_gb(1000),operating_system('Microsoft Windows')).
device(id(5182),cpu_brand('Acer'),cpu_type('Quad Core'),gpu_card('GeForce RTX 4090'),ram_in_gb(16),storage_in_gb(500),operating_system('Linux')).
device(id(6235),cpu_brand('AMD'),cpu_type('Deca Core'),gpu_card('Radeon RX 7900 XT'),ram_in_gb(32),storage_in_gb(2000),operating_system('MacOS')).
device(id(7350),cpu_brand('NVIDIA'),cpu_type('Dual Core'),gpu_card('Intel Arc A770'),ram_in_gb(8),storage_in_gb(4000),operating_system('Microsoft Windows')).
device(id(8451),cpu_brand('Acer'),cpu_type('Quad Core'),gpu_card('GeForce RTX 4080'),ram_in_gb(2),storage_in_gb(1000),operating_system('Linux')).
device(id(9123),cpu_brand('Intel'),cpu_type('Hexa Core'),gpu_card('Radeon RX 7900 XT'),ram_in_gb(64),storage_in_gb(500),operating_system('MacOS')).
device(id(1058),cpu_brand('AMD'),cpu_type('Deca Core'),gpu_card('GeForce RTX 4090'),ram_in_gb(16),storage_in_gb(4000),operating_system('Microsoft Windows')).
device(id(2157),cpu_brand('NVIDIA'),cpu_type('Octa Core'),gpu_card('Intel Arc A770'),ram_in_gb(8),storage_in_gb(1000),operating_system('MacOS')).
device(id(3392),cpu_brand('Acer'),cpu_type('Quad Core'),gpu_card('GeForce RTX 4080'),ram_in_gb(64),storage_in_gb(2000),operating_system('Linux')).
device(id(4620),cpu_brand('Intel'),cpu_type('Dual Core'),gpu_card('Radeon RX 7900 XT'),ram_in_gb(16),storage_in_gb(500),operating_system('Microsoft Windows')).
device(id(5281),cpu_brand('AMD'),cpu_type('Hexa Core'),gpu_card('GeForce RTX 4080'),ram_in_gb(32),storage_in_gb(4000),operating_system('Linux')).
device(id(6339),cpu_brand('NVIDIA'),cpu_type('Deca Core'),gpu_card('GeForce RTX 4090'),ram_in_gb(64),storage_in_gb(2000),operating_system('MacOS')).
device(id(7487),cpu_brand('Acer'),cpu_type('Octa Core'),gpu_card('Intel Arc A770'),ram_in_gb(8),storage_in_gb(1000),operating_system('Microsoft Windows')).
device(id(8234),cpu_brand('AMD'),cpu_type('Quad Core'),gpu_card('Radeon RX 7900 XT'),ram_in_gb(16),storage_in_gb(500),operating_system('Linux')).
device(id(9345),cpu_brand('NVIDIA'),cpu_type('Hexa Core'),gpu_card('GeForce RTX 4080'),ram_in_gb(32),storage_in_gb(4000),operating_system('MacOS')).
device(id(1402),cpu_brand('Intel'),cpu_type('Dual Core'),gpu_card('Intel Arc A770'),ram_in_gb(8),storage_in_gb(500),operating_system('Microsoft Windows')).
device(id(2653),cpu_brand('Acer'),cpu_type('Deca Core'),gpu_card('Radeon RX 7900 XT'),ram_in_gb(64),storage_in_gb(1000),operating_system('Linux')).


/***********************************************************************************************


● One that shows the possible connections between computers.
For this step GenAi was used in order to randomize the connections between computers. The assumptions made were that
each computer must be connected to at least one other computer.

The prompt used was as follows:
Using the ID values from the above table, create a new table with 20 rows, each row having a first column that lists each unique computer id
and a second column named connections that lists the id's of all the other computers it is connected to. Some computers are connected to only one other computer,
others are connected to more, in a random number up to 4. If one computer with X ID from the first column is connected to a Y ID in the second column, then when the Y ID 
shows up in its own first column entry the X ID should show up in its corresponding connections column.
1134	 4423
2278	 4620
3249	 4423, 9123, 5281
4423	 1134, 3249, 7350, 1058
5182	 8451
6235	 3392,  5281, 9345
7350	 4423,  3392
8451	 5182,  1058
9123	 3249, 5281, 8234
1058	 4423, 8451, 2157, 9345
2157	 1058, 3392
3392	 6235, 7350, 2157, 2653
4620	2278,  5281, 1402
5281	3249, 9123, 4620
6339	8234, 2653, 9345

7487	 1402

8234	9123, 6339, 2653

9345	6235, 1058, 6339

1402	4620, 7487, 2653

2653	3392, 6339, 8234, 1402
************************************************************************************************/
connected_devices(1134,4423).
connected_devices(2278,4620).
connected_devices(3249,4423).
connected_devices(3249,9123).
connected_devices(3249,5281).
connected_devices(4423,1134).
connected_devices(4423,3249).
connected_devices(4423,7350).
connected_devices(4423,1058).
connected_devices(5182,8451).
connected_devices(6235,3392).
connected_devices(6235,5281).
connected_devices(6235,9345).
connected_devices(7350,4423).
connected_devices(7350,3392).
connected_devices(8451,5182).
connected_devices(8451,1058).
connected_devices(9123,3249).
connected_devices(9123,5281).
connected_devices(9123,8234).
connected_devices(1058,4423).
connected_devices(1058,8451).
connected_devices(1058,2157).
connected_devices(1058,9345).
connected_devices(2157,1058).
connected_devices(2157,3392).
connected_devices(3392,6235).
connected_devices(3392,7350).
connected_devices(3392,2157).
connected_devices(3392,2653).
connected_devices(4620,2278).
connected_devices(4620,5281).
connected_devices(4620,1402).
connected_devices(5281,3249).
connected_devices(5281,9123).
connected_devices(5281,4620).
connected_devices(6339,8234).
connected_devices(6339,2653).
connected_devices(6339,9345).
connected_devices(7487,1402).
connected_devices(8234,9123).
connected_devices(8234,6339).
connected_devices(8234,2653).
connected_devices(9345,6235).
connected_devices(9345,1058).
connected_devices(9345,6339).
connected_devices(1402,4620).
connected_devices(1402,7487).
connected_devices(1402,2653).
connected_devices(2653,3392). 
connected_devices(2653,6339). 
connected_devices(2653,8234). 
connected_devices(2653,1402). 
/***********************************************************************************************
● One that shows which computer belongs to which subnet.
ASSUMPTIONS:
1.The overall number of subnets is arbitrary (but larger than or equal to two). For this prompt we assumed the existence of three subnets: A, B , C
2.Each computer may be connected to either one (as "all computers are organised as groups")
or two different subnets at the same time and no more than that.

The prompt used was as follows:
Suppose now that we have three subnets A, B, C. From this table, take each unique computer id in the first column and generate a new table 
assigning to each entry(ID) one or two subnets. the subnets assigned to each entry should be random but each entry should be assigned to at least one subnet and at maximum two.

ID	Subnets
1134	A, B
2278	B
3249	A, C
4423	B, C
5182	A
6235	C
7350	A, B
8451	B
9123	A, C
1058	C
2157	A, B
3392	B, C
4620	A
5281	B, C
6339	C
7487	A, B
8234	B
9345	A, C
1402	C
2653	A, B

************************************************************************************************/
belongs_to_subnet(1134,'A'). 
belongs_to_subnet(1134,'B'). 
belongs_to_subnet(2278,'B').
belongs_to_subnet(3249,'A').
belongs_to_subnet(3249,'C'). 
belongs_to_subnet(4423,'B'). 
belongs_to_subnet(4423,'C'). 
belongs_to_subnet(5182,'A'). 
belongs_to_subnet(6235,'C'). 
belongs_to_subnet(7350,'A'). 
belongs_to_subnet(7350,'B'). 
belongs_to_subnet(8451,'B'). 
belongs_to_subnet(9123,'A'). 
belongs_to_subnet(9123,'C').
belongs_to_subnet(1058,'C').
belongs_to_subnet(2157,'A').
belongs_to_subnet(2157,'B').
belongs_to_subnet(3392,'B').
belongs_to_subnet(3392,'C').
belongs_to_subnet(4620,'A').
belongs_to_subnet(5281,'B').
belongs_to_subnet(5281,'C').
belongs_to_subnet(6339,'C').
belongs_to_subnet(7487,'A').
belongs_to_subnet(7487,'B').
belongs_to_subnet(8234,'B').
belongs_to_subnet(9345,'A').
belongs_to_subnet(9345,'C').
belongs_to_subnet(1402,'C').
belongs_to_subnet(2653,'A').
belongs_to_subnet(2653,'B').


/***********************************************************************************************


● One that shows which operating system is recommended for which type of
processor.For this table the matching of processors to operating systems was done completely arbitrarily.
The prompt used was as follows:

You said:
for the CPU type with possible values Dual Core, Quad Core, Hexa Core, Octa Core, Deca Core, each processor type
comes with a recommended operating system. for Dual Core it is Linux, for Quad Core and Hexa Core it is Microsoft Windows, 
for Octa Core it is MacOS and for Deca Core it is Linux. 
generate a table representing this data, where each cpu type is matched to its recommended system.

CPU Type	Recommended OS
Dual Core	Linux
Quad Core	Microsoft Windows
Hexa Core	Microsoft Windows
Octa Core	MacOS
Deca Core	Linux

*************************************************************************************************/
recommended_for(cpu_type('Dual Core'),operating_system('Linux')).
recommended_for(cpu_type('Quad Core'),operating_system('Microsoft Windows')).
recommended_for(cpu_type('Hexa Core'),operating_system('Microsoft Windows')).
recommended_for(cpu_type('Octa Core'),operating_system('MacOS')).
recommended_for(cpu_type('Deca Core'),operating_system('Linux')).

/****************************************************************************************************************
a) Write a set of Prolog facts that represent the above tables 
and provide at least 10 queries that demonstrate how you can use the program to retrieve
information about this network of computers. 
Explain each query in English
within comments.

QUERIES:
1.display all the device id's (one by one) that have a gpu card of GeForce RTX 4090 type and ram equal to 32GB:
?- device(id(X),_,_,gpu_card('Radeon RX 7900 XT'),ram_in_gb(32),_,_).
X = 6235 .

2.display the id's of all the devices (one by one) that device 3392 is connected to:
?- connected_devices(3392,X).
X = 6235 ;
X = 7350 ;
X = 2157 ;
X = 2653.

equivalently, because of our assumption that all connections are bidirectional we will get  the same results if we query the id's of all devices that are 
connected to device 3392:
?- connected_devices(X,3392).
X = 6235 ;
X = 7350 ;
X = 2157 ;
X = 2653.

3.


**************************************************************************************************/

/****************************************************************************************************************
a) Write a set of Prolog facts that represent the above tables 
and provide at least 10 queries that demonstrate how you can use the program to retrieve
information about this network of computers. 
Explain each query in English
within comments.

b) Write a Prolog rule which, given a subnet name, returns all computers (one by
one) that belong to this subnet. Provide a query and the output.
c) Write a Prolog rule which suggests (one by one) which computers need
upgrading, i.e. their current operating system is not the one that is
recommended by the processor type. Provide a query and the output.
d) Provide a query that returns all computers (one by one) that are linked to only
one other computer.

**************************************************************************************************/
subnet_device(Subnet, Device_id) :-
    belongs_to_subnet(Device_id, Subnet).

needs_os_upgrade(Device_id) :-
    device(Device_id, _, cpu_type(Type), _, _, _, operating_system(Os)),
    \+ recommended_for(cpu_type(Type), operating_system(Os)).

one_connection(Device_id) :-
    connected_devices(Device_id, X),
    \+ (connected_devices(Device_id, Y), 
    Y \= X).
    
