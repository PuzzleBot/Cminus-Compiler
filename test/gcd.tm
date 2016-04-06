* Standard prelude
  0:     LD  6, 0(0)     load gp with maxaddress
  1:    LDA  5, 0(6)     copy to gp to fp
  2:     ST  0, 0(0)     clear location 0
  3:    LDC 4, 1024, 0     Set starting variable stack
* code for input routine
  5:     IN  1, 0, 0  input
  6:    LDA  6, 0(5)    return sequence
  7:     LD  4, -1(6)   Restore frame ptr 
  8:     LD  5, -2(6)   Restore frame ptr 
  9:    LDA  6, -3(6)   Move stack ptr down 
 10:     LD  7, 0(6)   Use return address to return 
* code for output routine
 11:     LD  1, 0(5)    load output value
 12:    OUT  1, 0, 0  output
 13:    LDA  6, 0(5)    return sequence
 14:     LD  4, -1(6)   Restore frame ptr 
 15:     LD  5, -2(6)   Restore frame ptr 
 16:    LDA  6, -3(6)   Move stack ptr down 
 17:     LD  7, 0(6)   Use return address to return 
  4:    LDC  7, 18, 0     jump around i/o code
* End of prelude
18: ST 6, 0(4)   Var Table 
19: LDA 6, 1(6)   Variable 
20: LDA 4, 1(4)   Var Table 
22: ST 6, 0(4)   Var Table 
23: LDA 6, 1(6)   Variable 
24: LDA 4, 1(4)   Var Table 
25: ST 6, 0(4)   Var Table 
26: LDA 6, 1(6)   Variable 
27: LDA 4, 1(4)   Var Table 
* Function arguments
28: LD 1, 0(1)
* Variable Access
29: LDA 1, -1(4)
30: LD 1, 0(1)
31: ST  1, 0(6)
32: LDA 6,  1(6)
  33:   LDC  1, 0, 0     IntExp constant val
34: LD  2, 0(6)
35: LDA 6,  -1(6)
36: SUB 1, 2, 1    Less than
37: JEQ 1, 2(7)    Branch on true
38: LDC 1, 0, 0    Put 0 (false) in
39: LDA 7, 1(7)    Go to next code segment
40: LDC 1, 1, 0    Put 1 (true) in
41: ST  1, 0(6)
42: LDA 6,  1(6)
44: LD 1, 0(1)
* Variable Access
45: LDA 1, -0(4)
46: LD 1, 0(1)
* Return statement
47: LDA 6, 0(5)   Stack ptr = frame ptr 
48: LD 4, -1(6)   Restore table ptr 
49: LD 5, -2(6)   Restore frame ptr 
50: LDA 6, -3(6)   Move stack ptr down 
51: LD 7, 0(6)   Use return address to return 
43: JEQ 1, 9(7)    If jump to else
* Call setup
54: ST 7, 0(6)   Store return address
55: LDA 6, 1(6)   Increment stack 
56: ST 5, 0(6)   Store frame pointer 
57: LDA 6, 1(6)   Increment stack 
58: ST 4, 0(6)   Store table pointer 
59: LDA 6, 1(6)   Increment stack 
60: LDA 5, 0(6)   Set new frame pointer 
61: LDC 7, 28, 0   Jump to function 
* Function arguments
62: LD 1, 0(1)
* Variable Access
63: LDA 1, -1(4)
64: LD 1, 0(1)
65: ST 1, 0(5)
66: LD 1, 0(1)
* Variable Access
67: LDA 1, -0(4)
68: LD 1, 0(1)
69: ST  1, 0(6)
70: LDA 6,  1(6)
71: LD 1, 0(1)
* Variable Access
72: LDA 1, -0(4)
73: LD 1, 0(1)
74: ST  1, 0(6)
75: LDA 6,  1(6)
76: LD 1, 0(1)
* Variable Access
77: LDA 1, -1(4)
78: LD 1, 0(1)
79: LD  2, 0(6)
80: LDA 6,  -1(6)
81: DIV 1, 2, 1    Div operation
82: ST  1, 0(6)
83: LDA 6,  1(6)
84: ST  1, 0(6)
85: LDA 6,  1(6)
86: LD 1, 0(1)
* Variable Access
87: LDA 1, -1(4)
88: LD 1, 0(1)
89: LD  2, 0(6)
90: LDA 6,  -1(6)
91: MUL 1, 2, 1    Mul operation
92: ST  1, 0(6)
93: LDA 6,  1(6)
94: LD  2, 0(6)
95: LDA 6,  -1(6)
96: SUB 1, 2, 1    Sub operation
97: ST  1, 0(6)
98: LDA 6,  1(6)
99: ST 1, 1(5)
* Return statement
100: LDA 6, 0(5)   Stack ptr = frame ptr 
101: LD 4, -1(6)   Restore table ptr 
102: LD 5, -2(6)   Restore frame ptr 
103: LDA 6, -3(6)   Move stack ptr down 
104: LD 7, 0(6)   Use return address to return 
52: LDC 7, 105, 0     Jump past else if the if part is true
105: ST 1, 0(5)
106: ST 1, 1(5)
21: LDC 7, 107, 0    Function Jump
108: ST 6, 0(4)   Var Table 
109: LDA 6, 1(6)   Variable 
110: LDA 4, 1(4)   Var Table 
* Function arguments
* Variable Access
111: LDA 1, -0(4)
112: LD 1, 0(1)
113: ST  1, 0(6)
114: LDA 6,  1(6)
* Call setup
115: ST 7, 0(6)   Store return address
116: LDA 6, 1(6)   Increment stack 
117: ST 5, 0(6)   Store frame pointer 
118: LDA 6, 1(6)   Increment stack 
119: ST 4, 0(6)   Store table pointer 
120: LDA 6, 1(6)   Increment stack 
121: LDA 5, 0(6)   Set new frame pointer 
122: LDC 7, 4, 0   Jump to function 
* Function arguments
123: LD  2, 0(6)
124: LDA 6,  -1(6)
125: ST 1, 0(2)  var equals expression result
126: ST 1, 0(5)
* Variable Access
127: LDA 1, -0(4)
128: LD 1, 0(1)
129: ST  1, 0(6)
130: LDA 6,  1(6)
  131:   LDC  1, 10, 0     IntExp constant val
