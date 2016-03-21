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
}
