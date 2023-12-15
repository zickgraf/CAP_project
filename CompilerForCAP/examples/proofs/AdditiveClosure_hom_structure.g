LoadPackage( "FreydCategoriesForCAP", false : OnlyNeeded );

dummy_range := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsWellDefinedForObjects",
        "IsWellDefinedForMorphismsWithGivenSourceAndRange",
        "IsEqualForObjects",
        "IsCongruentForMorphisms",
        "PreCompose",
        "PreComposeList",
        "IdentityMorphism",
        "AdditionForMorphisms",
        "SumOfMorphisms",
        "ZeroMorphism",
        "DirectSum",
        "ProjectionInFactorOfDirectSum",
        "UniversalMorphismIntoDirectSum",
        "ComponentOfMorphismIntoDirectSum",
        "InjectionOfCofactorOfDirectSum",
        "UniversalMorphismFromDirectSum",
        "ComponentOfMorphismFromDirectSum",
        "MorphismBetweenDirectSums",
    ],
    properties := [
        "IsAdditiveCategory",
    ],
) : FinalizeCategory := false );
AddMorphismBetweenDirectSums( dummy_range, { cat, source_diagram, matrix, target_diagram } -> fail );
Finalize( dummy_range );

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsWellDefinedForObjects",
        "IsWellDefinedForMorphismsWithGivenSourceAndRange",
        "IsEqualForObjects",
        "IsCongruentForMorphisms",
        "PreCompose",
        "PreComposeList",
        "IdentityMorphism",
        "AdditionForMorphisms",
        "SumOfMorphisms",
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

cat := AdditiveClosure( dummy );

# set a human readable name
cat!.Name := "the additive closure of a pre-additive category with a homomorphism structure in an additive category";

Assert( 0, HasRangeCategoryOfHomomorphismStructure( cat ) and RangeCategoryOfHomomorphismStructure( cat ) = dummy_range );
Assert( 0, CanCompute( cat, "HomomorphismStructureOnObjects" ) );
Assert( 0, CanCompute( cat, "HomomorphismStructureOnMorphisms" ) );
Assert( 0, CanCompute( cat, "DistinguishedObjectOfHomomorphismStructure" ) );
Assert( 0, CanCompute( cat, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) );
Assert( 0, CanCompute( cat, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) );

LoadPackage( "CompilerForCAP", false : OnlyNeeded );

CapJitEnableProofAssistantMode( );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy_range );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

StateProposition( cat, "is_equipped_with_hom_structure" );

# DistinguishedObjectOfHomomorphismStructure is well-defined
StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

AssertLemma( );

# HomomorphismStructureOnObjects is well-defined
StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

AssertLemma( );

# HomomorphismStructureOnMorphisms is well-defined
StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

AssertLemma( );

# HomomorphismStructureOnMorphisms preserves identities
StateNextLemma( );

# check congruence with identity on direct sum componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "list" ],
        src_template := "IsCongruentForMorphisms( cat, morphism, IdentityMorphism( cat, DirectSum( cat, list ) ) )",
        dst_template := "ForAll( [ 1 .. Length( list ) ], i -> ForAll( [ 1 .. Length( list ) ], j -> IsCongruentForMorphisms( cat, PreComposeList( cat, list[i], [ InjectionOfCofactorOfDirectSum( cat, list, i ), morphism, ProjectionInFactorOfDirectSum( cat, list, j ) ], list[j] ), CAP_JIT_INTERNAL_EXPR_CASE( i = j, IdentityMorphism( cat, list[i] ), true, ZeroMorphism( cat, list[i], list[j] ) ) ) ) )",
        new_funcs := [ [ "i" ], [ "j"] ],
    )
);

# injection * morphism_between_direct_sum * projection selects a component
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list", "i", "j", "matrix", "source", "target" ],
        src_template := "PreComposeList( cat, source, [ InjectionOfCofactorOfDirectSum( cat, list, i ), MorphismBetweenDirectSums( cat, list, matrix, list ), ProjectionInFactorOfDirectSum( cat, list, j ) ], target )",
        dst_template := "matrix[i][j]",
    )
);

# pull equality into case distinction
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "P", "case1", "case2" ],
        src_template := "IsCongruentForMorphisms( cat, morphism, CAP_JIT_INTERNAL_EXPR_CASE( P, case1, true, case2 ) )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, IsCongruentForMorphisms( cat, morphism, case1 ), true, IsCongruentForMorphisms( cat, morphism, case2 ) )",
    )
);

