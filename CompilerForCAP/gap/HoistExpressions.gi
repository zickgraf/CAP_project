# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

InstallGlobalFunction( CapJitHoistedExpressions, function ( tree )
    
    return CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS( tree, false );
    
end );

InstallGlobalFunction( CapJitHoistedBindings, function ( tree )
    
    return CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS( tree, true );
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS, function ( tree, only_hoist_bindings )
  local expressions_to_hoist, references_to_function_variables, result_func, additional_arguments_func, pre_func;
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    # loop fission
    pre_func := function ( tree, func_stack )
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, func_stack )
      local levels, domain_levels, func, func_level, loop_func, loop_level, extracted_expression_template, args, id, old_id, result_func, additional_arguments_func;
        
        levels := Union( List( keys, name -> result.(name).levels ) );
        
        if tree.type = "EXPR_REF_FVAR" then
            
            # references to variables always restrict the scope to the corresponding function
            AddSet( levels, PositionProperty( func_stack, f -> f.id = tree.func_id ) );
            
        elif tree.type = "FVAR_BINDING_SEQ" then
            
            # bindings restrict the scope to the current function
            AddSet( levels, Length( func_stack ) );
            
        elif tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # a function binds its variables, so the level of the function variables can be ignored (at this point, the function stack does not yet include the current func)
            levels := Difference( levels, [ Length( func_stack ) + 1 ] );
            
        fi;
        
        if CapJitIsCallToGlobalFunction( tree, gvar -> gvar in [ "List", "Sum", "Product" ] ) and tree.args.length = 2 and tree.args.2.type = "EXPR_DECLARATIVE_FUNC" then
            
            domain_levels := result.args.children.1.levels;
            
            func := Last( func_stack );
            func_level := Length( func_stack );
            
            loop_func := tree.args.2;
            loop_level := Length( func_stack ) + 1;
            
            Assert( 0, loop_level >= 2 );
            
            # If the domain does not depend on all levels, it makes sense to split the loop because we might be able to hoist things later.
            if Length( domain_levels ) < Length( func_stack ) then
                
                Assert( 0, tree.args.2.narg = 1 );
                
                extracted_expression_template := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "List",
                    ),
                    args := AsSyntaxTreeList( [
                        tree.args.1,
                        rec(
                            type := "EXPR_DECLARATIVE_FUNC",
                            id := loop_func.id,
                            narg := 1,
                            variadic := false,
                            nams := [ loop_func.nams[1], "RETURN_VALUE" ],
                            bindings := rec(
                                type := "FVAR_BINDING_SEQ",
                                names := [ "RETURN_VALUE" ],
                                BINDING_RETURN_VALUE := rec( ), # to be set later
                            ),
                        ),
                    ] ),
                );
                
                id := CapJitGetNextUnusedVariableID( func );
                old_id := id;
                
                #pre_func := function ( tree, func_stack )
                #    
                #    if CapJitIsCallToGlobalFunction( tree, "[]" ) then
                #        
                #        # see below
                #        tree.args.CAP_JIT_ARGUMENTS_OF_LIST_ACCESS := true;
                #        
                #    fi;
                #    
                #    return tree;
                #    
                #end;
                
                result_func := function ( tree, result, keys, func_stack )
                  local levels, all_levels, new_variable_name, id, args, key;
                    
                    levels := Union( List( keys, name -> result.(name).levels ) );
                    
                    if tree.type = "EXPR_REF_FVAR" then
                        
                        # references to variables always restrict the scope to the corresponding function
                        AddSet( levels, PositionProperty( func_stack, f -> f.id = tree.func_id ) );
                        
                    elif tree.type = "FVAR_BINDING_SEQ" then
                        
                        # bindings restrict the scope to the current function
                        AddSet( levels, Length( func_stack ) );
                        
                    elif tree.type = "EXPR_DECLARATIVE_FUNC" then
                        
                        # a function binds its variables, so the level of the function variables can be ignored (at this point, the function stack does not yet include the current func)
                        levels := Difference( levels, [ Length( func_stack ) + 1 ] );
                        
                    fi;
                    
                    if MaximumList( levels ) > loop_level or tree.type = "FVAR_BINDING_SEQ" then
                        
                        for key in keys do
                            
                            # If the child depends on deeper levels, we cannot extract it.
                            # If the child does neither depend on deeper levels nor on `loop_level`, it will be hoisted anyway.
                            if ForAll( result.(key).levels, l -> l <= loop_level ) and loop_level in result.(key).levels then
                                
                                # we do not want to extract `expr[loop_index]` if `expr` is independent of `loop_index`
                                if CapJitIsCallToGlobalFunction( tree.(key), "[]" ) then
                                    
                                    if not loop_level in result.(key).children.1.levels then
                                        
                                        Assert( 0, loop_level in result.(key).children.2.levels );
                                        
                                        continue;
                                        
                                    fi;
                                    
                                fi;
                                
                                all_levels := Union( domain_levels, result.(key).levels );
                                
                                Assert( 0, ForAll( all_levels, l -> l <= loop_level ) and loop_level in all_levels );
                                
                                if Length( all_levels ) = loop_level then
                                    
                                    # the extracted expression would depend on all levels -> it could not be hoisted anyway
                                    continue;
                                    
                                fi;
                                
                                new_variable_name := Concatenation( "extracted_", String( id ) );
                                id := id + 1;
                                
                                extracted_expression_template.args.2.bindings.BINDING_RETURN_VALUE := tree.(key);
                                
                                CapJitAddBinding( tree.bindings, new_variable_name, CapJitCopyWithNewFunctionIDs( extracted_expression_template ) );
                                
                                tree.(key) := rec(
                                    type := "EXPR_FUNCCALL",
                                    funcref := rec(
                                        type := "EXPR_REF_GVAR",
                                        gvar := "[]",
                                    ),
                                    args := AsSyntaxTreeList( [
                                        rec(
                                            type := "EXPR_REF_FVAR",
                                            func_id := func.id,
                                            name := new_variable_name,
                                        ),
                                        rec(
                                            type := "EXPR_REF_FVAR",
                                            func_id := loop_func.id,
                                            name := "key", # this argument will be added to loop_func below
                                        ),
                                    ] ),
                                );
                                
                            fi;
                            
                        od;
                        
                    fi;
                    
                    return rec( levels := levels, children := result );
                    
                end;
                
                additional_arguments_func := function ( tree, key, func_stack )
                    
                    if tree.type = "EXPR_DECLARATIVE_FUNC" then
                        
                        return Concatenation( func_stack, [ tree ] );
                        
                    fi;
                    
                    return func_stack;
                    
                end;
                
                CapJitIterateOverTree( loop_func, ReturnFirst, result_func, additional_arguments_func, func_stack );
                
                if id <> old_id then
                    
                    tree.funcref.gvar := Concatenation( tree.funcref.gvar, "WithKeys" );
                    
                    loop_func.narg := 2;
                    Add( loop_func.nams, "key", 1 );
                    
                fi;
                
            fi;
            
        fi;
        
        return rec( levels := levels, children := result );
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        fi;
        
        return func_stack;
        
    end;
    
    tree := CapJitIterateOverTreeWithCachedBindingResults( tree, pre_func, result_func, additional_arguments_func, [ ] );
    
    Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    expressions_to_hoist := rec( );
    references_to_function_variables := rec( );
    
    result_func := function ( tree, result, keys, func_stack )
      local levels, level, type_matches, pos, func_id, name;
        
        levels := Union( List( keys, name -> result.(name) ) );
        
        if tree.type = "EXPR_REF_FVAR" then
            
            # if EXPR_REF_FVAR references a function argument, `result` will be a record
            if only_hoist_bindings and IsList( result ) then
                
                if not IsBound( references_to_function_variables.(tree.func_id) ) then
                    
                    references_to_function_variables.(tree.func_id) := rec( );
                    
                fi;
                
                if not IsBound( references_to_function_variables.(tree.func_id).(tree.name) ) then
                    
                    references_to_function_variables.(tree.func_id).(tree.name) := [ ];
                    
                fi;
                
                Add( references_to_function_variables.(tree.func_id).(tree.name), tree );
                
                return result;
                
            fi;
            
            # references to variables always restrict the scope to the corresponding function
            Add( levels, PositionProperty( func_stack, f -> f.id = tree.func_id ) );
            
        elif tree.type = "FVAR_BINDING_SEQ" then
            
            # bindings restrict the scope to the current function
            Add( levels, Length( func_stack ) );
            
        elif tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # a function binds its variables, so the level of the function variables can be ignored (at this point, the function stack does not yet include the current func)
            levels := Difference( levels, [ Length( func_stack ) + 1 ] );
            
        fi;
        
        # we do not want to create global variables, because this would break precompilation -> the minimum level is 1
        level := MaximumList( levels, 1 );
        
        for name in keys do
            
            # Hoisting the return value would require special care below, so we skip it because
            # the return value is not a user-visible binding and
            # hoisting the return value is not relevant for our use case (outlining wrapped arguments to the highest level possible).
            if only_hoist_bindings and name = "BINDING_RETURN_VALUE" then
                continue;
            fi;
            
            if only_hoist_bindings then
                
                type_matches := tree.type = "FVAR_BINDING_SEQ";
                
            else
                
                type_matches := StartsWith( tree.(name).type, "EXPR_" ) and not tree.(name).type in [ "EXPR_REF_FVAR", "EXPR_REF_GVAR", "EXPR_DECLARATIVE_FUNC", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ];
                
            fi;
            
            # Check if child expressions have a lower level than the current level.
            # If yes, this child expression will be hoisted, except if they already are "static", e.g. variable references or function expressions.
            if type_matches and MaximumList( result.(name), 1 ) < level then
                
                pos := MaximumList( result.(name), 1 );
                
                func_id := func_stack[pos].id;
                
                if not IsBound( expressions_to_hoist.(func_id) ) then
                    
                    expressions_to_hoist.(func_id) := [ ];
                    
                fi;
                
                Add( expressions_to_hoist.(func_id), rec(
                    parent := tree,
                    key := name,
                    old_func := Last( func_stack ),
                ) );
                
            fi;
            
        od;
        
        return levels;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        fi;
        
        return func_stack;
        
    end;
    
    # populate `expressions_to_hoist`
    CapJitIterateOverTreeWithCachedBindingResults( tree, ReturnFirst, result_func, additional_arguments_func, [ ] );
    
    # now actually hoist the expressions
    pre_func := function ( tree, additional_arguments )
      local id, info, parent, key, expr, new_variable_name, to_delete, info2, old_variable_name, old_func, i, ref;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" and IsBound( expressions_to_hoist.(tree.id) ) then
            
            id := CapJitGetNextUnusedVariableID( tree );
            
            while Length( expressions_to_hoist.(tree.id) ) > 0 do
                
                info := expressions_to_hoist.(tree.id)[1];
                
                parent := info.parent;
                key := info.key;
                expr := parent.(key);
                
                new_variable_name := Concatenation( "hoisted_", String( id ) );
                id := id + 1;
                
                tree.nams := Concatenation( tree.nams, [ new_variable_name ] );
                
                CapJitAddBinding( tree.bindings, new_variable_name, expr );
                
                # search for all occurences of parent.(key) (always matching for i=1)
                to_delete := [ ];
                for i in [ 1 .. Length( expressions_to_hoist.(tree.id) ) ] do
                    
                    info2 := expressions_to_hoist.(tree.id)[i];
                    
                    if CapJitIsEqualForEnhancedSyntaxTrees( expr, info2.parent.(info2.key) ) then
                        
                        if only_hoist_bindings then
                            
                            Assert( 0, info2.parent.type = "FVAR_BINDING_SEQ" );
                            Assert( 0, StartsWith( info2.key, "BINDING_" ) );
                            
                            old_variable_name := info2.key{[ 9 .. Length( info2.key ) ]};
                            
                            old_func := info2.old_func;
                            
                            if IsBound( references_to_function_variables.(info2.old_func.id) ) and IsBound( references_to_function_variables.(info2.old_func.id).(old_variable_name) ) then
                                
                                for ref in references_to_function_variables.(info2.old_func.id).(old_variable_name) do
                                    
                                    Assert( 0, ref.type = "EXPR_REF_FVAR" );
                                    
                                    ref.func_id := tree.id;
                                    ref.name := new_variable_name;
                                    
                                od;
                                
                            fi;
                            
                            # drop old binding
                            Remove( info2.old_func.nams, Position( info2.old_func.nams, old_variable_name ) );
                            CapJitUnbindBinding( info2.old_func.bindings, old_variable_name );
                            
                        else
                            
                            info2.parent.(info2.key) := rec(
                                type := "EXPR_REF_FVAR",
                                func_id := tree.id,
                                name := new_variable_name,
                            );
                            
                        fi;
                        
                        Add( to_delete, i );
                        
                    fi;
                    
                od;
                
                Assert( 0, 1 in to_delete );
                
                expressions_to_hoist.(tree.id) := expressions_to_hoist.(tree.id){Difference( [ 1 .. Length( expressions_to_hoist.(tree.id) ) ], to_delete )};
                
            od;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
