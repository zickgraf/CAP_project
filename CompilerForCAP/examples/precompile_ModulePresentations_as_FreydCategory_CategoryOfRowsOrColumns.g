#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "ModulePresentationsForCAP", false );
#! true
LoadPackage( "FreydCategoriesForCAP", false );
#! true

ReadPackage( "LinearAlgebraForCAP", "gap/CompilerLogic.gi" );
#! true

homalg_field := DummyHomalgField( );;
commutative_homalg_ring := DummyCommutativeHomalgRing( );;
homalg_ring := DummyHomalgRing( );;

# CAUTION: when adding new operations make sure that they are compatible
# with the ones added manually in `ADD_FUNCTIONS_FOR_LEFT/RIGHT_PRESENTATION`.
operations_for_arbitrary_ring := [
    "AdditionForMorphisms",
    "AdditiveInverseForMorphisms",
    "CokernelColiftWithGivenCokernelObject",
    "CokernelProjection",
    "DirectSum",
    "EpimorphismFromSomeProjectiveObject",
    "IdentityMorphism",
    "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
    "IsCongruentForMorphisms",
    "IsEqualForMorphisms",
    "IsEqualForObjects",
    #"IsWellDefinedForMorphisms",
    #"IsWellDefinedForObjects",
    "IsZeroForMorphisms",
    #"KernelEmbedding",
    #"LiftAlongMonomorphism",
    "PreCompose",
    "ProjectionInFactorOfDirectSumWithGivenDirectSum",
    "UniversalMorphismFromDirectSumWithGivenDirectSum",
    "UniversalMorphismFromZeroObjectWithGivenZeroObject",
    "UniversalMorphismIntoDirectSumWithGivenDirectSum",
    "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
    "ZeroMorphism",
    "ZeroObject",
];;

operations_for_commutative_ring := Concatenation(
    operations_for_arbitrary_ring,
    [ #"AssociatorLeftToRightWithGivenTensorProducts",
      #"AssociatorRightToLeftWithGivenTensorProducts",
      #"BraidingWithGivenTensorProducts",
      #"CoevaluationMorphismWithGivenRange",
      #"Colift",
      #"EvaluationMorphismWithGivenSource",
      #"InternalHomOnMorphismsWithGivenInternalHoms",
      #"InternalHomOnObjects",
      #"IsColiftable",
      #"IsLiftable",
      #"LeftUnitorWithGivenTensorProduct",
      #"Lift",
      "MultiplyWithElementOfCommutativeRingForMorphisms",
      #"RightUnitorWithGivenTensorProduct",
      #"TensorProductOnMorphismsWithGivenTensorProducts",
      #"TensorProductOnObjects",
      #"TensorUnit",
    ]
);;

precompile_LeftPresentations := function( ring, name, operations )
    
    CapJitPrecompileCategoryAndCompareResult(
        ring -> LeftPresentations_as_FreydCategory_CategoryOfRows( ring ),
        [ ring ],
        "ModulePresentationsForCAP",
        Concatenation(
            "LeftPresentations_as_FreydCategory_CategoryOfRows_",
            name,
            "_precompiled"
        ) :
        operations := operations
    ); end;;

precompile_LeftPresentations(
    homalg_field, "Field", operations_for_commutative_ring
);;
precompile_LeftPresentations(
    commutative_homalg_ring, "CommutativeRing", operations_for_commutative_ring
);;
precompile_LeftPresentations(
    homalg_ring, "ArbitraryRing", operations_for_arbitrary_ring
);;

precompile_RightPresentations := function( ring, name, operations )
    
    CapJitPrecompileCategoryAndCompareResult(
        ring -> RightPresentations_as_FreydCategory_CategoryOfColumns( ring ),
        [ ring ],
        "ModulePresentationsForCAP",
        Concatenation(
            "RightPresentations_as_FreydCategory_CategoryOfColumns_",
            name,
            "_precompiled"
        ) :
        operations := operations,
        number_of_objectified_objects_in_data_structure_of_object := 1,
        number_of_objectified_morphisms_in_data_structure_of_object := 0,
        number_of_objectified_objects_in_data_structure_of_morphism := 2,
        number_of_objectified_morphisms_in_data_structure_of_morphism := 1
    ); end;;

precompile_RightPresentations(
    homalg_field, "Field", operations_for_commutative_ring
);;
precompile_RightPresentations(
    commutative_homalg_ring, "CommutativeRing", operations_for_commutative_ring
);;
precompile_RightPresentations(
    homalg_ring, "ArbitraryRing", operations_for_arbitrary_ring
);;


LeftPresentations( homalg_field )!.precompiled_functions_added;
#! true

LeftPresentations( commutative_homalg_ring )!.precompiled_functions_added;
#! true

LeftPresentations( homalg_ring )!.precompiled_functions_added;
#! true

RightPresentations( homalg_field )!.precompiled_functions_added;
#! true

RightPresentations( commutative_homalg_ring )!.precompiled_functions_added;
#! true

RightPresentations( homalg_ring )!.precompiled_functions_added;
#! true

# put the letter 'V' here to work around
# https://github.com/frankluebeck/GAPDoc/pull/61

