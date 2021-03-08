# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
InstallMethod( RingAsCategory,
               [ IsRing ],
               RING_AS_CATEGORY
);

##
InstallMethod( RING_AS_CATEGORY,
               [ IsRing ],
               
  function( ring )
    local category;
    
    category := CreateCapCategory( Concatenation( "RingAsCategory( ", String( ring )," )" ), IsRingAsCategory, IsRingAsCategoryObject, IsRingAsCategoryMorphism, IsCapCategoryTwoCell );
    
    category!.compiler_hints := rec(
        category_attribute_names := [
            "UnderlyingRing",
            "RingAsCategoryUniqueObject",
        ],
    );
    
    SetUnderlyingRing( category, ring );
    
    SetIsAbCategory( category, true );
    
    INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY( category );
    
    Finalize( category );
    
    return category;
    
end );

##
InstallMethod( RingAsCategoryUniqueObject,
               [ IsRingAsCategory ],
               
  function( category )
    
    return CreateCapCategoryObjectWithAttributes( category );
    
end );

##
InstallMethodForCompilerForCAP( RingAsCategoryMorphismOp,
                                [ IsRingAsCategory, IsRingElement ],
                                
  function( category, element )
    local unique_object;
    #% CAP_JIT_RESOLVE_FUNCTION
    
    unique_object := RingAsCategoryUniqueObject( category );
    
    return CreateCapCategoryMorphismWithAttributes( category,
                                                    unique_object,
                                                    unique_object,
                                                    UnderlyingRingElement, element );
    
end );

