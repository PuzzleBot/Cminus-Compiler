package absyn;

public class ExpList extends absyn{
  public Exp head;
  public ExpList tail;
  public ExpList( Exp head, ExpList tail ) {
    this.head = head;
    this.tail = tail;
  }
}
