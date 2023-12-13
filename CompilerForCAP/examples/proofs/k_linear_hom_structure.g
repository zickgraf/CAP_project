LoadPackage( "FreydCategoriesForCAP" : OnlyNeeded );

k := DummyCommutativeRing( );
# CategoryOfRows expects a *homalg* ring
SetFilterObj( k, IsHomalgRing );
k!.RingFilter := IsHomalgRing;
k!.RingElementFilter := IsHomalgRingElement;

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsWellDefinedForObjects",
        "IsWellDefinedForMorphisms",
        "IsEqualForObjects",
		"IsCongruentForMorphisms",
		"IdentityMorphism",
        "PreComposeList",
        "AdditionForMorphisms",
        "SumOfMorphisms",
        "MultiplyWithElementOfCommutativeRingForMorphisms",
        "LinearCombinationOfMorphisms",
    ],
    properties := [
        "IsLinearCategoryOverCommutativeRing",
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

LoadPackage( "CompilerForCAP" : OnlyNeeded );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

CapJitEnableProofAssistantMode( );

#### CONTINUE

SetCurrentCategory( dummy, "any category which is linear over a commutative ring" ); # TODO
SetCurrentCategory( dummy, "a $k$-linear category with a $k$-basis" ); # TODO

Assert( 0, CanCompute( dummy, "HomomorphismStructureOnObjects" ) );
Assert( 0, CanCompute( dummy, "HomomorphismStructureOnMorphisms" ) );
Assert( 0, CanCompute( dummy, "DistinguishedObjectOfHomomorphismStructure" ) );
Assert( 0, CanCompute( dummy, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" ) );
Assert( 0, CanCompute( dummy, "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" ) );

StateProposition( "is_equipped_with_hom_structure", function ( name )
    
    #if name = "alpha" then
    #    
    #    return "M__m__n"; # TODO
    #    return rec(
    #        type := "morphism",
    #        string := "\\myboxed{M}",
    #        source := "\\myboxed{m}",
    #        target := "\\myboxed{n}",
    #    );
    #    
    #fi;
    
    return name;
    
end );;

LATEX_OUTPUT := false;

# DistinguishedObjectOfHomomorphismStructure is well-defined

StateNextLemma( );

AssumeValidInputs( );

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

AssumeValidInputs( );

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

AssumeValidInputs( ); # TODO: throw error if nothing changes

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

## List( list, func )[index]
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "list", "func", "index" ],
#        src_template := "List( list, func )[index]",
#        dst_template := "func( list[index] )",
#    )
#);

# CoefficientsOfMorphism( BasisOfExternalHom[i] )[j]
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "i", "j" ],
        src_template := "CoefficientsOfMorphism( cat, BasisOfExternalHom( cat, A, B )[i] )[j]",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i = j, One( CommutativeRingOfLinearCategory( cat ) ), true, Zero( CommutativeRingOfLinearCategory( cat ) ) )",
    )
);

# TODO
ApplyLogicTemplateNTimes( 2,
    rec(
        variable_names := [ "cat" ],
        src_template := "UnderlyingRing( RangeCategoryOfHomomorphismStructure( cat ) )",
        dst_template := "CommutativeRingOfLinearCategory( cat )",
    )
);

AssertLemma( );


# HomomorphismStructureOnMorphisms compatible with composition
StateNextLemma( );

