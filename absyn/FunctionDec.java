package absyn;

public class FunctionDec extends Dec{
    NameTy result;
    String func;
    VarDecList params;
    CompountEXP body;
    
    public FunctionDec(int pos, NameTy result, String func, varDecList parmas, CompundExp body){
    this.pos=pos;
    this.result=result;
    this.func=func;
    this.params=params;
    this.body=body;
    }
}