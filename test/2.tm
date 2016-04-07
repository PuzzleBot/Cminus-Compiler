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
* Variable Access: y
33: LD 1, 1(5)
* VarExp: Value load
34: LD 1, 0(1)   Variable get value
35: LDA 6,  -1(6)    Stack dealloc
36: LD  2, 0(6)   Get value into operand
37: ADD 1, 2, 1    Add operation
* Operation Expression:
38: ST  1, 0(6)   Store value as a temp value
39: LDA 6,  1(6)    Stack alloc
  40:   LDC  1, 4, 0     IntExp constant val
41: LDA 6,  -1(6)    Stack dealloc
42: LD  2, 0(6)   Get value into operand
43: ADD 1, 2, 1    Add operation
* Return statement:
44: LDA 4, 0(5)   Table ptr = frame ptr 
45: LD 6, -1(4)   Restore stack ptr 
46: LD 5, -2(4)   Restore frame ptr 
47: LDA 4, -3(4)   Move stack ptr down 
48: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
22: LDC 7, 49, 0    Function Jump around
* Variable declaration: t
50: ST 6, 0(4)   Pointer-> Var Table 
51: LDA 6, 1(6)   Variable 
52: LDA 4, 1(4)   Var Table 
* Variable Access: t
53: LD 1, 0(5)
* VarExp: Value load
54: LD 1, 0(1)   Variable get value
* Operation Expression:
55: ST  1, 0(6)   Store value as a temp value
56: LDA 6,  1(6)    Stack alloc
  57:   LDC  1, 2, 0     IntExp constant val
58: LDA 6,  -1(6)    Stack dealloc
59: LD  2, 0(6)   Get value into operand
60: ADD 1, 2, 1    Add operation
* Return statement:
61: LDA 4, 0(5)   Table ptr = frame ptr 
62: LD 6, -1(4)   Restore stack ptr 
63: LD 5, -2(4)   Restore frame ptr 
64: LDA 4, -3(4)   Move stack ptr down 
65: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
49: LDC 7, 66, 0    Function Jump around
* Variable declaration: x
67: ST 6, 0(4)   Pointer-> Var Table 
68: LDA 6, 1(6)   Variable 
69: LDA 4, 1(4)   Var Table 
* Variable declaration: y
70: ST 6, 0(4)   Pointer-> Var Table 
71: LDA 6, 1(6)   Variable 
72: LDA 4, 1(4)   Var Table 
* Function arguments
* Variable Access: x
73: LD 1, 0(5)
* VarExp: Value load
74: LD 1, 0(1)   Variable get value
* Operation Expression:
75: ST  1, 0(6)   Store value as a temp value
76: LDA 6,  1(6)    Stack alloc
* Variable Access: x
77: LD 1, 0(5)
* VarExp: Value load
78: LD 1, 0(1)   Variable get value
* Operation Expression:
79: ST  1, 0(6)   Store value as a temp value
80: LDA 6,  1(6)    Stack alloc
* Variable Access: y
81: LD 1, 1(5)
* VarExp: Value load
82: LD 1, 0(1)   Variable get value
83: LDA 6,  -1(6)    Stack dealloc
84: LD  2, 0(6)   Get value into operand
85: DIV 1, 2, 1    Div operation
* Operation Expression:
86: ST  1, 0(6)   Store value as a temp value
87: LDA 6,  1(6)    Stack alloc
* Variable Access: y
88: LD 1, 1(5)
* VarExp: Value load
89: LD 1, 0(1)   Variable get value
90: LDA 6,  -1(6)    Stack dealloc
91: LD  2, 0(6)   Get value into operand
92: MUL 1, 2, 1    Mul operation
93: LDA 6,  -1(6)    Stack dealloc
94: LD  2, 0(6)   Get value into operand
95: SUB 1, 2, 1    Sub operation
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
105: LDC 7, 50, 0   Jump to function 
* Continue after finishing function "add2"
* Return statement:
106: LDA 4, 0(5)   Table ptr = frame ptr 
107: LD 6, -1(4)   Restore stack ptr 
108: LD 5, -2(4)   Restore frame ptr 
109: LDA 4, -3(4)   Move stack ptr down 
110: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
66: LDC 7, 111, 0    Function Jump around
* Variable declaration: x
112: ST 6, 0(4)   Pointer-> Var Table 
113: LDA 6, 1(6)   Variable 
114: LDA 4, 1(4)   Var Table 
* Variable declaration: y
115: ST 6, 0(4)   Pointer-> Var Table 
116: LDA 6, 1(6)   Variable 
117: LDA 4, 1(4)   Var Table 
* Variable Access: x
118: LD 1, 0(5)
* Assignment save result (Variable address):
119: ST  1, 0(6)   Store value as a temp value
120: LDA 6,  1(6)    Stack alloc
  121:   LDC  1, 6, 0     IntExp constant val