# TODO
# flatten PreComposeList
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha", "beta", "gamma", "delta", "epsilon" ],
#        src_template := "PreComposeList( cat, Source( alpha ), [ PreComposeList( cat, Source( alpha ), [ alpha, beta ], Target( beta ) ), gamma, PreComposeList( cat, Source( delta ), [ delta, epsilon ], Target( epsilon ) ) ], Target( epsilon ) )",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, beta, gamma, delta, epsilon ], Target( epsilon ) )",
#    )
#);
#
# MODIFIED
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
			IsCongruentForMorphisms( cat,
				SumOfMorphisms( cat,
					Source( mor ),
					List( [ 1 .. Length( list ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, list[j], BasisOfExternalHom( cat, Source( mor ), Target( mor ) )[j] ) ),
					Target( mor )
				),
				mor
			)
		""",
		new_funcs := [ [ "j" ] ],
    )
);

# List( list, func )[index]
#ApplyLogicTemplateNTimes( 2,
#    rec(
#        variable_names := [ "list", "func", "index" ],
#        src_template := "List( list, func )[index]",
#        dst_template := "func( list[index] )",
#    )
#);

# swap sums
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list1", "list2", "value1", "value2", "mor", "target" ],
        src_template := "SumOfMorphisms( cat, source, List( list1, j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, Sum( list2, k -> value1 * value2 ), mor ) ), target )",
        dst_template := "SumOfMorphisms( cat, source, List( list2, k -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, value1, SumOfMorphisms( cat, source, List( list1, j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, value2, mor ) ), target ) ) ), target )",
    )
);

# CoefficientsOfMorphism * BasisOfExternalHom
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha", "beta", "mor" ],
#        src_template := """
#			SumOfMorphisms( cat,
#				Source( alpha ),
#				List( [ 1 .. Length( BasisOfExternalHom( cat, Source( alpha ), Target( beta ) ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, Source( alpha ), [ alpha, mor, beta ], Target( beta ) ) )[j], BasisOfExternalHom( cat, Source( alpha ), Target( beta ) )[j] ) ),
#				Target( beta )
#			)
#		""",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, mor, beta ], Target( beta ) )",
#    )
#);
# CoefficientsOfMorphism * BasisOfExternalHom
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
			SumOfMorphisms( cat,
				A,
				List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j], BasisOfExternalHom( cat, A, B )[j] ) ),
				B
			)
		""",
        dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
    )
);

# value * ( α ⋅ β ⋅ γ )
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "value", "alpha", "beta", "gamma" ],
#        src_template := "MultiplyWithElementOfCommutativeRingForMorphisms( cat, value, PreComposeList( cat, Source( alpha ), [ alpha, beta, gamma ], Target( gamma ) ) )",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, MultiplyWithElementOfCommutativeRingForMorphisms( cat, value, beta ), gamma ], Target( gamma ) )",
#    )
#);
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "value", "alpha", "beta", "gamma" ],
        src_template := "MultiplyWithElementOfCommutativeRingForMorphisms( cat, value, PreComposeList( cat, A, [ alpha, beta, gamma ], B ) )",
        dst_template := "PreComposeList( cat, A, [ alpha, MultiplyWithElementOfCommutativeRingForMorphisms( cat, value, beta ), gamma ], B )",
    )
);

# ∑( α ⋅ β ⋅ γ )
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "source", "list", "alpha", "beta", "gamma", "target" ],
#        src_template := "SumOfMorphisms( cat, source, List( list, k -> PreComposeList( cat, Source( alpha ), [ alpha, beta, gamma ], Target( gamma ) ) ), target )",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, SumOfMorphisms( cat, Target( alpha ), List( list, k -> beta ), Source( gamma ) ), gamma ], Target( gamma ) )",
#    )
#);
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "source", "list", "alpha", "beta", "gamma", "target" ],
        src_template := "SumOfMorphisms( cat, source, List( list, k -> PreComposeList( cat, A, [ alpha, beta, gamma ], B ) ), target )",
        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, SumOfMorphisms( cat, Target( alpha ), List( list, k -> beta ), Source( gamma ) ), gamma ], B )",
    )
);

# List( list, func )[index]
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "last", "func", "index" ],
#        src_template := "List( [ 1 .. last ], func )[index]",
#        dst_template := "func( index )",
#    )
#);

# CoefficientsOfMorphism * BasisOfExternalHom
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha", "beta", "mor" ],
#        src_template := """
#			SumOfMorphisms( cat,
#				Source( alpha ),
#				List( [ 1 .. Length( BasisOfExternalHom( cat, Source( alpha ), Target( beta ) ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, Source( alpha ), [ alpha, mor, beta ], Target( beta ) ) )[j], BasisOfExternalHom( cat, Source( alpha ), Target( beta ) )[j] ) ),
#				Target( beta )
#			)
#		""",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, mor, beta ], Target( beta ) )",
#    )
#);
# CoefficientsOfMorphism * BasisOfExternalHom
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
			SumOfMorphisms( cat,
				A,
				List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j], BasisOfExternalHom( cat, A, B )[j] ) ),
				B
			)
		""",
        dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
    )
);

# flatten PreComposeList
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha", "beta", "gamma", "delta", "epsilon" ],
#        src_template := "PreComposeList( cat, Source( alpha ), [ alpha, PreComposeList( cat, Source( beta ), [ beta, gamma, delta ], Target( delta ) ), epsilon ], Target( epsilon ) )",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, beta, gamma, delta, epsilon ], Target( epsilon ) )",
#    )
#);
# MODIFIED
# flatten PreComposeList
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "C", "D", "alpha", "beta", "gamma", "delta", "epsilon" ],
        src_template := "PreComposeList( cat, A, [ alpha, PreComposeList( cat, B, [ beta, gamma, delta ], C ), epsilon ], D )",
        dst_template := "PreComposeList( cat, A, [ alpha, beta, gamma, delta, epsilon ], D )",
    )
);

result := AssertLemma( );

# HomomorphismStructureOnMorphisms additive in first component
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

# List( list, func )[index]
#ApplyLogicTemplateNTimes( 2,
#    rec(
#        variable_names := [ "list", "func", "index" ],
#        src_template := "List( list, func )[index]",
#        dst_template := "func( list[index] )",
#    )
#);

# CoefficientsOfMorphism is linear
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "mor1", "j", "mor2" ],
        src_template := "CoefficientsOfMorphism( cat, mor1 )[j] + CoefficientsOfMorphism( cat, mor2 )[j]",
        dst_template := "CoefficientsOfMorphism( cat, AdditionForMorphisms( cat, mor1, mor2 ) )[j]",
    )
);

# PreComposeList is linear
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha_1", "alpha_2", "beta", "gamma" ],
#        src_template := "AdditionForMorphisms( cat, PreComposeList( cat, Source( alpha_1 ), [ alpha_1, beta, gamma ], Target( gamma ) ), PreComposeList( cat, Source( alpha_1 ), [ alpha_2, beta, gamma ], Target( gamma ) ) )",
#        dst_template := "PreComposeList( cat, Source( alpha_1 ), [ AdditionForMorphisms( cat, alpha_1, alpha_2 ), beta, gamma ], Target( gamma ) )",
#    )
#);
# MODIFIED
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
			IsCongruentForMorphisms( cat,
				SumOfMorphisms( cat,
					Source( mor ),
					List( [ 1 .. Length( list ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, list[j], BasisOfExternalHom( cat, Source( mor ), Target( mor ) )[j] ) ),
					Target( mor )
				),
				mor
			)
		""",
		new_funcs := [ [ "j" ] ],
    )
);

