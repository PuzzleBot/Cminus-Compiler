JAVA=java
JAVAC=javac
JFLEX=jflex
CLASSPATH=-classpath /usr/share/java/cup.jar:./java-cup-11.jar:.
CUP=$(JAVA) $(CLASSPATH) java_cup.Main <
#CUP=cup

all: Main.class

Main.class: absyn/*.java parser.java sym.java Lexer.java src/Main.java

%.class: %.java
	$(JAVAC) $(CLASSPATH)  $^

Lexer.java: src/tiny.flex
	$(JFLEX) src/tiny.flex

parser.java: src/tiny.cup
	$(CUP) -dump -expect 3 src/tiny.cup

clean:
	rm -f parser.java Lexer.java sym.java *.class absyn/*.class *~
