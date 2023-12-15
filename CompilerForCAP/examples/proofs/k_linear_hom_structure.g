LoadPackage( "FreydCategoriesForCAP", false : OnlyNeeded );

k := DummyCommutativeRing( );
# CategoryOfRows expects a *homalg* ring
SetFilterObj( k, IsHomalgRing );
k!.RingFilter := IsHomalgRing;
k!.RingElementFilter := IsHomalgRingElement;

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsWellDefinedForObjects",
        "IsWellDefinedForMorphismsWithGivenSourceAndRange",
        "IsEqualForObjects",
        "IsCongruentForMorphisms",
        "IdentityMorphism",
        "PreComposeList",
        "AdditionForMorphisms",
        "LinearCombinationOfMorphisms",
    ],
    properties := [
        "IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms",
        "IsEquippedWithHomomorphismStructure",
    ],
    commutative_ring_of_linear_category := k
) : FinalizeCategory := false );
SetRangeCategoryOfHomomorphismStructure( dummy, CategoryOfRows( k ) );
AddBasisOfExternalHom( dummy, function ( cat, a, b )
    
    Error( "this is a dummy category without actual implementation" );
    
end );
AddCoefficientsOfMorphism( dummy, function ( cat, alpha )
    
    Error( "this is a dummy category without actual implementation" );
    
end );
Finalize( dummy );

# set a human readable name
dummy!.Name := "any linear category with finitely generated free external homs";

LoadPackage( "CompilerForCAP", false : OnlyNeeded );

CapJitEnableProofAssistantMode( );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

Assert( 0, CanCompute( dummy, "DistinguishedObjectOfHomomorphismStructure" ) );
Assert( 0, CanCompute( dummy, "HomomorphismStructureOnObjects" ) );
Assert( 0, CanCompute( dummy, "HomomorphismStructureOnMorphisms" ) );
Assert( 0, CanCompute( dummy, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) );
Assert( 0, CanCompute( dummy, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) );

#
StateProposition( dummy, "is_equipped_with_hom_structure" );;

# DistinguishedObjectOfHomomorphismStructure is well-defined

StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

ApplyLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "1 >= 0",
        dst_template := "true",
    )
);

AssertLemma( );

# HomomorphismStructureOnObjects is well-defined
StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

ApplyLogicTemplate(
    rec(
        variable_names := [ "list" ],
        variable_filters := [ IsList ],
        src_template := "Length( list ) >= 0",
        dst_template := "true",
    )
);

AssertLemma( );

# HomomorphismStructureOnMorphisms is well-defined
StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

ApplyLogicTemplate(
    rec(
        variable_names := [ "entries", "nr_rows", "nr_cols", "ring" ],
        src_template := "NumberRows( HomalgMatrixListList( entries, nr_rows, nr_cols, ring ) )",
        dst_template := "nr_rows",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "entries", "nr_rows", "nr_cols", "ring" ],
        src_template := "NumberColumns( HomalgMatrixListList( entries, nr_rows, nr_cols, ring ) )",
        dst_template := "nr_cols",
    )
);

AssertLemma( );

# HomomorphismStructureOnMorphisms on identities
StateNextLemma( );

# identites in PreComposeList
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "mor", "B" ],
        src_template := "PreComposeList( cat, A, [ IdentityMorphism( cat, A ), mor, IdentityMorphism( cat, B ) ], B )",
        dst_template := "mor",
    )
);

# equal to HomalgIdentityMatrix
ApplyLogicTemplate(
    rec(
        variable_names := [ "matrix", "size", "ring" ],
        src_template := "matrix = HomalgIdentityMatrix( size, ring )",
        dst_template := "ForAll( [ 1 .. size ], i -> ForAll( [ 1 .. size ], j -> matrix[i, j] = CAP_JIT_INTERNAL_EXPR_CASE( i = j, One( ring ), true, Zero( ring ) ) ) )",
        new_funcs := [ [ "i" ], [ "j" ] ],
    )
);

# HomalgMatrixListList[i,j]
ApplyLogicTemplate(
    rec(
        variable_names := [ "list_list", "nr_rows", "nr_cols", "ring", "i", "j" ],
        src_template := "HomalgMatrixListList( list_list, nr_rows, nr_cols, ring )[i, j]",
        dst_template := "list_list[i][j]",
    )
);

