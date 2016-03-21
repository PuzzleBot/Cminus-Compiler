import absyn.*;
import java.util.*;

public class SemanticHashmap{
    public Stack<HashMap<String, Identifier>> hashMapList;

    public SemanticHashmap(){
        hashMapList = new Stack<HashMap<String, Identifier>>();
        hashMapList.push(new HashMap<String, Identifier>());
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
    
    public void printInnerScope(int scopeDepth){
        Iterator<Map.Entry<String, Identifier>> scopeIterator = hashMapList.peek().entrySet().iterator();
        Map.Entry<String, Identifier> currentEntry;
        Identifier currentIdentifier;
        
        int i;
        
        for(i = 0; i <= scopeDepth; i++){
            System.out.print("    ");
        }
        System.out.println("--Identifiers: Variable scope depth " + scopeDepth + " --");
        
        while(scopeIterator.hasNext() == true){
            currentEntry = scopeIterator.next();
            
            currentIdentifier = currentEntry.getValue();
            for(i = 0; i <= scopeDepth; i++){
                System.out.print("    ");
                System.out.println(currentIdentifier.toString());
            }
        }
    }
}