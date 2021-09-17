# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( CapJitInlinedVariableAssignments, function ( tree )
  local inline_gvars_only, inline_rapid_reassignments_only, condition_func, path, lvar_path, lvar_assignment, parent_path, parent, inline_tree, subsequent_child, is_rapid_reassigment, inline_tree_path, inline_tree_parent, func_path, func, func_id, number_of_assignments, pre_func, rhs, number_of_uses, modified_inline_tree;
    
    inline_gvars_only := ValueOption( "inline_gvars_only" ) = true;
    
    inline_rapid_reassignments_only := ValueOption( "inline_rapid_reassignments_only" ) = true;
    
    tree := StructuralCopy( tree );
    
    # find STAT_ASS_FVAR
    condition_func := function ( tree, path )
        
        if tree.type = "STAT_ASS_FVAR" and (not inline_gvars_only or tree.rhs.type = "EXPR_REF_GVAR") then
            
            if IsBound( tree.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT ) and tree.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT then
                
                return false;
                
            fi;
            
            return true;
            
        fi;
        
        return false;
        
    end;
    
    lvar_path := CapJitFindNodeDeep( tree, condition_func );
    
    if lvar_path = fail then
        
        Info( InfoCapJit, 1, "####" );
        Info( InfoCapJit, 1, "Inlined all variables, finished." );

        # reset CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT
        pre_func := function ( tree, additional_arguments )
            
            if IsBound( tree.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT ) then
                
                Unbind( tree.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT );
                
            fi;
                
            return tree;
            
        end;
        
        CapJitIterateOverTree( tree, pre_func, ReturnTrue, ReturnTrue, true );
        
        return tree;
        
    fi;

    lvar_assignment := CapJitGetNodeByPath( tree, lvar_path );
    parent_path := lvar_path{[ 1 .. Length( lvar_path ) - 1 ]};
    parent := CapJitGetNodeByPath( tree, parent_path );

    # assert that parent is a list of statements
    Assert( 0, Last( parent_path ) = "statements" and parent.type = "SYNTAX_TREE_LIST" );
    
    Info( InfoCapJit, 1, "####" );
    Info( InfoCapJit, 1, Concatenation( "Try to inline variable with initial name ", lvar_assignment.initial_name ), "." );
    
    # we want to ignore the variable in the next iteration in any case
    lvar_assignment.CAP_JIT_IGNORE_VARIABLE_ASSIGNMENT := true;
    
    inline_tree := fail;
    
    if parent.length >= Int( Last( lvar_path ) ) + 1 then
        
        subsequent_child := parent.(Int( Last( lvar_path ) ) + 1);

        # detect "rapid reassignment"
        if subsequent_child.type = "STAT_ASS_FVAR" and subsequent_child.func_id = lvar_assignment.func_id and subsequent_child.name = lvar_assignment.name then
            
            Info( InfoCapJit, 1, "Found rapid reassignment." );
            
            is_rapid_reassigment := true;
            
            inline_tree := subsequent_child.rhs;
            inline_tree_path := Concatenation( parent_path, [ Int( Last( lvar_path ) ) + 1, "rhs" ] );
            inline_tree_parent := subsequent_child;
            
        elif inline_rapid_reassignments_only then
            
            Info( InfoCapJit, 1, "Not a rapid reassignment. Skip inlining..." );
            
            return CapJitInlinedVariableAssignments( tree );
            
        else
            
            is_rapid_reassigment := false;
            
            inline_tree_path := parent_path;
            inline_tree := parent;
            inline_tree_parent := CapJitGetNodeByPath( tree, parent_path{[ 1 .. Length( parent_path ) - 1 ]} );
            
        fi;
        
    else
        
        Info( InfoCapJit, 1, "Variable assignment is the last statement in STAT_SEQ_STAT. Skip inlining..." );
        
        return CapJitInlinedVariableAssignments( tree );
        
    fi;

    # replace all references to lvar by rhs
    rhs := lvar_assignment.rhs;
    number_of_uses := 0;
    
    pre_func := function ( tree, additional_arguments )
        
        if PositionSublist( tree.type, "FVAR" ) <> fail and tree.func_id = lvar_assignment.func_id and tree.name = lvar_assignment.name then
            
            if tree.type = "EXPR_REF_FVAR" then
                
                number_of_uses := number_of_uses + 1;
                
                return CapJitCopyWithNewFunctionIDs( rhs );
                
            fi;
            
        fi;
        
        return tree;
        
    end;
    
    modified_inline_tree := CapJitIterateOverTree( inline_tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );

    if number_of_uses = 0 then

        Info( InfoCapJit, 1, "Variable is unused." );
        
    # Heuristic: Generally, only inline a variable of it is used a single time, because the size of the tree might explode if a large expression is inlined at multiple points. Exceptions:
    #  * Simple references to global or local variables do not make the tree larger.
    #  * The result of ObjectifyWithAttributes might be referenced at multiple points, but different attributes might be accessed.
    #    So if we would not inline the result in that case, we would lose a lot of opportunities for optimizations.
    #    Ideally, we would only inline attributes which are accessed a single time and keep the other ones.
    elif is_rapid_reassigment or number_of_uses = 1 or lvar_assignment.rhs.type = "EXPR_REF_GVAR" or lvar_assignment.rhs.type = "EXPR_REF_FVAR" or CapJitIsCallToGlobalFunction( lvar_assignment.rhs, "ObjectifyWithAttributes" ) then
        
        Info( InfoCapJit, 1, "Success." );
        
        inline_tree_parent.(Last( inline_tree_path )) := modified_inline_tree;
        
    else
        
        Info( InfoCapJit, 1, "Variable is used multiple times (and does not match our heuristic which allows inlining despite this fact)." );
        
    fi;
    
    # drop lvar assignment if possible
    # if this is a rapid reassignment, we can simply drop the assignment
    # if not, the assignment might be in the body of an if statement and the lvar might still be used after the if statement
    
    if is_rapid_reassigment then
        
        Info( InfoCapJit, 1, "Drop first assignment of rapid reassignment." );
        
        Remove( parent, Int( Last( lvar_path ) ) );
        
    else
        
        # get func containing lvar assignment
        func_path := ShallowCopy( lvar_path );
        
        # find "stats"
        while Last( func_path ) <> "stats" do
            
            Remove( func_path );
            
        od;
        
        # remove "stats"
        Remove( func_path );
        
        Info( InfoCapJit, 1, "Try to drop variable assignment:" );
        
        tree := CapJitDroppedUnusedVariables( tree, func_path );
        
    fi;
    
    return CapJitInlinedVariableAssignments( tree );
    
end );
