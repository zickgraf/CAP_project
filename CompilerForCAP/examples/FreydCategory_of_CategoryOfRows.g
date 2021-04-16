#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );;

Q := HomalgFieldOfRationals();;
rows := CategoryOfRows( Q );;
freyd := FreydCategory( rows );;
V := ObjectConstructor( rows, 2 );;
A := AsFreydCategoryObject( V );;
id := IdentityMorphism( A );;
ColiftAlongEpimorphism( id, id );;

func := function ( cat, alpha, test_morphism )
    
    return ColiftAlongEpimorphism( cat, alpha, test_morphism );
    
end;

# CertainColumns( RightDivide( <two arguments> ) ) => RightDivide( <three arguments> )
# TODO: filters
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "B", "A", "list" ],
        src_template := "CertainColumns( SafeRightDivide( B, A ), list )",
        dst_template := "SafeRightDivide( B, CertainRows( A, list ), CertainRows( A, Difference( [ 1 .. NrRows( A ) ], list ) ) )",
        new_funcs := [ [ "x" ] ],
        #returns_value := true,
    )
);
CapJitAddTypeSignatureDeferred( "MatricesForHomalg", "SafeRightDivide", [ "IsHomalgMatrix", "IsHomalgMatrix", "IsHomalgMatrix" ], "IsHomalgMatrix" );

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "alpha" ],
        variable_filters := [ IsFreydCategoryMorphism ],
        src_template := "Range( RelationMorphism( Source( alpha ) ) )",
        dst_template := "Source( UnderlyingMorphism( alpha ) )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "alpha" ],
        variable_filters := [ IsCategoryOfRowsMorphism ],
        src_template := "RankOfObject( Source( alpha ) )",
        dst_template := "NumberRows( UnderlyingMatrix( alpha ) )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "2 - 1",
        dst_template := "1",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "entry1", "entry2" ],
        src_template := "[ entry1, entry2 ]{[ 1 ]}",
        dst_template := "[ entry1 ]",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "entry" ],
        src_template := "Sum( [ entry ] )",
        dst_template := "entry",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_cols", "A", "B" ],
        src_template := "CertainRows( UnionOfRows( ring, nr_cols, [ A, B ] ), [ NumberRows( A ) + 1 .. NumberRows( A ) + 1 - 1 + NumberRows( B ) ] )",
        dst_template := "B",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_cols", "A", "B" ],
        src_template := "CertainRows( UnionOfRows( ring, nr_cols, [ A, B ] ), Difference( [ 1 .. NumberRows( UnionOfRows( ring, nr_cols, [ A, B ] ) ) ], [ NumberRows( A ) + 1 .. NumberRows( A ) + 1 - 1 + NumberRows( B ) ] ) )",
        dst_template := "A",
    )
);

compiled_func := CapJitCompiledFunction( func, freyd, [ "category", "morphism", "morphism" ], "morphism" );

Display( compiled_func );

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

#! function ( cat_1, alpha_1, test_morphism_1 )
#!   local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1;
#!     deduped_5_1 := UnderlyingMorphism(
#!         test_morphism_1
#!     );
#!     deduped_4_1 := UnderlyingCategory(
#!         cat_1
#!     );
#!     deduped_3_1 := Range(
#!         alpha_1
#!     );
#!     deduped_2_1 := RelationMorphism(
#!         deduped_3_1
#!     );
#!     deduped_1_1 := Range(
#!         deduped_2_1
#!     );
#!     return (
#!         CreateCapCategoryMorphismWithAttributes(
#!             cat_1,
#!             deduped_3_1,
#!             Range(
#!                 test_morphism_1
#!             ),
#!             UnderlyingMorphism,
#!             CreateCapCategoryMorphismWithAttributes(
#!                 deduped_4_1,
#!                 deduped_1_1,
#!                 Range(
#!                     deduped_5_1
#!                 ),
#!                 UnderlyingMatrix,
#!                 SafeRightDivide(
#!                       HomalgIdentityMatrix(
#!                           RankOfObject(
#!                               deduped_1_1
#!                           ),
#!                           UnderlyingRing(
#!                               deduped_4_1
#!                           )
#!                       ),
#!                       UnderlyingMatrix(
#!                           UnderlyingMorphism(
#!                               alpha_1
#!                           )
#!                       ),
#!                       UnderlyingMatrix(
#!                           deduped_2_1
#!                       )
#!                   ) * UnderlyingMatrix(
#!                       deduped_5_1
#!                   )
#!             )
#!         )
#!     );
#! end