* Assignment Expression
122: LDA 6,  -1(6)    Stack dealloc
123: LD  2, 0(6)   Get value into operand
124: ST 1, 0(2)  var equals expression result
* Variable Access: y
125: LD 1, 1(5)
* Assignment save result (Variable address):
126: ST  1, 0(6)   Store value as a temp value
127: LDA 6,  1(6)    Stack alloc
  128:   LDC  1, 7, 0     IntExp constant val
* Assignment Expression
129: LDA 6,  -1(6)    Stack dealloc
130: LD  2, 0(6)   Get value into operand
131: ST 1, 0(2)  var equals expression result
* Variable Access: x
132: LD 1, 0(5)
* Assignment save result (Variable address):
133: ST  1, 0(6)   Store value as a temp value
134: LDA 6,  1(6)    Stack alloc
* Function arguments
* Call setup:
137: LDA 4, 1(4)   Increment stack 
138: ST 5, 0(4)   Store frame pointer 
139: LDA 4, 1(4)   Increment stack 
140: ST 6, 0(4)   Store stack pointer 
141: LDA 4, 1(4)   Increment stack 
142: LDA 5, 0(4)   Set new frame pointer 
135: LDA 3, 8(7)   Store return address
136: ST 3, 0(4)   Store return address
143: LDC 7, 5, 0   Jump to function 
* Continue after finishing function "input"
* Assignment Expression
144: LDA 6,  -1(6)    Stack dealloc
145: LD  2, 0(6)   Get value into operand
146: ST 1, 0(2)  var equals expression result
* Variable Access: y
147: LD 1, 1(5)
* Assignment save result (Variable address):
148: ST  1, 0(6)   Store value as a temp value
149: LDA 6,  1(6)    Stack alloc
* Function arguments
  150:   LDC  1, 10, 0     IntExp constant val
151: ST 1, 0(6)    Store argument
  152:   LDC  1, 5, 0     IntExp constant val
153: ST 1, 1(6)    Store argument
* Call setup:
156: LDA 4, 1(4)   Increment stack 
157: ST 5, 0(4)   Store frame pointer 
158: LDA 4, 1(4)   Increment stack 
159: ST 6, 0(4)   Store stack pointer 
160: LDA 4, 1(4)   Increment stack 
161: LDA 5, 0(4)   Set new frame pointer 
154: LDA 3, 8(7)   Store return address
155: ST 3, 0(4)   Store return address
162: LDC 7, 23, 0   Jump to function 
* Continue after finishing function "addxy4"
* Assignment Expression
163: LDA 6,  -1(6)    Stack dealloc
164: LD  2, 0(6)   Get value into operand
165: ST 1, 0(2)  var equals expression result
* Variable Access: x
166: LD 1, 0(5)
* VarExp: Value load
167: LD 1, 0(1)   Variable get value
* Operation Expression:
168: ST  1, 0(6)   Store value as a temp value
169: LDA 6,  1(6)    Stack alloc
* Variable Access: y
170: LD 1, 1(5)
* VarExp: Value load
171: LD 1, 0(1)   Variable get value
172: LDA 6,  -1(6)    Stack dealloc
173: LD  2, 0(6)   Get value into operand
174: SUB 1, 2, 1    Less than
175: JGT 1, 2(7)    Branch on true
176: LDC 1, 0, 0    Put 0 (false) in
177: LDA 7, 1(7)    Go to next code segment
178: LDC 1, 1, 0    Put 1 (true) in
* Function arguments
* Variable Access: x
180: LD 1, 0(5)
* VarExp: Value load
181: LD 1, 0(1)   Variable get value
182: ST 1, 0(6)    Store argument
* Call setup:
185: LDA 4, 1(4)   Increment stack 
186: ST 5, 0(4)   Store frame pointer 
187: LDA 4, 1(4)   Increment stack 
188: ST 6, 0(4)   Store stack pointer 
189: LDA 4, 1(4)   Increment stack 
190: LDA 5, 0(4)   Set new frame pointer 
183: LDA 3, 8(7)   Store return address
184: ST 3, 0(4)   Store return address
191: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Inner scope non-function deallocation
* If-else statement: 
179: JEQ 1, 14(7)    If jump to else
* Inner scope non-function deallocation
* Else statement: 
192: LDC 7, 194, 0     Jump past else if the if part is true
* Function arguments
* Variable Access: y
194: LD 1, 1(5)
* VarExp: Value load
195: LD 1, 0(1)   Variable get value
196: ST 1, 0(6)    Store argument
* Call setup:
199: LDA 4, 1(4)   Increment stack 
200: ST 5, 0(4)   Store frame pointer 
201: LDA 4, 1(4)   Increment stack 
202: ST 6, 0(4)   Store stack pointer 
203: LDA 4, 1(4)   Increment stack 
204: LDA 5, 0(4)   Set new frame pointer 
197: LDA 3, 8(7)   Store return address
198: ST 3, 0(4)   Store return address
205: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Variable Access: x
206: LD 1, 0(5)
* Assignment save result (Variable address):
207: ST  1, 0(6)   Store value as a temp value
208: LDA 6,  1(6)    Stack alloc
* Function arguments
* Variable Access: x
209: LD 1, 0(5)
* VarExp: Value load
210: LD 1, 0(1)   Variable get value
211: ST 1, 0(6)    Store argument
  212:   LDC  1, 2, 0     IntExp constant val
