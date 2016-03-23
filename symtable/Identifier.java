package symtable;

import absyn.*;
import java.util.*;

public class Identifier{
    public static final int VOID = 0;
    public static final int INT = 1;
    public static final int INT_ARRAY = 2;
    
    protected String name;
    protected int type;

    public Identifier(String name, int type){
        this.name = name;
        this.type = type;
    }
    
    /*Get methods*/
    public String getName(){
        return name;
    }
    
    public int getType(){
        return type;
    }
    
    /*ToString override*/
    public String toString(){
        switch(type){
            case INT:
                return "int " + name;
            case INT_ARRAY:
                return "int array " + name;
            case VOID:
                return "void " + name;
            default:
                return "Error!";
        }
    }
    
    public static String typeToString(int type){
        switch(type){
            case VOID:
                return "VOID";
            case INT:
                return "INT";
            case INT_ARRAY:
                return "INT ARRAY";
            default:
                return "UNKNOWN";
        }
    }
}