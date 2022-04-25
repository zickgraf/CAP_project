# SPDX-License-Identifier: GPL-2.0-or-later
# CompilerForCAP: Speed up computations in CAP categories
#
# Implementations
#
InstallGlobalFunction( "CapJitCompiledCAPOperationAsEnhancedSyntaxTree", function ( cat, operation_name )
  local index, function_to_compile, info, filter_list, return_type, arguments_data_types, return_data_type;
    
    if not (IsBound( cat!.category_as_first_argument ) and cat!.category_as_first_argument = true) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "only CAP operations of categories with `cat!.category_as_first_argument = true` can be compiled" );
        
    fi;
    
    # find the last added function with no additional filters
    index := Last( PositionsProperty( cat!.added_functions.(operation_name), f -> Length( f[2] ) = 0 ) );
    
    if index = fail then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "All added functions for <operation_name> in <cat> have additional filters. Cannot continue with compilation." );
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees ) then
        
        cat!.compiled_functions_trees := rec( );
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees.(operation_name) ) then
        
        cat!.compiled_functions_trees.(operation_name) := [ ];
        
    fi;
    
    if not IsBound( cat!.compiled_functions_trees.(operation_name)[index] ) then
        
        function_to_compile := cat!.added_functions.(operation_name)[index][1];
        
        if IsOperation( function_to_compile ) or IsKernelFunction( function_to_compile ) then
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "compiling operations or kernel functions is not supported." );
            
        fi;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(operation_name);
        
        filter_list := info.filter_list;
        return_type := info.return_type;
        
        if IsString( return_type ) and EndsWith( return_type, "fail" ) then
            
            Display( Concatenation(
                "WARNING: Compiling CAP operation ", operation_name, " with return_type ", return_type, ". ",
                "Operations returning fail usually do not fulfill the requirements that all branches of an if statement can be executed even if the corresponding condition does not hold. ",
                "This might cause errors."
            ) );
            
        fi;
        
        arguments_data_types := List( filter_list, function ( filter )
            
            if filter = "category" then
                
                return rec( filter := IsCapCategory, category := cat );
                
            elif filter = "object" then
                
                return rec( filter := cat!.object_representation, category := cat );
                
            elif filter = "morphism" then
                
                return rec( filter := cat!.morphism_representation, category := cat );
                
            elif filter = "list_of_objects" then
                
                return rec( filter := IsList, element_type := rec( filter := cat!.object_representation, category := cat ) );
                
            elif filter = "list_of_morphisms" then
                
                return rec( filter := IsList, element_type := rec( filter := cat!.morphism_representation, category := cat ) );
                
            elif filter = IsInt then
                
                return rec( filter := IsInt );
                
            elif filter = "object_in_range_category_of_homomorphism_structure" then
                
                return rec( filter := RangeCategoryOfHomomorphismStructure( cat )!.object_representation, category := RangeCategoryOfHomomorphismStructure( cat ) );
                
            elif filter = "morphism_in_range_category_of_homomorphism_structure" then
                
                return rec( filter := RangeCategoryOfHomomorphismStructure( cat )!.morphism_representation, category := RangeCategoryOfHomomorphismStructure( cat ) );
                
            # handle matrices of morphisms until https://github.com/homalg-project/CAP_project/issues/801 is fixed
            elif filter = IsList and operation_name in [ "MorphismBetweenDirectSums", "MorphismBetweenDirectSumsWithGivenDirectSums", "SolveLinearSystemInAbCategory", "MereExistenceOfSolutionOfLinearSystemInAbCategory" ] then
                
                return rec( filter := IsList, element_type := rec( filter := IsList, element_type := rec( filter := cat!.morphism_representation, category := cat ) ) );
                
            elif filter = IsObject and IsMatrixCategory( cat ) and operation_name = "ObjectConstructor" then
                
                return rec( filter := IsInt );
                
            elif filter = IsObject and IsMatrixCategory( cat ) and operation_name = "MorphismConstructor" then
                
                return rec( filter := IsHomalgMatrix );
                
            elif filter = IsRingElement and IsMatrixCategory( cat ) and operation_name = "MultiplyWithElementOfCommutativeRingForMorphisms" then
                
                return rec( filter := IsHomalgRingElement );
                
            else
                
                Error( "unhandled filter ", filter );
                return fail;
                
            fi;
            
        end );
        
        if fail in arguments_data_types then
            
            arguments_data_types := fail;
            
        fi;
        
        if return_type = "object" then
            
            return_data_type := rec( filter := cat!.object_representation, category := cat );
            
        elif return_type = "morphism" then
            
            return_data_type := rec( filter := cat!.morphism_representation, category := cat );
            
        elif return_type = "list_of_objects" then
            
            return_data_type := rec( filter := IsList, element_type := rec( filter := cat!.object_representation, category := cat ) );
            
        elif return_type = "list_of_morphisms" then
            
            return_data_type := rec( filter := IsList, element_type := rec( filter := cat!.morphism_representation, category := cat ) );
            
        elif return_type = "object_in_range_category_of_homomorphism_structure" then
            
            return_data_type := rec( filter := RangeCategoryOfHomomorphismStructure( cat )!.object_representation, category := RangeCategoryOfHomomorphismStructure( cat ) );
            
        elif return_type = "morphism_in_range_category_of_homomorphism_structure" then
            
            return_data_type := rec( filter := RangeCategoryOfHomomorphismStructure( cat )!.morphism_representation, category := RangeCategoryOfHomomorphismStructure( cat ) );
            
        elif return_type = "bool" then
            
            return_data_type := rec( filter := IsBool );
            
        elif return_type = IsList and IsMatrixCategory( cat ) and operation_name = "CoefficientsOfMorphismWithGivenBasisOfExternalHom" then
            
            return_data_type := rec( filter := IsList, element_type := rec( filter := IsHomalgRingElement ) );
            
        elif return_type = IsObject and IsMatrixCategory( cat ) and operation_name = "ObjectDatum" then
            
            return_data_type := rec( filter := IsInt );
            
        elif return_type = IsObject and IsMatrixCategory( cat ) and operation_name = "MorphismDatum" then
            
            return_data_type := rec( filter := IsHomalgMatrix );
            
        else
            
            Error( "unhandled return_type ", return_type );
            return_data_type := fail;
            
        fi;
        
        if IsAdelmanCategory( cat ) and operation_name in [ "CokernelColift", "ColiftAlongEpimorphism" ] then
            
            Assert( 0, arguments_data_types <> fail );
            
            return ENHANCED_SYNTAX_TREE( function_to_compile : globalize_hvars := true, given_arguments := [ cat ], type_signature := [ arguments_data_types, return_data_type ] );
            
        fi;
        
        if NamesLocalVariablesFunction( function_to_compile )[1] <> "cat_1" then
            
            Display( "precompiling" );
            Display( operation_name );
            Display( "in" );
            Display( Name( cat ) );
            
        fi;
        
        if arguments_data_types <> fail then
            
            cat!.compiled_functions_trees.(operation_name)[index] := CapJitCompiledFunctionAsEnhancedSyntaxTree( function_to_compile, [ arguments_data_types, return_data_type ] );
            
        else
            
            cat!.compiled_functions_trees.(operation_name)[index] := CapJitCompiledFunctionAsEnhancedSyntaxTree( function_to_compile, cat );
            
        fi;
        
        if operation_name = "ComponentOfMorphismIntoDirectSum" then
            
            #Error("asd");
            
        fi;
        
        if NamesLocalVariablesFunction( function_to_compile )[1] <> "cat_1" then
            
            Display( "finished" );
            Display( operation_name );
            Display( "in" );
            Display( Name( cat ) );
            Display( "" );
            
        fi;
        
    fi;
    
    return CapJitCopyWithNewFunctionIDs( cat!.compiled_functions_trees.(operation_name)[index] );
    
end );
