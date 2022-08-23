# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( MatrixCategoryAsFreydCategoryOfMatrixCategory,
               [ IsFieldForHomalg ],
               
  function( homalg_ring )
    local vec, freyd, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_constructor, morphism_datum, modeling_tower_morphism_datum, wrapper;
    
    vec := MATRIX_CATEGORY( homalg_ring : FinalizeCategory := true );
    
    freyd := FreydCategory( vec : FinalizeCategory := true );
    
    ##
    object_constructor := function( cat, dimension )
        
        return MatrixCategoryObject( cat, dimension );
        
    end;
    
    modeling_tower_object_constructor := function( cat, dimension )
      local freyd, vec;
        
        freyd := ModelingCategory( cat );
        
        vec := UnderlyingCategory( freyd );
        
        return AsFreydCategoryObject( freyd, MatrixCategoryObject( vec, dimension ) ); # 0 -> dimension
        
    end;
    
    ##
    object_datum := function( cat, obj )
        
        return Dimension( obj );
        
    end;
    
    modeling_tower_object_datum := function( cat, obj )
      local freyd, vec;
        
        freyd := ModelingCategory( cat );
        
        vec := UnderlyingCategory( freyd );
        
        return Dimension( CokernelObject( vec, RelationMorphism( obj ) ) );
        
    end;
    
    ##
    morphism_constructor := function( cat, source, underlying_matrix, range )
        
        return VectorSpaceMorphism( cat, source, underlying_matrix, range );
        
    end;
    
    modeling_tower_morphism_constructor := function( cat, source, underlying_matrix, range )
      local freyd, vec, vec_morphism;
        
        freyd := ModelingCategory( cat );
        
        vec := UnderlyingCategory( freyd );
        
        vec_morphism := VectorSpaceMorphism( vec,
            Range( RelationMorphism( source ) ),
            underlying_matrix,
            Range( RelationMorphism( range ) )
        );
        
        return FreydCategoryMorphism( freyd,
            source,
            vec_morphism,
            range
        );
        
    end;
    
    ##
    morphism_datum := function( cat, mor )
        
        return UnderlyingMatrix( mor );
        
    end;
    
    modeling_tower_morphism_datum := function( cat, mor )
      local freyd, vec, A, B, pi_B, tau, L;
        
        freyd := ModelingCategory( cat );
        
        vec := UnderlyingCategory( freyd );
        
        A := RelationMorphism( Source( mor ) );
        B := RelationMorphism( Range( mor ) );
        
        #pi_A := CokernelProjection( vec, A ); # implicit in CokernelColift
        pi_B := CokernelProjection( vec, B );
        
        tau := PreCompose( vec, UnderlyingMorphism( mor ), pi_B );
        
        L := CokernelColift( vec, A, Range( tau ), tau );
        
        return UnderlyingMatrix( L );
        
    end;
    
    wrapper := WrapperCategory( freyd, rec(
        name := Concatenation( "Columns( ", RingName( homalg_ring )," )" ),
        category_filter := IsMatrixCategory,
        category_filter := IsMatrixCategory,
        category_object_filter := IsVectorSpaceObject and HasDimension and HasIsProjective and IsProjective,
        category_morphism_filter := IsVectorSpaceMorphism and HasUnderlyingMatrix,
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum,
        modeling_tower_object_constructor := modeling_tower_object_constructor,
        modeling_tower_object_datum := modeling_tower_object_datum,
        modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
        modeling_tower_morphism_datum := modeling_tower_morphism_datum,
        #only_primitive_operations := true,
    ) : FinalizeCategory := false, overhead := false );
    
    SetUnderlyingRing( wrapper, homalg_ring );
    
    wrapper!.compiler_hints.category_attribute_names := [
        "UnderlyingRing",
    ];
    wrapper!.compiler_hints.source_and_range_attributes_from_morphism_attribute := rec(
        object_attribute_name := "Dimension",
        morphism_attribute_name := "UnderlyingMatrix",
        source_attribute_getter_name := "NumberRows",
        range_attribute_getter_name := "NumberColumns",
    );
    
    SetIsSkeletalCategory( wrapper, true );
    
    SetIsAbelianCategory( wrapper, true );
    
    Finalize( wrapper );
    
    return wrapper;
    
end );
