# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
BindGlobal( "CAP_JIT_LOGIC_FUNCTIONS", [ ] );

InstallGlobalFunction( CapJitAddLogicFunction, function ( func )
    
    if not IsFunction( func ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic function must be a function" );
        
    fi;
    
    if NumberArgumentsFunction( func ) <> 1 then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic function must have exactly one argument" );
        
    fi;
    
    Add( CAP_JIT_LOGIC_FUNCTIONS, func );
    
end );

InstallGlobalFunction( CapJitAppliedLogic, function ( tree )
  local logic_function;
    
    for logic_function in CAP_JIT_LOGIC_FUNCTIONS do
        
        tree := logic_function( tree );
        
    od;
    
    tree := CapJitAppliedLogicTemplates( tree );
    
    return tree;
    
end );

# [ int1 .. int2 ] = [ int1, ..., int2 ]
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for ranges with known boundaries." );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_RANGE" and tree.first.type = "EXPR_INT" and tree.last.type = "EXPR_INT" then
            
            return rec(
                type := "EXPR_LIST",
                data_type := CapJitDataTypeOfListOf( IsInt ),
                list := AsSyntaxTreeList( List(
                    [ tree.first.value .. tree.last.value ],
                    int -> rec(
                        type := "EXPR_INT",
                        value := int,
                    )
                ) ),
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# [ a_1, a_2, ... ][i] => a_i
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for accessing elements of literal lists." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "[]" ) and tree.args.1.type = "EXPR_LIST" and tree.args.2.type = "EXPR_INT" then
            
            return tree.args.1.list.(tree.args.2.value);
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Last( [ a_1, ..., a_n ] ) => a_n
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for accessing the last element of a literal list." );
    
    pre_func := function ( tree, additional_arguments )
        
        if CapJitIsCallToGlobalFunction( tree, "Last" ) and tree.args.1.type = "EXPR_LIST" then
            
            return tree.args.1.list.(tree.args.1.list.length);
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# NTuple( n, a_1, ..., a_n )[i] => a_i
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for accessing elements of tuples." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "[]" ) and CapJitIsCallToGlobalFunction( tree.args.1, "NTuple" ) then
            
            if tree.args.2.type <> "EXPR_INT" then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "You should only access tuples via literal integers." );
                
            fi;
            
            return tree.args.1.args.(tree.args.2.value + 1);
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# a = b?
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for equality." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if tree.type = "EXPR_EQ" and tree.left.type = tree.right.type then
            
            if CapJitIsEqualForEnhancedSyntaxTrees( tree.left, tree.right ) then
                
                return rec( type := "EXPR_TRUE" );
                
            # for integers, strings, and chars we can also decide inequality
            elif tree.left.type = "EXPR_INT" or tree.left.type = "EXPR_STRING" or tree.left.type = "EXPR_CHAR" then
                
                # CAUTION: One value might have a data type set and the other not -> they might differ with regard to `CapJitIsEqualForEnhancedSyntaxTrees`
                # despite having equal values. Hence, to decide inequality we have to explicitly check the values again.
                if tree.left.value = tree.right.value then
                    
                    return rec( type := "EXPR_TRUE" );
                    
                else
                    
                    return rec( type := "EXPR_FALSE" );
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Length( [ a_1, ..., a_n ] ) => n
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for Length of literal lists." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "Length" ) and tree.args.length = 1 and tree.args.1.type = "EXPR_LIST" then
            
            return rec(
                type := "EXPR_INT",
                value := tree.args.1.list.length,
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Length( Concatenation( ... ) ) => Sum( ... )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for Length of a Concatenation." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "Length" ) and tree.args.length = 1 and CapJitIsCallToGlobalFunction( tree.args.1, "Concatenation" ) then
            
            args := tree.args.1.args;
            
            if args.length = 0 then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "`Concatenation` with zero arguments is not supported by CompilerForCAP" );
                
            elif args.length = 1 then
                
                # Length( Concatenation( list ) ) -> Sum( List( list, Length ) )
                
                tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "Sum",
                    ),
                    args := AsSyntaxTreeList( [
                        rec(
                            type := "EXPR_FUNCCALL",
                            funcref := rec(
                                type := "EXPR_REF_GVAR",
                                gvar := "List",
                            ),
                            args := AsSyntaxTreeList( [
                                args.1,
                                rec(
                                    type := "EXPR_REF_GVAR",
                                    gvar := "Length",
                                ),
                            ] ),
                        ),
                    ] ),
                );
                
            else
                
                Assert( 0, args.length > 1 );
                
                # Length( Concatenation( list1, list2, ... ) ) -> Sum( [ Length( list1 ), Length( list2 ), ... ] )
                
                tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "Sum",
                    ),
                    args := AsSyntaxTreeList( [
                        rec(
                            type := "EXPR_LIST",
                            list := List( args, a ->
                                rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := rec(
                                        type := "EXPR_REF_GVAR",
                                        gvar := "Length",
                                    ),
                                    args := AsSyntaxTreeList( [
                                        a,
                                    ] ),
                                )
                            ),
                        ),
                    ] ),
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Concatenation( [ ... ] ) => Concatenation( ... )
# Concatenation( [ a, b, ... ], [ c, d, ... ], ... ) => [ a, b, ..., c, d, ... ]
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for concatenation of literal lists." );
    
    pre_func := function ( tree, additional_arguments )
      local args, new_tree;
        
        # Concatenation with a single argument has different semantics
        # -> convert to version with multiple arguments
        if CapJitIsCallToGlobalFunction( tree, "Concatenation" ) and tree.args.length = 1 and tree.args.1.type = "EXPR_LIST" then
            
            args := tree.args;
            
            if args.1.list.length = 0 then
                
                new_tree := rec(
                    type := "EXPR_LIST",
                    list := AsSyntaxTreeList( [ ] ),
                );
                
                if IsBound( tree.data_type ) then
                    
                    new_tree.data_type := tree.data_type;
                    
                fi;
                
                tree := new_tree;
                
            elif args.1.list.length = 1 then
                
                tree := args.1.list.1;
                
            else
                
                tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := tree.funcref, # Concatenation
                    args := args.1.list,
                );
                
            fi;
            
        fi;
        
        if CapJitIsCallToGlobalFunction( tree, "Concatenation" ) and tree.args.length > 1 and ForAll( tree.args, a -> a.type = "EXPR_LIST" ) then
            
            args := tree.args;
            
            new_tree := rec(
                type := "EXPR_LIST",
                list := ConcatenationForSyntaxTreeLists( AsListMut( List( args, a -> a.list ) ) ),
            );
            
            if IsBound( tree.data_type ) then
                
                new_tree.data_type := tree.data_type;
                
            fi;
            
            tree := new_tree;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# CallFuncList( func, [ a, b, ... ] ) => func( a, b, ... )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for CallFuncList." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "CallFuncList" ) then
            
            args := tree.args;
            
            if args.2.type = "EXPR_LIST" then
                
                return rec(
                    type := "EXPR_FUNCCALL",
                    funcref := args.1,
                    args := args.2.list,
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# [ a_1, ..., a_n ][i] => a_i
#CapJitAddLogicFunction( function ( tree, jit_args )
#  local pre_func;
#    
#    Info( InfoCapJit, 1, "####" );
#    Info( InfoCapJit, 1, "Apply logic for list access." );
#    
#    pre_func := function ( tree, additional_arguments )
#      local args;
#        
#        if tree.type = "EXPR_ELM_LIST" and tree.list.type = "EXPR_LIST" and tree.pos.type = "EXPR_INT" then
#            
#            return tree.list.list.(tree.pos.value);
#            
#        fi;
#        
#        return tree;
#        
#    end;
#    
#    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
#    
#end );

# Length( [ a_1, ..., a_n ] ) = n
#CapJitAddLogicFunction( function ( tree, jit_args )
#  local pre_func;
#    
#    Info( InfoCapJit, 1, "####" );
#    Info( InfoCapJit, 1, "Apply logic for Length." );
#    
#    pre_func := function ( tree, additional_arguments )
#      local args;
#        
#        if CapJitIsCallToGlobalFunction( tree, "Length" ) then
#            
#            args := tree.args;
#            
#            if args.1.type = "EXPR_LIST" then
#                
#                return rec(
#                    type := "EXPR_INT",
#                    value := args.1.list.length,
#                );
#                
#            fi;
#            
#        fi;
#        
#        return tree;
#        
#    end;
#    
#    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
#    
#end );

# f( [ a_1, ..., a_n ][index] ) = [ f( a_1 ), ..., f( a_n ) ][index]
#CapJitAddLogicFunction( function ( tree, jit_args )
#  local orig_tree, pre_func, result;
#    
#    Info( InfoCapJit, 1, "####" );
#    Info( InfoCapJit, 1, "Apply logic for Length." );
#    
#    orig_tree := tree;
#    
#    pre_func := function ( tree, additional_arguments )
#      local args;
#        
#        if tree.type = "EXPR_FUNCCALL" and tree.args.length = 1 and tree.args.1.type = "EXPR_ELM_LIST" and tree.args.1.list.type = "EXPR_LIST" then
#            
#            return rec(
#                type := "EXPR_ELM_LIST",
#                pos := tree.args.1.pos,
#                list := rec(
#                    type := "EXPR_LIST",
#                    list := List(
#                        tree.args.1.list.list,
#                        entry -> rec(
#                            type := "EXPR_FUNCCALL",
#                            funcref := CapJitCopyWithNewFunctionIDs( tree.funcref ),
#                            args := AsSyntaxTreeList( [ entry ] ),
#                        )
#                    ),
#                ),
#            );
#            
#        fi;
#        
#        return tree;
#        
#    end;
#    
#    result := CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
#    
#    if result <> orig_tree then
#        
#        #Display( "#############################" );
#        #Display( ENHANCED_SYNTAX_TREE_CODE( orig_tree ) );
#        #Display( ENHANCED_SYNTAX_TREE_CODE( result ) );
#        
#    fi;
#    
#    return result;
#    
#end );

# [ f( a_1 ), ..., f( a_n ) ] => List( [ a_1, ..., a_n ], f )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for literal lists." );
    
    pre_func := function ( tree, additional_arguments )
      local variable_argument_position, t, i, j;
        
        # check if we have a non-empty literal list
        if tree.type = "EXPR_LIST" and tree.list.length > 0 then
            
            # check if all entries of the list are obtained by a call to the same function with the same number of arguments
            if ForAll( tree.list, t -> t.type = "EXPR_FUNCCALL" and CapJitIsEqualForEnhancedSyntaxTrees( t.funcref, tree.list.1.funcref ) and t.args.length = tree.list.1.args.length ) then
                
                # check if only a single argument varies between the function calls
                variable_argument_position := fail;
                
                for i in [ 2 .. tree.list.length ] do
                    
                    t := tree.list.(i);
                    
                    for j in [ 1 .. t.args.length ] do
                        
                        if not CapJitIsEqualForEnhancedSyntaxTrees( t.args.(j), tree.list.1.args.(j) ) then
                            
                            if variable_argument_position = fail then
                                
                                variable_argument_position := j;
                                
                            else
                                
                                # at least two arguments vary between the function calls, this is not supported
                                return tree;
                                
                            fi;
                            
                        fi;
                        
                    od;
                    
                od;
                
                if variable_argument_position = fail then
                    
                    # TODO
                    return tree;
                    
                fi;
                
                tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "List",
                    ),
                    args := AsSyntaxTreeList( [
                        rec(
                            type := "EXPR_LIST",
                            list := List( tree.list, t -> t.args.(variable_argument_position) ),
                        ),
                        rec(
                            type := "EXPR_DECLARATIVE_FUNC",
                            id := CAP_JIT_INTERNAL_FUNCTION_ID,
                            nams := [
                                "logic_new_func_x",
                                "RETURN_VALUE",
                            ],
                            narg := 1,
                            variadic := false,
                            bindings := rec(
                                type := "FVAR_BINDING_SEQ",
                                names := Set( [ "RETURN_VALUE" ] ),
                                BINDING_RETURN_VALUE := rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := tree.list.1.funcref,
                                    args := AsSyntaxTreeList( List( [ 1 .. tree.list.1.args.length ], function( j )
                                        
                                        if j = variable_argument_position then
                                            
                                            return rec(
                                                type := "EXPR_REF_FVAR",
                                                func_id := CAP_JIT_INTERNAL_FUNCTION_ID,
                                                name := "logic_new_func_x",
                                            );
                                            
                                        else
                                            
                                            return tree.list.1.args.(j);
                                            
                                        fi;
                                        
                                    end ) ),
                                ),
                            ),
                        ),
                    ] ),
                );
                CAP_JIT_INTERNAL_FUNCTION_ID := CAP_JIT_INTERNAL_FUNCTION_ID + 1;
                
                return tree;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# EXPR_CASE( f( a_i )_i ) => f( EXPR_CASE )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for EXPR_CASE." );
    
    pre_func := function ( tree, additional_arguments )
      local variable_argument_position, t, i, j;
        
        # check if we have a non-empty literal list
        if tree.type = "EXPR_CASE" then
            
            Assert( 0, tree.branches.length > 0 );
            
            # check if all values of branches are obtained by a call to the same function with the same number of arguments
            if ForAll( tree.branches, branch -> branch.value.type = "EXPR_FUNCCALL" and CapJitIsEqualForEnhancedSyntaxTrees( branch.value.funcref, tree.branches.1.value.funcref ) and branch.value.args.length = tree.branches.1.value.args.length ) then
                
                # check if only a single argument varies between the function calls
                variable_argument_position := fail;
                
                for i in [ 2 .. tree.branches.length ] do
                    
                    value := tree.branches.(i).value;
                    
                    for j in [ 1 .. value.args.length ] do
                        
                        if not CapJitIsEqualForEnhancedSyntaxTrees( value.args.(j), tree.branches.1.value.args.(j) ) then
                            
                            if variable_argument_position = fail then
                                
                                variable_argument_position := j;
                                
                            else
                                
                                # at least two arguments vary between the function calls, this is not supported
                                return tree;
                                
                            fi;
                            
                        fi;
                        
                    od;
                    
                od;
                
                if variable_argument_position = fail then
                    
                    # TODO
                    return tree;
                    
                fi;
                
                return rec(
                    type := "EXPR_FUNCCALL",
                    funcref := tree.branches.1.value.funcref,
                    args := AsSyntaxTreeList( List( [ 1 .. tree.branches.1.value.args.length ], function( j )
                        
                        if j = variable_argument_position then
                            
                            return rec(
                                type := "EXPR_CASE",
                                branches := List( tree.branches, branch -> rec(
                                    type := "CASE_BRANCH",
                                    condition := branch.condition,
                                    value := branch.value.args.(j),
                                ) ),
                            );
                            
                        else
                            
                            return tree.branches.1.value.args.(j);
                            
                        fi;
                        
                    end ) ),
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );



# List( [ a_1, ..., a_n ], f ) = [ f( a_1 ), ..., f( a_n ) ]
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for List applied to a literal list." );
    
    pre_func := function ( tree, additional_arguments )
      local args, new_tree;
        
        if CapJitIsCallToGlobalFunction( tree, "List" ) then
            
            args := tree.args;
            
            if args.length = 2 and args.1.type = "EXPR_LIST" then
                
                new_tree := rec(
                    type := "EXPR_LIST",
                    list := List(
                        args.1.list,
                        entry -> rec(
                            type := "EXPR_FUNCCALL",
                            funcref := CapJitCopyWithNewFunctionIDs( args.2 ),
                            args := AsSyntaxTreeList( [ entry ] ),
                        )
                    ),
                );
                
                if IsBound( tree.data_type ) then
                    
                    new_tree.data_type := tree.data_type;
                    
                fi;
                
                tree := new_tree;
                
            fi;
            
            #if args.length = 2 and args.1.type = "EXPR_RANGE" and args.1.first.type = "EXPR_INT" and args.1.last.type = "EXPR_INT" then
            #    
            #    return rec(
            #        type := "EXPR_LIST",
            #        list := List(
            #            AsSyntaxTreeList( [ args.1.first.value .. args.1.last.value ] ),
            #            pos -> rec(
            #                type := "EXPR_FUNCCALL",
            #                funcref := CapJitCopyWithNewFunctionIDs( args.2 ),
            #                args := AsSyntaxTreeList( [ rec(
            #                    type := "EXPR_INT",
            #                    value := pos,
            #                ) ] ),
            #            )
            #        ),
            #    );
            #    
            #fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# List( Concatenation( L_1, ..., L_n ), f ) = Concatenation( List( L_1, f ), ..., List( L_n, f ) )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for List applied to a Concatenation with multiple arguments." ); # the case of a single argument is handled by a logic template
    
    pre_func := function ( tree, additional_arguments )
        
        if CapJitIsCallToGlobalFunction( tree, "List" ) then
            
            if tree.args.length = 2 and CapJitIsCallToGlobalFunction( tree.args.1, "Concatenation" ) and tree.args.1.args.length > 1 then
                
                return rec(
                    type := "EXPR_FUNCCALL",
                    funcref := tree.args.1.funcref, # Concatenation
                    args := List(
                        tree.args.1.args,
                        a -> rec(
                            type := "EXPR_FUNCCALL",
                            funcref := tree.funcref, # List
                            args := AsSyntaxTreeList( [
                                a,
                                CapJitCopyWithNewFunctionIDs( tree.args.2 )
                            ] ),
                        )
                    ),
                );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# AttributeGetter( CreateCapCategoryObject/MorphismWithAttributes( ..., Attribute, value, ... ) ) => value
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for attribute getters." );
    
    pre_func := function ( tree, additional_arguments )
      local attribute_name, args, object, list, pos;
        
        # attribute getters can also be applied to more than one argument, but we are not interested in that case
        if CapJitIsCallToGlobalFunction( tree, gvar -> IsAttribute( ValueGlobal( gvar ) ) ) and tree.args.length = 1 then
            
            attribute_name := tree.funcref.gvar;
            
            args := tree.args;
            
            object := args.1;
            
            list := fail;
            
            if CapJitIsCallToGlobalFunction( object, "CreateCapCategoryObjectWithAttributes" ) then
                
                # special case
                if attribute_name = "CapCategory" then
                    
                    return object.args.1;
                    
                fi;
                
                list := Sublist( object.args, [ 2 .. object.args.length ] );
                
            fi;
            
            if CapJitIsCallToGlobalFunction( object, "CreateCapCategoryMorphismWithAttributes" ) then
                
                # special cases
                if attribute_name = "CapCategory" then
                    
                    return object.args.1;
                    
                elif attribute_name = "Source" then
                    
                    return object.args.2;
                    
                elif attribute_name = "Range" or attribute_name = "Target" then
                    
                    return object.args.3;
                    
                fi;
                
                list := Sublist( object.args, [ 4 .. object.args.length ] );
                
            fi;
            
            if list <> fail then
                
                pos := PositionProperty( list, a -> a.type = "EXPR_REF_GVAR" and a.gvar = tree.funcref.gvar );
                
                if pos <> fail and IsOddInt( pos ) then
                    
                    Assert( 0, IsBound( list.(pos + 1) ) );
                    
                    return list.(pos + 1);
                    
                fi;
                
            fi;
            
            if CapJitIsCallToGlobalFunction( object, "AsCapCategoryObject" ) then
                
                # special case
                if attribute_name = "CapCategory" then
                    
                    return object.args.1;
                    
                fi;
                
                if IsBound( object.args.1.data_type ) and object.args.1.data_type.category!.object_attribute_name = attribute_name then
                    
                    return object.args.2;
                    
                fi;
                
            fi;
            
            if CapJitIsCallToGlobalFunction( object, "AsCapCategoryMorphism" ) then
                
                # special cases
                if attribute_name = "CapCategory" then
                    
                    return object.args.1;
                    
                elif attribute_name = "Source" then
                    
                    return object.args.2;
                    
                elif attribute_name = "Range" or attribute_name = "Target" then
                    
                    return object.args.4;
                    
                fi;
                
                if IsBound( object.args.1.data_type ) and object.args.1.data_type.category!.morphism_attribute_name = attribute_name then
                    
                    return object.args.3;
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# CreateCapCategoryObjectWithAttributes( cat, Attribute, Attribute( obj ) ) => obj
# Note: Attribute( obj ) is outlined!
CapJitAddLogicFunction( function ( tree )
  local pre_func, additional_arguments_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for unwrapping and immediately re-wrapping a CAP category object." );
    
    pre_func := function ( tree, func_stack )
      local attribute_name, func, value;
        
        # Attribute( obj ) is outlined!
        if CapJitIsCallToGlobalFunction( tree, "CreateCapCategoryObjectWithAttributes" ) and tree.args.length = 3 and tree.args.1.type = "EXPR_REF_GVAR" and IsBound( tree.args.1.data_type ) and tree.args.2.type = "EXPR_REF_GVAR" and tree.args.3.type = "EXPR_REF_FVAR" then
            
            attribute_name := tree.args.2.gvar;
            
            func := SafeUniqueEntry( func_stack, func -> func.id = tree.args.3.func_id );
            
            # check if tree.args.3 references a binding, not an argument
            if SafeUniquePosition( func.nams, tree.args.3.name ) > func.narg then
            
                value := CapJitValueOfBinding( func.bindings, tree.args.3.name );
                
                if CapJitIsCallToGlobalFunction( value, attribute_name ) and value.args.length = 1 and IsBound( value.args.1.data_type ) then
                    
                    Assert( 0, IsSpecializationOfFilter( IsCapCategory, tree.args.1.data_type.filter ) );
                    
                    if value.args.1.data_type = CapJitDataTypeOfObjectOfCategory( tree.args.1.data_type.category ) then
                        
                        return value.args.1;
                        
                    fi;
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ ] );
    