# List( list, func )[index]
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "list", "func", "index" ],
#        src_template := "List( list, func )[index]",
#        dst_template := "func( list[index] )",
#    )
#);

# CoefficientsOfMorphism * BasisOfExternalHom
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha", "alpha2", "beta", "mor" ],
#        src_template := """
#			SumOfMorphisms( cat,
#				Source( alpha ),
#				List( [ 1 .. Length( BasisOfExternalHom( cat, Source( alpha ), Target( beta ) ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, Source( alpha ), [ AdditionForMorphisms( cat, alpha, alpha2 ), mor, beta ], Target( beta ) ) )[j], BasisOfExternalHom( cat, Source( alpha ), Target( beta ) )[j] ) ),
#				Target( beta )
#			)
#		""",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ AdditionForMorphisms( cat, alpha, alpha2 ), mor, beta ], Target( beta ) )",
#    )
#);
# CoefficientsOfMorphism * BasisOfExternalHom
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
			SumOfMorphisms( cat,
				A,
				List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j], BasisOfExternalHom( cat, A, B )[j] ) ),
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

## List( list, func )[index]
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "list", "func", "index" ],
#        src_template := "List( list, func )[index]",
#        dst_template := "func( list[index] )",
#    )
#);

## CoefficientsOfMorphism is linear
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "mor1", "j", "mor2" ],
#        src_template := "CoefficientsOfMorphism( cat, mor1 )[j] + CoefficientsOfMorphism( cat, mor2 )[j]",
#        dst_template := "CoefficientsOfMorphism( cat, AdditionForMorphisms( cat, mor1, mor2 ) )[j]",
#    )
#);

#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "list", "cat", "mor1", "mor2", "i", "j" ],
#        src_template := "List( list, l1 -> CoefficientsOfMorphism( cat, mor1 ) )[i][j] + List( list, l2 -> CoefficientsOfMorphism( cat, mor2 ) )[i][j]",
#        dst_template := "List( list, l1 -> CoefficientsOfMorphism( cat, mor1 )[j] )[i] + List( list, l2 -> CoefficientsOfMorphism( cat, mor2 )[j] )[i]",
#    )
#);

