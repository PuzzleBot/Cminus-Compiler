package absyn;

public abstract class Dec extends Absyn{
    public VarDecList params;
    public CompoundExp body;
    public int pos;
    public NameTy result;
    public String func;
}