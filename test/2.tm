* Standard prelude
  0:    LDC  6, 0, 0     load gp with 0
  1:    LDC  5, 1024, 0     Frame pointer is at the table bottom
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
19: ST 6, 0(4)   Pointer-> Var Table 
20: LDA 6, 1(6)   Variable 
21: LDA 4, 1(4)   Var Table 
* Variable declaration: y
22: ST 6, 0(4)   Pointer-> Var Table 
23: LDA 6, 1(6)   Variable 
24: LDA 4, 1(4)   Var Table 
* Function arguments
* Variable Access: x
25: LD 1, 0(5)
* Assignment save result:
26: ST  1, 0(6)   Store value as a temp thing
27: LDA 6,  1(6)    Stack alloc
  28:   LDC  1, 5, 0     IntExp constant val
* Assignment right side value
29: LDA 6,  -1(6)    Stack dealloc
30: LD  2, 0(6)   Get value into operand
31: ST 1, 0(2)  var equals expression result
32: ST 1, 0(6)    Store argument
33: LDA 6, 1(6)    Store argument
* Variable Access: y
34: LD 1, 1(5)
* Assignment save result:
35: ST  1, 0(6)   Store value as a temp thing
36: LDA 6,  1(6)    Stack alloc
  37:   LDC  1, 7, 0     IntExp constant val
* Assignment right side value
38: LDA 6,  -1(6)    Stack dealloc
39: LD  2, 0(6)   Get value into operand
40: ST 1, 0(2)  var equals expression result
41: ST 1, 0(6)    Store argument
42: LDA 6, 1(6)    Store argument
* Variable Access: x
43: LD 1, 0(5)
* Assignment save result:
44: ST  1, 0(6)   Store value as a temp thing
45: LDA 6,  1(6)    Stack alloc
  46:   LDC  1, 5, 0     IntExp constant val
* Expression:
47: ST  1, 0(6)   Store value as a temp thing
48: LDA 6,  1(6)    Stack alloc
  49:   LDC  1, 7, 0     IntExp constant val
50: LDA 6,  -1(6)    Stack dealloc
51: LD  2, 0(6)   Get value into operand
52: ADD 1, 2, 2    Add operation
53: ST  1, 0(6)   Store value as a temp thing
54: LDA 6,  1(6)    Stack alloc
* Assignment right side value
55: LDA 6,  -1(6)    Stack dealloc
56: LD  2, 0(6)   Get value into operand
57: ST 1, 0(2)  var equals expression result
58: ST 1, 0(6)    Store argument
59: LDA 6, 1(6)    Store argument
* Variable Access: y
60: LD 1, 1(5)
* Assignment save result:
61: ST  1, 0(6)   Store value as a temp thing
62: LDA 6,  1(6)    Stack alloc
* Variable Access: x
63: LD 1, 0(5)
64: LD 1, 0(1)   Variable get value
* Expression:
65: ST  1, 0(6)   Store value as a temp thing
66: LDA 6,  1(6)    Stack alloc
  67:   LDC  1, 8, 0     IntExp constant val
68: LDA 6,  -1(6)    Stack dealloc
69: LD  2, 0(6)   Get value into operand
70: ADD 1, 2, 2    Add operation
71: ST  1, 0(6)   Store value as a temp thing
72: LDA 6,  1(6)    Stack alloc
* Assignment right side value
73: LDA 6,  -1(6)    Stack dealloc
74: LD  2, 0(6)   Get value into operand
75: ST 1, 0(2)  var equals expression result
76: ST 1, 0(6)    Store argument
77: LDA 6, 1(6)    Store argument
* Return statement
78: LDA 4, 0(5)   Table ptr = frame ptr 
79: LD 6, -1(4)   Restore stack ptr 
80: LD 5, -2(4)   Restore frame ptr 
81: LDA 4, -3(4)   Move stack ptr down 
82: LD 7, 0(4)   Use return address to return 
83: ST 1, 0(6)    Store argument
84: LDA 6, 1(6)    Store argument
85: ST 1, 0(6)    Store argument
86: LDA 6, 1(6)    Store argument
* Inner scope non-function deallocation
87: LDA 4, -2(4)  Deallocation: Variable table in scope
88: LD 6, 0(4)  Deallocation: Scope variables
18: LDC 7, 89, 0    Function Jump around
* Finale
89: LDA 3, 9(7)   Store return address
90: ST 3, 0(4)   Store return address
91: LDA 4, 1(4)   Increment stack 
92: ST 5, 0(4)   Store frame pointer 
93: LDA 4, 1(4)   Increment stack 
94: ST 6, 0(4)   Store table pointer 
95: LDA 4, 1(4)   Increment stack 
96: LDA 5, 0(4)   Set new frame pointer 
97: LDC 7, 19, 0   Jump to main 
98: HALT 0, 0, 0