#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "list", "func1", "func2", "i" ],
#        src_template := "List( list, func1 )[i] + List( list, func2 )[i]",
#        dst_template := "List( list, x -> func1( x ) + func2( x ) )[i]",
#        new_funcs := [ [ "x" ] ],
#    )
#);

# CoefficientsOfMorphism is linear
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "mor1", "j", "mor2" ],
        src_template := "CoefficientsOfMorphism( cat, mor1 )[j] + CoefficientsOfMorphism( cat, mor2 )[j]",
        dst_template := "CoefficientsOfMorphism( cat, AdditionForMorphisms( cat, mor1, mor2 ) )[j]",
    )
);

# PreComposeList is linear
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha", "beta", "gamma_1", "gamma_2" ],
#        src_template := "AdditionForMorphisms( cat, PreComposeList( cat, Source( alpha ), [ alpha, beta, gamma_1 ], Target( gamma_1 ) ), PreComposeList( cat, Source( alpha ), [ alpha, beta, gamma_2 ], Target( gamma_1 ) ) )",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, beta, AdditionForMorphisms( cat, gamma_1, gamma_2 ) ], Target( gamma_1 ) )",
#    )
#);
# MODIFIED
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
			IsCongruentForMorphisms( cat,
				SumOfMorphisms( cat,
					Source( mor ),
					List( [ 1 .. Length( list ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, list[j], BasisOfExternalHom( cat, Source( mor ), Target( mor ) )[j] ) ),
					Target( mor )
				),
				mor
			)
		""",
		new_funcs := [ [ "j" ] ],
    )
);

# List( list, func )[index]
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "list", "func", "index" ],
#        src_template := "List( list, func )[index]",
#        dst_template := "func( list[index] )",
#    )
#);

# CoefficientsOfMorphism * BasisOfExternalHom
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha", "beta", "beta2", "mor" ],
#        src_template := """
#			SumOfMorphisms( cat,
#				Source( alpha ),
#				List( [ 1 .. Length( BasisOfExternalHom( cat, Source( alpha ), Target( beta ) ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, Source( alpha ), [ alpha, mor, AdditionForMorphisms( cat, beta, beta2 ) ], Target( beta ) ) )[j], BasisOfExternalHom( cat, Source( alpha ), Target( beta ) )[j] ) ),
#				Target( beta )
#			)
#		""",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, mor, AdditionForMorphisms( cat, beta, beta2 ) ], Target (beta ) )",
#    )
#);
# CoefficientsOfMorphism * BasisOfExternalHom
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
			SumOfMorphisms( cat,
				A,
				List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j], BasisOfExternalHom( cat, A, B )[j] ) ),
				B
			)
		""",
        dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
    )
);

result := AssertLemma( );

# InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure well-defined
StateNextLemma( );

AssumeValidInputs( );

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

AssumeValidInputs( );

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

# linear combination with basis
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha" ],
#        src_template := "SumOfMorphisms( cat, Source( alpha ), ListN( CoefficientsOfMorphism( cat, alpha ), BasisOfExternalHom( cat, Source( alpha ), Target( alpha ) ), { c, m } -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, c, m ) ), Target( alpha ) )",
#        dst_template := "alpha",
#    )
#);
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha" ],
#        src_template := "LinearCombinationOfMorphisms( cat, Source( alpha ), CoefficientsOfMorphism( cat, alpha ), BasisOfExternalHom( cat, Source( alpha ), Target( alpha ) ), Target( alpha ) )",
#        dst_template := "alpha",
#    )
#);
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha" ],
        src_template := "LinearCombinationOfMorphisms( cat, A, CoefficientsOfMorphism( cat, alpha ), BasisOfExternalHom( cat, A, B ), B )",
        dst_template := "alpha",
    )
);

result := AssertLemma( );


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

result := AssertLemma( );


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
			IsCongruentForMorphisms( cat,
				mor,
				SumOfMorphisms( cat,
					Source( mor ),
					List( [ 1 .. Length( list ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, list[j], BasisOfExternalHom( cat, Source( mor ), Target( mor ) )[j] ) ),
					Target( mor )
				)
			)
		""",
		new_funcs := [ [ "j" ] ],
    )
);

# List( list, func )[index]
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "list", "func", "index" ],
#        src_template := "List( list, func )[index]",
#        dst_template := "func( list[index] )",
#    )
#);

