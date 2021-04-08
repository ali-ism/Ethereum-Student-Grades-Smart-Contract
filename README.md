# Ethereum-Student-Grades-Smart-Contract

Assignment 4

In this assignment, you will write a simple smart contract using the Solidity programming
language and the Remix Ethereum IDE.

The smart contract should store the grades of students in a class. Student information consists of a name, an AUB-style ID number, and an email address. Assume that there are up to 25 students, and that each student has grades for four assignments and a final exam. Each assignment or exam grade is an integer between 0 and 100.

The smart contract should store all the above information, and should calculate the following weighted sum and the course letter grade:

weighted sum = 0.15×(sum of assignment grades) + 0.4×(final exam grade)

The course letter grade is assigned to each student in accordance with the following table:

weighted sum course grade
< 60 F
60 to 69 D
70 to 79 C
80 to 89 B
90 to 100 A
