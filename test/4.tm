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
* Variable Access: x
29: LD 1, 0(5)
* VarExp: Value load
30: LD 1, 0(1)   Variable get value
* Operation Expression:
31: ST  1, 0(6)   Store value as a temp value
32: LDA 6,  1(6)    Stack alloc
  33:   LDC  1, 4, 0     IntExp constant val
34: LDA 6,  -1(6)    Stack dealloc
35: LD  2, 0(6)   Get value into operand
36: SUB 1, 2, 1    Less than
37: JLT 1, 2(7)    Branch on true
38: LDC 1, 0, 0    Put 0 (false) in
39: LDA 7, 1(7)    Go to next code segment
40: LDC 1, 1, 0    Put 1 (true) in
* Function arguments
* Variable Access: x
42: LD 1, 0(5)
* VarExp: Value load
43: LD 1, 0(1)   Variable get value
* Operation Expression:
44: ST  1, 0(6)   Store value as a temp value
45: LDA 6,  1(6)    Stack alloc
  46:   LDC  1, 1, 0     IntExp constant val
47: LDA 6,  -1(6)    Stack dealloc
48: LD  2, 0(6)   Get value into operand
49: ADD 1, 2, 1    Add operation
50: ST 1, 0(6)    Store argument
* Call setup:
53: LDA 4, 1(4)   Increment stack 
54: ST 5, 0(4)   Store frame pointer 
55: LDA 4, 1(4)   Increment stack 
56: ST 6, 0(4)   Store stack pointer 
57: LDA 4, 1(4)   Increment stack 
58: LDA 5, 0(4)   Set new frame pointer 
51: LDA 3, 8(7)   Store return address
52: ST 3, 0(4)   Store return address
59: LDC 7, 23, 0   Jump to function 
* Continue after finishing function "recurse"
* Inner scope non-function deallocation
* If statement: 
41: JEQ 1, 18(7)    If jump
* Function arguments
* Variable Access: x
60: LD 1, 0(5)
* VarExp: Value load
61: LD 1, 0(1)   Variable get value
62: ST 1, 0(6)    Store argument
* Call setup:
65: LDA 4, 1(4)   Increment stack 
66: ST 5, 0(4)   Store frame pointer 
67: LDA 4, 1(4)   Increment stack 
68: ST 6, 0(4)   Store stack pointer 
69: LDA 4, 1(4)   Increment stack 
70: LDA 5, 0(4)   Set new frame pointer 
63: LDA 3, 8(7)   Store return address
64: ST 3, 0(4)   Store return address
71: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Variable Access: y
72: LD 1, 1(5)
* VarExp: Value load
73: LD 1, 0(1)   Variable get value
* Return statement:
74: LDA 4, 0(5)   Table ptr = frame ptr 
75: LD 6, -1(4)   Restore stack ptr 
76: LD 5, -2(4)   Restore frame ptr 
77: LDA 4, -3(4)   Move stack ptr down 
78: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
79: LDA 4, -1(4)  Deallocation: Variable table in scope
80: LD 6, 0(4)  Deallocation: Scope variables
22: LDC 7, 81, 0    Function Jump around
* Variable declaration: number
82: ST 6, 0(4)   Pointer-> Var Table 
83: LDA 6, 1(6)   Variable 
84: LDA 4, 1(4)   Var Table 
* Variable Access: number
85: LD 1, 0(5)
* Assignment save result (Variable address):
86: ST  1, 0(6)   Store value as a temp value
87: LDA 6,  1(6)    Stack alloc
  88:   LDC  1, 500, 0     IntExp constant val
* Assignment Expression
89: LDA 6,  -1(6)    Stack dealloc
90: LD  2, 0(6)   Get value into operand
91: ST 1, 0(2)  var equals expression result
* Variable Access: number
92: LD 1, 0(5)
* Assignment save result (Variable address):
93: ST  1, 0(6)   Store value as a temp value
94: LDA 6,  1(6)    Stack alloc
* Function arguments
  95:   LDC  1, 0, 0     IntExp constant val
96: ST 1, 0(6)    Store argument
* Call setup:
99: LDA 4, 1(4)   Increment stack 
100: ST 5, 0(4)   Store frame pointer 
101: LDA 4, 1(4)   Increment stack 
102: ST 6, 0(4)   Store stack pointer 
103: LDA 4, 1(4)   Increment stack 
104: LDA 5, 0(4)   Set new frame pointer 
97: LDA 3, 8(7)   Store return address
98: ST 3, 0(4)   Store return address
105: LDC 7, 23, 0   Jump to function 
* Continue after finishing function "recurse"
* Assignment Expression
106: LDA 6,  -1(6)    Stack dealloc
107: LD  2, 0(6)   Get value into operand
108: ST 1, 0(2)  var equals expression result
* Function arguments
* Variable Access: number
109: LD 1, 0(5)
* VarExp: Value load
110: LD 1, 0(1)   Variable get value
111: ST 1, 0(6)    Store argument
* Call setup:
114: LDA 4, 1(4)   Increment stack 
115: ST 5, 0(4)   Store frame pointer 
116: LDA 4, 1(4)   Increment stack 
117: ST 6, 0(4)   Store stack pointer 
118: LDA 4, 1(4)   Increment stack 
119: LDA 5, 0(4)   Set new frame pointer 
112: LDA 3, 8(7)   Store return address
113: ST 3, 0(4)   Store return address
120: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Return statement:
121: LDA 4, 0(5)   Table ptr = frame ptr 
122: LD 6, -1(4)   Restore stack ptr 
123: LD 5, -2(4)   Restore frame ptr 
124: LDA 4, -3(4)   Move stack ptr down 
125: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
126: LDA 4, -1(4)  Deallocation: Variable table in scope
127: LD 6, 0(4)  Deallocation: Scope variables
81: LDC 7, 128, 0    Function Jump around
* Finale
128: LDA 3, 8(7)   Store return address
129: ST 3, 0(4)   Store return address
130: LDA 4, 1(4)   Increment stack 
131: ST 5, 0(4)   Store frame pointer 
132: LDA 4, 1(4)   Increment stack 
133: ST 6, 0(4)   Store stack pointer 
134: LDA 4, 1(4)   Increment stack 
135: LDA 5, 0(4)   Set new frame pointer 
136: LDC 7, 82, 0   Jump to main 
137: HALT 0, 0, 0
