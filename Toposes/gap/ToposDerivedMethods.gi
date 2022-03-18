# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( DirectProductOnMorphismsWithGivenDirectProducts,
  function( cat, s, alpha, beta, r )
    
    return DirectProductFunctorialWithGivenDirectProducts(
                   cat,
                   s,
                   [ Source( alpha ), Source( beta ) ],
                   [ alpha, beta ],
                   [ Range( alpha ), Range( beta ) ],
                   r );
    
end : Description := "TensorProductOnMorphisms is DirectProductFunctorial",
      CategoryFilter := IsCartesianCategory );

##
AddDerivationToCAP( CoproductOnMorphismsWithGivenCoproducts,
  function( cat, s, alpha, beta, r )
    
    return CoproductFunctorialWithGivenCoproducts(
                   cat,
                   s,
                   [ Source( alpha ), Source( beta ) ],
                   [ alpha, beta ],
                   [ Range( alpha ), Range( beta ) ],
                   r );
    
end : Description := "CoproductOnMorphisms is CoproductFunctorial",
      CategoryFilter := IsCocartesianCategory );

##
AddDerivationToCAP( CartesianLeftUnitorWithGivenDirectProduct,
  function( cat, a, s )
    
    return ProjectionInFactorOfDirectProductWithGivenDirectProduct(
                   [ TerminalObject( cat ), a ],
                   2,
                   s );
    
end : Description := "CartesianLeftUnitorWithGivenDirectProduct using the projection onto the second factor of the direct product");

##
AddDerivationToCAP( CartesianRightUnitorWithGivenDirectProduct,
  function( cat, a, s )
    
    return ProjectionInFactorOfDirectProductWithGivenDirectProduct(
                   [ a, TerminalObject( cat ) ],
                   1,
                   s );
    
end : Description := "CartesianRightUnitorWithGivenDirectProduct using the projection onto the first factor of the direct product");

##
AddDerivationToCAP( CartesianAssociatorRightToLeftWithGivenDirectProducts,
  function( cat, s, a, b, c, r )
    local Db_c, bc, pi_b, pi_c, Da_bc, pi_a, pi_bc, Da_b, ab, pi_ab;
    
    Db_c := [ b, c ];
    
    bc := DirectProduct( cat, Db_c );
    
    pi_b := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Db_c, 1, bc );
    pi_c := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Db_c, 2, bc );
    
    Da_bc := [ a, bc ];
    
    pi_a := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Da_bc, 1, s );
    pi_bc := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Da_bc, 2, s );
    
    Da_b := [ a, b ];
    
    ab := DirectProduct( cat, Da_b );
    
    pi_ab := UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, Da_b, s, [ pi_a, PreCompose( cat, pi_bc, pi_b ) ], ab );
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, [ ab, c ], s, [ pi_ab, PreCompose( cat, pi_bc, pi_c ) ], r );
    
end : Description := "CartesianAssociatorRightToLeftOfDirectProductsWithGivenDirectProducts using the universal morphism into direct product");

##
AddDerivationToCAP( CartesianAssociatorLeftToRightWithGivenDirectProducts,
  function( cat, s, a, b, c, r )
    local Da_b, ab, pi_a, pi_b, Dab_c, pi_ab, pi_c, Db_c, bc, pi_bc;
    
    Da_b := [ a, b ];
    
    ab := DirectProduct( cat, Da_b );
    
    pi_a := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Da_b, 1, ab );
    pi_b := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Da_b, 2, ab );
    
    Dab_c := [ ab, c ];
    
    pi_ab := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Dab_c, 1, s );
    pi_c := ProjectionInFactorOfDirectProductWithGivenDirectProduct( cat, Dab_c, 2, s );
    
    Db_c := [ b, c ];
    
    bc := DirectProduct( cat, Db_c );
    
    pi_bc := UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, Db_c, s, [ PreCompose( cat, pi_ab, pi_b ), pi_c ], bc );
    
    return UniversalMorphismIntoDirectProductWithGivenDirectProduct( cat, [ a, bc ], s, [ PreCompose( cat, pi_ab, pi_a ), pi_bc ], r );
    
end : Description := "CartesianAssociatorLeftToRightWithGivenDirectProducts using the universal morphism into direct product");

