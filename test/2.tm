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
  30:   LDC  1, 4, 0     IntExp constant val
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
* Variable declaration: y
43: ST 6, 0(4)   Pointer-> Var Table 
44: LDA 6, 1(6)   Variable 
45: LDA 4, 1(4)   Var Table 
* Function arguments
* Variable Access: x
46: LD 1, 0(5)
* Assignment save result (Variable address):
47: ST  1, 0(6)   Store value as a temp value
48: LDA 6,  1(6)    Stack alloc
  49:   LDC  1, 6, 0     IntExp constant val
* Assignment Expression
50: LDA 6,  -1(6)    Stack dealloc
51: LD  2, 0(6)   Get value into operand
52: ST 1, 0(2)  var equals expression result
* Variable Access: y
53: LD 1, 1(5)
* Assignment save result (Variable address):
54: ST  1, 0(6)   Store value as a temp value
55: LDA 6,  1(6)    Stack alloc
  56:   LDC  1, 7, 0     IntExp constant val
* Assignment Expression
57: LDA 6,  -1(6)    Stack dealloc
58: LD  2, 0(6)   Get value into operand
59: ST 1, 0(2)  var equals expression result
* Variable Access: x
60: LD 1, 0(5)
* Assignment save result (Variable address):
61: ST  1, 0(6)   Store value as a temp value
62: LDA 6,  1(6)    Stack alloc
* Function arguments
* Call setup:
65: LDA 4, 1(4)   Increment stack 
66: ST 5, 0(4)   Store frame pointer 
67: LDA 4, 1(4)   Increment stack 
68: ST 6, 0(4)   Store stack pointer 
69: LDA 4, 1(4)   Increment stack 
70: LDA 5, 0(4)   Set new frame pointer 
63: LDA 3, 8(7)   Store return address
64: ST 3, 0(4)   Store return address
71: LDC 7, 5, 0   Jump to function 
* Continue after finishing function "input"
* Assignment Expression
72: LDA 6,  -1(6)    Stack dealloc
73: LD  2, 0(6)   Get value into operand
74: ST 1, 0(2)  var equals expression result
* Variable Access: y
75: LD 1, 1(5)
* Assignment save result (Variable address):
76: ST  1, 0(6)   Store value as a temp value
77: LDA 6,  1(6)    Stack alloc
* Function arguments
* Variable Access: x
78: LD 1, 0(5)
* VarExp: Value load
79: LD 1, 0(1)   Variable get value
80: ST 1, 0(6)    Store argument
* Call setup:
83: LDA 4, 1(4)   Increment stack 
84: ST 5, 0(4)   Store frame pointer 
85: LDA 4, 1(4)   Increment stack 
86: ST 6, 0(4)   Store stack pointer 
87: LDA 4, 1(4)   Increment stack 
88: LDA 5, 0(4)   Set new frame pointer 
81: LDA 3, 8(7)   Store return address
82: ST 3, 0(4)   Store return address
89: LDC 7, 26, 0   Jump to function 
* Continue after finishing function "addFour"
* Assignment Expression
90: LDA 6,  -1(6)    Stack dealloc
91: LD  2, 0(6)   Get value into operand
92: ST 1, 0(2)  var equals expression result
* Variable Access: x
93: LD 1, 0(5)
* VarExp: Value load
94: LD 1, 0(1)   Variable get value
* Operation Expression:
95: ST  1, 0(6)   Store value as a temp value
96: LDA 6,  1(6)    Stack alloc
* Variable Access: y
97: LD 1, 1(5)
* VarExp: Value load
98: LD 1, 0(1)   Variable get value
99: LDA 6,  -1(6)    Stack dealloc
100: LD  2, 0(6)   Get value into operand
101: SUB 1, 2, 1    Less than
102: JGT 1, 2(7)    Branch on true
103: LDC 1, 0, 0    Put 0 (false) in
104: LDA 7, 1(7)    Go to next code segment
105: LDC 1, 1, 0    Put 1 (true) in
* Function arguments
* Function arguments
* Variable Access: x
107: LD 1, 0(5)
* VarExp: Value load
108: LD 1, 0(1)   Variable get value
109: ST 1, 0(6)    Store argument
* Call setup:
112: LDA 4, 1(4)   Increment stack 
113: ST 5, 0(4)   Store frame pointer 
114: LDA 4, 1(4)   Increment stack 
115: ST 6, 0(4)   Store stack pointer 
116: LDA 4, 1(4)   Increment stack 
117: LDA 5, 0(4)   Set new frame pointer 
110: LDA 3, 8(7)   Store return address
111: ST 3, 0(4)   Store return address
118: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Inner scope non-function deallocation
* If-else statement: 
106: JEQ 1, 14(7)    If jump to else
* Function arguments
* Function arguments
* Variable Access: y
121: LD 1, 1(5)
* VarExp: Value load
122: LD 1, 0(1)   Variable get value
123: ST 1, 0(6)    Store argument
* Call setup:
126: LDA 4, 1(4)   Increment stack 
127: ST 5, 0(4)   Store frame pointer 
128: LDA 4, 1(4)   Increment stack 
129: ST 6, 0(4)   Store stack pointer 
130: LDA 4, 1(4)   Increment stack 
131: LDA 5, 0(4)   Set new frame pointer 
124: LDA 3, 8(7)   Store return address
125: ST 3, 0(4)   Store return address
132: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Inner scope non-function deallocation
* Else statement: 
119: LDC 7, 133, 0     Jump past else if the if part is true
* Function arguments
  133:   LDC  1, 5000, 0     IntExp constant val
134: ST 1, 0(6)    Store argument
* Call setup:
137: LDA 4, 1(4)   Increment stack 
138: ST 5, 0(4)   Store frame pointer 
139: LDA 4, 1(4)   Increment stack 
140: ST 6, 0(4)   Store stack pointer 
141: LDA 4, 1(4)   Increment stack 
142: LDA 5, 0(4)   Set new frame pointer 
135: LDA 3, 8(7)   Store return address
136: ST 3, 0(4)   Store return address
143: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Return statement:
144: LDA 4, 0(5)   Table ptr = frame ptr 
145: LD 6, -1(4)   Restore stack ptr 
146: LD 5, -2(4)   Restore frame ptr 
147: LDA 4, -3(4)   Move stack ptr down 
148: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
149: LDA 4, -2(4)  Deallocation: Variable table in scope
150: LD 6, 0(4)  Deallocation: Scope variables
39: LDC 7, 151, 0    Function Jump around
* Finale
151: LDA 3, 8(7)   Store return address
152: ST 3, 0(4)   Store return address
153: LDA 4, 1(4)   Increment stack 
154: ST 5, 0(4)   Store frame pointer 
155: LDA 4, 1(4)   Increment stack 
156: ST 6, 0(4)   Store stack pointer 
157: LDA 4, 1(4)   Increment stack 
158: LDA 5, 0(4)   Set new frame pointer 
159: LDC 7, 40, 0   Jump to main 
160: HALT 0, 0, 0
