* Standard prelude
  0:    LDC  6, 0, 0     load gp with 0
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
* Variable declaration: x
19: ST 6, 0(4)   Var Table 
20: LDA 6, 1(6)   Variable 
21: LDA 4, 1(4)   Var Table 
* Variable declaration: y
22: ST 6, 0(4)   Var Table 
23: LDA 6, 1(6)   Variable 
24: LDA 4, 1(4)   Var Table 
* Variable declaration: z
25: ST 6, 0(4)   Var Table 
26: LDA 6, 1(6)   Variable 
27: LDA 4, 1(4)   Var Table 
* Function arguments
* Variable Access: x
28: LDC 3, 1024, 0
29: LDA 1, 0(3)
30: LD 1, 0(1)
31: LD 1, 0(1)
* Assignment save result:
32: ST  1, 0(6)   Store value as a temp thing
33: LDA 6,  1(6)    Stack alloc
  34:   LDC  1, 5, 0     IntExp constant val
* Assignment right side value
35: LDA 6,  -1(6)    Stack dealloc
36: LD  2, 0(6)   Get value into operand
37: ST 1, 0(2)  var equals expression result
38: ST 1, 0(5)    Store argument
* Variable Access: y
39: LDC 3, 1024, 0
40: LDA 1, 1(3)
41: LD 1, 0(1)
42: LD 1, 0(1)
* Assignment save result:
43: ST  1, 0(6)   Store value as a temp thing
44: LDA 6,  1(6)    Stack alloc
  45:   LDC  1, 7, 0     IntExp constant val
* Assignment right side value
46: LDA 6,  -1(6)    Stack dealloc
47: LD  2, 0(6)   Get value into operand
48: ST 1, 0(2)  var equals expression result
49: ST 1, 1(5)    Store argument
* Variable Access: z
50: LDC 3, 1024, 0
51: LDA 1, 2(3)
52: LD 1, 0(1)
53: LD 1, 0(1)
* Assignment save result:
54: ST  1, 0(6)   Store value as a temp thing
55: LDA 6,  1(6)    Stack alloc
56: LD 1, 0(1)   Variable get value
* Variable Access: y
57: LDC 3, 1024, 0
58: LDA 1, 1(3)
59: LD 1, 0(1)
60: LD 1, 0(1)
* Expression:
61: ST  1, 0(6)   Store value as a temp thing
62: LDA 6,  1(6)    Stack alloc
63: LD 1, 0(1)   Variable get value
* Variable Access: x
64: LDC 3, 1024, 0
65: LDA 1, 0(3)
66: LD 1, 0(1)
67: LD 1, 0(1)
68: LDA 6,  -1(6)    Stack dealloc
69: LD  2, 0(6)   Get value into operand
70: ADD 1, 2, 1    Add operation
71: ST  1, 0(6)   Store value as a temp thing
72: LDA 6,  1(6)    Stack alloc
* Assignment right side value
73: LDA 6,  -1(6)    Stack dealloc
74: LD  2, 0(6)   Get value into operand
75: ST 1, 0(2)  var equals expression result
76: ST 1, 2(5)    Store argument
* Call setup
77: LDA 3, 9(7)   Store return address
78: ST 3, 0(6)   Store return address
79: LDA 6, 1(6)   Increment stack 
80: ST 5, 0(6)   Store frame pointer 
81: LDA 6, 1(6)   Increment stack 
82: ST 4, 0(6)   Store table pointer 
83: LDA 6, 1(6)   Increment stack 
84: LDA 5, 0(6)   Set new frame pointer 
85: LDC 7, 11, 0   Jump to function 
* Function arguments
86: LD 1, 0(1)   Variable get value
* Variable Access: x
87: LDC 3, 1024, 0
88: LDA 1, 0(3)
89: LD 1, 0(1)
90: LD 1, 0(1)
91: ST 1, 0(5)    Store argument
92: ST 1, 3(5)    Store argument
* Return statement
93: LDA 6, 0(5)   Stack ptr = frame ptr 
94: LD 4, -1(6)   Restore table ptr 
95: LD 5, -2(6)   Restore frame ptr 
96: LDA 6, -3(6)   Move stack ptr down 
97: LD 7, 0(6)   Use return address to return 
98: ST 1, 4(5)    Store argument
99: ST 1, 5(5)    Store argument
* Inner scope non-function deallocation
100: LDA 4, -3(4)  Deallocation: Variable table in scope
101: LD 6, 0(4)  Deallocation: Scope variables
18: LDC 7, 102, 0    Function Jump around
* Finale
102: LDA 3, 9(7)   Store return address
103: ST 3, 0(6)   Store return address
104: LDA 6, 1(6)   Increment stack 
105: ST 5, 0(6)   Store frame pointer 
106: LDA 6, 1(6)   Increment stack 
107: ST 4, 0(6)   Store table pointer 
108: LDA 6, 1(6)   Increment stack 
109: LDA 5, 0(6)   Set new frame pointer 
110: LDC 7, 19, 0   Jump to main 
111: HALT 0, 0, 0
