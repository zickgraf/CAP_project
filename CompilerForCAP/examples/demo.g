# https://github.com/homalg-project/CAP_project/tree/master/CompilerForCAP#readme

LoadPackage( "Algebroids" );

ZZ := HomalgRingOfIntegers( );

####

##
rows := CategoryOfRows( ZZ );

V := CategoryOfRowsObject( rows, 1 );
W := CategoryOfRowsObject( rows, 2 );

alpha := CategoryOfRowsMorphism( V, HomalgMatrix( [ 1, 0 ], 1, 2, ZZ ), W );
Display( alpha );
IsWellDefined( alpha );



##
cols := CategoryOfColumns( ZZ );

S := CategoryOfColumnsObject( cols, 2 );
T := CategoryOfColumnsObject( cols, 1 );

beta := CategoryOfColumnsMorphism( S, HomalgMatrix( [ 1, 0 ], 1, 2, ZZ ), T );
Display( beta );
IsWellDefined( beta );



##
op := Opposite( rows );
Vop := Opposite( V );
Wop := Opposite( W );
alphaop := Opposite( alpha );
Display( Source( alphaop ) );
Display( Range( alphaop ) );

# MorphismBetweenDirectSums
#
# A_1 ⊕ … ⊕ A_n → B_1 ⊕ … ⊕ B_m
#
# α_ij: A_i → B_j
#
# [ [ α_11, …, α_1m ],
#           ⋮
#   [ α_n1, …, α_nm ] ]

# Konkatenation von zwei Operationen: UniversalMorphismInto/FromDirectSumWithGivenDirectSum
func := function( cat, S, diagram_S, morphism_matrix, diagram_T, T )
  local test_diagram_product, test_diagram_coproduct;
    
    test_diagram_coproduct := ListN( diagram_S, morphism_matrix,
        { source, row } -> UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, diagram_T, source, row, T )
    );
    
    return UniversalMorphismFromDirectSumWithGivenDirectSum( cat, diagram_S, T, test_diagram_coproduct, S );
    
end;

# Implementierung: unwrappen, UniversalMorphismFromDirectSumWithGivenDirectSum, wrappen
Display( op!.added_functions.UniversalMorphismIntoDirectSumWithGivenDirectSum );

StopCompilationAtCategory( rows );

# wir sehen das iterierte Wrappen und Unwrappen im Code
compiled_func := CapJitCompiledFunction( func, [ op ] : display_after_resolving_phase );

# wegkompiliert
Display( compiled_func );

# ganz nach unten durchkompilieren
ContinueCompilationAtCategory( rows );

Display( CapJitCompiledFunction( func, [ op ] ) );



####

# Freyd: Fügt einer Kategorie formal Kokerne hinzu:
#   Ein Objekt in Freyd ist gegeben durch einen Morphismus in der zugrundeliegenden Kategorie. Interpretation: Kokernobjekt dieses Morphismus
#   Ein Morphismus in Freyd ist gegeben durch einen Morphismus in der zugrundeliegenden Kategorie, der mit der Kokerninterpretation kompatibel ist (also die Relationen respektiert)
# FreydCategory( CategoryOfRows ) modelliert endlich präsentierte Moduln:
# ℤ^n → ℤ^m ist n×m-Matrix. Interpretation: ℤ^m modulo Zeilenraum
# unter bestimmten Voraussetzungen kann man auch Kerne ausrechnen
# die Kernobjekte sind aber teuer: doppelte Syzygienrechnung

freyd := FreydCategory( rows );

A := AsFreydCategoryObject( V );
id := IdentityMorphism( A );;

# ColiftAlongEpimorphism
# generische Derivation
func1 := function( cat, epimorphism, test_morphism )
    local kernel_emb, cokernel_colift_to_range_of_epimorphism, cokernel_colift_to_range_of_test_morphism;
    
    kernel_emb := KernelEmbedding( cat, epimorphism );
    
    cokernel_colift_to_range_of_epimorphism :=
      CokernelColift( cat, kernel_emb, epimorphism );
      
    cokernel_colift_to_range_of_test_morphism :=
      CokernelColift( cat, kernel_emb, test_morphism );
    
    return PreCompose( cat, InverseForMorphisms( cat, cokernel_colift_to_range_of_epimorphism ), cokernel_colift_to_range_of_test_morphism );
    
end;

# KernelEmbedding steckt nur in "morphism" (was nicht genutzt wird) und in cokernel_object, was beim PreCompose wegfällt
Display( freyd!.added_functions.CokernelColiftWithGivenCokernelObject );

# hier ist noch ReducedSyzygiesOfRows vorhanden
compiled_func := CapJitCompiledFunction( func1, [ freyd, id, id ] : display_after_resolving_phase );
# hier nicht mehr
Display( compiled_func );

