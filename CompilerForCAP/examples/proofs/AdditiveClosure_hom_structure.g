LoadPackage( "FreydCategoriesForCAP" : OnlyNeeded );
LoadPackage( "CompilerForCAP" : OnlyNeeded );

CapJitEnableProofAssistantMode( );

dummy_range := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsWellDefinedForMorphisms",
		"IsCongruentForMorphisms",
		"IdentityMorphism",
		"PreCompose",
		"DirectSum",
		"ProjectionInFactorOfDirectSum",
		"UniversalMorphismIntoDirectSum",
		"MorphismBetweenDirectSums",
    ],
    properties := [
        "IsAdditiveCategory",
    ],
) : FinalizeCategory := false );
AddMorphismBetweenDirectSums( dummy_range, { cat, source_diagram, matrix, target_diagram } -> fail );
Finalize( dummy_range );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy_range );

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsWellDefinedForMorphisms",
		"IsCongruentForMorphisms",
		"IdentityMorphism",
		"ZeroMorphism",
    ],
    properties := [
		"IsAbCategory",
    ],
) : FinalizeCategory := false );
SetRangeCategoryOfHomomorphismStructure( dummy, dummy_range );
AddHomomorphismStructureOnObjects( dummy, { cat, A, B } -> fail );
AddHomomorphismStructureOnMorphisms( dummy, { cat, alpha, beta } -> fail );
AddDistinguishedObjectOfHomomorphismStructure( dummy, { cat } -> fail );
AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( dummy, { cat, alpha } -> fail );
AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( dummy, { cat, source, target, alpha } -> fail );
Finalize( dummy );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

cat := AdditiveClosure( dummy );

SetCurrentCategory( cat, "the additive closure of a pre-additive category" );

Assert( 0, HasRangeCategoryOfHomomorphismStructure( cat ) and RangeCategoryOfHomomorphismStructure( cat ) = dummy_range );
Assert( 0, CanCompute( cat, "HomomorphismStructureOnObjects" ) );
Assert( 0, CanCompute( cat, "HomomorphismStructureOnMorphisms" ) );
Assert( 0, CanCompute( cat, "DistinguishedObjectOfHomomorphismStructure" ) );
Assert( 0, CanCompute( cat, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) );
Assert( 0, CanCompute( cat, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) );



proposition := function ( cat, A, B )
    
    return IsCongruentForMorphisms( RangeCategoryOfHomomorphismStructure( cat ),
		HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), IdentityMorphism( cat, B ) ),
		IdentityMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) )
	);
    
end;
result := StateLemma( proposition, cat, [ "category", "object", "object" ] );
