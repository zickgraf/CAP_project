# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
BindGlobal( "CAP_INTERNAL_ADD_OBJECT_OR_FAIL",
  
  function( category, object_or_fail )
    
    if object_or_fail = fail then
        return;
    fi;
    
    AddObject( category, object_or_fail );
    
end );

BindGlobal( "CAP_INTERNAL_ADD_MORPHISM_OR_FAIL",
  
  function( category, morphism_or_fail )
    
    if morphism_or_fail = fail then
        return;
    fi;
    
    AddMorphism( category, morphism_or_fail );
    
end );

BindGlobal( "CAP_INTERNAL_DISPLAY_ERROR_FOR_FUNCTION_OF_CATEGORY",
  
  function( function_name, category, message )
    
    Error( Concatenation( "in function \033[1m", function_name,
        "\033[0m\n       of category \033[1m",
        Name( category ), ":\033[0m\n\033[1m       ", message, "\033[0m\n" ) );
    
end );

InstallGlobalFunction( CapInternalInstallAdd,
  
  function( record )
    local function_name, install_name, add_name, pre_function, pre_function_full,
          redirect_function, post_function, filter_list,
          add_function, replaced_filter_list,
          enhanced_filter_list, get_convenience_function;
    
    function_name := record.function_name;
    
    if not IsBound( record.installation_name ) then
        
        install_name := function_name;
        
    else
        
        install_name := record.installation_name;
        
    fi;
    
    add_name := Concatenation( "Add", function_name );
    
    if IsBound( record.pre_function ) then
        pre_function := record.pre_function;
    else
        pre_function := function( arg ) return [ true ]; end;
    fi;

    if IsBound( record.pre_function_full ) then
        pre_function_full := record.pre_function_full;
    else
        pre_function_full := function( arg ) return [ true ]; end;
    fi;
    
    if IsBound( record.redirect_function ) then
        redirect_function := record.redirect_function;
    else
        redirect_function := false;
    fi;
    
    if IsBound( record.post_function ) then
        post_function := record.post_function;
    else
        post_function := false;
    fi;
    
    filter_list := record.filter_list;
    
    if record.return_type = "object" then
        add_function := AddObject;
    elif record.return_type = "morphism" then
        add_function := AddMorphism;
    elif record.return_type = "twocell" then
        add_function := AddTwoCell;
    elif record.return_type = "object_or_fail" then
        add_function := CAP_INTERNAL_ADD_OBJECT_OR_FAIL;
    elif record.return_type = "morphism_or_fail" then
        add_function := CAP_INTERNAL_ADD_MORPHISM_OR_FAIL;
    else
        add_function := ReturnTrue;
    fi;
    
    # declare operation with category as first argument and install convenience method
    if record.install_convenience_without_category then
        
        replaced_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( filter_list );
        
        DeclareOperation( install_name, replaced_filter_list );
        
        if filter_list[2] in [ "object", "morphism", "twocell" ] or ( IsList( filter_list[2] ) and filter_list[2][1] in [ "object", "morphism", "twocell" ] ) then
            
            get_convenience_function := oper -> { arg } -> CallFuncList( oper, Concatenation( [ CapCategory( arg[1] ) ], arg ) );
            
        elif filter_list[2] = "list_of_objects" or filter_list[2] = "list_of_morphisms" then
            
            get_convenience_function := oper -> { arg } -> CallFuncList( oper, Concatenation( [ CapCategory( arg[1][1] ) ], arg ) );
            
        elif filter_list[3] in [ "object", "morphism", "twocell" ] then
            
            get_convenience_function := oper -> { arg } -> CallFuncList( oper, Concatenation( [ CapCategory( arg[2] ) ], arg ) );
            
        elif filter_list[4] = "list_of_objects" or filter_list[4] = "list_of_morphisms" then
            
            get_convenience_function := oper -> { arg } -> CallFuncList( oper, Concatenation( [ CapCategory( arg[3][1] ) ], arg ) );
            
        else
            
            Error( Concatenation( "please add a way to derive the category from the arguments of ", install_name ) );
            
        fi;
        
        InstallMethod( ValueGlobal( install_name ), replaced_filter_list{[ 2 .. Length( replaced_filter_list ) ]}, get_convenience_function( ValueGlobal( install_name ) ) );
        
    fi;
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsFunction ],
                   
      function( category, func )
        
        ValueGlobal( add_name )( category, func, -1 );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsFunction, IsInt ],
                   
      function( category, func, weight )
        
        ValueGlobal( add_name )( category, [ [ func, [ ] ] ], weight );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsList ],
                   
      function( category, func )
        
        ValueGlobal( add_name )( category, func, -1 );
        
    end );
    
    InstallMethod( ValueGlobal( add_name ),
                   [ IsCapCategory, IsList, IsInt ],
      
      function( category, method_list, weight )
        local install_func, replaced_filter_list, needs_wrapping, i, set_primitive, is_derivation, is_final_derivation, without_given_name, with_given_name,
              without_given_weight, with_given_weight, number_of_proposed_arguments, current_function_number,
              current_function_argument_number, current_additional_filter_list_length, filter, input_human_readable_identifier_getter, input_sanity_check_functions,
              output_human_readable_identifier_getter, output_sanity_check_function, cap_jit_compiled_function;
        
        if HasIsFinalized( category ) and IsFinalized( category ) then
            Error( "cannot add methods anymore, category is finalized" );
        fi;
        
        if Length( method_list ) = 0 then
            Error( "you must pass at least one function to the add method" );
        fi;
        
        ## If there already is a faster method, do nothing!
        if weight > CurrentOperationWeight( category!.derivations_weight_list, function_name ) then
            return;
        fi;
        
        set_primitive := ValueOption( "SetPrimitive" );
        if set_primitive <> false then
            set_primitive := true;
        fi;
        
        is_derivation := ValueOption( "IsDerivation" );
        if is_derivation <> true then
            is_derivation := false;
        fi;
        
        is_final_derivation := ValueOption( "IsFinalDerivation" );
        if is_final_derivation <> true then
            is_final_derivation := false;
        fi;
        
        if weight = -1 then
            weight := 100;
        fi;
        
        if record.with_given_without_given_name_pair <> fail then
            
            without_given_name := record.with_given_without_given_name_pair[ 1 ];
            with_given_name := record.with_given_without_given_name_pair[ 2 ];
            
            without_given_weight := CurrentOperationWeight( category!.derivations_weight_list, without_given_name );
            with_given_weight := CurrentOperationWeight( category!.derivations_weight_list, with_given_name );
            
            if record.is_with_given = false then
                
                if with_given_weight <= weight then
                    
                    category!.redirects.( without_given_name ) := true;
                    
                else
                    
                    category!.redirects.( without_given_name ) := false;
                    
                fi;
                
            else
                
                if weight <= without_given_weight then
                    
                    category!.redirects.( without_given_name ) := true;
                    
                else
                    
                    category!.redirects.( without_given_name ) := false;
                    
                fi;
                
            fi;
            
        fi;
        
        replaced_filter_list := CAP_INTERNAL_REPLACE_STRINGS_WITH_FILTERS( filter_list, category );
        
        ## Nr arguments sanity check
        
        needs_wrapping := record.install_convenience_without_category and not ( ( is_derivation or is_final_derivation ) or ( IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true ) );
        
        # backwards compatibility for categories without category!.category_as_first_argument
        if needs_wrapping then
            
            number_of_proposed_arguments := Length( filter_list ) - 1;
            
        else
            
            number_of_proposed_arguments := Length( filter_list );
            
        fi;
        
        for current_function_number in [ 1 .. Length( method_list ) ] do
            
            current_function_argument_number := NumberArgumentsFunction( method_list[ current_function_number ][ 1 ] );
            
            if current_function_argument_number >= 0 and current_function_argument_number <> number_of_proposed_arguments then
                Error( "In ", add_name, ": given function ", String( current_function_number ), " has ", String( current_function_argument_number ),
                       " arguments but should have ", String( number_of_proposed_arguments ) );
            fi;
            
            if ( is_derivation or is_final_derivation ) or ( IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true ) then
                
                current_additional_filter_list_length := Length( method_list[ current_function_number ][ 2 ] );
                
                if current_additional_filter_list_length > 0 and current_additional_filter_list_length <> number_of_proposed_arguments then
                    Error( "In ", add_name, ": the additional filter list of given function ", String( current_function_number ), " has length ",
                           String( current_additional_filter_list_length ), " but should have length ", String( number_of_proposed_arguments ), " (or 0)" );
                fi;
                
            fi;
            
            # backwards compatibility for categories without category!.category_as_first_argument
            if needs_wrapping then
                
                method_list[ current_function_number ][ 1 ] := CAP_INTERNAL_CREATE_NEW_FUNC_WITH_ONE_MORE_ARGUMENT_WITH_RETURN( method_list[ current_function_number ][ 1 ] );
                method_list[ current_function_number ][ 2 ] := Concatenation( [ IsCapCategory ], method_list[ current_function_number ][ 2 ] );
                
            fi;
            
        od;
        
        # prepare input sanity check
        input_human_readable_identifier_getter := i -> Concatenation( "the ", String(i), "-th argument of the function \033[1m", record.function_name, "\033[0m of the category named \033[1m", Name( category ), "\033[0m" );
        
        input_sanity_check_functions := [];
        for i in [ 1 .. Length( record.filter_list ) ] do
            filter := record.filter_list[ i ];

            # in the special case of multiple filters, we currently only test for the first one
            if not IsString( filter ) and IsList( filter ) then
                filter := filter[1];
            fi;
            
            if IsFilter( filter ) then
                # the only check would be that the input lies in the filter, which is already checked by the method selection
                input_sanity_check_functions[i] := ReturnTrue;
            elif filter = "category" then
                # the only check would be that the input lies in IsCapCategory, which is already checked by the method selection
                input_sanity_check_functions[i] := ReturnTrue;
            elif filter = "cell" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "object" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "morphism" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "twocell" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "other_cell" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_CELL_OF_CATEGORY( arg, false, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "other_object" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( arg, false, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "other_morphism" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( arg, false, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "other_twocell" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY( arg, false, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "list_of_objects" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_LIST_OF_OBJECTS_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "list_of_morphisms" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_LIST_OF_MORPHISMS_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            elif filter = "list_of_twocells" then
                input_sanity_check_functions[i] := function( arg, i )
                    CAP_INTERNAL_ASSERT_IS_LIST_OF_TWO_CELLS_OF_CATEGORY( arg, category, function( ) return input_human_readable_identifier_getter( i ); end );
                end;
            else
                Display( Concatenation( "Warning: You should add an input sanity check for the following filter: ", String( filter ) ) );
                input_sanity_check_functions[i] := ReturnTrue;
            fi;
        od;
        
        # prepare output sanity check
        output_human_readable_identifier_getter := function( )
            return Concatenation( "the result of the function \033[1m", record.function_name, "\033[0m of the category named \033[1m", Name( category ), "\033[0m" );
        end;
        
        if IsFilter( record.return_type ) then
            output_sanity_check_function := function( result )
                if not record.return_type( result ) then
                    Error( Concatenation( output_human_readable_identifier_getter(), " does not lie in the required filter. You can access the result and the filter via the local variables 'result' and 'record.return_type' in a break loop." ) );
                fi;
            end;
        elif record.return_type = "object" then
            output_sanity_check_function := function( result )
                CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
            end;
        elif record.return_type = "object_or_fail" then
            output_sanity_check_function := function( result )
                if result <> fail then
                    CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
                fi;
            end;
        elif record.return_type = "morphism" then
            output_sanity_check_function := function( result )
                CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
            end;
        elif record.return_type = "morphism_or_fail" then
            output_sanity_check_function := function( result )
                if result <> fail then
                    CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
                fi;
            end;
        elif record.return_type = "twocell" then
            output_sanity_check_function := function( result )
                CAP_INTERNAL_ASSERT_IS_TWO_CELL_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
            end;
        elif record.return_type = "bool" then
            output_sanity_check_function := function( result )
                if not ( result = true or result = false ) then
                    Error( Concatenation( output_human_readable_identifier_getter(), " is not a boolean (true/false). You can access the result via the local variable 'result' in a break loop." ) );
                fi;
            end;
        elif record.return_type = "other_object" then
            output_sanity_check_function := function( result )
                CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( result, false, output_human_readable_identifier_getter );
            end;
        elif record.return_type = "other_morphism" then
            output_sanity_check_function := function( result )
                CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( result, false, output_human_readable_identifier_getter );
            end;
        elif record.return_type = "list_of_morphisms" then
            output_sanity_check_function := function( result )
                CAP_INTERNAL_ASSERT_IS_LIST_OF_MORPHISMS_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
            end;
        elif record.return_type = "list_of_morphisms_or_fail" then
            output_sanity_check_function := function( result )
                if result <> fail then
                    CAP_INTERNAL_ASSERT_IS_LIST_OF_MORPHISMS_OF_CATEGORY( result, category, output_human_readable_identifier_getter );
                fi;
            end;
        else
            Display( Concatenation( "Warning: You should add an output sanity check for the following return_type: ", String( record.return_type ) ) );
            output_sanity_check_function := ReturnTrue;
        fi;

        if IsPackageMarkedForLoading( "CompilerForCAP", ">= 2020.06.17" ) then
            
            cap_jit_compiled_function := ValueGlobal( "CapJitCompiledFunction" );
            
        else
            
            cap_jit_compiled_function := function( args... )
                
                Error( "package CompilerForCAP is not loaded, so please disable compilation" );
                
            end;
            
        fi;
        
        install_func := function( func_to_install, additional_filters )
          local new_filter_list, index;
            
            Add( category!.added_functions.( function_name ), [ func_to_install, additional_filters ] );
            
            new_filter_list := CAP_INTERNAL_MERGE_FILTER_LISTS( replaced_filter_list, additional_filters );
            
            if category!.enable_compilation = true or ( IsList( category!.enable_compilation ) and function_name in category!.enable_compilation ) then
                
                if not (IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true) then
                    
                    Error( "only categories with `category!.category_as_first_argument = true` can be compiled" );
                    
                fi;
                
                index := Length( category!.added_functions.( function_name ) );
                
                InstallMethod( ValueGlobal( install_name ),
                            new_filter_list,
                    
                    function( arg )
                        
                        if not IsBound( category!.compiled_functions.( function_name )[ index ] ) then
                            
                            category!.compiled_functions.( function_name )[ index ] := cap_jit_compiled_function( func_to_install, arg );
                            
                        fi;
                        
                        return CallFuncList( category!.compiled_functions.( function_name )[ index ], arg );
                        
                end );
                
            elif category!.overhead then
            
                InstallMethodWithCache( ValueGlobal( install_name ),
                                new_filter_list,
                                
                  function( arg )
                    local redirect_return, filter, human_readable_identifier_getter, pre_func_return, result, i, j;
                    
                    if (redirect_function <> false) and (not IsBound( category!.redirects.( function_name ) ) or category!.redirects.( function_name ) <> false) then
                        redirect_return := CallFuncList( redirect_function, arg );
                        if redirect_return[ 1 ] = true then
                            if category!.predicate_logic then
                                if record!.install_convenience_without_category then
                                    INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{[ 2 .. Length( arg ) ]}, redirect_return[ 2 ], category );
                                else
                                    INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg, redirect_return[ 2 ], category );
                                fi;
                            fi;
                            return redirect_return[ 2 ];
                        fi;
                    fi;
                    
                    if category!.input_sanity_check_level > 0 then
                        for i in [ 1 .. Length( input_sanity_check_functions ) ] do
                            input_sanity_check_functions[ i ]( arg[ i ], i );
                        od;
                        
                        pre_func_return := CallFuncList( pre_function, arg );
                        if pre_func_return[ 1 ] = false then
                            CAP_INTERNAL_DISPLAY_ERROR_FOR_FUNCTION_OF_CATEGORY( record.function_name, category, pre_func_return[ 2 ] );
                        fi;
                        
                        if category!.input_sanity_check_level > 1 then
                            pre_func_return := CallFuncList( pre_function_full, arg );
                            if pre_func_return[ 1 ] = false then
                                CAP_INTERNAL_DISPLAY_ERROR_FOR_FUNCTION_OF_CATEGORY( record.function_name, category, pre_func_return[ 2 ] );
                            fi;
                        fi;
                        
                    fi;
                    
                    result := CallFuncList( func_to_install, arg );
                    
                    if category!.predicate_logic then
                        if record!.install_convenience_without_category then
                            INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg{[ 2 .. Length( arg ) ]}, result, category );
                        else
                            INSTALL_TODO_FOR_LOGICAL_THEOREMS( record.function_name, arg, result, category );
                        fi;
                    fi;
                    
                    if (not is_derivation) then
                        if category!.add_primitive_output then
                            add_function( category, result );
                        elif category!.output_sanity_check_level > 0 then
                            output_sanity_check_function( result );
                        fi;
                    fi;
                    
                    if post_function <> false then
                        
                        CallFuncList( post_function, Concatenation( arg, [ result ] ) );
                        
                    fi;
                    
                    return result;
                    
                end : Cache := GET_METHOD_CACHE( category, function_name, Length( filter_list ) ) );
            
            else #category!.overhead = false
                
                InstallMethod( ValueGlobal( install_name ),
                            new_filter_list,
                    
                    function( arg )
                        
                        return CallFuncList( func_to_install, arg );
                        
                end );
                
            fi;
            
        end;
        
        if not IsBound( category!.added_functions.( function_name ) ) then
            
            category!.added_functions.( function_name ) := [ ];
            
        fi;
        
        if not IsBound( category!.compiled_functions.( function_name ) ) then
            
            category!.compiled_functions.( function_name ) := [ ];
            
        fi;
        
        for i in method_list do
            
            if record.installation_name = "IsEqualForObjects" and IsIdenticalObj( i[ 1 ], IsIdenticalObj ) and category!.default_cache_type <> "crisp" and not ValueOption( "SuppressCacheWarning" ) = true then
                Display( "WARNING: IsIdenticalObj is used for deciding the equality of objects but the caching is not set to crisp. Thus, probably the specification that equal input gives equal output is not fulfilled. You can suppress this warning by passing the option \"SuppressCacheWarning := true\" to AddIsEqualForObjects." );
            fi;
            
            install_func( i[ 1 ], i[ 2 ] );
        od;
        
        if set_primitive then
            AddPrimitiveOperation( category!.derivations_weight_list, function_name, weight );
            
            if not ValueOption( "IsFinalDerivation" ) = true then
                category!.primitive_operations.( function_name ) := true;
            fi;
            
        fi;
        
    end );
    
end );