end );

# AsCapCategoryObject( cat, Attribute( obj ) ) => obj
# Note: Attribute( obj ) is outlined!
CapJitAddLogicFunction( function ( tree )
  local pre_func, additional_arguments_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for unwrapping and immediately re-wrapping a CAP category object." );
    
    pre_func := function ( tree, func_stack )
      local func, value;
        
        # Attribute( obj ) is outlined!
        if CapJitIsCallToGlobalFunction( tree, "AsCapCategoryObject" ) and tree.args.1.type = "EXPR_REF_GVAR" and IsBound( tree.args.1.data_type ) and tree.args.2.type = "EXPR_REF_FVAR" then
            
            func := SafeUniqueEntry( func_stack, func -> func.id = tree.args.2.func_id );
            
            # check if tree.args.2 references a binding, not an argument
            if SafeUniquePosition( func.nams, tree.args.2.name ) > func.narg then
                
                value := CapJitValueOfBinding( func.bindings, tree.args.2.name );
                
                if CapJitIsCallToGlobalFunction( value, tree.args.1.data_type.category!.object_attribute_name ) and value.args.length = 1 and IsBound( value.args.1.data_type ) then
                    
                    Assert( 0, IsSpecializationOfFilter( IsCapCategory, tree.args.1.data_type.filter ) );
                    
                    if value.args.1.data_type = CapJitDataTypeOfObjectOfCategory( tree.args.1.data_type.category ) then
                        
                        return value.args.1;
                        
                    fi;
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ ] );
    
