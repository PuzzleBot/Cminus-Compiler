* Standard prelude
  0:     LD  6,0(0)     load gp with maxaddress
  1:    LDA  5,0(6)     copy to gp to fp
  2:     ST  0,0(0)     clear location 0
* code for input routine
  4:     ST  0,-1(5)    store return
  5:     IN  0,0,0  input
  6:     LD  7,-1(5)    return to caller
* code for output routine
  7:     ST  0,-1(5)    store return
  8:     LD  0,-2(5)    load output value
  9:    OUT  0,0,0  output
 10:     LD  7,-1(5)    return to caller
 11:    LDC 4, 1024, 0     Set starting variable stack
  3:    LDA  7,7(7)     jump around i/o code
* End of prelude
12: ST 6, 0(4)   Var Table 
13: LDA 6, 1(6)   Variable 
14: LDA 4, 1(4)   Var Table 
16: ST 6, 0(4)   Var Table 
17: LDA 6, 1(6)   Variable 
18: LDA 4, 1(4)   Var Table 
19: ST 6, 0(4)   Var Table 
20: LDA 6, 1(6)   Variable 
21: LDA 4, 1(4)   Var Table 
* Function arguments
22: LD 1, 0(1)
* Variable Access
23: LDA 1, -1(4)
24: LD 1, 0(1)
25: ST  1, 0(6)
26: LDA 6,  1(6)
  27:   LDC  1, 0, 0     IntExp constant val
28: LD  2, 0(6)
29: LDA 6,  -1(6)
30: SUB 1, 2, 1    Less than
31: JEQ 1, 2(7)    Branch on true
32: LDC 1, 0, 0    Put 0 (false) in
33: LDA 7, 1(7)    Go to next code segment
34: LDC 1, 1, 0    Put 1 (true) in
35: ST  1, 0(6)
36: LDA 6,  1(6)
38: LD 1, 0(1)
* Variable Access
39: LDA 1, -0(4)
40: LD 1, 0(1)
* Return statement
41: LDA 6, 0(5)   Stack ptr = frame ptr 
42: LD 4, -1(6)   Restore frame ptr 
43: LD 5, -2(6)   Restore frame ptr 
44: LDA 6, -3(6)   Move stack ptr down 
45: LD 7, 0(6)   Use return address to return 
37: JEQ 1, 9(7)    If jump to else
* Call setup
48: ST 7, 0(6)   Store return address
49: LDA 6, 1(6)   Increment stack 
50: ST 5, 0(6)   Store frame pointer 
51: LDA 6, 1(6)   Increment stack 
52: ST 4, 0(6)   Store frame pointer 
53: LDA 6, 1(6)   Increment stack 
54: LDA 5, 0(6)   Set new frame pointer 
55: LDC 7, 22, 0   Jump to function 
* Function arguments
56: LD 1, 0(1)
* Variable Access
57: LDA 1, -1(4)
58: LD 1, 0(1)
59: ST 1, 0(5)
60: LD 1, 0(1)
* Variable Access
61: LDA 1, -0(4)
62: LD 1, 0(1)
63: ST  1, 0(6)
64: LDA 6,  1(6)
65: LD 1, 0(1)
* Variable Access
66: LDA 1, -0(4)
67: LD 1, 0(1)
68: ST  1, 0(6)
69: LDA 6,  1(6)
70: LD 1, 0(1)
* Variable Access
71: LDA 1, -1(4)
72: LD 1, 0(1)
73: LD  2, 0(6)
74: LDA 6,  -1(6)
75: DIV 1, 2, 1    Div operation
76: ST  1, 0(6)
77: LDA 6,  1(6)
78: ST  1, 0(6)
79: LDA 6,  1(6)
80: LD 1, 0(1)
* Variable Access
81: LDA 1, -1(4)
82: LD 1, 0(1)
83: LD  2, 0(6)
84: LDA 6,  -1(6)
85: MUL 1, 2, 1    Mul operation
86: ST  1, 0(6)
87: LDA 6,  1(6)
88: LD  2, 0(6)
89: LDA 6,  -1(6)
90: SUB 1, 2, 1    Sub operation
91: ST  1, 0(6)
92: LDA 6,  1(6)
93: ST 1, 1(5)
* Return statement
94: LDA 6, 0(5)   Stack ptr = frame ptr 
95: LD 4, -1(6)   Restore frame ptr 
96: LD 5, -2(6)   Restore frame ptr 
97: LDA 6, -3(6)   Move stack ptr down 
98: LD 7, 0(6)   Use return address to return 
46: LDC 7, 99, 0     Jump past else if the if part is true
99: ST 1, 0(5)
100: ST 1, 1(5)
15: LDC 7, 101, 0    Function Jump
102: ST 6, 0(4)   Var Table 
103: LDA 6, 1(6)   Variable 
104: LDA 4, 1(4)   Var Table 
* Function arguments
* Variable Access
105: LDA 1, -0(4)
106: LD 1, 0(1)
107: ST  1, 0(6)
108: LDA 6,  1(6)
* Call setup
109: ST 7, 0(6)   Store return address
110: LDA 6, 1(6)   Increment stack 
111: ST 5, 0(6)   Store frame pointer 
112: LDA 6, 1(6)   Increment stack 
113: ST 4, 0(6)   Store frame pointer 
114: LDA 6, 1(6)   Increment stack 
115: LDA 5, 0(6)   Set new frame pointer 
116: LDC 7, 4, 0   Jump to function 
* Function arguments
117: LD  2, 0(6)
118: LDA 6,  -1(6)
119: ST 1, 0(2)  var equals expression result
120: ST 1, 0(5)
* Variable Access
121: LDA 1, -0(4)
122: LD 1, 0(1)
123: ST  1, 0(6)
124: LDA 6,  1(6)
  125:   LDC  1, 10, 0     IntExp constant val
126: LD  2, 0(6)
127: LDA 6,  -1(6)
128: ST 1, 0(2)  var equals expression result
129: ST 1, 1(5)
* Call setup
130: ST 7, 0(6)   Store return address
131: LDA 6, 1(6)   Increment stack 
132: ST 5, 0(6)   Store frame pointer 
133: LDA 6, 1(6)   Increment stack 
134: ST 4, 0(6)   Store frame pointer 
135: LDA 6, 1(6)   Increment stack 
136: LDA 5, 0(6)   Set new frame pointer 
137: LDC 7, 7, 0   Jump to function 
* Function arguments
* Call setup
138: ST 7, 0(6)   Store return address
139: LDA 6, 1(6)   Increment stack 
140: ST 5, 0(6)   Store frame pointer 
141: LDA 6, 1(6)   Increment stack 
142: ST 4, 0(6)   Store frame pointer 
143: LDA 6, 1(6)   Increment stack 
144: LDA 5, 0(6)   Set new frame pointer 
145: LDC 7, 22, 0   Jump to function 
* Function arguments
146: LD 1, 0(1)
* Variable Access
147: LDA 1, -0(4)
148: LD 1, 0(1)
149: ST 1, 0(5)
150: LD 1, 0(1)
* Variable Access
151: LDA 1, -0(4)
152: LD 1, 0(1)
153: ST 1, 1(5)
154: ST 1, 0(5)
155: ST 1, 2(5)
156: ST 1, 3(5)
157: LDA 4, -1(4)  Deallocation: Variable table in scope
158: LD 6, 0(4)  Deallocation: Scope variables
101: LDC 7, 159, 0    Function Jump
