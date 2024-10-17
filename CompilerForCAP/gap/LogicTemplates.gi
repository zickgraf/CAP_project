# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
BindGlobal( "CAP_JIT_LOGIC_TEMPLATES", [ ] );
InstallGlobalFunction( CapJitAddLogicTemplate, function ( template )
    
    # the logic template will later be enhanced in-place -> make a copy
    template := StructuralCopy( template );
    
    CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE( template );
    
    Add( CAP_JIT_LOGIC_TEMPLATES, template );
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_ENHANCE_LOGIC_TEMPLATE, function ( template )
  local diff, variable_name, unbound_global_variable_names, syntax_tree_variables_ids, pre_func_identify_syntax_tree_variables, additional_arguments_func_identify_syntax_tree_variables, tmp_tree, pre_func, additional_arguments_func, i;
    
    if IsBound( template.is_fully_enhanced ) and template.is_fully_enhanced = true then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the logic template is already fully enhanced" );
        
    fi;
    
    # some basic sanity checks
    if not IsRecord( template ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic template must be a record" );
        
    fi;
    
    if not IsSubset( RecNames( template ), [ "variable_names", "src_template", "dst_template" ] ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic template must have the following required record entries: variable_names, src_template, dst_template" );
        
    fi;
    
    diff := Difference( RecNames( template ), [ "variable_names", "variable_filters", "src_template", "src_template_tree", "dst_template", "dst_template_tree", "new_funcs", "number_of_applications", "apply_in_proof_assistant_mode", "debug", "debug_path" ] );
    
    if not IsEmpty( diff ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a logic template has unknown components: ", diff );
        
    fi;
    
    for variable_name in template.variable_names do
        
        if variable_name in GAPInfo.Keywords then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "\"", variable_name, "\" (contained in variable_names) is a keyword. This is not supported." );
            
        fi;
        
    od;
    
    if Last( NormalizedWhitespace( template.src_template ) ) = ';' then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "src_template ends with a semicolon. This is not supported." );
        
    fi;
    
    if Last( NormalizedWhitespace( template.dst_template ) ) = ';' then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "dst_template ends with a semicolon. This is not supported." );
        
    fi;
    
    if IsBound( template.variable_filters ) then
        
        # replace strings with actual filters
        template.variable_filters := List( template.variable_filters, function ( f )
            
            if IsString( f ) then
                
                return ValueGlobal( f );
                
            else
                
                return f;
                
            fi;
            
        end );
        
    else
        
        # default variable filters: IsObject
        template.variable_filters := ListWithIdenticalEntries( Length( template.variable_names ), IsObject );
        
    fi;
    
    if Length( template.variable_names ) <> Length( template.variable_filters ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the length of the record entries variable_names and variable_filters of a logic template must be equal" );
        
    fi;
    
    if not ForAll( template.variable_filters, f -> IsFilter( f ) or IsRecord( f ) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the entries of variable_filters must be filters or records" );
        
    fi;
    
    # default new funcs: none
    if not IsBound( template.new_funcs ) then
        
        template.new_funcs := [ ];
        
    fi;
    
    # default number of applications: infinity
    if not IsBound( template.number_of_applications ) then
        
        template.number_of_applications := infinity;
        
    fi;
    
    if not (IsPosInt( template.number_of_applications ) or IsInfinity( template.number_of_applications )) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "number_of_applications must be a positive integer or infinity" );
        
    fi;
    
    # apply in proof assistant mode by default
    if not IsBound( template.apply_in_proof_assistant_mode ) then
        
        template.apply_in_proof_assistant_mode := "yes";
        
    fi;
    
    if not template.apply_in_proof_assistant_mode in [ "yes", "no", "only" ] then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "apply_in_proof_assistant_mode must be \"yes\", \"no\", or \"only\"" );
        
    fi;
    
    pre_func_identify_syntax_tree_variables := function ( tree, outer_func_id )
      local id;
        
        # `IsBoundGlobal` calls `CheckGlobalName`, which warns about names containing characters not in `IdentifierLetters`.
        # This is expected for operations in CAP_JIT_INTERNAL_OPERATION_TO_SYNTAX_TREE_TRANSLATIONS, so we avoid IsBoundGlobal in this case.
        if tree.type = "EXPR_REF_GVAR" and not IsBound( CAP_JIT_INTERNAL_OPERATION_TO_SYNTAX_TREE_TRANSLATIONS.(tree.gvar) ) and not IsBoundGlobal( tree.gvar ) then
            
            # for debugging only
            # COVERAGE_IGNORE_NEXT_LINE
            AddSet( unbound_global_variable_names, tree.gvar );
            
        fi;
        
        if tree.type = "EXPR_REF_FVAR" and tree.func_id = outer_func_id then
            
            if IsBound( tree.data_type ) then
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "using CapJitTypedExpression with logic template variables is currently not supported, use variable_filters instead" );
                
            fi;
            
            id := SafeUniquePosition( template.variable_names, tree.name );
            
            AddSet( syntax_tree_variables_ids, id );
            
            return rec(
                type := "SYNTAX_TREE_VARIABLE",
                id := id,
            );
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func_identify_syntax_tree_variables := function ( tree, key, outer_func_id )
        
        return outer_func_id;
        
    end;
    
    # get src_template_tree from src_template
    if not IsBound( template.src_template_tree ) then
        
        # to get a syntax tree we have to wrap the template in a function
        tmp_tree := ENHANCED_SYNTAX_TREE( EvalStringStrict( Concatenation( "{ ", JoinStringsWithSeparator( template.variable_names, ", " ), " } -> ", template.src_template ) ) );
        
        Assert( 0, tmp_tree.bindings.names = [ "RETURN_VALUE" ] );
        
        unbound_global_variable_names := [ ];
        
        syntax_tree_variables_ids := [ ];
        
        template.src_template_tree := CapJitIterateOverTree( CapJitValueOfBinding( tmp_tree.bindings, "RETURN_VALUE" ), pre_func_identify_syntax_tree_variables, CapJitResultFuncCombineChildren, additional_arguments_func_identify_syntax_tree_variables, tmp_tree.id );
        
        if not IsEmpty( unbound_global_variable_names ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "found the following unbound global variables in src_template, they should probably be listed in variable_names: ", unbound_global_variable_names );
            
        fi;
        
        Assert( 0, IsSubset( [ 1 .. Length( template.variable_names ) ], syntax_tree_variables_ids ) );
        
        if Length( syntax_tree_variables_ids ) < Length( template.variable_names ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "The following variable names do not appear in src_template: ", template.variable_names{Difference( [ 1 .. Length( template.variable_names ) ], syntax_tree_variables_ids )}, ". This is not supported." );
            
        fi;
        
    fi;
    
    # get dst_template_tree from dst_template
    if not IsBound( template.dst_template_tree ) then
        
        # to get a syntax tree we have to wrap the template in a function
        tmp_tree := ENHANCED_SYNTAX_TREE( EvalStringStrict( Concatenation( "{ ", JoinStringsWithSeparator( template.variable_names, ", " ), " } -> ", template.dst_template ) ) );
        
        Assert( 0, tmp_tree.bindings.names = [ "RETURN_VALUE" ] );
        
        unbound_global_variable_names := [ ];
        
        template.dst_template_tree := CapJitIterateOverTree( CapJitValueOfBinding( tmp_tree.bindings, "RETURN_VALUE" ), pre_func_identify_syntax_tree_variables, CapJitResultFuncCombineChildren, additional_arguments_func_identify_syntax_tree_variables, tmp_tree.id );
        
        if not IsEmpty( unbound_global_variable_names ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "found the following unbound global variables in dst_template, there probably is a typo: ", unbound_global_variable_names );
            
        fi;
        
    fi;
    
    # Match functions in dst_template_tree to those in src_template_tree and set function IDs accordingly.
    # Functions from src_template_tree can appear multiple times in dst_template_tree, so in dst_template_tree the same function ID can occur multiple times.
    # However, we do not allow the same ID to occur multiple times in a single function stack, as this would cause ambiguities.
    
    template.new_funcs_corresponding_src_funcs := [ ];
    
    pre_func := function ( tree, func_id_stack )
      local dst_func, pos, condition_func, src_template_paths, src_func, pre_func;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            dst_func := tree;
            
            pos := Position( template.new_funcs, dst_func.nams{[ 1 .. dst_func.narg ]} );
            
            # if this is not a new function, find matching function in src_template_tree
            if pos = fail then
                
                condition_func := function ( tree, path )
                    
                    return tree.type = "EXPR_DECLARATIVE_FUNC" and tree.nams = dst_func.nams;
                    
                end;
                
                src_template_paths := CapJitFindNodes( template.src_template_tree, condition_func );
                
                if Length( src_template_paths ) = 0 then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "could not find matching func in src_template" );
                    
                elif Length( src_template_paths ) > 1 then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "found multiple matching funcs in src_template" );
                    
                fi;
                
                src_func := CapJitGetNodeByPath( template.src_template_tree, src_template_paths[1] );
                
                Assert( 0, src_func.nams = dst_func.nams );
                
                if src_func.id in func_id_stack then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "A function in src_template is used multiple times in dst_template in a nested way. This is not supported." );
                    
                fi;
                
                dst_func := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( dst_func, src_func.id, src_func.nams );
                
            fi;
            
            return dst_func;
            
        fi;
        
        # detect `List( SYNTAX_TREE_VARIABLE, x -> ... )` where `x -> ...` is a new function
        if CapJitIsCallToGlobalFunction( tree, "List" ) and tree.args.1.type = "SYNTAX_TREE_VARIABLE" and tree.args.2.type = "EXPR_DECLARATIVE_FUNC" then
            
            dst_func := tree.args.2;
            
            pos := Position( template.new_funcs, dst_func.nams{[ 1 .. dst_func.narg ]} );
            
            if pos <> fail then
                
                # detect `List( SYNTAX_TREE_VARIABLE, func )` in src_template_tree
                pre_func := function ( src_tree, additional_arguments )
                    
                    if IsBound( template.new_funcs_corresponding_src_funcs[pos] ) then
                        
                        return fail;
                        
                    fi;
                    
                    if CapJitIsCallToGlobalFunction( src_tree, "List" ) and src_tree.args.1.type = "SYNTAX_TREE_VARIABLE" and src_tree.args.1.id = tree.args.1.id and src_tree.args.2.type in [ "SYNTAX_TREE_VARIABLE", "EXPR_DECLARATIVE_FUNC" ] then
                        
                        template.new_funcs_corresponding_src_funcs[pos] := src_tree.args.2;
                        
                    fi;
                    
                    return src_tree;
                    
                end;
                
                CapJitIterateOverTree( template.src_template_tree, pre_func, ReturnTrue, ReturnTrue, true );
                
            fi;
            
        fi;
        
        # detect `ListN( SYNTAX_TREE_VARIABLE_1, SYNTAX_TREE_VARIABLE_2, { x, y } -> ... )` where `{ x, y } -> ...` is a new function
        if CapJitIsCallToGlobalFunction( tree, "ListN" ) and tree.args.1.type = "SYNTAX_TREE_VARIABLE" and tree.args.2.type = "SYNTAX_TREE_VARIABLE" and tree.args.3.type = "EXPR_DECLARATIVE_FUNC" then
            
            dst_func := tree.args.3;
            
            pos := Position( template.new_funcs, dst_func.nams{[ 1 .. dst_func.narg ]} );
            
            if pos <> fail then
                
                # detect `ListN( SYNTAX_TREE_VARIABLE_1, SYNTAX_TREE_VARIABLE_2, func )` in src_template_tree
                pre_func := function ( src_tree, additional_arguments )
                    
                    if IsBound( template.new_funcs_corresponding_src_funcs[pos] ) then
                        
                        return fail;
                        
                    fi;
                    
                    if CapJitIsCallToGlobalFunction( src_tree, "ListN" ) and src_tree.args.1.type = "SYNTAX_TREE_VARIABLE" and src_tree.args.1.id = tree.args.1.id and src_tree.args.2.type = "SYNTAX_TREE_VARIABLE" and src_tree.args.2.id = tree.args.2.id and src_tree.args.3.type in [ "SYNTAX_TREE_VARIABLE", "EXPR_DECLARATIVE_FUNC" ] then
                        
                        template.new_funcs_corresponding_src_funcs[pos] := src_tree.args.3;
                        
                    fi;
                    
                    return src_tree;
                    
                end;
                
                CapJitIterateOverTree( template.src_template_tree, pre_func, ReturnTrue, ReturnTrue, true );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_id_stack, [ tree.id ] );
            
        else
            
            return func_id_stack;
            
        fi;
        
    end;
    
    template.dst_template_tree := CapJitIterateOverTree( template.dst_template_tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ ] );
    
    template.is_fully_enhanced := true;
    
