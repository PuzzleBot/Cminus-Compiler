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
12: ST 6, 0(4)   Var Table globalVar
13: LDA 6, 1(6)   Variable globalVar
14: LDA 4, 1(4)   Var Table globalVar
15: ST 6, 0(4)   Var Table de
16: LDA 6, 1(6)   Variable de
17: LDA 4, 1(4)   Var Table de
  19:   LDC  1, 8, 0     IntExp constant val
20: LD  1, 0(6)
21: LDA 6,  -1(6)
22: ST 6, 0(4)   Var Table x
23: ADD 6, 6, 1   Array Variable x
24: LDA 4, 1(4)   Var Table x
  25:   LDC  1, 0, 0     IntExp constant val
* Array Access
26: LD  1, 0(6)
27: LDA 6,  -1(6)
28: LDA 0, -1(4)
29: SUB 1, 1,0
30: ADD 1, 1,5
31: LD 1, 0(1)
  32:   LDC  1, 8, 0     IntExp constant val
33: ST  1, 0(6)
34: LDA 6,  1(6)
  35:   LDC  1, 9, 0     IntExp constant val
36: LD  2, 0(6)
37: LDA 6,  -1(6)
38: ADD 1, 2, 1    Add operation
39: ST  1, 0(6)
40: LDA 6,  1(6)
* Variable Access
41: LDA 1, -0(4)
42: LD 1, 0(1)
  43:   LDC  1, 5, 0     IntExp constant val
44: ST  1, 0(6)
45: LDA 6,  1(6)
  46:   LDC  1, 6, 0     IntExp constant val
47: LD  2, 0(6)
48: LDA 6,  -1(6)
49: ADD 1, 2, 1    Add operation
50: ST  1, 0(6)
51: LDA 6,  1(6)
* Variable Access
52: LDA 1, -0(4)
53: LD 1, 0(1)
18: LDC 7, 54, 0    Function Jump
54: LDC 7, 55, 0    Function Jump
55: ST 6, 0(4)   Var Table u
56: LDA 6, 1(6)   Variable u
57: LDA 4, 1(4)   Var Table u
58: ST 6, 0(4)   Var Table v
59: LDA 6, 1(6)   Variable v
60: LDA 4, 1(4)   Var Table v
* Variable Access
62: LDA 1, -1(4)
63: LD 1, 0(1)
64: ST  1, 0(6)
65: LDA 6,  1(6)
  66:   LDC  1, 0, 0     IntExp constant val
67: LD  2, 0(6)
68: LDA 6,  -1(6)
69: ST  1, 0(6)
70: LDA 6,  1(6)
* Variable Access
71: LDA 1, -0(4)
72: LD 1, 0(1)
* Variable Access
73: LDA 1, -1(4)
74: LD 1, 0(1)
* Variable Access
75: LDA 1, -0(4)
76: LD 1, 0(1)
77: ST  1, 0(6)
78: LDA 6,  1(6)
* Variable Access
79: LDA 1, -0(4)
80: LD 1, 0(1)
81: ST  1, 0(6)
82: LDA 6,  1(6)
* Variable Access
83: LDA 1, -1(4)
84: LD 1, 0(1)
85: LD  2, 0(6)
86: LDA 6,  -1(6)
87: DIV 1, 2, 1    Div operation
88: ST  1, 0(6)
89: LDA 6,  1(6)
90: ST  1, 0(6)
91: LDA 6,  1(6)
* Variable Access
92: LDA 1, -1(4)
93: LD 1, 0(1)
94: LD  2, 0(6)
95: LDA 6,  -1(6)
96: MUL 1, 2, 1    Mul operation
97: ST  1, 0(6)
98: LDA 6,  1(6)
99: LD  2, 0(6)
100: LDA 6,  -1(6)
101: SUB 1, 2, 1    Sub operation
102: ST  1, 0(6)
103: LDA 6,  1(6)
61: LDC 7, 104, 0    Function Jump
105: ST 6, 0(4)   Var Table x
106: LDA 6, 1(6)   Variable x
107: LDA 4, 1(4)   Var Table x
108: ST 6, 0(4)   Var Table y
109: LDA 6, 1(6)   Variable y
110: LDA 4, 1(4)   Var Table y
111: ST 6, 0(4)   Var Table result
112: LDA 6, 1(6)   Variable result
113: LDA 4, 1(4)   Var Table result
* Variable Access
114: LDA 1, -0(4)
115: LD 1, 0(1)
* Variable Access
116: LDA 1, -1(4)
117: LD 1, 0(1)
* Variable Access
118: LDA 1, -0(4)
119: LD 1, 0(1)
* Variable Access
120: LDA 1, -1(4)
121: LD 1, 0(1)
104: LDC 7, 122, 0    Function Jump