end );

# EXPR_CASE with all branches having the same value
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for EXPR_CASE with all branches having the same value." );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_CASE" and tree.branches.length > 0 and ForAll( tree.branches, branch -> CapJitIsEqualForEnhancedSyntaxTrees( branch.value, tree.branches.1.value ) ) then
            
            return tree.branches.1.value;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# func( EXPR_CASE )
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for func( EXPR_CASE )." );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_FUNCCALL" and tree.args.length = 1 and tree.args.1.type = "EXPR_CASE" then
            
            return rec(
                type := "EXPR_CASE",
                branches := List( tree.args.1.branches, branch -> rec(
                    type := "CASE_BRANCH",
                    condition := branch.condition,
                    value := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := CapJitCopyWithNewFunctionIDs( tree.funcref ),
                        args := AsSyntaxTreeList( [
                            branch.value
                        ] ),
                    ),
                ) ),
            );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# func( ..., EXPR_CASE, ... )
#CapJitAddLogicFunction( function ( tree, jit_args )
#  local pre_func;
#    
#    Info( InfoCapJit, 1, "####" );
#    Info( InfoCapJit, 1, "Apply logic for func( ..., EXPR_CASE, ... )." );
#    
#    pre_func := function ( tree, additional_arguments )
#      local pos, new_tree, i;
#        
#        if tree.type = "EXPR_FUNCCALL" then
#            
#            pos := PositionProperty( tree.args, t -> t.type = "EXPR_CASE" );
#            
#            if pos <> fail then
#                
#                new_tree := rec(
#                    type := "EXPR_CASE",
#                    branches := List( tree.args.(pos).branches, function ( branch )
#                      local new_args;
#                        
#                        new_args := List( [ 1 .. tree.args.length ], function ( i )
#                            
#                            if i = pos then
#                                
#                                return CapJitCopyWithNewFunctionIDs( branch.value );
#                                
#                            else
#                                
#                                return CapJitCopyWithNewFunctionIDs( tree.args.(i) );
#                                
#                            fi;
#                            
#                        end );
#                        
#                        return rec(
#                            type := "CASE_BRANCH",
#                            condition := branch.condition,
#                            value := rec(
#                                type := "EXPR_FUNCCALL",
#                                funcref := CapJitCopyWithNewFunctionIDs( tree.funcref ),
#                                args := AsSyntaxTreeList( new_args ),
#                            ),
#                        );
#                        
#                    end ),
#                );
#                
#                #for i in [ 1 .. new_tree.branches.length ] do
#                #    
#                #    new_tree.branches.(i).value.args.(pos) := CapJitCopyWithNewFunctionIDs( tree.args.(pos).branches.(i).value );
#                #    
#                #od;
#                
#                return new_tree;
#                
#            fi;
#            
#        fi;
#        
#        return tree;
#        
#    end;
#    
#    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
#    
#end );

