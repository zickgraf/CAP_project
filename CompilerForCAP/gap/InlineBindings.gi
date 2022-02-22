# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitInlinedBindings, function ( tree )
  local inline_var_refs_only, actually_inline, pre_func, additional_arguments_func;
    
    inline_var_refs_only := ValueOption( "inline_var_refs_only" ) = true;
    actually_inline := ValueOption( "actually_inline" ) = true;
    
    #tree := StructuralCopy( tree );
    
    pre_func := function ( tree, func_stack )
      local func, value;
        
        # iterate in case the inlined value is an EXPR_REF_FVAR again
        while true do
            
            if tree.type = "EXPR_REF_FVAR" then
                
                func := First( func_stack, func -> func.id = tree.func_id );
                Assert( 0, func <> fail );
                
                # the fvar might be an argument, which has no binding
                if Position( func.nams, tree.name ) > func.narg then
                    
                    value := CapJitValueOfBinding( func.bindings, tree.name );
                    
                    if actually_inline or value.type = "EXPR_REF_GVAR" or value.type = "EXPR_REF_FVAR" then
                        
                        Info( InfoCapJit, 1, "####" );
                        Info( InfoCapJit, 1, "Inline binding with name ", tree.name, "." );
                        
                        tree := CapJitCopyWithNewFunctionIDs( value );
                        continue;
                        
                    elif not inline_var_refs_only then
                        
                        #Display( Concatenation( "Inline binding with name ", tree.name, "." ) );
                        tree.resolved_value := value;
                        
                    fi;
                    
                fi;
                
            fi;
            
            #if not IsBound( tree.resolved_value ) then
            #    
            #    tree := ShallowCopy( tree );
            #    tree.resolved_value := tree;
            #    
            #fi;
            
            return tree;
            
        od;
        
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

InstallGlobalFunction( CapJitInlinedBindingsToVariableReferences, function ( tree )
    
    return CapJitInlinedBindings( tree : inline_var_refs_only := true );
    
end );

BindGlobal( "CapJitInlinedBindingsActually", function ( tree )
    
    return CapJitInlinedBindings( tree : actually_inline := true );
    
end );

BindGlobal( "CapJitTransparentBindings", function ( tree )
    
    return CAP_JIT_TRANSPARENT_BINDINGS( tree, [ ] );
    
end );

BindGlobal( "CAP_JIT_TRANSPARENT_BINDINGS", function ( tree, func_stack )
  local pre_func, result_func;
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # manual iteration in result_func
            return fail;
            
        fi;
        
        return tree;
        
    end;
    
    result_func := function ( tree, result, keys, additional_arguments )
      local value, func_pos, func, pos, rec_name, name, key;
        
        tree := ShallowCopy( tree );
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            tree.bindings := ShallowCopy( tree.bindings );
            
            tree.bindings.transparent_names := [ ];
            
            # try to determine data type of return value
            # this also populates the data types of other bindings (see EXPR_REF_FVAR below)
            tree.bindings.BINDING_RETURN_VALUE := CAP_JIT_TRANSPARENT_BINDINGS( tree.bindings.BINDING_RETURN_VALUE, Concatenation( func_stack, [ tree ] ) );
            
            Add( tree.bindings.transparent_names, "RETURN_VALUE" );
            
            #for name in tree.bindings.names do
            #    
            #    value := CapJitValueOfBinding( tree.bindings, name );
            #    
            #    if not IsBound( value.is_transparent ) then
            #        
            #        #Error( "there are unused bindings, please drop unused bindings first" );
            #        
            #    fi;
            #    
            #    Unbind( value.is_transparent );
            #    
            #od;
            
            if Set( tree.bindings.transparent_names ) <> tree.bindings.names then
                
                Error( "there are unused bindings, please drop unused bindings first" );
                
            fi;
            
            Unbind( tree.bindings.transparent_names );
            
            return tree;
            
        fi;
        
        if tree.type = "EXPR_REF_FVAR" then
            
            func_pos := PositionProperty( func_stack, func -> func.id = tree.func_id );
            Assert( 0, func_pos <> fail );
            
            func := func_stack[func_pos];
            
            pos := Position( func.nams, tree.name );
            
            if pos <= func.narg then
                
                return tree;
                
            else
                
                value := CapJitValueOfBinding( func.bindings, tree.name );
                
                if not tree.name in func.bindings.transparent_names then
                    
                    # make value transparent
                    value := CAP_JIT_TRANSPARENT_BINDINGS( value, func_stack{[ 1 .. func_pos ]} );
                    
                    rec_name := Concatenation( "BINDING_", tree.name );
                    
                    # inplace hack to avoid making values transparent multiple times
                    func.bindings.(rec_name) := value;
                    
                    Add( func.bindings.transparent_names, tree.name );
                    
                fi;
                
                value := ShallowCopy( value );
                value.original_ref_fvar := tree;
                
                return value;
                
            fi;
            
        fi;
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        return tree;
        
    end;
    
    #additional_arguments_func := function ( tree, key, func_stack )
    #    
    #    if tree.type = "EXPR_DECLARATIVE_FUNC" then
    #        
    #        return Concatenation( func_stack, [ tree ] );
    #        
    #    else
    #        
    #        return func_stack;
    #        
    #    fi;
    #    
    #end;
    
    return CapJitIterateOverTree( tree, pre_func, result_func, ReturnTrue, true );
    
end );

BindGlobal( "CapJitOpaqueBindings", function ( tree )
  local inline_var_refs_only, actually_inline, pre_func, additional_arguments_func;
    
    inline_var_refs_only := ValueOption( "inline_var_refs_only" ) = true;
    actually_inline := ValueOption( "actually_inline" ) = true;
    
    #tree := StructuralCopy( tree );
    
    pre_func := function ( tree, func_stack )
      local keys, func, value, key;
        
        if IsBound( tree.original_ref_fvar ) then
            
            #keys := CAP_JIT_INTERNAL_ITERATION_KEYS.(tree.type);
            #
            #func := First( func_stack, func -> func.id = tree.original_ref_fvar.func_id );
            #Assert( 0, func <> fail );
            #Assert( 0, Position( func.nams, tree.original_ref_fvar.name ) > func.narg );
            #value := CapJitValueOfBinding( func.bindings, tree.original_ref_fvar.name );
            #
            #for key in keys do
            #    
            #    #Assert( 0, IsIdenticalObj( tree.(key), value.(key) ) );
            #    #Assert( 0, tree.(key) = value.(key) );
            #    
            #od;
            
            return tree.original_ref_fvar;
            
        else
            
            return tree;
            
        fi;
        
    end;
    
    #additional_arguments_func := function ( tree, key, func_stack )
    #    
    #    if tree.type = "EXPR_DECLARATIVE_FUNC" then
    #        
    #        return Concatenation( func_stack, [ tree ] );
    #        
    #    else
    #        
    #        return func_stack;
    #        
    #    fi;
    #    
    #end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

