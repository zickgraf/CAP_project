# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up and verify categorical algorithms
#
# Implementations
#
BindGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID", 1 );
MakeReadWriteGlobal( "CAP_JIT_INTERNAL_FUNCTION_ID" );

# names of functions which accept a domain and a function which is applied to elements of the domain
BindGlobal( "CAP_JIT_INTERNAL_NAMES_OF_LOOP_FUNCTIONS", [ "List", "Sum", "Product", "ForAll", "ForAny", "Number", "Filtered", "First", "SafeFirst", "SafeUniqueEntry", "Last", "SafePositionProperty", "SafeUniquePositionProperty" ] );

InstallGlobalFunction( CapJitIsCallToGlobalFunction, function ( tree, condition )
  local condition_func;
    
    if IsString( condition ) then
        
        if condition = "Range" or condition = "Target" then
            
            condition_func := gvar -> gvar = "Range" or gvar = "Target";
            
        else
            
            condition_func := gvar -> gvar = condition;
            
        fi;
        
    elif IsFunction( condition ) then
        
        condition_func := condition;
        
    else
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<condition> must be a string or a function" );
        
    fi;
    
    return tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_REF_GVAR" and condition_func( tree.funcref.gvar );
    
end );

InstallGlobalFunction( CapJitResultFuncCombineChildren, function ( tree, result, keys, additional_arguments )
  local key;
    
    tree := ShallowCopy( tree );
    
    for key in keys do
        
        tree.(key) := result.(key);
        
    od;
    
    return tree;
    
end );

InstallGlobalFunction( CapJitContainsRefToFVAROutsideOfFuncStack, function ( tree, initial_func_id_stack )
  local result_func, additional_arguments_func;
    
    result_func := function ( tree, result, keys, func_id_stack )
      local type, level;
        
        if tree.type = "EXPR_REF_FVAR" then
            
            if not tree.func_id in func_id_stack then
                
                return true;
                
            fi;
            
        fi;
        
        return ForAny( keys, key -> result.(key) );
        
    end;
    
    additional_arguments_func := function ( tree, key, func_id_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            Assert( 0, IsBound( tree.id ) );
            
            return Concatenation( func_id_stack, [ tree.id ] );
            
        else
            
            return func_id_stack;
            
        fi;
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, additional_arguments_func, initial_func_id_stack );
    
end );

BindGlobal( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER", 1 );
MakeReadWriteGlobal( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER" );
InstallGlobalFunction( CapJitGetOrCreateGlobalVariable, function ( value )
  local gvar, i;
    
    # check if value is already bound to a global variable
    for i in [ 1 .. CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER - 1 ] do
        
        gvar := Concatenation( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_", String( i ) );

        if IsIdenticalObj( value, ValueGlobal( gvar ) ) then
            
            return gvar;
            
        fi;
        
    od;
    
    # create new global variable
    gvar := Concatenation( "CAP_JIT_INTERNAL_GLOBAL_VARIABLE_", String( CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER ) );
    
    BindGlobal( gvar, value );

    CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER := CAP_JIT_INTERNAL_GLOBAL_VARIABLE_COUNTER + 1;
    
    return gvar;
    
end );

InstallGlobalFunction( CapJitFindNodeDeep, function ( tree, condition_func )
  local match, pre_func, result_func, additional_arguments_func;
    
    match := fail;
    
    pre_func := function ( tree, additional_arguments )
        
        if match = fail then
            
            return tree;
            
        else
            
            return fail;
            
        fi;
        
    end;
    
    result_func := function ( tree, result, keys, path )
      local key;
        
        if match <> fail then
            
            return fail;
            
        fi;
        
        # none of the descendants fulfills condition, otherwise we would already have returned above
        if condition_func( tree, path ) then
            
            match := path;
            return true;
            
        fi;
        
        # neither this record nor any of its descendants fulfills the condition
        return fail;
        
    end;
    
    additional_arguments_func := function ( tree, key, path )
        
        return Concatenation( path, [ key ] );
        
    end;
    
    CapJitIterateOverTree( tree, pre_func, result_func, additional_arguments_func, [ ] );
    
    return match;
    
end );

InstallGlobalFunction( CapJitFindNodes, function ( tree, condition_func )
  local result_func, additional_arguments_func;
    
    result_func := function ( tree, result, keys, path )
      local new_result;
        
        # concatenate the results of the children
        new_result := Concatenation( List( keys, name -> result.(name) ) );
        
        # add this node if it fulfills the condition
        if condition_func( tree, path ) then
            
            return Concatenation( new_result, [ path ] );
            
        else
            
            return new_result;
            
        fi;
        
    end;
    
    additional_arguments_func := function ( tree, key, path )
        
        return Concatenation( path, [ key ] );
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, additional_arguments_func, [ ] );
    
end );

InstallGlobalFunction( CapJitGetNodeByPath, function ( tree, path )
    
    if Length( path ) = 0 then
        
        return tree;
        
    else
       
        Assert( 0, IsBound( tree.(path[1]) ) );
        
        return CapJitGetNodeByPath( tree.(path[1]), path{[ 2 .. Length( path ) ]} );
        
    fi;
    
end );

InstallGlobalFunction( CapJitRemovedReturnFail, function ( tree )
  local found_return_fail, return_value, new_branches;
    
    Assert( 0, tree.type = "EXPR_DECLARATIVE_FUNC" );
    
    tree := StructuralCopy( tree );
    
    found_return_fail := false;
    
    return_value := tree.bindings.BINDING_RETURN_VALUE;
    
    if return_value.type = "EXPR_CASE" then
        
        new_branches := Filtered( return_value.branches, branch -> not (branch.value.type = "EXPR_REF_GVAR" and branch.value.gvar = "fail") );
        
        found_return_fail := return_value.branches.length <> new_branches.length;
        
        # turn `if true then var := value; fi;` into `var := value;`
        if new_branches.length = 1 and new_branches.1.condition.type = "EXPR_TRUE" then
            
            tree.bindings.BINDING_RETURN_VALUE := new_branches.1.value;
            
        else
            
            return_value.branches := new_branches;
            
        fi;
        
    fi;
    
    if not found_return_fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "Could not detect a statement returning fail. Either the pragma CAP_JIT_NEXT_FUNCCALL_DOES_NOT_RETURN_FAIL is not set correctly or the given structure is not yet handled correctly by the compiler." );
        
    fi;
    
    return tree;
    
end );

InstallGlobalFunction( CapJitPrettyPrintFunction, function ( func )
  local size_screen, function_string, string_stream;
    
    if IsOperation( func ) or IsKernelFunction( func ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "<func> must neither be an operation nor a kernel function" );
        
    fi;
    
    size_screen := SizeScreen( );
    
    # Lines which are exceeding SizeScreen and are thus wrapped using "\" are still valid GAP code,
    # so this is purely cosmetic.
    # We cannot use SetPrintFormattingStatus as that also prevents indentation.
    SizeScreen( [ 4096 ] );
    
    function_string := "";
    
    string_stream := OutputTextString( function_string, false );
    
    PrintTo( string_stream, func );
    
    CloseStream( string_stream );
    
    SizeScreen( size_screen );
    
    return function_string;
    
end );

InstallGlobalFunction( CapJitCopyWithNewFunctionIDs, function ( tree )
  local pre_func;
    
    tree := StructuralCopy( tree );
    
    pre_func := function ( tree, additional_arguments )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            tree := CAP_JIT_INTERNAL_REPLACED_FVARS_FUNC_ID( tree, CAP_JIT_INTERNAL_FUNCTION_ID, tree.nams );
            CAP_JIT_INTERNAL_FUNCTION_ID := CAP_JIT_INTERNAL_FUNCTION_ID + 1;
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, pre_func, CapJitResultFuncCombineChildren, ReturnTrue, true );
    
end );