#CapJitPrecompileCategoryAndCompareResult(
#    category_constructor,
#    given_arguments,
#    package_name,
#    compiled_category_name :
#    operations := operations
#);;


#FreydOfMatrixCategoryOfQUnfinalized := function( )
#  local Q, rows, freyd;
#    
#    Q := HomalgFieldOfRationalsInSingular();;
#    #rows := MatrixCategory( Q );;
#    rows := CategoryOfRows( Q );;
#    return FreydCategory( rows : FinalizeCategory := false, enable_compilation := true );;
#    
#end;
#
#freyd := FreydOfMatrixCategoryOfQUnfinalized();

#CapJitPreCompileCategory( freyd, FreydOfMatrixCategoryOfQUnfinalized, "FreydCategoriesForCAP", "FreydOfMatrixCategoryOfQ" );


#ColiftAlongEpimorphism( id, id );;
#
#Display(freyd!.compiled_functions.ColiftAlongEpimorphism[2]);
#! function ( cat, alpha, test_morphism )
#!     return ObjectifyWithAttributes( rec(
#!            ), cat!.morphism_type, CapCategory, cat, Source, Range( alpha ), 
#!        Range, Range( test_morphism ), MorphismDatum, 
#!        ObjectifyWithAttributes( rec(
#!              ), cat!.RangeCategoryOfHomomorphismStructure!.morphism_type, 
#!          CapCategory, cat!.RangeCategoryOfHomomorphismStructure, Source, 
#!          Source( 
#!            IdentityMorphism( Range( RelationMorphism( Range( alpha ) ) ) ) ), 
#!          Range, Range( MorphismDatum( test_morphism ) ), 
#!          UnderlyingFieldForHomalg, cat!.CommutativeRingOfLinearCategory, 
#!          UnderlyingMatrix, 
#!          RightDivide( 
#!              UnderlyingMatrix( 
#!                IdentityMorphism( Range( RelationMorphism( Range( alpha ) ) ) 
#!                  ) ), 
#!              CertainRows( 
#!                UnionOfRows( 
#!                  List( 
#!                    [ RelationMorphism( Range( alpha ) ), 
#!                       MorphismDatum( alpha ) ], function ( s )
#!                         return UnderlyingMatrix( s );
#!                     end ) ), 
#!                [ 
#!                   (
#!                      Sum( 
#!                        List( 
#!                          [ Source( RelationMorphism( Range( alpha ) ) ), 
#!                               Range( RelationMorphism( Source( alpha ) ) ) ]{
#!                            [ 1 .. 2 - 1 ]}, Dimension ) ) + 1) .. 
#!                   (
#!                      Sum( 
#!                            List( 
#!                              [ Source( RelationMorphism( Range( alpha ) ) ), 
#!                                   Range( RelationMorphism( Source( alpha ) ) 
#!                                      ) ]{[ 1 .. 2 - 1 ]}, Dimension ) ) + 1 
#!                       - 1 
#!                     + 
#!                       Dimension( 
#!                        [ Source( RelationMorphism( Range( alpha ) ) ), 
#!                             Range( RelationMorphism( Source( alpha ) ) ) ][2] 
#!                        )) ] ), 
#!              CertainRows( 
#!                UnionOfRows( 
#!                  List( 
#!                    [ RelationMorphism( Range( alpha ) ), 
#!                       MorphismDatum( alpha ) ], function ( s )
#!                         return UnderlyingMatrix( s );
#!                     end ) ), 
#!                Filtered( 
#!                  [ 1 .. 
#!                     NrRows( 
#!                        UnionOfRows( 
#!                          List( 
#!                            [ RelationMorphism( Range( alpha ) ), 
#!                               MorphismDatum( alpha ) ], function ( s )
#!                                 return UnderlyingMatrix( s );
#!                             end ) ) ) ], function ( logic_new_func_469_x )
#!                       return 
#!                        (
#!                          not logic_new_func_469_x 
#!                            in 
#!                              [ 
#!                                Sum( 
#!                                     List( 
#!                                       [ 
#!                                            Source( 
#!                                               RelationMorphism( 
#!                                                 Range( alpha ) ) ), 
#!                                            Range( 
#!                                               RelationMorphism( 
#!                                                 Source( alpha ) ) ) ]{
#!                                         [ 1 .. 2 - 1 ]}, Dimension ) ) + 1 .. 
#!                                Sum( List( [ Source( 
#!                                                   RelationMorphism( 
#!                                                     Range( alpha ) ) ), 
#!                                                Range( 
#!                                                   RelationMorphism( 
#!                                                     Source( alpha ) ) ) ]{
#!                                             [ 1 .. 2 - 1 ]}, Dimension ) ) + 1
#!                                    - 1 
#!                                  + 
#!                                    Dimension( 
#!                                     [ 
#!                                          Source( RelationMorphism( Range( alpha ) 
#!                                               ) ), 
#!                                          Range( 
#!                                             RelationMorphism( Source( alpha ) 
#!                                               ) ) ][2] ) ]);
#!                   end ) ) ) 
#!           * UnderlyingMatrix( MorphismDatum( test_morphism ) ) ) );
#! end

#! @EndExample