end );

# x -> x => ID_FUNC
CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "x -> x",
        dst_template := "ID_FUNC",
    )
);

# ID_FUNC( value ) => value
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "ID_FUNC( value )",
        dst_template := "value",
    )
);

# List( list, ID_FUNC ) => list
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list" ],
        variable_filters := [ IsList ],
        src_template := "List( list, ID_FUNC )",
        dst_template := "list",
    )
);

# List( List( L, f ), g ) => List( L, x -> g( f( x ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "outer_func", "inner_func" ],
        src_template := "List( List( list, inner_func ), outer_func )",
        dst_template := "List( list, x -> outer_func( inner_func( x ) ) )",
        new_funcs := [ [ "x" ] ],
    )
);

# List( list, x -> func( x ) ) => List( list, func )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "func" ],
        src_template := "List( list, x -> func( x ) )",
        dst_template := "List( list, func )",
    )
);

# List( ListN( L1, L2, f ), g ) => ListN( L1, L2, { x, y } -> g( f( x, y ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list1", "list2", "outer_func", "inner_func" ],
        src_template := "List( ListN( list1, list2, inner_func ), outer_func )",
        dst_template := "ListN( list1, list2, { x, y } -> outer_func( inner_func( x, y ) ) )",
        new_funcs := [ [ "x", "y" ] ],
    )
);

