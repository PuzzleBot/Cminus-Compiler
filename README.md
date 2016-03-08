A JFlex+Cup implementation for the C-Minus language.



  To build the entire program, type "make" in the current directory, which will 
generate an executable program called "tiny".

  To test source code like "gcd.tiny", type 

    "java -classpath /usr/share/java/cup.jar:. Main gcd.tiny" 

and the syntax tree will be displayed on the screen.

  To rebuild the parser, type "make clean" and type "make" again.

  Also note that all the abstract syntax tree structures are defined under
the directory "absyn" and within "Absyn.java" class, the showTree function
is implemented.  In addition, since some java files are generated automatically,
they may contain variables that are not used, which are safe to ignore in
the compilation process.