InstallGlobalFunction( CapJitIsEqualForEnhancedSyntaxTrees, function ( tree1, tree2 )
    
    return CAP_JIT_INTERNAL_TREE_MATCHES_TEMPLATE_TREE( tree1, tree2, [ ], false ) <> fail;
    
end );

InstallGlobalFunction( CapJitAddBinding, function ( bindings, name, value )
  local rec_name;
    
    if not IsRecord( bindings ) or not IsBound( bindings.type ) or bindings.type <> "FVAR_BINDING_SEQ" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the first argument must be a syntax tree of type FVAR_BINDING_SEQ" );
        
    fi;
    
    if not IsString( name ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the second arguments must be a string" );
        
    fi;
    
    rec_name := Concatenation( "BINDING_", name );
    
    if IsBound( bindings.(rec_name) ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "there already is a binding with name ", name );
        
    fi;
    
    bindings.(rec_name) := value;
    Add( bindings.names, name );
    
end );

InstallGlobalFunction( CapJitValueOfBinding, function ( bindings, name )
    
    if not IsRecord( bindings ) or not IsBound( bindings.type ) or bindings.type <> "FVAR_BINDING_SEQ" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the first argument must be a syntax tree of type FVAR_BINDING_SEQ" );
        
    fi;
    
    if not IsString( name ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the second arguments must be a string" );
        
    fi;
    
    if not name in bindings.names then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( name, " is not the name of a binding" );
        
    fi;
    
    return bindings.(Concatenation( "BINDING_", name ));
    
end );

InstallGlobalFunction( CapJitUnbindBinding, function ( bindings, name )
  local pos;
    
    if not IsRecord( bindings ) or not IsBound( bindings.type ) or bindings.type <> "FVAR_BINDING_SEQ" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the first argument must be a syntax tree of type FVAR_BINDING_SEQ" );
        
    fi;
    
    if not IsString( name ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "the second arguments must be a string" );
        
    fi;
    
    pos := Position( bindings.names, name );
    
    if pos = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( name, " is not the name of a binding" );
        
    fi;
    
    Unbind( bindings.(Concatenation( "BINDING_", name )) );
    Remove( bindings.names, pos );
    
end );

InstallGlobalFunction( CapJitReplacedEXPR_REF_FVARByValue, function ( tree, func_id, name, value )
  local result_func;
    
    # Use result_func instead of pre_func: this way we do not iterate over `value` which
    # a) gives better performance and
    # b) prevents an infinite recursion in the following case:
    # val1 := 1;
    # val2 := 2;
    # val1 := val1;
    result_func := function ( tree, result, keys, additional_arguments )
      local key;
        
        tree := ShallowCopy( tree );
        
        for key in keys do
            
            tree.(key) := result.(key);
            
        od;
        
        if tree.type = "EXPR_REF_FVAR" and tree.func_id = func_id and tree.name = name then
            
            return CapJitCopyWithNewFunctionIDs( value );
            
        fi;
        
        return tree;
        
    end;
    
    return CapJitIterateOverTree( tree, ReturnFirst, result_func, ReturnTrue, true );
    
end );

InstallGlobalFunction( CapJitGetNextUnusedVariableID, function ( func )
  local used_ids, pos, name;
    
    used_ids := [ ];
    
    for name in func.nams do
        
        pos := Length( name );
        
        while pos > 0 and IsDigitChar( name[pos] ) do
            
            pos := pos - 1;
            
        od;
        
        if pos > 0 and pos < Length( name ) and name[pos] = '_' then
            
            Add( used_ids, Int( name{[ pos + 1 .. Length( name ) ]} ) );
            
        fi;
        
    od;
    
    return MaximumList( used_ids, 0 ) + 1;
    
end );

InstallGlobalFunction( CapJitDataTypeIsNestedListOfSimpleLiterals, function ( data_type )
    
    if data_type.filter in [ IsInt, IsBool, IsStringRep, IsChar ] then
        
        return true;
        
    elif data_type.filter = IsList then
        
        return CapJitDataTypeIsNestedListOfSimpleLiterals( data_type.element_type );
        
    else
        
        return false;
        
    fi;
    
end );

## allow to handle SYNTAX_TREE_LISTs like lists
InstallMethod( AsSyntaxTreeList,
               [ IsList ],
               
  function ( list )
    local tree, i;
    
    tree := rec(
        type := "SYNTAX_TREE_LIST",
        length := Length( list ),
    );
    
    for i in [ 1 .. Length( list ) ] do
        
        tree.(i) := list[i];
        
    od;
    
    return tree;
    
end );

InstallMethod( AsListMut,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord ],
               
  function ( tree )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return List( [ 1 .. tree.length ], i -> tree.(i) );
    
end );

InstallMethod( Sublist,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsDenseList and IsSmallList ],
               
  function ( tree, poslist )
    local choice, j, i;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    choice := rec(
        type := "SYNTAX_TREE_LIST",
        length := Length( poslist ),
    );
    
    j := 1;
    
    for i in poslist do
        
        choice.(j) := tree.(i);
        
        j := j + 1;
        
    od;
    
    return choice;
    
end );

InstallMethod( Remove,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord and IsMutable, IsPosInt ],
               
  function ( tree, index )
    local old_value, i;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    if index > tree.length then
        
        return;
        
    fi;
    
    old_value := tree.(index);
    
    # move all elements after index by one index to the front
    for i in [ index .. tree.length - 1 ] do
        
        tree.(i) := tree.(i + 1);
        
    od;
    
    Unbind( tree.(tree.length) );
    
    tree.length := tree.length - 1;
    
    return old_value;
    
end );

InstallMethod( PositionProperty,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return PositionProperty( [ 1 .. tree.length ], i -> func( tree.(i) ) );
    
end );

InstallGlobalFunction( ConcatenationForSyntaxTreeLists, function ( arg... )
  local tree, index, i, j;
    
    if Length( arg ) = 1 then
        
        arg := arg[1];
        
    fi;
    
    Assert( 0, IsList( arg ) );
    Assert( 0, ForAll( arg, a -> a.type = "SYNTAX_TREE_LIST" ) );
    
    tree := rec(
        type := "SYNTAX_TREE_LIST",
        length := Sum( arg, tree -> tree.length ),
    );
    
    index := 1;
    
    for i in [ 1 .. Length( arg ) ] do
        
        for j in [ 1 .. arg[i].length ] do
            
            tree.(index) := arg[i].(j);
            
            index := index + 1;
            
        od;
        
    od;
    
    return tree;
    
end );

InstallMethod( ListOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    local result, i;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    result := rec(
        type := "SYNTAX_TREE_LIST",
        length := tree.length,
    );
    
    for i in [ 1 .. tree.length ] do
        
        result.(i) := func( tree.(i) );
        
    od;
    
    return result;
    
end );

InstallMethod( FilteredOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return AsSyntaxTreeList( Filtered( AsListMut( tree ), func ) );
    
end );

InstallMethod( PositionsProperty,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return PositionsProperty( AsListMut( tree ), func );
    
end );