# ListN( List( L, f1 ), List( L, f2 ), g ) => List( L, x -> g( f1( x ), f2( x ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "inner_func1", "inner_func2", "outer_func" ],
        src_template := "ListN( List( list, inner_func1 ), List( list, inner_func2 ), outer_func )",
        dst_template := "List( list, x -> outer_func( inner_func1( x ), inner_func2( x ) ) )",
        new_funcs := [ [ "x" ] ],
    )
);

# List( Concatenation( list ), func ) => Concatenation( List( list, x -> List( x, func ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "func" ],
        src_template := "List( Concatenation( list ), func )",
        dst_template := "Concatenation( List( list, x -> List( x, func ) ) )",
        new_funcs := [ [ "x" ] ],
    )
);

# List( L{poss}, f ) => List( L, f ){poss}
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "poss", "func" ],
        src_template := "List( list{poss}, func )",
        dst_template := "List( list, func ){poss}",
    )
);

# func( L[index] ) => List( L, func )[index]
# Note: We always "push down" the function, because:
# If L is a `Concatenation`, we cannot resolve the index on the left hand side, but we can push the function further down on the right hand side.
# Moreover, `index` often introduces new variables, so the right hand side allows more hoisting and deduplication.
# This causes some minor overhead if the index is fixed (e.g. for ProjectionInFactorOfDirectSum) because f is applied to the whole list
# instead of only the element given by the index, but such examples are rare.
# Additionally, this should only trigger for homogeneous lists, i.e. `func` must be applicable to all elements of `L`.
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "list", "func", "index" ],
#        variable_filters := [ IsList, IsFunction, IsInt ],
#        src_template := "func( list[index] )",
#        dst_template := "List( list, func )[index]",
#        apply_in_proof_assistant_mode := "no",
#    )
#);

