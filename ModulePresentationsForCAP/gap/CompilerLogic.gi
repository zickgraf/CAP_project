CapJitAddLogicFunction( function( tree, jit_args )
  local pre_func, additional_arguments_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for HomalgMatrix." );
    
    pre_func := function( tree, func_stack )
      local args, list, func_id, ring_element, condition_func, right;
        
        # find HomalgMatrix( ... )
        if CapJitIsCallToGlobalFunction( tree, "HomalgMatrix" ) then
            
            args := tree.args;

            # check if ... = [ [ ... ], ... ]
            if args.1.type = "EXPR_LIST" then
                
                list := args.1.list;
                
                func_id := Last( func_stack).id;
                
                # check if all elements of the matrix are multiplied by the same ring element from the left
                if list.length > 0 and ForAll( list, l -> l.type = "EXPR_PROD" and l.left = list.1.left ) then
                    
                    ring_element := list.1.left;
                    
                    # check if ring_element is independent of local variables
                    condition_func := function( tree, path )
                        
                        if PositionSublist( tree.type, "FVAR" ) <> fail and tree.func_id = func_id then
                            
                            return true;
                            
                        fi;
                        
                        return false;
                        
                    end;
                    
                    if CapJitFindNodeDeep( ring_element, condition_func ) = fail then
                        
                        tree := rec(
                            type := "EXPR_PROD",
                            left := ring_element,
                            right := StructuralCopy( tree ),
                        );
                        
                        tree.right.args.1.list := List( list, l -> l.right );

                        return tree;
                        
                    fi;
                    
                fi;
                
                # check if all elements of the matrix are multiplied by the same ring element from the right
                if list.length > 0 and ForAll( list, l -> l.type = "EXPR_PROD" and l.right = list.1.right ) then
                    
                    ring_element := list.1.right;
                    
                    # check if ring_element is independent of local variables
                    condition_func := function( tree, path )
                        
                        if PositionSublist( tree.type, "FVAR" ) <> fail and tree.func_id = func_id then
                            
                            return true;
                            
                        fi;
                        
                        return false;
                        
                    end;
                    
                    if CapJitFindNodeDeep( ring_element, condition_func ) = fail then
                        
                        tree := rec(
                            type := "EXPR_PROD",
                            left := StructuralCopy( tree ),
                            right := ring_element,
                        );
                        
                        tree.left.args.1.list := List( list, l -> l.left );

                        return tree;
                        
                    fi;
                    
                fi;
                
            fi;

        fi;
            
        return tree;
        
    end;
    
    additional_arguments_func := function( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [] );
    
end );

# if IsMatrixObj( ... ) then return ...; else return ...; fi;
CapJitAddLogicTemplate( rec(
    variable_names := [ "matrix", "if_value", "else_value" ],
    variable_filters := [ IsMatrixObj, IsObject, IsObject ],
    src_template := "if IsMatrixObj( matrix ) then return if_value; else return else_value; fi;",
    dst_template := "return if_value;",
    returns_value := false,
) );

# MatElm( List( L, f ), i, j ) => List( L, f )[i][j]
CapJitAddLogicTemplate( rec(
    variable_names := [ "list", "func", "row", "col" ],
    src_template := "MatElm( List( list, func ), row, col )",
    dst_template := "List( list, func )[row][col]",
    returns_value := true,
) );

# ListN( List( list1, x -> constant ), list2, f ) => List( L, y -> f( constant, y ) )
CapJitAddLogicTemplate( rec(
    variable_names := [ "list1", "constant", "list2", "func" ],
    src_template := "ListN( List( list1, x -> constant ), list2, func )",
    dst_template := "List( list2, y -> func( constant, y ) )",
    new_funcs := [ [ "y" ] ],
    returns_value := true,
) );

