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
* Variable Access
22: LDA 1, -1(4)
23: LD 1, 0(1)
24: ST  1, 0(6)
25: LDA 6,  1(6)
  26:   LDC  1, 0, 0     IntExp constant val
27: LD  2, 0(6)
28: LDA 6,  -1(6)
29: SUB 1, 2, 1    Less than
30: JEQ 1, 2(7)    Branch on true
31: LDC 1, 0, 0    Put 0 (false) in
32: LDA 7, 1(7)    Go to next code segment
33: LDC 1, 1, 0    Put 1 (true) in
34: ST  1, 0(6)
35: LDA 6,  1(6)
* Variable Access
37: LDA 1, -0(4)
38: LD 1, 0(1)
* Return statement
39: LDA 6, 0(5)   Stack ptr = frame ptr 
40: LD 5, -1(6)   Restore frame ptr 
41: LDA 6, -2(6)   Move stack ptr down 
42: LD 7, 0(6)   Use return address to return 
36: JEQ 1, 7(7)    If jump to else
* Call setup
45: ST 7, 0(6)   Store return address
46: LDA 6, 1(6)   Increment stack 
47: ST 5, 0(6)   Store frame pointer 
48: LDA 6, 1(6)   Increment stack 
49: LDA 5, 0(6)   Set new frame pointer 
50: LDC 7, 22, 0   Jump to function 
* Variable Access
51: LDA 1, -1(4)
52: LD 1, 0(1)
53: ST 1, 0(5)
* Variable Access
54: LDA 1, -0(4)
55: LD 1, 0(1)
56: ST  1, 0(6)
57: LDA 6,  1(6)
* Variable Access
58: LDA 1, -0(4)
59: LD 1, 0(1)
60: ST  1, 0(6)
61: LDA 6,  1(6)
* Variable Access
62: LDA 1, -1(4)
63: LD 1, 0(1)
64: LD  2, 0(6)
65: LDA 6,  -1(6)
66: DIV 1, 2, 1    Div operation
67: ST  1, 0(6)
68: LDA 6,  1(6)
69: ST  1, 0(6)
70: LDA 6,  1(6)
* Variable Access
71: LDA 1, -1(4)
72: LD 1, 0(1)
73: LD  2, 0(6)
74: LDA 6,  -1(6)
75: MUL 1, 2, 1    Mul operation
76: ST  1, 0(6)
77: LDA 6,  1(6)
78: LD  2, 0(6)
79: LDA 6,  -1(6)
80: SUB 1, 2, 1    Sub operation
81: ST  1, 0(6)
82: LDA 6,  1(6)
83: ST 1, 1(5)
* Return statement
84: LDA 6, 0(5)   Stack ptr = frame ptr 
85: LD 5, -1(6)   Restore frame ptr 
86: LDA 6, -2(6)   Move stack ptr down 
87: LD 7, 0(6)   Use return address to return 
43: LDC 7, 88, 0     Jump past else if the if part is true
88: ST 1, 0(5)
89: ST 1, 1(5)
15: LDC 7, 90, 0    Function Jump
91: ST 6, 0(4)   Var Table 
92: LDA 6, 1(6)   Variable 
93: LDA 4, 1(4)   Var Table 
* Variable Access
94: LDA 1, -0(4)
95: LD 1, 0(1)
* Call setup
96: ST 7, 0(6)   Store return address
97: LDA 6, 1(6)   Increment stack 
98: ST 5, 0(6)   Store frame pointer 
99: LDA 6, 1(6)   Increment stack 
100: LDA 5, 0(6)   Set new frame pointer 
101: LDC 7, 4, 0   Jump to function 
102: ST 1, 0(5)
* Variable Access
103: LDA 1, -0(4)
104: LD 1, 0(1)
  105:   LDC  1, 10, 0     IntExp constant val
106: ST 1, 1(5)
* Call setup
107: ST 7, 0(6)   Store return address
108: LDA 6, 1(6)   Increment stack 
109: ST 5, 0(6)   Store frame pointer 
110: LDA 6, 1(6)   Increment stack 
111: LDA 5, 0(6)   Set new frame pointer 
112: LDC 7, 7, 0   Jump to function 
* Call setup
113: ST 7, 0(6)   Store return address
114: LDA 6, 1(6)   Increment stack 
115: ST 5, 0(6)   Store frame pointer 
116: LDA 6, 1(6)   Increment stack 
117: LDA 5, 0(6)   Set new frame pointer 
118: LDC 7, 22, 0   Jump to function 
* Variable Access
119: LDA 1, -0(4)
120: LD 1, 0(1)
121: ST 1, 0(5)
* Variable Access
122: LDA 1, -0(4)
123: LD 1, 0(1)
124: ST 1, 1(5)
125: ST 1, 0(5)
126: ST 1, 2(5)
127: ST 1, 3(5)
90: LDC 7, 128, 0    Function Jump
