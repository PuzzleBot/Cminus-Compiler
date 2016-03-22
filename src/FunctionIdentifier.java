import absyn.*;
import java.util.*;

public class FunctionIdentifier extends Identifier{
    public static final int FUNCTION_INT = 3;
    public static final int FUNCTION_VOID = 4;
    
    private ArrayList<Identifier> args;
    
    public FunctionIdentifier(String name, int type){
        super(name, type);
        args = new ArrayList<Identifier>();
    }
    
    /*Add a new argument identifier to the function's set of arguments.*/
    public void addToArgs(Identifier newArg){
        args.add(newArg);
    }
    
    /*Get the argument identifiers of the function*/
    public ArrayList<Identifier> getArgList(){
        return args;
    }
    
    /*ToString override*/
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
