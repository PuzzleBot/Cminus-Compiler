import absyn.*;
import java.util.*;

public class SemanticHashmap{
    public Stack<HashMap<String, Identifier>> hashMapList;

    public SemanticHashmap(){
        hashMapList = new Stack<HashMap<String, Identifier>>();
        hashMapList.push(new HashMap<String, Identifier>());
        
        this.insertIdentifier(new FunctionIdentifier("input", Identifier.FUNCTION_VOID));
        this.insertIdentifier(new FunctionIdentifier("output", Identifier.FUNCTION_VOID));
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
        
        for(i = 0; i < scopeDepth; i++){
            System.out.print("    ");
        }
        System.out.println("--Identifiers: Variable scope depth " + scopeDepth + " --");
        
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
        FunctionIdentifier gcdIdentifier = new FunctionIdentifier("gcd", Identifier.FUNCTION_INT);
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
