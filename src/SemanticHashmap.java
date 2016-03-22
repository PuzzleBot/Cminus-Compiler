import absyn.*;
import java.util.*;

public class SemanticHashmap{
    public Stack<HashMap<String, Identifier>> hashMapList;

    public SemanticHashmap(){
        hashMapList = new Stack<HashMap<String, Identifier>>();
        hashMapList.push(new HashMap<String, Identifier>());
        
        this.insertIdentifier(new FunctionIdentifier("input", FunctionIdentifier.FUNCTION_VOID));
        this.insertIdentifier(new FunctionIdentifier("output", FunctionIdentifier.FUNCTION_VOID));
    }
    
    public void insertIdentifier(Identifier newIdentifier){
        /*Put the new identifier into the innermost scope*/
        hashMapList.peek().put(newIdentifier.getName(), newIdentifier);
    }
    
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
    
    public void newInnerScope(){
        hashMapList.push(new HashMap<String, Identifier>());
    }
    
    public void deleteInnerScope(){
        HashMap<String, Identifier> deletedScope = hashMapList.pop();
    }
    
    public void printInnerScope(){
        Iterator<Map.Entry<String, Identifier>> scopeIterator = hashMapList.peek().entrySet().iterator();
        Map.Entry<String, Identifier> currentEntry;
        Identifier currentIdentifier;
        int scopeDepth = hashMapList.size();
        
        int i;
        
        while(scopeIterator.hasNext() == true){
            currentEntry = scopeIterator.next();
            
            currentIdentifier = currentEntry.getValue();
            for(i = 0; i < scopeDepth; i++){
                System.out.print("    ");
            }
            System.out.println(currentIdentifier.toString());
        }
    }
    
    /*Test main*/
    public static void main(String args[]){
        SemanticHashmap symbolTable = new SemanticHashmap();
        FunctionIdentifier gcdIdentifier = new FunctionIdentifier("gcd", FunctionIdentifier.FUNCTION_INT);
        gcdIdentifier.addToArgs(new Identifier("x", Identifier.INT));
        gcdIdentifier.addToArgs(new Identifier("y", Identifier.INT));
        
        symbolTable.insertIdentifier(gcdIdentifier);
        symbolTable.insertIdentifier(new Identifier("globalX", Identifier.INT));
        
        symbolTable.newInnerScope();
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
