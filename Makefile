JAVA=java
JAVAC=javac
JFLEX=jflex
FILE=test/euclid.cm
CLASSPATH=-classpath /usr/share/java/cup.jar:./cup/java-cup-11.jar:.:
RUNCLASSPATH=-classpath /usr/share/java/cup.jar:.:./bin/:./absyn/:./symtable/
CUP=$(JAVA) $(CLASSPATH) java_cup.Main -expect 3 <
#CUP=cup

all: Main.class

Main.class: absyn/*.java symtable/*.java bin/parser.java bin/sym.java bin/lexer.java allClasses 

allClasses:
	$(JAVAC) $(CLASSPATH) absyn/*.java symtable/*.java src/*.java bin/*.java
	mv src/*.class ./bin/

bin/lexer.java: src/cminus.flex
	$(JFLEX) src/cminus.flex
	mv src/Lexer.java bin/Lexer.java

bin/parser.java: src/cminus.cup
	$(CUP) src/cminus.cup
	mkdir -p ./bin
	mv parser.java bin/parser.java
	mv sym.java bin/sym.java



clean:
	rm -f bin/parser.java bin/lexer.java bin/sym.java *.class bin/*.class bin/*.java absyn/*.class *~ symtable/*.class

run:
	java $(RUNCLASSPATH) Main $(FILE) -a -e -c


testSymTable:
	java $(RUNCLASSPATH) symtable/SemanticHashmap