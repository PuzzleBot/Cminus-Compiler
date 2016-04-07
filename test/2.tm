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
* Variable declaration: y
26: ST 6, 0(4)   Pointer-> Var Table 
27: LDA 6, 1(6)   Variable 
28: LDA 4, 1(4)   Var Table 
* Function arguments
* Variable Access: x
29: LD 1, 0(5)
* Assignment save result (Variable address):
30: ST  1, 0(6)   Store value as a temp value
31: LDA 6,  1(6)    Stack alloc
  32:   LDC  1, 6, 0     IntExp constant val
* Assignment Expression
33: LDA 6,  -1(6)    Stack dealloc
34: LD  2, 0(6)   Get value into operand
35: ST 1, 0(2)  var equals expression result
* Variable Access: y
36: LD 1, 1(5)
* Assignment save result (Variable address):
37: ST  1, 0(6)   Store value as a temp value
38: LDA 6,  1(6)    Stack alloc
  39:   LDC  1, 7, 0     IntExp constant val
* Assignment Expression
40: LDA 6,  -1(6)    Stack dealloc
41: LD  2, 0(6)   Get value into operand
42: ST 1, 0(2)  var equals expression result
* Variable Access: x
43: LD 1, 0(5)
* Assignment save result (Variable address):
44: ST  1, 0(6)   Store value as a temp value
45: LDA 6,  1(6)    Stack alloc
  46:   LDC  1, 5, 0     IntExp constant val
* Operation Expression:
47: ST  1, 0(6)   Store value as a temp value
48: LDA 6,  1(6)    Stack alloc
  49:   LDC  1, 8, 0     IntExp constant val
* Operation Expression:
50: ST  1, 0(6)   Store value as a temp value
51: LDA 6,  1(6)    Stack alloc
  52:   LDC  1, 10, 0     IntExp constant val
53: LDA 6,  -1(6)    Stack dealloc
54: LD  2, 0(6)   Get value into operand
55: MUL 1, 2, 1    Mul operation
56: LDA 6,  -1(6)    Stack dealloc
57: LD  2, 0(6)   Get value into operand
58: ADD 1, 2, 1    Add operation
* Assignment Expression
59: LDA 6,  -1(6)    Stack dealloc
60: LD  2, 0(6)   Get value into operand
61: ST 1, 0(2)  var equals expression result
* Variable Access: y
62: LD 1, 1(5)
* Assignment save result (Variable address):
63: ST  1, 0(6)   Store value as a temp value
64: LDA 6,  1(6)    Stack alloc
* Variable Access: x
65: LD 1, 0(5)
* VarExp: Value load
66: LD 1, 0(1)   Variable get value
* Operation Expression:
67: ST  1, 0(6)   Store value as a temp value
68: LDA 6,  1(6)    Stack alloc
  69:   LDC  1, 4, 0     IntExp constant val
70: LDA 6,  -1(6)    Stack dealloc
71: LD  2, 0(6)   Get value into operand
72: ADD 1, 2, 1    Add operation
* Assignment Expression
73: LDA 6,  -1(6)    Stack dealloc
74: LD  2, 0(6)   Get value into operand
75: ST 1, 0(2)  var equals expression result
* Variable Access: x
76: LD 1, 0(5)
* VarExp: Value load
77: LD 1, 0(1)   Variable get value
* Operation Expression:
78: ST  1, 0(6)   Store value as a temp value
79: LDA 6,  1(6)    Stack alloc
* Variable Access: y
80: LD 1, 1(5)
* VarExp: Value load
81: LD 1, 0(1)   Variable get value
82: LDA 6,  -1(6)    Stack dealloc
83: LD  2, 0(6)   Get value into operand
84: SUB 1, 2, 1    Less than
85: JGT 1, 2(7)    Branch on true
86: LDC 1, 0, 0    Put 0 (false) in
87: LDA 7, 1(7)    Go to next code segment
88: LDC 1, 1, 0    Put 1 (true) in
* Function arguments
* Function arguments
* Variable Access: x
90: LD 1, 0(5)
* VarExp: Value load
91: LD 1, 0(1)   Variable get value
92: ST 1, 0(6)    Store argument
* Call setup:
95: LDA 4, 1(4)   Increment stack 
96: ST 5, 0(4)   Store frame pointer 
97: LDA 4, 1(4)   Increment stack 
98: ST 6, 0(4)   Store stack pointer 
99: LDA 4, 1(4)   Increment stack 
100: LDA 5, 0(4)   Set new frame pointer 
93: LDA 3, 8(7)   Store return address
94: ST 3, 0(4)   Store return address
101: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Inner scope non-function deallocation
* If-else statement: 
89: JEQ 1, 14(7)    If jump to else
* Function arguments
* Function arguments
* Variable Access: y
104: LD 1, 1(5)
* VarExp: Value load
105: LD 1, 0(1)   Variable get value
106: ST 1, 0(6)    Store argument
* Call setup:
109: LDA 4, 1(4)   Increment stack 
110: ST 5, 0(4)   Store frame pointer 
111: LDA 4, 1(4)   Increment stack 
112: ST 6, 0(4)   Store stack pointer 
113: LDA 4, 1(4)   Increment stack 
114: LDA 5, 0(4)   Set new frame pointer 
107: LDA 3, 8(7)   Store return address
108: ST 3, 0(4)   Store return address
115: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Inner scope non-function deallocation
* Else statement: 
102: LDC 7, 116, 0     Jump past else if the if part is true
* Function arguments
  116:   LDC  1, 5000, 0     IntExp constant val
117: ST 1, 0(6)    Store argument
* Call setup:
120: LDA 4, 1(4)   Increment stack 
121: ST 5, 0(4)   Store frame pointer 
122: LDA 4, 1(4)   Increment stack 
123: ST 6, 0(4)   Store stack pointer 
124: LDA 4, 1(4)   Increment stack 
125: LDA 5, 0(4)   Set new frame pointer 
118: LDA 3, 8(7)   Store return address
119: ST 3, 0(4)   Store return address
126: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Return statement:
127: LDA 4, 0(5)   Table ptr = frame ptr 
128: LD 6, -1(4)   Restore stack ptr 
129: LD 5, -2(4)   Restore frame ptr 
130: LDA 4, -3(4)   Move stack ptr down 
131: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
132: LDA 4, -2(4)  Deallocation: Variable table in scope
133: LD 6, 0(4)  Deallocation: Scope variables
22: LDC 7, 134, 0    Function Jump around
* Finale
134: LDA 3, 8(7)   Store return address
135: ST 3, 0(4)   Store return address
136: LDA 4, 1(4)   Increment stack 
137: ST 5, 0(4)   Store frame pointer 
138: LDA 4, 1(4)   Increment stack 
139: ST 6, 0(4)   Store stack pointer 
140: LDA 4, 1(4)   Increment stack 
141: LDA 5, 0(4)   Set new frame pointer 
142: LDC 7, 23, 0   Jump to main 
143: HALT 0, 0, 0