132: LD  2, 0(6)
133: LDA 6,  -1(6)
134: ST 1, 0(2)  var equals expression result
135: ST 1, 1(5)
* Call setup
136: ST 7, 0(6)   Store return address
137: LDA 6, 1(6)   Increment stack 
138: ST 5, 0(6)   Store frame pointer 
139: LDA 6, 1(6)   Increment stack 
140: ST 4, 0(6)   Store table pointer 
141: LDA 6, 1(6)   Increment stack 
142: LDA 5, 0(6)   Set new frame pointer 
143: LDC 7, 7, 0   Jump to function 
* Function arguments
* Call setup
144: ST 7, 0(6)   Store return address
145: LDA 6, 1(6)   Increment stack 
146: ST 5, 0(6)   Store frame pointer 
147: LDA 6, 1(6)   Increment stack 
148: ST 4, 0(6)   Store table pointer 
149: LDA 6, 1(6)   Increment stack 
150: LDA 5, 0(6)   Set new frame pointer 
151: LDC 7, 28, 0   Jump to function 
* Function arguments
152: LD 1, 0(1)
* Variable Access
153: LDA 1, -0(4)
154: LD 1, 0(1)
155: ST 1, 0(5)
156: LD 1, 0(1)
* Variable Access
157: LDA 1, -0(4)
158: LD 1, 0(1)
159: ST 1, 1(5)
160: ST 1, 0(5)
161: ST 1, 2(5)
162: ST 1, 3(5)
163: LDA 4, -1(4)  Deallocation: Variable table in scope
164: LD 6, 0(4)  Deallocation: Scope variables
107: LDC 7, 165, 0    Function Jump
* Finale
165: ST 7, 0(6)   Store return address
166: LDA 6, 1(6)   Increment stack 
167: ST 5, 0(6)   Store frame pointer 
168: LDA 6, 1(6)   Increment stack 
169: ST 4, 0(6)   Store frame pointer 
170: LDA 6, 1(6)   Increment stack 
171: LDA 5, 0(6)   Set new frame pointer 
172: LDC 7, 108, 0   Jump to main 
173: HALT 0, 0, 0
