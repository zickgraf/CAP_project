# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitResolvedOperations, function ( tree )
  local result_func;
    
    Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    # operations are compiled recursively, so we can use result_func instead of pre_func
    result_func := function ( tree, result, keys, additional_arguments )
      local key, operation, operation_name, info, category, resolved_tree, known_methods, known_method, similar_methods;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" then
            
            operation := ValueGlobal( tree.funcref.gvar );
            
            operation_name := NameFunction( operation );
            
            # exclude "PreCompose" until it can be type checked
            if operation_name = "PreCompose" and not (CapJitIsCallToGlobalFunction( tree.args.2, "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" ) and CapJitIsCallToGlobalFunction( tree.args.3, "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" )) then
                
                return false;
                
            fi;
            
            # check if this is a CAP operation which is not a convenience method or if we know methods for this operation
            if (IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name) ) and tree.args.length = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list )) or IsBound( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name) ) then
                
                if CAP_JIT_PROOF_ASSISTANT_MODE_ENABLED and IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name) ) then
                    
                    info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
                    
                    if not IsBound( info.compatible_with_congruence_of_morphisms ) then
                        
                        # COVERAGE_IGNORE_NEXT_LINE
                        Print( "WARNING: please check if the CAP operation ", operation_name, " is compatible with the congruence of morphisms and add this information to the method name record.\n" );
                        
                    elif info.compatible_with_congruence_of_morphisms <> true then
                        
                        Print( "WARNING: the CAP operation ", operation_name, " is not compatible with the congruence of morphisms. Keep this in mind when writing logic templates.\n" );
                        
                    fi;
                    
                fi;
                
                # we can resolve operations if and only if the category is known, i.e., stored in a global variable
                if tree.args.1.type = "EXPR_REF_GVAR" then
                    
                    category := ValueGlobal( tree.args.1.gvar );
                    
                    Assert( 0, IsCapCategory( category ) );
                    
                    if IsBound( category!.stop_compilation ) and category!.stop_compilation = true then
                        
                        return tree;
                        
                    fi;
                    
                    if IsBound( category!.stop_compilation_at_primitively_installed_operations ) and category!.stop_compilation_at_primitively_installed_operations = true and operation_name in ListPrimitivelyInstalledOperationsOfCategory( category ) then
                        
                        return tree;
                        
                    fi;
                    
                    Info( InfoCapJit, 1, "####" );
                    Info( InfoCapJit, 1, Concatenation( "Resolve ", operation_name, "." ) );
                    
                    # check if this is a CAP operation which is not a convenience method
                    if IsBound( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name) ) and tree.args.length = Length( CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name).filter_list ) then
                        
                        # type check "PreCompose"
                        if operation_name = "PreCompose" then
                            
                            Assert( 0, CapJitIsCallToGlobalFunction( funccall_args.2, "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" ) and CapJitIsCallToGlobalFunction( funccall_args.3, "ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes" ) );
                            
                            if not CapJitIsEqualForEnhancedSyntaxTrees( funccall_args.2.args.4, funccall_args.3.args.3 ) then
                                
                                Display( funccall_args.2.args.4 );
                                Display( funccall_args.3.args.3 );
                                Display( path );
                                
                                Error( "morphisms (with above given Range and Source) are not composable" );
                                
                            fi;
                            
                        fi;
                        
                        Assert( 0, CanCompute( category, operation_name ) );
                        
                        Info( InfoCapJit, 1, "This is a CAP operation, recurse compilation." );
                        
                        resolved_tree := CapJitCompiledCAPOperationAsEnhancedSyntaxTree( category, operation_name, false );
                        
                    # check if we know methods for this operation
                    elif IsBound( CAP_JIT_INTERNAL_KNOWN_METHODS.(operation_name) ) then
                        
                        Info( InfoCapJit, 1, "Methods are known for this operation." );
                        
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
                        
                        # look for GAP methods with the same number of arguments and first filter implying known_method.filters[1] or being implied by it
                        similar_methods := Filtered( MethodsOperation( operation, tree.args.length ), m ->
                            IS_SUBSET_FLAGS( WITH_IMPS_FLAGS( m.argFilt[1] ), WITH_IMPS_FLAGS( FLAGS_FILTER( known_method.filters[1] ) ) ) or
                            IS_SUBSET_FLAGS( WITH_IMPS_FLAGS( FLAGS_FILTER( known_method.filters[1] ) ), WITH_IMPS_FLAGS( m.argFilt[1] ) )
                        );
                        
                        # we should always find the method installed using Install(Other)MethodForCompilerForCAP
                        Assert( 0, not IsEmpty( similar_methods ) );
                        
                        if Length( similar_methods ) > 1 then
                            
                            # COVERAGE_IGNORE_BLOCK_START
                            Print(
                                "WARNING: A method for ", operation_name, " with ", Length( known_method.filters ), " arguments and first filter ", known_method.filters[1], " was installed using Install(Other)MethodForCompilerForCAP ",
                                "but additional methods with the same number of arguments and the same first filter (or a filter implying or being implied by it) have been installed (using Install(Other)Method). ",
                                "If such an additional method is used in the code, CompilerForCAP will resolve the wrong method.\n"
                            );
                            # COVERAGE_IGNORE_BLOCK_END
                            
                        fi;
                        
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
                        
                    else
                        
                        Error( "this should never happen" );
                        
                    fi;
                    
                    if IsBound( tree.funcref.does_not_return_fail ) and tree.funcref.does_not_return_fail = true then
                        
                        resolved_tree := CapJitRemovedReturnFail( resolved_tree );
                        
                    fi;
                    
                    tree := ShallowCopy( tree );
                    tree.funcref := resolved_tree;
                    
                fi;
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, ReturnTrue, true );
    
end );