# List( list_of_lists[index], func ) => List( list_of_lists, list -> List( list, func ) )[index]
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "list_of_lists", "index", "func" ],
#        variable_filters := [ IsList, IsInt, IsFunction ],
#        src_template := "List( list_of_lists[index], func )",
#        dst_template := "List( list_of_lists, list -> List( list, func ) )[index]",
#        new_funcs := [ [ "list" ] ],
#        apply_in_proof_assistant_mode := "no",
#    )
#);

# In proof assistant mode, performance (and in particular hoisting and deduplication) is irrelevant.
# Instead, evaluating a function applied to a list at a given index makes the code more readable.
# Hence, we apply the reverse of the above templates.
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "list", "func", "index" ],
#        variable_filters := [ IsList, IsFunction, IsInt ],
#        src_template := "List( list, func )[index]",
#        dst_template := "func( list[index] )",
#        apply_in_proof_assistant_mode := "only",
#    )
#);

# Length( List( list, func ) ) => Length( list )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "func" ],
        src_template := "Length( List( list, func ) )",
        dst_template := "Length( list )",
    )
);

# Length( [ 1 .. n ] ) => n
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "n" ],
        src_template := "Length( [ 1 .. n ] )",
        dst_template := "n",
    )
);

# [ 1 .. range_end ][i] => i
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "range_end", "index" ],
        src_template := "[ 1 .. range_end ][index]",
        dst_template := "index",
    )
);

# Iterated: function always choosing first value
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "initial_value" ],
        src_template := "Iterated( list, { x, y } -> x, initial_value )",
        dst_template := "initial_value",
    )
);

# Iterated: function always choosing first value
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "initial_value", "terminal_value" ],
        src_template := "Iterated( list, { x, y } -> x, initial_value, terminal_value )",
        dst_template := "initial_value",
    )
);

# Iterated: function always choosing last value
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "initial_value", "terminal_value" ],
        src_template := "Iterated( list, { x, y } -> y, initial_value, terminal_value )",
        dst_template := "terminal_value",
    )
);