##
InstallOtherMethod( RingAsCategoryMorphism,
               [ IsRingElement, IsRingAsCategory ],
               
  function( element, category )
    
    return RingAsCategoryMorphism( category, element );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( ViewString,
               [ IsRingAsCategoryMorphism ],
    
    function( alpha )
        
        return Concatenation( "<", ViewString( UnderlyingRingElement( alpha ) ), ">" );
        
end );

##
InstallMethod( ViewString,
               [ IsRingAsCategoryObject ],

  function( obj )
    
    return "*";
    
end );

####################################
##
## Basic operations
##
####################################

InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY,
  
  function( category )
    local ring, equality_func, range_category, field, generating_system, indets, l, generating_system_as_column, ring_as_module, distinguished_object, interpret_element_as_row_vector, morphism_constructor, ring_inclusion, k, comb, Qrows, matrix_access;
    
    ring := UnderlyingRing( category );
    
    ##
    AddIsEqualForObjects( category, {cat, A, B} -> true );
    
    equality_func := {cat, alpha, beta} -> UnderlyingRingElement( alpha ) = UnderlyingRingElement( beta );
    
    ##
    AddIsEqualForMorphisms( category, equality_func );
    
    ##
    AddIsCongruentForMorphisms( category, equality_func );
    
    ##
    AddIsWellDefinedForObjects( category, {cat, x} -> true );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( cat, alpha )
        
        return UnderlyingRingElement( alpha ) in UnderlyingRing( category );
        
    end );
    
    ##
    AddPreCompose( category,
      function( cat, alpha, beta )
        
        return RingAsCategoryMorphism(
            category,
            UnderlyingRingElement( alpha ) * UnderlyingRingElement( beta )
        );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( cat, unique_object )
        
        return RingAsCategoryMorphism(
            category,
            One( UnderlyingRing( cat ) )
        );
        
    end );
    
    ##
    AddIsOne( category,
      function( cat, alpha )
        
        return IsOne( UnderlyingRingElement( alpha ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, a, b )
        
        return RingAsCategoryMorphism(
            category,
            Zero( UnderlyingRing( cat ) )
        );
        
    end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( cat, alpha )
        
        return IsZero( UnderlyingRingElement( alpha ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( cat, alpha, beta )
        
        return RingAsCategoryMorphism(
            category,
            UnderlyingRingElement( alpha ) + UnderlyingRingElement( beta )
        );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( cat, alpha )
        
        return RingAsCategoryMorphism(
            category,
            - UnderlyingRingElement( alpha )
        );
        
    end );
    
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        SetCommutativeRingOfLinearCategory( category, ring );
        
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( cat, r, alpha )
            
            return RingAsCategoryMorphism( category, r * UnderlyingRingElement( alpha ) );
            
        end );
        
        ##
        AddLift( category,
          function( cat, alpha, beta )
            
            return RingAsCategoryMorphism(
                category,
                UnderlyingRingElement( alpha ) / UnderlyingRingElement( beta )
            );
            
        end );
        
        ##
        AddColift( category,
          function( cat, alpha, beta )
            
            return RingAsCategoryMorphism(
                category,
                UnderlyingRingElement( beta ) / UnderlyingRingElement( alpha )
            );
            
        end );
        
    fi;
    
    ## Homomorphism structure
    
    generating_system := fail;
    
if true then
    ## Homomorphism structure for homalg exterior rings over fields
    if IsHomalgRing( ring ) and HasIsExteriorRing( ring ) and IsExteriorRing( ring ) and IsField( BaseRing( ring ) ) then
        
        LoadPackage( "LazyCategories" );
        
        field := BaseRing( ring );
        
        SetInfoLevel( ValueGlobal( "InfoLazyCategory" ), 1000 );
        
    if true then
        
        # QRows
        Qrows := CategoryOfRows( field );
        Finalize( Qrows );
        
        #range_category := LazyCategory( Qrows : optimize := 0, show_evaluation := true );
        range_category := Qrows;
        
        generating_system := [ One( ring ) ];
        
        indets := IndeterminatesOfExteriorRing( ring );
        
        l := Length( indets );
        
        for k in [ 1 .. l ] do
            for comb in Combinations( indets, k ) do
                Add( generating_system, Product( comb ) );
            od;
        od;
        
        category!.generating_system := generating_system;
        
        generating_system_as_column := HomalgMatrix( generating_system, Length( generating_system ), 1, ring );
        
        category!.generating_system_as_column := generating_system_as_column;
        
        #ring_as_module := function ( )
        #    #% CAP_JIT_RESOLVE_FUNCTION
        #    
        #    return AsObjectInLazyCategory( range_category, CategoryOfRowsObjectOp( Qrows, Length( generating_system ) ) );
        #    
        #end;
        ring_as_module := function ( )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CategoryOfRowsObject( range_category, Length( generating_system ) );
            
        end;
        
        # field^{1 x 1}
        #distinguished_object := function( )
        #    #% CAP_JIT_RESOLVE_FUNCTION
        #    
        #    return AsObjectInLazyCategory( range_category, CategoryOfRowsObjectOp( Qrows, 1 ) );
        #    
        #end;
        distinguished_object := function( )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CategoryOfRowsObject( range_category, 1 );
            
        end;
        
        interpret_element_as_row_vector := function( r )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CoercedMatrix( ring, field, CoefficientsWithGivenMonomials( HomalgMatrix( [ r ], 1, 1, ring ), generating_system_as_column ) );
            
        end;
        
        #morphism_constructor := {source, matrix, range} -> AsMorphismInLazyCategory( source, CategoryOfRowsMorphism( EvaluatedCell( source ), matrix, EvaluatedCell( range ) ), range );
        morphism_constructor := CategoryOfRowsMorphism;
        
        ring_inclusion := RingMap( [], field, ring );

        #matrix_access := mor -> UnderlyingMatrix( EvaluatedCell( mor ) );
        matrix_access := UnderlyingMatrix;
        

    else
        
        # Qfpres
        Qfpres := LeftPresentations( field );
        Finalize( Qfpres );
        
        range_category := Qfpres;
        
        generating_system := [ One( ring ) ];
        
        indets := IndeterminatesOfExteriorRing( ring );
        
        l := Length( indets );
        
        for k in [ 1 .. l ] do
            for comb in Combinations( indets, k ) do
                Add( generating_system, Product( comb ) );
            od;
        od;

        category!.generating_system := generating_system;
        
        generating_system_as_column := HomalgMatrix( generating_system, Length( generating_system ), 1, ring );
        
        category!.generating_system_as_column := generating_system_as_column;
        
        ring_as_module := FreeLeftPresentation( Length( generating_system ), field );
        
        # Q^{1 x 1}
        distinguished_object := FreeLeftPresentation( 1, field );
        
        interpret_element_as_row_vector := function( r )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CoefficientsWithGivenMonomials( HomalgMatrix( [ r ], 1, 1, ring ), generating_system_as_column ) * field;
            
        end;

        morphism_constructor := PresentationMorphism;
        
        ring_inclusion := RingMap( [], field, ring );
        
        matrix_access := UnderlyingMatrix;

    fi;
        
    fi;

else

    ## Homomorphism structure for homalg exterior rings over center
    if IsHomalgRing( ring ) and HasIsExteriorRing( ring ) and IsExteriorRing( ring ) and IsField( CoefficientsRing( ring ) ) then
        
        GetMatrixOfRelationsOverRealCenter := function( R, dimension )
          local zero_relation, index_of_dth_ith_basis_vector, l, relations, relation, M, d, i, j, k;
            
            zero_relation := function()
                return HomalgInitialMatrix( 1, (l + 1) * dimension, RealCenter );
            end;
            
            index_of_dth_ith_basis_vector := function( d, i )
                return dimension * i + d;
            end;
            
            indets := Indeterminates( R );
            
            l := Length( indets );
            
            relations := [  ];
            
            for d in [ 1 .. dimension ] do
                for i in [ 1 .. l ] do
                    for j in [ 1 .. l ] do
                        if i < j then
                            relation := zero_relation();
                            relation[1,index_of_dth_ith_basis_vector( d, i )] := Concatenation( "e", String( i - 1 ), "e", String( j - 1 ) ) / RealCenter;
                            Add( relations, relation );
                            for k in [ (i+1) .. l ] do
                                if k <> j then
                                    relation := zero_relation();
                                    if k < j then
                                        relation[1,index_of_dth_ith_basis_vector( d, i )] := Concatenation( "e", String( k - 1 ), "e", String( j - 1 ) ) / RealCenter;
                                    else
                                        relation[1,index_of_dth_ith_basis_vector( d, i )] := Concatenation( "-e", String( j - 1 ), "e", String( k - 1 ) ) / RealCenter;
                                    fi;
                                    relation[1,index_of_dth_ith_basis_vector( d, j )] := Concatenation( "-e", String( i - 1 ), "e", String( k - 1 ) ) / RealCenter;
                                    Add( relations, relation );
                                fi;
                            od;
                        fi;
                        if i > j then
                            relation := zero_relation();
                            relation[1,index_of_dth_ith_basis_vector( d, i )] := Concatenation( "e", String( j - 1 ), "e", String( i - 1 ) ) / RealCenter;
                            Add( relations, relation );
                        fi;
                    od;
                od;
            od;
            
            M := UnionOfRows( relations );
            
            Eval( M );
            
            return M;
            
        end;

        GeneratingSystemOverQ := function( R )
          local generating_system, indets, l, k, comb;
            
            generating_system := [ One( R ) ];
            
            indets := Indeterminates( R );
            
            l := Length( indets );
            
            for k in [ 1 .. l ] do
                for comb in Combinations( indets, k ) do
                    Add( generating_system, Product( comb ) );
                od;
            od;
            
            return generating_system;
            
        end;

        GeneratingSystemOverQToRealCenterTrafoMatrix := function( R )
          local generating_system, l, i, k, comb, real_center_comb;
            
            generating_system := [ ];
            
            l := Length( Indeterminates( R ) );
            l_Q := Length( GeneratingSystemOverQ( R ) );
            
            for j in [ 1 .. l_Q ] do
                generating_system[j] := ListWithIdenticalEntries( l + 1, Zero( RealCenter ) );
            od;
            
            j := 1;
            for k in [ 0 .. l ] do
                for comb in Combinations( [ 0 .. l-1 ], k ) do
                    if Length( comb ) mod 2 = 0 then
                        real_center_comb := comb;
                        index := 1;
                    else
                        real_center_comb := comb{ [ 2 .. Length( comb ) ] };
                        index := comb[1] + 2;
                    fi;
                    real_center_string := "1";
                    for i in [ 1 .. Length( real_center_comb ) / 2 ] do
                        real_center_string := Concatenation( real_center_string, "*e", String( real_center_comb[2*i-1] ), "e", String( real_center_comb[2*i] ) );
                    od;
                    generating_system[j][index] := real_center_string / RealCenter;
                    j := j + 1;
                od;
            od;
            
            return HomalgMatrix( generating_system, l_Q, l + 1, RealCenter );
            
        end;
            
        field := CoefficientsRing( ring );
        
        indets := IndeterminatesOfExteriorRing( ring );

        l := Length( indets );
        
        vars := [];
        vars_by_index := [];
        
        for i in [ 0 .. (l-1) ] do
            for j in [ (i+1) .. (l-1) ] do
                 Add( vars, Concatenation( "e", String(i), "e", String(j) ) );
                 Add( vars_by_index, [ i, j ] );
            od;
        od;

        ideal := [];
        for i in [ 1 .. Length( vars_by_index ) ] do
            var1 := vars_by_index[ i ];

            Add( ideal, Concatenation( "e", String(var1[1]), "e", String(var1[2]), "^2" ) );
            
            for j in [ (i+1) .. Length( vars_by_index ) ] do
                var2 := vars_by_index[ j ];

                if var1[1] = var2[1] then
                    result := "0";
                else
                    # var1[1] < var2[1]
                    if var2[1] < var1[2] then
                        if var2[2] < var1[2] then
                            result := Concatenation( "e", String(var1[1]), "e", String(var2[1]), "*e", String(var2[2]), "e", String(var1[2]) );
                        elif var2[2] = var1[2] then
                            result := "0";
                        else
                            # var2[2] > var1[2]
                            result := Concatenation( "-e", String(var1[1]), "e", String(var2[1]), "*e", String(var1[2]), "e", String(var2[2]) );
                        fi;
                    elif var2[1] = var1[2] then
                        result := "0";
                    else
                        # var2[1] > var1[2]
                        result := false;
                    fi;
                fi;
                
                if result <> false then
                    Add( ideal, Concatenation( "e", String(var1[1]), "e", String(var1[2]), "*e", String(var2[1]), "e", String(var2[2]), "-(", result, ")" ) );
                fi;
            od;
        od;
        
        # center
        C := HomalgQRingInSingular( field * JoinStringsWithSeparator( vars, "," ), ideal );
        RealCenter := C;
        
        Cfpres := LeftPresentations( C );
        Finalize( Cfpres );
        
        range_category := Cfpres;
        
        generating_system := Concatenation( [ One( ring ) ], indets );
        
        category!.generating_system := generating_system;
        
        generating_system_as_column := HomalgMatrix( generating_system, Length( generating_system ), 1, ring );
        
        category!.generating_system_as_column := generating_system_as_column;
        
        matrix_of_relations := GetMatrixOfRelationsOverRealCenter( ring, 1 );
        ring_as_module := AsLeftPresentation( matrix_of_relations );
        
        # C^{1 x 1}
        distinguished_object := FreeLeftPresentation( 1, C );
        
        generating_system_over_Q := GeneratingSystemOverQ( R );
        generating_system_over_Q_to_C_trafo_matrix := GeneratingSystemOverQToRealCenterTrafoMatrix( R );
        generating_system_over_Q_as_column := HomalgMatrix( generating_system_over_Q, Length( generating_system_over_Q ), 1, R );
        
        category!.generating_system_over_Q_to_C_trafo_matrix := generating_system_over_Q_to_C_trafo_matrix;
        category!.generating_system_over_Q_as_column := generating_system_over_Q_as_column;
        
        interpret_element_as_row_vector := function( r )
          local coefficients_over_Q, coefficients_over_real_center;
            #% CAP_JIT_RESOLVE_FUNCTION
            
            coefficients_over_Q := CoefficientsWithGivenMonomials( r, generating_system_over_Q_as_column );
            
            coefficients_over_C := (coefficients_over_Q * C) * generating_system_over_Q_to_C_trafo_matrix;
            
            return coefficients_over_C;
            
        end;
        
        morphism_constructor := PresentationMorphism;
        
        ring_inclusion := RingMap( List( vars_by_index, x -> indets[x[1] + 1] * indets[x[2] + 1] ), C, ring );
        
        matrix_access := UnderlyingMatrix;
        
    fi;
    
fi;
    
    ## Homomorphism structure for commutative rings, see https://arxiv.org/abs/1908.04132 (Sebastian Posur: Methods of constructive category theory), Example 1.24
    if HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        ##
        SetRangeCategoryOfHomomorphismStructure( category, category );
        SetIsEquippedWithHomomorphismStructure( category, true );
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category, { cat } -> RingAsCategoryUniqueObject( cat ) );
        
        ##
        AddHomomorphismStructureOnObjects( category, { cat, a, b } -> RingAsCategoryUniqueObject( cat ) );
        
        ##
        AddHomomorphismStructureOnMorphisms( category,
          function( cat, alpha, beta )
            local a, b, rows;
            
            a := UnderlyingRingElement( alpha );
            b := UnderlyingRingElement( beta );
            
            return RingAsCategoryMorphism( cat, a * b );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( cat, alpha )
            
            return alpha;
            
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( cat, a, b, mor )
            
            return mor;
            
        end );
        
        matrix_access := UnderlyingMatrix;
        
    fi;
    
    if generating_system <> fail then
        
        # set attributes
        MakeImmutable( generating_system );
        SetGeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure( category, generating_system );
        
        SetColumnVectorOfGeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure( category, generating_system_as_column );
        
        SetRingInclusionForHomomorphismStructure( category, ring_inclusion );
        
        Add( category!.compiler_hints.category_attribute_names, "GeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure" );
        Add( category!.compiler_hints.category_attribute_names, "ColumnVectorOfGeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure" );
        Add( category!.compiler_hints.category_attribute_names, "RingInclusionForHomomorphismStructure" );
        
        SetRangeCategoryOfHomomorphismStructure( category, CategoryOfRows( field ) );
        SetIsEquippedWithHomomorphismStructure( category, true );
        
        ##
        SetRangeCategoryOfHomomorphismStructure( category, range_category );
        
        if not ( HasIsProjective( distinguished_object ) and IsProjective( distinguished_object ) ) then
            
            Error( "distinguished object is not projective" );
            
        fi;
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category, { cat } -> distinguished_object( ) );
        
        ##
        AddHomomorphismStructureOnObjects( category, { cat, a, b } -> ring_as_module( ) );
        
        ##
        AddHomomorphismStructureOnMorphisms( category,
          function( cat, alpha, beta )
            local a, b, rows;
            
            a := UnderlyingRingElement( alpha );
            b := UnderlyingRingElement( beta );
            
            rows := List( generating_system, function( generator )
              local res, element;
                
                element := a * (generator * b);
                
                res := interpret_element_as_row_vector( element );
                
                return res;
                
            end );
            
            return morphism_constructor( range_category, ring_as_module( ), UnionOfRows( UnderlyingRing( range_category ), Length( generating_system ), rows ), ring_as_module( ) );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( cat, alpha )
            local decomposition;
            
            decomposition := interpret_element_as_row_vector( UnderlyingRingElement( alpha ) );
            
            return morphism_constructor( range_category, distinguished_object( ), decomposition, ring_as_module( ) );
            
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( cat, a, b, mor )
            local element;
            
            element := EntriesOfHomalgMatrix( Pullback( ring_inclusion, matrix_access( mor ) ) * generating_system_as_column )[1];
            
            return RingAsCategoryMorphism( category, element );
            
        end );
        
    fi;
    
    ## Random Methods
    
    AddRandomObjectByInteger( category,
      { cat, n } -> RingAsCategoryUniqueObject( cat ) );
    
    AddRandomMorphismWithFixedSourceAndRangeByInteger( category,
      { cat, S, R, n } ->  RingAsCategoryMorphism( cat, Sum( [ 1 .. n ], i -> Random( UnderlyingRing( cat ) ), Zero( UnderlyingRing( cat ) ) ) ) );
    
end );

####################################
##
## Convenience
##
####################################

InstallMethod( \*,
               [ IsRingAsCategoryMorphism, IsRingAsCategoryMorphism ],
               PreCompose );

InstallMethod( \=,
               [ IsRingAsCategoryMorphism, IsRingAsCategoryMorphism ],
               IsCongruentForMorphisms );

InstallOtherMethod( \/,
               [ IsRingElement, IsRingAsCategory ],
               RingAsCategoryMorphism );

####################################
##
## Down
##
####################################

##
InstallMethod( Down,
               [ IsRingAsCategoryObject ],
               UnderlyingRing );

##
InstallMethod( DownOnlyMorphismData,
               [ IsRingAsCategoryMorphism ],
               UnderlyingRingElement );
