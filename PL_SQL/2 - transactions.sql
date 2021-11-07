--What is Transaction ?
/*
  A transaction is a sequence of operations performed (using one or more SQL statements) 
  on a database as a single logical unit of work. The effects of all the SQL statements in 
  a transaction can be either all committed (applied to the database) or all rolled back 
  (undone from the database). A database transaction must be atomic, consistent,
  isolated and durable. -ACID-
  in order to ensure accuracy, completeness, and data integrity
  
  
*/

/*
- Atomic : A transaction is a logical unit of work which must be either completed with all 
         of its data modifications, or none of them is performed.
		 -maintained by: Transaction Management Component

- Consistent* (correctness) (is compromised by modern databases) : At the end of the transaction, all data must be left in a consistent state.

- Isolated : Modifications of data performed by a transaction must be independent of another 
           transaction. Unless this happens, the outcome of a transaction may be erroneous.
		   -managed by: Concurrency control manager

- Durable : When the transaction is completed, effects of the modifications performed by 
          the transaction must be permanent in the system.
		  -responsibility of recovery manager
*/

/*
	Advantages of concurrent transactions execution:
		- increased performance
		- Resource utilization
		- decreased waiting time
		
	Five concurrency probelms that can occur in a database system:
	
	(i). Temporary Update Problem
	(ii). Incorrect Summary Problem
	(iii). Lost Update Problem
	(iv). Unrepeatable Read Problem
	(v). Phantom Read Problem 
	SOURCE: https://www.geeksforgeeks.org/concurrency-problems-in-dbms-transactions/
	
*/

/*
-- Locking
  Occurs if a transaction tries to acquire an incompatible lock on a resource that another 
  transaction has already locked. The blocked transaction remains blocked until the blocking 
  transaction release the lock.
  
-- DeadLocking
  Occurs when two ore more transactions have resource locked and each transacition requests 
  lock on the resource that another transaction has already lock.
  Neither of the transactions here can move forward as each one is waiting for another to 
  release the lock
*/
/*
--2Phase Locking Protocol
  -Locking (Growing)
  -Unlocking (Shrinking)
  -Locking
    A transaction applies locking on a desired data item one at a time.
  -Unlocking
    A transaction unlock its locked data items one at a time
    
  Requirement: for a transaction these two phases must be mutually exclusively
  that is during the locking phase the unlocking phase must not start and vice versa.
  
*/