# UnionOfRows( CoercedMatrix( R, S, M ) )
CapJitAddLogicTemplate( rec(
    variable_names := [ "ring2", "nr_cols", "list", "ring1", "matrix" ],
    src_template := "UnionOfRows( ring2, nr_cols, List( list, l -> CoercedMatrix( ring1, ring2, matrix ) ) )",
    dst_template := "CoercedMatrix( ring1, ring2, UnionOfRows( ring1, nr_cols, List( list, l -> matrix ) ) )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfColumns( CoercedMatrix( R, S, M ) )
CapJitAddLogicTemplate( rec(
    variable_names := [ "ring2", "nr_rows", "list", "ring1", "matrix" ],
    src_template := "UnionOfColumns( ring2, nr_rows, List( list, l -> CoercedMatrix( ring1, ring2, matrix ) ) )",
    dst_template := "CoercedMatrix( ring1, ring2, UnionOfColumns( ring1, nr_rows, List( list, l -> matrix ) ) )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfRows( CoefficientsWithGivenMonomials )
CapJitAddLogicTemplate( rec(
    variable_names := [ "ring", "nr_cols", "list", "matrix", "monomials" ],
    variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
    src_template := "UnionOfRows( ring, nr_cols, List( list, l -> CoefficientsWithGivenMonomials( matrix, monomials ) ) )",
    dst_template := "CoefficientsWithGivenMonomials( UnionOfRows( ring, NrCols( monomials ), List( list, l -> matrix ) ), monomials )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfColumns( CoefficientsWithGivenMonomials )
CapJitAddLogicTemplate( rec(
    variable_names := [ "ring", "nr_rows", "list", "matrix", "monomials" ],
    variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
    src_template := "UnionOfColumns( ring, nr_rows, List( list, l -> CoefficientsWithGivenMonomials( matrix, monomials ) ) )",
    dst_template := "CoefficientsWithGivenMonomials( UnionOfColumns( ring, nr_rows, List( list, l -> matrix ) ), DiagMat( List( list, x -> monomials ) ) )",
    new_funcs := [ [ "x" ] ],
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfRows( a * B )
CapJitAddLogicTemplate( rec(
    variable_names := [ "homalg_ring", "nr_cols", "list", "ring_element", "matrix" ],
    variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgRingElement", "IsHomalgMatrix" ],
    src_template := "UnionOfRows( homalg_ring, nr_cols, List( list, l -> ring_element * matrix ) )",
    dst_template := "ring_element * UnionOfRows( homalg_ring, nr_cols, List( list, l -> matrix ) )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfRows( A * b )
CapJitAddLogicTemplate( rec(
    variable_names := [ "homalg_ring", "nr_cols", "list", "matrix", "ring_element" ],
    variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgRingElement" ],
    src_template := "UnionOfRows( homalg_ring, nr_cols, List( list, l -> matrix * ring_element ) )",
    dst_template := "UnionOfRows( homalg_ring, nr_cols, List( list, l -> matrix ) ) * ring_element",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfColumns( a * B )
CapJitAddLogicTemplate( rec(
    variable_names := [ "homalg_ring", "nr_rows", "list", "ring_element", "matrix" ],
    variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgRingElement", "IsHomalgMatrix" ],
    src_template := "UnionOfColumns( homalg_ring, nr_rows, List( list, l -> ring_element * matrix ) )",
    dst_template := "ring_element * UnionOfColumns( homalg_ring, nr_rows, List( list, l -> matrix ) )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# UnionOfColumns( A * b )
CapJitAddLogicTemplate( rec(
    variable_names := [ "homalg_ring", "nr_rows", "list", "matrix", "ring_element" ],
    variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgRingElement" ],
    src_template := "UnionOfColumns( homalg_ring, nr_rows, List( list, l -> matrix * ring_element ) )",
    dst_template := "UnionOfColumns( homalg_ring, nr_rows, List( list, l -> matrix ) ) * ring_element",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );

# DualKroneckerMat( A, B )
CapJitAddLogicTemplate( rec(
    variable_names := [ "ring", "nr_cols", "nr_rows", "matrix1", "matrix2" ],
    variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
    src_template := """
        UnionOfRows( ring, nr_cols, List( [ 1 .. NrRows( matrix2 ) ], i ->
            UnionOfColumns( ring, nr_rows, List( [ 1 .. NrColumns( matrix2 ) ], j ->
                matrix1 * matrix2[i,j]
            ) )
        ) )
    """,
    dst_template := "DualKroneckerMat( matrix1, matrix2 )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.06.27" ] ],
) );

# KroneckerMat( TransposedMatrix( A ), B )
CapJitAddLogicTemplate( rec(
    variable_names := [ "ring", "nr_cols", "nr_rows", "matrix1", "matrix2" ],
    variable_filters := [ IsObject, IsObject, IsObject, "IsHomalgMatrix", "IsHomalgMatrix" ],
    src_template := """
        UnionOfRows( ring, nr_cols, List( [ 1 .. NrColumns( matrix1 ) ], j ->
            UnionOfColumns( ring, nr_rows, List( [ 1 .. NrRows( matrix1 ) ], i ->
                matrix1[i,j] * matrix2
            ) )
        ) )
    """,
    dst_template := "KroneckerMat( TransposedMatrix( matrix1 ), matrix2 )",
    returns_value := true,
    needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
) );
