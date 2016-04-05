package symtable;
import absyn.*;
import java.util.*;
import java.io.*;

abstract public class CodeGen {
    public static final int RESULT_REG = 1;
    public static final int OPERAND1_REG = 2;
    public static final int OPERAND2_REG = 3;
    public static final int STACK_PTR_REG = 7;

    public static final int VARIABLE_STACK_START = 1024;

    public static int currentLine = 11;
    public static int currentVariableOffset = 0;

    public static String outputFileName = "";
    public static File outputFile;
    public static PrintWriter writer;

    public static void initFile(String fileName){
        try{
            outputFile = new File(fileName);
            System.out.println("Writing to: " + fileName);

            writer = new PrintWriter(outputFile);

            writer.println("* Standard prelude");
            writer.println("  0:     LD  6,0(0)  load gp with maxaddress");
            writer.println("  1:    LDA  5,0(6)     copy to gp to fp");
            writer.println("  2:     ST  0,0(0)     clear location 0");
            writer.println("* code for input routine");
            writer.println("  4:     ST  0,-1(5)    store return");
            writer.println("  5:     IN  0,0,0  input");
            writer.println("  6:     LD  7,-1(5)    return to caller");
            writer.println("* code for output routine");
            writer.println("  7:     ST  0,-1(5)    store return");
            writer.println("  8:     LD  0,-2(5)    load output value");
            writer.println("  9:    OUT  0,0,0  output");
            writer.println(" 10:     LD  7,-1(5)    return to caller");
            writer.println("  3:    LDA  7,7(7)     jump around i/o code");
            writer.println("* End of prelude");

        }
        catch(Exception e){
            System.out.println("Output file error.");
        }
    }

    public static void genStmt( IfExp tree ){

    }

    public static void genStmt( ReturnExp tree ){
        
    }

    public static void genStmt( WhileExp tree ){

    }

    public static void genStmt( CompoundExp tree ){
        
    }

    public static void genStmt( Exp tree ){
        
    }

    public static void genDec( ArrayDec tree ){
        
    }

    public static void genDec( SimpleDec tree ){
        
    }

    public static void genDec( FunctionDec tree ){
        
    }

    public static void genExp( IntExp tree, boolean isAddress ){

    }

    public static void genExp( VarExp tree, boolean isAddress ){

    }

    public static void genExp( OpExp tree, boolean isAddress ){

    }

    public static void genExp( CallExp tree, boolean isAddress ){

    }

    public static void genExp( AssignExp tree, boolean isAddress ){

    }
}