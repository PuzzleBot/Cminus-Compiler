package symtable;

import absyn.*;
import java.util.*;

public class SemanticHashmap{
    public Stack<HashMap<String, Identifier>> hashMapList;
    public Stack<String> scopeNames;

    /*Constructor for a new syntax table. Automatically declares int input() and void output(int x).*/
    public SemanticHashmap(){
        hashMapList = new Stack<HashMap<String, Identifier>>();
        scopeNames = new Stack<String>();
        
        hashMapList.push(new HashMap<String, Identifier>());
        this.newInnerScope("global");
        
        FunctionIdentifier inputIdentifier = new FunctionIdentifier("input", FunctionIdentifier.FUNCTION_INT);
        FunctionIdentifier outputIdentifier = new FunctionIdentifier("output", FunctionIdentifier.FUNCTION_VOID);
        outputIdentifier.addToArgs(new Identifier("x", Identifier.INT));
        
        this.insertIdentifier(inputIdentifier);
        this.insertIdentifier(outputIdentifier);
    }
    
    /*Insert (declare) a new identifier in the symbol table, with its type.*/
    public void insertIdentifier(Identifier newIdentifier){
        /*Put the new identifier into the innermost scope (or put it in the global scope
          if its a function)*/
        if(newIdentifier instanceof FunctionIdentifier){
            hashMapList.get(0).put(newIdentifier.getName(), newIdentifier);
        }
        else{
            hashMapList.peek().put(newIdentifier.getName(), newIdentifier);
        }
    }
    
    /*Look for an identifier with the matching name, prioritizing identifiers in the
      most inner scope.*/
    public Identifier lookup(String identifierName){
        Identifier matchingIdentifier;
        int i;
        
        /*The top of the stack is at the end for some reason*/
        for(i = hashMapList.size() - 1; i >= 0; i--){
            matchingIdentifier = hashMapList.get(i).get(identifierName);
            
            if(matchingIdentifier != null){
                return matchingIdentifier;
            }
        }
        
        return null;
    }
    
    /*Check if the innermost identifier with the matching name has the given type/return type.*/
    public boolean typeCheck(String identifierName, int type){
        /*Type may only be Identifier.INT, Identifier.INT_ARRAY or Identifier.VOID*/
        Identifier theIdentifier = this.lookup(identifierName);
        
        if(theIdentifier.getType() == type){
            return true;
        }
        else{
            return false;
        }
    }
    
    /*Check if the innermost identifier with the matching name is a function and
      has the given number of arguments*/
    public boolean functionArgCheck(String identifierName, ArrayList<Integer> argTypes){
        /*argTypes is an arraylist of integers containing the types of the given arguments,
          in order*/
        Identifier theIdentifier = this.lookup(identifierName);
        
        if(theIdentifier instanceof FunctionIdentifier){
            FunctionIdentifier theFunction = (FunctionIdentifier)theIdentifier;
            ArrayList<Identifier> functionArgs = theFunction.getArgList();
            
            if(functionArgs.size() != argTypes.size()){
                /*Mismatching number of args test*/
                return false;
            }
            else{
                int i;
                int numberOfArgs = argTypes.size();
                
                for(i = 0; i < numberOfArgs; i++){
                    /*Mismatching type test*/
                    if(functionArgs.get(i).getType() != argTypes.get(i)){
                        return false;
                    }
                }
            }
        }
        else{
            return false;
        }
        
        /*Pass all type comparisons - accept*/
        return true;
    }
    
    /*Create a new scope inside the current scope*/
    public void newInnerScope(String scopeName){
        hashMapList.push(new HashMap<String, Identifier>());
        scopeNames.push(scopeName);
    }
    
    /*Exit the innermost scope*/
    public void deleteInnerScope(){
        HashMap<String, Identifier> deletedScope = hashMapList.pop();
        String deletedScopeName = scopeNames.pop();
    }
    
    /*Print all identifiers local to the current scope*/
    public void printInnerScope(){
        Iterator<Map.Entry<String, Identifier>> scopeIterator = hashMapList.peek().entrySet().iterator();
        Map.Entry<String, Identifier> currentEntry;
        Identifier currentIdentifier;
        int scopeDepth = hashMapList.size();
        
        int i;
        
        
        for(i = 0; i < scopeDepth; i++){
            System.out.print("    ");
        }
        System.out.println("Variables inside \"" + scopeNames.peek() + "\":");
        
        while(scopeIterator.hasNext() == true){
            currentEntry = scopeIterator.next();
            
            currentIdentifier = currentEntry.getValue();
            for(i = 0; i < scopeDepth; i++){
                System.out.print("    ");
            }
            System.out.println("  " + currentIdentifier.toString());
        }
        
        for(i = 0; i < scopeDepth; i++){
            System.out.print("    ");
        }
        System.out.println("Leaving \"" + scopeNames.peek() + "\"");
    }
    
    /*Test main*/
    public static void main(String args[]){
        SemanticHashmap symbolTable = new SemanticHashmap();
        FunctionIdentifier gcdIdentifier = new FunctionIdentifier("gcd", FunctionIdentifier.FUNCTION_INT);
        gcdIdentifier.addToArgs(new Identifier("x", Identifier.INT));
        gcdIdentifier.addToArgs(new Identifier("y", Identifier.INT));
        
        symbolTable.insertIdentifier(gcdIdentifier);
        symbolTable.insertIdentifier(new Identifier("globalX", Identifier.INT));
        
        symbolTable.newInnerScope("gcd");
        symbolTable.insertIdentifier(new Identifier("varX", Identifier.INT));
        symbolTable.insertIdentifier(new Identifier("varY", Identifier.INT));
        
        Identifier globalIDtest = symbolTable.lookup("globalX");
        if(globalIDtest == null){
            System.out.println("globalX not accessible! (fail)");
        }
        else{
            System.out.println("globalX is accessible! (pass)");
        }
        
        globalIDtest = symbolTable.lookup("globalY");
        if(globalIDtest == null){
            System.out.println("globalY not accessible! (pass)");
        }
        else{
            System.out.println("globalY is accessible! (fail)");
        }
        
        boolean isInt = symbolTable.typeCheck("globalX", Identifier.INT);
        if(isInt == true){
            System.out.println("globalX is an int! (pass)");
        }
        else{
            System.out.println("globalX is not an int! (fail)");
        }
        
        boolean isVoid = symbolTable.typeCheck("globalX", Identifier.VOID);
        if(isVoid == true){
            System.out.println("globalX is a void! (fail)");
        }
        else{
            System.out.println("globalX is not a void! (pass)");
        }
        
        symbolTable.printInnerScope();
        symbolTable.deleteInnerScope();
        
        Identifier scopedIDtest = symbolTable.lookup("varX");
        if(scopedIDtest == null){
            System.out.println("varX not accessible! (pass)");
        }
        else{
            System.out.println("varX is accessible! (fail)");
        }
        
        symbolTable.printInnerScope();
        symbolTable.deleteInnerScope();
    }
}
