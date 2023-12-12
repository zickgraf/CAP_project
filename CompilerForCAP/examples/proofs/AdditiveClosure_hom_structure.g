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

SetCurrentCategory( cat, "the additive closure of a pre-additive category" );

StateProposition( "is_equipped_with_hom_structure", function ( name )
    
    if name = "a" then
        
        return "A";
        
    fi;
    
    if name = "b" then
        
        return "B";
        
    fi;
    
    if name = "alpha" then
        
        return "alpha__A__B";
        
    fi;
    
    if name = "beta" then
        
        return "beta__C__D";
        
    fi;
    
    if name = "gamma" then
        
        return "gamma__E__F";
        
    fi;
    
    return name;
    
end );

#LATEX_OUTPUT := false;

# DistinguishedObjectOfHomomorphismStructure is well-defined
StateNextLemma( );

AssumeValidInputs( );

AssertLemma( );

# HomomorphismStructureOnObjects is well-defined
StateNextLemma( );

AssumeValidInputs( );

AssertLemma( );

# HomomorphismStructureOnMorphisms is well-defined
StateNextLemma( );

PrintLemma( );

AssumeValidInputs( );

AssertLemma( );

# HomomorphismStructureOnMorphisms preserves identities
StateNextLemma( );

# check congruence with identity on direct sum componentwise
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "list" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsList ],
        src_template := "IsCongruentForMorphisms( cat, morphism, IdentityMorphism( cat, DirectSum( cat, list ) ) )",
        dst_template := "ForAll( [ 1 .. Length( list ) ], i -> ForAll( [ 1 .. Length( list ) ], j -> IsCongruentForMorphisms( cat, PreComposeList( cat, list[i], [ InjectionOfCofactorOfDirectSum( cat, list, i ), morphism, ProjectionInFactorOfDirectSum( cat, list, j ) ], list[j] ), CAP_JIT_INTERNAL_EXPR_CASE( i = j, IdentityMorphism( cat, list[i] ), true, ZeroMorphism( cat, list[i], list[j] ) ) ) ) )",
        new_funcs := [ [ "i" ], [ "j"] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list", "i", "j", "matrix", "source", "target" ],
        variable_filters := [ IsDummyCategory, IsList, IsInt, IsInt, IsList, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "PreComposeList( cat, source, [ InjectionOfCofactorOfDirectSum( cat, list, i ), MorphismBetweenDirectSums( cat, list, matrix, list ), ProjectionInFactorOfDirectSum( cat, list, j ) ], target )",
        dst_template := "matrix[i][j]",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "P", "case1", "case2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsBool, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "IsCongruentForMorphisms( cat, morphism, CAP_JIT_INTERNAL_EXPR_CASE( P, case1, true, case2 ) )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, IsCongruentForMorphisms( cat, morphism, case1 ), true, IsCongruentForMorphisms( cat, morphism, case2 ) )",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "case1", "case2", "i" ],
        src_template := "j -> CAP_JIT_INTERNAL_EXPR_CASE( i = j, case1, true, case2 )",
        dst_template := "x -> CAP_JIT_INTERNAL_EXPR_CASE( i = x, (j -> case1)(i), true, (j -> case2)(x) )",
        new_funcs := [ [ "x" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "list" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsList ],
        src_template := "IsCongruentForMorphisms( cat, morphism, IdentityMorphism( cat, DirectSum( cat, list ) ) )",
        dst_template := "ForAll( [ 1 .. Length( list ) ], i -> ForAll( [ 1 .. Length( list ) ], j -> IsCongruentForMorphisms( cat, PreComposeList( cat, list[i], [ InjectionOfCofactorOfDirectSum( cat, list, i ), morphism, ProjectionInFactorOfDirectSum( cat, list, j ) ], list[j] ), CAP_JIT_INTERNAL_EXPR_CASE( i = j, IdentityMorphism( cat, list[i] ), true, ZeroMorphism( cat, list[i], list[j] ) ) ) ) )",
        new_funcs := [ [ "i" ], [ "j"] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list", "i", "j", "matrix", "source", "target" ],
        variable_filters := [ IsDummyCategory, IsList, IsInt, IsInt, IsList, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "PreComposeList( cat, source, [ InjectionOfCofactorOfDirectSum( cat, list, i ), MorphismBetweenDirectSums( cat, list, matrix, list ), ProjectionInFactorOfDirectSum( cat, list, j ) ], target )",
        dst_template := "matrix[i][j]",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "P", "case1", "case2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsBool, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "IsCongruentForMorphisms( cat, morphism, CAP_JIT_INTERNAL_EXPR_CASE( P, case1, true, case2 ) )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, IsCongruentForMorphisms( cat, morphism, case1 ), true, IsCongruentForMorphisms( cat, morphism, case2 ) )",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), IdentityMorphism( cat, B ) )",
        dst_template := "IdentityMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ) )",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "C" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "HomomorphismStructureOnMorphisms( cat, IdentityMorphism( cat, A ), ZeroMorphism( cat, B, C ) )",
        dst_template := "ZeroMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, A, B ), HomomorphismStructureOnObjects( cat, A, C ) )",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "morphism", "list1", "list2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsList, IsList ],
        src_template := "IsCongruentForMorphisms( cat, morphism, ZeroMorphism( cat, DirectSum( cat, list1 ), DirectSum( cat, list2 ) ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], k -> ForAll( [ 1 .. Length( list2 ) ], l -> IsCongruentForMorphisms( cat, PreComposeList( cat, list1[k], [ InjectionOfCofactorOfDirectSum( cat, list1, k ), morphism, ProjectionInFactorOfDirectSum( cat, list2, l ) ], list2[l] ), ZeroMorphism( cat, list1[k], list2[l] ) ) ) )",
        new_funcs := [ [ "k" ], [ "l"] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "k", "l", "matrix", "source", "target" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsInt, IsInt, IsList, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "PreComposeList( cat, source, [ InjectionOfCofactorOfDirectSum( cat, list1, k ), MorphismBetweenDirectSums( cat, list1, matrix, list2 ), ProjectionInFactorOfDirectSum( cat, list2, l ) ], target )",
        dst_template := "matrix[k][l]",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "mor" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, ZeroMorphism( cat, A, B ), mor )",
        dst_template := "ZeroMorphism( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, B, Source( mor ) ), HomomorphismStructureOnObjects( A, Target( mor ) ) )",
    )
);

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

ApplyLogicTemplateNTimes( 2,
    rec(
        variable_names := [ "cat", "list1", "list2", "list3", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList, IsList ],
        src_template := "PreCompose( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list2, matrix2, list3 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], i -> List( [ 1 .. Length( list3 ) ], j -> SumOfMorphisms( cat, list1[i], List( [ 1 .. Length( list2 ) ], k -> PreCompose( cat, matrix1[i][k], matrix2[k][j] ) ), list3[j] ) ) ), list3 )",
        new_funcs := [ [ "i" ], [ "j" ], [ "k" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], x -> ForAll( [ 1 .. Length( list2 ) ], y -> IsCongruentForMorphisms( cat, matrix1[x][y], matrix2[x][y] ) ) )",
        new_funcs := [ [ "x" ], [ "y" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "list1", "list2", "list3", "matrix" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsList, IsList, IsList ],
        src_template := "SumOfMorphisms( cat, source, List( list3, k -> MorphismBetweenDirectSums( cat, list1, matrix, list2 ) ), target )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> SumOfMorphisms( cat, list1[a], List( list3, k -> matrix[a][b] ), list2[b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "list", "alpha", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, SumOfMorphisms( cat, source, List( list, k -> alpha ), target ), beta )",
        dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, target, Source( beta ) ), List( list, k -> HomomorphismStructureOnMorphisms( cat, alpha, beta ) ), HomomorphismStructureOnObjects( cat, source, Target( beta ) ) )",
    )
);
 
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "list", "alpha", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, alpha, SumOfMorphisms( cat, source, List( list, k -> beta ), target ) )",
        dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnObjects( cat, Target( alpha ), source ), List( list, k -> HomomorphismStructureOnMorphisms( cat, alpha, beta ) ), HomomorphismStructureOnObjects( cat, Source( alpha ), target ) )", # TODO: alpha is a PreCompose, so we lose the correct source here, which previously was part of SumOfMorphisms
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "beta", "gamma", "delta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "HomomorphismStructureOnMorphisms( cat, PreCompose( cat, alpha, beta ), PreCompose( cat, gamma, delta ) )",
        dst_template := "PreCompose( RangeCategoryOfHomomorphismStructure( cat ), HomomorphismStructureOnMorphisms( cat, beta, gamma ), HomomorphismStructureOnMorphisms( cat, alpha, delta ) )",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "alpha", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Source( MorphismMatrix( alpha )[i][j] )",
        dst_template := "ObjectList( Source( alpha ) )[i]",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "alpha", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Target( MorphismMatrix( alpha )[i][j] )",
        dst_template := "ObjectList( Target( alpha ) )[j]",
    )
);

