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
  3:    LDA  7,7(7)     jump around i/o code
* End of prelude
  11:   LDC  1, 8, 0     IntExp constant val
  12:   LDC  1, 0, 0     IntExp constant val
* Array Access
13: LD  1, 0(6)
14: LDA 6,  -1(6)
15: LDC 0, -1, 0    Array start
16: SUB 1, 1,0
17: ADD 1, 1,5
  18:   LDC  1, 8, 0     IntExp constant val
19: ST  1, 0(6)
20: LDA 6,  1(6)
  21:   LDC  1, 9, 0     IntExp constant val
22: LD  2, 0(6)
23: LDA 6,  -1(6)
24: ADD 1, 2, 1    Add operation
25: ST  1, 0(6)
26: LDA 6,  1(6)
* Variable Access
27: LD 1, -0(5)
  28:   LDC  1, 5, 0     IntExp constant val
29: ST  1, 0(6)
30: LDA 6,  1(6)
  31:   LDC  1, 6, 0     IntExp constant val
32: LD  2, 0(6)
33: LDA 6,  -1(6)
34: ADD 1, 2, 1    Add operation
35: ST  1, 0(6)
36: LDA 6,  1(6)
* Variable Access
37: LD 1, -0(5)
* Variable Access
38: LD 1, -0(5)
39: ST  1, 0(6)
40: LDA 6,  1(6)
  41:   LDC  1, 0, 0     IntExp constant val
42: LD  2, 0(6)
43: LDA 6,  -1(6)
44: ST  1, 0(6)
45: LDA 6,  1(6)
* Variable Access
46: LD 1, -0(5)
* Variable Access
47: LD 1, -0(5)
* Variable Access
48: LD 1, -0(5)
49: ST  1, 0(6)
50: LDA 6,  1(6)
* Variable Access
51: LD 1, -0(5)
52: ST  1, 0(6)
53: LDA 6,  1(6)
* Variable Access
54: LD 1, -0(5)
55: LD  2, 0(6)
56: LDA 6,  -1(6)
57: DIV 1, 2, 1    Add operation
58: ST  1, 0(6)
59: LDA 6,  1(6)
60: ST  1, 0(6)
61: LDA 6,  1(6)
* Variable Access
62: LD 1, -0(5)
63: LD  2, 0(6)
64: LDA 6,  -1(6)
65: MUL 1, 2, 1    Add operation
66: ST  1, 0(6)
67: LDA 6,  1(6)
68: LD  2, 0(6)
69: LDA 6,  -1(6)
70: SUB 1, 2, 1    Add operation
71: ST  1, 0(6)
72: LDA 6,  1(6)
* Variable Access
73: LD 1, -0(5)
* Variable Access
74: LD 1, -0(5)
* Variable Access
75: LD 1, -0(5)
* Variable Access
76: LD 1, -0(5)
