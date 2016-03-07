package absyn;

public class VarDecList extends Absyn{
    VarDec head;
    VarDecList tail;
    
    public VarDecList(VarDec head, VarDecList tail){
        this.head=head;
        this.tail=tail;
    }
}