# swap sums
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "list1", "list2", "value1", "value2", "mor", "target" ],
        src_template := "SumOfMorphisms( cat, source, List( list1, j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, Sum( list2, k -> value1 * value2 ), mor ) ), target )",
        dst_template := "SumOfMorphisms( cat, source, List( list2, k -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, value1, SumOfMorphisms( cat, source, List( list1, j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, value2, mor ) ), target ) ) ), target )",
    )
);

# CoefficientsOfMorphism * BasisOfExternalHom
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "alpha", "beta", "mor" ],
#        src_template := """
#			SumOfMorphisms( cat,
#				Source( alpha ),
#				List( [ 1 .. Length( BasisOfExternalHom( cat, Source( alpha ), Target( beta ) ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, Source( alpha ), [ alpha, mor, beta ], Target( beta ) ) )[j], BasisOfExternalHom( cat, Source( alpha ), Target( beta ) )[j] ) ),
#				Target( beta )
#			)
#		""",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, mor, beta ], Target( beta ) )",
#    )
#);
# CoefficientsOfMorphism * BasisOfExternalHom
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "alpha", "beta", "mor" ],
        src_template := """
			SumOfMorphisms( cat,
				A,
				List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, PreComposeList( cat, A, [ alpha, mor, beta ], B ) )[j], BasisOfExternalHom( cat, A, B )[j] ) ),
				B
			)
		""",
        dst_template := "PreComposeList( cat, A, [ alpha, mor, beta ], B )",
    )
);

# value * ( α ⋅ β ⋅ γ )
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "value", "alpha", "beta", "gamma" ],
#        src_template := "MultiplyWithElementOfCommutativeRingForMorphisms( cat, value, PreComposeList( cat, Source( alpha ), [ alpha, beta, gamma ], Target( gamma ) ) )",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, MultiplyWithElementOfCommutativeRingForMorphisms( cat, value, beta ), gamma ], Target( gamma ) )",
#    )
#);
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "value", "alpha", "beta", "gamma" ],
        src_template := "MultiplyWithElementOfCommutativeRingForMorphisms( cat, value, PreComposeList( cat, A, [ alpha, beta, gamma ], B ) )",
        dst_template := "PreComposeList( cat, A, [ alpha, MultiplyWithElementOfCommutativeRingForMorphisms( cat, value, beta ), gamma ], B )",
    )
);

# ∑( α ⋅ β ⋅ γ )
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "source", "list", "alpha", "beta", "gamma", "target" ],
#        src_template := "SumOfMorphisms( cat, source, List( list, k -> PreComposeList( cat, Source( alpha ), [ alpha, beta, gamma ], Target( gamma ) ) ), target )",
#        dst_template := "PreComposeList( cat, Source( alpha ), [ alpha, SumOfMorphisms( cat, Target( alpha ), List( list, k -> beta ), Source( gamma ) ), gamma ], Target( gamma ) )",
#    )
#);
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "source", "list", "alpha", "beta", "gamma", "target" ],
        src_template := "SumOfMorphisms( cat, source, List( list, k -> PreComposeList( cat, A, [ alpha, beta, gamma ], B ) ), target )",
        dst_template := "PreComposeList( cat, A, [ alpha, SumOfMorphisms( cat, Target( alpha ), List( list, k -> beta ), Source( gamma ) ), gamma ], B )",
    )
);

# List( list, func )[index]
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "last", "func", "index" ],
#        src_template := "List( [ 1 .. last ], func )[index]",
#        dst_template := "func( index )",
#    )
#);

# CoefficientsOfMorphism * BasisOfExternalHom
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "cat", "mor" ],
#        src_template := """
#			SumOfMorphisms( cat,
#				Source( mor ),
#				List( [ 1 .. Length( BasisOfExternalHom( cat, Source( mor ), Target( mor ) ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, mor )[j], BasisOfExternalHom( cat, Source( mor ), Target( mor ) )[j] ) ),
#				Target( mor )
#			)
#		""",
#        dst_template := "mor",
#    )
#);
# MODIFIED
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "A", "B", "mor" ],
        src_template := """
			SumOfMorphisms( cat,
				A,
				List( [ 1 .. Length( BasisOfExternalHom( cat, A, B ) ) ], j -> MultiplyWithElementOfCommutativeRingForMorphisms( cat, CoefficientsOfMorphism( cat, mor )[j], BasisOfExternalHom( cat, A, B )[j] ) ),
				B
			)
		""",
        dst_template := "mor",
    )
);

result := AssertLemma( );



AssertProposition( );