BindGlobal( "CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATION_PAIR", function( without_given_name, with_given_name, object_name, with_given_arguments_names, object_arguments_positions )
  local without_given_arguments_names, with_given_via_without_given_function, without_given_via_with_given_function;
    
    without_given_arguments_names := with_given_arguments_names{[ 1 .. Length( with_given_arguments_names ) - 1 ]};
    
    with_given_via_without_given_function := EvalString( ReplacedStringViaRecord(
        """
        function( with_given_arguments )
            
            return without_given_name( without_given_arguments );
            
        end
        """,
        rec(
            with_given_arguments := with_given_arguments_names,
            without_given_arguments := without_given_arguments_names,
            without_given_name := without_given_name,
        )
    ) );
    
    without_given_via_with_given_function := EvalString( ReplacedStringViaRecord(
        """
        function( without_given_arguments )
            
            return with_given_name( without_given_arguments, object_name( object_arguments ) );
            
        end
        """,
        rec(
            without_given_arguments := without_given_arguments_names,
            with_given_name := with_given_name,
            object_name := object_name,
            object_arguments := without_given_arguments_names{object_arguments_positions},
        )
    ) );
    
    AddDerivationToCAP( ValueGlobal( with_given_name ),
                        [ [ ValueGlobal( without_given_name ), 1 ] ],
      with_given_via_without_given_function
      : Description := Concatenation( with_given_name, " by calling ", without_given_name, " with the last argument dropped" ) );
    
    AddDerivationToCAP( ValueGlobal( without_given_name ),
                        [ [ ValueGlobal( with_given_name ), 1 ],
                          [ ValueGlobal( object_name ), 1 ] ],
      without_given_via_with_given_function
      : Description := Concatenation( without_given_name, " by calling ", with_given_name, " with ", object_name, " as last argument" ) );
    
end );

