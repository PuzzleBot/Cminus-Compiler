package absyn;

class DecList extends Absyn{
    Dec head;
    DecList tail;
    
    
    public DecList(Dec head,DecList tail){
    this.head=head;
    this.tail=tail;
    }
}