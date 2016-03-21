import absyn.*;
import java.util.*;

public class Identifier{
    public static final int INT = 1;
    public static final int INT_ARRAY = 2;
    public static final int FUNCTION_INT = 3;
    public static final int FUNCTION_VOID = 4;
    
    public String name;
    public int type;

    public Identifier(String name, int type){
        this.name = name;
        this.type = type;
    }
}