# CoefficientsOfMorphism( BasisOfExternalHom[i] )[j]
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "i", "j" ],
        src_template := "CoefficientsOfMorphism( cat, BasisOfExternalHom( cat, A, B )[i] )[j]",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i = j, One( CommutativeRingOfLinearCategory( cat ) ), true, Zero( CommutativeRingOfLinearCategory( cat ) ) )",
    )
);

AssertLemma( );


# HomomorphismStructureOnMorphisms compatible with composition
StateNextLemma( );

# flatten PreComposeList
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "C", "D", "alpha", "beta", "gamma", "delta", "epsilon" ],
        src_template := "PreComposeList( cat, A, [ PreComposeList( cat, A, [ alpha, beta ], B ), gamma, PreComposeList( cat, C, [ delta, epsilon ], D ) ], D )",
        dst_template := "PreComposeList( cat, A, [ alpha, beta, gamma, delta, epsilon ], D )",
    )
);

# matrix multiplication for HomalgMatrixListList
ApplyLogicTemplate(
    rec(
        variable_names := [ "list_list1", "nr_rows1", "nr_cols1", "ring", "list_list2", "nr_cols2" ],
        src_template := "HomalgMatrixListList( list_list1, nr_rows1, nr_cols1, ring ) * HomalgMatrixListList( list_list2, nr_cols1, nr_cols2, ring )",
        dst_template := "HomalgMatrixListList( List( [ 1 .. nr_rows1 ], i -> List( [ 1 .. nr_cols2 ], j -> Sum( [ 1 .. nr_cols1 ], k -> list_list1[i][k] * list_list2[k][j] ) ) ) , nr_rows1, nr_cols2, ring )",
        new_funcs := [ [ "i" ], [ "j" ], [ "k" ] ],
    )
);

# equality for HomalgMatrixListList
ApplyLogicTemplate(
    rec(
        variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
        src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) = HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
        dst_template := "list_list1 = list_list2",
    )
);

# List( list1, func1 ) = List( list2, func2 )
ApplyLogicTemplate(
    rec(
        variable_names := [ "list1", "func1", "list2", "func2" ],
        variable_filters := [ IsList, IsFunction, IsList, IsFunction ],
        src_template := "List( list1, func1 ) = List( list2, func2 )",
        dst_template := "Length( list1 ) = Length( list2 ) and ForAll( [ 1 .. Length( list1 ) ], i -> func1( list1[i] ) = func2( list2[i] ) )",
        new_funcs := [ [ "i" ] ],
    )
);

# decide equality with CoefficientsOfMorphism by taking the linear combination with the corresponding basis
ApplyLogicTemplate(
    rec(
        variable_names := [ "list", "cat", "mor" ],
        src_template := "list = CoefficientsOfMorphism( cat, mor )",
        dst_template := """
            Length( list ) = Length( BasisOfExternalHom( cat, Source( mor ), Target( mor ) ) ) and
            IsCongruentForMorphisms( cat,
                LinearCombinationOfMorphisms( cat, Source( mor ), list, BasisOfExternalHom( cat, Source( mor ), Target( mor ) ), Target( mor ) ),
                mor
            )
        """,
    )
);

# swap sums
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list1", "list2", "value1", "value2", "list_of_morphisms", "target" ],
        src_template := "LinearCombinationOfMorphisms( cat, source, List( list1, j -> Sum( list2, k -> value1 * value2 ) ), list_of_morphisms, target )",
        dst_template := "LinearCombinationOfMorphisms( cat, source, List( list2, k -> value1 ), List( list2, k -> LinearCombinationOfMorphisms( cat, source, List( list1, j -> value2 ), list_of_morphisms, target ) ), target )",
    )
);

# CoefficientsOfMorphism * BasisOfExternalHom
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
            LinearCombinationOfMorphisms( cat,
                A,
                List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
                BasisOfExternalHom( cat, A, B ),
                B
            )
        """,
        dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
    )
);

# composition is linear
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "list", "alpha", "list2", "gamma", "coeffs" ],
        src_template := "LinearCombinationOfMorphisms( cat, A, coeffs, List( list, k -> PreComposeList( cat, A, [ alpha, list2[k], gamma ], B ) ), B )",
        dst_template := "PreComposeList( cat, A, [ alpha, LinearCombinationOfMorphisms( cat, Target( alpha ), coeffs, list2, Source( gamma ) ), gamma ], B )",
    )
);

# CoefficientsOfMorphism * BasisOfExternalHom
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
            LinearCombinationOfMorphisms( cat,
                A,
                List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
                BasisOfExternalHom( cat, A, B ),
                B
            )
        """,
        dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
    )
);