# replace j by i in the if case
ApplyLogicTemplate(
    rec(
        variable_names := [ "case1", "case2", "i" ],
        src_template := "j -> CAP_JIT_INTERNAL_EXPR_CASE( i = j, case1, true, case2 )",
        dst_template := "x -> CAP_JIT_INTERNAL_EXPR_CASE( i = x, (j -> case1)(i), true, (j -> case2)(x) )",
        new_funcs := [ [ "x" ] ],
    )
);

# check congruence with identity on direct sum componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "list" ],
        src_template := "IsCongruentForMorphisms( cat, morphism, IdentityMorphism( cat, DirectSum( cat, list ) ) )",
        dst_template := "ForAll( [ 1 .. Length( list ) ], i -> ForAll( [ 1 .. Length( list ) ], j -> IsCongruentForMorphisms( cat, PreComposeList( cat, list[i], [ InjectionOfCofactorOfDirectSum( cat, list, i ), morphism, ProjectionInFactorOfDirectSum( cat, list, j ) ], list[j] ), CAP_JIT_INTERNAL_EXPR_CASE( i = j, IdentityMorphism( cat, list[i] ), true, ZeroMorphism( cat, list[i], list[j] ) ) ) ) )",
        new_funcs := [ [ "i" ], [ "j"] ],
    )
);

# injection * morphism_between_direct_sum * projection selects a component
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list", "i", "j", "matrix", "source", "target" ],
        src_template := "PreComposeList( cat, source, [ InjectionOfCofactorOfDirectSum( cat, list, i ), MorphismBetweenDirectSums( cat, list, matrix, list ), ProjectionInFactorOfDirectSum( cat, list, j ) ], target )",
        dst_template := "matrix[i][j]",
    )
);

# pull equality into case distinction
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "P", "case1", "case2" ],
        src_template := "IsCongruentForMorphisms( cat, morphism, CAP_JIT_INTERNAL_EXPR_CASE( P, case1, true, case2 ) )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, IsCongruentForMorphisms( cat, morphism, case1 ), true, IsCongruentForMorphisms( cat, morphism, case2 ) )",
    )
);

# hom structure on identities in the underlying category
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), IdentityMorphism( cat, B ) )",
        dst_template := "IdentityMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) )",
    )
);

# hom structure on identity and zero in the underlying category
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "C" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), ZeroMorphism( cat, B, C ) )",
        dst_template := "ZeroMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ), HomomorphismStructureOnObjects( cat, A, C ) )",
    )
);

# check congruence with zero morphism on direct sum componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "list1", "list2" ],
        src_template := "IsCongruentForMorphisms( cat, morphism, ZeroMorphism( cat, DirectSum( cat, list1 ), DirectSum( cat, list2 ) ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], k -> ForAll( [ 1 .. Length( list2 ) ], l -> IsCongruentForMorphisms( cat, PreComposeList( cat, list1[k], [ InjectionOfCofactorOfDirectSum( cat, list1, k ), morphism, ProjectionInFactorOfDirectSum( cat, list2, l ) ], list2[l] ), ZeroMorphism( cat, list1[k], list2[l] ) ) ) )",
        new_funcs := [ [ "k" ], [ "l"] ],
    )
);

# injection * morphism_between_direct_sum * projection selects a component
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "k", "l", "matrix", "source", "target" ],
        src_template := "PreComposeList( cat, source, [ InjectionOfCofactorOfDirectSum( cat, list1, k ), MorphismBetweenDirectSums( cat, list1, matrix, list2 ), ProjectionInFactorOfDirectSum( cat, list2, l ) ], target )",
        dst_template := "matrix[k][l]",
    )
);

# hom structure on zero in the underlying category
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "mor" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, ZeroMorphism( cat, A, B ), mor )",
        dst_template := "ZeroMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, B, Source( mor ) ), HomomorphismStructureOnObjects( A, Range( mor ) ) )",
    )
);

# eliminate case distinction
ApplyLogicTemplate(
    rec(
        variable_names := [ "k", "l", "list" ],
        src_template := "CAP_JIT_INTERNAL_EXPR_CASE( k = l, list[k], true, list[l] )",
        dst_template := "list[l]",
    )
);

AssertLemma( );

# HomomorphismStructureOnMorphisms is compatible with composition
StateNextLemma( );

