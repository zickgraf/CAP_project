#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );
#! true

QQ := HomalgFieldOfRationalsInSingular( );;

operations := [
    "AdditionForMorphisms",
    "AdditiveInverseForMorphisms",
    #"AssociatorLeftToRightWithGivenTensorProducts",
    #"AssociatorRightToLeftWithGivenTensorProducts",
    #"BraidingWithGivenTensorProducts",
    #"CoevaluationMorphismWithGivenRange",
    "CokernelColift",
    "CokernelColiftWithGivenCokernelObject",
    "CokernelProjection",
    #"Colift",
    "ColiftAlongEpimorphism",
    "DirectSum",
    "DirectSumFunctorialWithGivenDirectSums",
    #"DistinguishedObjectOfHomomorphismStructure",
    "EpimorphismFromSomeProjectiveObject",
    "EpimorphismFromSomeProjectiveObjectForKernelObject",
    #"EvaluationMorphismWithGivenSource",
    #"HomomorphismStructureOnMorphismsWithGivenObjects",
    #"HomomorphismStructureOnObjects",
    "IdentityMorphism",
    "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
    #"InternalHomOnMorphismsWithGivenInternalHoms",
    #"InternalHomOnObjects",
    #"InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
    #"InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
    #"IsColiftable",
    "IsCongruentForMorphisms",
    "IsEqualForMorphisms",
    "IsEqualForObjects",
    #"IsLiftable",
    "IsWellDefinedForMorphisms",
    "IsWellDefinedForObjects",
    "IsZeroForMorphisms",
    "KernelEmbedding",
    "KernelLiftWithGivenKernelObject",
    #"LeftUnitorInverseWithGivenTensorProduct",
    #"LeftUnitorWithGivenTensorProduct",
    #"Lift",
    "LiftAlongMonomorphism",
    "MorphismConstructor",
    "MorphismDatum",
    "MultiplyWithElementOfCommutativeRingForMorphisms",
    "ObjectConstructor",
    "ObjectDatum",
    "PreCompose",
    "ProjectionInFactorOfDirectSumWithGivenDirectSum",
    #"RightUnitorInverseWithGivenTensorProduct",
    #"RightUnitorWithGivenTensorProduct",
    #"SimplifyObject",
    #"SimplifyObject_IsoFromInputObject",
    #"SimplifyObject_IsoToInputObject",
    #"TensorProductOnMorphismsWithGivenTensorProducts",
    #"TensorProductOnObjects",
    #"TensorUnit",
    "UniversalMorphismFromDirectSumWithGivenDirectSum",
    "UniversalMorphismFromZeroObjectWithGivenZeroObject",
    "UniversalMorphismIntoDirectSumWithGivenDirectSum",
    "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
    "ZeroMorphism",
    "ZeroObject"
];

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "dimension", "ring" ],
        src_template := "SyzygiesOfColumns( HomalgZeroMatrix( 0, dimension, ring ) )",
        dst_template := "HomalgIdentityMatrix( dimension, ring )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "dimension", "ring" ],
        variable_filters := [ IsHomalgMatrix, IsInt, IsHomalgRing ],
        src_template := "matrix * HomalgIdentityMatrix( dimension, ring )",
        dst_template := "matrix",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "dimension", "ring" ],
        variable_filters := [ IsHomalgMatrix, IsInt, IsHomalgRing ],
        src_template := "HomalgIdentityMatrix( dimension, ring ) * matrix",
        dst_template := "matrix",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "matrix", "dimension", "ring" ],
        src_template := "LeftDivide( HomalgIdentityMatrix( dimension, ring ), matrix )",
        dst_template := "matrix",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "nr_rows", "nr_cols", "ring" ],
        src_template := "RowRankOfMatrix( HomalgZeroMatrix( nr_rows, nr_cols, ring ) )",
        dst_template := "0",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "nr_rows", "nr_cols", "ring" ],
        src_template := "DiagMat( ring, List( list, x -> HomalgZeroMatrix( nr_rows, nr_cols, ring ) ) )",
        dst_template := "HomalgZeroMatrix( Sum( List( list, x -> nr_rows ) ), Sum( List( list, x -> nr_cols ) ), ring )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "nr_cols", "ring", "matrix" ],
        src_template := "UnionOfRows( ring, nr_cols, [ HomalgZeroMatrix( 0, nr_cols, ring ), matrix ] )",
        dst_template := "matrix",
    )
);

CapJitPrecompileCategoryAndCompareResult(
    homalg_ring -> MatrixCategoryAsFreydCategoryOfMatrixCategory(
        homalg_ring
    ),
    [ QQ ],
    "LinearAlgebraForCAP",
    "MatrixCategoryAsFreydCategoryOfMatrixCategoryPrecompiled" :
    operations := operations,
    number_of_objectified_objects_in_data_structure_of_object := 1,
    number_of_objectified_morphisms_in_data_structure_of_object := 0,
    number_of_objectified_objects_in_data_structure_of_morphism := 2,
    number_of_objectified_morphisms_in_data_structure_of_morphism := 1
);

ReadPackage( "LinearAlgebraForCAP", "gap/precompiled_categories/MatrixCategoryAsFreydCategoryOfMatrixCategoryPrecompiled.gi" );

vec := MatrixCategory( QQ );
vec2 := MatrixCategoryAsFreydCategoryOfMatrixCategory( QQ );
vec3 := MatrixCategoryAsFreydCategoryOfMatrixCategoryPrecompiled( QQ );

M := HomalgMatrix( [ 1, 1 ], 1, 2, QQ );
T := HomalgMatrix( [ 3, 4, -3, -4 ], 2, 2, QQ );

Display( IsZero( M * T ) );

mor := M / vec;
mor2 := M / vec2;
mor3 := M / vec3;

tau := T / vec;
tau2 := T / vec2;
tau3 := T / vec3;

Display( IsZeroForMorphisms( PreCompose( mor, tau ) ) );
Display( IsZeroForMorphisms( PreCompose( mor2, tau2 ) ) );
Display( IsZeroForMorphisms( PreCompose( mor3, tau3 ) ) );

pi := CokernelProjection( mor );
pi2 := CokernelProjection( mor2 );
pi3 := CokernelProjection( mor3 );

colift := CokernelColift( mor, tau );
colift2 := CokernelColift( mor2, tau2 );
colift3 := CokernelColift( mor3, tau3 );

Display( IsEqualForMorphisms( PreCompose( pi, colift ), tau ) );
Display( IsEqualForMorphisms( PreCompose( pi2, colift2 ), tau2 ) );
Display( IsEqualForMorphisms( PreCompose( pi3, colift3 ), tau3 ) );



#! @EndExample
