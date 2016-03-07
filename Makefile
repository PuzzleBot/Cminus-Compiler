JAVA=java
JAVAC=javac
JFLEX=jflex
CLASSPATH=-classpath /usr/share/java/cup.jar:./cup/java-cup-11.jar:.
CUP=$(JAVA) $(CLASSPATH) java_cup.Main -expect 3 <
#CUP=cup

all: Main.class

Main.class: absyn/*.java bin/parser.java bin/sym.java bin/lexer.java src/Main.java 

%.class: %.java
	$(JAVAC) $(CLASSPATH)  $^

bin/lexer.java: src/tiny.flex
	$(JFLEX) src/tiny.flex
	mv src/lexer.java bin/lexer.java

bin/parser.java: src/tiny.cup
	$(CUP) src/tiny.cup
	mv parser.java bin/parser.java
	mv sym.java bin/sym.java

clean:
	rm -f bin/parser.java bin/lexer.java bin/sym.java *.class bin/*.class bin/*.java absyn/*.class *~
