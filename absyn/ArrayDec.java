package absyn;

public class ArrayDec extends VarDec{
    public IntExp size;
    
    public ArrayDec(int pos, NameTy typ, String name, IntExp size){
        this.pos=pos;
        this.typ=typ;
        this.name=name;
        this.size=size;
    }
}