213: ST 1, 1(6)    Store argument
* Call setup:
216: LDA 4, 1(4)   Increment stack 
217: ST 5, 0(4)   Store frame pointer 
218: LDA 4, 1(4)   Increment stack 
219: ST 6, 0(4)   Store stack pointer 
220: LDA 4, 1(4)   Increment stack 
221: LDA 5, 0(4)   Set new frame pointer 
214: LDA 3, 8(7)   Store return address
215: ST 3, 0(4)   Store return address
222: LDC 7, 67, 0   Jump to function 
* Continue after finishing function "complexOp"
* Assignment Expression
223: LDA 6,  -1(6)    Stack dealloc
224: LD  2, 0(6)   Get value into operand
225: ST 1, 0(2)  var equals expression result
* Function arguments
* Variable Access: x
226: LD 1, 0(5)
* VarExp: Value load
227: LD 1, 0(1)   Variable get value
228: ST 1, 0(6)    Store argument
* Call setup:
231: LDA 4, 1(4)   Increment stack 
232: ST 5, 0(4)   Store frame pointer 
233: LDA 4, 1(4)   Increment stack 
234: ST 6, 0(4)   Store stack pointer 
235: LDA 4, 1(4)   Increment stack 
236: LDA 5, 0(4)   Set new frame pointer 
229: LDA 3, 8(7)   Store return address
230: ST 3, 0(4)   Store return address
237: LDC 7, 11, 0   Jump to function 
* Continue after finishing function "output"
* Return statement:
238: LDA 4, 0(5)   Table ptr = frame ptr 
239: LD 6, -1(4)   Restore stack ptr 
240: LD 5, -2(4)   Restore frame ptr 
241: LDA 4, -3(4)   Move stack ptr down 
242: LD 7, 0(4)   Use return address to return 
* Inner scope non-function deallocation
243: LDA 4, -2(4)  Deallocation: Variable table in scope
244: LD 6, 0(4)  Deallocation: Scope variables
111: LDC 7, 245, 0    Function Jump around
* Finale
245: LDA 3, 8(7)   Store return address
246: ST 3, 0(4)   Store return address
247: LDA 4, 1(4)   Increment stack 
248: ST 5, 0(4)   Store frame pointer 
249: LDA 4, 1(4)   Increment stack 
250: ST 6, 0(4)   Store stack pointer 
251: LDA 4, 1(4)   Increment stack 
252: LDA 5, 0(4)   Set new frame pointer 
253: LDC 7, 112, 0   Jump to main 
254: HALT 0, 0, 0
