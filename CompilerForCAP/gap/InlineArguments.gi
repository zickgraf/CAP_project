# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitInlinedArguments, function ( tree )
  local pre_func, additional_arguments_func;
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, "Inlining function arguments." );
    
    pre_func := function ( tree, additional_arguments )
      local func, args, arg_statements;
        
        if IsRecord( tree ) and tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_FUNC" and tree.funcref.narg <> 0 then
            
            tree := ShallowCopy( tree );
            func := ShallowCopy( tree.funcref );
            
            if func.variadic then
                
                Assert( 0, Length( tree.args ) >= func.narg - 1 );
                
            else
                
                Assert( 0, Length( tree.args ) = func.narg );
                
            fi;

            args := ShallowCopy( tree.args );
            
            if func.variadic then
                
                args[func.narg] := rec(
                    type := "EXPR_LIST",
                    list := args{[ func.narg .. Length( args ) ]},
                );
                
            fi;
            
            arg_statements := List( [ 1 .. func.narg ], j -> rec(
                type := "STAT_ASS_FVAR",
                func_id := func.id,
                name := func.nams[j],
                initial_name := func.nams[j],
                rhs := args[j],
            ) );
            
            func.nloc := func.nloc + func.narg;
            func.narg := 0;
            func.variadic := false;
            func.stats := ShallowCopy( func.stats );
            func.stats.statements := Concatenation( arg_statements, func.stats.statements );
            
            tree.funcref := func;
            tree.args := [ ];
            
            Info( InfoCapJit, 1, "####" );
            Info( InfoCapJit, 1, "Inlined arguments of a single function." );
            
        fi;

        return tree;
        
    end;

    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );
