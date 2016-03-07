package absyn;

abstract class SimpleDec extends VarDeck{
    NameTy typ;
    String name;
    
    public SimpleDec(int pos, NameTy typ, String name){
    this.pos=pos;
    this.name=name;
    this.typ=typ;
    }
}