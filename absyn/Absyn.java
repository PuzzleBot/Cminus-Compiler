package absyn;
import symtable.*;
import java.util.*;
abstract public class Absyn {
    public int pos;

    final static int SPACES = 4;
    public static SemanticHashmap theMap;
    public static boolean showMap = true;
    public static boolean showAST = true;
    public static ArrayList <Identifier> theList;
    
    public static String previousScopeName = "noScope";
    
    static private void indent( int spaces ) {
        for( int i = 0; i < spaces; i++ ) System.out.print( " " );
    }
    
    static public void startTraversal( DecList tree ){
        theMap = new SemanticHashmap();
        
        showTree( tree, 0 );
        
        if(showMap==true){
            theMap.printInnerScope();
        }
    }

    static public void showTree( ExpList tree, int spaces ) {
        while( tree != null ) {
            showTree( tree.head, spaces );
            tree = tree.tail;
        } 
    }
    
    static public void showTree( DecList tree, int spaces ) {
        
        while( tree != null ) {
            showTree( tree.head, spaces );
            tree = tree.tail;
        }
    }

    static private void showTree( Exp tree, int spaces ) {
        if(tree!=null){
            if( tree instanceof AssignExp )
                showTree( (AssignExp)tree, spaces );
            else if( tree instanceof IfExp )
                showTree( (IfExp)tree, spaces );
            else if( tree instanceof IntExp )
                showTree( (IntExp)tree, spaces );
            else if( tree instanceof OpExp )
                showTree( (OpExp)tree, spaces );
            else if( tree instanceof ReadExp )
                showTree( (ReadExp)tree, spaces );
            else if( tree instanceof RepeatExp )
                showTree( (RepeatExp)tree, spaces );
            else if( tree instanceof VarExp )
                showTree( (VarExp)tree, spaces );
            else if( tree instanceof WriteExp ) 
                showTree( (WriteExp)tree, spaces );
            else if( tree instanceof NilExp ) 
                showTree( (NilExp)tree, spaces );
            else if( tree instanceof CallExp ) 
                showTree( (CallExp)tree, spaces );
            else if( tree instanceof WhileExp ) 
                showTree( (WhileExp)tree, spaces );
            else if( tree instanceof ReturnExp ) 
                showTree( (ReturnExp)tree, spaces );
            else if( tree instanceof CompoundExp ) 
                showTree( (CompoundExp)tree, spaces, true );
    
            else {
                indent( spaces );
                System.out.println( "Illegal expression at line " + tree.pos);
            }
        }else{
            if(showAST==true){
                System.out.println("null expression");
            }
        }
    }

