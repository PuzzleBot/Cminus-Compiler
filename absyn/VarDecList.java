package absyn;

public class VarDeckList extends absyn{
    VarDec head;
    VarDecList tail;
    
    public VarDeckList(VarDeck head, VarDecList tail){
    this.head=head;
    this.tail=tail;
    }
}