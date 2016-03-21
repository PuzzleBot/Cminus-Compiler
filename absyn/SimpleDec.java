package absyn;

public class SimpleDec extends VarDec{
    
    public SimpleDec(int pos, NameTy typ, String name){
        this.pos=pos;
        this.name=name;
        this.typ=typ;
        
        System.out.println("Storing name: " + this.name);
    }
}