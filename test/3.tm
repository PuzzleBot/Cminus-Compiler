* Standard prelude
  0:    LDC  6, 0, 0     load gp with 0
  1:    LDC  5, 1024, 0     Frame pointer is at the table bottom
  2:     ST  0, 0(0)     clear location 0
  3:    LDC 4, 1024, 0     Set starting variable stack
* code for input routine
  5:     IN  1, 0, 0  input
  6:    LDA  4, 0(5)    return sequence
  7:     LD  6, -1(4)   Restore stack ptr 
  8:     LD  5, -2(4)   Restore frame ptr 
  9:    LDA  4, -3(4)   Move table ptr down 
 10:     LD  7, 0(4)   Use return address to return 
* code for output routine
 11:     ST 6, 0(4)   Allocate x 
 12:    LDA 6, 1(6)   Allocate x
 13:    LDA 4, 1(4)   Allocate x
 14:     LD  1, 0(5)    load arg x address
 15:     LD  1, 0(1)    load arg x value
 16:    OUT  1, 0, 0  output
 17:    LDA  4, 0(5)    return sequence
 18:     LD  6, -1(4)   Restore stack ptr 
 19:     LD  5, -2(4)   Restore frame ptr 
 20:    LDA  4, -3(4)   Move table ptr down 
 21:     LD  7, 0(4)   Use return address to return 
  4:    LDC  7, 22, 0     jump around i/o code
* End of prelude
  23:   LDC  1, 5, 0     IntExp constant val
* Array declaration: x[absyn.IntExp@405084c6]
24: ST 6, 0(4)   Pointer-> Var Table 
25: ADD 6, 6, 1   Array Variable 
26: LDA 4, 1(4)   Var Table alloc 
* Variable declaration: z
27: ST 6, 0(4)   Pointer-> Var Table 
28: LDA 6, 1(6)   Variable 
29: LDA 4, 1(4)   Var Table 
  30:   LDC  1, 0, 0     IntExp constant val
* Array Access: x
31: LDA 2, 0(1)
32: LDA 1, 0(5)
33: LD 1, 0(1)
34: ADD 1, 1,2
* Assignment save result (Variable address):
35: ST  1, 0(6)   Store value as a temp value
36: LDA 6,  1(6)    Stack alloc
  37:   LDC  1, 4, 0     IntExp constant val
* Assignment Expression
38: LDA 6,  -1(6)    Stack dealloc
39: LD  2, 0(6)   Get value into operand
40: ST 1, 0(2)  var equals expression result
  41:   LDC  1, 1, 0     IntExp constant val
* Array Access: x
42: LDA 2, 0(1)
43: LDA 1, 0(5)
44: LD 1, 0(1)
45: ADD 1, 1,2
* Assignment save result (Variable address):
46: ST  1, 0(6)   Store value as a temp value
47: LDA 6,  1(6)    Stack alloc
  48:   LDC  1, 7, 0     IntExp constant val
* Assignment Expression
49: LDA 6,  -1(6)    Stack dealloc
50: LD  2, 0(6)   Get value into operand
51: ST 1, 0(2)  var equals expression result
  52:   LDC  1, 2, 0     IntExp constant val
* Array Access: x
53: LDA 2, 0(1)
54: LDA 1, 0(5)
55: LD 1, 0(1)
56: ADD 1, 1,2
* Assignment save result (Variable address):
57: ST  1, 0(6)   Store value as a temp value
58: LDA 6,  1(6)    Stack alloc
  59:   LDC  1, 11, 0     IntExp constant val
* Assignment Expression
60: LDA 6,  -1(6)    Stack dealloc
61: LD  2, 0(6)   Get value into operand
62: ST 1, 0(2)  var equals expression result
* Variable Access: z
63: LD 1, 1(5)
* Assignment save result (Variable address):
64: ST  1, 0(6)   Store value as a temp value
65: LDA 6,  1(6)    Stack alloc
  66:   LDC  1, 2, 0     IntExp constant val
* Array Access: x
67: LDA 2, 0(1)
68: LDA 1, 0(5)
69: LD 1, 0(1)
70: ADD 1, 1,2
* VarExp: Value load
71: LD 1, 0(1)   Variable get value
* Assignment Expression
72: LDA 6,  -1(6)    Stack dealloc
73: LD  2, 0(6)   Get value into operand
74: ST 1, 0(2)  var equals expression result
* Function arguments
* Variable Access: z
75: LD 1, 1(5)
* VarExp: Value load
76: LD 1, 0(1)   Variable get value
77: ST 1, 0(6)    Store argument
* Call setup:
80: LDA 4, 1(4)   Increment stack 
81: ST 5, 0(4)   Store frame pointer 
82: LDA 4, 1(4)   Increment stack 
83: ST 6, 0(4)   Store stack pointer 
84: LDA 4, 1(4)   Increment stack 
85: LDA 5, 0(4)   Set new frame pointer 
78: LDA 3, 8(7)   Store return address
79: ST 3, 0(4)   Store return address
86: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Return statement:
87: LDA 4, 0(5)   Table ptr = frame ptr 
88: LD 6, -1(4)   Restore stack ptr 
89: LD 5, -2(4)   Restore frame ptr 
90: LDA 4, -3(4)   Move stack ptr down 
91: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
92: LDA 4, -2(4)  Deallocation: Variable table in scope
93: LD 6, 0(4)  Deallocation: Scope variables
22: LDC 7, 94, 0    Function Jump around
* Finale
94: LDA 3, 8(7)   Store return address
95: ST 3, 0(4)   Store return address
96: LDA 4, 1(4)   Increment stack 
97: ST 5, 0(4)   Store frame pointer 
98: LDA 4, 1(4)   Increment stack 
99: ST 6, 0(4)   Store stack pointer 
100: LDA 4, 1(4)   Increment stack 
101: LDA 5, 0(4)   Set new frame pointer 
102: LDC 7, 23, 0   Jump to main 
103: HALT 0, 0, 0
