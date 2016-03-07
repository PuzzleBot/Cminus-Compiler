package absyn;

public class CompoundExp extends Exp{
    varDecList decs;
    ExpList exps;
    
    public CompoundExp(int pos, VarDecList decs, ExpList exps){
        this.pos=pos;
        this.decs=decs;
        this.exps=exps;
    }
}