    static private void showTree( AssignExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "AssignExp:" );
        }
        spaces += SPACES;
        showTree( tree.lhs, spaces );
        showTree( tree.rhs, spaces );
    }

    static private void showTree( IfExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "IfExp:" );
        }
        previousScopeName = "if";
        
        spaces += SPACES;
        showTree( tree.test, spaces );
        showTree( tree.thenpart, spaces );
        if(tree.elsepart!=null){
            previousScopeName = "else";
            showTree( tree.elsepart, spaces );
        }
    }

    static private void showTree( IntExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "IntExp: " + tree.value );
        }
    }

    static private void showTree( OpExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.print( "OpExp:" );
 
            switch( tree.op ) {
                case OpExp.PLUS:
                    System.out.println( " + " );
                    break;
                case OpExp.MINUS:
                    System.out.println( " - " );
                    break;
                case OpExp.MULT:
                    System.out.println( " * " );
                    break;
                case OpExp.DIV:
                    System.out.println( " / " );
                    break;
                case OpExp.EQ:
                    System.out.println( " == " );
                    break;
                case OpExp.LT:
                    System.out.println( " < " );
                    break;
                case OpExp.LE:
                    System.out.println( " <= " );
                    break;
                case OpExp.GE:
                    System.out.println( " >= " );
                    break;
                case OpExp.NE:
                    System.out.println( " != " );
                    break;
                default:
                    System.out.println( "Unrecognized operator at line " + tree.pos);
            }
        }
        spaces += SPACES;
        showTree( tree.left, spaces );
        showTree( tree.right, spaces ); 
    }

    static private void showTree( ReadExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "ReadExp:" );
        }
        showTree( tree.input, spaces + SPACES );  
    }
    
    static private void showTree( Dec tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "Dec:" );
        }
        if (tree!=null){
            if( tree instanceof ArrayDec )
                showTree( (ArrayDec)tree, spaces );
            else if( tree instanceof SimpleDec )
                showTree( (SimpleDec)tree, spaces );
            else if( tree instanceof FunctionDec )
                showTree( (FunctionDec)tree, spaces );
            
        }
    }

    static private void showTree( RepeatExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "RepeatExp:" );
        }
        spaces += SPACES;
        showTree( tree.exps, spaces );
        showTree( tree.test, spaces ); 
    }

    static private void showTree( VarExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "VarExp: ");
        }
        showTree( tree.name, spaces );
    }
    
    static private void showTree( NilExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "NilExp:" );
        }
    }
    
    static private void showTree( CallExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "CallExp: " +tree.func );
        }
        
        
        showTree( tree.args, spaces + SPACES );
        
    }
    
    
    static private void showTree( WhileExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "WhileExp:" );
        }
        showTree( tree.test, spaces + SPACES ); 
        showTree( tree.body, spaces + SPACES ); 
    }
    
    static private void showTree( ReturnExp tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "ReturnExp:" );
        }
        showTree( tree.exp, spaces + SPACES ); 
    }
    
    static private void showTree( CompoundExp tree, int spaces , boolean createNewScope) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "CompoundExp:" );
        }
        
        if(showMap==true){
            //System.out.println("entering new scope");
        }
        
        /*If the new scope has not been created, create it*/
        if(createNewScope){
            theMap.newInnerScope(previousScopeName);
        }
        
        showTree( tree.decs, spaces + SPACES ); 
        showTree( tree.exps, spaces + SPACES ); 
        if(showMap==true){
            theMap.printInnerScope();
        }
        
        if(createNewScope){
            theMap.deleteInnerScope();
        }
    }
    
    static private void showTree( VarDecList tree, int spaces ) {
        if(tree!=null){
            if(showAST==true){
                indent( spaces );
                System.out.println( "VarDecList:" );
            }
            if(tree.head!=null){
                /*tree.head.typ.typ is not Identifier.type, but rather NameTy.type*/
                if(tree.head instanceof ArrayDec){
                    theList.add(new Identifier(tree.head.name, Identifier.INT_ARRAY));
                }
                else if(tree.head instanceof SimpleDec){
                    switch(tree.head.typ.typ){
                        case NameTy.INT:
                            theList.add(new Identifier(tree.head.name, Identifier.INT));
                            break;
                        case NameTy.VOID:
                            /*In case void vars are allowed*/
                            theList.add(new Identifier(tree.head.name, Identifier.VOID));
                            break;
                    }
                }
                
                //theList.add(new Identifier(tree.head.name, tree.head.typ.typ));
            }
            showTree( tree.head, spaces + SPACES ); 
            showTree( tree.tail, spaces + SPACES ); 
        }
    }
    
    static private void showTree( SimpleDec tree, int spaces ) {
        theMap.insertIdentifier(new Identifier(tree.name, Identifier.INT));
        if(showAST==true){
            indent( spaces );
            System.out.println( "SimpleDec: " + tree.name );
        }
        showTree( tree.typ, spaces + SPACES );
            
    }
    
    static private void showTree( ArrayDec tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "ArrayDec: " + tree.name );
        }
        theMap.insertIdentifier(new Identifier(tree.name,Identifier.INT_ARRAY));
        showTree( tree.typ, spaces + SPACES );
        showTree( tree.size, spaces + SPACES ); 
    }
    
    static private void showTree( VarDec tree, int spaces ) {
        if( tree instanceof SimpleDec )
            showTree((SimpleDec)tree, spaces);
        else if( tree instanceof ArrayDec )
            showTree((ArrayDec)tree, spaces);
            
            
    }
   
    static private void showTree( Var tree, int spaces ) {
        if( tree instanceof SimpleVar )
            showTree((SimpleVar)tree,spaces);
        else if( tree instanceof IndexVar )
            showTree((IndexVar)tree,spaces);
        
    }
    
    static private void showTree( FunctionDec tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "FunctionDec: " +tree.func );
        }
        
        previousScopeName = tree.func;
        
        if (tree!=null){
            if(showMap==true){
                indent( spaces );
                //System.out.println("entering new scope");
            }
            
            theMap.newInnerScope(previousScopeName);
            showTree( tree.result, spaces + SPACES );
            
            theList = new ArrayList<Identifier>();
            showTree( tree.params, spaces + SPACES );
            FunctionIdentifier thisFunction;
             
             
            if(tree.result.typ==NameTy.VOID){
               thisFunction=new FunctionIdentifier(tree.func,FunctionIdentifier.FUNCTION_VOID);
                
                for(int i=0;i<theList.size();i++){
                    thisFunction.addToArgs(theList.get(i));
                }
                
            }
            
            else{
                thisFunction=new FunctionIdentifier(tree.func,FunctionIdentifier.FUNCTION_INT);
                for(int i=0;i<theList.size();i++){
                    thisFunction.addToArgs(theList.get(i));
                }
                
            }
            

            showTree( (CompoundExp)tree.body, spaces + SPACES, false );
            if(showMap==true){
                //theMap.printInnerScope();
            }
            theMap.deleteInnerScope();
            theMap.insertIdentifier(thisFunction);
        }
    }
    static private void showTree( SimpleVar tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "Variable: " +tree.name );
        }
    }
    static private void showTree( IndexVar tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            System.out.println( "indexed Variable: " +tree.name );
        }
        showTree(tree.index,spaces);
    }
    
    static private void showTree( NameTy tree, int spaces ) {
        if(showAST==true){
            indent( spaces );
            switch(tree.typ){
                case NameTy.INT:
                    System.out.println( "NameType: INT");
                    break;
                case NameTy.VOID:
                    System.out.println( "NameType: VOID");
                    break;
            }
        }
    }
    
}
