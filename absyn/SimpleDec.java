package absyn;

<<<<<<< HEAD
public abstract class SimpleDec extends VarDec{
    public NameTy typ;
    public String name;
=======
public class SimpleDec extends VarDec{
    NameTy typ;
    String name;
>>>>>>> cf25166104d05eb2c42787d52792a5710edb4fdb
    
    public SimpleDec(int pos, NameTy typ, String name){
        this.pos=pos;
        this.name=name;
        this.typ=typ;
    }
}