# helper
InstallGlobalFunction( CAP_JIT_INTERNAL_TELESCOPED_ITERATION, function ( tree, result_func_index, additional_funcs_indices, additional_values_indices, additional_lists_indices )
  local result_func, additional_funcs, additional_values, additional_lists, return_obj, cat, attributes_names, attributes_values, new_attributes_values, attribute_name, attribute_value, new_func, new_additional_funcs, problematic_access, arguments_references_paths, parent, object_attribute_value_getter_name, args, new_additional_values, new_additional_lists, new_args, new_tree, attribute_index, func, path, i;
    
    Assert( 0, tree.type = "EXPR_FUNCCALL" );
    Assert( 0, tree.funcref.type = "EXPR_REF_GVAR" );
    
    Assert( 0, [ 1 .. tree.args.length ] = SortedList( Concatenation( [ result_func_index ], additional_funcs_indices, additional_values_indices, additional_lists_indices ) ) );
    
    result_func := tree.args.(result_func_index);
    additional_funcs := Sublist( tree.args, additional_funcs_indices );
    additional_values := Sublist( tree.args, additional_values_indices );
    additional_lists := Sublist( tree.args, additional_lists_indices );
    
    if result_func.type = "EXPR_DECLARATIVE_FUNC" and ForAll( additional_funcs, f -> f.type = "EXPR_DECLARATIVE_FUNC" ) then
        
        return_obj := result_func.bindings.BINDING_RETURN_VALUE;
        
        if CapJitIsCallToGlobalFunction( return_obj, gvar -> gvar in [ "CreateCapCategoryObjectWithAttributes", "CreateCapCategoryMorphismWithAttributes", "AsCapCategoryObject", "AsCapCategoryMorphism" ] ) and return_obj.args.1.type = "EXPR_REF_GVAR" then
            
            cat := ValueGlobal( return_obj.args.1.gvar );
            
            Assert( 0, IsCapCategory( cat ) );
            
            # This could easily be extended to cases with multiple attributes but
            # 1. this case currently does not occur and
            # 2. the logic below requires that each attribute can be computed independently of the other attributes and
            # it is unclear if this condition typically holds in contexts with multiple attributes
            # -> we do not implement this case for now.
            if return_obj.funcref.gvar = "CreateCapCategoryObjectWithAttributes" and return_obj.args.length = 3 and return_obj.args.2.type = "EXPR_REF_GVAR" then
                
                attributes_names := [ return_obj.args.2.gvar ];
                attributes_values := [ return_obj.args.3 ];
                
            elif return_obj.funcref.gvar = "CreateCapCategoryMorphismWithAttributes" and return_obj.args.length = 5 and return_obj.args.4.type = "EXPR_REF_GVAR" then
                
                attributes_names := [ return_obj.args.4.gvar, "Source", "Range" ];
                attributes_values := [ return_obj.args.5, return_obj.args.2, return_obj.args.3 ];
                
            elif return_obj.funcref.gvar = "AsCapCategoryObject" then
                
                attributes_names := [ cat!.object_attribute_name ];
                attributes_values := [ return_obj.args.2 ];
                
            elif return_obj.funcref.gvar = "AsCapCategoryMorphism" then
                
                attributes_names := [ cat!.morphism_attribute_name, "Source", "Range" ];
                attributes_values := [ return_obj.args.3, return_obj.args.2, return_obj.args.4 ];
                
            else
                
                return tree;
                
            fi;
            
            new_attributes_values := [ ];
            
            Assert( 0, Length( attributes_names ) = Length( attributes_values ) );
            
            for attribute_index in [ 1 .. Length( attributes_names ) ] do
                
                attribute_name := attributes_names[attribute_index];
                attribute_value := attributes_values[attribute_index];
                
                Assert( 0, IsAttribute( ValueGlobal( attribute_name ) ) );
                
                # create new func which immediately returns the attribute
                new_func := StructuralCopy( result_func );
                new_func.bindings.BINDING_RETURN_VALUE := StructuralCopy( attribute_value );
                
                # possibly drop outlined source and range
                new_func := CapJitDroppedUnusedBindings( new_func );
                
                # new_additional_funcs will be modified inplace
                new_additional_funcs := StructuralCopy( additional_funcs );
                
                # check if arguments are only accessed via the attribute in the functions and drop the attribute access
                problematic_access := false;
                
                for func in ConcatenationForSyntaxTreeLists( AsSyntaxTreeList( [ new_func ] ), new_additional_funcs ) do
                    
                    arguments_references_paths := CapJitFindNodes( func, { tree, path } -> tree.type = "EXPR_REF_FVAR" and tree.func_id = func.id and SafeUniquePosition( func.nams, tree.name ) <= func.narg );
                    
                    for path in arguments_references_paths do
                        
                        # check if <path> points to the first (and only) argument of a function call calling the attribute getter
                        
                        parent := CapJitGetNodeByPath( func, path{[ 1 .. Length( path ) - 2 ]} );
                        
                        if EndsWith( path, [ "args", "1" ] ) and CapJitIsCallToGlobalFunction( parent, attribute_name ) and parent.args.length = 1 then
                            
                            Assert( 0, parent.args.1.type = "EXPR_REF_FVAR" );
                            Assert( 0, parent.args.1.func_id = func.id );
                            
                            # set parent := parent.args.1, but inplace
                            parent.type := parent.args.1.type;
                            parent.func_id := parent.args.1.func_id;
                            parent.name := parent.args.1.name;
                            Unbind( parent.funcref );
                            Unbind( parent.args );
                            
                        else
                            
                            # we cannot optimize because the variable is used in a way different from simply accessing the attribute
                            problematic_access := true;
                            
                        fi;
                        
                    od;
                    
                od;
                
                if problematic_access then
                    
                    # try to obtain source or range from compiler hints
                    if ((return_obj.funcref.gvar = "CreateCapCategoryMorphismWithAttributes" and return_obj.args.length = 5) or return_obj.funcref.gvar = "AsCapCategoryMorphism") and attribute_name in [ "Source", "Range" ] then
                        
                        if IsBound( cat!.compiler_hints ) and IsBound( cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute ) then
                            
                            Assert( 0, Length( attributes_names ) = 3 );
                            Assert( 0, attributes_names[1] = cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.morphism_attribute_name );
                            Assert( 0, attributes_names[2] = "Source" );
                            Assert( 0, attributes_names[3] = "Range" );
                            
                            if attribute_name = "Source" then
                                
                                object_attribute_value_getter_name := cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.source_attribute_getter_name;
                                
                            elif attribute_name = "Range" then
                                
                                object_attribute_value_getter_name := cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.range_attribute_getter_name;
                                
                            else
                                
                                # COVERAGE_IGNORE_NEXT_LINE
                                Error( "this should never happen" );
                                
                            fi;
                            
                            Add( new_attributes_values, rec(
                                type := "EXPR_FUNCCALL",
                                funcref := rec(
                                    type := "EXPR_REF_GVAR",
                                    gvar := "CreateCapCategoryObjectWithAttributes",
                                ),
                                args := AsSyntaxTreeList( [
                                    # the category
                                    return_obj.args.1,
                                    # the object attribute
                                    rec(
                                        type := "EXPR_REF_GVAR",
                                        gvar := cat!.compiler_hints.source_and_range_attributes_from_morphism_attribute.object_attribute_name,
                                    ),
                                    # the attribute value
                                    rec(
                                        type := "EXPR_FUNCCALL",
                                        funcref := rec(
                                            type := "EXPR_REF_GVAR",
                                            gvar := object_attribute_value_getter_name,
                                        ),
                                        args := AsSyntaxTreeList( [
                                            CapJitCopyWithNewFunctionIDs( new_attributes_values[1] ),
                                        ] ),
                                    ),
                                ] ),
                            ) );
                            
                            continue;
                            
                        fi;
                        
                    fi;
                    
                    # we cannot do anything
                    return tree;
                    
                fi;
                
                # wrap additional values in a call to the attribute
                new_additional_values := [ ];
                
                for i in [ 1 .. Length( additional_values_indices ) ] do
                    
                    new_additional_values[i] := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := attribute_name,
                        ),
                        args := AsSyntaxTreeList( [
                            additional_values.(i),
                        ] ),
                    );
                    
                od;
                
                # wrap additional lists in element-wise calls to the attribute
                new_additional_lists := [ ];
                
                for i in [ 1 .. Length( additional_lists_indices ) ] do
                    
                    new_additional_lists[i] := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := "List",
                        ),
                        args := AsSyntaxTreeList( [
                            additional_lists.(i),
                            rec(
                                type := "EXPR_REF_GVAR",
                                gvar := attribute_name,
                            )
                        ] ),
                    );
                    
                od;
                
                # form new args by collecting the variables set above
                new_args := [ ];
                new_args[result_func_index] := new_func;
                
                for i in [ 1 .. Length( additional_funcs_indices ) ] do
                    
                    new_args[additional_funcs_indices[i]] := new_additional_funcs.(i);
                    
                od;
                
                for i in [ 1 .. Length( additional_values_indices ) ] do
                    
                    new_args[additional_values_indices[i]] := new_additional_values[i];
                    
                od;
                
                for i in [ 1 .. Length( additional_lists_indices ) ] do
                    
                    new_args[additional_lists_indices[i]] := new_additional_lists[i];
                    
                od;
                
                Add( new_attributes_values, rec(
                    type := "EXPR_FUNCCALL",
                    funcref := CapJitCopyWithNewFunctionIDs( tree.funcref ),
                    args := AsSyntaxTreeList( new_args ),
                ) );
                
            od;
            
            # create new tree
            if return_obj.funcref.gvar = "CreateCapCategoryObjectWithAttributes" then
                
                # func call to CreateCapCategoryObjectWithAttributes
                new_tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "CreateCapCategoryObjectWithAttributes"
                    ),
                    args := AsSyntaxTreeList( [
                        # the category
                        return_obj.args.1,
                        # the attribute
                        return_obj.args.2,
                        # the func call with new args
                        new_attributes_values[1],
                    ] ),
                );
                
            elif return_obj.funcref.gvar = "CreateCapCategoryMorphismWithAttributes" then
                
                Assert( 0, Length( attributes_names ) = 3 );
                Assert( 0, attributes_names[2] = "Source" );
                Assert( 0, attributes_names[3] = "Range" );
                
                # func call to CreateCapCategoryMorphismWithAttributes
                new_tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "CreateCapCategoryMorphismWithAttributes"
                    ),
                    args := AsSyntaxTreeList( [
                        # the category
                        return_obj.args.1,
                        # the source
                        new_attributes_values[2],
                        # the range
                        new_attributes_values[3],
                        # the attribute
                        return_obj.args.4,
                        # the func call with new args
                        new_attributes_values[1],
                    ] ),
                );
                
            elif return_obj.funcref.gvar = "AsCapCategoryObject" then
                
                # func call to AsCapCategoryObject
                new_tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "AsCapCategoryObject"
                    ),
                    args := AsSyntaxTreeList( [
                        # the category
                        return_obj.args.1,
                        # the func call with new args
                        new_attributes_values[1],
                    ] ),
                );
                
            elif return_obj.funcref.gvar = "AsCapCategoryMorphism" then
                
                Assert( 0, Length( attributes_names ) = 3 );
                Assert( 0, attributes_names[2] = "Source" );
                Assert( 0, attributes_names[3] = "Range" );
                
                # func call to AsCapCategoryMorphism
                new_tree := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "AsCapCategoryMorphism"
                    ),
                    args := AsSyntaxTreeList( [
                        # the category
                        return_obj.args.1,
                        # the source
                        new_attributes_values[2],
                        # the func call with new args
                        new_attributes_values[1],
                        # the range
                        new_attributes_values[3],
                    ] ),
                );
                
            else
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "this should never happen" );
                
            fi;
            
            return new_tree;
            
        fi;
        
    fi;
    
    return tree;
    