BindGlobal( "CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATIONS", function( record )
  local recnames, current_recname, current_rec, without_given_name, with_given_name, object_name, with_given_arguments_names, object_arguments_positions;
    
    recnames := RecNames( record );
    
    for current_recname in recnames do
        
        current_rec := record.(current_recname);

        if current_rec.is_with_given then
            
            without_given_name := current_rec.with_given_without_given_name_pair[1];
            with_given_name := current_rec.with_given_without_given_name_pair[2];
            object_name := current_rec.with_given_object_name;
            with_given_arguments_names := current_rec.input_arguments_names;
            object_arguments_positions := record.( without_given_name ).object_arguments_positions;
            
            if record.( without_given_name ).filter_list[1] <> "category" or record.( object_name ).filter_list[1] <> "category" or record.( with_given_name ).filter_list[1] <> "category" then
                
                Display( Concatenation(
                    "WARNING: You seem to be relying on automatically installed WithGiven derivations but the first arguments of the functions involved are not the category. ",
                    "The automatic WithGiven derivation will not be installed. ",
                    "To prevent this warning, add the category as the first argument to all functions involved. ",
                    "Search for `category_as_first_argument` in the documentation for more details."
                ) );
                
            elif Length( record.( without_given_name ).filter_list ) + 1 <> Length( record.( with_given_name ).filter_list ) then
                
                Display( Concatenation(
                    "WARNING: You seem to be relying on automatically installed WithGiven derivations. ",
                    "For this, the with given method must have exactly one additional argument compared to the without given method. ",
                    "This is not the case, so no automatic WithGiven derivation will be installed."
                ) );
                
            else
                
                CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATION_PAIR( without_given_name, with_given_name, object_name, with_given_arguments_names, object_arguments_positions );
                
            fi;
            
        fi;
        
    od;
end );

