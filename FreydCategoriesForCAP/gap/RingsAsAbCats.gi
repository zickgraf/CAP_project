#
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
    local ring, equality_func, homomorphism_structure_data, R_as_C_module, generating_system, interpret_element_as_row_vector, ring_map, range_category, C, distinguished_object, morphism_constructor, generating_system_as_column;
    
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

    homomorphism_structure_data := ValueOption("HomomorphismStructureOverSubringOfCenter");
    # TODO: pop?
    
    if homomorphism_structure_data <> fail then
        
        if not IsHomalgRing( ring ) then
            Error("the homomorphism structure can currently only be defined for homalg rings.");
        fi;

        if not IsList( homomorphism_structure_data ) or Length( homomorphism_structure_data ) <> 4 then
            Error("the option HomomorphismStructureOverSubringOfCenter must be a list of length 4.");
        fi;

        R_as_C_module := homomorphism_structure_data[1];
        generating_system := homomorphism_structure_data[2];
        interpret_element_as_row_vector := homomorphism_structure_data[3];
        ring_map := homomorphism_structure_data[4];
        
        if IsLeftPresentation( R_as_C_module ) then
            
            range_category := CapCategory( R_as_C_module );

            C := range_category!.ring_for_representation_category;
            
            # C^{1 x 1}
            distinguished_object := FreeLeftPresentation( 1, C );

            morphism_constructor := PresentationMorphism;
            
        elif IsVectorSpaceObject( R_as_C_module ) then
            
            range_category := CapCategory( R_as_C_module );

            C := UnderlyingFieldForHomalg( R_as_C_module );
            
            # C^{1 x 1}
            distinguished_object := VectorSpaceObject( 1, C );
            
            morphism_constructor := VectorSpaceMorphism;
            
        else
            Error("the first entry of the data defining the homomorphism structure must be an object in a category of left presentations or in a matrix category.");
        fi;

        if not IsList( generating_system ) or not ForAll( generating_system, x -> IsHomalgRingElement( x ) ) then
            Error("the second entry of the data defining the homomorphism structure must be a dense list of homalg ring elements.");
        fi;

        if not IsHomalgRingMap( ring_map ) then
            Error("the fourth entry of the data defining the homomorphism structure must be a homalg ring map.");
        fi;
        
        if not IsHomalgRing( C ) or not IsCommutative( C ) then
            Error("the ring over which the homorphism structure should be defined must be a commutative homalg ring.");
        fi;

        generating_system_as_column := HomalgMatrix( generating_system, Length( generating_system ), 1, ring );
        
        ##
        SetRangeCategoryOfHomomorphismStructure( category, range_category );

        ##
        AddDistinguishedObjectOfHomomorphismStructure( category, {} -> distinguished_object );
        
        ##
        AddHomomorphismStructureOnObjects( category, {a,b} -> R_as_C_module );
        
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

            return morphism_constructor( R_as_C_module, UnionOfRows( rows ), R_as_C_module );
        
        end );
        
        ##
        AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( category,
          function( alpha )
            local decomposition;

              decomposition := interpret_element_as_row_vector( UnderlyingRingElement( alpha ) );
              
              return morphism_constructor( distinguished_object, decomposition, R_as_C_module );
        end );
        
        ##
        AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( category,
          function( a, b, mor )
            local element;
              
              element := EntriesOfHomalgMatrix( Pullback( ring_map, UnderlyingMatrix( mor ) ) * generating_system_as_column )[1];
              
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
