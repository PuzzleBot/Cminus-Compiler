package symtable;
import absyn.*;
import java.util.*;
import java.io.*;

abstract public class CodeGen {
    public static final int TEMP_REG = 3;
    public static final int RESULT_REG = 1;
    public static final int OPERAND1_REG = 2;
    public static final int TABLE_STACK_REG = 4;    //Variable table stack
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
            writer.println("  0:    LDC  "+ STACK_PTR_REG +", 0, 0     load gp with 0");
            writer.println("  1:    LDA  "+ FRAME_PTR_REG +", 0("+ STACK_PTR_REG +")     copy to gp to fp");
            writer.println("  2:     ST  0, 0(0)     clear location 0");
            writer.println("  3:    LDC " + TABLE_STACK_REG + ", 1024, 0     Set starting variable stack");

            writer.println("* code for input routine");
            writer.println("  5:     IN  "+ RESULT_REG +", 0, 0  input");
            writer.println("  6:    LDA  "+ STACK_PTR_REG +", 0("+ FRAME_PTR_REG + ")    return sequence");
            writer.println("  7:     LD  "+ TABLE_STACK_REG + ", -1("+ STACK_PTR_REG + ")   Restore frame ptr ");
            writer.println("  8:     LD  "+ FRAME_PTR_REG + ", -2("+ STACK_PTR_REG + ")   Restore frame ptr ");
            writer.println("  9:    LDA  "+ STACK_PTR_REG + ", -3("+ STACK_PTR_REG + ")   Move stack ptr down ");
            writer.println(" 10:     LD  "+ PC + ", 0("+ STACK_PTR_REG + ")   Use return address to return ");

            writer.println("* code for output routine");
            writer.println(" 11:     LD  "+ RESULT_REG +", 0("+ FRAME_PTR_REG +")    load output value");
            writer.println(" 12:    OUT  "+ RESULT_REG +", 0, 0  output");
            writer.println(" 13:    LDA  "+ STACK_PTR_REG +", 0("+ FRAME_PTR_REG + ")    return sequence");
            writer.println(" 14:     LD  "+ TABLE_STACK_REG + ", -1("+ STACK_PTR_REG + ")   Restore frame ptr ");
            writer.println(" 15:     LD  "+ FRAME_PTR_REG + ", -2("+ STACK_PTR_REG + ")   Restore frame ptr ");
            writer.println(" 16:    LDA  "+ STACK_PTR_REG + ", -3("+ STACK_PTR_REG + ")   Move stack ptr down ");
            writer.println(" 17:     LD  "+ PC + ", 0("+ STACK_PTR_REG + ")   Use return address to return ");

            writer.println("  4:    LDC  "+ PC +", 18, 0     jump around i/o code");
            writer.println("* End of prelude");

            currentLine = 18;
            currentVariableOffset = 0;
        }
        catch(Exception e){
            System.out.println("Output file error.");
        }
    }

    public static void finish(){
        int entryLine = Absyn.theMap.lookup("main").memPosition;

        writer.println("* Finale");

        /*Put a the return address in memory*/
        writer.println(currentLine + ": LDA " + TEMP_REG + ", 9("+ PC + ")   Store return address");
        currentLine++;
        writer.println(currentLine + ": ST " + TEMP_REG + ", 0("+ STACK_PTR_REG + ")   Store return address");
        currentLine++;
        /*Move stack pointer by 1 to allocate*/
        writer.println(currentLine + ": LDA " + STACK_PTR_REG + ", 1("+ STACK_PTR_REG + ")   Increment stack ");
        currentLine++;

        /*Put a the old frame pointer in memory*/
        writer.println(currentLine + ": ST " + FRAME_PTR_REG + ", 0("+ STACK_PTR_REG + ")   Store frame pointer ");
        currentLine++;
        /*Move stack pointer by 1 to allocate*/
        writer.println(currentLine + ": LDA " + STACK_PTR_REG + ", 1("+ STACK_PTR_REG + ")   Increment stack ");
        currentLine++;

        /*Put a the old variable table pointer in memory*/
        writer.println(currentLine + ": ST " + TABLE_STACK_REG + ", 0("+ STACK_PTR_REG + ")   Store table pointer ");
        currentLine++;
        /*Move stack pointer by 1 to allocate*/
        writer.println(currentLine + ": LDA " + STACK_PTR_REG + ", 1("+ STACK_PTR_REG + ")   Increment stack ");
        currentLine++;

        /*New frame pointer*/
        writer.println(currentLine + ": LDA " + FRAME_PTR_REG + ", 0("+ STACK_PTR_REG + ")   Set new frame pointer ");
        currentLine++;

        /*New PC*/
        writer.println(currentLine + ": LDC " + PC + ", "+ entryLine +", 0   Jump to main ");
        currentLine++;

        writer.println(currentLine + ": HALT 0, 0, 0");

        writer.close();
    }

    public static void genSaveResult(){
        /*Save the contents of the result register (register 1) into the stack*/
        writer.println(currentLine + ": ST  " + RESULT_REG + ", " + "0(" + STACK_PTR_REG + ")   Store value as a temp thing");
        currentLine++;
        writer.println(currentLine + ": LDA " + STACK_PTR_REG + ",  1(" + STACK_PTR_REG + ")    Stack alloc");
        currentLine++;
    }

    public static void genRecoverResult(){
        writer.println(currentLine + ": LDA " + STACK_PTR_REG + ",  -1(" + STACK_PTR_REG + ")  Stack dealloc");
        currentLine++;
        writer.println(currentLine + ": LD  " + RESULT_REG + ", " + "0(" + STACK_PTR_REG + ")  Get value into result");
        currentLine++;
    }

    public static void genRecoverOperand(){
        writer.println(currentLine + ": LDA " + STACK_PTR_REG + ",  -1(" + STACK_PTR_REG + ")    Stack dealloc");
        currentLine++;
        writer.println(currentLine + ": LD  " + OPERAND1_REG + ", " + "0(" + STACK_PTR_REG + ")   Get value into operand");
        currentLine++;
    }

    public static void genComment(String comment){
        writer.println("* " + comment);
    }
}