InstallGlobalFunction( CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD,
    
  function( record )
    local recnames, current_recname, current_rec;
    
    CAP_INTERNAL_ENHANCE_NAME_RECORD( record );
    
    recnames := RecNames( record );
    
    AddOperationsToDerivationGraph( CAP_INTERNAL_DERIVATION_GRAPH, recnames );
    
    for current_recname in recnames do
        
        current_rec := record.( current_recname );
        
        ## keep track of it in method name rec
        CAP_INTERNAL_METHOD_NAME_RECORD.( current_recname ) := current_rec;
        
        if IsBound( current_rec.no_install ) and current_rec.no_install = true then
            
            continue;
            
        fi;
        
        CapInternalInstallAdd( current_rec );
        
    od;
    
    # for the sanity checks in AddDerivation, the record already has to be attached to CAP_INTERNAL_METHOD_NAME_RECORD at this point
    CAP_INTERNAL_INSTALL_WITH_GIVEN_DERIVATIONS( record );
    
end );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( CAP_INTERNAL_METHOD_NAME_RECORD );

## These methods overwrite the automatically generated methods.
## The users do not have to give the category as an argument
## to their functions, but within derivations, the category has
## to be an argument (see any derivation of ZeroObject in DerivedMethods.gi)
##
InstallMethod( AddZeroObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then
        
        TryNextMethod( );
        
    fi;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddZeroObject( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
InstallMethod( AddInitialObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then
        
        TryNextMethod( );
        
    fi;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddInitialObject( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
InstallMethod( AddTerminalObject,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then
        
        TryNextMethod( );
        
    fi;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddTerminalObject( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
InstallMethod( AddDistinguishedObjectOfHomomorphismStructure,
               [ IsCapCategory, IsFunction, IsInt ],
               
  function( category, func, weight )
    local wrapped_func;
    
    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then
        
        TryNextMethod( );
        
    fi;
    
    wrapped_func := function( cat ) return func(); end;
    
    AddDistinguishedObjectOfHomomorphismStructure( category, [ [ wrapped_func, [ ] ] ], weight );
    
end );

##
InstallMethod( AddMorphismBetweenDirectSums,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    local wrapper;
    
    Print(
      Concatenation(
      "WARNING: AddMorphismBetweenDirectSums is deprecated and will not be supported after 2022.04.18. ",
      "Please use AddMorphismBetweenDirectSumsWithGivenDirectSums instead.\n"
      )
    );
    
    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then
        
        wrapper := { cat, S, diagram_S, M, diagram_T, T } -> func( cat, S, M, T );
        
    else
        
        wrapper := { S, diagram_S, M, diagram_T, T } -> func( S, M, T );
        
    fi;
    
    AddMorphismBetweenDirectSumsWithGivenDirectSums( category, wrapper );
    
end );

##
InstallMethod( AddDirectSumFunctorialWithGivenDirectSums,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    local nr_arguments, wrapper;
    
    nr_arguments := NumberArgumentsFunction( func );

    wrapper := fail;
    
    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then

        if nr_arguments = 4 then
        
            Print(
              Concatenation(
              "WARNING: AddDirectSumFunctorialWithGivenDirectSums with a function with 4 arguments is deprecated and will not be supported after 2022.04.18. ",
              "Please give a function with 6 arguments instead.\n"
              )
            );
                
            wrapper := { cat, S, diagram_S, L, diagram_T, T } -> func( cat, S, L, T );

        fi;
        
    else
        
        if nr_arguments = 3 then
        
            Print(
              Concatenation(
              "WARNING: AddDirectSumFunctorialWithGivenDirectSums with a function with 3 arguments is deprecated and will not be supported after 2022.04.18. ",
              "Please give a function with 5 arguments instead.\n"
              )
            );
                
            wrapper := { S, diagram_S, L, diagram_T, T } -> func( S, L, T );

        fi;
        
    fi;

    if wrapper = fail then
        
        TryNextMethod( );
        
    fi;
    
    AddDirectSumFunctorialWithGivenDirectSums( category, wrapper );
    
end );

##
InstallMethod( AddDirectProductFunctorialWithGivenDirectProducts,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    local nr_arguments, wrapper;
    
    nr_arguments := NumberArgumentsFunction( func );

    wrapper := fail;
    
    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then

        if nr_arguments = 4 then
        
            Print(
              Concatenation(
              "WARNING: AddDirectProductFunctorialWithGivenDirectProducts with a function with 4 arguments is deprecated and will not be supported after 2022.04.18. ",
              "Please give a function with 6 arguments instead.\n"
              )
            );
                
            wrapper := { cat, S, diagram_S, L, diagram_T, T } -> func( cat, S, L, T );

        fi;
        
    else
        
        if nr_arguments = 3 then
        
            Print(
              Concatenation(
              "WARNING: AddDirectProductFunctorialWithGivenDirectProducts with a function with 3 arguments is deprecated and will not be supported after 2022.04.18. ",
              "Please give a function with 5 arguments instead.\n"
              )
            );
                
            wrapper := { S, diagram_S, L, diagram_T, T } -> func( S, L, T );

        fi;
        
    fi;

    if wrapper = fail then
        
        TryNextMethod( );
        
    fi;
    
    AddDirectProductFunctorialWithGivenDirectProducts( category, wrapper );
    
end );

##
InstallMethod( AddCoproductFunctorialWithGivenCoproducts,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    local nr_arguments, wrapper;
    
    nr_arguments := NumberArgumentsFunction( func );

    wrapper := fail;
    
    if IsBound( category!.category_as_first_argument ) and category!.category_as_first_argument = true then

        if nr_arguments = 4 then
        
            Print(
              Concatenation(
              "WARNING: AddCoproductFunctorialWithGivenCoproducts with a function with 4 arguments is deprecated and will not be supported after 2022.04.18. ",
              "Please give a function with 6 arguments instead.\n"
              )
            );
                
            wrapper := { cat, S, diagram_S, L, diagram_T, T } -> func( cat, S, L, T );

        fi;
        
    else
        
        if nr_arguments = 3 then
        
            Print(
              Concatenation(
              "WARNING: AddCoproductFunctorialWithGivenCoproducts with a function with 3 arguments is deprecated and will not be supported after 2022.04.18. ",
              "Please give a function with 5 arguments instead.\n"
              )
            );
                
            wrapper := { S, diagram_S, L, diagram_T, T } -> func( S, L, T );

        fi;
        
    fi;

    if wrapper = fail then
        
        TryNextMethod( );
        
    fi;
    
    AddCoproductFunctorialWithGivenCoproducts( category, wrapper );
    
end );