# composition of morphisms between direct sums via generalized matrix multiplication
ApplyLogicTemplateNTimes( 2,
    rec(
        variable_names := [ "cat", "list1", "list2", "list3", "matrix1", "matrix2" ],
        src_template := "PreCompose( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list2, matrix2, list3 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], i -> List( [ 1 .. Length( list3 ) ], j -> SumOfMorphisms( cat, list1[i], List( [ 1 .. Length( list2 ) ], k -> PreCompose( cat, matrix1[i][k], matrix2[k][j] ) ), list3[j] ) ) ), list3 )",
        new_funcs := [ [ "i" ], [ "j" ], [ "k" ] ],
    )
);

# equality of morphisms between direct sums can be checked componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], x -> ForAll( [ 1 .. Length( list2 ) ], y -> IsCongruentForMorphisms( cat, matrix1[x][y], matrix2[x][y] ) ) )",
        new_funcs := [ [ "x" ], [ "y" ] ],
    )
);

# sum of morphisms between direct sums can be computed componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "list1", "list2", "list3", "matrix" ],
        src_template := "SumOfMorphisms( cat, source, List( list3, k -> MorphismBetweenDirectSums( cat, list1, matrix, list2 ) ), target )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> SumOfMorphisms( cat, list1[a], List( list3, k -> matrix[a][b] ), list2[b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

# equality of morphisms between direct sums can be checked componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

# HomomorphismStructureOnMorphisms in the underlying category is additive in the first component
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "list", "alpha", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, SumOfMorphisms( cat, source, List( list, k -> alpha ), target ), beta )",
        dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, target, Source( beta ) ), List( list, k -> HomomorphismStructureOnMorphisms( cat, alpha, beta ) ), HomomorphismStructureOnObjects( cat, source, Range( beta ) ) )",
    )
);

# HomomorphismStructureOnMorphisms in the underlying category is additive in the second component
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "list", "alpha", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, alpha, SumOfMorphisms( cat, source, List( list, k -> beta ), target ) )",
        dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, Range( alpha ), source ), List( list, k -> HomomorphismStructureOnMorphisms( cat, alpha, beta ) ), HomomorphismStructureOnObjects( cat, Source( alpha ), target ) )", # alpha is a PreCompose, so we lose the correct source here, which previously was part of SumOfMorphisms
    )
);

# HomomorphismStructureOnMorphisms in the underlying category is compatible with the composition
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "beta", "gamma", "delta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, PreCompose( cat, alpha, beta ), PreCompose( cat, gamma, delta ) )",
        dst_template := "PreCompose( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, beta, gamma ), HomomorphismStructureOnMorphisms( cat, alpha, delta ) )",
    )
);

# Source of entries of a morphism matrix
ApplyLogicTemplate(
    rec(
        variable_names := [ "alpha", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Source( MorphismMatrix( alpha )[i][j] )",
        dst_template := "ObjectList( Source( alpha ) )[i]",
    )
);

# Range of entries of a morphism matrix
ApplyLogicTemplate(
    rec(
        variable_names := [ "alpha", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Range( MorphismMatrix( alpha )[i][j] )",
        dst_template := "ObjectList( Range( alpha ) )[j]",
    )
);

AssertLemma( );

# HomomorphismStructureOnMorphisms is compatible with addition in the first component
StateNextLemma( );

# adding morphisms between direct sums can be done componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

# equality of morphisms between direct sums can be checked componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

# adding morphisms between direct sums can be done componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

# equality of morphisms between direct sums can be checked componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

# HomomorphismStructureOnMorphisms in the underlying category is additive in the first component
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha_1", "alpha_2", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, AdditionForMorphisms( cat, alpha_1, alpha_2 ), beta )",
        dst_template := "AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha_1, beta ), HomomorphismStructureOnMorphisms( cat, alpha_2, beta ) )",
    )
);

AssertLemma( );

# HomomorphismStructureOnMorphisms is compatible with addition in the second component
StateNextLemma( );

# adding morphisms between direct sums can be done componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

# equality of morphisms between direct sums can be checked componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

# adding morphisms between direct sums can be done componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

# equality of morphisms between direct sums can be checked componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

# HomomorphismStructureOnMorphisms in the underlying category is additive in the second component
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "beta_1", "beta_2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, alpha, AdditionForMorphisms( cat, beta_1, beta_2 ) )",
        dst_template := "AdditionForMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, alpha, beta_1 ), HomomorphismStructureOnMorphisms( cat, alpha, beta_2 ) )",
    )
);

AssertLemma( );

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure well-defined
StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

AssertLemma( );

# InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism well-defined
StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

AssertLemma( );

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure is injective
StateNextLemma( );

