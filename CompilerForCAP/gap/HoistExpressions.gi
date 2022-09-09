# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

InstallGlobalFunction( CapJitHoistedExpressions, function ( tree )
    
    #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    return CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS( tree, false );
    
end );

InstallGlobalFunction( CapJitHoistedBindings, function ( tree )
    
    #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    #Display( "in bindings" );
    Display( "bindings" );
    
    return CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS( tree, true );
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_HOISTED_EXPRESSIONS_OR_BINDINGS, function ( tree, only_hoist_bindings )
  local expressions_to_hoist, references_to_function_variables, pre_func, result_func, additional_arguments_func;
    
    # functions and hoisted variables will be modified inline
    tree := StructuralCopy( tree );
    
    expressions_to_hoist := rec( );
    references_to_function_variables := rec( );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            expressions_to_hoist.(tree.id) := [ ];
            
        fi;
        
        if CapJitIsCallToGlobalFunction( tree, gvar -> gvar in [ "ObjectifyObjectForCAPWithAttributes", "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" ] ) then
            
            # special case: the first argument of Objectify*WithAttributes is affected by side effects and thus must not be hoisted
            tree.args.1.CAP_JIT_DO_NOT_HOIST := true;
            
        fi;
        
        #if not only_hoist_bindings and CapJitIsCallToGlobalFunction( tree, gvar -> gvar in [ "List", "Sum", "Product" ] ) and tree.args.length = 2 and tree.args.2.type = "EXPR_DECLARATIVE_FUNC" then
        #    
        #    tree := ShallowCopy( tree );
        #    tree.funcref := ShallowCopy( tree.funcref );
        #    tree.funcref.gvar := Concatenation( tree.funcref.gvar, "WithKeys" );
        #    
        #    tree.args := ShallowCopy( tree.args );
        #    tree.args.2 := ShallowCopy( tree.args.2 );
        #    
        #    Assert( 0, tree.args.2.narg = 1 );
        #    
        #    tree.args.2.narg := 2;
        #    tree.args.2.nams := Concatenation( [ "key" ], tree.args.2.nams );
        #    
        #fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, func_stack )
      local levels, func, domain, expressions_needing_domain, new_level, domain_level, type_matches, pos, func_id, new_levels, max_new_level, open_levels, non_open_levels, info, name, level;
        
        levels := Union( List( keys, name -> result.(name) ) );
        
        #if not only_hoist_bindings and CapJitIsCallToGlobalFunction( tree, gvar -> gvar in [ "ListWithKeys", "SumWithKeys", "ProductWithKeys" ] ) and tree.args.length = 2 and tree.args.2.type = "EXPR_DECLARATIVE_FUNC" then
        if not only_hoist_bindings and CapJitIsCallToGlobalFunction( tree, gvar -> gvar in [ "List", "Sum", "Product" ] ) and tree.args.length = 2 and tree.args.2.type = "EXPR_DECLARATIVE_FUNC" then
            
            # check if tree.args.1 is hoisted
            for domain_level in [ 1 .. Length( func_stack ) ] do
                
                func := func_stack[domain_level];
                
                if not IsEmpty( expressions_to_hoist.(func.id) ) and IsIdenticalObj( Last( expressions_to_hoist.(func.id) ).parent, tree.args ) then
                    
                    domain := Last( expressions_to_hoist.(func.id) );
                    
                    # the second argument is a function expression and thus is never hoisted
                    Assert( 0, domain.key = "1" );
                    
                    # get those needing a domain
                    expressions_needing_domain := Filtered( expressions_to_hoist.(tree.args.2.id), x -> IsBound( x.domains ) );
                    
                    for info in expressions_needing_domain do
                        
                        if Last( info.levels ) = Length( func_stack ) + 1 then
                            info.domains[Length( info.levels )] := domain;
                            info.funccalls[Length( info.levels )] := tree;
                            Remove( info.levels );
                            
                            new_level := MaximumList( Concatenation( [ domain_level ], info.levels ), 1 );
                            
                            Assert( 0, StartsWith( info.func_stack, func_stack ) );
                            
                            Add( expressions_to_hoist.(info.func_stack[new_level].id), info );
                            
                        fi;
                        
                    od;
                    
                    # only keep those not needing a domain
                    expressions_to_hoist.(tree.args.2.id) := Filtered( expressions_to_hoist.(tree.args.2.id), x -> not IsBound( x.domains ) );
                    
                    break;
                    
                fi;
                
            od;
            
        fi;
        
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
            
            Assert( 0, IsEmpty( levels ) );
            
            # references to variables always restrict the scope to the corresponding function
            AddSet( levels, PositionProperty( func_stack, f -> f.id = tree.func_id ) );
            
        elif tree.type = "FVAR_BINDING_SEQ" then
            
            # bindings restrict the scope to the current function
            AddSet( levels, Length( func_stack ) );
            
        elif tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # a function binds its variables, so the level of the function variables can be ignored (at this point, the function stack does not yet include the current func)
            RemoveSet( levels, Length( func_stack ) + 1 );
            
        fi;
        
        # we do not want to create global variables, because this would break precompilation -> the minimum level is 1
        level := MaximumList( levels, 1 );
        
        for name in keys do
            
            if IsBound( tree.(name).CAP_JIT_DO_NOT_HOIST ) and tree.(name).CAP_JIT_DO_NOT_HOIST = true then
                
                # we do not need this information anymore
                Unbind( tree.(name).CAP_JIT_DO_NOT_HOIST );
                
                continue;
                
            fi;
            
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
                
                Add( expressions_to_hoist.(func_id), rec(
                    parent := tree,
                    key := name,
                    old_func := Last( func_stack ),
                ) );
                
            elif not only_hoist_bindings and type_matches and not IsEmpty( result.(name) ) and result.(name) <> levels then
                
                new_levels := Difference( levels, result.(name) );
                
                # By construction we have result.(name) ⊆ levels.
                # Since we are in the case result.(name) ≠ levels, we must have result.(name) ⊊ levels, i.e. levels \ result.(name) ≠ ∅.
                Assert( 0, not IsEmpty( new_levels ) );
                
                if new_levels = [ 1 ] then
                    
                    # we have detected an expression which is independent of level 1, i.e. could be fully precomputed
                    # we do not handle this yet -> ignore
                    continue;
                    
                fi;
                
                max_new_level := MaximumList( new_levels );
                
                open_levels := Filtered( result.(name), x -> x > max_new_level );
                
                # We have: max_new_level = MaximumList( new_levels ) ≤ MaximumList( levels, 1 ) = level ≤ MaximumList( result.(name), 1 ) = MaximumList( result.(name) ),
                # where the last inequality holds because we are in the else case and the last equality holds because result.(name) is non-empty and can only contain numbers ≥ 1.
                # Since new_levels ∩ result.(name) = ∅ by construction, we cannot have equality, i.e. we have max_new_level < MaximumList( result.(name) ).
                # This, there exists x ∈ result.(name) such that x > max_new_level, i.e. open_levels ≠ ∅.
                Assert( 0, not IsEmpty( open_levels ) );
                
                if Length( open_levels ) = 1 then
                    
                    Assert( 0, Last( levels ) = open_levels[1] );
                    
                    func_id := func_stack[Last( levels )].id;
                    
                    Add( expressions_to_hoist.(func_id), rec(
                        parent := tree,
                        key := name,
                        #old_func := Last( func_stack ),
                        levels := result.(name),
                        domains := [],
                        funccalls := [],
                        #non_open_levels := Filtered( result.(name), x -> x < max_new_level ),
                        func_stack := func_stack,
                    ) );
                    
                else
                    
                    #Display( tree );
                    #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
                    #Error( "nice opportunity, but not yet handled" );
                    
                fi;
                
            fi;
            
        od;
        
        return levels;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            return Concatenation( func_stack, [ tree ] );
            
        fi;
        
        return func_stack;
        
    end;
    
    # populate `expressions_to_hoist`
    CapJitIterateOverTreeWithCachedBindingResults( tree, pre_func, result_func, additional_arguments_func, [ ] );
    
    # now actually hoist the expressions
    pre_func := function ( tree, additional_arguments )
      local id, info, parent, key, expr, new_variable_name, to_delete, info2, old_variable_name, old_func, i, ref;
        
        if IsBound( tree.CAP_JIT_STOP_HOISTING ) then
            
            Unbind( tree.CAP_JIT_STOP_HOISTING );
            
            return fail;
            
        fi;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" and not IsEmpty( expressions_to_hoist.(tree.id) ) then
            
            id := CapJitGetNextUnusedVariableID( tree );
            
            while Length( expressions_to_hoist.(tree.id) ) > 0 do
                
                info := expressions_to_hoist.(tree.id)[1];
                
                parent := info.parent;
                key := info.key;
                expr := parent.(key);
                
                #if IsBound( info.domain ) and info.domain = fail then
                #    
                #    Remove( expressions_to_hoist.(tree.id), 1 );
                #    continue;
                #    
                #fi;
                
                if IsBound( info.domains ) then
                    
                    if ForAny( info.domains, d -> not IsBound( d.new_func_id ) ) then
                        
                        Error("this should never happen123");
                        continue;
                        
                    fi;
                    
                    # do not hoist if `expr` already is of the form `hoisted[index]`
                    if CapJitIsCallToGlobalFunction( expr, "[]" ) and expr.args.1.type = "EXPR_REF_FVAR" and StartsWith( expr.args.1.name, "hoisted" ) then
                        
                        #if not expr.args.1.type = "EXPR_REF_FVAR" and StartsWith( expr.args.1.name, "hoisted" ) then
                        
                        
                        #Error("here");
                        
                        Remove( expressions_to_hoist.(tree.id), 1 );
                        
                        continue;
                        
                    fi;
                    
                    new_variable_name := Concatenation( "extracted_", String( id ) );
                    id := id + 1;
                    
                    tree.nams := Concatenation( tree.nams, [ new_variable_name ] );
                    
                    Remove( expressions_to_hoist.(tree.id), 1 );
                    
                    #Assert( 0, IsIdenticalObj( info.funccall.args.2, info.old_func ) );
                    
                    if Last( info.funccalls ).funcref.gvar in [ "List", "Sum", "Product" ] then
                        
                        #Error("this should never happen");
                        Last( info.funccalls ).funcref.gvar := Concatenation( Last( info.funccalls ).funcref.gvar, "WithKeys" );
                        
                        Assert( 0, Last( info.funccalls ).args.2.narg = 1 );
                        Last( info.funccalls ).args.2.narg := 2;
                        Add( Last( info.funccalls ).args.2.nams, "key", 1 );
                        
                    elif Last( info.funccalls ).funcref.gvar in [ "ListWithKeys", "SumWithKeys", "ProductWithKeys" ] then
                        
                        # already handled
                        
                    else
                        
                        Error( "this should never happen" );
                        
                    fi;
                    
                    Assert( 0, Last( info.funccalls ).funcref.gvar in [ "ListWithKeys", "SumWithKeys", "ProductWithKeys" ] );
                    Assert( 0, Last( info.funccalls ).args.2.narg = 2 );
                    
                    CapJitAddBinding( tree.bindings, new_variable_name, rec(
                        CAP_JIT_STOP_HOISTING := true,
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := "ListWithKeys",
                        ),
                        args := AsSyntaxTreeList( [
                            rec(
                                type := "EXPR_REF_FVAR",
                                func_id := Last( info.domains ).new_func_id,
                                name := Last( info.domains ).new_name,
                            ),
                            CapJitCopyWithNewFunctionIDs( rec(
                            #rec(
                                type := "EXPR_DECLARATIVE_FUNC",
                                id := Last( info.funccalls ).args.2.id,
                                narg := 2,
                                variadic := false,
                                nams := [ Last( info.funccalls ).args.2.nams[1], Last( info.funccalls ).args.2.nams[2], "RETURN_VALUE" ],
                                bindings := rec(
                                    type := "FVAR_BINDING_SEQ",
                                    names := [ "RETURN_VALUE" ],
                                    BINDING_RETURN_VALUE := expr,
                                ),
                            #),
                            ) ),
                        ] ),
                    ) );
                    
                    #expressions_to_hoist.(CapJitValueOfBinding( tree.bindings, new_variable_name ).args.2.id) := [ ];
                    
                    info.parent.(info.key) := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := rec(
                            type := "EXPR_REF_GVAR",
                            gvar := "[]",
                        ),
                        args := AsSyntaxTreeList( [
                            rec(
                                type := "EXPR_REF_FVAR",
                                func_id := tree.id,
                                name := new_variable_name,
                            ),
                            rec(
                                type := "EXPR_REF_FVAR",
                                func_id := Last( info.funccalls ).args.2.id,
                                name := "key",
                            ),
                        ] ),
                    );
                    
                    continue;
                    
                fi;
                
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
                        
                        info2.new_func_id := tree.id;
                        info2.new_name := new_variable_name;
                        
                        Add( to_delete, i );
                        
                    fi;
                    
                od;
                
                Assert( 0, 1 in to_delete );
                
                expressions_to_hoist.(tree.id) := expressions_to_hoist.(tree.id){Difference( [ 1 .. Length( expressions_to_hoist.(tree.id) ) ], to_delete )};
                
            od;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, additional_arguments )
      local key;
        
        tree := ShallowCopy( tree );
        
        if result = fail then
            
            return tree;
            
        fi;
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        return tree;
        
    end;
    
    #return CapJitCopyWithNewFunctionIDs( CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true ) );
    tree := CapJitIterateOverTree( tree, pre_func, result_func, ReturnTrue, true );
    
    #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    return tree;
    
end );
