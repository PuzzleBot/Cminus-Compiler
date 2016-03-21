import absyn.*;
import java.util.*;

public class SemanticHashmap{
    public Stack<HashMap<String, Identifier>> hashMapList;

    public SemanticHashmap(){
        hashMapList = new Stack<HashMap<String, Identifier>>();
    }
    
    public void insert(Identifier newIdentifier){
        
    }
    
    public Identifier lookup(String identifierName){
        return hashMapList.peek().get(identifierName);
    }
    
    public void deleteInnerScope(){
        
    }
}