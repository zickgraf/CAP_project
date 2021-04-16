#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );;

Q := HomalgFieldOfRationals();;
rows := MatrixCategory( Q );;
freyd := FreydCategory( rows :
    enable_compilation := [ "ColiftAlongEpimorphism" ]
);;
V := VectorSpaceObject( 2, Q );;
A := AsFreydCategoryObject( V );;
id := IdentityMorphism( A );;
ColiftAlongEpimorphism( id, id );;

Display(freyd!.compiled_functions.ColiftAlongEpimorphism[2]);
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
