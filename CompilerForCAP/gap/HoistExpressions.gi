# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

GLOBAL_ID := 0;

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
    
    orig_tree := tree;
    
    result_func := function ( tree, result, keys, func_stack )
      local levels, binding_levels, pos, pos2, domain_levels, func, func_level, loop_func, loop_level, id, domain_variable_name, extracted_expression_template, args, old_id, result_func, additional_arguments_func;
        
        levels := Union( List( keys, name -> result.(name).levels ) );
        binding_levels := Union( List( keys, name -> result.(name).binding_levels ) );
        
        if tree.type = "EXPR_REF_FVAR" then
            
            pos := PositionProperty( func_stack, f -> f.id = tree.func_id );
            
            # references to variables always restrict the scope to the corresponding function
            AddSet( levels, pos );
            
            pos2 := Position( func_stack[pos].nams, tree.name );
            
            if pos2 > func_stack[pos].narg then
                
                AddSet( binding_levels, pos );
                
            fi;
            
        elif tree.type = "FVAR_BINDING_SEQ" then
            
            # bindings restrict the scope to the current function
            AddSet( levels, Length( func_stack ) );
            AddSet( binding_levels, Length( func_stack ) );
            
        elif tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # a function binds its variables, so the level of the function variables can be ignored (at this point, the function stack does not yet include the current func)
            levels := Difference( levels, [ Length( func_stack ) + 1 ] );
            binding_levels := Difference( binding_levels, [ Length( func_stack ) + 1 ] );
            
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
                
                id := CapJitGetNextUnusedVariableID( func );
                
                domain_variable_name := Concatenation( "domain_", String( id ) );
                id := id + 1;
                
                Assert( 0, tree.args.2.narg = 1 );
                
                extracted_expression_template := rec(
                    type := "EXPR_FUNCCALL",
                    funcref := rec(
                        type := "EXPR_REF_GVAR",
                        gvar := "ListWithKeys",
                    ),
                    args := AsSyntaxTreeList( [
                        tree.args.1,
                        #rec(
                        #    type := "EXPR_REF_FVAR",
                        #    func_id := func.id,
                        #    name := domain_variable_name,
                        #),
                        rec(
                            type := "EXPR_DECLARATIVE_FUNC",
                            id := loop_func.id,
                            narg := 2,
                            variadic := false,
                            #nams := Concatenation( [ "key" ], loop_func.nams ),
                            #bindings := ShallowCopy( loop_func.bindings ), # BINDING_RETURN_VALUE will be overwritten later, other bindings might be needed
                            nams := [ "key" , loop_func.nams[1], "RETURN_VALUE" ],
                            bindings := rec(
                                type := "FVAR_BINDING_SEQ",
                                names := [ "RETURN_VALUE" ],
                                BINDING_RETURN_VALUE := rec( ), # to be set later
                            ),
                        ),
                    ] ),
                );
                
                old_id := id;
                
                #Print( "add " , domain_variable_name, " to ", func.id, "\n" );
                
                #func.nams := Concatenation( func.nams, [ domain_variable_name ] );
                
                result_func := function ( tree, result, keys, func_stack )
                  local levels, binding_levels, pos, pos2, all_levels, new_variable_name, args, key;
                    
                    levels := Union( List( keys, name -> result.(name).levels ) );
                    binding_levels := Union( List( keys, name -> result.(name).binding_levels ) );
                    
                    if tree.type = "EXPR_REF_FVAR" then
                        
                        pos := PositionProperty( func_stack, f -> f.id = tree.func_id );
                        
                        # references to variables always restrict the scope to the corresponding function
                        AddSet( levels, pos );
                        
                        pos2 := Position( func_stack[pos].nams, tree.name );
                        
                        if pos2 > func_stack[pos].narg then
                            
                            AddSet( binding_levels, pos );
                            
                        fi;
                        
                    elif tree.type = "FVAR_BINDING_SEQ" then
                        
                        # bindings restrict the scope to the current function
                        AddSet( levels, Length( func_stack ) );
                        AddSet( binding_levels, Length( func_stack ) );
                        
                    elif tree.type = "EXPR_DECLARATIVE_FUNC" then
                        
                        # a function binds its variables, so the level of the function variables can be ignored (at this point, the function stack does not yet include the current func)
                        levels := Difference( levels, [ Length( func_stack ) + 1 ] );
                        binding_levels := Difference( binding_levels, [ Length( func_stack ) + 1 ] );
                        
                    fi;
                    
                    for key in keys do
                        
                        # TODO
                        #if tree.type = "FVAR_BINDING_SEQ" and Length( func_stack ) = loop_level then
                        #    break;
                        #fi;
                        #
                        #if tree.type = "SYNTAX_TREE_LIST" and tree.length > 0 and CapJitIsCallToGlobalFunction(tree.1, "ListWithKeys") then
                        #    break;
                        #fi;
                        
                        # TODO
                        #if tree.type = "FVAR_BINDING_SEQ" and key = "BINDING_RETURN_VALUE" then
                        #    continue;
                        #fi;
                        
                        if
                            StartsWith( tree.(key).type, "EXPR_" ) # tree.(key) is an expression
                            and not tree.(key).type in [ "EXPR_REF_FVAR", "EXPR_REF_GVAR", "EXPR_DECLARATIVE_FUNC", "EXPR_INT", "EXPR_STRING", "EXPR_TRUE", "EXPR_FALSE" ] # which is not "static"
                            and ForAll( result.(key).levels, l -> l <= loop_level ) # and does not depend on deeper levels (because then we could not extract it)
                            and loop_level in result.(key).levels # and depends on the current loop variable (if not, it would be hoisted anyway)
                            # TODO
                            and Union( result.(key).levels, domain_levels ) <> Union( levels, domain_levels ) # and we now add a new dependency (dependencies which are already in the domain do not count because we depend on them anyway)
                            #and result.(key).levels <> levels # and we now add a new dependency (dependencies which are already in the domain do not count because we depend on them anyway)
                            #and not loop_level in result.(key).binding_levels
                        then
                            
                            # we do not want to extract `expr[loop_index]` if `expr` is independent of `loop_index`
                            # because then `expr` will be hoisted anyway
                            if CapJitIsCallToGlobalFunction( tree.(key), "[]" ) then
                                
                                if not loop_level in result.(key).children.args.children.1.levels then
                                    
                                    # loop_level appears in result.(key).levels by the condition above, so if it does not appear in the first argument of [], it must appear in the second arguments
                                    Assert( 0, loop_level in result.(key).children.args.children.2.levels );
                                    
                                    continue;
                                    
                                fi;
                                
                            fi;
                            
                            all_levels := Union( [ 1 ], domain_levels, result.(key).levels ); # TODO: 1
                            
                            Assert( 0, ForAll( all_levels, l -> l <= loop_level ) and loop_level in all_levels );
                            
                            if Length( all_levels ) = loop_level then
                                
                                # the extracted expression would depend on all levels -> it could not be hoisted anyway
                                continue;
                                
                            fi;
                            
                            if loop_level in result.(key).binding_levels then
                                continue;
                                Error("qwe");
                            fi;
                            
                            Display( "################" );
                            Display( GLOBAL_ID );
                            GLOBAL_ID := GLOBAL_ID + 1;
                            Display( key );
                            Display( ENHANCED_SYNTAX_TREE_CODE( tree.(key) ) );
                            
                            #if GLOBAL_ID = 20 then
                            #    Error("asd");
                            #fi;
                            
                            #if tree.type = "FVAR_BINDING_SEQ" and key = "BINDING_RETURN_VALUE" then
                            #    Error("asd");
                            #fi;
                            
                            #Display( "want to extract:" );
                            #Display( ENHANCED_SYNTAX_TREE_CODE( tree.(key) ) );
                            
                            new_variable_name := Concatenation( "extracted_", String( id ) );
                            id := id + 1;
                            
                            extracted_expression_template.args.2.bindings.BINDING_RETURN_VALUE := tree.(key);
                            
                            func.nams := Concatenation( func.nams, [ new_variable_name ] );
                            
                            #Display( "start" );
                            #Display( extracted_expression_template );
                            
                            #Display( "finished" );
                            
                            CapJitAddBinding( func.bindings, new_variable_name, CapJitCopyWithNewFunctionIDs( extracted_expression_template ) );
                            
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
                    
                    return rec( levels := levels, binding_levels := binding_levels, children := result );
                    
                end;
                
                additional_arguments_func := function ( tree, key, func_stack )
                    
                    if tree.type = "EXPR_DECLARATIVE_FUNC" then
                        
                        return Concatenation( func_stack, [ tree ] );
                        
                    fi;
                    
                    return func_stack;
                    
                end;
                
                #CapJitIterateOverTreeWithCachedBindingResults( loop_func, ReturnFirst, result_func, additional_arguments_func, func_stack );
                # we have no logic for hoisting bindings, so we must not use CapJitIterateOverTreeWithCachedBindingResults
                CapJitIterateOverTree( loop_func, ReturnFirst, result_func, additional_arguments_func, func_stack );
                
                if id <> old_id then
                    
                    #CapJitAddBinding( func.bindings, domain_variable_name, tree.args.1 );
                    
                    #tree.args.1 := rec(
                    #    type := "EXPR_REF_FVAR",
                    #    func_id := func.id,
                    #    name := domain_variable_name,
                    #);
                    
                    tree.funcref.gvar := Concatenation( tree.funcref.gvar, "WithKeys" );
                    
                    loop_func.narg := 2;
                    Add( loop_func.nams, "key", 1 );
                    
                fi;
                
                Display( ENHANCED_SYNTAX_TREE_CODE( orig_tree ) );
                #Error("here");
                
            fi;
            
        fi;
        
        return rec( levels := levels, binding_levels := binding_levels, children := result );
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        fi;
        
        return func_stack;
        
    end;
    
    if not only_hoist_bindings then
        
        #Display( "##############################" );
        #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
        
        #CapJitIterateOverTreeWithCachedBindingResults( tree, pre_func, result_func, additional_arguments_func, [ ] );
        # we have no logic for hoisting bindings, so we must not use CapJitIterateOverTreeWithCachedBindingResults
        CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, [ ] );
        
        #tree := CapJitDroppedUnusedBindings( tree );
        
        #Display( "##############################" );
        #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
        #Error("qwe");
        
    fi;
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    expressions_to_hoist := rec( );
    references_to_function_variables := rec( );
    
    result_func := function ( tree, result, keys, func_stack )
      local levels, level, type_matches, pos, func_id, name;
        
        levels := Union( List( keys, name -> result.(name) ) );
        
        if tree.type = "EXPR_REF_FVAR" then
            
            # if EXPR_REF_FVAR references a function argument, `result` will be a record
            if IsList( result ) then
                
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
            # TODO
            if name = "BINDING_RETURN_VALUE" then
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
                        
                        if info2.parent.type = "FVAR_BINDING_SEQ" then
                            
                            #Assert( 0,  );
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