AssertLemma( );

# HomomorphismStructureOnMorphisms is compatible with addition in the first component
StateNextLemma( );

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

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

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "AdditionForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "MorphismBetweenDirectSums( cat, list1, List( [ 1 .. Length( list1 ) ], a -> List( [ 1 .. Length( list2 ) ], b -> AdditionForMorphisms( cat, matrix1[a][b], matrix2[a][b] ) ) ), list2 )",
        new_funcs := [ [ "a" ], [ "b" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list1", "list2", "matrix1", "matrix2" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsList, IsList ],
        src_template := "IsCongruentForMorphisms( cat, MorphismBetweenDirectSums( cat, list1, matrix1, list2 ), MorphismBetweenDirectSums( cat, list1, matrix2, list2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list1 ) ], s -> ForAll( [ 1 .. Length( list2 ) ], t -> IsCongruentForMorphisms( cat, matrix1[s][t], matrix2[s][t] ) ) )",
        new_funcs := [ [ "s" ], [ "t" ] ],
    )
);

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

AssumeValidInputs( );

AssertLemma( );

# InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism well-defined
StateNextLemma( );

AssumeValidInputs( );

AssertLemma( );

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure is injective
StateNextLemma( );

ApplyLogicTemplateNTimes( 2,
    rec(
        variable_names := [ "cat", "list", "T", "list_of_morphisms", "i" ],
        variable_filters := [ IsDummyCategory, IsList, IsDummyCategoryObject, IsList, IsInt ],
        src_template := "ComponentOfMorphismIntoDirectSum( cat, UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms ), list, i )",
        dst_template := "list_of_morphisms[i]",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryMorphism ],
        src_template := "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, alpha ) )", # TODO: A = Source( alpha )
        dst_template := "alpha",
    )
);

