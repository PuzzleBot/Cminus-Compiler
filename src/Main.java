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

            Absyn.outputFileName = (argv[0].replaceFirst("[.][^.]+$", "")) + ".tm";
            
            /*Result is usually DecList*/
            Object result = p.parse().value;
            
            /*Print the AST if the flag says to print it*/
            Absyn.showAST = showTreeFlag;
            Absyn.showMap = false;
            Absyn.compileCode = false;
            if(showTreeFlag == true){
                System.out.println( "The abstract syntax tree is:" );
                Absyn.startTraversal( (DecList)result );
            }

            /*Print the symbol table if the flag says to print it*/
            Absyn.showAST = false;
            Absyn.showMap = showTableFlag;
            Absyn.compileCode = false;
            if(showTableFlag == true){
                Absyn.startTraversal( (DecList)result );
            }
            
            /*Print errors without the AST or symbol table*/
            Absyn.showAST = false;
            Absyn.showMap = false;
            Absyn.compileCode = false;
            System.out.println();
            
            if(Absyn.hasError == true){
                System.out.println("Error summary:");
            }

            Absyn.compileCode = genCodeFlag;
            Absyn.startTraversal( (DecList)result );


            

        } catch (Exception e) {
            /* do cleanup here -- possibly rethrow e */
            e.printStackTrace();
        }
    }
}