InstallGlobalFunction( CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE, function ( tree, template_tree, variable_filters, debug )
  local i, variables, func_id_replacements, pre_func, result_func, additional_arguments_func, result;
    
    # bail out early if type mismatches
    if template_tree.type <> "SYNTAX_TREE_VARIABLE" and tree.type <> template_tree.type then
        
        return fail;
        
    fi;
    
    # after inlining, most syntax tree nodes are of type EXPR_FUNCCALL -> we can bail out early for some frequent conditions (i.e. check the type of funcref and args)
    if template_tree.type = "EXPR_FUNCCALL" then
        
        # by the check above, tree.type = template_tree.type = "EXPR_FUNCCALL"
        
        if template_tree.funcref.type <> "SYNTAX_TREE_VARIABLE" then
            
            if tree.funcref.type <> template_tree.funcref.type then
                
                return fail;
                
            fi;
            
            if template_tree.funcref.type = "EXPR_REF_GVAR" then
                
                if
                    not IsIdenticalObj( ValueGlobal( tree.funcref.gvar ), ValueGlobal( template_tree.funcref.gvar ) ) and
                    not (template_tree.funcref.gvar in [ "Range", "Target" ] and tree.funcref.gvar in [ "Range", "Target" ] and IsBound( tree.funcref.data_type ) and IsSpecializationOfFilter( IsCapCategoryMorphism, tree.funcref.data_type.signature[1][1].filter ))
                then
                    
                    return fail;
                    
                fi;
                
            fi;
            
        fi;
        
        if tree.args.length <> template_tree.args.length then
            
            return fail;
            
        fi;
        
        for i in [ 1 .. template_tree.args.length ] do
            
            if template_tree.args.(i).type <> "SYNTAX_TREE_VARIABLE" and tree.args.(i).type <> template_tree.args.(i).type then
                
                return fail;
                
            fi;
            
        od;
        
    fi;
    
    variables := [ ];
    func_id_replacements := rec( );
    
    pre_func := function ( template_tree, tree )
      local new_template_tree;
        
        if template_tree.type <> "SYNTAX_TREE_VARIABLE" and tree.type <> template_tree.type then
            
            return fail;
            
        fi;
        
        if template_tree.type = "SYNTAX_TREE_LIST" and template_tree.length <> tree.length then
            
            return fail;
            
        fi;
        
        if template_tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            Assert( 0, tree.type = "EXPR_DECLARATIVE_FUNC" );
            
            # we are only interested in two cases:
            # a) the functions actually only differ by ID, i.e. the names of all local variables and bindings agree
            # b) there are no local variables (i.e. only a single return statement), but the argument names might differ
            if template_tree.narg = tree.narg and template_tree.variadic = tree.variadic and ((template_tree.nams = tree.nams and template_tree.bindings.names = tree.bindings.names) or (Length( template_tree.nams ) = template_tree.narg + 1 and Length( tree.nams ) = tree.narg + 1 )) then
                
                Assert( 0, not IsBound( func_id_replacements.(template_tree.id) ) );
                
                # map from template function to actual function
                func_id_replacements.(template_tree.id) := rec(
                    func_id := tree.id,
                    nams := tree.nams,
                );
                
                template_tree := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( template_tree, tree.id, tree.nams );
                
            else
                
                return fail;
                
            fi;
            
        fi;
        
        return template_tree;
        
    end;
    
    result_func := function ( template_tree, result, keys, tree )
      local var_number, filter_or_data_type, key;
        
        if debug then
            # COVERAGE_IGNORE_BLOCK_START
            Display( "now matching against" );
            Display( template_tree );
            Display( "result" );
            Display( result );
            # COVERAGE_IGNORE_BLOCK_END
        fi;
        
        # check if we already bailed out in pre_func
        if result = fail then
            
            return false;
            
        fi;
        
        # handle syntax tree variables
        if template_tree.type = "SYNTAX_TREE_VARIABLE" then
            
            var_number := template_tree.id;
            
            if not IsBound( variables[var_number] ) then
                
                filter_or_data_type := variable_filters[var_number];
                
                if IsRecord( filter_or_data_type ) then
                    
                    if IsBound( tree.data_type ) and tree.data_type = filter_or_data_type then
                        
                        variables[var_number] := tree;
                        
                        if debug then
                            # COVERAGE_IGNORE_BLOCK_START
                            Display( "matched via new variable with data type" );
                            Display( true );
                            # COVERAGE_IGNORE_BLOCK_END
                        fi;
                        
                        return true;
                        
                    else
                        
                        if debug then
                            # COVERAGE_IGNORE_BLOCK_START
                            Display( "type could not be inferred or did not match" );
                            # COVERAGE_IGNORE_BLOCK_END
                        fi;
                        
                        return false;
                        
                    fi;
                    
                    
                elif IsFilter( filter_or_data_type ) then
                    
                    if IsIdenticalObj( filter_or_data_type, IsObject ) or (IsBound( tree.data_type ) and IsSpecializationOfFilter( filter_or_data_type, tree.data_type.filter )) then
                        
                        variables[var_number] := tree;
                        
                        if debug then
                            # COVERAGE_IGNORE_BLOCK_START
                            Display( "matched via new variable with filter" );
                            Display( true );
                            # COVERAGE_IGNORE_BLOCK_END
                        fi;
                        
                        return true;
                        
                    else
                        
                        if debug then
                            # COVERAGE_IGNORE_BLOCK_START
                            Display( "data type could not be inferred or did not match (variable_filters)" );
                            # COVERAGE_IGNORE_BLOCK_END
                        fi;
                        
                        return false;
                        
                    fi;
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "this should never happen" );
                    
                fi;
                
            else
                
                if debug then
                    # COVERAGE_IGNORE_BLOCK_START
                    Display( "matched via existing variable" );
                    Display( CapJitIsEqualForEnhancedSyntaxTrees( variables[var_number], tree ) );
                    # COVERAGE_IGNORE_BLOCK_END
                fi;
                
                return CapJitIsEqualForEnhancedSyntaxTrees( variables[var_number], tree );
                
            fi;
            
        fi;
        
        # <keys> are only the keys with children, but we want to test all keys -> loop over RecNames( template_tree )
        for key in RecNames( template_tree ) do
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                Display( "checking" );
                Display( key );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            if key = "data_type" then
                
                if not IsBound( tree.data_type ) or tree.data_type <> template_tree.data_type then
                    
                    if debug then
                        # COVERAGE_IGNORE_NEXT_LINE
                        Display( "data type could not be inferred or did not match (typed template tree)" );
                    fi;
                    
                    return false;
                    
                fi;
                
                continue;
                
            fi;
            
            # ignore these keys
            if key = "CAP_JIT_NOT_RESOLVABLE" or (template_tree.type = "EXPR_DECLARATIVE_FUNC" and key = "name") then
                
                continue;
                
            fi;
            
            Assert( 0, IsBound( tree.(key) ) );
            
            # different gvars might point to the same value
            if key = "gvar" then
                
                if IsIdenticalObj( ValueGlobal( template_tree.gvar ), ValueGlobal( tree.gvar ) ) then
                    
                    if debug then
                        # COVERAGE_IGNORE_NEXT_LINE
                        Display( "match: gvars point to identical values" );
                    fi;
                    
                    continue;
                    
                elif template_tree.gvar in [ "Range", "Target" ] and tree.gvar in [ "Range", "Target" ] and IsBound( tree.data_type ) and IsSpecializationOfFilter( IsCapCategoryMorphism, tree.data_type.signature[1][1].filter ) then
                    
                    if debug then
                        # COVERAGE_IGNORE_NEXT_LINE
                        Display( "match: gvars are both Range resp. Target of a morphism" );
                    fi;
                    
                    continue;
                    
                else
                    
                    if debug then
                        # COVERAGE_IGNORE_NEXT_LINE
                        Display( "mismatch: gvars point to non-identical values" );
                    fi;
                    
                    return false;
                    
                fi;
                
            fi;
            
            # check if children match
            if IsBound( result.(key) ) then
                
                if result.(key) = false then
                    
                    if debug then
                        # COVERAGE_IGNORE_BLOCK_START
                        Display( "child mismatch" );
                        Display( key );
                        # COVERAGE_IGNORE_BLOCK_END
                    fi;
                    
                    return false;
                    
                else
                    
                    continue;
                    
                fi;
                
            fi;
            
            # now there should only remain integers, booleans, strings or list of strings
            Assert( 0, IsInt( template_tree.(key) ) or IsBool( template_tree.(key) ) or IsString( template_tree.(key) ) or (IsList( template_tree.(key) ) and ForAll( template_tree.(key), x -> IsString( x ) )) );
            
            if template_tree.(key) <> tree.(key) then
                
                if debug then
                    # COVERAGE_IGNORE_BLOCK_START
                    Display( "tree mismatch" );
                    Display( key );
                    # COVERAGE_IGNORE_BLOCK_END
                fi;
                
                return false;
                
            else
                
                continue;
                
            fi;
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "should never get here" );
            
        od;
        
        if debug then
            # COVERAGE_IGNORE_NEXT_LINE
            Display( "everything matched" );
        fi;
        
        return true;
        
    end;
    
    additional_arguments_func := function ( template_tree, key, tree )
        
        return tree.(key);
        
    end;
    
    result := CapJitIterateOverTree( template_tree, pre_func, result_func, additional_arguments_func, tree );
    
    if result then
        
        return rec( variables := variables, func_id_replacements := func_id_replacements );
        
    else
        
        return fail;
        
    fi;
    
