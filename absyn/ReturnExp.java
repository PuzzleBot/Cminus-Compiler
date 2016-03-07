package absyn;

abstract class ReturnExp implements Exp{
    Exp exp;
    
    public ReturnExp(int pos; Exp exp){
        this.pos=pos;
        this.exp=exp;
    }
}