# ComponentOfMorphismIntoDirectSum of UniversalMorphismIntoDirectSum gives the original morphisms
ApplyLogicTemplateNTimes( 2,
    rec(
        variable_names := [ "cat", "list", "T", "list_of_morphisms", "i" ],
        src_template := "ComponentOfMorphismIntoDirectSum( cat, UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms ), list, i )",
        dst_template := "list_of_morphisms[i]",
    )
);

PrintLemma( );

# interpreting and reinterpreting in the underlying category gives the original morphism
# CONDITION: only if alpha : A -> B
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryMorphism ],
        src_template := "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha ) )",
        dst_template := "alpha",
    )
);

AssertLemma( );

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure is surjective
StateNextLemma( );

# interpreting and reinterpreting in the underlying category gives the original morphism
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryMorphism ],
        src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, alpha ) )",
        dst_template := "alpha",
    )
);

# UniversalMorphismIntoDirectSum of ComponentOfMorphismIntoDirectSum gives the original morphism
ApplyLogicTemplateNTimes( 2,
    rec(
        variable_names := [ "cat", "list", "list2", "T", "alpha" ],
        src_template := "UniversalMorphismIntoDirectSum( cat, list, T, List( list2, i -> ComponentOfMorphismIntoDirectSum( cat, alpha, list, i ) ) )",
        dst_template := "alpha",
    )
);

AssertLemma( );

# naturality of InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure
StateNextLemma( );

# degenerate version of MorphismBetweenDirectSums ⋅ MorphismBetweenDirectSums
ApplyLogicTemplateNTimes( 2,
    rec(
        variable_names := [ "cat", "T", "list1", "list2", "list_of_morphisms", "matrix" ],
        src_template := "PreCompose( cat, UniversalMorphismIntoDirectSum( cat, list1, T, list_of_morphisms ), MorphismBetweenDirectSums( cat, list1, matrix, list2 ) )",
        dst_template := "UniversalMorphismIntoDirectSum( cat, list2, T, List( [ 1 .. Length( list2 ) ], j -> SumOfMorphisms( cat, T, List( [ 1 .. Length( list1 ) ], k -> PreCompose( cat, list_of_morphisms[k], matrix[k][j] ) ), list2[j] ) ) )",
        new_funcs := [ [ "j" ], [ "k" ] ],
    )
);

# degenerate version of MorphismBetweenDirectSums = MorphismBetweenDirectSums
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list", "T", "list_of_morphisms_1", "list_of_morphisms_2" ],
        src_template := "IsCongruentForMorphisms( cat, UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_1 ), UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list ) ], s -> IsCongruentForMorphisms( cat, list_of_morphisms_1[s], list_of_morphisms_2[s] ) )",
        new_funcs := [ [ "s" ] ],
    )
);

# degenerate version of SumOfMorphisms( MorphismBetweenDirectSums )
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "T", "list2", "list3", "list_of_morphisms" ],
        src_template := "SumOfMorphisms( cat, source, List( list3, k -> UniversalMorphismIntoDirectSum( cat, list2, T, list_of_morphisms ) ), target )",
        dst_template := "UniversalMorphismIntoDirectSum( cat, list2, T, List( [ 1 .. Length( list2 ) ], b -> SumOfMorphisms( cat, T, List( list3, k -> list_of_morphisms[b] ), list2[b] ) ) )",
        new_funcs := [ [ "b" ] ],
    )
);

# degenerate version of MorphismBetweenDirectSums = MorphismBetweenDirectSums
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list", "T", "list_of_morphisms_1", "list_of_morphisms_2" ],
        src_template := "IsCongruentForMorphisms( cat, UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_1 ), UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list ) ], s -> IsCongruentForMorphisms( cat, list_of_morphisms_1[s], list_of_morphisms_2[s] ) )",
        new_funcs := [ [ "s" ] ],
    )
);

# pull composition into the case distinction
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "P", "beta_1", "beta_2" ],
        src_template := "PreCompose( cat, CAP_JIT_INTERNAL_EXPR_CASE( P, beta_1, true, beta_2 ), alpha )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, PreCompose( cat, beta_1, alpha ), true, PreCompose( cat, beta_2, alpha ) )",
    )
);

# composition with the identity
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "B" ],
        src_template := "PreCompose( cat, IdentityMorphism( cat, B ), alpha )",
        dst_template := "alpha",
    )
);

# composition with zero
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "B_1", "B_2" ],
        src_template := "PreCompose( cat, ZeroMorphism( cat, B_1, B_2 ), alpha )",
        dst_template := "ZeroMorphism( cat, B_1, Range( alpha ) )",
    )
);