# spezielle Installation in Freyd
func2 := function( cat, epimorphism, test_morphism )
  local witness, R_B, A, sigma_A;
    
    witness := WitnessForBeingCongruentToZero( cat, CokernelProjection( cat, epimorphism ) );
    
    R_B := Source( RelationMorphism( Range( epimorphism ) ) );
    
    A := Range( RelationMorphism( Source( epimorphism ) ) );
    
    sigma_A := ComponentOfMorphismIntoDirectSum( UnderlyingCategory( cat ), witness, [ R_B, A ], 2 );
    
    return FreydCategoryMorphism( cat, Range( epimorphism ), PreCompose( UnderlyingCategory( cat ), sigma_A, MorphismDatum( cat, test_morphism ) ), Range( test_morphism ) );
        
end;

compiled_func := CapJitCompiledFunction( func2, [ freyd, id, id ] : display_after_resolving_phase );
Display( compiled_func );

# func1 und func2 unterscheiden sich in einer Multiplikation mit HomalgIdentityMatrix

CapJitAddLogicTemplate(
    # matrix * HomalgIdentityMatrix( size, ring ) -> matrix
    rec(
        variable_names := [ "size", "ring", "matrix" ],
        src_template := "matrix * HomalgIdentityMatrix( size, ring )",
        dst_template := "matrix",
        returns_value := true,
        needed_packages := [ [ "MatricesForHomalg", ">= 2020.05.19" ] ],
    )
);

Display( CapJitCompiledFunction( func1, [ freyd, id, id ] ) );

# jetzt sind func1 und func2 gleich

# weiteres Phanänomen: RightDivide -> RelativeRightDivide

####

# AdditiveClosure: formale direkte Summen
#   Objekte: Listen von Objekten der zugrundeliegenden Kategorie
#   Morphismen: Matrizen von Morphismen der zugrundeliegenden Kategorie (Stichwort: MorphismBetweenDirectSums)

LoadPackage( "Algebroids" );

QQ := HomalgFieldOfRationals( );;
snake_quiver := RightQuiver( "Q(4)[a:1->2,b:2->3,c:3->4]" );;
A := PathAlgebra( QQ, snake_quiver );;
A := QuotientOfPathAlgebra( A, [ A.abc ] );;

add := AdditiveClosure( Algebroid( A, false ) : no_precompiled_code );

# HomomorphismStructureOnMorphismsWithGivenObjects
func := function( cat, source, alpha, beta, range )
    local size_i, size_j, size_s, size_t, A, B, C, D, H_B_C, H_A_D, source_direct_sums, range_direct_sums;
    
    size_i := NrRows( alpha );
    
    size_j := NrCols( alpha );
    
    size_s := NrRows( beta );
    
    size_t := NrCols( beta );
    
    A := Source( alpha );
    B := Range( alpha );
    C := Source( beta );
    D := Range( beta );
    
    H_B_C :=
        List( [ 1 .. size_j ], j ->
            List( [ 1 .. size_s ], s ->
                HomomorphismStructureOnObjects( UnderlyingCategory( cat ), B[j], C[s] )
            )
        );
    
    H_A_D :=
        List( [ 1 .. size_i ], i ->
            List( [ 1 .. size_t ], t ->
                HomomorphismStructureOnObjects( UnderlyingCategory( cat ), A[i], D[t] )
            )
        );
    
    source_direct_sums := List( [ 1 .. size_j ], j -> DirectSum( RangeCategoryOfHomomorphismStructure( cat ), List( [ 1 .. size_s ], s -> H_B_C[j, s] ) ) );
    range_direct_sums := List( [ 1 .. size_i ], i -> DirectSum( RangeCategoryOfHomomorphismStructure( cat ), List( [ 1 .. size_t ], t -> H_A_D[i, t] ) ) );
    
    return MorphismBetweenDirectSumsWithGivenDirectSums(
        RangeCategoryOfHomomorphismStructure( cat ),
        source,
        source_direct_sums,
        List( [ 1 .. size_j ], j ->
            List( [ 1 .. size_i ], i ->
                MorphismBetweenDirectSumsWithGivenDirectSums(
                    RangeCategoryOfHomomorphismStructure( cat ),
                    source_direct_sums[j],
                    List( [ 1 .. size_s ], s -> H_B_C[j, s] ),
                    List( [ 1 .. size_s ], s ->
                        List( [ 1 .. size_t ], t ->
                            HomomorphismStructureOnMorphismsWithGivenObjects( UnderlyingCategory( cat ), H_B_C[j, s], alpha[i, j], beta[s, t], H_A_D[i, t] )
                        )
                    ),
                    List( [ 1 .. size_t ], t -> H_A_D[i, t] ),
                    range_direct_sums[i]
                )
            )
        ),
        range_direct_sums,
        range
    );
    
end;

Display( CapJitCompiledFunction( func, [ add ] : no_hoisting ) );

# CoefficientsOfPaths ist teuer und wird in der inneren Schleife ausgeführt -> hoisting

# in neuer Session:
Display( CapJitCompiledFunction( func, [ add ] ) );
