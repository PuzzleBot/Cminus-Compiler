package absyn;
import symtable.*;
import java.util.*;
import java.io.*;

abstract public class Absyn {
    public int pos;

    public static String outputFileName = "";

    final static int SPACES = 4;
    public static SemanticHashmap theMap;
    public static boolean showMap = true;
    public static boolean showAST = true;
    public static boolean compileCode = true;
    
    /*Data variables for passing data between tree nodes*/
    public static ArrayList <Identifier> theList;
    public static Identifier searchResult;
    public static String previousScopeName = "noScope";
    public static String currentFunction = "global";
    public static int type;
    
    /*Lets the driver program there is something wrong and don't generate the code*/
    public static boolean hasError = false;
    
    /*For capturing call arguments for typechecking*/
    public static Stack<ArrayList<Integer>> callTypeListStack;
    public static boolean getCallTypes = false;
    
    static private void indent( int spaces ) {
        for( int i = 0; i < spaces; i++ ) System.out.print( " " );
    }
    
    static public void startTraversal( DecList tree ){
        theMap = new SemanticHashmap();
        callTypeListStack = new Stack<ArrayList<Integer>>();
        hasError = false;
        
        if(compileCode == true){
            CodeGen.initFile(outputFileName);
        }

        showTree( tree, 0 );
        
        if(showMap==true){
            theMap.printInnerScope();
        }

        if(compileCode == true){
            CodeGen.finish();
        }
    }

    static public void showTree( ExpList tree, int spaces ) {
        int expType;
        int argNumber = 0;

        if(compileCode == true){
            CodeGen.genComment("Function arguments");
        }

        while( tree != null ) {
            expType = showTree( tree.head, spaces );
            
            /*If this expression list is inside a function call, store the types*/
            if(getCallTypes == true){
                callTypeListStack.peek().add((Integer)expType);

                if(compileCode == true){
                    /*Store arguments in the frame on the stack, in the soon-to-be allocated space (arguments in result register)*/
                    CodeGen.genStackArgPush(argNumber);
                }
            }
            
            argNumber++;
            tree = tree.tail;
        } 
    }
    
    static public void showTree( DecList tree, int spaces ) {
        
        while( tree != null ) {
            showTree( tree.head, spaces );
            tree = tree.tail;
        }
    }

    /*All exp nodes pass the "type" of the exp back up*/
    static private int showTree( Exp tree, int spaces ) {
        int expressionType = Identifier.VOID;
        
        if(tree!=null){
            /*All of these return Identifier types*/
            if( tree instanceof AssignExp )
                /*Returns type which should be on both sides*/
                expressionType = showTree( (AssignExp)tree, spaces );
            else if( tree instanceof IfExp )
                /*Returns INT*/
                expressionType = showTree( (IfExp)tree, spaces );
            else if( tree instanceof IntExp )
                /*Returns INT*/
                expressionType = showTree( (IntExp)tree, spaces );
            else if( tree instanceof OpExp )
                /*Returns type which should be on both sides*/
                expressionType = showTree( (OpExp)tree, spaces );
            else if( tree instanceof VarExp )
                /*Returns type of variable*/
                expressionType = showTree( (VarExp)tree, spaces );
            else if( tree instanceof NilExp )
                /*Returns VOID*/
                showTree( (NilExp)tree, spaces );
            else if( tree instanceof CallExp )
                /*Returns the return type of the called function*/
                expressionType = showTree( (CallExp)tree, spaces );
            else if( tree instanceof WhileExp )
                /*Returns VOID*/
                showTree( (WhileExp)tree, spaces );
            else if( tree instanceof ReturnExp )
                /*Returns type of the thing returned*/
                expressionType = showTree( (ReturnExp)tree, spaces );
            else if( tree instanceof CompoundExp )
                /*Returns VOID*/
                showTree( (CompoundExp)tree, spaces, true );
    
            else {
                indent( spaces );
                System.out.println( "Error: Illegal expression at line " + tree.pos);
                hasError = true;
            }
        }else{
            if(showAST==true){
                System.out.println("null expression");
            }
        }
        
        return expressionType;
    }

    static private int showTree( AssignExp tree, int spaces ) {
        int leftType;
        int rightType;
        
        if(showAST==true){
            indent( spaces );
            System.out.println( "AssignExp:" );
        }
        spaces += SPACES;
        leftType = showTree( tree.lhs, spaces );
        if(compileCode == true){
            /*LHS is in the result register, store it in memory*/
            CodeGen.genComment("Assignment save result (Variable address):");
            CodeGen.genSaveResult();
        }

        rightType = showTree( tree.rhs, spaces );
        
        if(leftType != rightType){
            System.out.println("Error: Assigning value of type " + Identifier.typeToString(rightType) + " to variable of type " + Identifier.typeToString(leftType) + ": line " + tree.pos);
            hasError = true;
        }

        if(compileCode == true){
            /*RHS should be in the result register, LHS (var) address should be in memory (put into operand register)*/
            CodeGen.genComment("Assignment Expression");
            CodeGen.genRecoverOperand();

            CodeGen.writer.println(CodeGen.currentLine + ": ST " + CodeGen.RESULT_REG + ", 0(" + CodeGen.OPERAND1_REG + ")  var equals expression result");
            CodeGen.currentLine++;
        }
        
        return leftType;
    }

