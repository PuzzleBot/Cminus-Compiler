JAVA=java
JAVAC=javac
JFLEX=jflex
CLASSPATH=-classpath /usr/share/java/cup.jar:./cup/java-cup-11.jar:.:
CUP=$(JAVA) $(CLASSPATH) java_cup.Main -expect 3 <
#CUP=cup

all: Main.class

Main.class: absyn/*.java bin/parser.java bin/sym.java bin/lexer.java allClasses 

allClasses:
	$(JAVAC) $(CLASSPATH) absyn/*.java src/*.java bin/*.java
	mv src/*.class ./bin/

bin/lexer.java: src/tiny.flex
	$(JFLEX) src/tiny.flex
	mv src/Lexer.java bin/Lexer.java

bin/parser.java: src/tiny.cup
	$(CUP) src/tiny.cup
	mkdir -p ./bin
	mv parser.java bin/parser.java
	mv sym.java bin/sym.java



clean:
	rm -f bin/parser.java bin/lexer.java bin/sym.java *.class bin/*.class bin/*.java absyn/*.class *~

run:
	java -classpath /usr/share/java/cup.jar:.:./bin/:./absyn/ Main test/euclid.cm