AssertLemma( );

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure is surjective
StateNextLemma( );

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryMorphism ],
        src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat, A, B, alpha ) )",
        dst_template := "alpha",
    )
);

ApplyLogicTemplateNTimes( 2,
    rec(
        variable_names := [ "cat", "list", "list2", "T", "alpha" ],
        variable_filters := [ IsDummyCategory, IsList, IsList, IsDummyCategoryObject, IsDummyCategoryMorphism ],
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
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsList, IsList, IsList, IsList ],
        src_template := "PreCompose( cat, UniversalMorphismIntoDirectSum( cat, list1, T, list_of_morphisms ), MorphismBetweenDirectSums( cat, list1, matrix, list2 ) )",
        dst_template := "UniversalMorphismIntoDirectSum( cat, list2, T, List( [ 1 .. Length( list2 ) ], j -> SumOfMorphisms( cat, T, List( [ 1 .. Length( list1 ) ], k -> PreCompose( cat, list_of_morphisms[k], matrix[k][j] ) ), list2[j] ) ) )",
        new_funcs := [ [ "j" ], [ "k" ] ],
    )
);

# degenerate version of MorphismBetweenDirectSums = MorphismBetweenDirectSums
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list", "T", "list_of_morphisms_1", "list_of_morphisms_2" ],
        variable_filters := [ IsDummyCategory, IsList, IsDummyCategoryObject, IsList, IsList ],
        src_template := "IsCongruentForMorphisms( cat, UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_1 ), UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list ) ], s -> IsCongruentForMorphisms( cat, list_of_morphisms_1[s], list_of_morphisms_2[s] ) )",
        new_funcs := [ [ "s" ] ],
    )
);

