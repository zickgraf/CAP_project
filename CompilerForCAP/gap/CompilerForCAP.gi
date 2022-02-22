# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#

InstallGlobalFunction( StopCompilationAtCategory, function ( category )
    
    Assert( 0, IsCapCategory( category ) );
    
    category!.stop_compilation := true;
    
end );

InstallGlobalFunction( ContinueCompilationAtCategory, function ( category )
    
    Assert( 0, IsCapCategory( category ) );
    
    category!.stop_compilation := false;
    
end );

InstallGlobalFunction( CapJitCompiledFunction, function ( func, args... )
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        Info( InfoCapJit, 1, "<func> is a operation or kernel function, this is not supported yet." );
        return func;
        
    fi;
    
    return ENHANCED_SYNTAX_TREE_CODE( CallFuncList( CapJitCompiledFunctionAsEnhancedSyntaxTree, Concatenation( [ func ], args ) ) );
    
end );

RECURSIVE_COMPILATION := false;

InstallGlobalFunction( CapJitCompiledFunctionAsEnhancedSyntaxTree, function ( func, args... )
  local recursive_call, debug, debug_idempotence, category_as_first_argument, category, type_signature, tree, resolving_phase_functions, orig_tree, compiled_func, tmp, rule_phase_functions, pre_func, f;
    
    recursive_call := ValueOption( "called_from_CapJitCompiledFunctionAsEnhancedSyntaxTree" ) = true;
    PushOptions( rec( called_from_CapJitCompiledFunctionAsEnhancedSyntaxTree := true ) );
    
    if recursive_call then
        StopTimer( "CapJitResolvedOperations" );
    fi;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Start compilation." );
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<func> is a operation or kernel function, this is not supported yet." );
        
    fi;
    
    debug := false;
    debug_idempotence := false;
    
    if debug then
        # COVERAGE_IGNORE_BLOCK_START
        Display( func );
        Error( "start compilation" );
        # COVERAGE_IGNORE_BLOCK_END
    fi;
    
    category_as_first_argument := false;
    category := fail;
    
    if Length( args ) = 0 then
        
        type_signature := fail;
        
    elif Length( args ) = 1 then
        
        if IsCapCategory( args[1] ) then
            
            type_signature := fail;
            
            category_as_first_argument := true;
            category := args[1];
            
        elif IsList( args[1] ) and Length( args[1] ) = 2 and IsList( args[1][1] ) and Length( args[1][1] ) = NumberArgumentsFunction( func ) then
            
            type_signature := args[1];
            
            if NumberArgumentsFunction( func ) > 0 and type_signature[1][1].filter = IsCapCategory then
                
                category_as_first_argument := true;
                category := type_signature[1][1].category;
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "the second argument of CapJitCompiledFunction(AsEnhancedSyntaxTree) must be a CAP category or a valid type signature" );
            
        fi;
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "CapJitCompiledFunction(AsEnhancedSyntaxTree) must be called with at most two arguments" );
        
    fi;
    
    if category_as_first_argument then
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true, given_arguments := [ category ], type_signature := type_signature );
        
    else
        
        tree := ENHANCED_SYNTAX_TREE( func : globalize_hvars := true, type_signature := type_signature );
        
    fi;
    
    #if not recursive_call then
        Display( "main" );
    #fi;
    
    # resolving phase
    resolving_phase_functions := [
        CapJitResolvedOperations,
        CapJitInlinedArguments,
        CapJitDroppedUnusedBindings,
        CapJitInlinedBindingsToVariableReferences,
        CapJitResolvedGlobalVariables,
    ];
    
    #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    orig_tree := rec( );
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        #if not recursive_call then
            Display( "resolving phase" );
        #fi;
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Start resolving." );
        
        if debug then
            # COVERAGE_IGNORE_BLOCK_START
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "start resolving" );
            # COVERAGE_IGNORE_BLOCK_END
        fi;
        
        for f in resolving_phase_functions do
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
                Display( compiled_func );
                # use Concatenation so one can easily replace "Error" by "Display"
                Error( Concatenation( "next step: apply ", NameFunction( f ) ) );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            #if not recursive_call then
                StartTimer( NameFunction( f ) );
            #fi;
            
            tree := f( tree );
            
            #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
            
            #if not recursive_call then
                StopTimer( NameFunction( f ) );
            #fi;
            
            if debug_idempotence then
                
                # COVERAGE_IGNORE_BLOCK_START
                tmp := StructuralCopy( tree );
                
                tree := f( tree );
                
                if tmp <> tree then
                    
                    Error( NameFunction( f ), " is not idempotent" );
                    
                fi;
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
        od;
        
    od;
    
    #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    tree := CapJitDeduplicatedExpressions( tree );
    
    #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    myfunc := function ( tree )
        
        if tree <> orig_tree then
            
            return CapJitCopyWithNewFunctionIDs( tree );
            
        else
            
            return tree;
            
        fi;
        
    end;
    
    # rule phase
    rule_phase_functions := [
        CapJitInlinedBindingsToVariableReferences,
        CapJitDroppedUnusedBindings,
        CapJitInferredDataTypes,
        #CapJitInlinedBindings,
        CapJitTransparentBindings,
        CapJitAppliedLogic,
        CapJitOpaqueBindings,
        myfunc,
        CapJitDroppedHandledEdgeCases,
        CapJitInlinedArguments,
        CapJitInlinedSimpleFunctionCalls,
        CapJitInlinedFunctionCalls,
    ];
    
    orig_tree := rec( );
    while tree <> orig_tree do
        
        orig_tree := tree;
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Apply rules." );
        
        #if not recursive_call then
            Display( "rules phase" );
        #fi;
        
        if debug then
            # COVERAGE_IGNORE_BLOCK_START
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply rules" );
            # COVERAGE_IGNORE_BLOCK_END
        fi;
        
        for f in rule_phase_functions do
            
            if debug then
                # COVERAGE_IGNORE_BLOCK_START
                compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
                Display( compiled_func );
                # use Concatenation so one can easily replace "Error" by "Display"
                Error( Concatenation( "next step: apply ", NameFunction( f ) ) );
                # COVERAGE_IGNORE_BLOCK_END
            fi;
            
            #if not recursive_call then
                StartTimer( NameFunction( f ) );
            #fi;
            
            Display( NameFunction( f ) );
            
            tree := f( tree );
            
            #if f <> CapJitTransparentBindings and f <> CapJitOpaqueBindings then
            #    
            #    Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
            #    
            #fi;
            
            #if not recursive_call then
                StopTimer( NameFunction( f ) );
            #fi;
            
            if debug_idempotence then
                
                # COVERAGE_IGNORE_BLOCK_START
                tmp := StructuralCopy( tree );
                
                tree := f( tree );
                
                if tmp <> tree then
                    
                    Error( NameFunction( f ), " is not idempotent" );
                    
                fi;
                # COVERAGE_IGNORE_BLOCK_END
                
            fi;
            
        od;
        
        #pre_func := function ( tree, additional_arguments )
        #    
        #    Unbind( tree.resolved_value );
        #    
        #    return tree;
        #    
        #end;
        #
        #CapJitIterateOverTree( tree, pre_func, ReturnFail, ReturnTrue, true );
        
    od;
    
    # post-processing
    
    StartTimer( "post1" );
    
    tree := CapJitInlinedBindingsActually( tree );
    tree := CapJitDroppedUnusedBindings( tree );
    
    StopTimer( "post1" );
    
    #if not recursive_call then
        StartTimer( "post_processing" );
    #fi;
    
    if category_as_first_argument then
        
        if debug then
            # COVERAGE_IGNORE_BLOCK_START
            compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
            Display( compiled_func );
            Error( "apply CapJitAppliedCompilerHints" );
            # COVERAGE_IGNORE_BLOCK_END
        fi;
        
        tree := CapJitAppliedCompilerHints( tree, category );
        
    fi;
    
    if debug then
        # COVERAGE_IGNORE_BLOCK_START
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
        Display( compiled_func );
        Error( "apply CapJitHoistedExpressions" );
        # COVERAGE_IGNORE_BLOCK_END
    fi;
    
    tree := CapJitHoistedExpressions( tree );
    
    if debug then
        # COVERAGE_IGNORE_BLOCK_START
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
        Display( compiled_func );
        Error( "apply CapJitDeduplicatedExpressions" );
        # COVERAGE_IGNORE_BLOCK_END
    fi;
    
    tree := CapJitDeduplicatedExpressions( tree );
    
    #if not recursive_call then
        StopTimer( "post_processing" );
    #fi;
    
    if debug then
        
        # COVERAGE_IGNORE_BLOCK_START
        compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
        
        Display( compiled_func );
        
        Error( "compilation finished" );
        # COVERAGE_IGNORE_BLOCK_END
        
    fi;
    
    #Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Compilation finished." );
    
    #Assert( 0, Last( OptionsStack ) = rec( called_from_CapJitCompiledFunctionAsEnhancedSyntaxTree := true ) );
    PopOptions( );
    
    if recursive_call then
        StartTimer( "CapJitResolvedOperations" );
    fi;
    
    return tree;
    
end );