# flatten PreComposeList
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "C", "D", "alpha", "beta", "gamma", "delta", "epsilon" ],
        src_template := "PreComposeList( cat, A, [ alpha, PreComposeList( cat, B, [ beta, gamma, delta ], C ), epsilon ], D )",
        dst_template := "PreComposeList( cat, A, [ alpha, beta, gamma, delta, epsilon ], D )",
    )
);

AssertLemma( );

# HomomorphismStructureOnMorphisms additive in first component
StateNextLemma( );

# matrix addition for HomalgMatrixListList
ApplyLogicTemplate(
    rec(
        variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
        src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) + HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
        dst_template := "HomalgMatrixListList( List( [ 1 .. nr_rows ], i -> List( [ 1 .. nr_cols ], j -> list_list1[i][j] + list_list2[i][j] ) ), nr_rows, nr_cols, ring )",
        new_funcs := [ [ "i" ], [ "j" ] ],
    )
);

# CoefficientsOfMorphism is linear
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "j", "A", "B", "list1", "list2" ],
        src_template := "CoefficientsOfMorphism( cat, PreComposeList( cat, A, list1, B ) )[j] + CoefficientsOfMorphism( cat, PreComposeList( cat, A, list2, B ) )[j]",
        dst_template := "CoefficientsOfMorphism( cat, AdditionForMorphisms( cat, PreComposeList( cat, A, list1, B ), PreComposeList( cat, A, list2, B ) ) )[j]",
    )
);

# PreComposeList is linear
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha_1", "alpha_2", "beta", "gamma" ],
        src_template := "AdditionForMorphisms( cat, PreComposeList( cat, A, [ alpha_1, beta, gamma ], B ), PreComposeList( cat, A, [ alpha_2, beta, gamma ], B ) )",
        dst_template := "PreComposeList( cat, A, [ AdditionForMorphisms( cat, alpha_1, alpha_2 ), beta, gamma ], B )",
    )
);

# equality for HomalgMatrixListList
ApplyLogicTemplate(
    rec(
        variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
        src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) = HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
        dst_template := "list_list1 = list_list2",
    )
);

# List( list1, func1 ) = List( list2, func2 )
ApplyLogicTemplate(
    rec(
        variable_names := [ "list1", "func1", "list2", "func2" ],
        variable_filters := [ IsList, IsFunction, IsList, IsFunction ],
        src_template := "List( list1, func1 ) = List( list2, func2 )",
        dst_template := "Length( list1 ) = Length( list2 ) and ForAll( [ 1 .. Length( list1 ) ], i -> func1( list1[i] ) = func2( list2[i] ) )",
        new_funcs := [ [ "i" ] ],
    )
);

# decide equality with CoefficientsOfMorphism by taking the linear combination with the corresponding basis
ApplyLogicTemplate(
    rec(
        variable_names := [ "list", "cat", "mor" ],
        src_template := "list = CoefficientsOfMorphism( cat, mor )",
        dst_template := """
            Length( list ) = Length( BasisOfExternalHom( cat, Source( mor ), Target( mor ) ) ) and
            IsCongruentForMorphisms( cat,
                LinearCombinationOfMorphisms( cat, Source( mor ), list, BasisOfExternalHom( cat, Source( mor ), Target( mor ) ), Target( mor ) ),
                mor
            )
        """,
    )
);

