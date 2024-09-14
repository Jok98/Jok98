# Database
### Is a collection of related data correlated and shared, manged by a system called DBMS (Database Management System).
### Databese functions:
- **Data integrity check** : defined by the user in relation to the values they can take on (assumere)
- **Database manipulation and query**
- **Security**: access control and user authentication
- **Transaction support**: a transaction is a sequence of operations that must be performed as a single indivisible unit of work

### Data modeling :
- **Conceptual data model**: describes the data at a high level of abstraction, without implementation details
- **Logical data model**: represents the data in terms of their logical structure, independent of the DBMS used
- **Physical data model**: represents the data insert into the database, including implementation details

### Entity Relationship Model (ERM)
- **Entity**: a thing or object in the real world that is distinguishable from other objects
- **Attribute**: a property of an entity
- **Relationship**: an association among two or more entities

### Relationship types
- **One-to-one**: (1:1) an entity of one type is associated with at most one entity of another type
- **One-to-many**: (1:N) an entity of one type is associated with many entities of another type
- **Many-to-many**: (N:N) an entity of one type is associated with many entities of another type and vice versa
    - **Associative entity**: an entity that exists to represent the relationship between two other entities

---

---

# Normalization
It's a process to produce smaller, well-structured relations that simplify the CRUD operations,<br>
avoid data anomalies allowing to modify the database schema without affecting the application programs that access the data,<br>
allowing to adapt the structure model.

- Domain -> Column type
- Tuple -> Row
- Atomic -> Not divisible

## First Normal Form (1NF)
A relation is in 1NF if and only : 
- all rows of the table contain the same number of columns
- the attributes of each tuple are atomic
- the values of each attribute are from the same domain
- the order of the tuples is irrelevant

## Second Normal Form (2NF)
A relation is in 2NF if and only if it is in 1NF and every non-key attribute is fully functionally dependent on the primary key.<br>
This case refers to a relation with a composite primary key, so the non-key attributes must be dependent on the entire primary key not only on a part of it.

## Third Normal Form (3NF)
A relation is in 3NF if and only if it is in 2NF and every non-key attribute is non-transitively dependent on the primary key.<br>
This case refers to a non-key attribute that is dependent on another non-key attribute, that is dependent on the primary key.<br>
This is not allowed in 3NF.

---

---

# Referential Integrity
Is a set of rules that defines how the data in one table must be related to the data in another table through the foreign key

Example : <br>
Clienti (Codice, RagioneSociale, Indirizzo)<br>
Ordini (NumeroOrdine, DataOrdine, CodiceCliente)<br>

### Applying referential integrity to the database means guaranteeing that a value present in the Orders table for the foreign key CustomerCode has a corresponding Code value in one of the rows of the Customers table. <br>Furthermore, you should not allow deletion of a customer from the Customers table if there are rows in the Orders table that refer to it.