# Range of entries of a morphism matrix
ApplyLogicTemplate(
    rec(
        variable_names := [ "alpha", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Range( MorphismMatrix( alpha )[i][j] )",
        dst_template := "ObjectList( Range( alpha ) )[j]",
    )
);

PrintLemma( );

# drop zero morphisms in sums of morphisms
# CONDITION: only if `i in [ 1 .. l ]`
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "l", "i", "alpha", "B_1", "B_2" ],
        src_template := "SumOfMorphisms( cat, B_1, List( [ 1 .. l ], k -> CAP_JIT_INTERNAL_EXPR_CASE( i = k, alpha, true, ZeroMorphism( cat, B_1, B_2 ) ) ), B_2 )",
        dst_template := "(k -> alpha)(i)",
    )
);

# pull composition into case distinction
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "index1", "index2", "value_if_equal", "value_if_not_equal" ],
        src_template := "PreCompose( cat, alpha, CAP_JIT_INTERNAL_EXPR_CASE( index1 = index2, value_if_equal, true, value_if_not_equal ) )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( index1 = index2, PreCompose( cat, alpha, value_if_equal ), true, PreCompose( cat, alpha, value_if_not_equal ) )",
    )
);

# composition with the identity
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "object" ],
        src_template := "PreCompose( cat, alpha, IdentityMorphism( cat, object ) )",
        dst_template := "alpha",
    )
);

# composition with zero
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "object1", "object2" ],
        src_template := "PreCompose( cat, alpha, ZeroMorphism( cat, object1, object2 ) )",
        dst_template := "ZeroMorphism( cat, Source( alpha ), object2 )",
    )
);

PrintLemma( );

# drop zero morphisms in sums of morphisms
# CONDITION: only if `i in [ 1 .. l ]`
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "l", "i", "alpha", "B_1", "B_2" ],
        src_template := "SumOfMorphisms( cat, B_1, List( [ 1 .. l ], k -> CAP_JIT_INTERNAL_EXPR_CASE( k = i, alpha, true, ZeroMorphism( cat, B_1, B_2 ) ) ), B_2 )",
        dst_template := "(k -> alpha)(i)",
    )
);

# interpretation in the underlying category is additive
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list", "target" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsList, IsDummyCategoryObject ],
        src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, SumOfMorphisms( cat, source, list, target ) )",
        dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ), List( [ 1 .. Length( list ) ], x -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, list[x] ) ), HomomorphismStructureOnObjects( cat, source, target ) )",
        new_funcs := [ [ "x" ] ],
    )
);

# composition is additive in the first component
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list", "target", "mor" ],
        src_template := "PreCompose( cat, SumOfMorphisms( cat, source, list, target ), mor )",
        dst_template := "SumOfMorphisms( cat, source, List( [ 1 .. Length( list ) ], x -> PreCompose( cat, list[x], mor ) ), Range( mor ) )",
        new_funcs := [ [ "x" ] ],
    )
);

# interpretation in the underlying category is additive
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list", "target" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsList, IsDummyCategoryObject ],
        src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, SumOfMorphisms( cat, source, list, target ) )",
        dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ), List( [ 1 .. Length( list ) ], x -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, list[x] ) ), HomomorphismStructureOnObjects( cat, source, target ) )",
        new_funcs := [ [ "x" ] ],
    )
);

# interpretation in the underlying category is a natural transformation
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "xi", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, PreCompose( cat, PreCompose( cat, alpha, xi ), beta ) )",
        dst_template := "PreCompose( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, xi ), HomomorphismStructureOnMorphisms( cat, alpha, beta ) )",
    )
);

# Range of entries of a morphism matrix
ApplyLogicTemplate(
    rec(
        variable_names := [ "alpha", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Range( MorphismMatrix( alpha )[i][j] )",
        dst_template := "ObjectList( Range( alpha ) )[j]",
    )
);

# swap sums
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "m", "n", "alpha", "A", "B" ],
        src_template := "SumOfMorphisms( cat, A, List( [ 1 .. m ], i -> SumOfMorphisms( cat, A, List( [ 1 .. n ], j -> alpha ), B ) ), B )",
        dst_template := "SumOfMorphisms( cat, A, List( [ 1 .. n ], j -> SumOfMorphisms( cat, A, List( [ 1 .. m ], i -> alpha ), B ) ), B )",
    )
);

AssertLemma( );



#
AssertProposition( );