##
AddDerivationToCAP( CocartesianLeftUnitorInverseWithGivenCoproduct,
  function( cat, a, r )
    
    return InjectionOfCofactorOfCoproductWithGivenCoproduct(
                   [ InitialObject( cat ), a ],
                   2,
                   r );
    
end : Description := "CocartesianLeftUnitorInverseWithGivenCoproduct using the injection into the second factor of the coproduct");

##
AddDerivationToCAP( CocartesianRightUnitorInverseWithGivenCoproduct,
  function( cat, a, r )
    
    return InjectionOfCofactorOfCoproductWithGivenCoproduct(
                   [ a, InitialObject( cat ) ],
                   1,
                   r );
    
end : Description := "CocartesianRightUnitorInverseWithGivenCoproduct using the injection into the first factor of the coproduct");

##
AddDerivationToCAP( CocartesianAssociatorLeftToRightWithGivenCoproducts,
  function( cat, s, a, b, c, r )
    local Db_c, bc, iota_b, iota_c, Da_bc, iota_a, iota_bc, Da_b, ab, iota_ab;
    
    Db_c := [ b, c ];
    
    bc := Coproduct( cat, Db_c );
    
    iota_b := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Db_c, 1, bc );
    iota_c := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Db_c, 2, bc );
    
    Da_bc := [ a, bc ];
    
    iota_a := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Da_bc, 1, r );
    iota_bc := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Da_bc, 2, r );
    
    Da_b := [ a, b ];
    
    ab := Coproduct( cat, Da_b );
    
    iota_ab := UniversalMorphismFromCoproductWithGivenCoproduct( cat, Da_b, r, [ iota_a, PreCompose( cat, iota_b, iota_bc ) ], ab );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( cat, [ ab, c ], r, [ iota_ab, PreCompose( cat, iota_c, iota_bc ) ], s );
    
end : Description := "CocartesianAssociatorLeftToRightWithGivenCoproducts using the universal morphism from coproduct");

##
AddDerivationToCAP( CocartesianAssociatorRightToLeftWithGivenCoproducts,
  function( cat, s, a, b, c, r )
    local Da_b, ab, iota_a, iota_b, Dab_c, iota_ab, iota_c, Db_c, bc, iota_bc;
    
    Da_b := [ a, b ];
    
    ab := Coproduct( cat, Da_b );
    
    iota_a := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Da_b, 1, ab );
    iota_b := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Da_b, 2, ab );
    
    Dab_c := [ ab, c ];
    
    iota_ab := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Dab_c, 1, r );
    iota_c := InjectionOfCofactorOfCoproductWithGivenCoproduct( cat, Dab_c, 2, r );
    
    Db_c := [ b, c ];
    
    bc := Coproduct( cat, Db_c );
    
    iota_bc := UniversalMorphismFromCoproductWithGivenCoproduct( cat, Db_c, r, [ PreCompose( cat, iota_b, iota_ab ), iota_c ], bc );
    
    return UniversalMorphismFromCoproductWithGivenCoproduct( cat, [ a, bc ], r, [ PreCompose( cat, iota_a, iota_ab ), iota_bc ], s );
    
end : Description := "CocartesianAssociatorRightToLeftWithGivenCoproducts using the universal morphism from coproduct");

##
AddDerivationToCAP( SubobjectOfClassifyingMorphism,
                    [ [ TruthMorphismOfTrueWithGivenObjects , 1 ],
                      [ ProjectionInFactorOfFiberProduct , 1 ] ],
  function( cat, mor )
    local truth;
    
    truth := TruthMorphismOfTrueWithGivenObjects(
                     cat,
                     TerminalObject( cat ),
                     SubobjectClassifier( cat ) );
    
    return ProjectionInFactorOfFiberProduct( cat, [ mor, truth ], 1 );
    
end : Description := "SubobjectOfClassifyingMorphism using the fiber product along the true morphism" );

##
AddDerivationToCAP( CartesianSquareOfSubobjectClassifier,
  function( cat )
    local Omega;
    
    Omega := SubobjectClassifier( cat );
    
    return DirectProduct( cat, [ Omega, Omega ] );
    
end );

##
AddDerivationToCAP( TruthMorphismOfTrueWithGivenObjects,
  function( cat, T, Omega )
    
    return ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier(
                   cat,
                   IdentityMorphism( cat, T ),
                   Omega );
    
end );