# degenerate version of SumOfMorphisms( MorphismBetweenDirectSums )
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "T", "list2", "list3", "list_of_morphisms" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsList, IsList ],
        src_template := "SumOfMorphisms( cat, source, List( list3, k -> UniversalMorphismIntoDirectSum( cat, list2, T, list_of_morphisms ) ), target )",
        dst_template := "UniversalMorphismIntoDirectSum( cat, list2, T, List( [ 1 .. Length( list2 ) ], b -> SumOfMorphisms( cat, T, List( list3, k -> list_of_morphisms[b] ), list2[b] ) ) )",
        new_funcs := [ [ "b" ] ],
    )
);

# degenerate version of MorphismBetweenDirectSums = MorphismBetweenDirectSums
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list", "T", "list_of_morphisms_1", "list_of_morphisms_2" ],
        variable_filters := [ IsDummyCategory, IsList, IsDummyCategoryObject, IsList, IsList ],
        src_template := "IsCongruentForMorphisms( cat, UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_1 ), UniversalMorphismIntoDirectSum( cat, list, T, list_of_morphisms_2 ) )",
        dst_template := "ForAll( [ 1 .. Length( list ) ], s -> IsCongruentForMorphisms( cat, list_of_morphisms_1[s], list_of_morphisms_2[s] ) )",
        new_funcs := [ [ "s" ] ],
    )
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "P", "beta_1", "beta_2" ],
        src_template := "PreCompose( cat, CAP_JIT_INTERNAL_EXPR_CASE( P, beta_1, true, beta_2 ), alpha )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, PreCompose( cat, beta_1, alpha ), true, PreCompose( cat, beta_2, alpha ) )",
    ),
    dummy, [ "category", "morphism", "bool", "morphism", "morphism" ], "="
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "B" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject ],
        src_template := "PreCompose( cat, IdentityMorphism( cat, B ), alpha )",
        dst_template := "alpha",
    ),
    dummy, [ "category", "morphism", "object" ], "="
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "B_1", "B_2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "PreCompose( cat, ZeroMorphism( cat, B_1, B_2 ), alpha )",
        dst_template := "ZeroMorphism( cat, B_1, Target( alpha ) )",
    ),
    dummy, [ "category", "morphism", "object", "object" ], "=", "."
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "alpha", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Target( MorphismMatrix( alpha )[i][j] )",
        dst_template := "ObjectList( Target( alpha ) )[j]",
    )
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "l", "i", "alpha", "B_1", "B_2" ],
        variable_filters := [ IsDummyCategory, IsInt, IsInt, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "SumOfMorphisms( cat, B_1, List( [ 1 .. l ], k -> CAP_JIT_INTERNAL_EXPR_CASE( i = k, alpha, true, ZeroMorphism( cat, B_1, B_2 ) ) ), B_2 )",
        #dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i in [ 1 .. l ], (k -> alpha)(i), true, ZeroMorphism( cat, B_1, B_2 ) )",
        dst_template := "(k -> alpha)(i)", # TODO: wrong
    ),
    dummy, [ "category", "integer", "integer", "morphism", "object", "object" ], "="
);