InstallMethod( FirstOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    local elm;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    for elm in tree do
        
        if func( elm ) then
            
            return elm;
            
        fi;
        
    od;
    
    return fail;
    
end );

InstallMethod( LastOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord ],
               
  function ( tree )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    if tree.length = 0 then
        
        return fail;
        
    fi;
    
    return tree.(tree.length);
    
end );

InstallMethod( ForAllOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return ForAll( [ 1 .. tree.length ], i -> func( tree.(i) ) );
    
end );

InstallMethod( ForAnyOp,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord, IsFunction ],
               
  function ( tree, func )
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    return ForAny( [ 1 .. tree.length ], i -> func( tree.(i) ) );
    
end );

InstallMethod( Iterator,
               "for syntax tree nodes of type SYNTAX_TREE_LIST",
               [ IsRecord ],
               
  function ( tree )
    local iter;
    
    if not IsBound( tree.type ) or tree.type <> "SYNTAX_TREE_LIST" then
        
        # COVERAGE_IGNORE_NEXT_LINE
        TryNextMethod();
        
    fi;
    
    # cf. IteratorList
    iter := rec(
        tree := tree,
        pos := 0,
        len := tree.length,
        NextIterator := function ( iter )
          local p;
            
            p := iter!.pos + 1;
            
            iter!.pos := p;
            
            return iter!.tree.(p);
            
        end,
        IsDoneIterator := iter -> iter!.pos >= iter!.len,
        ShallowCopy := iter -> rec( tree := iter!.tree, pos := iter!.pos, len := iter!.len ),
    );
    
    return IteratorByFunctions( iter );
    
end );

