JAVA=java
JAVAC=javac
JFLEX=jflex
CLASSPATH=-classpath /usr/share/java/cup.jar:./cup/java-cup-11.jar:.
CUP=$(JAVA) $(CLASSPATH) java_cup.Main -dump -expect 3 <
#CUP=cup

all: Main.class

Main.class: absyn/*.java parser.java sym.java Lexer.java src/Main.java

%.class: %.java
	$(JAVAC) $(CLASSPATH)  $^

Lexer.java: src/tiny.flex
	$(JFLEX) src/tiny.flex

parser.java: src/tiny.cup
	$(CUP) src/tiny.cup

clean:
	rm -f parser.java Lexer.java sym.java *.class absyn/*.class *~
