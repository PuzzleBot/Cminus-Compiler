0: LDC 0, 5, 0
1: LDC 1, 7, 0
2: ST  0, 4(1)
3: LDC 3, 11, 0
4: LD  2, 0(3)  Load whatever is at the address pointed by r3 (11)
5: OUT 2, 0, 0  Prints 5

6: LDC 0, 105, 0
7: LDC 6, 0, 0
8: ST  0, 0(6)     Store whatever is in r0 into the address in r6 (which is 0)
9: LDC 0, 1, 0
10: ADD 6, 0, 0   
11: LDA 7, 15, 0   Put 15 into register 7 (PC)

15: OUT 0, 0, 0   
16: OUT 7, 0, 0
17: LDC 0, 105, 0   r0 is now 105
18: LDC 1, 500, 0   r1 is now 500
19: ST  1, 105(0)   Store the contents of register 1 at 105 which is 500
21: LDA 7, 0(0)     Load into PC: The number inside register 0 (not whatever is at the address 0 points to)
20: JGE 0, 3(7)     Branch less than or equal to 24 (3 + 1)

23: OUT 0, 0, 0

300: LD 0, 0(1)     Load into r0 the contents in memory at the address in r1
301: LDA 0, 0(1)     Load into r0 the stuff inside r1

