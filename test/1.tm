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
* Variable declaration: y
22: ST 6, 0(4)   Pointer-> Var Table 
23: LDA 6, 1(6)   Variable 
24: LDA 4, 1(4)   Var Table 
* Variable declaration: u
26: ST 6, 0(4)   Pointer-> Var Table 
27: LDA 6, 1(6)   Variable 
28: LDA 4, 1(4)   Var Table 
* Variable declaration: v
29: ST 6, 0(4)   Pointer-> Var Table 
30: LDA 6, 1(6)   Variable 
31: LDA 4, 1(4)   Var Table 
* Variable Access: v
32: LD 1, 1(5)
* VarExp: Value load
33: LD 1, 0(1)   Variable get value
* Operation Expression:
34: ST  1, 0(6)   Store value as a temp value
35: LDA 6,  1(6)    Stack alloc
  36:   LDC  1, 0, 0     IntExp constant val
37: LDA 6,  -1(6)    Stack dealloc
38: LD  2, 0(6)   Get value into operand
39: SUB 1, 2, 1    Less than
40: JEQ 1, 2(7)    Branch on true
41: LDC 1, 0, 0    Put 0 (false) in
42: LDA 7, 1(7)    Go to next code segment
43: LDC 1, 1, 0    Put 1 (true) in
* Variable Access: u
45: LD 1, 0(5)
* VarExp: Value load
46: LD 1, 0(1)   Variable get value
* Return statement:
47: LDA 4, 0(5)   Table ptr = frame ptr 
48: LD 6, -1(4)   Restore stack ptr 
49: LD 5, -2(4)   Restore frame ptr 
50: LDA 4, -3(4)   Move stack ptr down 
51: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
* If-else statement: 
44: JEQ 1, 9(7)    If jump to else
* Function arguments
* Variable Access: v
54: LD 1, 1(5)
* VarExp: Value load
55: LD 1, 0(1)   Variable get value
56: ST 1, 0(6)    Store argument
* Variable Access: u
57: LD 1, 0(5)
* VarExp: Value load
58: LD 1, 0(1)   Variable get value
* Operation Expression:
59: ST  1, 0(6)   Store value as a temp value
60: LDA 6,  1(6)    Stack alloc
* Variable Access: u
61: LD 1, 0(5)
* VarExp: Value load
62: LD 1, 0(1)   Variable get value
* Operation Expression:
63: ST  1, 0(6)   Store value as a temp value
64: LDA 6,  1(6)    Stack alloc
* Variable Access: v
65: LD 1, 1(5)
* VarExp: Value load
66: LD 1, 0(1)   Variable get value
67: LDA 6,  -1(6)    Stack dealloc
68: LD  2, 0(6)   Get value into operand
69: DIV 1, 2, 1    Div operation
* Operation Expression:
70: ST  1, 0(6)   Store value as a temp value
71: LDA 6,  1(6)    Stack alloc
* Variable Access: v
72: LD 1, 1(5)
* VarExp: Value load
73: LD 1, 0(1)   Variable get value
74: LDA 6,  -1(6)    Stack dealloc
75: LD  2, 0(6)   Get value into operand
76: MUL 1, 2, 1    Mul operation
77: LDA 6,  -1(6)    Stack dealloc
78: LD  2, 0(6)   Get value into operand
79: SUB 1, 2, 1    Sub operation
80: ST 1, 1(6)    Store argument
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
* Continue after finishing function "gcd"
* Return statement:
90: LDA 4, 0(5)   Table ptr = frame ptr 
91: LD 6, -1(4)   Restore stack ptr 
92: LD 5, -2(4)   Restore frame ptr 
93: LDA 4, -3(4)   Move stack ptr down 
94: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
* Else statement: 
52: LDC 7, 95, 0     Jump past else if the if part is true
* Inner scope non-function deallocation
25: LDC 7, 95, 0    Function Jump around
* Variable declaration: x
96: ST 6, 0(4)   Pointer-> Var Table 
97: LDA 6, 1(6)   Variable 
98: LDA 4, 1(4)   Var Table 
* Variable Access: x
99: LD 1, 0(5)
* Assignment save result (Variable address):
100: ST  1, 0(6)   Store value as a temp value
101: LDA 6,  1(6)    Stack alloc
* Function arguments
* Call setup:
104: LDA 4, 1(4)   Increment stack 
105: ST 5, 0(4)   Store frame pointer 
106: LDA 4, 1(4)   Increment stack 
107: ST 6, 0(4)   Store stack pointer 
108: LDA 4, 1(4)   Increment stack 
109: LDA 5, 0(4)   Set new frame pointer 
102: LDA 3, 8(7)   Store return address
103: ST 3, 0(4)   Store return address
110: LDC 7, 5, 0   Jump to function 
* Continue after finishing function "input"
* Assignment Expression
111: LDA 6,  -1(6)    Stack dealloc
112: LD  2, 0(6)   Get value into operand
113: ST 1, 0(2)  var equals expression result
* Variable Access: y
114: LD 1, 0(5)
* Assignment save result (Variable address):
115: ST  1, 0(6)   Store value as a temp value
116: LDA 6,  1(6)    Stack alloc
* Function arguments
* Call setup:
119: LDA 4, 1(4)   Increment stack 
120: ST 5, 0(4)   Store frame pointer 
121: LDA 4, 1(4)   Increment stack 
122: ST 6, 0(4)   Store stack pointer 
123: LDA 4, 1(4)   Increment stack 
124: LDA 5, 0(4)   Set new frame pointer 
117: LDA 3, 8(7)   Store return address
118: ST 3, 0(4)   Store return address
125: LDC 7, 5, 0   Jump to function 
* Continue after finishing function "input"
* Assignment Expression
126: LDA 6,  -1(6)    Stack dealloc
127: LD  2, 0(6)   Get value into operand
128: ST 1, 0(2)  var equals expression result
* Function arguments
* Function arguments
* Variable Access: x
129: LD 1, 0(5)
* VarExp: Value load
130: LD 1, 0(1)   Variable get value
131: ST 1, 0(6)    Store argument
* Variable Access: y
132: LD 1, 0(5)
* VarExp: Value load
133: LD 1, 0(1)   Variable get value
134: ST 1, 1(6)    Store argument
* Call setup:
137: LDA 4, 1(4)   Increment stack 
138: ST 5, 0(4)   Store frame pointer 
139: LDA 4, 1(4)   Increment stack 
140: ST 6, 0(4)   Store stack pointer 
141: LDA 4, 1(4)   Increment stack 
142: LDA 5, 0(4)   Set new frame pointer 
135: LDA 3, 8(7)   Store return address
136: ST 3, 0(4)   Store return address
143: LDC 7, 26, 0   Jump to function 
* Continue after finishing function "gcd"
144: ST 1, 0(6)    Store argument
* Call setup:
147: LDA 4, 1(4)   Increment stack 
148: ST 5, 0(4)   Store frame pointer 
149: LDA 4, 1(4)   Increment stack 
150: ST 6, 0(4)   Store stack pointer 
151: LDA 4, 1(4)   Increment stack 
152: LDA 5, 0(4)   Set new frame pointer 
145: LDA 3, 8(7)   Store return address
146: ST 3, 0(4)   Store return address
153: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Return statement:
154: LDA 4, 0(5)   Table ptr = frame ptr 
155: LD 6, -1(4)   Restore stack ptr 
156: LD 5, -2(4)   Restore frame ptr 
157: LDA 4, -3(4)   Move stack ptr down 
158: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
159: LDA 4, -1(4)  Deallocation: Variable table in scope
160: LD 6, 0(4)  Deallocation: Scope variables
95: LDC 7, 161, 0    Function Jump around
* Finale
161: LDA 3, 8(7)   Store return address
162: ST 3, 0(4)   Store return address
163: LDA 4, 1(4)   Increment stack 
164: ST 5, 0(4)   Store frame pointer 
165: LDA 4, 1(4)   Increment stack 
166: ST 6, 0(4)   Store stack pointer 
167: LDA 4, 1(4)   Increment stack 
168: LDA 5, 0(4)   Set new frame pointer 
169: LDC 7, 96, 0   Jump to main 
170: HALT 0, 0, 0