InstallGlobalFunction( PrintWithCurrentlyCompiledFunctionLocation, function ( args... )
  local func;
    
    # COVERAGE_IGNORE_BLOCK_START
    if IsEmpty( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK ) then
        
        CallFuncList( Print, Concatenation( args, [ "\nwhile not compiling a function. This should never happen.\n" ] ) );
        
    fi;
    
    func := Last( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
    CallFuncList( Print, Concatenation( args, [ "\nwhile compiling function with name \"", NameFunction( func ), "\"\nlocated at ", FilenameFunc( func ), ":", StartlineFunc( func ), "\n\n" ] ) );
    # COVERAGE_IGNORE_BLOCK_END
    
end );

InstallGlobalFunction( DisplayWithCurrentlyCompiledFunctionLocation, function ( obj )
  local func;
    
    # COVERAGE_IGNORE_BLOCK_START
    if IsEmpty( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK ) then
        
        Error( obj, "\nwhile not compiling a function. This should never happen.\n" );
        
    fi;
    
    func := Last( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
    Display( obj );
    
    Print( "while compiling function with name \"", NameFunction( func ), "\"\nlocated at ", FilenameFunc( func ), ":", StartlineFunc( func ), "\n\n" );
    # COVERAGE_IGNORE_BLOCK_END
    
end );

InstallGlobalFunction( ErrorWithCurrentlyCompiledFunctionLocation, function ( args... )
  local func;
    
    # COVERAGE_IGNORE_BLOCK_START
    if IsEmpty( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK ) then
        
        CallFuncList( Error, Concatenation( args, [ "\nwhile not compiling a function. This should never happen.\n" ] ) );
        
    fi;
    
    func := Last( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
    CallFuncList( Error, Concatenation( args, [ "\nwhile compiling function with name \"", NameFunction( func ), "\"\nlocated at ", FilenameFunc( func ), ":", StartlineFunc( func ), "\n" ] ) );
    # COVERAGE_IGNORE_BLOCK_END
    
end );

InstallGlobalFunction( EvalStringStrict, function ( string )
  local func;
    
    func := ReadAsFunction( InputTextString( Concatenation( "return ", string, ";" ) ) );
    
    if func = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "a syntax error has occured" );
        
    fi;
    
    return EvalString( string );
    
end );

InstallGlobalFunction( "ConcatenationOfStringsAsEnumerationWithAnd", function ( parts )
    
    Assert( 0, Length( parts ) > 0 );
    
    if Length( parts ) = 1 then
        
        return parts[1];
        
    elif Length( parts ) = 2 then
        
        return Concatenation( parts[1], " and ", parts[2] );
        
    else
        
        return Concatenation( JoinStringsWithSeparator( parts{[ 1 .. Length( parts ) - 1 ]}, ", " ), ", and ", Last( parts ) );
        
    fi;
    
end );

WriteResultToTeXFile := function ( filename, result )
  local path, content;
    
    path := Concatenation( filename, ".gap_autogen.tex" );
    
    result := Concatenation(
        "\\begin{autogen}\n",
        result,
        "\n\\end{autogen}\n"
    );
    
    # check if file already exists with the correct content
    if IsExistingFile( path ) then
        
        content := ReadFileForHomalg( path );
        
        if content = result then
            
            return;
            
        fi;
        
    fi;
    
    WriteFileForHomalg( path, result );
    
end;

FunctionLaTeXString := function ( func )
  local old_size_screen, string;
    
    old_size_screen := SizeScreen( );
    
    SizeScreen( [ 70 ] );
    
    string := DisplayString( func );
    
    # drop trailing new line
    string := string{[ 1 .. Length( string ) - 1 ]};
    
    string := Concatenation(
        "\\begin{Verbatim}[frame=single]\n",
        string,
        "\n\\end{Verbatim}\n"
    );
    
    SizeScreen( old_size_screen );
    
    return string;
    
end;

prepare_for_tensoring := function ( string, tree )
    
    #return string;
    
    #if CapJitIsCallToGlobalFunction( tree, gvar -> gvar in [ "TensorProductOnMorphisms", "LeftUnitorInverse", "Braiding", "AssociatorLeftToRight", "AssociatorRightToLeft", "CoevaluationForDual" ] ) then
    if CapJitIsCallToGlobalFunction( tree, gvar -> gvar in [ "TensorProductOnMorphisms", "TensorProductOnMorphismsWithGivenTensorProducts", "TensorProductOnObjects", "PreComposeList", "PreCompose", "AdditionForMorphisms", "AdditiveInverseForMorphisms" ] ) then
        
        return Concatenation( "\\left(", string, "\\right)" );
        
    else
        
        return string;
        
    fi;
    
end;

BindGlobal( "LaTeXName", function ( name )
  local GREEK_LETTERS, pos, letter_name;
    
    GREEK_LETTERS := rec(
        alpha := "α",
        beta := "β",
        gamma := "γ",
        delta := "δ",
        epsilon := "ε",
        zeta := "ζ",
        eta := "η",
        theta := "θ",
        iota := "ι",
        kappa := "κ",
        lambda := "λ",
        mu := "μ",
        nu := "ν",
        xi := "ξ",
        # omikron
        pi := "π",
        rho := "ρ",
        sigma := "σ",
        tau := "τ",
        # ypsilon
        phi := "φ",
        chi := "χ",
        psi := "ψ",
        omega := "ω",
    );
    
    # replace names of greek letters by unicode characters
    for letter_name in RecNames( GREEK_LETTERS ) do
        
        if StartsWith( name, letter_name ) then
            
            name := Concatenation( GREEK_LETTERS.(letter_name), name{[ Length( letter_name ) + 1 .. Length( name ) ]} );
            break;
            
        fi;
        
    od;
    
    # turn trailing numbers into indices
    pos := Length( name ) - SafePositionProperty( Reversed( name ), c -> not IsDigitChar( c ) ) + 1;
    
    if pos < Length( name ) then
        
        name := Concatenation( name{[ 1 .. pos ]}, "_{", name{[ pos + 1 .. Length( name ) ]}, "}" );
        
    fi;
    
    return name;
            
end );

FunctionAsMathString := function ( func, cat, input_filters, args... )
  local suffix, arguments_data_types, type_signature, func_tree, return_value, result_func, additional_arguments_func, left_list, right, latex_string, max_length, mor, i;
    
    if IsEmpty( args ) then
        
        suffix := "";
        
    elif Length( args ) = 1 then
        
        suffix := args[1];
        
    else
        
        Error( "FunctionAsMathString must be called with at most three arguments" );
        
    fi;
    
    if not IsList( input_filters ) or Length( input_filters ) <> NumberArgumentsFunction( func ) then
        
        Error( "<input_filters> must be a list of length `NumberArgumentsFunction( <func> )`" );
        
    fi;
    
    if not ForAll( input_filters, x -> IsString( x ) ) then
        
        Error( "can only handle input filters given by strings" );
        
    fi;
    
    arguments_data_types := List( input_filters, x -> CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( x, cat ) );
    
    Assert( 0, not fail in arguments_data_types );
    
    type_signature := Pair( arguments_data_types, fail );
    
    func_tree := ENHANCED_SYNTAX_TREE( func );
    func_tree.data_type := rec( filter := IsFunction, signature := type_signature );
    
    # TODO: populate CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK
    func_tree := CapJitInferredDataTypes( func_tree );
    
    if Length( func_tree.bindings.names ) > 1 then
        
        Error( "only functions without proper bindings can be displayed as math" );
        
    fi;
    
    return_value := func_tree.bindings.BINDING_RETURN_VALUE;
    
    result_func := function ( tree, result, keys, func_stack )
      local pos, type, GREEK_LETTERS, name, string, info, local_cat, object_func_tree, object_func, source_string, range_string, math_record, list, mor, letter_name, i;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # TODO
            return result.bindings;
            
        elif tree.type = "SYNTAX_TREE_LIST" then
            
            return result;
            
        elif tree.type = "FVAR_BINDING_SEQ" then
            
            if tree.names <> [ "RETURN_VALUE" ] then
                
                Error( "only functions without proper bindings can be displayed as math" );
                
            fi;
            
            return result.BINDING_RETURN_VALUE;
            
        elif tree.type = "EXPR_TRUE" then
            
            return rec(
                type := "bool",
                string := "\\qed",
            );
            
        # TODO: this should be a function!!!
        elif tree.type = "EXPR_EQ" then
            
            return rec(
                type := "bool",
                string := Concatenation( result.left.string, " = ", result.right.string ),
            );
            
        elif tree.type = "EXPR_INT" then
            
            return rec(
                type := "integer",
                string := String( tree.value ),
            );
            
        elif tree.type = "EXPR_FALSE" then
            
            return rec(
                type := "bool",
                string := "\\bottom",
            );
            
        elif tree.type = "EXPR_LIST" then
            
            result.list.type := "list";
            result.list.length := tree.list.length;
            return result.list;
            
        elif tree.type = "EXPR_REF_GVAR" then
            
            return rec(
                type := "var",
                string := tree.gvar,
            );
            
        elif tree.type = "EXPR_REF_FVAR" then
            
            # TODO: make variable names unique
            
            func := SafeUniqueEntry( func_stack, f -> f.id = tree.func_id );
            
            pos := SafeUniquePosition( func.nams, tree.name );
            
            if tree.func_id = func_tree.id then
                
                type := input_filters[pos];
                
            elif IsBound( func.data_type ) then
                
                type := func.data_type.signature[1][pos].filter;
                
                if IsSpecializationOfFilter( "category", type ) then
                    
                    type := "category";
                    
                elif IsSpecializationOfFilter( "object", type ) then
                    
                    type := "object";
                    
                elif IsSpecializationOfFilter( "morphism", type ) then
                    
                    type := "morphism";
                    
                else
                    
                    Error( "unknown type" );
                    
                fi;
                
            else
                
                Error( "cannot determine type" );
                
            fi;
            
            name := LaTeXName( tree.name );
            
            if type = "category" then
                
                return rec(
                    type := "category",
                    string := name,
                );
                
            elif type = "object" then
                
                return rec(
                    type := "object",
                    string := name,
                );
                
            elif type = "morphism" then
                
                return rec(
                    type := "morphism",
                    source := Concatenation( "s(", name, ")" ),
                    range := Concatenation( "t(", name, ")" ),
                    string := name,
                );
                
            elif type = "morphism_in_range_category_of_homomorphism_structure" then
                
                return rec(
                    type := "morphism_in_range_category_of_homomorphism_structure",
                    source := Concatenation( "s(", name, ")" ),
                    range := Concatenation( "t(", name, ")" ),
                    string := name,
                );
                
            elif type = "list_of_objects" then
                
                return rec(
                    type := "list_of_objects",
                    string := Concatenation( "[", name, "\ldots]" ),
                );
                
            elif type = "list_of_morphisms" then
                
                return rec(
                    type := "list_of_morphisms",
                    string := Concatenation( "[", name, "\ldots]" ),
                );
                
            else
                
                Error( "unkown type ", type );
                
            fi;
            
        elif CapJitIsCallToGlobalFunction( tree, ReturnTrue ) then
            
            #if tree.funcref.gvar = "PreCompose" then
            #    
            #    first := result.args.2;
            #    
            #    if first.type = "morphism" then
            #        
            #        first_list := [ first ];
            #        
            #    elif first.type = "PreComposeList" then
            #        
            #        first_list := first.list;
            #        
            #    else
            #        
            #        Error( "unknown type ", first.type, " in PreCompose" );
            #        
            #    fi;
            #    
            #    second := result.args.3;
            #    
            #    if second.type = "morphism" then
            #        
            #        second_list := [ second ];
            #        
            #    elif second.type = "PreComposeList" then
            #        
            #        second_list := second.list;
            #        
            #    else
            #        
            #        Error( "unknown type ", second.type, " in PreCompose" );
            #        
            #    fi;
            #    
            #    return rec(
            #        type := "PreComposeList",
            #        list := Concatenation( first_list, second_list ),
            #    );
            #    
            #fi;
            
            #if tree.funcref.gvar = "TensorProductOnMorphismsWithGivenTensorProducts" then
            #    
            #    #if result.args.2.type = "morphism" and result.args.3.type = "morphism" then
            #    if result.args.3.type = "morphism" and result.args.4.type = "morphism" then
            #        
            #        return rec(
            #            type := "morphism",
            #            #source := Concatenation( prepare_for_tensoring( result.args.2.source, tree.args.2 ), " ⊗ ", prepare_for_tensoring( result.args.3.source, tree.args.3 ) ),
            #            #range := Concatenation( prepare_for_tensoring( result.args.2.range, tree.args.2 ), " ⊗ ", prepare_for_tensoring( result.args.3.range, tree.args.3 ) ),
            #            #string := Concatenation( prepare_for_tensoring( result.args.2.string, tree.args.2 ), " ⊗ ", prepare_for_tensoring( result.args.3.string, tree.args.3 ) ),
            #            source := result.args.2.string,
            #            range := result.args.5.string,
            #            string := Concatenation( prepare_for_tensoring( result.args.3.string, tree.args.3 ), " ⊗ ", prepare_for_tensoring( result.args.4.string, tree.args.4 ) ),
            #        );
            #        
            #    #elif result.args.2.type = "PreComposeList" and result.args.3.type = "morphism" then
            #    #    
            #    #    return rec(
            #    #        type := "PreComposeList",
            #    #        list := List( result.args.2.list, l -> rec(
            #    #            type := "morphism",
            #    #            source := Concatenation( l.source, " ⊗ TODO: ", result.args.3.source ),
            #    #            range := Concatenation( l.range, " ⊗ TODO: ", result.args.3.range ),
            #    #            string := Concatenation( l.string, " ⊗ TODO: ", result.args.3.string ),
            #    #        ) ),
            #    #    );
            #    #    
            #    else
            #        
            #        Error( "case not handled yet" );
            #        
            #    fi;
            #    
            #fi;
            
            if tree.funcref.gvar = "List" then
                
                return rec(
                    type := "list",
                    string := Concatenation( "List(", result.args.1.string, ", ", result.args.2.string, ")" ),
                );
                
            fi;
            
            if tree.funcref.gvar = "Concatenation" then
                
                return rec(
                    type := "list",
                    string := Concatenation( "Concatenation(", JoinStringsWithSeparator( List( [ 1 .. tree.args.length ], i -> result.args.(i).string ), ", " ), ")" ),
                );
                
            fi;
            
            if tree.funcref.gvar = "CreateCapCategoryObjectWithAttributes" then
                
                if tree.args.length <> 3 then
                    
                    Error( "Cannot handle CreateCapCategoryObjectWithAttributes with less or more than three arguments yet." );
                    
                fi;
                
                return rec(
                    type := "object",
                    string := Concatenation( "\\boxed{", result.args.3.string, "}" ),
                );
                
            fi;
            
            if tree.funcref.gvar = "-" and result.args.1.type = "integer" and result.args.2.type = "integer" then
                
                return rec(
                    type := "integer",
                    string := Concatenation( result.args.1.string, " - ", result.args.2.string ),
                );
                
            fi;
            
            if tree.funcref.gvar = "*" and result.args.1.type = "integer" and result.args.2.type = "integer" then
                
                return rec(
                    type := "integer",
                    string := Concatenation( result.args.1.string, " ⋅ ", result.args.2.string ),
                );
                
            fi;
            
            if tree.funcref.gvar = "*" and result.args.1.type = "homalg_matrix" and result.args.2.type = "homalg_matrix" then
                
                return rec(
                    type := "homalg_matrix",
                    string := Concatenation( result.args.1.string, " ⋅ ", result.args.2.string ),
                );
                
            fi;
            
            if tree.funcref.gvar = "NumberRows" and result.args.1.type = "homalg_matrix" then
                
                return rec(
                    type := "integer",
                    string := Concatenation( "NumberRows(", result.args.1.string, ")" ),
                );
                
            fi;
            
            if tree.funcref.gvar = "NumberColumns" and result.args.1.type = "homalg_matrix" then
                
                return rec(
                    type := "integer",
                    string := Concatenation( "NumberColumns(", result.args.1.string, ")" ),
                );
                
            fi;
            
            if tree.funcref.gvar = "RowRankOfMatrix" and result.args.1.type = "homalg_matrix" then
                
                return rec(
                    type := "integer",
                    string := Concatenation( "RowRankOfMatrix(", result.args.1.string, ")" ),
                );
                
            fi;
            
            for i in [ 1 .. tree.args.length ] do
                
                if not result.args.(i).type in [ "category", "object", "object_in_range_category_of_homomorphism_structure", "morphism", "morphism_in_range_category_of_homomorphism_structure", "list", "list_of_objects", "list_of_morphisms" ] then
                    
                    Error( tree.funcref.gvar, " can only handle categories, objects, morphisms, and literal lists, but not ", result.args.(i).type );
                    
                fi;
                
            od;
            
            if tree.funcref.gvar in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) then
                
                info := CAP_INTERNAL_METHOD_NAME_RECORD.(tree.funcref.gvar);
                
                if info.return_type in [ "morphism", "morphism_in_range_category_of_homomorphism_structure" ] and tree.args.length = Length( info.filter_list ) then
                    
                    if not IsBound( info.output_source_getter ) or not IsBound( info.output_range_getter ) then
                        
                        Error( "cannot determine source and/or range of CAP operation ", tree.funcref.gvar );
                        
                    fi;
                    
                    if info.return_type = "morphism" then
                        
                        local_cat := cat;
                        
                    elif info.return_type = "morphism_in_range_category_of_homomorphism_structure" then
                        
                        local_cat := RangeCategoryOfHomomorphismStructure( cat );
                        local_cat := cat;
                        
                    else
                        
                        Error( "this should never happen" );
                        
                    fi;
                    
                    #Display( "start" );
                    
                    # we currently do not support nested functions or bindings
                    # in particular, the code can only depend on arguments of func_tree
                    object_func_tree := ShallowCopy( func_tree );
                    object_func_tree.bindings := ShallowCopy( object_func_tree.bindings );
                    object_func_tree.bindings.BINDING_RETURN_VALUE := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := ENHANCED_SYNTAX_TREE( info.output_source_getter : given_arguments := [ local_cat ] ), # TODO: types
                        args := tree.args,
                    );
                    
                    #Display( object_func_tree );
                    #Display( ENHANCED_SYNTAX_TREE_CODE( object_func_tree ) );
                    
                    # TODO types
                    object_func := CapJitCompiledFunction( ENHANCED_SYNTAX_TREE_CODE( object_func_tree ), local_cat );
                    
                    #Display( tree.funcref.gvar );
                    #Display( object_func );
                    
                    source_string := FunctionAsMathString( object_func, local_cat, input_filters : raw );
                    
                    #Display( source_string );
                    
                    # we currently do not support nested functions or bindings
                    # in particular, the code can only depend on arguments of func_tree
                    object_func_tree := ShallowCopy( func_tree );
                    object_func_tree.bindings := ShallowCopy( object_func_tree.bindings );
                    object_func_tree.bindings.BINDING_RETURN_VALUE := rec(
                        type := "EXPR_FUNCCALL",
                        funcref := ENHANCED_SYNTAX_TREE( info.output_range_getter : given_arguments := [ local_cat ] ), # TODO: types
                        args := tree.args,
                    );
                    
                    # TODO types
                    object_func := CapJitCompiledFunction( ENHANCED_SYNTAX_TREE_CODE( object_func_tree ), local_cat );
                    
                    range_string := FunctionAsMathString( object_func, local_cat, input_filters : raw );
                    
                    #Display( range_string );
                    
                fi;
                
            fi;
            
            math_record := fail;
            
            if tree.funcref.gvar = "PreComposeList" then
                
                if tree.args.3.type = "EXPR_LIST" and ForAll( tree.args.3.list, x -> x.type = "EXPR_REF_FVAR" ) then
                    
                    list := result.args.3;
                    
                    if list.type <> "list" then
                        
                        Error( "this case is not handled yet" );
                        
                    fi;
                    
                    math_record := rec(
                        type := "morphism",
                        string := JoinStringsWithSeparator( List( [ 1 .. list.length ], i -> list.(i).string ), " ⋅ " ),
                    );
                    
                else
                    
                    list := result.args.3;
                    
                    if list.type <> "list" then
                        
                        Error( "this case is not handled yet" );
                        
                    fi;
                    
                    string := "";
                    
                    for i in [ 1 .. list.length ] do
                        
                        mor := list.(i);
                        
                        string := Concatenation( string, mor.source ); 
                        string := Concatenation( string, "\\xrightarrow{" ); 
                        string := Concatenation( string, mor.string ); 
                        string := Concatenation( string, "}" ); 
                        
                        if i < list.length and mor.range <> list.(i + 1).source then
                            
                            #Error("range and source are not equal");
                            
                            string := Concatenation( string, mor.range ); 
                            string := Concatenation( string, " = " ); 
                            
                        fi;
                        
                    od;
                    
                    string := Concatenation( string, list.(list.length).range ); 
                    
                    math_record := rec(
                        type := "morphism",
                        string := string,
                    );
                    
                fi;
                
            elif tree.funcref.gvar = "=" then
                
                math_record := rec(
                    type := "bool",
                    string := Concatenation( result.args.1.string, " \\quad = \\quad ", result.args.2.string ),
                );
                
            elif tree.funcref.gvar = "Length" then
                
                math_record := rec(
                    type := "integer",
                    string := Concatenation( "\\mathrm{Length}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "UnderlyingCategory" then
                
                math_record := rec(
                    type := "category",
                    string := Concatenation( "\\mathrm{UnderlyingCategory}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "RankOfObject" then
                
                math_record := rec(
                    type := "integer",
                    string := Concatenation( "\\mathrm{RankOfObject}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "Dimension" then
                
                math_record := rec(
                    type := "integer",
                    string := Concatenation( "\\mathrm{Dimension}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "UnderlyingMatrix" then
                
                math_record := rec(
                    type := "homalg_matrix",
                    string := Concatenation( "\\mathrm{UnderlyingMatrix}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "ObjectList" then
                
                math_record := rec(
                    type := "list_of_objects",
                    string := Concatenation( "\\mathrm{ObjectList}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "IdentityMorphism" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "id_{", result.args.2.string, "}" ),
                );
                
            elif tree.funcref.gvar = "ZeroMorphism" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "0_{", result.args.2.string, ", ", result.args.3.string, "}" ),
                );
                
            elif tree.funcref.gvar = "RangeCategoryOfHomomorphismStructure" then
                
                math_record := rec(
                    type := "category",
                    string := "D",
                );
                
            elif tree.funcref.gvar = "TensorUnit" then
                
                math_record := rec(
                    type := "object",
                    string := "1",
                );
                
            elif tree.funcref.gvar = "TensorProductOnObjects" then
                
                math_record := rec(
                    type := "object",
                    string := Concatenation( prepare_for_tensoring( result.args.2.string, tree.args.2 ), " ⊗ ", prepare_for_tensoring( result.args.3.string, tree.args.3 ) ),
                );
                
            elif tree.funcref.gvar = "TensorProductOnMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( prepare_for_tensoring( result.args.2.string, tree.args.2 ), " ⊗ ", prepare_for_tensoring( result.args.3.string, tree.args.3 ) ),
                );
                
            elif tree.funcref.gvar = "LeftUnitor" then
                
                math_record := rec(
                    type := "morphism",
                    string := "λ",
                );
                
            elif tree.funcref.gvar = "LeftUnitorInverse" then
                
                math_record := rec(
                    type := "morphism",
                    string := "λ⁻¹",
                );
                
            elif tree.funcref.gvar = "RightUnitor" then
                
                math_record := rec(
                    type := "morphism",
                    string := "ρ",
                );
                
            elif tree.funcref.gvar = "RightUnitorInverse" then
                
                math_record := rec(
                    type := "morphism",
                    string := "ρ⁻¹",
                );
                
            elif tree.funcref.gvar = "AssociatorLeftToRight" then
                
                math_record := rec(
                    type := "morphism",
                    string := "α",
                );
                
            elif tree.funcref.gvar = "AssociatorRightToLeft" then
                
                math_record := rec(
                    type := "morphism",
                    string := "α⁻¹",
                );
                
            elif tree.funcref.gvar = "Braiding" then
                
                math_record := rec(
                    type := "morphism",
                    string := "γ",
                );
                
            elif tree.funcref.gvar = "BraidingInverse" then
                
                math_record := rec(
                    type := "morphism",
                    string := "γ⁻¹",
                );
                
            elif tree.funcref.gvar = "Source" then
                
                math_record := rec(
                    type := "object",
                    string := Concatenation( "s(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar in [ "Range", "Target" ] then
                
                math_record := rec(
                    type := "object",
                    string := Concatenation( "t(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "DualOnObjects" then
                
                math_record := rec(
                    type := "object",
                    string := Concatenation( result.args.2.string, "ᵛ" ),
                );
                
            elif tree.funcref.gvar = "DualOnMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( result.args.2.string, "ᵛ" ),
                );
                
            elif tree.funcref.gvar = "EvaluationForDual" then
                
                math_record := rec(
                    type := "morphism",
                    #string := "ev",
                    string := "",
                );
                
            elif tree.funcref.gvar = "CoevaluationForDual" then
                
                math_record := rec(
                    type := "morphism",
                    #string := "coev",
                    string := "",
                );
                
            elif tree.funcref.gvar = "DistinguishedObjectOfHomomorphismStructure" then
                
                math_record := rec(
                    type := "object",
                    string := "1",
                );
                
            elif tree.funcref.gvar = "InternalHomOnObjects" then
                
                math_record := rec(
                    type := "object",
                    string := Concatenation( "hom(", result.args.2.string, ",", result.args.3.string, ")" ),
                );
                
            elif tree.funcref.gvar = "HomomorphismStructureOnObjects" then
                
                math_record := rec(
                    type := "object",
                    string := Concatenation( "H(", result.args.2.string, ",", result.args.3.string, ")" ),
                );
                
            elif tree.funcref.gvar = "InternalHomOnMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "hom(", result.args.2.string, ",", result.args.3.string, ")" ),
                );
                
            elif tree.funcref.gvar = "HomomorphismStructureOnMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "H(", result.args.2.string, ",", result.args.3.string, ")" ),
                );
                
            elif tree.funcref.gvar = "BasisOfExternalHom" then
                
                math_record := rec(
                    type := "list_of_morphisms",
                    string := Concatenation( "\\mathcal{B}(\\operatorname{Hom}(", result.args.2.string, ",", result.args.3.string, "))" ),
                );
                
            elif tree.funcref.gvar = "PreCompose" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( prepare_for_tensoring( result.args.2.string, tree.args.2 ), " ⋅ ", prepare_for_tensoring( result.args.3.string, tree.args.3 ) ),
                );
                
            elif tree.funcref.gvar = "AdditionForMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( prepare_for_tensoring( result.args.2.string, tree.args.2 ), " + ", prepare_for_tensoring( result.args.3.string, tree.args.3 ) ),
                );
                
            elif tree.funcref.gvar = "AdditiveInverseForMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "-", prepare_for_tensoring( result.args.2.string, tree.args.2 ) ),
                );
                
            elif tree.funcref.gvar = "IsCongruentForMorphisms" then
                
                math_record := rec(
                    type := "bool",
                    string := Concatenation( result.args.2.string, " \\quad ∼ \\quad ", result.args.3.string ),
                );
                
            elif tree.funcref.gvar = "IsEqualForObjects" or tree.funcref.gvar = "IsEqualForMorphisms" then
                
                math_record := rec(
                    type := "bool",
                    string := Concatenation( result.args.2.string, " = ", result.args.3.string ),
                );
                
            elif tree.funcref.gvar = "IsWellDefinedForMorphisms" then
                
                math_record := rec(
                    type := "bool",
                    string := Concatenation( "IsWellDefined(", result.args.2.string, ")" ),
                );
                
            elif tree.funcref.gvar = "IsZeroForMorphisms" then
                
                math_record := rec(
                    type := "bool",
                    string := Concatenation( "IsZero(", result.args.2.string, ")" ),
                );
                
            elif tree.funcref.gvar = "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" then
                
                math_record := rec(
                    type := "morphism_in_range_category_of_homomorphism_structure",
                    string := Concatenation( "\\nu_{", result.args.2.source, ", ", result.args.2.range, "}(", result.args.2.string, ")" ),
                );
                
            elif tree.funcref.gvar = "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "\\nu_{", result.args.2.string, ", ", result.args.3.string, "}^{-1}(", result.args.4.string, ")" ),
                );
                
            fi;
            
            if tree.funcref.gvar in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) then
                
                info := CAP_INTERNAL_METHOD_NAME_RECORD.(tree.funcref.gvar);
                
                if math_record = fail then
                    
                    math_record := rec(
                        type := info.return_type,
                        string := Concatenation( "\\mathrm{", tree.funcref.gvar, "}(", JoinStringsWithSeparator( List( [ 2 .. tree.args.length ], i -> result.args.(i).string ), ", " ), ")" ),
                    );
                    
                fi;
                
                if info.return_type in [ "morphism", "morphism_in_range_category_of_homomorphism_structure" ] then
                    
                    math_record.source := source_string;
                    math_record.range := range_string;
                    
                fi;
                
            fi;
            
            if math_record = fail then
                
                Error( tree.funcref.gvar, " is not yet handled" );
                
            fi;
            
            return math_record;
            
        fi;
        
        Error( tree.type, " is not yet handled" );
        
    end;
    
    additional_arguments_func := function ( tree, key, func_stack )
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            return Concatenation( func_stack, [ tree ] );
            
        else
            
            return func_stack;
            
        fi;
        
    end;
    
    if CapJitIsCallToGlobalFunction( return_value, "IsCongruentForMorphisms" ) and CapJitIsCallToGlobalFunction( return_value.args.2, "PreComposeList" ) and return_value.args.3.type = "EXPR_REF_FVAR" then
        
        #Error( "only functions returning the result of a call to IsCongruentForMorphisms can be displayed as math" );
        
        left_list := CapJitIterateOverTree( return_value.args.2.args.3, ReturnFirst, result_func, additional_arguments_func, [ func_tree ] );
        right := CapJitIterateOverTree( return_value.args.3, ReturnFirst, result_func, additional_arguments_func, [ func_tree ] );
        
        Assert( 0, left_list.type = "list" );
        
        left_list.type := "SYNTAX_TREE_LIST";
        
        left_list := AsListMut( left_list );
        
        latex_string := "";
        
        max_length := Maximum( List( left_list, mor -> Maximum( WidthUTF8String( mor.source ), WidthUTF8String( mor.range ) ) ) );
        
        #if IsEven( max_length ) then
        #    max_length := max_length + 1;
        #fi;
        
        for i in [ 1 .. Length( left_list ) ] do
            
            mor := left_list[i];
            
            #DisplayCentered( mor.source, max_length, "" );
            #DisplayCentered( "│", max_length, TextAttr.7 );
            #PrintCentered( "│", max_length, TextAttr.7 );
            #Print( " ", TextAttr.bold, " ", mor.string, " ", TextAttr.reset, "\n" );
            #DisplayCentered( "∨", max_length, TextAttr.7 );
            
            latex_string := Concatenation( latex_string, mor.source ); 
            latex_string := Concatenation( latex_string, "\\arrow[dd, \"" ); 
            latex_string := Concatenation( latex_string, mor.string ); 
            latex_string := Concatenation( latex_string, "\"] \\\\\n\\\\\n" ); 
            
            if i < Length( left_list ) and mor.range <> left_list[i + 1].source then
                
                #DisplayCentered( mor.range, max_length, "" );
                #DisplayCentered( "∥", max_length, TextAttr.7 );
                
                latex_string := Concatenation( latex_string, mor.range ); 
                latex_string := Concatenation( latex_string, "\\arrow[d, Rightarrow, no head] \\\\\n" ); 
                
            fi;
            
        od;
        
        #DisplayCentered( Last( left_list ).range, max_length, "" );
        latex_string := Concatenation( latex_string, Last( left_list ).range, "\\arrow[dd, phantom, \"\\sim\"]\\\\\n\\\\\n" ); 
        
        #Display( "∼" );
        #Display( right.string );
        latex_string := Concatenation( latex_string, right.string );
        
        #LoadPackage( "ToolsForHigher" );
        
        if ValueOption( "raw" ) = true then
            
            Error( "raw not supported" );
            
        fi;
        
        latex_string := ReplacedString( latex_string, "⁻¹", """^{-1}""" );
        latex_string := ReplacedString( latex_string, "ᵛ", """^{\vee}""" );
        latex_string := ReplacedString( latex_string, "⊗", """\otimes""" );
        latex_string := ReplacedString( latex_string, "id", """\mathrm{id}""" );
        latex_string := ReplacedString( latex_string, "ev", """\mathrm{ev}""" );
        latex_string := ReplacedString( latex_string, "coev", """\mathrm{coev}""" );
        latex_string := ReplacedString( latex_string, "hom", """\mathrm{hom}""" );
        latex_string := ReplacedString( latex_string, "", """\mathrm{ev}""" );
        latex_string := ReplacedString( latex_string, "", """\mathrm{coev}""" );
        latex_string := ReplacedString( latex_string, "α", """\alpha""" );
        latex_string := ReplacedString( latex_string, "β", """\beta""" );
        latex_string := ReplacedString( latex_string, "γ", """\gamma""" );
        latex_string := ReplacedString( latex_string, "λ", """\lambda""" );
        latex_string := ReplacedString( latex_string, "ρ", """\rho""" );
        latex_string := ReplacedString( latex_string, "IsWellDefined", """\mathrm{IsWellDefined}""" );
        latex_string := ReplacedString( latex_string, "IsZero", """\mathrm{IsZero}""" );
        
        #Error("here");
        
        #return Concatenation( "\\[\n    ", latex_string, "\n\\]\n" );
        
        latex_string := Concatenation( "\\begin{tikzcd}\n", latex_string, "\\end{tikzcd}\n" );
        #return Concatenation( "\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{$", latex_string, "$}\n" );
        #return Concatenation( "\\begin{center}\\framebox[\\textwidth]{\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{$", latex_string, "$}}\\end{center}\n" );
        return Concatenation( "\\begin{center}\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{$", latex_string, "$}\\end{center}\n" );
        
    elif CapJitIsCallToGlobalFunction( return_value, "PreComposeList" ) and ValueOption( "raw" ) <> true then
        
        #Error( "only functions returning the result of a call to IsCongruentForMorphisms can be displayed as math" );
        
        left_list := CapJitIterateOverTree( return_value.args.3, ReturnFirst, result_func, additional_arguments_func, [ func_tree ] );
        
        Assert( 0, left_list.type = "list" );
        
        left_list.type := "SYNTAX_TREE_LIST";
        
        left_list := AsListMut( left_list );
        
        latex_string := "";
        
        max_length := Maximum( List( left_list, mor -> Maximum( WidthUTF8String( mor.source ), WidthUTF8String( mor.range ) ) ) );
        
        #if IsEven( max_length ) then
        #    max_length := max_length + 1;
        #fi;
        
        for i in [ 1 .. Length( left_list ) ] do
            
            mor := left_list[i];
            
            #DisplayCentered( mor.source, max_length, "" );
            #DisplayCentered( "│", max_length, TextAttr.7 );
            #PrintCentered( "│", max_length, TextAttr.7 );
            #Print( " ", TextAttr.bold, " ", mor.string, " ", TextAttr.reset, "\n" );
            #DisplayCentered( "∨", max_length, TextAttr.7 );
            
            latex_string := Concatenation( latex_string, mor.source ); 
            latex_string := Concatenation( latex_string, "\\arrow[dd, \"" ); 
            latex_string := Concatenation( latex_string, mor.string ); 
            latex_string := Concatenation( latex_string, "\"] \\\\\n\\\\\n" ); 
            
            if i < Length( left_list ) and mor.range <> left_list[i + 1].source then
                
                #DisplayCentered( mor.range, max_length, "" );
                #DisplayCentered( "∥", max_length, TextAttr.7 );
                
                latex_string := Concatenation( latex_string, mor.range ); 
                latex_string := Concatenation( latex_string, "\\arrow[d, Rightarrow, no head] \\\\\n" ); 
                
            fi;
            
        od;
        
        #DisplayCentered( Last( left_list ).range, max_length, "" );
        latex_string := Concatenation( latex_string, Last( left_list ).range, "\n" ); 
        
        if ValueOption( "raw" ) = true then
            
            Error( "raw not supported" );
            
        fi;
        
        #Display( "∼" );
        
        #LoadPackage( "ToolsForHigher" );
        
        latex_string := ReplacedString( latex_string, "⁻¹", """^{-1}""" );
        latex_string := ReplacedString( latex_string, "ᵛ", """^{\vee}""" );
        latex_string := ReplacedString( latex_string, "⊗", """\otimes""" );
        latex_string := ReplacedString( latex_string, "id", """\mathrm{id}""" );
        latex_string := ReplacedString( latex_string, "ev", """\mathrm{ev}""" );
        latex_string := ReplacedString( latex_string, "coev", """\mathrm{coev}""" );
        latex_string := ReplacedString( latex_string, "hom", """\mathrm{hom}""" );
        latex_string := ReplacedString( latex_string, "", """\mathrm{ev}""" );
        latex_string := ReplacedString( latex_string, "", """\mathrm{coev}""" );
        latex_string := ReplacedString( latex_string, "α", """\alpha""" );
        latex_string := ReplacedString( latex_string, "β", """\beta""" );
        latex_string := ReplacedString( latex_string, "γ", """\gamma""" );
        latex_string := ReplacedString( latex_string, "λ", """\lambda""" );
        latex_string := ReplacedString( latex_string, "ρ", """\rho""" );
        latex_string := ReplacedString( latex_string, "IsWellDefined", """\mathrm{IsWellDefined}""" );
        latex_string := ReplacedString( latex_string, "IsZero", """\mathrm{IsZero}""" );
        
        #Error("here");
        
        #return Concatenation( "\\[\n    ", latex_string, "\n\\]\n" );
    
        latex_string := Concatenation( "\\begin{tikzcd}\n", latex_string, "\\end{tikzcd}\n" );
        #return Concatenation( "\\begin{center}\\framebox[\\textwidth]{\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{$", latex_string, "$}}\\end{center}\n" );
        return Concatenation( "\\begin{center}\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{$", latex_string, "$}\\end{center}\n" );
        
    else
        
        #Error("TODO");
        
        latex_string := CapJitIterateOverTree( return_value, ReturnFirst, result_func, additional_arguments_func, [ func_tree ] );
        
        if latex_string.type in [ "object", "bool" ] then
            
            latex_string := latex_string.string;
            
        elif latex_string.type = "morphism" then
            
            if CapJitIsCallToGlobalFunction( return_value, gvar -> gvar in [ "PreCompose", "PreComposeList" ] ) then
                
                # PreCompose already encodes source and range
                latex_string := latex_string.string;
                
            else
                
                latex_string := Concatenation( latex_string.source, "\\xrightarrow{", latex_string.string, "}", latex_string.range );
                
            fi;
            
        else
            
            Error( "type ", latex_string.type, " not yet supported" );
            
        fi;
        
        if ValueOption( "raw" ) = true then
            
            return latex_string;
            
        fi;
        
        latex_string := ReplacedString( latex_string, "⁻¹", """^{-1}""" );
        latex_string := ReplacedString( latex_string, "ᵛ", """^{\vee}""" );
        latex_string := ReplacedString( latex_string, "⊗", """\otimes""" );
        latex_string := ReplacedString( latex_string, "id", """\mathrm{id}""" );
        latex_string := ReplacedString( latex_string, "ev", """\mathrm{ev}""" );
        latex_string := ReplacedString( latex_string, "coev", """\mathrm{coev}""" );
        latex_string := ReplacedString( latex_string, "hom", """\mathrm{hom}""" );
        latex_string := ReplacedString( latex_string, "", """\mathrm{ev}""" );
        latex_string := ReplacedString( latex_string, "", """\mathrm{coev}""" );
        latex_string := ReplacedString( latex_string, "α", """\alpha""" );
        latex_string := ReplacedString( latex_string, "β", """\beta""" );
        latex_string := ReplacedString( latex_string, "γ", """\gamma""" );
        latex_string := ReplacedString( latex_string, "λ", """\lambda""" );
        latex_string := ReplacedString( latex_string, "ρ", """\rho""" );
        latex_string := ReplacedString( latex_string, "IsWellDefined", """\mathrm{IsWellDefined}""" );
        latex_string := ReplacedString( latex_string, "IsZero", """\mathrm{IsZero}""" );
        
        #latex_string := Concatenation( "\\framebox[\\textwidth]{\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{$", latex_string, suffix, "$}}\n" );
        latex_string := Concatenation( "\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{$", latex_string, suffix, "$}\n" );
        
        return Concatenation( "\\[", latex_string, "\\]\n" );
        
        #return latex_string;
        
    fi;
    
end;

BindGlobal( "CapJitCompiledFunctionAsMathString", function ( func, cat, input_filters, return_type )
  local compiled_func;
    
    compiled_func := CapJitCompiledFunction( func, cat, input_filters, return_type );
    
    return FunctionAsMathString( compiled_func, cat, input_filters );
    
end );

BindGlobal( "CapJitCompiledFunctionAsMathStringAssert", function ( func, cat, input_filters )
  local tree, string;
    
    tree := CapJitCompiledFunctionAsEnhancedSyntaxTree( func, "with_post_processing", cat, input_filters, "bool" );
    
    if tree.bindings.names = [ "RETURN_VALUE" ] and tree.bindings.BINDING_RETURN_VALUE.type = "EXPR_TRUE" then
        
        return "\\qedhere";
        
    else
        
        Display( ENHANCED_SYNTAX_TREE_CODE( tree ) );
        
        Error( "function is not true" );
        
        return FunctionAsMathString( ENHANCED_SYNTAX_TREE_CODE( tree ), cat, input_filters );
        
    fi;
    
end );
