package symtable;
import absyn.*;
import java.util.*;
import java.io.*;

abstract public class CodeGen {
    public static final int TEMP_REG = 0;
    public static final int RESULT_REG = 1;
    public static final int OPERAND1_REG = 2;
    public static final int TABLE_STACK_REG = 4;    //Free register for storing an address
    public static final int FRAME_PTR_REG = 5;  //fp
    public static final int STACK_PTR_REG = 6;  //gp
    public static final int PC = 7;

    public static final int VARIABLE_STACK_START = 1024;

    public static int currentLine = 12;
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
            writer.println("  0:     LD  6,0(0)     load gp with maxaddress");
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
            writer.println(" 11:    LDC " + TABLE_STACK_REG + ", 1024, 0     Set starting variable stack");
            writer.println("  3:    LDA  7,7(7)     jump around i/o code");
            writer.println("* End of prelude");

        }
        catch(Exception e){
            System.out.println("Output file error.");
        }
    }

    public static void genSaveResult(){
        /*Save the contents of the result register (register 0) into the stack*/
        writer.println(currentLine + ": ST  " + RESULT_REG + ", " + "0(" + STACK_PTR_REG + ")");
        currentLine++;
        writer.println(currentLine + ": LDA " + STACK_PTR_REG + ",  1(" + STACK_PTR_REG + ")");
        currentLine++;
    }

    public static void genRecoverResult(){
        writer.println(currentLine + ": LD  " + RESULT_REG + ", " + "0(" + STACK_PTR_REG + ")");
        currentLine++;
        writer.println(currentLine + ": LDA " + STACK_PTR_REG + ",  -1(" + STACK_PTR_REG + ")");
        currentLine++;
    }

    public static void genRecoverOperand(){
        writer.println(currentLine + ": LD  " + OPERAND1_REG + ", " + "0(" + STACK_PTR_REG + ")");
        currentLine++;
        writer.println(currentLine + ": LDA " + STACK_PTR_REG + ",  -1(" + STACK_PTR_REG + ")");
        currentLine++;
    }
}