end );

InstallGlobalFunction( CapJitAppliedLogicTemplates, function ( tree )
  local template;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Apply logic templates." );
    
    tree := CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATES( tree, Filtered( CAP_JIT_LOGIC_TEMPLATES, t ->
        (CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED and t.apply_in_proof_assistant_mode <> "no") or
        (not CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED and t.apply_in_proof_assistant_mode <> "only")
    ) );
    
    MakeReadWriteGlobal( "CAP_JIT_LOGIC_TEMPLATES" );
    
    CAP_JIT_LOGIC_TEMPLATES := Filtered( CAP_JIT_LOGIC_TEMPLATES, t -> t.number_of_applications <> 0 );
        
    MakeReadOnlyGlobal( "CAP_JIT_LOGIC_TEMPLATES" );
    
    return tree;
    
end );

InstallGlobalFunction( CAP_JIT_INTERNAL_APPLIED_LOGIC_TEMPLATES, function ( tree, templates )
  local path_debugging_enabled, pre_func, additional_arguments_func;
    
    Assert( 0, ForAll( templates, template -> IsBound( template.is_fully_enhanced ) and template.is_fully_enhanced and template.number_of_applications > 0 ) );
    
    path_debugging_enabled := ForAny( templates, template -> IsBound( template.debug_path ) );
    
    pre_func := function ( tree, additional_arguments )
      local func_id_stack, matching_info, variables, func_id_replacements, well_defined, pre_func, result_func, additional_arguments_func, dst_tree, template;
        
        func_id_stack := additional_arguments[1];
        # path = additional_arguments[2] is only needed for debugging and only available if path debugging is enabled
        
        for template in templates do
            
            # make sure that the outermost function is not turned into a non-literal function
            if IsEmpty( func_id_stack ) then
                
                Assert( 0, tree.type = "EXPR_DECLARATIVE_FUNC" );
                
                if template.dst_template_tree.type <> "EXPR_DECLARATIVE_FUNC" then
                    
                    continue;
                    
                fi;
                
            fi;
            
            # Try to apply the same logic template multiple times.
            # If it does not match multiple times, this does not increase the runtime noticeably
            # but if it does, the runtime improves noticeably.
            while template.number_of_applications > 0 do
                
                if IsBound( template.debug ) and template.debug then
                    
                    # COVERAGE_IGNORE_BLOCK_START
                    Display( "try to match template:" );
                    Display( template.src_template );
                    # COVERAGE_IGNORE_BLOCK_END
                    
                fi;
                
                matching_info := CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE( tree, template.src_template_tree, template.variable_filters, path_debugging_enabled and IsBound( template.debug_path ) and template.debug_path = additional_arguments[2] );
                
                if matching_info = fail then
                    
                    break;
                    
                fi;
                
                if IsBound( template.debug ) and template.debug then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "found match" );
                    
                fi;
                
                variables := matching_info.variables;
                func_id_replacements := matching_info.func_id_replacements;
                
                if not IsDenseList( variables ) or Length( variables ) <> Length( template.variable_names ) then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "the following variables where not matched: ", template.variable_names{Difference( [ 1 .. Length( template.variable_names ) ], PositionsBound( variables ) )} );
                    
                fi;
                
                # will be modified inplace
                well_defined := true;
                
                # adjust function IDs and insert variables in dst_template_tree
                pre_func := function ( tree, func_id_stack )
                  local pos, replacement, new_nams, src_func, old_func;
                    
                    if not well_defined then
                        
                        # abort iteration
                        return fail;
                        
                    fi;
                    
                    if tree.type = "EXPR_DECLARATIVE_FUNC" then
                        
                        pos := Position( template.new_funcs, tree.nams{[ 1 .. tree.narg ]} );
                        
                        if pos = fail then
                            
                            Assert( 0, IsBound( func_id_replacements.(tree.id) ) );
                            
                            replacement := func_id_replacements.(tree.id);
                            
                            return CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tree, replacement.func_id, replacement.nams );
                            
                        else
                            
                            new_nams := ShallowCopy( tree.nams );
                            
                            # try to get the names of the function arguments from an existing function
                            if IsBound( template.new_funcs_corresponding_src_funcs[pos] ) then
                                
                                src_func := template.new_funcs_corresponding_src_funcs[pos];
                                
                                if src_func.type = "SYNTAX_TREE_VARIABLE" then
                                    
                                    old_func := variables[src_func.id];
                                    
                                    if old_func.type = "EXPR_DECLARATIVE_FUNC" then
                                        
                                        Assert( 0, tree.narg = old_func.narg );
                                        
                                        new_nams{[ 1 .. tree.narg ]} := old_func.nams{[ 1 .. tree.narg ]};
                                        
                                        return CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tree, tree.id, new_nams );
                                        
                                    fi;
                                    
                                elif src_func.type = "EXPR_DECLARATIVE_FUNC" then
                                    
                                    Assert( 0, tree.narg = src_func.narg );
                                    
                                    Assert( 0, IsBound( func_id_replacements.(src_func.id) ) );
                                    
                                    replacement := func_id_replacements.(src_func.id);
                                    
                                    new_nams{[ 1 .. tree.narg ]} := replacement.nams{[ 1 .. tree.narg ]};
                                    
                                    return CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tree, tree.id, new_nams );
                                    
                                else
                                    
                                    # COVERAGE_IGNORE_NEXT_LINE
                                    Error( "this should never happen" );
                                    
                                fi;
                                
                            fi;
                            
                            # if we cannot find a suitable existing function, prepend "logic_new_func_" to the names of arguments
                            new_nams{[ 1 .. tree.narg ]} := List( tree.nams{[ 1 .. tree.narg ]}, nam -> Concatenation( "logic_new_func_", nam ) );
                            
                            return CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tree, tree.id, new_nams );
                            
                        fi;
                        
                    fi;
                    
                    return tree;
                    
                end;
                
                result_func := function ( tree, result, keys, func_id_stack )
                  local key;
                    
                    if not well_defined then
                        
                        return fail;
                        
                    fi;
                    
                    if tree.type = "SYNTAX_TREE_VARIABLE" then
                        
                        # check if the resulting tree would be well-defined
                        if CapJitContainsRefToFVAROutsideOfFuncStack( variables[tree.id], func_id_stack ) then
                            
                            well_defined := false;
                            
                            if IsBound( template.debug ) and template.debug then
                                
                                # COVERAGE_IGNORE_NEXT_LINE
                                Error( "variable contains fvar outside of func stack" );
                                
                            fi;
                            
                            # abort iteration
                            return fail;
                            
                        fi;
                        
                        # new function IDs will be set below
                        return StructuralCopy( variables[tree.id] );
                        
                    fi;
                    
                    tree := ShallowCopy( tree );
                    
                    for key in keys do
                        
                        tree.(key) := result.(key);
                        
                    od;
                    
                    return tree;
                    
                end;
                
                additional_arguments_func := function ( tree, key, func_id_stack )
                    
                    if tree.type = "EXPR_DECLARATIVE_FUNC" then
                        
                        func_id_stack := Concatenation( func_id_stack, [ tree.id ] );
                        
                    fi;
                    
                    return func_id_stack;
                    
                end;
                
                dst_tree := CapJitIterateOverTree( template.dst_template_tree, pre_func, result_func, additional_arguments_func, func_id_stack );
                
                # if new_tree is well-defined, take it
                if well_defined then
                    
                    if IsBound( template.debug ) and template.debug then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "success, dst_tree is well-defined" );
                        
                    fi;
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, "Applied the following template:" );
                    Info( InfoCapJit, 1, template.src_template );
                    Info( InfoCapJit, 1, template.dst_template );
                    
                    # make sure we have new function IDs
                    # Functions from src_template_tree can appear multiple times in dst_template_tree, so in dst_template_tree the same function ID can occur multiple times.
                    # Since we require function IDs to be unique in a tree except in this special case, we now have to create a copy with new IDs.
                    tree := CapJitCopyWithNewFunctionIDs( dst_tree );
                    
                    template.number_of_applications := template.number_of_applications - 1;
                    Assert( 0, template.number_of_applications >= 0 );
                    
                    continue;
                    
                else
                    
                    if IsBound( template.debug ) and template.debug then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Error( "dst_tree is not well-defined" );
                        
                    fi;
                    
                    break;
                    
                fi;
                
            od;
            
        od;
        
        return tree;
        
    end;
    
    if path_debugging_enabled then
        
        # COVERAGE_IGNORE_BLOCK_START
        # path is only needed when path debugging is enabled
        additional_arguments_func := function ( tree, key, additional_arguments )
          local path, func_id_stack;
            
            func_id_stack := additional_arguments[1];
            path := additional_arguments[2];
            
            if tree.type = "EXPR_DECLARATIVE_FUNC" then
                
                func_id_stack := Concatenation( func_id_stack, [ tree.id ] );
                
            fi;
            
            path := Concatenation( path, [ key ] );
            
            return [ func_id_stack, path ];
            
        end;
        # COVERAGE_IGNORE_BLOCK_END
        
    else
        
        additional_arguments_func := function ( tree, key, additional_arguments )
            
            if tree.type = "EXPR_DECLARATIVE_FUNC" then
                
                return [ Concatenation( additional_arguments[1], [ tree.id ] ) ];
                
            else
                
                return additional_arguments;
                
            fi;
            
        end;
        
    fi;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, additional_arguments_func, [ [ ], [ ] ] );
    
end );
