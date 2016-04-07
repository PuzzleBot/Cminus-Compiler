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
* Variable declaration: x
23: ST 6, 0(4)   Pointer-> Var Table 
24: LDA 6, 1(6)   Variable 
25: LDA 4, 1(4)   Var Table 
* Function arguments
* Variable Access: x
26: LD 1, 0(5)
* VarExp: Value load
27: LD 1, 0(1)   Variable get value
* Operation Expression:
28: ST  1, 0(6)   Store value as a temp value
29: LDA 6,  1(6)    Stack alloc
  30:   LDC  1, 5, 0     IntExp constant val
31: LDA 6,  -1(6)    Stack dealloc
32: LD  2, 0(6)   Get value into operand
33: ADD 1, 2, 1    Add operation
* Return statement:
34: LDA 4, 0(5)   Table ptr = frame ptr 
35: LD 6, -1(4)   Restore stack ptr 
36: LD 5, -2(4)   Restore frame ptr 
37: LDA 4, -3(4)   Move stack ptr down 
38: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
22: LDC 7, 39, 0    Function Jump around
* Variable declaration: x
40: ST 6, 0(4)   Pointer-> Var Table 
41: LDA 6, 1(6)   Variable 
42: LDA 4, 1(4)   Var Table 
* Function arguments
* Variable Access: x
43: LD 1, 0(5)
* Assignment save result (Variable address):
44: ST  1, 0(6)   Store value as a temp value
45: LDA 6,  1(6)    Stack alloc
  46:   LDC  1, 4, 0     IntExp constant val
* Assignment Expression
47: LDA 6,  -1(6)    Stack dealloc
48: LD  2, 0(6)   Get value into operand
49: ST 1, 0(2)  var equals expression result
* Variable Access: x
50: LD 1, 0(5)
* Assignment save result (Variable address):
51: ST  1, 0(6)   Store value as a temp value
52: LDA 6,  1(6)    Stack alloc
* Function arguments
* Variable Access: x
53: LD 1, 0(5)
* VarExp: Value load
54: LD 1, 0(1)   Variable get value
55: ST 1, 0(6)    Store argument
* Call setup:
58: LDA 4, 1(4)   Increment stack 
59: ST 5, 0(4)   Store frame pointer 
60: LDA 4, 1(4)   Increment stack 
61: ST 6, 0(4)   Store stack pointer 
62: LDA 4, 1(4)   Increment stack 
63: LDA 5, 0(4)   Set new frame pointer 
56: LDA 3, 8(7)   Store return address
57: ST 3, 0(4)   Store return address
64: LDC 7, 26, 0   Jump to function 
* Continue after finishing function "addFive"
* Assignment Expression
65: LDA 6,  -1(6)    Stack dealloc
66: LD  2, 0(6)   Get value into operand
67: ST 1, 0(2)  var equals expression result
* Function arguments
* Variable Access: x
68: LD 1, 0(5)
* VarExp: Value load
69: LD 1, 0(1)   Variable get value
70: ST 1, 0(6)    Store argument
* Call setup:
73: LDA 4, 1(4)   Increment stack 
74: ST 5, 0(4)   Store frame pointer 
75: LDA 4, 1(4)   Increment stack 
76: ST 6, 0(4)   Store stack pointer 
77: LDA 4, 1(4)   Increment stack 
78: LDA 5, 0(4)   Set new frame pointer 
71: LDA 3, 8(7)   Store return address
72: ST 3, 0(4)   Store return address
79: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Return statement:
80: LDA 4, 0(5)   Table ptr = frame ptr 
81: LD 6, -1(4)   Restore stack ptr 
82: LD 5, -2(4)   Restore frame ptr 
83: LDA 4, -3(4)   Move stack ptr down 
84: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
85: LDA 4, -1(4)  Deallocation: Variable table in scope
86: LD 6, 0(4)  Deallocation: Scope variables
39: LDC 7, 87, 0    Function Jump around
* Finale
87: LDA 3, 8(7)   Store return address
88: ST 3, 0(4)   Store return address
89: LDA 4, 1(4)   Increment stack 
90: ST 5, 0(4)   Store frame pointer 
91: LDA 4, 1(4)   Increment stack 
92: ST 6, 0(4)   Store stack pointer 
93: LDA 4, 1(4)   Increment stack 
94: LDA 5, 0(4)   Set new frame pointer 
95: LDC 7, 40, 0   Jump to main 
96: HALT 0, 0, 0
