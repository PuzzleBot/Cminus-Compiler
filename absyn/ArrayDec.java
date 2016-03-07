package absyn;

abstract class ArrayDec extends VarDeck{
    NameTY typ;
    String name;
    IntExp size;
    
    public ArrayDec(int pos, NameTy typ, String name, IntExp size){
    this.pos=pos;
    this.typ=typ;
    this.name=name;
    this.size=size;
    }
}