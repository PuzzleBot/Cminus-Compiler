package absyn;

abstract public class Absyn {
    public int pos;

    final static int SPACES = 4;

    static private void indent( int spaces ) {
        for( int i = 0; i < spaces; i++ ) System.out.print( " " );
    }

    static public void showTree( ExpList tree, int spaces ) {
        while( tree != null ) {
            showTree( tree.head, spaces );
            tree = tree.tail;
        } 
    }

    static private void showTree( Exp tree, int spaces ) {
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
        else {
            indent( spaces );
            System.out.println( "Illegal expression at line " + tree.pos  );
        }
    }

    static private void showTree( AssignExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "AssignExp:" );
        spaces += SPACES;
        showTree( tree.lhs, spaces );
        showTree( tree.rhs, spaces );
    }

    static private void showTree( IfExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "IfExp:" );
        spaces += SPACES;
        showTree( tree.test, spaces );
        showTree( tree.thenpart, spaces );
        showTree( tree.elsepart, spaces );
    }

    static private void showTree( IntExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "IntExp: " + tree.value ); 
    }

    static private void showTree( OpExp tree, int spaces ) {
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
                System.out.println( " = " );
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
        spaces += SPACES;
        showTree( tree.left, spaces );
        showTree( tree.right, spaces ); 
    }

    static private void showTree( ReadExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "ReadExp:" );
        showTree( tree.input, spaces + SPACES );  
    }

    static private void showTree( RepeatExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "RepeatExp:" );
        spaces += SPACES;
        showTree( tree.exps, spaces );
        showTree( tree.test, spaces ); 
    }

    static private void showTree( VarExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "VarExp: " + tree.name );
          showTree( tree.variable, spaces );
    }
    
    static private void showTree( NilExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "NilExp:" );
    }
    
    static private void showTree( CallExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "CallExp:" );
        showTree( tree.args, spaces + SPACES );
        
    }
    
    
    static private void showTree( WhileExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "WhileExp:" );
        showTree( tree.test, spaces + SPACES ); 
        showTree( tree.body, spaces + SPACES ); 
    }
    
    static private void showTree( ReturnExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "ReturnExp:" );
        showTree( tree.exp, spaces + SPACES ); 
    }
    
    static private void showTree( CompoundExp tree, int spaces ) {
        indent( spaces );
        System.out.println( "CompoundExp:" );
        showTree( tree.decs, spaces + SPACES ); 
        showTree( tree.exps, spaces + SPACES ); 
    }
    
    static private void showTree( VarDecList tree, int spaces ) {
        indent( spaces );
        System.out.println( "VarDecList:" );
        showTree( tree.head, spaces + SPACES ); 
        showTree( tree.tail, spaces + SPACES ); 
    }
    
    static private void showTree( SimpleDec tree, int spaces ) {
        indent( spaces );
        System.out.println( "SimpleDec:" );
        System.out.println( tree.typ+" "+tree.name );
    }
    
    static private void showTree( ArrayDec tree, int spaces ) {
        indent( spaces );
        System.out.println( "ArrayDec:" );
        System.out.println( tree.typ+" "+tree.name );
        showTree( tree.size, spaces + SPACES ); 
    }
    
    static private void showTree( VarDec tree, int spaces ) {
        indent( spaces );
        System.out.println( "VarDec:" );
    }
   
    
}