    static private int showTree( IfExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "IfExp:" );
        }
        previousScopeName = "if";
        
        spaces += SPACES;

        showTree( tree.test, spaces );
        /*Result register now holds 0 or 1 for the boolean expression, branch if false*/
        int branchLine = CodeGen.currentLine;
        CodeGen.currentLine++;

        int branchLength;

        showTree( tree.thenpart, spaces );

        if(tree.elsepart==null){
            if(compileCode == true){
                /*Branch on false*/
                CodeGen.genComment("If statement: ");
                branchLength = CodeGen.currentLine - branchLine - 1;
                CodeGen.writer.println(branchLine + ": JEQ " + CodeGen.RESULT_REG + ", "+ branchLength +"(" + CodeGen.PC  + ")    If jump");
            }
        }
        else if(tree.elsepart!=null){
            int unconditionalJump = CodeGen.currentLine;
            CodeGen.currentLine++;
            if(compileCode == true){
                /*Branch on false, one after the unconditional jump*/
                CodeGen.genComment("If-else statement: ");
                branchLength = CodeGen.currentLine - branchLine - 1;
                CodeGen.writer.println(branchLine + ": JEQ " + CodeGen.RESULT_REG + ", "+ branchLength +"(" + CodeGen.PC  + ")    If jump to else");
            }

            int elseStart = CodeGen.currentLine;
            CodeGen.currentLine++;

            previousScopeName = "else";
            showTree( tree.elsepart, spaces );

            if(compileCode == true){
                CodeGen.genComment("Else statement: ");
                CodeGen.writer.println(unconditionalJump + ": LDC " + CodeGen.PC + ", " + CodeGen.currentLine + ", 0     Jump past else if the if part is true");
            }
        }
        
        return Identifier.INT;
    }

    static private int showTree( IntExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "IntExp: " + tree.value );
        }

        if(compileCode == true){
            CodeGen.writer.println("  " + CodeGen.currentLine + ":   LDC  " + CodeGen.RESULT_REG + ", " + tree.value + ", 0     IntExp constant val");
            CodeGen.currentLine++;
        }

        return Identifier.INT;
    }

    static private int showTree( OpExp tree, int spaces ) {
        int leftType;
        int rightType;
        
        if(showAST==true){
            indent( spaces );
            System.out.print( "OpExp:" );
 
            switch( tree.op ) {
                case OpExp.PLUS:
                    System.out.println( " + " );
                    break;
                case OpExp.MINUS:
                    System.out.println( " - " );
                    break;
                case OpExp.MULT:
                    System.out.println( " * " );
                    break;
                case OpExp.DIV:
                    System.out.println( " / " );
                    break;
                case OpExp.EQ:
                    System.out.println( " == " );
                    break;
                case OpExp.LT:
                    System.out.println( " < " );
                    break;
                case OpExp.LE:
                    System.out.println( " <= " );
                    break;
                case OpExp.GT:
                    System.out.println( " > " );
                    break;
                case OpExp.GE:
                    System.out.println( " >= " );
                    break;
                case OpExp.NE:
                    System.out.println( " != " );
                    break;
                default:
                    System.out.println( "Error: Unrecognized operator at line " + tree.pos);
                    hasError = true;
                    break;
            }
        }
        
        
        spaces += SPACES;
        
        //typechecking for 2 sides of operand
        Identifier sideA;
        Identifier sideB;
        
        /*Generate operation code*/
        leftType = showTree( tree.left, spaces );
        if(compileCode == true){
            CodeGen.genComment("Operation Expression:");
            CodeGen.genSaveResult();
        }
        rightType = showTree( tree.right, spaces );
        if(compileCode == true){
            CodeGen.genRecoverOperand();

            /*Check operand type, do operation (result stored in result register)*/
            /*FOR CONDITIONALS: 1 if true, 0 if false*/
            switch( tree.op ) {
                case OpExp.PLUS:
                    CodeGen.writer.println(CodeGen.currentLine + ": ADD " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG + "    Add operation");
                    CodeGen.currentLine++;
                    break;
                case OpExp.MINUS:
                    CodeGen.writer.println(CodeGen.currentLine + ": SUB " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG  + "    Sub operation");
                    CodeGen.currentLine++;
                    break;
                case OpExp.MULT:
                    CodeGen.writer.println(CodeGen.currentLine + ": MUL " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG  + "    Mul operation");
                    CodeGen.currentLine++;
                    break;
                case OpExp.DIV:
                    CodeGen.writer.println(CodeGen.currentLine + ": DIV " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG  + "    Div operation");
                    CodeGen.currentLine++;
                    break;
                case OpExp.EQ:
                    /*If equal, Then op1 - op2 = 0 -> skip past*/
                    CodeGen.writer.println(CodeGen.currentLine + ": SUB " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG  + "    Less than");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": JEQ " + CodeGen.RESULT_REG + ", 2(" + CodeGen.PC  + ")    Branch on true");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 0, 0    Put 0 (false) in");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.PC + ", 1(" + CodeGen.PC  + ")    Go to next code segment");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 1, 0    Put 1 (true) in");
                    CodeGen.currentLine++;
                    break;
                case OpExp.LT:
                    /*If less than, Then op1 - op2 < 0 -> skip past*/
                    CodeGen.writer.println(CodeGen.currentLine + ": SUB " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG  + "    Less than");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": JLT " + CodeGen.RESULT_REG + ", 2(" + CodeGen.PC  + ")    Branch on true");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 0, 0    Put 0 (false) in");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.PC + ", 1(" + CodeGen.PC  + ")    Go to next code segment");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 1, 0    Put 1 (true) in");
                    CodeGen.currentLine++;
                    break;
                case OpExp.LE:
                    /*If less than equal, Then op1 - op2 <= 0 -> skip past*/
                    CodeGen.writer.println(CodeGen.currentLine + ": SUB " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG  + "    Less than");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": JLE " + CodeGen.RESULT_REG + ", 2(" + CodeGen.PC  + ")    Branch on true");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 0, 0    Put 0 (false) in");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.PC + ", 1(" + CodeGen.PC  + ")    Go to next code segment");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 1, 0    Put 1 (true) in");
                    CodeGen.currentLine++;
                    break;
                case OpExp.GT:
                    /*If greater than, Then op1 - op2 > 0 -> skip past*/
                    CodeGen.writer.println(CodeGen.currentLine + ": SUB " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG  + "    Less than");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": JGT " + CodeGen.RESULT_REG + ", 2(" + CodeGen.PC  + ")    Branch on true");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 0, 0    Put 0 (false) in");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.PC + ", 1(" + CodeGen.PC  + ")    Go to next code segment");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 1, 0    Put 1 (true) in");
                    CodeGen.currentLine++;
                    break;
                case OpExp.GE:
                    /*If greater than equal, Then op1 - op2 >= 0 -> skip past*/
                    CodeGen.writer.println(CodeGen.currentLine + ": SUB " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG  + "    Less than");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": JGE " + CodeGen.RESULT_REG + ", 2(" + CodeGen.PC  + ")    Branch on true");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 0, 0    Put 0 (false) in");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.PC + ", 1(" + CodeGen.PC  + ")    Go to next code segment");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 1, 0    Put 1 (true) in");
                    CodeGen.currentLine++;
                    break;
                case OpExp.NE:
                    /*If greater than equal, Then op1 - op2 != 0 -> skip past*/
                    CodeGen.writer.println(CodeGen.currentLine + ": SUB " + CodeGen.RESULT_REG + ", " + CodeGen.OPERAND1_REG + ", " + CodeGen.RESULT_REG  + "    Less than");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": JNE " + CodeGen.RESULT_REG + ", 2(" + CodeGen.PC  + ")    Branch on true");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 0, 0    Put 0 (false) in");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.PC + ", 1(" + CodeGen.PC  + ")    Go to next code segment");
                    CodeGen.currentLine++;
                    CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.RESULT_REG + ", 1, 0    Put 1 (true) in");
                    CodeGen.currentLine++;
                    break;
                default:
                    break;
            }

            //CodeGen.genSaveResult();
        }
        
        if(leftType != rightType){
            System.out.println("Warning: Value of type " + Identifier.typeToString(rightType) + " used with incompatible type " + Identifier.typeToString(leftType) + ": line " + tree.pos);
            System.out.println("Value assumed to actually supposed to be int");
        }
        else{
            /*If this is a comparison statement, both sides must be int*/
            if((tree.op == OpExp.EQ) || (tree.op == OpExp.LT) || (tree.op == OpExp.LE) || (tree.op == OpExp.GT) || (tree.op == OpExp.GE) || (tree.op == OpExp.NE)){
                if(leftType != Identifier.INT){
                    System.out.println("Error: Value of type " + Identifier.typeToString(leftType) + " cannot be used with comparison operator: line " + tree.pos);
                    hasError = true;
                }
                else if(rightType != Identifier.INT){
                    System.out.println("Error: Value of type " + Identifier.typeToString(rightType) + " cannot be used with comparison operator: line " + tree.pos);
                    hasError = true;
                }
            }
        }
        
        
        return leftType;
    }
    
    static private void showTree( Dec tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "Dec:" );
        }
        if (tree!=null){
            if( tree instanceof ArrayDec )
                showTree( (ArrayDec)tree, spaces );
            else if( tree instanceof SimpleDec )
                showTree( (SimpleDec)tree, spaces );
            else if( tree instanceof FunctionDec )
                showTree( (FunctionDec)tree, spaces );
            
        }
    }

    static private int showTree( VarExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "VarExp: ");
        }

        int theType = showTree( tree.name, spaces );

        if(compileCode == true){
            /*Load the variable's data*/
            CodeGen.genComment("VarExp: Value load");
            CodeGen.writer.println(CodeGen.currentLine + ": LD " + CodeGen.RESULT_REG + ", 0(" + CodeGen.RESULT_REG + ")   Variable get value");
            CodeGen.currentLine++;
        }
        
        return theType;
    }
    
    static private void showTree( NilExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "NilExp:" );
        }
    }
    
    static private int showTree( CallExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "CallExp: " +tree.func );
        }
        
        ArrayList<Integer> currentCallArgs;
        
        /*Get types of arguments in the call*/
        getCallTypes = true;

        Identifier currentFuncIdentifier = theMap.lookup(tree.func);

        int storeReturnLine1 = 0;
        int storeReturnLine2 = 0;

        /*GenCode Arguments transferred to function here*/
        callTypeListStack.push(new ArrayList<Integer>());
        showTree( tree.args, spaces + SPACES );
        currentCallArgs = callTypeListStack.pop();

        /*Place Frame pointer, alloc frame offset space, return address
   fp-> arg1
        var table ptr     ^
        previous fp       ^ 
        return address    | Stack grows up, return alloc'd first     */
        if(compileCode == true){
            CodeGen.genComment("Call setup:");

            storeReturnLine1 = CodeGen.currentLine;
            CodeGen.currentLine++;

            storeReturnLine2 = CodeGen.currentLine;
            CodeGen.currentLine++;

            /*Move stack pointer by 1 to allocate*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.TABLE_STACK_REG + ", 1("+ CodeGen.TABLE_STACK_REG + ")   Increment stack ");
            CodeGen.currentLine++;

            /*Put a the old frame pointer in memory*/
            CodeGen.writer.println(CodeGen.currentLine + ": ST " + CodeGen.FRAME_PTR_REG + ", 0("+ CodeGen.TABLE_STACK_REG + ")   Store frame pointer ");
            CodeGen.currentLine++;
            /*Move stack pointer by 1 to allocate*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.TABLE_STACK_REG + ", 1("+ CodeGen.TABLE_STACK_REG + ")   Increment stack ");
            CodeGen.currentLine++;

            /*Put a the old variable table pointer in memory*/
            CodeGen.writer.println(CodeGen.currentLine + ": ST " + CodeGen.STACK_PTR_REG + ", 0("+ CodeGen.TABLE_STACK_REG + ")   Store stack pointer ");
            CodeGen.currentLine++;
            /*Move stack pointer by 1 to allocate*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.TABLE_STACK_REG + ", 1("+ CodeGen.TABLE_STACK_REG + ")   Increment stack ");
            CodeGen.currentLine++;

            /*New frame pointer*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.FRAME_PTR_REG + ", 0("+ CodeGen.TABLE_STACK_REG + ")   Set new frame pointer ");
            CodeGen.currentLine++;

            /*Pass arguments, then load new pc*/
        }

        /*GenCode Arguments transferred to function here
        callTypeListStack.push(new ArrayList<Integer>());
        showTree( tree.args, spaces + SPACES );
        currentCallArgs = callTypeListStack.pop();*/

        if(compileCode == true){
            int jumpDistance = CodeGen.currentLine - storeReturnLine1;

            /*Put a the return address in memory*/
            CodeGen.writer.println(storeReturnLine1 + ": LDA " + CodeGen.TEMP_REG + ", "+ jumpDistance +"("+ CodeGen.PC + ")   Store return address");
            CodeGen.writer.println(storeReturnLine2 + ": ST " + CodeGen.TEMP_REG + ", 0("+ CodeGen.TABLE_STACK_REG + ")   Store return address");

            /*Get function line number*/
            int functionLine = currentFuncIdentifier.getMemPosition();

            /*New PC*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.PC + ", "+ functionLine +", 0   Jump to function ");
            CodeGen.currentLine++;

            CodeGen.genComment("Continue after finishing function \"" + tree.func + "\"");
        }
        
        if(callTypeListStack.isEmpty()){
            getCallTypes = false;
        }
        
        if(currentFuncIdentifier == null){
            System.out.println("Error: Calling undefined function " + tree.func + ": line " + tree.pos);
            hasError = true;
            
            return Identifier.VOID;
        }
        else{
            /*Check function call parameters*/
            boolean isValidCall = theMap.functionArgCheck(tree.func, currentCallArgs);
            if(isValidCall == false){
                System.out.println("Error: Invalid arguments to function " + tree.func + ": line " + tree.pos);
                hasError = true;
            }
            
            switch(currentFuncIdentifier.getType()){
                case FunctionIdentifier.FUNCTION_INT:
                    return Identifier.INT;
                case FunctionIdentifier.FUNCTION_VOID:
                    return Identifier.VOID;
                default:
                    return Identifier.VOID;
            }
        }
    }
    
    
    static private void showTree( WhileExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "WhileExp:" );
        }

        if(compileCode == true){
            CodeGen.genComment("While loop:");
        }

        int whileSetupLine = CodeGen.currentLine;
        showTree( tree.test, spaces + SPACES );
        /*While test*/
        int whileTestLine = CodeGen.currentLine;
        CodeGen.currentLine++;

        int branchLine = CodeGen.currentLine;
        CodeGen.currentLine++;

        showTree( tree.body, spaces + SPACES ); 

        if(compileCode == true){
            /*Unconditional jump back to while test*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.PC + ", "+ whileSetupLine +", 0    Go back to the while test");
            CodeGen.currentLine++;

            /*Branch on false*/
            int branchLength = CodeGen.currentLine - whileTestLine - 1;
            CodeGen.writer.println(branchLine + ": JEQ " + CodeGen.RESULT_REG + ", "+ branchLength +"(" + CodeGen.PC  + ")    While jump on false: exit loop");
        }
    }
    
    static private int showTree( ReturnExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "ReturnExp:" );
        }
        
        /*Check for function return match*/
        /*Return value from the expression is in the result register*/
        Identifier currentFuncIdentifier = theMap.lookup(currentFunction);
        int returnType = showTree( tree.exp, spaces + SPACES );
        int functionReturnType;
        
        if(currentFuncIdentifier != null){
            switch(currentFuncIdentifier.getType()){
                case FunctionIdentifier.FUNCTION_INT:
                    functionReturnType = Identifier.INT;
                    break;
                case FunctionIdentifier.FUNCTION_VOID:
                    functionReturnType = Identifier.VOID;
                    break;
                default:
                    functionReturnType = Identifier.VOID;
                    break;
            }
            
            if(functionReturnType != returnType){
                System.out.println("Error: Returning value of type " + Identifier.typeToString(returnType) + " for function with type " + Identifier.typeToString(currentFuncIdentifier.getType()) + ": line " + tree.pos);
                hasError = true;
            }
        }

        if(compileCode == true){
            /*Deallocate the frame: stack ptr = frame ptr, old var table is 1 down, old frame ptr is 2 down, return address is 3 down, stack ptr decrement 2*/
            /*Result is already in the result register*/
            CodeGen.genComment("Return statement:");

            /*Move stack pointer to frame pointer*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.TABLE_STACK_REG + ", 0("+ CodeGen.FRAME_PTR_REG + ")   Table ptr = frame ptr ");
            CodeGen.currentLine++;

            /*Restore variable stack pointer from memory*/
            CodeGen.writer.println(CodeGen.currentLine + ": LD " + CodeGen.STACK_PTR_REG + ", -1("+ CodeGen.TABLE_STACK_REG + ")   Restore stack ptr ");
            CodeGen.currentLine++;

            /*Restore frame pointer from memory*/
            CodeGen.writer.println(CodeGen.currentLine + ": LD " + CodeGen.FRAME_PTR_REG + ", -2("+ CodeGen.TABLE_STACK_REG + ")   Restore frame ptr ");
            CodeGen.currentLine++;
            /*Move stack pointer down by 3*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.TABLE_STACK_REG + ", -3("+ CodeGen.TABLE_STACK_REG + ")   Move stack ptr down ");
            CodeGen.currentLine++;

            /*Return to caller*/
            CodeGen.writer.println(CodeGen.currentLine + ": LD " + CodeGen.PC + ", 0("+ CodeGen.TABLE_STACK_REG + ")   Use return address to return ");
            CodeGen.currentLine++;
        }
        
        return returnType;
    }
    
    static private void showTree( CompoundExp tree, int spaces , boolean createNewScope) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "CompoundExp:" );
        }
        
        int initVarOffset = CodeGen.currentVariableOffset;
        /*If the new scope has not been created, create it*/
        if(createNewScope){
            theMap.newInnerScope(previousScopeName);
        }
        
        showTree( tree.decs, spaces + SPACES );

        /*Number of variables declared in this scope: newVarOffset - initVarOffset*/
        int newVarOffset;

        showTree( tree.exps, spaces + SPACES ); 
        if(showMap==true){
            theMap.printInnerScope();
        }
        
        if(createNewScope){
            theMap.deleteInnerScope();
        }

        if(compileCode == true){
            CodeGen.genComment("Inner scope non-function deallocation");
            newVarOffset = CodeGen.currentVariableOffset;
            int numberOfVars = newVarOffset - initVarOffset;
            /*Generate: Deallocate local variables (both the stack and variable table stack)*/

            if(numberOfVars > 0){
                CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.TABLE_STACK_REG + ", -" + numberOfVars + "(" + CodeGen.TABLE_STACK_REG + ")  Deallocation: Variable table in scope");
                CodeGen.currentLine++;
                CodeGen.writer.println(CodeGen.currentLine + ": LD " + CodeGen.STACK_PTR_REG + ", 0(" + CodeGen.TABLE_STACK_REG + ")  Deallocation: Scope variables");
                CodeGen.currentLine++;
            }
        }
    }
    
    static private void showTree( VarDecList tree, int spaces ) {
        if(tree!=null){
            if(showAST==true){
                indent( spaces );
                System.out.println( "VarDecList:" );
            }
            if(tree.head!=null){
                /*tree.head.typ.typ is not Identifier.type, but rather NameTy.type, so
                  convert it*/
                if(tree.head instanceof ArrayDec){
                    theList.add(new Identifier(tree.head.name, Identifier.INT_ARRAY, CodeGen.currentVariableOffset));
                }
                else if(tree.head instanceof SimpleDec){
                    switch(tree.head.typ.typ){
                        case NameTy.INT:
                            theList.add(new Identifier(tree.head.name, Identifier.INT, CodeGen.currentVariableOffset));
                            break;
                        case NameTy.VOID:
                            /*In case void vars are allowed*/
                            theList.add(new Identifier(tree.head.name, Identifier.VOID, CodeGen.currentVariableOffset));
                            break;
                    }
                }
            }
            showTree( tree.head, spaces + SPACES ); 
            showTree( tree.tail, spaces + SPACES ); 
        }
    }
    
    static private void showTree( SimpleDec tree, int spaces ) {
        /*Double declaration check*/
        if(theMap.hashMapList.peek().get(tree.name) != null){
            System.out.println("Error: Variable "+tree.name+" is already declared: line " + tree.pos);
            hasError = true;
        }
        else{
            switch(tree.typ.typ){
                case NameTy.INT:
                    theMap.insertIdentifier(new Identifier(tree.name, Identifier.INT, CodeGen.currentVariableOffset));
                    CodeGen.currentVariableOffset++;
                    break;
                case NameTy.VOID:
                    /*In case void vars are allowed*/
                    theMap.insertIdentifier(new Identifier(tree.name, Identifier.VOID, CodeGen.currentVariableOffset));
                    CodeGen.currentVariableOffset++;
                    break;
            }
        }
        
        if(showAST==true){
            indent( spaces );
            System.out.println( "SimpleDec: " + tree.name );
        }


        if(compileCode == true){
            CodeGen.genComment("Variable declaration: " + tree.name);

            /*Put a pointer to the variable in the variable table*/
            CodeGen.writer.println(CodeGen.currentLine + ": ST " + CodeGen.STACK_PTR_REG + ", 0("+ CodeGen.TABLE_STACK_REG + ")   Pointer-> Var Table ");
            CodeGen.currentLine++;

            /*Move stack pointer by 1 to allocate*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.STACK_PTR_REG + ", 1("+ CodeGen.STACK_PTR_REG + ")   Variable ");
            CodeGen.currentLine++;
            /*Move variable table stack by 1*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.TABLE_STACK_REG + ", 1("+ CodeGen.TABLE_STACK_REG + ")   Var Table ");
            CodeGen.currentLine++;
        }

        showTree( tree.typ, spaces + SPACES );
            
    }
    
    static private void showTree( ArrayDec tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "ArrayDec: " + tree.name );
        }
        
        if(theMap.hashMapList.peek().get(tree.name) != null){
            System.out.println("Error: Variable "+tree.name+" is already declared: line " + tree.pos);
            hasError = true;
        }
        else{
            theMap.insertIdentifier(new Identifier(tree.name, Identifier.INT_ARRAY, CodeGen.currentVariableOffset));
            CodeGen.currentVariableOffset++;
        }
        
        showTree( tree.typ, spaces + SPACES );
        
        /*Type is stored in memory, get into result register*/
        int arraySizeType = showTree( tree.size, spaces + SPACES );
        
        if(arraySizeType != Identifier.INT){
            System.out.println("Error: Setting array size to non-integer: line " + tree.pos);
            hasError = true;
        }
        

        if(compileCode == true){
            CodeGen.genComment("Array declaration: " + tree.name + "[" + tree.size + "]");
            /*Get allocation size*/
            CodeGen.genRecoverResult();

            /*Put a pointer to the variable in the variable table*/
            CodeGen.writer.println(CodeGen.currentLine + ": ST " + CodeGen.STACK_PTR_REG + ", 0("+ CodeGen.TABLE_STACK_REG + ")   Pointer-> Var Table ");
            CodeGen.currentLine++;
            /*Move the stack pointer by the array's length to allocate*/
            CodeGen.writer.println(CodeGen.currentLine + ": ADD " + CodeGen.STACK_PTR_REG + ", "+ CodeGen.STACK_PTR_REG + ", "+ CodeGen.RESULT_REG +"   Array Variable ");
            CodeGen.currentLine++;
            /*Move variable table stack by 1*/
            CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.TABLE_STACK_REG + ", 1("+ CodeGen.TABLE_STACK_REG + ")   Var Table alloc ");
            CodeGen.currentLine++;
        }
    }
    
    static private void showTree( VarDec tree, int spaces ) {
        if( tree instanceof SimpleDec )
            showTree((SimpleDec)tree, spaces);
        else if( tree instanceof ArrayDec )
            showTree((ArrayDec)tree, spaces);
            
            
    }
   
    static private int showTree( Var tree, int spaces ) {
        if( tree instanceof SimpleVar )
            return showTree((SimpleVar)tree,spaces);
        else if( tree instanceof IndexVar )
            return showTree((IndexVar)tree,spaces);
        
        return Identifier.VOID;
        
    }
    
    static private void showTree( FunctionDec tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "FunctionDec: " +tree.func );
        }

        /*CODEGEN NOTE: Reset currentVariableOffset*/
        
        previousScopeName = tree.func;
        currentFunction = tree.func;
        
        if (tree!=null){
            if(showMap==true){
                indent( spaces );
            }
            
            theMap.newInnerScope(previousScopeName);
            CodeGen.currentVariableOffset = 0;

            /*Type*/
            showTree( tree.result, spaces + SPACES );

            /*Record the function's start*/
            int functionStartLine = CodeGen.currentLine;
            CodeGen.currentLine++;

            /*Parameters, generates code for var declarations*/
            theList = new ArrayList<Identifier>();
            showTree( tree.params, spaces + SPACES );
            FunctionIdentifier thisFunction;
             
            if(tree.result.typ==NameTy.VOID){
               thisFunction=new FunctionIdentifier(tree.func, FunctionIdentifier.FUNCTION_VOID, CodeGen.currentLine);
                
                for(int i=0;i<theList.size();i++){
                    thisFunction.addToArgs(theList.get(i));
                }
                
            }
            
            else{
                thisFunction=new FunctionIdentifier(tree.func, FunctionIdentifier.FUNCTION_INT, CodeGen.currentLine);
                for(int i=0;i<theList.size();i++){
                    thisFunction.addToArgs(theList.get(i));
                }
                
            }
            
            /*Double declaration test*/
            if(theMap.lookup(tree.func) != null){
                System.out.println("Error: Function "+tree.func+" is already declared: line " + tree.pos);
                hasError = true;
            }
            else{
                theMap.insertIdentifier(thisFunction);
            }

            /*Function body codegen*/
            showTree( (CompoundExp)tree.body, spaces + SPACES, false );

            if(compileCode == true){
                /*Jump around the function*/
                CodeGen.writer.println(functionStartLine + ": LDC " + CodeGen.PC + ", "+ CodeGen.currentLine +", 0    Function Jump around");
            }
            theMap.deleteInnerScope();
        }
    }
    static private int showTree( SimpleVar tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "Variable: " +tree.name );
        }
        //run the type test for variable showtree
        searchResult=theMap.lookup(tree.name);
        
        if(searchResult==null){
            System.out.println("Error: variable "+tree.name+" not declared: line " + tree.pos);
            hasError = true;
            return Identifier.VOID;
        }
        else if(searchResult.getType()==Identifier.INT_ARRAY){
            System.out.println("Error: variable "+tree.name+" is an array type, not a simple variable: line " + tree.pos);
            hasError = true;
        }

        if(compileCode == true){
            /*Variable table location: offset(tableBottom)*/
            int memOffset = searchResult.getMemPosition();

            CodeGen.genComment("Variable Access: " + tree.name);
            
            if(searchResult.layersDeep == 0){
                /*1024 is the bottom, variable is at location bottom + offset*/
                CodeGen.writer.println(CodeGen.currentLine + ": LDC " + CodeGen.TEMP_REG + ", 1024, 0");
                CodeGen.currentLine++;
                /*Load pointer to variable*/
                CodeGen.writer.println(CodeGen.currentLine + ": LD " + CodeGen.RESULT_REG + ", " + memOffset + "("+ CodeGen.TEMP_REG +")    ");
                CodeGen.currentLine++;
            }
            else{
                /*Variable is at fp + offset*/
                /*Local scope: Variable pointer = frame pointer + offset*/
                CodeGen.writer.println(CodeGen.currentLine + ": LD " + CodeGen.RESULT_REG + ", " + memOffset + "("+ CodeGen.FRAME_PTR_REG +")");
                CodeGen.currentLine++;

            }

            /*RESULT_REG now contains the address of the variable*/
        }
        
        return searchResult.getType();
        
    }
    
    
    
    static private int showTree( IndexVar tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "indexed Variable: " +tree.name );
        }

        int indexType = showTree(tree.index,spaces);
        if(indexType != Identifier.INT){
            System.out.println("Error: array index may not be int type: line " + tree.pos);
            hasError = true;
        }
        
        searchResult=theMap.lookup(tree.name);
        if(searchResult==null){
            System.out.println("Error: variable "+tree.name+" not declared: line " + tree.pos);
            hasError = true;
            
            return Identifier.VOID;
        }

        if(compileCode == true){
            /*Variable location: offset(framePointer)*/
            int memOffset = searchResult.getMemPosition();

            /*Get the index from memory (stored in the result register)*/
            CodeGen.genComment("Array Access:" + tree.name);
            
            /*TABLE_STACK_REG is a pointer to the bottom of the variable table*/
            if(searchResult.layersDeep == 0){
                /*Global scope: No use of frame pointer: Variable location = offset + index
                  TEMP_REG holds offset, RESULT_REG initially holds index*/
                /*1024 is the bottom, variable is at location bottom + offset + index*/

                /*Get the index back into the operand register*/
                CodeGen.genRecoverOperand();

                CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.RESULT_REG + ", 1024(0)");
                CodeGen.currentLine++;
                /*Global scope: No use of frame pointer: Variable location = bottom + offset*/
                CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.RESULT_REG + ", " + memOffset + "("+ CodeGen.RESULT_REG +")");
                CodeGen.currentLine++;
                /*Load the data pointed by RESULT_REG into RESULT_REG*/
                CodeGen.writer.println(CodeGen.currentLine + ": LD " + CodeGen.RESULT_REG + ", 0(" + CodeGen.RESULT_REG + ")");
                CodeGen.currentLine++;
                /*Array index offset inside operand1reg, add*/
                CodeGen.writer.println(CodeGen.currentLine + ": ADD " + CodeGen.RESULT_REG + ", " + CodeGen.RESULT_REG + "," + CodeGen.OPERAND1_REG + "");
                CodeGen.currentLine++;
            }
            else{
                /*Local scope: Variable location = frame pointer - offset + index, frame pointer - offset is the array start
                  TEMP_REG holds offset, RESULT_REG initially holds index*/
                CodeGen.genRecoverOperand();

                /*Local scope: Variable location = frame pointer + offset*/
                CodeGen.writer.println(CodeGen.currentLine + ": LDA " + CodeGen.RESULT_REG + ", " + memOffset + "("+ CodeGen.FRAME_PTR_REG +")");
                CodeGen.currentLine++;
                /*Load the data pointed by RESULT_REG into RESULT_REG*/
                CodeGen.writer.println(CodeGen.currentLine + ": LD " + CodeGen.RESULT_REG + ", 0(" + CodeGen.RESULT_REG + ")");
                CodeGen.currentLine++;
                /*Array index offset inside operand1reg, add*/
                CodeGen.writer.println(CodeGen.currentLine + ": ADD " + CodeGen.RESULT_REG + ", " + CodeGen.RESULT_REG + "," + CodeGen.OPERAND1_REG + "");
                CodeGen.currentLine++;
            }
        }
        
        if(searchResult.getType() == Identifier.INT_ARRAY){
            return Identifier.INT;
        }
        else{
            return searchResult.getType();
        }
    }
    
    static private void showTree( NameTy tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            switch(tree.typ){
                case NameTy.INT:
                    System.out.println( "NameType: INT");
                    break;
                case NameTy.VOID:
                    System.out.println( "NameType: VOID");
                    break;
            }
        }
    }
    
}
