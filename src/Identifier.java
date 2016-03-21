import absyn.*;
import java.util.*;

public class Identifier{
    public static final int INT = 1;
    public static final int INT_ARRAY = 2;
    public static final int FUNCTION_INT = 3;
    public static final int FUNCTION_VOID = 4;
    
    protected String name;
    protected int type;

    public Identifier(String name, int type){
        this.name = name;
        this.type = type;
    }
    
    public String getName(){
        return name;
    }
    
    public int getType(){
        return type;
    }
    
    public String toString(){
        switch(type){
            case INT:
                return "int " + name;
            case INT_ARRAY:
                return "int array" + name;
            default:
                return "Error!";
        }
    }
}