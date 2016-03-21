package absyn;

public class FunctionDec extends Dec{
    public VarDecList params;
    public CompoundExp body;
    public NameTy result;
    public String func;

    public FunctionDec(int pos, NameTy result, String func, VarDecList params, CompoundExp body){
        this.pos=pos;
        this.result=result;
        this.func=func;
        this.params=params;
        this.body=body;
    }
}