# CoefficientsOfMorphism * BasisOfExternalHom
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
            LinearCombinationOfMorphisms( cat,
                A,
                List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
                BasisOfExternalHom( cat, A, B ),
                B
            )
        """,
        dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
    )
);

AssertLemma( );




# HomomorphismStructureOnMorphisms additive in second component
StateNextLemma( );

# matrix addition for HomalgMatrixListList
ApplyLogicTemplate(
    rec(
        variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
        src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) + HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
        dst_template := "HomalgMatrixListList( List( [ 1 .. nr_rows ], i -> List( [ 1 .. nr_cols ], j -> list_list1[i][j] + list_list2[i][j] ) ) , nr_rows, nr_cols, ring )",
        new_funcs := [ [ "i" ], [ "j" ] ],
    )
);

# CoefficientsOfMorphism is linear
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "j", "A", "B", "list1", "list2" ],
        src_template := "CoefficientsOfMorphism( cat, PreComposeList( cat, A, list1, B ) )[j] + CoefficientsOfMorphism( cat, PreComposeList( cat, A, list2, B ) )[j]",
        dst_template := "CoefficientsOfMorphism( cat, AdditionForMorphisms( cat, PreComposeList( cat, A, list1, B ), PreComposeList( cat, A, list2, B ) ) )[j]",
    )
);


# PreComposeList is linear
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "gamma_1", "gamma_2" ],
        src_template := "AdditionForMorphisms( cat, PreComposeList( cat, A, [ alpha, beta, gamma_1 ], B ), PreComposeList( cat, A, [ alpha, beta, gamma_2 ], B ) )",
        dst_template := "PreComposeList( cat, A, [ alpha, beta, AdditionForMorphisms( cat, gamma_1, gamma_2 ) ], B )",
    )
);

# equality for HomalgMatrixListList
ApplyLogicTemplate(
    rec(
        variable_names := [ "list_list1", "nr_rows", "nr_cols", "ring", "list_list2" ],
        src_template := "HomalgMatrixListList( list_list1, nr_rows, nr_cols, ring ) = HomalgMatrixListList( list_list2, nr_rows, nr_cols, ring )",
        dst_template := "list_list1 = list_list2",
    )
);

# List( list1, func1 ) = List( list2, func2 )
ApplyLogicTemplate(
    rec(
        variable_names := [ "list1", "func1", "list2", "func2" ],
        src_template := "List( list1, func1 ) = List( list2, func2 )",
        dst_template := "Length( list1 ) = Length( list2 ) and ForAll( [ 1 .. Length( list1 ) ], i -> func1( list1[i] ) = func2( list2[i] ) )",
        new_funcs := [ [ "i" ] ],
    )
);

# decide equality of CoefficientsOfMorphism by taking the linear combination with the corresponding basis
ApplyLogicTemplate(
    rec(
        variable_names := [ "list", "cat", "mor" ],
        src_template := "list = CoefficientsOfMorphism( cat, mor )",
        dst_template := """
            Length( list ) = Length( BasisOfExternalHom( cat, Source( mor ), Target( mor ) ) ) and
            IsCongruentForMorphisms( cat,
                LinearCombinationOfMorphisms( cat, Source( mor ), list, BasisOfExternalHom( cat, Source( mor ), Target( mor ) ), Target( mor ) ),
                mor
            )
        """,
    )
);

# CoefficientsOfMorphism * BasisOfExternalHom
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
            LinearCombinationOfMorphisms( cat,
                A,
                List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
                BasisOfExternalHom( cat, A, B ),
                B
            )
        """,
        dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
    )
);

AssertLemma( );

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure well-defined
StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

ApplyLogicTemplate(
    rec(
        variable_names := [ "entries", "nr_cols", "ring" ],
        src_template := "NumberRows( HomalgRowVector( entries, nr_cols, ring ) )",
        dst_template := "1",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "entries", "nr_cols", "ring" ],
        src_template := "NumberColumns( HomalgRowVector( entries, nr_cols, ring ) )",
        dst_template := "nr_cols",
    )
);

AssertLemma( );


# InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism well-defined
StateNextLemma( );

PrintLemma( );

AttestValidInputs( );

AssertLemma( );



# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure injective
StateNextLemma( );

# EntriesOfHomalgRowVector( HomalgRowVector )
ApplyLogicTemplate(
    rec(
        variable_names := [ "entries", "nr_cols", "ring" ],
        src_template := "EntriesOfHomalgRowVector( HomalgRowVector( entries, nr_cols, ring ) )",
        dst_template := "entries",
    )
);

PrintLemma( );

# linear combination with basis
# CONDITION: only if alpha : A -> B
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha" ],
        src_template := "LinearCombinationOfMorphisms( cat, A, CoefficientsOfMorphism( cat, alpha ), BasisOfExternalHom( cat, A, B ), B )",
        dst_template := "alpha",
    )
);

