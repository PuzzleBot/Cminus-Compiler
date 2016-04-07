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
* Variable declaration: z
22: ST 6, 0(4)   Pointer-> Var Table 
23: LDA 6, 1(6)   Variable 
24: LDA 4, 1(4)   Var Table 
  26:   LDC  1, 5, 0     IntExp constant val
* Array declaration: x[absyn.IntExp@1c980484]
27: ST 6, 0(4)   Pointer-> Var Table 
28: ADD 6, 6, 1   Array Variable 
29: LDA 4, 1(4)   Var Table alloc 
* Variable declaration: y
30: ST 6, 0(4)   Pointer-> Var Table 
31: LDA 6, 1(6)   Variable 
32: LDA 4, 1(4)   Var Table 
  33:   LDC  1, 0, 0     IntExp constant val
* Array Access: x
34: LDA 2, 0(1)
35: LDA 1, 0(5)
36: LD 1, 0(1)
37: ADD 1, 1,2
* Assignment save result (Variable address):
38: ST  1, 0(6)   Store value as a temp value
39: LDA 6,  1(6)    Stack alloc
  40:   LDC  1, 4, 0     IntExp constant val
* Assignment Expression
41: LDA 6,  -1(6)    Stack dealloc
42: LD  2, 0(6)   Get value into operand
43: ST 1, 0(2)  var equals expression result
  44:   LDC  1, 1, 0     IntExp constant val
* Array Access: x
45: LDA 2, 0(1)
46: LDA 1, 0(5)
47: LD 1, 0(1)
48: ADD 1, 1,2
* Assignment save result (Variable address):
49: ST  1, 0(6)   Store value as a temp value
50: LDA 6,  1(6)    Stack alloc
  51:   LDC  1, 7, 0     IntExp constant val
* Assignment Expression
52: LDA 6,  -1(6)    Stack dealloc
53: LD  2, 0(6)   Get value into operand
54: ST 1, 0(2)  var equals expression result
  55:   LDC  1, 2, 0     IntExp constant val
* Array Access: x
56: LDA 2, 0(1)
57: LDA 1, 0(5)
58: LD 1, 0(1)
59: ADD 1, 1,2
* Assignment save result (Variable address):
60: ST  1, 0(6)   Store value as a temp value
61: LDA 6,  1(6)    Stack alloc
  62:   LDC  1, 11, 0     IntExp constant val
* Assignment Expression
63: LDA 6,  -1(6)    Stack dealloc
64: LD  2, 0(6)   Get value into operand
65: ST 1, 0(2)  var equals expression result
* Variable Access: y
66: LD 1, 1(5)
* Assignment save result (Variable address):
67: ST  1, 0(6)   Store value as a temp value
68: LDA 6,  1(6)    Stack alloc
  69:   LDC  1, 0, 0     IntExp constant val
* Assignment Expression
70: LDA 6,  -1(6)    Stack dealloc
71: LD  2, 0(6)   Get value into operand
72: ST 1, 0(2)  var equals expression result
* While loop:
* Variable Access: y
73: LD 1, 1(5)
* VarExp: Value load
74: LD 1, 0(1)   Variable get value
* Operation Expression:
75: ST  1, 0(6)   Store value as a temp value
76: LDA 6,  1(6)    Stack alloc
  77:   LDC  1, 3, 0     IntExp constant val
78: LDA 6,  -1(6)    Stack dealloc
79: LD  2, 0(6)   Get value into operand
80: SUB 1, 2, 1    Less than
81: JLT 1, 2(7)    Branch on true
82: LDC 1, 0, 0    Put 0 (false) in
83: LDA 7, 1(7)    Go to next code segment
84: LDC 1, 1, 0    Put 1 (true) in
* Variable Access: z
86: LD 1, 0(5)
* Assignment save result (Variable address):
87: ST  1, 0(6)   Store value as a temp value
88: LDA 6,  1(6)    Stack alloc
* Variable Access: y
89: LD 1, 1(5)
* VarExp: Value load
90: LD 1, 0(1)   Variable get value
* Array Access: x
91: LDA 2, 0(1)
92: LDA 1, 0(5)
93: LD 1, 0(1)
94: ADD 1, 1,2
* VarExp: Value load
95: LD 1, 0(1)   Variable get value
* Assignment Expression
96: LDA 6,  -1(6)    Stack dealloc
97: LD  2, 0(6)   Get value into operand
98: ST 1, 0(2)  var equals expression result
* Function arguments
* Variable Access: z
99: LD 1, 0(5)
* VarExp: Value load
100: LD 1, 0(1)   Variable get value
101: ST 1, 0(6)    Store argument
* Call setup:
104: LDA 4, 1(4)   Increment stack 
105: ST 5, 0(4)   Store frame pointer 
106: LDA 4, 1(4)   Increment stack 
107: ST 6, 0(4)   Store stack pointer 
108: LDA 4, 1(4)   Increment stack 
109: LDA 5, 0(4)   Set new frame pointer 
102: LDA 3, 8(7)   Store return address
103: ST 3, 0(4)   Store return address
110: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Variable Access: y
111: LD 1, 1(5)
* Assignment save result (Variable address):
112: ST  1, 0(6)   Store value as a temp value
113: LDA 6,  1(6)    Stack alloc
* Variable Access: y
114: LD 1, 1(5)
* VarExp: Value load
115: LD 1, 0(1)   Variable get value
* Operation Expression:
116: ST  1, 0(6)   Store value as a temp value
117: LDA 6,  1(6)    Stack alloc
  118:   LDC  1, 1, 0     IntExp constant val
119: LDA 6,  -1(6)    Stack dealloc
120: LD  2, 0(6)   Get value into operand
121: ADD 1, 2, 1    Add operation
* Assignment Expression
122: LDA 6,  -1(6)    Stack dealloc
123: LD  2, 0(6)   Get value into operand
124: ST 1, 0(2)  var equals expression result
* Inner scope non-function deallocation
125: LDC 7, 73, 0    Go back to the while test
85: JEQ 1, 40(7)    While jump on false: exit loop
* Return statement:
126: LDA 4, 0(5)   Table ptr = frame ptr 
127: LD 6, -1(4)   Restore stack ptr 
128: LD 5, -2(4)   Restore frame ptr 
129: LDA 4, -3(4)   Move stack ptr down 
130: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
131: LDA 4, -2(4)  Deallocation: Variable table in scope
132: LD 6, 0(4)  Deallocation: Scope variables
25: LDC 7, 133, 0    Function Jump around
* Finale
133: LDA 3, 8(7)   Store return address
134: ST 3, 0(4)   Store return address
135: LDA 4, 1(4)   Increment stack 
136: ST 5, 0(4)   Store frame pointer 
137: LDA 4, 1(4)   Increment stack 
138: ST 6, 0(4)   Store stack pointer 
139: LDA 4, 1(4)   Increment stack 
140: LDA 5, 0(4)   Set new frame pointer 
141: LDC 7, 26, 0   Jump to main 
142: HALT 0, 0, 0
