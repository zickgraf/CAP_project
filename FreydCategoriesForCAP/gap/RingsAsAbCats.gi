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
               
  function( ring )
    local finalize_option, category;
    
    finalize_option := CAP_INTERNAL_RETURN_OPTION_OR_DEFAULT( "FinalizeCategory", true );
    
    category := CreateCapCategory( Concatenation( "Ring as category( ", String( ring )," )" ) );
    
    SetFilterObj( category, IsRingAsCategory );
    
    SetUnderlyingRing( category, ring );
    
    SetIsAbCategory( category, true );
    
    AddObjectRepresentation( category, IsRingAsCategoryObject );
    
    AddMorphismRepresentation( category, IsRingAsCategoryMorphism and HasUnderlyingRingElement );
    
    INSTALL_FUNCTIONS_FOR_RING_AS_CATEGORY( category );
    
    if finalize_option then
        
        Finalize( category );
        
    fi;
    
    return category;
    
end );

##
InstallMethod( RingAsCategoryUniqueObject,
               [ IsRingAsCategory ],
               
  function( category )
    
    return ObjectifyObjectForCAPWithAttributes( rec( ),
                                                category
    );
    
end );

##
InstallMethod( RingAsCategoryMorphismOp,
               [ IsRingAsCategory, IsObject ],
               
  function( category, element )
    local unique_object;
    #% CAP_JIT_RESOLVE_FUNCTION
    
    unique_object := RingAsCategoryUniqueObject( category );
    
    ## this is a "compiled" version of ObjectifyMorphismForCAPWithAttributes
    return ObjectifyWithAttributes( rec(), category!.morphism_type,
                                    Source, unique_object,
                                    Range, unique_object,
                                    UnderlyingRingElement, element,
                                    CapCategory, category
    );
    
end );

