package absyn;

public class WhileExp implents Exp{
    Exp test;
    Exp body;
    
    public WhileExp(int pos; Exp test; Exp body){
        this.pos=pos;
        this.test=test;
        this.body=body;
    }
}