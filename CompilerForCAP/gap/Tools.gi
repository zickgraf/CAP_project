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

WriteResultToTeXFile := function ( filename, label, result )
  local path, content;
    
    path := Concatenation( filename, ".gap_autogen.tex" );
    
    result := Concatenation(
        "\\begin{autogen-with-ref}{", label, "}\n",
        #"\\label{src:", label, "}\n",
        result,
        "\n\\end{autogen-with-ref}\n"
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

TestAndReturnCode := function ( code )
  local lines;
    
    Assert( 0, Test( InputTextString( code ) ) );
    
    lines := SplitString( code, "\n" );
    
    if lines[1] = "" then
        
        Remove( lines, 1 );
        
    fi;
    
    lines := List( lines, function ( line )
        
        if StartsWith( line, "gap>" ) then
            
            return Concatenation( "(*@\\textcolor{promptColor}{gap>}\\aftergroup\\startGAPInput@*)", line{[ 5 .. Length( line )]}, "(*@\\aftergroup\\endGAPInput@*)" );
            
        elif StartsWith( line, ">" ) then
            
            return Concatenation( "(*@\\textcolor{promptColor}{>}\\aftergroup\\startGAPInput@*)", line{[ 2 .. Length( line )]}, "(*@\\aftergroup\\endGAPInput@*)" );
            
        else
            
            return line;
            
        fi;
        
    end );
    
    return Concatenation( "\\begin{lstlisting}\n", JoinStringsWithSeparator( lines, "\n" ), "\n\\end{lstlisting}" );
    
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


BINDING_STRENGTHS := [
    [ "IsWellDefinedForObjects", "IsWellDefinedForMorphisms", "IsZeroForMorphisms", "IsZero", "IsInt", "IsHomalgMatrix", "IsCapCategoryMorphism", "IsList" ],
    [ "AdditionForMorphisms", "AdditiveInverseForMorphisms", "+", "-" ],
    [ "TensorProductOnMorphisms", "TensorProductOnMorphismsWithGivenTensorProducts", "TensorProductOnObjects", "PreCompose", "PreComposeList", "*" ],
    [ "SumOfMorphisms" ],
    [ "DualOnObjects", "DualOnMorphisms", "[]", "List" ],
];

get_strength := function ( tree )
  local pos;
    
    # things that never have to be parenthesized
    if tree.type = "EXPR_REF_FVAR" then
        
        return Length( BINDING_STRENGTHS ) + 1;
        
    elif CapJitIsCallToGlobalFunction( tree, ReturnTrue ) then
        
        pos := PositionProperty( BINDING_STRENGTHS, l -> tree.funcref.gvar in l );
        
        if pos <> fail then
            
            return pos;
            
        else
            
            # the function is not an infix and thus does not have to be parenthesized
            return Length( BINDING_STRENGTHS ) + 1;
            
        fi;
        
    fi;
    
    # things that always have to be parenthesized
    return 0;
    
end;

parenthesize_infix := function ( tree, symbol, left_tree, left_result, right_tree, right_result )
  local parent_strength, left_strength, right_strength, left_string, right_string;
    
    parent_strength := get_strength( tree );
    
    if parent_strength = 0 or parent_strength = Length( BINDING_STRENGTHS ) + 1 then
        
        Error( "parenthesize_* must only be called for operations which have a binding strength" );
        
    fi;
    
    left_strength := get_strength( left_tree );
    right_strength := get_strength( right_tree );
    
    left_string := left_result.string;
    
    if left_strength = 0 or left_strength <= parent_strength then
        
        left_string := Concatenation( "\\left(", left_string, "\\right)" );
        
    fi;
    
    right_string := right_result.string;
    
    if right_strength = 0 or right_strength <= parent_strength then
        
        right_string := Concatenation( "\\left(", right_string, "\\right)" );
        
    fi;
    
    return Concatenation( left_string, " ", symbol, " ", right_string );
    
end;

parenthesize_prefix := function ( tree, symbol, child_tree, child_result )
  local parent_strength, child_strength, child_string;
    
    parent_strength := get_strength( tree );
    
    if parent_strength = 0 or parent_strength = Length( BINDING_STRENGTHS ) + 1 then
        
        Error( "parenthesize_* must only be called for operations which have a binding strength" );
        
    fi;
    
    child_strength := get_strength( child_tree );
    
    child_string := child_result.string;
    
    if child_strength = 0 or child_strength <= parent_strength then
        
        child_string := Concatenation( "\\left(", child_string, "\\right)" );
        
    fi;
    
    return Concatenation( symbol, child_string );
    
end;

parenthesize_postfix := function ( tree, symbol, child_tree, child_result )
  local parent_strength, child_strength, child_string;
    
    parent_strength := get_strength( tree );
    
    if parent_strength = 0 or parent_strength = Length( BINDING_STRENGTHS ) + 1 then
        
        Error( "parenthesize_* must only be called for operations which have a binding strength" );
        
    fi;
    
    child_strength := get_strength( child_tree );
    
    child_string := child_result.string;
    
    if child_string = 0 or child_string <= parent_strength then
        
        child_string := Concatenation( "\\left(", child_string, "\\right)" );
        
    fi;
    
    return Concatenation( child_string, symbol );
    
end;

BindGlobal( "LaTeXName", function ( name )
  local latex_commands, pos, underscore, command;
    
    latex_commands := rec(
        alpha := "\\alpha",
        beta := "\\beta",
        gamma := "\\gamma",
        delta := "\\delta",
        epsilon := "\\varepsilon",
        zeta := "\\zeta",
        eta := "\\eta",
        theta := "\\theta",
        iota := "\\iota",
        kappa := "\\kappa",
        lambda := "\\lambda",
        mu := "\\mu",
        nu := "\\nu",
        xi := "\\xi",
        # omikron
        pi := "\\pi",
        rho := "\\rho",
        sigma := "\\sigma",
        tau := "\\tau",
        # ypsilon
        phi := "\\varphi",
        chi := "\\chi",
        psi := "\\psi",
        omega := "\\omega",
        QQ := "\\QQ",
    );
    
    # replace names of greek letters by unicode characters
    for command in RecNames( latex_commands ) do
        
        if StartsWith( name, command ) then
            
            name := Concatenation( latex_commands.(command), name{[ Length( command ) + 1 .. Length( name ) ]} );
            break;
            
        fi;
        
    od;
    
    # turn trailing numbers into indices
    pos := Length( name ) - SafePositionProperty( Reversed( name ), c -> not IsDigitChar( c ) ) + 1;
    
    if pos < Length( name ) then
        
        if name[pos] = '_' then
            
            underscore := "";
            
        else
            
            underscore := "_";
            
        fi;
        
        name := Concatenation( name{[ 1 .. pos ]}, underscore, "{", name{[ pos + 1 .. Length( name ) ]}, "}" );
        
    fi;
    
    if '_' in name then
        
        # escape for double subscript
        # TODO: parentheses
        name := Concatenation( "{", name, "}" );
        
    fi;
    
    return name;
            
end );

MySplitString := function ( string, substring )
  local pos;
    
    pos := PositionSublist( string, substring );
    
    if pos = fail then
        
        return [ string ];
        
    else
        
        return Concatenation( [ string{[ 1 .. pos - 1 ]} ], MySplitString( string{[ pos + 2 .. Length( string ) ]}, substring ) );
        
    fi;
    
end;

FunctionAsMathString := function ( func, cat, input_filters, args... )
  local suffix, arguments_data_types, type_signature, func_tree, old_stop_compilation, old_range_stop_compilation, return_value, result_func, additional_arguments_func, left_list, right, latex_string, max_length, mor, i, collect, conditions, latex_strings, latex_record_left_morphism, latex_record_right, latex_string_left;
    
    if IsEmpty( args ) then
        
        suffix := "";
        
    elif Length( args ) = 1 then
        
        suffix := args[1];
        
    else
        
        Error( "FunctionAsMathString must be called with at most three arguments" );
        
    fi;
    
    if not IsList( input_filters ) or (IsFunction( func ) and Length( input_filters ) <> NumberArgumentsFunction( func )) then
        
        Error( "<input_filters> must be a list of length `NumberArgumentsFunction( <func> )`" );
        
    fi;
    
    arguments_data_types := List( input_filters, function ( x ) if IsFilter( x ) then return rec( filter := x ); else return CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( x, cat ); fi; end );
    
    Assert( 0, not fail in arguments_data_types );
    
    type_signature := Pair( arguments_data_types, fail );
    
    Add( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK, func );
    
    if IsRecord( func ) then
        
        func_tree := func;
        
    else
        
        func_tree := ENHANCED_SYNTAX_TREE( func );
        func_tree.data_type := rec( filter := IsFunction, signature := type_signature );
        
    fi;
    
    func_tree := CapJitInferredDataTypes( func_tree );
    
    if not IsBound( func_tree.bindings.BINDING_RETURN_VALUE.data_type ) then
        
        Display( type_signature );
        Display( func );
        
        Error( "func could not be typed" );
        
    fi;
    
    # TODO
    if IsBound( cat!.stop_compilation ) then
        old_stop_compilation := cat!.stop_compilation;
    else
        old_stop_compilation := false;
    fi;
    cat!.stop_compilation := true;
    
    if HasRangeCategoryOfHomomorphismStructure( cat ) and not IsIdenticalObj( RangeCategoryOfHomomorphismStructure( cat ), cat ) then
        
        if IsBound( RangeCategoryOfHomomorphismStructure( cat )!.stop_compilation ) then
            old_range_stop_compilation := RangeCategoryOfHomomorphismStructure( cat )!.stop_compilation;
        else
            old_range_stop_compilation := false;
        fi;
        
        RangeCategoryOfHomomorphismStructure( cat )!.stop_compilation := true;
        
    fi;
    
    # why is this needed?
    func_tree := CapJitResolvedOperations( func_tree );
    func_tree := CapJitResolvedGlobalVariables( func_tree );
    
    Remove( CAP_JIT_INTERNAL_COMPILED_FUNCTIONS_STACK );
    
    #Display( ENHANCED_SYNTAX_TREE_CODE( func_tree ) );
    
    cat!.stop_compilation := old_stop_compilation;
    if HasRangeCategoryOfHomomorphismStructure( cat ) and not IsIdenticalObj( RangeCategoryOfHomomorphismStructure( cat ), cat ) then
        RangeCategoryOfHomomorphismStructure( cat )!.stop_compilation := old_range_stop_compilation;
    fi;
    
    func_tree := CapJitReplacedGlobalVariablesByCategoryAttributes( func_tree, cat );
    func_tree := CapJitInlinedBindingsFully( func_tree );
    
    if Length( func_tree.bindings.names ) > 1 then
        
        Display( func );
        Error( "only functions without proper bindings can be displayed as math" );
        
    fi;
    
    return_value := func_tree.bindings.BINDING_RETURN_VALUE;
    
    result_func := function ( tree, result, keys, func_stack )
      local func, pos, type, name, parts, source, range, string, info, local_cat, object_func_tree, object_func, source_string, range_string, math_record, list, mor, i, specifier;
        
        if tree.type = "EXPR_DECLARATIVE_FUNC" then
            
            # TODO
            return result.bindings;
            
        elif tree.type = "SYNTAX_TREE_LIST" then
            
            return result;
            
        elif tree.type = "CASE_BRANCH" then
            
            return result;
            
        elif tree.type = "FVAR_BINDING_SEQ" then
            
            if tree.names <> [ "RETURN_VALUE" ] then
                
                Error( "only functions without proper bindings can be displayed as math" );
                
            fi;
            
            return result.BINDING_RETURN_VALUE;
            
        elif tree.type = "EXPR_TRUE" then
            
            return rec(
                type := "plain",
                string := "\\qed",
            );
            
        # TODO: this should be a function!!!
        elif tree.type = "EXPR_EQ" then
            
            return rec(
                type := "plain",
                string := Concatenation( result.left.string, " = ", result.right.string ),
            );
            
        elif tree.type = "EXPR_GE" then
            
            return rec(
                type := "plain",
                string := Concatenation( result.left.string, " \\geq ", result.right.string ),
            );
            
        elif tree.type = "EXPR_AND" then
            
            return rec(
                type := "plain",
                string := Concatenation( result.left.string, " \\quad \\text{and} \\quad ", result.right.string ),
            );
            
        elif tree.type = "EXPR_OR" then
            
            return rec(
                type := "plain",
                string := Concatenation( result.left.string, " \\quad \\text{or} \\quad ", result.right.string ),
            );
            
        elif tree.type = "EXPR_INT" then
            
            return rec(
                type := "plain",
                string := String( tree.value ),
            );
            
        elif tree.type = "EXPR_FALSE" then
            
            return rec(
                type := "plain",
                string := "\\bottom",
            );
            
        elif tree.type = "EXPR_NOT" then
            
            return rec(
                type := "plain",
                string := Concatenation( "not(", result.op.string, ")" ),
            );
            
        elif tree.type = "EXPR_LIST" then
            
            result.list.type := "SYNTAX_TREE_LIST";
            result.list.length := tree.list.length;
            result.list.string := Concatenation( "(", JoinStringsWithSeparator( AsListMut( result.list ), ", " ), ")" );
            result.list.type := "list";
            return result.list;
            
        elif tree.type = "EXPR_IN" then
            
            return rec(
                type := "plain",
                string := Concatenation( result.left.string, " \\in ", result.right.string ),
            );
            
        elif tree.type = "EXPR_REF_GVAR" then
            
            return rec(
                type := "plain",
                string := LaTeXName( tree.gvar ),
            );
            
        elif tree.type = "EXPR_RANGE" then
            
            return rec(
                type := "plain",
                string := Concatenation( "\\{", result.first.string, ", \\ldots, ", result.last.string, "\\}" ),
            );
            
        elif tree.type = "EXPR_FUNCCALL" and tree.funcref.type = "EXPR_DECLARATIVE_FUNC" then # call to global functions are handled below
            
            if tree.args.length <> 1 then
                
                Error("not yet handled");
                
            fi;
            
            return rec(
                type := "plain",
                string := Concatenation( result.funcref.string, "[", tree.funcref.nams[1], " \\from ", result.args.1.string, "]" ),
            );
            
        elif tree.type = "EXPR_CASE" then
            
            # TODO: source and range for morphisms
            
            if tree.branches.length < 2 then
                
                Error( "degenerate case not handled" );
                
            fi;
            
            math_record := rec(
                type := "plain",
                string := Concatenation( """\left\{{\def\arraystretch{1.2}\begin{array}{@{}l@{\quad}l@{}}""", "\n" ),
            );
            
            for i in [ 1 .. tree.branches.length - 1 ] do
                
                math_record.string := Concatenation( math_record.string, result.branches.(i).value.string, """ & \text{if } """, result.branches.(i).condition.string, """\text{,}\\""", "\n" );
                
            od;
            
            Assert( 0, Last( tree.branches ).condition.type = "EXPR_TRUE" );
            
            math_record.string := Concatenation( math_record.string, result.branches.(tree.branches.length).value.string, """ & \text{else.}""", "\n", """\end{array}}\right\}""" );
            
            if IsSpecializationOfFilter( "morphism", tree.data_type.filter ) then
                
                math_record.type := "morphism";
                math_record.source := "EXPR_CASE_TODO";
                math_record.range := "EXPR_CASE_TODO";
                
            fi;
            
            return math_record;
            
        elif tree.type = "EXPR_REF_FVAR" then
            
            # TODO: make variable names unique
            
            func := SafeUniqueEntry( func_stack, f -> f.id = tree.func_id );
            
            pos := SafeUniquePosition( func.nams, tree.name );
            
            # we currently only handle functions without proper bindings
            Assert( 0, pos <= func.narg );
            
            if tree.func_id = func_tree.id then
                
                type := input_filters[pos];
                
            elif IsBound( func.data_type ) then
                
                type := func.data_type.signature[1][pos];
                
                if IsSpecializationOfFilter( "category", type.filter ) then
                    
                    type := "category";
                    
                elif IsSpecializationOfFilter( "object", type.filter ) then
                    
                    type := "object";
                    
                elif IsSpecializationOfFilter( "morphism", type.filter ) then
                    
                    type := "morphism";
                    
                elif IsSpecializationOfFilter( "integer", type.filter ) then
                    
                    type := "integer";
                    
                elif IsSpecializationOfFilter( IsList, type.filter ) and IsSpecializationOfFilter( "morphism", type.element_type.filter ) then
                    
                    type := "list_of_morphisms";
                    
                else
                    
                    Error( "unknown type" );
                    
                fi;
                
            else
                
                Error( "cannot determine type" );
                
            fi;
            
            name := tree.name;
            
            if CAP_JIT_PROOF_ASSISTANT_MODE_ACTIVE_PROPOSITION <> fail then
                
                name := CAP_JIT_PROOF_ASSISTANT_MODE_ACTIVE_PROPOSITION.variable_name_translator( name );
                
            fi;
            
            if IsFilter( type ) then
                
                return rec(
                    type := "plain",
                    string := LaTeXName( name ),
                );
                
            elif type = "integer" then
                
                return rec(
                    type := "plain",
                    string := LaTeXName( name ),
                );
                
            elif type = "bool" then
                
                return rec(
                    type := "plain",
                    string := LaTeXName( name ),
                );
                
            elif type = "category" then
                
                return rec(
                    type := "plain",
                    string := LaTeXName( name ),
                );
                
            elif type = "object" then
                
                name := Concatenation( "\\myboxed{", LaTeXName( name ), "}" );
                
                return rec(
                    type := "plain",
                    string := name,
                );
                
            elif type = "morphism" then
                
                parts := MySplitString( name, "__" );
                
                if Length( parts ) = 3 then
                    
                    name := Concatenation( "\\myboxed{", LaTeXName( parts[1] ), "}" );
                    source := Concatenation( "\\myboxed{", LaTeXName( parts[2] ), "}" );
                    range := Concatenation( "\\myboxed{", LaTeXName( parts[3] ), "}" );
                     
                else
                    
                    name := LaTeXName( name );
                    
                    name := Concatenation( "\\myboxed{", name, "}" );
                    source := Concatenation( "s\\left(", name, "\\right)" );
                    range := Concatenation( "t\\left(", name, "\\right)" );
                    
                fi;
                
                return rec(
                    type := "morphism",
                    source := source,
                    range := range,
                    string := name,
                );
                
            elif type = "morphism_in_range_category_of_homomorphism_structure" then
                
                return rec(
                    type := "morphism",
                    source := Concatenation( "s\\left(", name, "\\right)" ),
                    range := Concatenation( "t\\left(", name, "\\right)" ),
                    string := name,
                );
                
            elif type = "list_of_objects" then
                
                return rec(
                    type := "plain",
                    string := LaTeXName( name ),
                );
                
            elif type = "list_of_morphisms" then
                
                return rec(
                    type := "plain",
                    string := LaTeXName( name ),
                );
                
            else
                
                Error( "unkown type ", type );
                
            fi;
            
        elif CapJitIsCallToGlobalFunction( tree, ReturnTrue ) then
            
            math_record := fail;
            
            if tree.funcref.gvar = "[]" then
                
                if result.args.1.string = "tau" then
                    
                    Error("asd");
                    
                fi;
                
                return rec(
                    type := "plain",
                    #string := Concatenation( "{", result.args.1.string, "}_{", result.args.2.string, "}" ),
                    string := parenthesize_infix( tree, "_", tree.args.1, result.args.1, tree.args.2, result.args.2 ),
                );
                
            elif tree.funcref.gvar = "List" then
                
                if tree.args.2.type = "EXPR_DECLARATIVE_FUNC" then
                    
                    return rec(
                        type := "plain",
                        string := Concatenation( "\\left(", result.args.2.string, "\\right)_{", tree.args.2.nams[1], "}" ),
                    );
                    
                elif tree.args.2.type = "EXPR_REF_GVAR" then
                    
                    return rec(
                        type := "plain",
                        string := Concatenation( "\\left(", tree.args.2.gvar, "(x)\\right)_x" ),
                    );
                    
                else
                    
                    Error( "not implemented" );
                    
                fi;
                
            elif tree.funcref.gvar = "ForAll" then
                
                if tree.args.2.type <> "EXPR_DECLARATIVE_FUNC" then
                    
                    Error( "not implemented" );
                    
                fi;
                
                Assert( 0, tree.args.2.narg = 1 );
                
                return rec(
                    type := "plain",
                    string := Concatenation( "\\forall ", tree.args.2.nams[1], " \\colon ", result.args.2.string ),
                );
                
                #return rec(
                #    type := "plain",
                #    string := Concatenation( "\\forall ", tree.args.2.nams[1], " \\in ", result.args.1.string, " \\colon ", result.args.2.string ),
                #);
                
            elif tree.funcref.gvar = "KroneckerDelta" and result.args.3.type = "morphism" then
                
                Assert( 0, result.args.3.type = result.args.4.type );
                # source and range are complicated
                #Assert( 0, result.args.3.source = result.args.4.source );
                #Assert( 0, result.args.3.range = result.args.4.range );
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( """\left\{{\def\arraystretch{1.2}\begin{array}{@{}l@{\quad}l@{}}""", "\n", result.args.3.string, """ & \text{if } """, result.args.1.string, " = ", result.args.2.string, """\text{,}\\""", "\n", result.args.4.string, """ & \text{else.}""", "\n", """\end{array}}\right\}""" ),
                    #source := result.args.3.source,
                    #range := result.args.3.range,
                );
                
            elif tree.funcref.gvar = "IS_IDENTICAL_OBJ" then
                
                return rec(
                    type := "plain",
                    string := Concatenation( result.args.1.string, " \\quad = \\quad ", result.args.2.string ),
                );
                
            elif tree.funcref.gvar = "CreateCapCategoryObjectWithAttributes" then
                
                if tree.args.length <> 3 then
                    
                    Error( "Cannot handle CreateCapCategoryObjectWithAttributes with less or more than three arguments yet." );
                    
                fi;
                
                return rec(
                    type := "plain",
                    string := Concatenation( "\\myboxed{", result.args.3.string, "}" ),
                );
                
            elif tree.funcref.gvar = "AsCapCategoryObject" then
                
                if tree.args.length <> 2 then
                    
                    Error( "Cannot handle AsCapCategoryObject with less or more than three arguments yet." );
                    
                fi;
                
                return rec(
                    type := "plain",
                    string := Concatenation( "\\myboxed{", result.args.2.string, "}" ),
                );
                
            elif tree.funcref.gvar = "CreateCapCategoryMorphismWithAttributes" then
                
                if tree.args.length <> 5 then
                    
                    Error( "Cannot handle CreateCapCategoryMorphismWithAttributes with less or more than five arguments yet." );
                    
                fi;
                
                return rec(
                    type := "morphism",
                    string := Concatenation( "\\myboxed{", result.args.5.string, "}" ),
                    source := result.args.2.string,
                    range := result.args.3.string,
                );
                
            elif tree.funcref.gvar = "AsCapCategoryMorphism" then
                
                if tree.args.length <> 4 then
                    
                    Error( "Cannot handle AsCapCategoryMorphism with less or more than five arguments yet." );
                    
                fi;
                
                return rec(
                    type := "morphism",
                    string := Concatenation( "\\myboxed{", result.args.4.string, "}" ),
                    source := result.args.2.string,
                    range := result.args.3.string,
                );
                
            elif tree.funcref.gvar = "-" then
                
                return rec(
                    type := "plain",
                    string := parenthesize_infix( tree, "-", tree.args.1, result.args.1, tree.args.2, result.args.2 ),
                );
                
            elif tree.funcref.gvar = "*" then
                
                return rec(
                    type := "plain",
                    string := parenthesize_infix( tree, "\\cdot", tree.args.1, result.args.1, tree.args.2, result.args.2 ),
                );
                
            elif tree.funcref.gvar = "NumberRows" and tree.args.length = 1 then
                
                return rec(
                    type := "plain",
                    string := Concatenation( "\\mathrm{NrRows}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "NumberColumns" and tree.args.length = 1 then
                
                return rec(
                    type := "plain",
                    string := Concatenation( "\\mathrm{NrCols}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "RowRankOfMatrix" and tree.args.length = 1 then
                
                return rec(
                    type := "plain",
                    string := Concatenation( "\\mathrm{RowRank}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "ColumnRankOfMatrix" and tree.args.length = 1 then
                
                return rec(
                    type := "plain",
                    string := Concatenation( "\\mathrm{ColumnRank}(", result.args.1.string, ")" ),
                );
                
            elif tree.funcref.gvar = "PreComposeList" then
                
                if tree.args.3.type = "EXPR_LIST" and ForAll( tree.args.3.list, x -> x.type = "EXPR_REF_FVAR" ) then
                    
                    list := result.args.3;
                    
                    if list.type <> "list" then
                        
                        Error( "this case is not handled yet" );
                        
                    fi;
                    
                    math_record := rec(
                        type := "morphism",
                        string := JoinStringsWithSeparator( List( [ 1 .. list.length ], i -> list.(i).string ), " \\cdot " ),
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
                    type := "plain",
                    string := Concatenation( result.args.1.string, " \\quad = \\quad ", result.args.2.string ),
                );
                
            elif tree.funcref.gvar = "AsValue" and IsSpecializationOfFilter( "object", tree.args.1.data_type.filter ) then
                
                # TODO
                
                if Length( result.args.1.string ) >= 9 and result.args.1.string{[1 .. 9]} = "\\myboxed{" and Last( result.args.1.string ) = '}' then
                    
                    math_record := rec(
                        type := "plain",
                        string := result.args.1.string{[ 10 .. Length( result.args.1.string ) - 1 ]},
                    );
                    
                else
                    
                    math_record := rec(
                        type := "plain",
                        string := Concatenation( "\\mathrm{AsValue}(", result.args.1.string, ")" ),
                    );
                    
                fi;
                
            elif tree.funcref.gvar = "AsValue" and IsSpecializationOfFilter( "morphism", tree.args.1.data_type.filter ) then
                
                # TODO
                
                if Length( result.args.1.string ) >= 9 and result.args.1.string{[1 .. 9]} = "\\myboxed{" and Last( result.args.1.string ) = '}' then
                    
                    math_record := rec(
                        type := "plain",
                        string := result.args.1.string{[ 10 .. Length( result.args.1.string ) - 1 ]},
                    );
                    
                else
                    
                    math_record := rec(
                        type := "plain",
                        string := Concatenation( "\\mathrm{AsValue}(", result.args.1.string, ")" ),
                    );
                    
                fi;
                
            elif tree.funcref.gvar = "ObjectList" and IsSpecializationOfFilter( "object", tree.args.1.data_type.filter ) then
                
                # TODO
                
                if Length( result.args.1.string ) >= 9 and result.args.1.string{[1 .. 9]} = "\\myboxed{" and Last( result.args.1.string ) = '}' then
                    
                    math_record := rec(
                        type := "plain",
                        string := result.args.1.string{[ 10 .. Length( result.args.1.string ) - 1 ]},
                    );
                    
                else
                    
                    math_record := rec(
                        type := "plain",
                        string := Concatenation( "\\mathrm{ObjectList}(", result.args.1.string, ")" ),
                    );
                    
                fi;
                
            elif tree.funcref.gvar = "MorphismMatrix" and IsSpecializationOfFilter( "morphism", tree.args.1.data_type.filter ) then
                
                # TODO
                
                if Length( result.args.1.string ) >= 9 and result.args.1.string{[1 .. 9]} = "\\myboxed{" and Last( result.args.1.string ) = '}' then
                    
                    math_record := rec(
                        type := "plain",
                        string := result.args.1.string{[ 10 .. Length( result.args.1.string ) - 1 ]},
                    );
                    
                else
                    
                    math_record := rec(
                        type := "plain",
                        string := Concatenation( "\\mathrm{MorphismMatrix}(", result.args.1.string, ")" ),
                    );
                    
                fi;
                
            elif tree.funcref.gvar = "SumOfMorphisms" then
                
                if CapJitIsCallToGlobalFunction( tree.args.3, "List" ) and tree.args.3.args.2.type = "EXPR_DECLARATIVE_FUNC" then
                    
                    Assert( 0, tree.args.3.args.2.narg = 1 );
                    
                    math_record := rec(
                        type := "morphism",
                        string := parenthesize_prefix( tree, Concatenation( "\\sum_{", tree.args.3.args.2.nams[1], "}" ), tree.args.3.args.2.bindings.BINDING_RETURN_VALUE, rec( string := result.args.3.string{[ 7 .. Length( result.args.3.string ) - Length( tree.args.3.args.2.nams[1] ) - 10 ]} ) ), # HACK
                    );
                    
                else
                    
                    math_record := rec(
                        type := "morphism",
                        string := Concatenation( "\\sum_x ", result.args.3.string, "_x" ),
                    );
                    
                fi;
                
            elif tree.funcref.gvar = "IdentityMorphism" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "\\mathrm{id}_{", result.args.2.string, "}" ),
                );
                
            elif tree.funcref.gvar = "ZeroMorphism" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "0_{", result.args.2.string, ", ", result.args.3.string, "}" ),
                );
                
            elif tree.funcref.gvar = "RangeCategoryOfHomomorphismStructure" then
                
                math_record := rec(
                    type := "plain",
                    string := "D",
                );
                
            elif tree.funcref.gvar = "TensorUnit" then
                
                math_record := rec(
                    type := "plain",
                    string := "1",
                );
                
            elif tree.funcref.gvar = "TensorProductOnObjects" then
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_infix( tree, "\\otimes", tree.args.2, result.args.2, tree.args.3, result.args.3 ),
                );
                
            elif tree.funcref.gvar = "TensorProductOnMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := parenthesize_infix( tree, "\\otimes", tree.args.2, result.args.2, tree.args.3, result.args.3 ),
                );
                
            elif tree.funcref.gvar = "LeftUnitor" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\lambda",
                );
                
            elif tree.funcref.gvar = "LeftUnitorInverse" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\lambda^{-1}",
                );
                
            elif tree.funcref.gvar = "RightUnitor" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\rho",
                );
                
            elif tree.funcref.gvar = "RightUnitorInverse" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\rho^{-1}",
                );
                
            elif tree.funcref.gvar = "AssociatorLeftToRight" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\alpha",
                );
                
            elif tree.funcref.gvar = "AssociatorRightToLeft" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\alpha^{-1}",
                );
                
            elif tree.funcref.gvar = "Braiding" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\gamma",
                );
                
            elif tree.funcref.gvar = "BraidingInverse" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\gamma^{-1}",
                );
                
            elif tree.funcref.gvar = "Source" then
                
                math_record := rec(
                    type := "plain",
                    string := result.args.1.source,
                );
                
            elif tree.funcref.gvar in [ "Range", "Target" ] then
                
                math_record := rec(
                    type := "plain",
                    string := result.args.1.range,
                );
                
            elif tree.funcref.gvar = "DualOnObjects" then
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_postfix( tree, "^{\\vee}", tree.args.2, result.args.2 ),
                );
                
            elif tree.funcref.gvar = "DualOnMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := parenthesize_postfix( tree, "^{\\vee}", tree.args.2, result.args.2 ),
                );
                
            elif tree.funcref.gvar = "EvaluationForDual" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\mathrm{ev}",
                );
                
            elif tree.funcref.gvar = "CoevaluationForDual" then
                
                math_record := rec(
                    type := "morphism",
                    string := "\\mathrm{coev}",
                );
                
            elif tree.funcref.gvar = "DistinguishedObjectOfHomomorphismStructure" then
                
                math_record := rec(
                    type := "plain",
                    string := "1",
                );
                
            elif tree.funcref.gvar = "InternalHomOnObjects" then
                
                math_record := rec(
                    type := "plain",
                    string := Concatenation( "\\mathrm{hom}(", result.args.2.string, ",", result.args.3.string, ")" ),
                );
                
            elif tree.funcref.gvar = "HomomorphismStructureOnObjects" then
                
                math_record := rec(
                    type := "plain",
                    string := Concatenation( "H(", result.args.2.string, ",", result.args.3.string, ")" ),
                );
                
            elif tree.funcref.gvar = "InternalHomOnMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "\\mathrm{hom}(", result.args.2.string, ",", result.args.3.string, ")" ),
                );
                
            elif tree.funcref.gvar = "HomomorphismStructureOnMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "H(", result.args.2.string, ",", result.args.3.string, ")" ),
                );
                
            elif tree.funcref.gvar = "BasisOfExternalHom" then
                
                math_record := rec(
                    type := "plain",
                    string := Concatenation( "\\mathcal{B}(\\operatorname{Hom}(", result.args.2.string, ",", result.args.3.string, "))" ),
                );
                
            elif tree.funcref.gvar = "PreCompose" then
                
                math_record := rec(
                    type := "morphism",
                    string := parenthesize_infix( tree, "\\cdot", tree.args.2, result.args.2, tree.args.3, result.args.3 ),
                );
                
            elif tree.funcref.gvar = "AdditionForMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := parenthesize_infix( tree, "+", tree.args.2, result.args.2, tree.args.3, result.args.3 ),
                );
                
            elif tree.funcref.gvar = "AdditiveInverseForMorphisms" then
                
                math_record := rec(
                    type := "morphism",
                    string := parenthesize_prefix( tree, "-", tree.args.2, result.args.2 ),
                );
                
            elif tree.funcref.gvar = "IsCongruentForMorphisms" then
                
                math_record := rec(
                    type := "plain",
                    string := Concatenation( result.args.2.string, " \\quad \\sim \\quad ", result.args.3.string ),
                );
                
            elif tree.funcref.gvar = "IsInt" then
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_postfix( tree, " \\text{ is an integer}", tree.args.1, result.args.1 ),
                );
                
            elif tree.funcref.gvar = "IsList" then
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_postfix( tree, " \\text{ is a tuple}", tree.args.1, result.args.1 ),
                );
                
            elif tree.funcref.gvar = "IsHomalgMatrix" then
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_postfix( tree, " \\text{ is a matrix}", tree.args.1, result.args.1 ),
                );
                
            elif tree.funcref.gvar = "IsCapCategoryMorphism" then
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_postfix( tree, " \\text{ is a technical morphism}", tree.args.1, result.args.1 ),
                );
                
            elif tree.funcref.gvar = "IsZero" and tree.args.length = 1 and IsSpecializationOfFilter( IsHomalgMatrix, tree.args.1.data_type.filter ) then
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_postfix( tree, " \\text{ is a zero matrix}", tree.args.1, result.args.1 ),
                );
                
            elif tree.funcref.gvar = "IsEqualForObjects" or tree.funcref.gvar = "IsEqualForMorphisms" then
                
                math_record := rec(
                    type := "plain",
                    string := Concatenation( result.args.2.string, " = ", result.args.3.string ),
                );
                
            elif tree.funcref.gvar = "IsWellDefinedForObjects" then
                
                cat := tree.args.1.data_type.category;
                
                Assert( 0, IsCapCategory( cat ) );
                
                pos := PositionProperty( CAP_JIT_PROOF_ASSISTANT_CURRENT_CATEGORY_SYMBOLS, s -> IsIdenticalObj( cat, s.category ) );
                
                if pos = fail then
                    
                    specifier := "";
                    
                else
                    
                    specifier := Concatenation( " in ", CAP_JIT_PROOF_ASSISTANT_CURRENT_CATEGORY_SYMBOLS[pos].symbol );
                    
                fi;
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_postfix( tree, Concatenation( " \\text{ defines an object", specifier, "}" ), tree.args.2, result.args.2 ),
                );
                
            elif tree.funcref.gvar = "IsWellDefinedForMorphisms" then
                
                cat := tree.args.1.data_type.category;
                
                Assert( 0, IsCapCategory( cat ) );
                
                pos := PositionProperty( CAP_JIT_PROOF_ASSISTANT_CURRENT_CATEGORY_SYMBOLS, s -> IsIdenticalObj( cat, s.category ) );
                
                if pos = fail then
                    
                    specifier := "";
                    
                else
                    
                    specifier := Concatenation( " in ", CAP_JIT_PROOF_ASSISTANT_CURRENT_CATEGORY_SYMBOLS[pos].symbol );
                    
                fi;
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_postfix( tree, Concatenation( " \\text{ defines a morphism", specifier, "}" ), tree.args.2, result.args.2 ),
                );
                
            elif tree.funcref.gvar = "IsZeroForMorphisms" then
                
                math_record := rec(
                    type := "plain",
                    string := parenthesize_postfix( tree, " \\text{ is a zero morphism}", tree.args.2, result.args.2 ),
                );
                
            elif tree.funcref.gvar = "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "\\nu_{", result.args.2.source, ", ", result.args.2.range, "}(", result.args.2.string, ")" ),
                );
                
            elif tree.funcref.gvar = "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" then
                
                math_record := rec(
                    type := "morphism",
                    string := Concatenation( "\\nu_{", result.args.2.string, ", ", result.args.3.string, "}^{-1}(", result.args.4.string, ")" ),
                );
                
            fi;
            
            #if math_record <> fail and math_record.type = "morphism" then
            #    
            #    Assert( 0, tree.funcref.gvar in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) );
            #    
            #fi;
            
            if tree.funcref.gvar in RecNames( CAP_INTERNAL_METHOD_NAME_RECORD ) then
                
                info := CAP_INTERNAL_METHOD_NAME_RECORD.(tree.funcref.gvar);
                
                if math_record = fail then
                    
                    math_record := rec(
                        string := Concatenation( "\\mathrm{", tree.funcref.gvar, "}(", JoinStringsWithSeparator( List( [ 2 .. tree.args.length ], i -> result.args.(i).string ), ", " ), ")" ),
                    );
                    
                    if info.return_type in [ "morphism", "morphism_in_range_category_of_homomorphism_structure" ] then
                        
                        math_record.type := "morphism";
                        
                    else
                        
                        math_record.type := "plain";
                        
                    fi;
                    
                fi;
                
                if false and info.return_type in [ "morphism", "morphism_in_range_category_of_homomorphism_structure" ] and tree.args.length = Length( info.filter_list ) then
                    
                    if not IsBound( info.output_source_getter ) or not IsBound( info.output_range_getter ) then
                        
                        Error( "cannot determine source and/or range of CAP operation ", tree.funcref.gvar );
                        
                    fi;
                    
                    if info.return_type = "morphism" then
                        
                        local_cat := cat;
                        
                    elif info.return_type = "morphism_in_range_category_of_homomorphism_structure" then
                        
                        # TODO?
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
                    
                    math_record.type := "morphism";
                    math_record.source := source_string;
                    math_record.range := range_string;
                    
                fi;
                
            fi;
            
            # generic fallback
            if math_record = fail and ForAll( [ 1 .. tree.args.length ], i -> result.args.(i).type = "plain" ) and not IsSpecializationOfFilter( "morphism", tree.data_type.filter ) then
                
                math_record := rec(
                    type := "plain",
                    string := Concatenation( "\\mathrm{", tree.funcref.gvar, "}(", JoinStringsWithSeparator( List( [ 1 .. tree.args.length ], i -> result.args.(i).string ), ", " ), ")" ),
                );
                
            fi;
            
            if math_record = fail then
                
                Error( tree.funcref.gvar, " is not yet handled" );
                
            fi;
            
            if math_record.type = "morphism" then
                
                if not IsBound( math_record.source ) then
                    
                    math_record.source := Concatenation( "s\\left(", math_record.string, "\\right)" );
                    
                fi;
                
                if not IsBound( math_record.range ) then
                    
                    math_record.range := Concatenation( "t\\left(", math_record.string, "\\right)" );
                    
                fi;
                
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
        
        #Assert( 0, left_list.type = "list" );
        
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
        
        Assert( 0, ForAll( left_list, l -> l.type = "morphism" ) );
        
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
        
        #Error("here");
        
        #return Concatenation( "\\[\n    ", latex_string, "\n\\]\n" );
    
        latex_string := Concatenation( "\\begin{tikzcd}\n", latex_string, "\\end{tikzcd}\n" );
        #return Concatenation( "\\begin{center}\\framebox[\\textwidth]{\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{$", latex_string, "$}}\\end{center}\n" );
        return Concatenation( "\\begin{center}\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{$", latex_string, "$}\\end{center}\n" );
        
    elif return_value.type = "EXPR_AND" then
        
        Assert( 0, IsSpecializationOfFilter( "bool", return_value.data_type.filter ) );
        
        collect := function ( tree )
            
            if tree.type = "EXPR_AND" then
                
                return Concatenation( collect( tree.left ), collect( tree.right ) );
                
            else
                
                return [ tree ];
                
            fi;
            
        end;
        
        conditions := collect( return_value );
        
        Assert( 0, ForAll( conditions, c -> IsSpecializationOfFilter( "bool", c.data_type.filter ) ) );
        
        latex_strings := List( conditions, c -> CapJitIterateOverTree( c, ReturnFirst, result_func, additional_arguments_func, [ func_tree ] ).string );
        
        #latex_string := Concatenation( "\\begin{equation*}\\begin{split}\n", JoinStringsWithSeparator( latex_strings, "&\\quad\\text{and}\\\\\n" ), "&", suffix, "\n\\end{split}\\end{equation*}\n" );
        latex_string := Concatenation( "% neutralize abovedisplayskip\n\\vskip-\\abovedisplayskip\n\\begin{equation*}\\begin{split}\n&", JoinStringsWithSeparator( latex_strings, "\\\\\n\\text{and}\\enspace&" ), suffix, "\n\\end{split}\\end{equation*}\n" );
        return latex_string;
        
    elif CapJitIsCallToGlobalFunction( return_value, "IsEqualForObjects" ) and CapJitIsCallToGlobalFunction( return_value.args.2, gvar -> gvar = "Source" or gvar = "Range" or gvar = "Target" ) then
        
        latex_record_left_morphism := CapJitIterateOverTree( return_value.args.2.args.1, ReturnFirst, result_func, additional_arguments_func, [ func_tree ] );
        latex_record_right := CapJitIterateOverTree( return_value.args.3, ReturnFirst, result_func, additional_arguments_func, [ func_tree ] );
        
        if return_value.args.2.funcref.gvar = "Source" then
            
            latex_string_left := Concatenation( "the source of $", latex_record_left_morphism.string, "$" );
            
        elif return_value.args.2.funcref.gvar in [ "Range", "Target" ] then
            
            latex_string_left := Concatenation( "the target of $", latex_record_left_morphism.string, "$" );
            
        else
            
            Error( "this should never happen" );
            
        fi;
        
        latex_string := Concatenation( "\\resizebox{\\ifdim\\width>\\hsize\\hsize\\else\\width\\fi}{!}{", latex_string_left, " is $", latex_record_right.string, "$", suffix, "}\n" );
        
        return Concatenation( "\\[", latex_string, "\\]\n" );
        
    else
        
        latex_string := CapJitIterateOverTree( return_value, ReturnFirst, result_func, additional_arguments_func, [ func_tree ] );
        
        if IsSpecializationOfFilter( "morphism", return_value.data_type.filter ) then
            
            if CapJitIsCallToGlobalFunction( return_value, gvar -> gvar in [ "PreCompose", "PreComposeList" ] ) then
                
                # PreCompose already encodes source and range
                latex_string := latex_string.string;
                
            else
                
                # TODO
                latex_string := latex_string.string;
                #latex_string := Concatenation( latex_string.source, "\\xrightarrow{", latex_string.string, "}", latex_string.range );
                
            fi;
            
            
        else
            
            latex_string := latex_string.string;
            
        fi;
        
        if ValueOption( "raw" ) = true then
            
            return latex_string;
            
        fi;
        
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