##
AddDerivationToCAP( TruthMorphismOfFalseWithGivenObjects,
  function( cat, T, Omega )
    
    return ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier(
                   cat,
                   UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat, InitialObject( cat ), T ),
                   Omega );
    
end );

##
AddDerivationToCAP( TruthMorphismOfNotWithGivenObjects,
  function( cat, Omega, Omega1 )
    local T;
    
    T := TerminalObject( cat );
    
    return ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier(
                   cat,
                   PreCompose(
                           cat,
                           UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat, Omega, T ),
                           TruthMorphismOfFalseWithGivenObjects( cat, T, Omega ) ),
                   Omega );
    
end );

##
AddDerivationToCAP( TruthMorphismOfAndWithGivenObjects,
  function( cat, Omega2, Omega )
    local T, t;
    
    T := TerminalObject( cat );
    
    t := TruthMorphismOfTrueWithGivenObjects( cat, T, Omega );
    
    return ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier(
                   cat,
                   UniversalMorphismIntoDirectProductWithGivenDirectProduct(
                           cat,
                           [ Omega, Omega ],
                           T,
                           [ t, t ],
                           Omega2 ),
                   Omega );
    
end );

##
AddDerivationToCAP( TruthMorphismOfOrWithGivenObjects,
  function( cat, Omega2, Omega )
    local T, t, id, left, right;
    
    T := TerminalObject( cat );
    
    ## Ω → 1 → Ω
    t := PreCompose(
                 cat,
                 UniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat, Omega, T ),
                 TruthMorphismOfTrueWithGivenObjects( cat, T, Omega ) );
    
    id := IdentityMorphism( cat, Omega );
    
    left := UniversalMorphismIntoDirectProductWithGivenDirectProduct(
                    cat,
                    [ Omega, Omega ],
                    Omega,
                    [ t, id ],
                    Omega2 );
    
    right := UniversalMorphismIntoDirectProductWithGivenDirectProduct(
                     cat,
                     [ Omega, Omega ],
                     Omega,
                     [ id, t ],
                     Omega2 );
    
    return ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier(
                   cat,
                   UniversalMorphismFromCoproduct(
                           cat,
                           [ Omega, Omega ],
                           Omega2,
                           [ left, right ] ),
                   Omega );
    
end );

##
AddDerivationToCAP( TruthMorphismOfImpliesWithGivenObjects,
  function( cat, Omega2, Omega )
    
    return ClassifyingMorphismOfSubobjectWithGivenSubobjectClassifier(
                   cat,
                   EmbeddingOfEqualizer(
                           cat,
                           [ TruthMorphismOfAndWithGivenObjects( cat, Omega2, Omega ),
                             ProjectionInFactorOfDirectProductWithGivenDirectProduct(
                                     cat,
                                     [ Omega, Omega ],
                                     1,
                                     Omega2
                                     ) ] ),
                   Omega );
    
end );

##
AddDerivationToCAP( PseudoComplementSubobject,
  function( cat, iota )
    
    return Source( EmbeddingOfPseudoComplementSubobject( cat, iota ) );
    
end );

##
AddDerivationToCAP( EmbeddingOfPseudoComplementSubobject,
  function( cat, iota ) # ι: S → M
    
    return SubobjectOfClassifyingMorphism( ## -ι: (S - M) → M
                   cat,
                   PreCompose(
                           cat,
                           ClassifyingMorphismOfSubobject( cat, iota ), ## χ_ι: Range( ι ) → Ω
                           TruthMorphismOfNot( cat ) ## ¬: Ω → Ω
                           ) );
    
end );

##
AddDerivationToCAP( IntersectionSubobject,
  function( cat, iota1, iota2 )
    
    return Source( EmbeddingOfIntersectionSubobject( cat, iota1, iota2 ) );
    
end );

##
AddDerivationToCAP( EmbeddingOfIntersectionSubobject,
  function( cat, iota1, iota2 )
    local Omega;
    
    Omega := SubobjectClassifier( cat );
    
    return SubobjectOfClassifyingMorphism( ## -ι
                   cat,
                   PreCompose(
                           UniversalMorphismIntoDirectProduct( ## Range( ι1 ) = Range( ι2 ) → Ω × Ω
                                   cat,
                                   [ Omega, Omega ],
                                   Range( iota1 ),
                                   [ ClassifyingMorphismOfSubobject( cat, iota1 ), ## χ_ι1
                                     ClassifyingMorphismOfSubobject( cat, iota2 ) ] ), ## χ_ι2
                           TruthMorphismOfAnd( cat ) ## ∧: Ω × Ω → Ω
                           ) );
    
end );