# PreCompose( alpha, KroneckerDelta( ... ) )
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "index1", "index2", "value_if_equal", "value_if_not_equal" ],
        #src_template := "PreCompose( cat, KroneckerDelta( index1, index2, value_if_equal, value_if_not_equal ), alpha )",
        #dst_template := "KroneckerDelta( index1, index2, PreCompose( cat, value_if_equal, alpha ), PreCompose( cat, value_if_not_equal, alpha ) )",
        src_template := "PreCompose( cat, alpha, CAP_JIT_INTERNAL_EXPR_CASE( index1 = index2, value_if_equal, true, value_if_not_equal ) )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( index1 = index2, PreCompose( cat, alpha, value_if_equal ), true, PreCompose( cat, alpha, value_if_not_equal ) )",
    )
);

# PreCompose( alpha, IdentityMorphism( ... ) )
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "object" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject ],
        src_template := "PreCompose( cat, alpha, IdentityMorphism( cat, object ) )",
        dst_template := "alpha",
    )
);

# PreCompose( alpha, ZeroMorphism( ... ) )
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "object1", "object2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "PreCompose( cat, alpha, ZeroMorphism( cat, object1, object2 ) )",
        dst_template := "ZeroMorphism( cat, Source( alpha ), object2 )",
    )
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "l", "i", "alpha", "B_1", "B_2" ],
        variable_filters := [ IsDummyCategory, IsInt, IsInt, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "SumOfMorphisms( cat, B_1, List( [ 1 .. l ], k -> CAP_JIT_INTERNAL_EXPR_CASE( k = i, alpha, true, ZeroMorphism( cat, B_1, B_2 ) ) ), B_2 )",
        #dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i in [ 1 .. l ], (k -> alpha)(i), true, ZeroMorphism( cat, B_1, B_2 ) )",
        dst_template := "(k -> alpha)(i)", # TODO: wrong
    ),
    dummy, [ "category", "integer", "integer", "morphism", "object", "object" ], "="
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list", "target" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsList, IsDummyCategoryObject ],
        src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, SumOfMorphisms( cat, source, list, target ) )",
        dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ), List( [ 1 .. Length( list ) ], x -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, list[x] ) ), HomomorphismStructureOnObjects( cat, source, target ) )",
        new_funcs := [ [ "x" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list", "target", "mor" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsList, IsDummyCategoryObject, IsDummyCategoryMorphism ],
        src_template := "PreCompose( cat, SumOfMorphisms( cat, source, list, target ), mor )",
        dst_template := "SumOfMorphisms( cat, source, List( [ 1 .. Length( list ) ], x -> PreCompose( cat, list[x], mor ) ), Target( mor ) )",
        new_funcs := [ [ "x" ] ],
    )#,
    #dummy, [ "category", "morphism", "morphism" ], " = ", "."
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list", "target" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsList, IsDummyCategoryObject ],
        src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, SumOfMorphisms( cat, source, list, target ) )",
        dst_template := "SumOfMorphisms( RangeCategoryOfHomomorphismStructure( cat ), DistinguishedObjectOfHomomorphismStructure( cat ), List( [ 1 .. Length( list ) ], x -> InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, list[x] ) ), HomomorphismStructureOnObjects( cat, source, target ) )",
        new_funcs := [ [ "x" ] ],
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "X", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, PreCompose( cat, PreCompose( cat, alpha, X ), beta ) )",
        dst_template := "PreCompose( RangeCategoryOfHomomorphismStructure( cat ), InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat, X ), HomomorphismStructureOnMorphisms( cat, alpha, beta ) )",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "alpha", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Target( MorphismMatrix( alpha )[i][j] )",
        dst_template := "ObjectList( Target( alpha ) )[j]",
    )
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "m", "n", "alpha", "A", "B" ],
        src_template := "SumOfMorphisms( cat, A, List( [ 1 .. m ], i -> SumOfMorphisms( cat, A, List( [ 1 .. n ], j -> alpha ), B ) ), B )",
        dst_template := "SumOfMorphisms( cat, A, List( [ 1 .. n ], j -> SumOfMorphisms( cat, A, List( [ 1 .. m ], i -> alpha ), B ) ), B )",
    ),
    dummy, [ "category", "integer", "integer", "morphism", "object", "object" ], "="
);

AssertLemma( );



#
AssertProposition( );
