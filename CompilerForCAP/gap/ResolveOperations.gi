# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#

InstallGlobalFunction( CapJitResolvedOperations, function ( tree )
  local result_func;
    
    # operations are compiled recursively, so we can use result_func instead of pre_func
    result_func := function ( tree, result, keys, additional_arguments )
      local operation, operation_name, resolved_tree, info, category, filters, pos, known_methods, known_method, key;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" then
            
            operation := ValueGlobal( tree.funcref.gvar );
            
            operation_name := NameFunction( operation );
            
            # all CAP operations get the category or at least one argument from which the category can be derived
            # known methods without arguments are not supported
            if tree.args.length = 0 then
                
                return tree;
                
            fi;
            
            resolved_tree := fail;
            
            # resolve CAP operations
            if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name) ) then
                
                info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
                
                category := fail;
                
                if tree.args.length = Length( info.filter_list ) then
                    
                    if IsBound( tree.args.1.data_type ) and IsSpecializationOfFilter( IsCapCategory, tree.args.1.data_type.filter ) then
                        
                        category := tree.args.1.data_type.category;
                        
                    elif tree.args.1.type = "EXPR_REF_GVAR" then
                        
                        # When compiling without a type signature we do not even try to infer data types -> we still need this case.
                        category := ValueGlobal( tree.args.1.gvar );
                        
                    fi;
                    
                elif info.install_convenience_without_category and tree.args.length = Length( info.filter_list ) - 1 and ForAll( tree.args, x -> IsBound( x.data_type ) ) then
                    
                    filters := AsListMut( List( tree.args, x -> x.data_type.filter ) );
                    
                    if IsSpecializationOfFilterList( info.filter_list{[ 2 .. Length( info.filter_list ) ]}, filters ) then
                        
                        pos := PositionProperty( info.filter_list, filter_string -> filter_string in [ "object", "morphism", "twocell", "list_of_objects", "list_of_morphisms", "list_of_twocells" ] );
                        
                        if pos <> fail then
                            
                            CAP_INTERNAL_WARN_ABOUT_SIMILAR_METHODS( operation, filters, 1, { operation_name } -> Concatenation(
                                # COVERAGE_IGNORE_BLOCK_START
                                "WARNING: A method for the CAP operation ", operation_name, " without category as first argument was installed which could be confused with the convenience method ",
                                "deriving the category from the arguments. CompilerForCAP will always resolve the convenience method.\n"
                                # COVERAGE_IGNORE_BLOCK_END
                            ) );
                            
                            if StartsWith( info.filter_list[pos], "list_of" ) then
                                
                                category := tree.args.(pos - 1).data_type.element_type.category;
                                
                            else
                                
                                category := tree.args.(pos - 1).data_type.category;
                                
                            fi;
                            
                            tree.args := ConcatenationForSyntaxTreeLists( AsSyntaxTreeList( [ rec( type := "EXPR_REF_GVAR", gvar := CapJitGetOrCreateGlobalVariable( category ) ) ] ), tree.args );
                            
                        fi;
                        
                    fi;
                    
                fi;
                
                if category <> fail then
                    
                    Assert( 0, IsCapCategory( category ) );
                    
                    if not IsFinalized( category ) then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Print( "WARNING: You are compiling operations of an unfinalized category with name ", Name( category ), ". This may have unexpected side-effects like missing operations.\n" );
                        
                    fi;
                    
                    Assert( 0, CanCompute( category, operation_name ) );
                    Assert( 0, tree.args.length = Length( info.filter_list ) );
                    
                    if IsBound( category!.stop_compilation ) and category!.stop_compilation = true then
                        
                        return tree;
                        
                    fi;
                    
                    if IsBound( category!.stop_compilation_at_primitively_installed_operations ) and category!.stop_compilation_at_primitively_installed_operations = true and operation_name in ListPrimitivelyInstalledOperationsOfCategory( category ) then
                        
                        return tree;
                        
                    fi;
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, Concatenation( "Resolve CAP operation ", operation_name, ", recurse compilation." ) );
                    
                    filters := Concatenation( [ CapJitDataTypeOfCategory( category ).filter ], ListWithIdenticalEntries( Length( info.filter_list ) - 1, IsObject ) );
                    
                    CAP_INTERNAL_WARN_ABOUT_SIMILAR_METHODS( operation, filters, Length( category!.added_functions.(operation_name) ), { operation_name } -> Concatenation(
                        # COVERAGE_IGNORE_BLOCK_START
                        "WARNING: A method for the CAP operation ", operation_name, " was installed manually (e.g. using Install(Other)Method), ",
                        "but CompilerForCAP will always resolve the methods installed via CAP's Add-functions.\n"
                        # COVERAGE_IGNORE_BLOCK_END
                    ) );
                    
                    resolved_tree := CapJitCompiledCAPOperationAsEnhancedSyntaxTree( category, operation_name, false );
                    
                fi;
                
            fi;
            
            # resolve known categorical methods
            if resolved_tree = fail and IsBound( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name) ) and tree.args.1.type = "EXPR_REF_GVAR" and IsCapCategory( ValueGlobal( tree.args.1.gvar ) ) then
                
                category := ValueGlobal( tree.args.1.gvar );
                
                if IsBound( category!.stop_compilation ) and category!.stop_compilation = true then
                    
                    return tree;
                    
                fi;
                
                Info( InfoCapJit, 1, "####" );
                Info( InfoCapJit, 1, Concatenation( "Try to resolve ", operation_name, " by searching for known categorical methods." ) );
                
                known_methods := Filtered( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name),
                    m -> Length( m.filters ) = tree.args.length and m.filters[1]( category )
                );
                
                if IsEmpty( known_methods ) then
                    
                    return tree;
                    
                fi;
                
                if Length( known_methods ) > 1 then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "Found more than one known method for ", operation_name, " with correct length and category filter" );
                    
                fi;
                
                known_method := known_methods[1];
                
                filters := Concatenation( [ known_method.filters[1] ], ListWithIdenticalEntries( tree.args.length - 1, IsObject ) );
                
                CAP_INTERNAL_WARN_ABOUT_SIMILAR_METHODS( operation, filters, 1, { operation_name } -> Concatenation(
                    # COVERAGE_IGNORE_BLOCK_START
                    "WARNING: A method for ", operation_name, " with ", String( Length( known_method.filters ) ), " arguments and first filter ", String( known_method.filters[1] ), " was installed using Install(Other)MethodForCompilerForCAP ",
                    "but additional methods with the same number of arguments and the same first filter (or a filter implying or being implied by it) have been installed (using Install(Other)Method). ",
                    "If such an additional method is used in the code, CompilerForCAP will resolve the wrong method.\n"
                    # COVERAGE_IGNORE_BLOCK_END
                ) );
                
                # precompile known methods and cache the result
                
                if not IsBound( category!.compiled_known_methods_trees ) then
                    
                    category!.compiled_known_methods_trees := rec( );
                    
                fi;
                
                if not IsBound( category!.compiled_known_methods_trees.(operation_name) ) then
                    
                    category!.compiled_known_methods_trees.(operation_name) := [ ];
                    
                fi;
                
                if not IsBound( category!.compiled_known_methods_trees.(operation_name)[tree.args.length] ) then
                    
                    category!.compiled_known_methods_trees.(operation_name)[tree.args.length] := CapJitCompiledFunctionAsEnhancedSyntaxTree( known_method.method, "without_post_processing", category );
                    
                fi;
                
                resolved_tree := CapJitCopyWithNewFunctionIDs( category!.compiled_known_methods_trees.(operation_name)[tree.args.length] );
                
            fi;
            
            # resolve known non-categorical methods
            if resolved_tree = fail and IsBound( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name) ) and ForAll( tree.args, a -> IsBound( a.data_type ) ) and not IsSpecializationOfFilter( "category", tree.args.1.data_type.filter ) then
                
                Info( InfoCapJit, 1, "####" );
                Info( InfoCapJit, 1, Concatenation( "Try to resolve ", operation_name, " by searching for known non-categorical methods." ) );
                
                filters := AsListMut( List( tree.args, x -> x.data_type.filter ) );
                
                known_methods := Filtered( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name),
                    m -> Length( m.filters ) = tree.args.length and IsSpecializationOfFilterList( m.filters, filters )
                );
                
                if IsEmpty( known_methods ) then
                    
                    return tree;
                    
                fi;
                
                if Length( known_methods ) > 1 then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "Found more than one known method for ", operation_name, " with correct length and filters" );
                    
                fi;
                
                known_method := known_methods[1];
                
                CAP_JIT_INTERNAL_WARN_ABOUT_SIMILAR_METHODS( operation, tree.args.length, known_method.filters, 1, { operation_name } -> Concatenation(
                    # COVERAGE_IGNORE_BLOCK_START
                    "WARNING: A method for ", operation_name, " with ", String( Length( known_method.filters ) ), " arguments was installed using Install(Other)MethodForCompilerForCAP ",
                    "but additional methods with the same number of arguments and a comparable filter list have been installed (using Install(Other)Method). ",
                    "If such an additional method is used in the code, CompilerForCAP will resolve the wrong method.\n"
                    # COVERAGE_IGNORE_BLOCK_END
                ) );
                
                resolved_tree := ENHANCED_SYNTAX_TREE( known_method.method );
                
            fi;
            
            if resolved_tree <> fail then
                
                if IsBound( tree.funcref.does_not_return_fail ) and tree.funcref.does_not_return_fail = true then
                    
                    resolved_tree := CapJitRemovedReturnFail( resolved_tree );
                    
                fi;
                
                tree := ShallowCopy( tree );
                tree.funcref := resolved_tree;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, ReturnTrue, true );
    
end );
