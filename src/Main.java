/*
 Created by: Fei Song
 File Name: Main.java
 To Build:
 After the scanner, tiny.flex, and the parser, tiny.cup, have been created.
 javac Main.java
 
 To Run:
 java -classpath /usr/share/java/cup.jar:. Main gcd.tiny
 
 where gcd.tiny is an test input file for the tiny language.
 */

import java.io.*;
import absyn.*;
import symtable.*;

class Main {
    static public void main(String argv[]) {
        boolean showTreeFlag = false;
        boolean showTableFlag = false;
        boolean genCodeFlag = false;
        int i;
        
        
        for(i = 0; i < argv.length; i++){
            if(argv[i].equals("-a")){
                showTreeFlag = true;
            }
            
            if(argv[i].equals("-s")){
                showTableFlag = true;
            }
            
            if(argv[i].equals("-c")){
                genCodeFlag = true;
            }
        }
        
        /* Start the parser */
        try {
            parser p = new parser(new Lexer(new FileReader(argv[0])));
            
            /*Result is usually DecList*/
            Object result = p.parse().value;
            
            /*Print the AST if the flag says to print it*/
            Absyn.showAST = showTreeFlag;
            Absyn.showMap = false;
            if(showTreeFlag == true){
                System.out.println( "The abstract syntax tree is:" );
                Absyn.showTree( (DecList)result, 0 );
            }

            /*Print the symbol table if the flag says to print it*/
            Absyn.showAST = false;
            Absyn.showMap = showTableFlag;
            if(showTableFlag == true){
                Absyn.showTree( (DecList)result, 0 );
            }

        } catch (Exception e) {
            /* do cleanup here -- possibly rethrow e */
            e.printStackTrace();
        }
    }
}


