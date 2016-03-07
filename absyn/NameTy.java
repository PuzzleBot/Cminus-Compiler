package absyn;

public class NameTy extends Absyn{
    int typ;
    
    public static final int NameTy.INT = 0;
    public static final int NameTy.VOID = 1;
    
    public NameTy(int pos, int typ){
        this.pos=pos;
        this.typ=typ;
    }
}