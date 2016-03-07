package absyn;

public class callExp extends Exp{
    String func;
    EXPList args;
    
    public CallExp(int pos, String func, ExpList args){
        this.pos=pos;
        this.func=func;
        this.args=args;
    }
}