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

