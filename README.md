A JFlex+Cup implementation for the C-Minus language.

  To build the entire program, type "make" in the current directory, which will 
generate an executable program called "main".

To test source code like "euclid.cm", type 

    "java -classpath /usr/share/java/cup.jar:.:./bin/:./absyn/:./symtable/ Main <filename>"
    replacing <filename> with a path to a cminus file.

    Running options (append after the file name):
	-a : Display the abstract syntax tree
	-s : Display the symbol table
	-c : Compile code

Either the syntax tree, symbol table, or both will be displayed on the screen
depending on flags given.

Alternatively, the following commands will run the program with the file
test/euclid.cm:

    make run FILE=<filename>          (both -a and -s)
    make runAST FILE=<filename>       (-a only)
    make runTable FILE=<filename>     (-s only)
    make runCodegen FILE=<filename>   (-c only)


To rebuild the parser, type "make clean" and type "make" again.

  Also note that all the abstract syntax tree structures are defined under
the directory "absyn" and within "Absyn.java" class, the showTree function
is implemented.  In addition, since some java files are generated automatically,
they may contain variables that are not used, which are safe to ignore in
the compilation process.
