/*
 Created by: 
    Brandon Tan
    George Chapman-Brown
 
 Main.java
 - Main driver class for the Cminus compiler
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
                Absyn.startTraversal( (DecList)result );
            }

            /*Print the symbol table if the flag says to print it*/
            Absyn.showAST = false;
            Absyn.showMap = showTableFlag;
            if(showTableFlag == true){
                Absyn.startTraversal( (DecList)result );
            }
            
            /*Print errors without the AST or symbol table*/
            Absyn.showAST = false;
            Absyn.showMap = false;
            System.out.println();
            System.out.println("Error summary: (If nothing follows this line, there are no errors)");
            Absyn.startTraversal( (DecList)result );
            

        } catch (Exception e) {
            /* do cleanup here -- possibly rethrow e */
            e.printStackTrace();
        }
    }
}


