package absyn;

public class NameTy extends Absyn{
    int typ;
    
    public NameTy(int pos, int typ){
        this.pos=pos;
        this.typ=typ;
    }
}