## This is [Glodblatt 1984: Topoi - The categorical analysis of logic, Theorem 7.1.2]
AddDerivationToCAP( EmbeddingOfIntersectionSubobject,
  function( cat, iota1, iota2 )
    
    return MorphismFromFiberProductToSink( cat, [ iota1, iota2 ] );
    
end );

##
AddDerivationToCAP( UnionSubobject,
  function( cat, iota1, iota2 )
    
    return Source( EmbeddingOfUnionSubobject( cat, iota1, iota2 ) );
    
end );

##
AddDerivationToCAP( EmbeddingOfUnionSubobject,
  function( cat, iota1, iota2 )
    local Omega;
    
    Omega := SubobjectClassifier( cat );
    
    return SubobjectOfClassifyingMorphism( ## -ι
                   cat,
                   PreCompose(
                           UniversalMorphismIntoDirectProduct( ## Range( ι1 ) = Range( ι2 ) → Ω × Ω
                                   cat,
                                   [ Omega, Omega ],
                                   Range( iota1 ),
                                   [ ClassifyingMorphismOfSubobject( cat, iota1 ), ## χ_ι1
                                     ClassifyingMorphismOfSubobject( cat, iota2 ) ] ), ## χ_ι2
                           TruthMorphismOfOr( cat ) ## ∨: Ω × Ω → Ω
                           ) );
    
end );

## This is [Glodblatt 1984: Topoi - The categorical analysis of logic, Theorem 7.1.3]
AddDerivationToCAP( EmbeddingOfUnionSubobject,
  function( cat, iota1, iota2 )
    
    return ImageEmbedding(
                   cat,
                   UniversalMorphismFromCoproduct(
                           cat,
                           [ Source( iota1 ), Source( iota2 ) ],
                           Range( iota1 ),
                           [ iota1, iota2 ] ) );  ## [ ι1, ι2 ] : Source( ι1 ) ⊔ Source( ι2 ) → Range( ι1 )
    
end );

##
AddDerivationToCAP( RelativePseudoComplementSuboject,
  function( cat, iota1, iota2 )
    
    return Source( EmbeddingOfRelativePseudoComplementSuboject( cat, iota1, iota2 ) );
    
end );

##
AddDerivationToCAP( EmbeddingOfRelativePseudoComplementSuboject,
  function( cat, iota1, iota2 )
    local Omega;
    
    Omega := SubobjectClassifier( cat );
    
    return SubobjectOfClassifyingMorphism( ## -ι
                   cat,
                   PreCompose(
                           cat,
                           UniversalMorphismIntoDirectProduct( ## Range( ι1 ) = Range( ι2 ) → Ω × Ω
                                   cat,
                                   [ Omega, Omega ],
                                   Range( iota1 ),
                                   [ ClassifyingMorphismOfSubobject( cat, iota1 ), ## χ_ι1
                                     ClassifyingMorphismOfSubobject( cat, iota2 ) ] ), ## χ_ι2
                           TruthMorphismOfImplies( cat ) ## ⇒: Ω × Ω → Ω
                           ) );
    
end );

## Final derivations

##
AddFinalDerivation( CanonicalIdentificationFromImageObjectToCoimage,
                    [ [ ImageObject, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    [ CanonicalIdentificationFromCoimageToImageObject,
                      CanonicalIdentificationFromImageObjectToCoimage,
                      Coimage,
                      CoimageProjection,
                      CoimageProjectionWithGivenCoimage,
                      AstrictionToCoimage,
                      AstrictionToCoimageWithGivenCoimage,
                      UniversalMorphismIntoCoimage,
                      UniversalMorphismIntoCoimageWithGivenCoimage,
                      IsomorphismFromCoimageToCokernelOfKernel,
                      IsomorphismFromCokernelOfKernelToCoimage ],
                    
  function( cat, mor )
    
    return IdentityMorphism( cat, ImageObject( cat, mor ) );
    
  end,
  [
    CanonicalIdentificationFromCoimageToImageObject,
    function( cat, mor )
    
      return IdentityMorphism( cat, ImageObject( cat, mor ) );
    
    end
  ] : CategoryFilter := HasIsElementaryTopos and IsElementaryTopos );