AssertLemma( );


# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure surjective
StateNextLemma( );

# coefficients of a linear combination of a basis
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "coefficients" ],
        src_template := "CoefficientsOfMorphism( cat, LinearCombinationOfMorphisms( cat, source, coefficients, BasisOfExternalHom( cat, source, target ), target ) )",
        dst_template := "coefficients",
    )
);

# HomalgRowVector( EntriesOfHomalgRowVector )
ApplyLogicTemplate(
    rec(
        variable_names := [ "row_vector", "nr_cols", "ring" ],
        src_template := "HomalgRowVector( EntriesOfHomalgRowVector( row_vector ), nr_cols, ring )",
        dst_template := "row_vector",
    )
);

AssertLemma( );


# naturality of InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure
StateNextLemma( );

# matrix multiplication for HomalgRowVector and HomalgMatrixListList
ApplyLogicTemplate(
    rec(
        variable_names := [ "list1", "nr_cols1", "ring", "list_list2", "nr_cols2" ],
        src_template := "HomalgRowVector( list1, nr_cols1, ring ) * HomalgMatrixListList( list_list2, nr_cols1, nr_cols2, ring )",
        dst_template := "HomalgRowVector( List( [ 1 .. nr_cols2 ], j -> Sum( [ 1 .. nr_cols1 ], k -> list1[k] * list_list2[k][j] ) ), nr_cols2, ring )",
        new_funcs := [ [ "j" ], [ "k" ] ],
    )
);

# equality for HomalgRowVector
ApplyLogicTemplate(
    rec(
        variable_names := [ "list1", "nr_cols", "ring", "list2" ],
        src_template := "HomalgRowVector( list1, nr_cols, ring ) = HomalgRowVector( list2, nr_cols, ring )",
        dst_template := "list1 = list2",
    )
);

# decide equality of CoefficientsOfMorphism by taking the linear combination with the corresponding basis (swapped arguments compared to the version above)
ApplyLogicTemplate(
    rec(
        variable_names := [ "list", "cat", "mor" ],
        src_template := "CoefficientsOfMorphism( cat, mor ) = list",
        dst_template := """
            Length( BasisOfExternalHom( cat, Source( mor ), Target( mor ) ) ) = Length( list ) and
            IsCongruentForMorphisms( cat,
                mor,
                LinearCombinationOfMorphisms( cat, Source( mor ), list, BasisOfExternalHom( cat, Source( mor ), Target( mor ) ), Target( mor ) )
            )
        """,
    )
);

# swap sums
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list1", "list2", "value1", "value2", "list_of_morphisms", "target" ],
        src_template := "LinearCombinationOfMorphisms( cat, source, List( list1, j -> Sum( list2, k -> value1 * value2 ) ), list_of_morphisms, target )",
        dst_template := "LinearCombinationOfMorphisms( cat, source, List( list2, k -> value1 ), List( list2, k -> LinearCombinationOfMorphisms( cat, source, List( list1, j -> value2 ), list_of_morphisms, target ) ), target )",
    )
);

# CoefficientsOfMorphism * BasisOfExternalHom
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
            LinearCombinationOfMorphisms( cat,
                A,
                List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j] ),
                BasisOfExternalHom( cat, A, B ),
                B
            )
        """,
        dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
    )
);

# composition is linear
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "source", "list", "alpha", "list2", "gamma", "target", "coeffs" ],
        src_template := "LinearCombinationOfMorphisms( cat, source, coeffs, List( list, k -> PreComposeList( cat, A, [ alpha, list2[k], gamma ], B ) ), target )",
        dst_template := "PreComposeList( cat, A, [ alpha, LinearCombinationOfMorphisms( cat, Target( alpha ), coeffs, list2, Source( gamma ) ), gamma ], B )",
    )
);

PrintLemma( );

# CoefficientsOfMorphism * BasisOfExternalHom
# CONDITION: only if mor : A -> B
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "mor" ],
        src_template := """
            LinearCombinationOfMorphisms( cat,
                A,
                List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> CoefficientsOfMorphism( cat, mor )[j] ),
                BasisOfExternalHom( cat, A, B ),
                B
            )
        """,
        dst_template := "mor",
    )
);

AssertLemma( );

# all lemmata proven
StateNextLemma( );

#
AssertProposition( );
