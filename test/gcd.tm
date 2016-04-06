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
12: ST 6, 0(4)   Var Table y
13: LDA 6, 1(6)   Variable y
14: LDA 4, 1(4)   Var Table y
15: ST 6, 0(4)   Var Table u
16: LDA 6, 1(6)   Variable u
17: LDA 4, 1(4)   Var Table u
18: ST 6, 0(4)   Var Table v
19: LDA 6, 1(6)   Variable v
20: LDA 4, 1(4)   Var Table v
* Variable Access
22: LDA 1, -1(4)
23: LD 1, 0(1)
24: ST  1, 0(6)
25: LDA 6,  1(6)
  26:   LDC  1, 0, 0     IntExp constant val
27: LD  2, 0(6)
28: LDA 6,  -1(6)
29: ST  1, 0(6)
30: LDA 6,  1(6)
* Variable Access
31: LDA 1, -0(4)
32: LD 1, 0(1)
* Variable Access
33: LDA 1, -1(4)
34: LD 1, 0(1)
* Variable Access
35: LDA 1, -0(4)
36: LD 1, 0(1)
37: ST  1, 0(6)
38: LDA 6,  1(6)
* Variable Access
39: LDA 1, -0(4)
40: LD 1, 0(1)
41: ST  1, 0(6)
42: LDA 6,  1(6)
* Variable Access
43: LDA 1, -1(4)
44: LD 1, 0(1)
45: LD  2, 0(6)
46: LDA 6,  -1(6)
47: DIV 1, 2, 1    Div operation
48: ST  1, 0(6)
49: LDA 6,  1(6)
50: ST  1, 0(6)
51: LDA 6,  1(6)
* Variable Access
52: LDA 1, -1(4)
53: LD 1, 0(1)
54: LD  2, 0(6)
55: LDA 6,  -1(6)
56: MUL 1, 2, 1    Mul operation
57: ST  1, 0(6)
58: LDA 6,  1(6)
59: LD  2, 0(6)
60: LDA 6,  -1(6)
61: SUB 1, 2, 1    Sub operation
62: ST  1, 0(6)
63: LDA 6,  1(6)
21: LDC 7, 64, 0    Function Jump
65: ST 6, 0(4)   Var Table x
66: LDA 6, 1(6)   Variable x
67: LDA 4, 1(4)   Var Table x
* Variable Access
68: LDA 1, -0(4)
69: LD 1, 0(1)
* Variable Access
70: LDA 1, -0(4)
71: LD 1, 0(1)
  72:   LDC  1, 10, 0     IntExp constant val
* Variable Access
73: LDA 1, -0(4)
74: LD 1, 0(1)
* Variable Access
75: LDA 1, -0(4)
76: LD 1, 0(1)
64: LDC 7, 77, 0    Function Jump