##
InstallOtherMethod( RingAsCategoryMorphism,
               [ IsObject, IsRingAsCategory ],
               
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

##
InstallMethod( ViewObj,
               [ IsRingAsCategoryMorphism ],
               
    function( alpha )
        
        Print( ViewString( alpha ) );
        
end );

##
InstallMethod( ViewObj,
               [ IsRingAsCategoryObject ],
               
    function( obj )
        
        Print( ViewString( obj ) );
        
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
    AddIsEqualForObjects( category, ReturnTrue );
    
    equality_func := {alpha, beta} -> UnderlyingRingElement( alpha ) = UnderlyingRingElement( beta );
    
    ##
    AddIsEqualForMorphisms( category, equality_func );
    
    ##
    AddIsCongruentForMorphisms( category, equality_func );
    
    ##
    AddIsWellDefinedForObjects( category, x -> IsIdenticalObj( category, CapCategory( x ) ) );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( alpha )
        
        return UnderlyingRingElement( alpha ) in UnderlyingRing( category );
        
    end );
    
    ##
    AddPreCompose( category,
      function( alpha, beta )
        
        return RingAsCategoryMorphism(
            category,
            UnderlyingRingElement( alpha ) * UnderlyingRingElement( beta )
        );
        
    end );
    
    ##
    AddIdentityMorphism( category,
      function( unique_object )
        
        return RingAsCategoryMorphism(
            category,
            One( ring )
        );
        
    end );
    
    ##
    AddIsOne( category,
      function( alpha )
        
        return IsOne( UnderlyingRingElement( alpha ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( a, b )
        
        return RingAsCategoryMorphism(
            category,
            Zero( ring )
        );
        
    end );
    
    ##
    AddIsZeroForMorphisms( category,
      function( alpha )
        
        return IsZero( UnderlyingRingElement( alpha ) );
        
    end );
    
    ##
    AddAdditionForMorphisms( category,
      function( alpha, beta )
        
        return RingAsCategoryMorphism(
            category,
            UnderlyingRingElement( alpha ) + UnderlyingRingElement( beta )
        );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( alpha )
        
        return RingAsCategoryMorphism(
            category,
            - UnderlyingRingElement( alpha )
        );
        
    end );

    ## Homomorphism structure
    
    range_category := fail;
    
if true then
    ## Homomorphism structure for homalg exterior rings over fields
    if IsHomalgRing( ring ) and HasIsExteriorRing( ring ) and IsExteriorRing( ring ) and IsField( CoefficientsRing( ring ) ) then
        
        LoadPackage( "LazyCategories" );
        
        field := CoefficientsRing( ring );
        
        SetInfoLevel( ValueGlobal( "InfoLazyCategory" ), 1000 );

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
        
        #ring_as_module := AsObjectInLazyCategory( range_category, CategoryOfRowsObjectOp( Qrows, Length( generating_system ) ) );
        ring_as_module := CategoryOfRowsObjectOp( Qrows, Length( generating_system ) );
        
        # field^{1 x 1}
        #distinguished_object := AsObjectInLazyCategory( range_category, CategoryOfRowsObjectOp( Qrows, 1 ) );
        distinguished_object := CategoryOfRowsObjectOp( Qrows, 1 );
        
        interpret_element_as_row_vector := function( r )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return CoefficientsWithGivenMonomials( HomalgMatrix( [ r ], 1, 1, ring ), generating_system_as_column ) * field;
            
        end;
        
        #morphism_constructor := {source, matrix, range} -> AsMorphismInLazyCategory( source, CategoryOfRowsMorphism( EvaluatedCell( source ), matrix, EvaluatedCell( range ) ), range );
        morphism_constructor := CategoryOfRowsMorphism;
        
        ring_inclusion := RingMap( [], field, ring );

        #matrix_access := mor -> UnderlyingMatrix( EvaluatedCell( mor ) );
        matrix_access := UnderlyingMatrix;
        
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
    
    ## Homomorphism structure for commutative homalg rings
    if IsHomalgRing( ring ) and HasIsCommutative( ring ) and IsCommutative( ring ) then
        
        range_category := CategoryOfRows( ring );
        
        generating_system := [ One( ring ) ];
        
        generating_system_as_column := HomalgMatrix( generating_system, Length( generating_system ), 1, ring );
        
        ring_as_module := CategoryOfRowsObjectOp( range_category, Length( generating_system ) );
        
        # ring^{1 x 1}
        distinguished_object := CategoryOfRowsObjectOp( range_category, 1 );
        
        interpret_element_as_row_vector := function( r )
            #% CAP_JIT_RESOLVE_FUNCTION
            
            return HomalgMatrix( [ r ], 1, 1, ring );
            
        end;
        
        morphism_constructor := CategoryOfRowsMorphism;
        
        # identity
        ring_inclusion := RingMap( ring );
        
        matrix_access := UnderlyingMatrix;
        
    fi;
    
    if range_category <> fail then
        
        ##
        SetRangeCategoryOfHomomorphismStructure( category, range_category );
        
        ##
        AddDistinguishedObjectOfHomomorphismStructure( category, {} -> distinguished_object );
        
        ##
        AddHomomorphismStructureOnObjects( category, {a,b} -> ring_as_module );
        
        ##
        AddHomomorphismStructureOnMorphismsWithGivenObjects( category,
          function( source, alpha, beta, range )
            local a, b, rows;
            
            a := UnderlyingRingElement( alpha );
            b := UnderlyingRingElement( beta );
            
            rows := List( generating_system, function( generator )
              local res, element;
                
                element := a * (generator * b);
                
                res := interpret_element_as_row_vector( element );
                
                return res;
                
            end );
            
            return morphism_constructor( ring_as_module, UnionOfRows( rows ), ring_as_module );
            
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( alpha )
            local decomposition;
            
            decomposition := interpret_element_as_row_vector( UnderlyingRingElement( alpha ) );
            
            return morphism_constructor( distinguished_object, decomposition, ring_as_module );
            
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( a, b, mor )
            local element;
            
            element := EntriesOfHomalgMatrix( Pullback( ring_inclusion, matrix_access( mor ) ) * generating_system_as_column )[1];
            
            return RingAsCategoryMorphism( category, element );
            
        end );
        
    fi;
    
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

InstallMethod( \/,
               [ IsObject, IsRingAsCategory ],
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
