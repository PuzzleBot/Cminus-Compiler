import absyn.*;
import java.util.*;

public class FunctionIdentifier extends Identifier{
    private ArrayList<Identifier> args;
    
    public FunctionIdentifier(String name, int type){
        super(name, type);
        args = new ArrayList<Identifier>();
    }
    
    public void addToArgs(Identifier newArg){
        args.add(newArg);
    }
    
    public ArrayList<Identifier> getArgList(){
        return args;
    }
    
    public String toString(){
        Iterator<Identifier> argIterator = args.iterator();
        int currentType;
        String argString = "";
        
        while(argIterator.hasNext()){
            currentType = argIterator.next().getType();
            
            switch(currentType){
                case Identifier.INT:
                    argString = argString + "int";
                    break;
                case Identifier.INT_ARRAY:
                    argString = argString + "int array";
                    break;
                default:
                    break;
            }
            
            if(argIterator.hasNext()){
                argString = argString + ", ";
            }
        }
        
        if(argString.equals("")){
            argString = "No arguments";
        }
        
        switch(type){
            case INT:
                return "int " + name;
            case INT_ARRAY:
                return "int array" + name;
            case FUNCTION_INT:
                return "int function " + name + "; arguments: " + argString;
            case FUNCTION_VOID:
                return "void function " + name + "; arguments: " + argString;
            default:
                return "Error!";
        }
    }
}