end );

# CapFixpoint
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for CapFixpoint." );
    
    pre_func := function ( tree, additional_arguments )
      local args;
        
        if CapJitIsCallToGlobalFunction( tree, "CapFixpoint" ) then
            
            args := tree.args;
            
            Assert( 0, args.length = 3 );
            
            # CapFixpoint( predicate, func, initial_value )
            #
            # tree := tree,
            # result_func_index := 2,
            # additional_funcs_indices := [ 1 ],
            # additional_values_indices := [ 3 ],
            # additional_lists_indices := [ ],
            return CAP_JIT_INTERNAL_TELESCOPED_ITERATION( tree, 2, [ 1 ], [ 3 ], [ ] );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

# Iterated
CapJitAddLogicFunction( function ( tree )
  local pre_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic for Iterated." );
    
    pre_func := function ( tree, additional_arguments )
      local args, list, func, entries, new_tree, i;
        
        if CapJitIsCallToGlobalFunction( tree, "Iterated" ) then
            
            args := tree.args;
            
            Assert( 0, args.length = 2 or args.length = 3 or args.length = 4 );
            
            list := args.1;
            func := args.2;
            
            if list.type = "EXPR_LIST" then
                
                entries := list.list;
                
                # if we have an initial value, preprend it to the entries
                if args.length >= 3 then
                    
                    entries := ConcatenationForSyntaxTreeLists( AsSyntaxTreeList( [ args.3 ] ), entries );
                    
                fi;
                
                # if we have a terminal value, append it to the entries
                if args.length = 4 then
                    
                    entries := ConcatenationForSyntaxTreeLists( entries, AsSyntaxTreeList( [ args.4 ] ) );
                    
                fi;
                
                Assert( 0, entries.length > 0 );
                
                new_tree := entries.1;
                
                for i in [ 2 .. entries.length ] do
                    
                    new_tree := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := CapJitCopyWithNewFunctionIDs( func ),
                        args := AsSyntaxTreeList( [
                            new_tree,
                            entries.(i)
                        ] ),
                    );
                    
                od;
                
                return new_tree;
                
            else
                
                if args.length = 2 then
                    
                    # Iterated( list, func )
                    #
                    # tree := tree,
                    # result_func_index := 2,
                    # additional_funcs_indices := [ ],
                    # additional_values_indices := [ ],
                    # additional_lists_indices := [ 1 ],
                    return CAP_JIT_INTERNAL_TELESCOPED_ITERATION( tree, 2, [ ], [ ], [ 1 ] );
                    
                elif args.length = 3 then
                    
                    # Iterated( list, func, initial_value )
                    #
                    # tree := tree,
                    # result_func_index := 2,
                    # additional_funcs_indices := [ ],
                    # additional_values_indices := [ 3 ],
                    # additional_lists_indices := [ 1 ],
                    return CAP_JIT_INTERNAL_TELESCOPED_ITERATION( tree, 2, [ ], [ 3 ], [ 1 ] );
                    
                elif args.length = 4 then
                    
                    # Iterated( list, func, initial_value )
                    #
                    # tree := tree,
                    # result_func_index := 2,
                    # additional_funcs_indices := [ ],
                    # additional_values_indices := [ 3, 4 ],
                    # additional_lists_indices := [ 1 ],
                    return CAP_JIT_INTERNAL_TELESCOPED_ITERATION( tree, 2, [ ], [ 3, 4 ], [ 1 ] );
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "this should never happen" );
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
