#! @Chapter Examples and Tests

#! @Section Adelman snake lemma

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "Algebroid" );;
LoadPackage( "GeneralizedMorphismsForCAP" );;
LoadPackage( "profiling" );;

MY_GLOBAL_COUNTER := 0;
precompiled_func := 
function ( cat_1, mor1_1, mor2_1 )
    return UnionOfRows( UnderlyingRing( RangeCategoryOfHomomorphismStructure( cat_1 ) ), 
       Sum( Concatenation( List( ObjectList( Source( mor1_1 ) ), function ( logic_new_func_194_x_194_291 )
                  return List( ObjectList( Range( mor2_1 ) ), function ( logic_new_func_219_x_219_292 )
                          return Size( IncidenceMatrixOfBasisPaths( UnderlyingCategory( cat_1 ) )[VertexIndex( UnderlyingVertex( logic_new_func_194_x_194_291 ) )][
                               VertexIndex( UnderlyingVertex( logic_new_func_219_x_219_292 ) )] );
                      end );
              end ) ) ), List( [ 1 .. Length( [ 1 .. NumberColumns( mor1_1 ) ] ) ], function ( i_645_710_924 )
              local pulled_out_value3;
              pulled_out_value3 := IncidenceMatrixOfBasisPaths( UnderlyingCategory( cat_1 ) )[VertexIndex( UnderlyingVertex( Range( mor1_1 )[i_645_710_924] ) )];
              return UnionOfColumns( UnderlyingRing( RangeCategoryOfHomomorphismStructure( cat_1 ) ), 
                 Sum( List( [ 1 .. NumberRows( mor2_1 ) ], function ( logic_new_func_801_x_801_925 )
                          return Size( pulled_out_value3[
                               VertexIndex( UnderlyingVertex( Source( mor2_1 )[logic_new_func_801_x_801_925] ) )] );
                      end ) ), List( [ 1 .. NumberRows( mor1_1 ) ], function ( logic_new_func_831_x_831_926 )
                        local pulled_out_value1, pulled_out_value2, pulled_out_value4, pulled_out_value5, pulled_out_value6;
                        pulled_out_value1 := ZeroOfUnderlyingQuiverAlgebra( UnderlyingCategory( cat_1 ) ) 
                                                  = UnderlyingQuiverAlgebraElement( \[\,\]( mor1_1, logic_new_func_831_x_831_926, i_645_710_924 ) );
                        pulled_out_value2 := VertexIndex( UnderlyingVertex( Source( mor1_1 )[logic_new_func_831_x_831_926] ) );
                        pulled_out_value4 := IncidenceMatrixOfBasisPaths( UnderlyingCategory( cat_1 ) )[
                                                             VertexIndex( 
                                                              UnderlyingVertex( Range( \[\,\]( mor1_1, logic_new_func_831_x_831_926, i_645_710_924 ) ) ) )];
                        pulled_out_value5 := IncidenceMatrixOfBasisPaths( UnderlyingCategory( cat_1 ) )[
                                                             VertexIndex( 
                                                              UnderlyingVertex( Source( \[\,\]( mor1_1, logic_new_func_831_x_831_926, i_645_710_924 ) ) ) )];
                        pulled_out_value6 := UnderlyingQuiverAlgebraElement( \[\,\]( mor1_1, logic_new_func_831_x_831_926, 
                                                                           i_645_710_924 ) );
                        return UnionOfRows( UnderlyingRing( RangeCategoryOfHomomorphismStructure( cat_1 ) ), 
                           Sum( List( [ 1 .. NumberColumns( mor2_1 ) ], function ( logic_new_func_805_x_805_927 )
                                    return 
                                     Size( 
                                       IncidenceMatrixOfBasisPaths( UnderlyingCategory( cat_1 ) )[pulled_out_value2
                                           ][VertexIndex( UnderlyingVertex( Range( mor2_1 )[logic_new_func_805_x_805_927] ) )] );
                                end ) ), List( [ 1 .. Length( [ 1 .. NumberRows( mor2_1 ) ] ) ], function ( i_645_708_928 )
                                  local pulled_out_value7;
                                  pulled_out_value7 := VertexIndex( UnderlyingVertex( Source( mor2_1 )[i_645_708_928] ) );
                                  return UnionOfColumns( UnderlyingRing( RangeCategoryOfHomomorphismStructure( cat_1 ) ), 
                                     Size( pulled_out_value3[
                                         pulled_out_value7] ), List( [ 1 .. NumberColumns( mor2_1 ) ], 
                                       function ( logic_new_func_830_x_830_929 )
                                            if
                                              pulled_out_value1
                                                or ZeroOfUnderlyingQuiverAlgebra( UnderlyingCategory( cat_1 ) ) 
                                                  = UnderlyingQuiverAlgebraElement( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) then
                                                  
                                                  #return fail;
                                                  if 
                                                   Size( 
                                                     pulled_out_value3[
                                                       pulled_out_value7] ) = 0 or
                                                   Size( 
                                                     IncidenceMatrixOfBasisPaths( UnderlyingCategory( cat_1 ) )[
                                                         pulled_out_value2][
                                                       VertexIndex( UnderlyingVertex( Range( mor2_1 )[logic_new_func_830_x_830_929] ) )] ) = 0 then
                                                        
                                                        return fail;
                                                        
                                                    fi;
                                                  #MY_GLOBAL_COUNTER := MY_GLOBAL_COUNTER + 1;
                                                return 
                                                 HomalgZeroMatrix( 
                                                   Size( 
                                                     pulled_out_value3[
                                                       pulled_out_value7] ), 
                                                   Size( 
                                                     IncidenceMatrixOfBasisPaths( UnderlyingCategory( cat_1 ) )[
                                                         pulled_out_value2][
                                                       VertexIndex( UnderlyingVertex( Range( mor2_1 )[logic_new_func_830_x_830_929] ) )] ), 
                                                   UnderlyingRing( RangeCategoryOfHomomorphismStructure( cat_1 ) ) );
                                            else
                                                if
                                                 Size( pulled_out_value4[
                                                           VertexIndex( 
                                                            UnderlyingVertex( Source( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) )] )
                                                      = 0 
                                                    or 
                                                      Size( pulled_out_value5
                                                         
                                                            [
                                                           VertexIndex( 
                                                            UnderlyingVertex( Range( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) )] ) 
                                                      = 0 then
                                                      
                                                      return fail;
                                                      
                                                      #if Size( 
                                                      #   IncidenceMatrixOfBasisPaths( UnderlyingCategory( cat_1 ) )[
                                                      #       VertexIndex( 
                                                      #        UnderlyingVertex( Range( \[\,\]( mor1_1, logic_new_func_831_x_831_926, i_645_710_924 ) ) ) )][
                                                      #     VertexIndex( 
                                                      #      UnderlyingVertex( Source( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) )] ) = 0 or
                                                      #      Size( 
                                                      #   IncidenceMatrixOfBasisPaths( UnderlyingCategory( cat_1 ) )[
                                                      #       VertexIndex( 
                                                      #        UnderlyingVertex( Source( \[\,\]( mor1_1, logic_new_func_831_x_831_926, i_645_710_924 ) ) ) )]
                                                      #      [
                                                      #     VertexIndex( 
                                                      #      UnderlyingVertex( Range( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) )] ) = 0 then
                                                      #      
                                                      #      return fail;
                                                      #      
                                                      #  fi;
                                                      
                                                    return 
                                                     HomalgZeroMatrix( 
                                                       Size( 
                                                         pulled_out_value4[
                                                           VertexIndex( 
                                                            UnderlyingVertex( Source( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) )] )
                                                        , 
                                                       Size( 
                                                         pulled_out_value5
                                                            [
                                                           VertexIndex( 
                                                            UnderlyingVertex( Range( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) )] )
                                                        , UnderlyingRing( RangeCategoryOfHomomorphismStructure( cat_1 ) ) );
                                                else
                                                    return 
                                                     HomalgMatrix( 
                                                       List( 
                                                         pulled_out_value4[
                                                           VertexIndex( 
                                                            UnderlyingVertex( Source( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) )], 
                                                         function ( path_542_642_930 )
                                                              return 
                                                               CoefficientsOfPaths( 
                                                                 pulled_out_value5[
                                                                   VertexIndex( 
                                                                    UnderlyingVertex( Range( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) 
                                                                        ) ) )], 
                                                                 Representative( 
                                                                   pulled_out_value6 
                                                                      * PathAsAlgebraElement( UnderlyingQuiverAlgebra( UnderlyingCategory( cat_1 ) ), 
                                                                         path_542_642_930 ) 
                                                                    * UnderlyingQuiverAlgebraElement( 
                                                                       \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) );
                                                          end ), 
                                                       Size( 
                                                         pulled_out_value4[
                                                           VertexIndex( 
                                                            UnderlyingVertex( Source( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) )] )
                                                        , 
                                                       Size( 
                                                         pulled_out_value5
                                                            [
                                                           VertexIndex( 
                                                            UnderlyingVertex( Range( \[\,\]( mor2_1, i_645_708_928, logic_new_func_830_x_830_929 ) ) ) )] )
                                                        , UnderlyingRing( RangeCategoryOfHomomorphismStructure( cat_1 ) ) );
                                                fi;
                                            fi;
                                            return;
                                        end ) );
                              end ) );
                    end ) );
          end ) );
end;

precompiled_func2 := function ( cat_1, mor1_1, mor2_1 )
    return (
        (UnionOfRows)(
            (UnderlyingRing)(
                (RangeCategoryOfHomomorphismStructure)(
                    cat_1
                )
            ),
            (Sum)(
                (Concatenation)(
                    (List)(
                        (ObjectList)(
                            (Source)(
                                mor1_1
                            )
                        ),
                        function ( logic_new_func_255_x_255_372 )
                            return (
                                (List)(
                                    (ObjectList)(
                                        (Range)(
                                            mor2_1
                                        )
                                    ),
                                    function ( logic_new_func_285_x_285_373 )
                                        return (
                                            (Size)(
                                                (IncidenceMatrixOfBasisPaths)(
                                                    (UnderlyingCategory)(
                                                        cat_1
                                                    )
                                                )[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        logic_new_func_255_x_255_372
                                                    )
                                                )][(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        logic_new_func_285_x_285_373
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            );
                        end
                    )
                )
            ),
            (List)(
                [ 1 .. (NumberColumns)(
                        mor1_1
                    ) ],
                function ( logic_new_func_965_x_965_1096 )
                    return (
                        (UnionOfColumns)(
                            (UnderlyingRing)(
                                (RangeCategoryOfHomomorphismStructure)(
                                    cat_1
                                )
                            ),
                            (Sum)(
                                (List)(
                                    [ 1 .. (NumberRows)(
                                            mor2_1
                                        ) ],
                                    function ( logic_new_func_945_x_945_1097 )
                                        return (
                                            (Size)(
                                                (IncidenceMatrixOfBasisPaths)(
                                                    (UnderlyingCategory)(
                                                        cat_1
                                                    )
                                                )[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        (Range)(
                                                            mor1_1
                                                        )[logic_new_func_965_x_965_1096]
                                                    )
                                                )][(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        (Source)(
                                                            mor2_1
                                                        )[logic_new_func_945_x_945_1097]
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            ),
                            (List)(
                                [ 1 .. (NumberRows)(
                                        mor1_1
                                    ) ],
                                function ( logic_new_func_983_x_983_1098 )
                                    return (
                                        (UnionOfRows)(
                                            (UnderlyingRing)(
                                                (RangeCategoryOfHomomorphismStructure)(
                                                    cat_1
                                                )
                                            ),
                                            (Sum)(
                                                (List)(
                                                    [ 1 .. (NumberColumns)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_948_x_948_1099 )
                                                        return (
                                                            (Size)(
                                                                (IncidenceMatrixOfBasisPaths)(
                                                                    (UnderlyingCategory)(
                                                                        cat_1
                                                                    )
                                                                )[(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        (Source)(
                                                                            mor1_1
                                                                        )[logic_new_func_983_x_983_1098]
                                                                    )
                                                                )][(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        (Range)(
                                                                            mor2_1
                                                                        )[logic_new_func_948_x_948_1099]
                                                                    )
                                                                )]
                                                            )
                                                        );
                                                    end
                                                )
                                            ),
                                            (List)(
                                                [ 1 .. (NumberRows)(
                                                        mor2_1
                                                    ) ],
                                                function ( logic_new_func_964_x_964_1100 )
                                                    return (
                                                        (UnionOfColumns)(
                                                            (UnderlyingRing)(
                                                                (RangeCategoryOfHomomorphismStructure)(
                                                                    cat_1
                                                                )
                                                            ),
                                                            (Size)(
                                                                (IncidenceMatrixOfBasisPaths)(
                                                                    (UnderlyingCategory)(
                                                                        cat_1
                                                                    )
                                                                )[(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        (Range)(
                                                                            mor1_1
                                                                        )[logic_new_func_965_x_965_1096]
                                                                    )
                                                                )][(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        (Source)(
                                                                            mor2_1
                                                                        )[logic_new_func_964_x_964_1100]
                                                                    )
                                                                )]
                                                            ),
                                                            (List)(
                                                                [ 1 .. (NumberColumns)(
                                                                        mor2_1
                                                                    ) ],
                                                                function ( logic_new_func_982_x_982_1101 )
                                                                    if (ZeroOfUnderlyingQuiverAlgebra)(
                                                                                (UnderlyingCategory)(
                                                                                    cat_1
                                                                                )
                                                                            ) = (UnderlyingQuiverAlgebraElement)(
                                                                                (MatElm)(
                                                                                    mor1_1,
                                                                                    logic_new_func_983_x_983_1098,
                                                                                    logic_new_func_965_x_965_1096
                                                                                )
                                                                            ) or (ZeroOfUnderlyingQuiverAlgebra)(
                                                                                (UnderlyingCategory)(
                                                                                    cat_1
                                                                                )
                                                                            ) = (UnderlyingQuiverAlgebraElement)(
                                                                                (MatElm)(
                                                                                    mor2_1,
                                                                                    logic_new_func_964_x_964_1100,
                                                                                    logic_new_func_982_x_982_1101
                                                                                )
                                                                            )
                                                                    then
                                                                        return (
                                                                            (HomalgZeroMatrix)(
                                                                                (Size)(
                                                                                    (IncidenceMatrixOfBasisPaths)(
                                                                                        (UnderlyingCategory)(
                                                                                            cat_1
                                                                                        )
                                                                                    )[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Range)(
                                                                                                mor1_1
                                                                                            )[logic_new_func_965_x_965_1096]
                                                                                        )
                                                                                    )][(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Source)(
                                                                                                mor2_1
                                                                                            )[logic_new_func_964_x_964_1100]
                                                                                        )
                                                                                    )]
                                                                                ),
                                                                                (Size)(
                                                                                    (IncidenceMatrixOfBasisPaths)(
                                                                                        (UnderlyingCategory)(
                                                                                            cat_1
                                                                                        )
                                                                                    )[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Source)(
                                                                                                mor1_1
                                                                                            )[logic_new_func_983_x_983_1098]
                                                                                        )
                                                                                    )][(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Range)(
                                                                                                mor2_1
                                                                                            )[logic_new_func_982_x_982_1101]
                                                                                        )
                                                                                    )]
                                                                                ),
                                                                                (UnderlyingRing)(
                                                                                    (RangeCategoryOfHomomorphismStructure)(
                                                                                        cat_1
                                                                                    )
                                                                                )
                                                                            )
                                                                        );
                                                                    else
                                                                        return (
                                                                            (HomalgMatrix)(
                                                                                (List)(
                                                                                    (IncidenceMatrixOfBasisPaths)(
                                                                                        (UnderlyingCategory)(
                                                                                            cat_1
                                                                                        )
                                                                                    )[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Range)(
                                                                                                (MatElm)(
                                                                                                    mor1_1,
                                                                                                    logic_new_func_983_x_983_1098,
                                                                                                    logic_new_func_965_x_965_1096
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )][(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Source)(
                                                                                                (MatElm)(
                                                                                                    mor2_1,
                                                                                                    logic_new_func_964_x_964_1100,
                                                                                                    logic_new_func_982_x_982_1101
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )],
                                                                                    function ( path_557_897_1102 )
                                                                                        return (
                                                                                            (CoefficientsOfPaths)(
                                                                                                (IncidenceMatrixOfBasisPaths)(
                                                                                                    (UnderlyingCategory)(
                                                                                                        cat_1
                                                                                                    )
                                                                                                )[(VertexIndex)(
                                                                                                    (UnderlyingVertex)(
                                                                                                        (Source)(
                                                                                                            (MatElm)(
                                                                                                                mor1_1,
                                                                                                                logic_new_func_983_x_983_1098,
                                                                                                                logic_new_func_965_x_965_1096
                                                                                                            )
                                                                                                        )
                                                                                                    )
                                                                                                )][(VertexIndex)(
                                                                                                    (UnderlyingVertex)(
                                                                                                        (Range)(
                                                                                                            (MatElm)(
                                                                                                                mor2_1,
                                                                                                                logic_new_func_964_x_964_1100,
                                                                                                                logic_new_func_982_x_982_1101
                                                                                                            )
                                                                                                        )
                                                                                                    )
                                                                                                )],
                                                                                                (Representative)(
                                                                                                    (UnderlyingQuiverAlgebraElement)(
                                                                                                            (MatElm)(
                                                                                                                mor1_1,
                                                                                                                logic_new_func_983_x_983_1098,
                                                                                                                logic_new_func_965_x_965_1096
                                                                                                            )
                                                                                                        ) * (PathAsAlgebraElement)(
                                                                                                            (UnderlyingQuiverAlgebra)(
                                                                                                                (UnderlyingCategory)(
                                                                                                                    cat_1
                                                                                                                )
                                                                                                            ),
                                                                                                            path_557_897_1102
                                                                                                        ) * (UnderlyingQuiverAlgebraElement)(
                                                                                                          (MatElm)(
                                                                                                              mor2_1,
                                                                                                              logic_new_func_964_x_964_1100,
                                                                                                              logic_new_func_982_x_982_1101
                                                                                                          )
                                                                                                      )
                                                                                                )
                                                                                            )
                                                                                        );
                                                                                    end
                                                                                ),
                                                                                (Size)(
                                                                                    (IncidenceMatrixOfBasisPaths)(
                                                                                        (UnderlyingCategory)(
                                                                                            cat_1
                                                                                        )
                                                                                    )[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Range)(
                                                                                                (MatElm)(
                                                                                                    mor1_1,
                                                                                                    logic_new_func_983_x_983_1098,
                                                                                                    logic_new_func_965_x_965_1096
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )][(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Source)(
                                                                                                (MatElm)(
                                                                                                    mor2_1,
                                                                                                    logic_new_func_964_x_964_1100,
                                                                                                    logic_new_func_982_x_982_1101
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )]
                                                                                ),
                                                                                (Size)(
                                                                                    (IncidenceMatrixOfBasisPaths)(
                                                                                        (UnderlyingCategory)(
                                                                                            cat_1
                                                                                        )
                                                                                    )[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Source)(
                                                                                                (MatElm)(
                                                                                                    mor1_1,
                                                                                                    logic_new_func_983_x_983_1098,
                                                                                                    logic_new_func_965_x_965_1096
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )][(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Range)(
                                                                                                (MatElm)(
                                                                                                    mor2_1,
                                                                                                    logic_new_func_964_x_964_1100,
                                                                                                    logic_new_func_982_x_982_1101
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )]
                                                                                ),
                                                                                (UnderlyingRing)(
                                                                                    (RangeCategoryOfHomomorphismStructure)(
                                                                                        cat_1
                                                                                    )
                                                                                )
                                                                            )
                                                                        );
                                                                    fi;
                                                                    return;
                                                                end
                                                            )
                                                        )
                                                    );
                                                end
                                            )
                                        )
                                    );
                                end
                            )
                        )
                    );
                end
            )
        )
    );
end;

precompiled_func3 := function ( cat_1, mor1_1, mor2_1 )
  local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1;
    cap_jit_hoisted_expression_1_1 := (Range)(
        mor1_1
    );
    cap_jit_hoisted_expression_2_1 := (Source)(
        mor2_1
    );
    cap_jit_hoisted_expression_3_1 := (Source)(
        mor1_1
    );
    cap_jit_hoisted_expression_4_1 := (Range)(
        mor2_1
    );
    return (
        (UnionOfRows)(
            (UnderlyingRing)(
                (RangeCategoryOfHomomorphismStructure)(
                    cat_1
                )
            ),
            (Sum)(
                (Concatenation)(
                    (List)(
                        (ObjectList)(
                            (Source)(
                                mor1_1
                            )
                        ),
                        function ( logic_new_func_255_x_255_372 )
                          local cap_jit_hoisted_expression_5_372;
                            cap_jit_hoisted_expression_5_372 := (IncidenceMatrixOfBasisPaths)(
                                (UnderlyingCategory)(
                                    cat_1
                                )
                            )[(VertexIndex)(
                                (UnderlyingVertex)(
                                    logic_new_func_255_x_255_372
                                )
                            )];
                            return (
                                (List)(
                                    (ObjectList)(
                                        (Range)(
                                            mor2_1
                                        )
                                    ),
                                    function ( logic_new_func_285_x_285_373 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_5_372[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        logic_new_func_285_x_285_373
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            );
                        end
                    )
                )
            ),
            (List)(
                [ 1 .. (NumberColumns)(
                        mor1_1
                    ) ],
                function ( logic_new_func_965_x_965_1096 )
                  local cap_jit_hoisted_expression_6_1096;
                    cap_jit_hoisted_expression_6_1096 := (IncidenceMatrixOfBasisPaths)(
                        (UnderlyingCategory)(
                            cat_1
                        )
                    )[(VertexIndex)(
                        (UnderlyingVertex)(
                            cap_jit_hoisted_expression_1_1[logic_new_func_965_x_965_1096]
                        )
                    )];
                    return (
                        (UnionOfColumns)(
                            (UnderlyingRing)(
                                (RangeCategoryOfHomomorphismStructure)(
                                    cat_1
                                )
                            ),
                            (Sum)(
                                (List)(
                                    [ 1 .. (NumberRows)(
                                            mor2_1
                                        ) ],
                                    function ( logic_new_func_945_x_945_1097 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_6_1096[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        cap_jit_hoisted_expression_2_1[logic_new_func_945_x_945_1097]
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            ),
                            (List)(
                                [ 1 .. (NumberRows)(
                                        mor1_1
                                    ) ],
                                function ( logic_new_func_983_x_983_1098 )
                                  local cap_jit_hoisted_expression_7_1098, cap_jit_hoisted_expression_8_1098, cap_jit_hoisted_expression_9_1098, cap_jit_hoisted_expression_10_1098, cap_jit_hoisted_expression_11_1098;
                                    cap_jit_hoisted_expression_7_1098 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            cap_jit_hoisted_expression_3_1[logic_new_func_983_x_983_1098]
                                        )
                                    )];
                                    cap_jit_hoisted_expression_8_1098 := (ZeroOfUnderlyingQuiverAlgebra)(
                                          (UnderlyingCategory)(
                                              cat_1
                                          )
                                      ) = (UnderlyingQuiverAlgebraElement)(
                                          (MatElm)(
                                              mor1_1,
                                              logic_new_func_983_x_983_1098,
                                              logic_new_func_965_x_965_1096
                                          )
                                      );
                                    cap_jit_hoisted_expression_9_1098 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            (Range)(
                                                (MatElm)(
                                                    mor1_1,
                                                    logic_new_func_983_x_983_1098,
                                                    logic_new_func_965_x_965_1096
                                                )
                                            )
                                        )
                                    )];
                                    cap_jit_hoisted_expression_10_1098 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            (Source)(
                                                (MatElm)(
                                                    mor1_1,
                                                    logic_new_func_983_x_983_1098,
                                                    logic_new_func_965_x_965_1096
                                                )
                                            )
                                        )
                                    )];
                                    cap_jit_hoisted_expression_11_1098 := (UnderlyingQuiverAlgebraElement)(
                                        (MatElm)(
                                            mor1_1,
                                            logic_new_func_983_x_983_1098,
                                            logic_new_func_965_x_965_1096
                                        )
                                    );
                                    return (
                                        (UnionOfRows)(
                                            (UnderlyingRing)(
                                                (RangeCategoryOfHomomorphismStructure)(
                                                    cat_1
                                                )
                                            ),
                                            (Sum)(
                                                (List)(
                                                    [ 1 .. (NumberColumns)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_948_x_948_1099 )
                                                        return (
                                                            (Size)(
                                                                cap_jit_hoisted_expression_7_1098[(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        cap_jit_hoisted_expression_4_1[logic_new_func_948_x_948_1099]
                                                                    )
                                                                )]
                                                            )
                                                        );
                                                    end
                                                )
                                            ),
                                            (List)(
                                                [ 1 .. (NumberRows)(
                                                        mor2_1
                                                    ) ],
                                                function ( logic_new_func_964_x_964_1100 )
                                                    return (
                                                        (UnionOfColumns)(
                                                            (UnderlyingRing)(
                                                                (RangeCategoryOfHomomorphismStructure)(
                                                                    cat_1
                                                                )
                                                            ),
                                                            (Size)(
                                                                cap_jit_hoisted_expression_6_1096[(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        cap_jit_hoisted_expression_2_1[logic_new_func_964_x_964_1100]
                                                                    )
                                                                )]
                                                            ),
                                                            (List)(
                                                                [ 1 .. (NumberColumns)(
                                                                        mor2_1
                                                                    ) ],
                                                                function ( logic_new_func_982_x_982_1101 )
                                                                  local cap_jit_hoisted_expression_12_1101;
                                                                    cap_jit_hoisted_expression_12_1101 := (UnderlyingQuiverAlgebraElement)(
                                                                        (MatElm)(
                                                                            mor2_1,
                                                                            logic_new_func_964_x_964_1100,
                                                                            logic_new_func_982_x_982_1101
                                                                        )
                                                                    );
                                                                    if cap_jit_hoisted_expression_8_1098 or (ZeroOfUnderlyingQuiverAlgebra)(
                                                                                (UnderlyingCategory)(
                                                                                    cat_1
                                                                                )
                                                                            ) = (UnderlyingQuiverAlgebraElement)(
                                                                                (MatElm)(
                                                                                    mor2_1,
                                                                                    logic_new_func_964_x_964_1100,
                                                                                    logic_new_func_982_x_982_1101
                                                                                )
                                                                            )
                                                                    then
                                                                        
                                                                        if (Size)(
                                                                                    cap_jit_hoisted_expression_6_1096[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            cap_jit_hoisted_expression_2_1[logic_new_func_964_x_964_1100]
                                                                                        )
                                                                                    )]
                                                                                ) = 0 or (Size)(
                                                                                    cap_jit_hoisted_expression_7_1098[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_982_x_982_1101]
                                                                                        )
                                                                                    )]
                                                                                ) = 0 then
                                                                                
                                                                                #return fail;
                                                                                
                                                                        fi;
                                                                        
                                                                        return (
                                                                            (HomalgZeroMatrix)(
                                                                                (Size)(
                                                                                    cap_jit_hoisted_expression_6_1096[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            cap_jit_hoisted_expression_2_1[logic_new_func_964_x_964_1100]
                                                                                        )
                                                                                    )]
                                                                                ),
                                                                                (Size)(
                                                                                    cap_jit_hoisted_expression_7_1098[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_982_x_982_1101]
                                                                                        )
                                                                                    )]
                                                                                ),
                                                                                (UnderlyingRing)(
                                                                                    (RangeCategoryOfHomomorphismStructure)(
                                                                                        cat_1
                                                                                    )
                                                                                )
                                                                            )
                                                                        );
                                                                    else
                                                                        return (
                                                                            (HomalgMatrix)(
                                                                                (List)(
                                                                                    cap_jit_hoisted_expression_9_1098[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Source)(
                                                                                                (MatElm)(
                                                                                                    mor2_1,
                                                                                                    logic_new_func_964_x_964_1100,
                                                                                                    logic_new_func_982_x_982_1101
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )],
                                                                                    function ( path_557_897_1102 )
                                                                                        return (
                                                                                            (CoefficientsOfPaths)(
                                                                                                cap_jit_hoisted_expression_10_1098[(VertexIndex)(
                                                                                                    (UnderlyingVertex)(
                                                                                                        (Range)(
                                                                                                            (MatElm)(
                                                                                                                mor2_1,
                                                                                                                logic_new_func_964_x_964_1100,
                                                                                                                logic_new_func_982_x_982_1101
                                                                                                            )
                                                                                                        )
                                                                                                    )
                                                                                                )],
                                                                                                (Representative)(
                                                                                                    cap_jit_hoisted_expression_11_1098 * (PathAsAlgebraElement)(
                                                                                                            (UnderlyingQuiverAlgebra)(
                                                                                                                (UnderlyingCategory)(
                                                                                                                    cat_1
                                                                                                                )
                                                                                                            ),
                                                                                                            path_557_897_1102
                                                                                                        ) * cap_jit_hoisted_expression_12_1101
                                                                                                )
                                                                                            )
                                                                                        );
                                                                                    end
                                                                                ),
                                                                                (Size)(
                                                                                    cap_jit_hoisted_expression_9_1098[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Source)(
                                                                                                (MatElm)(
                                                                                                    mor2_1,
                                                                                                    logic_new_func_964_x_964_1100,
                                                                                                    logic_new_func_982_x_982_1101
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )]
                                                                                ),
                                                                                (Size)(
                                                                                    cap_jit_hoisted_expression_10_1098[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Range)(
                                                                                                (MatElm)(
                                                                                                    mor2_1,
                                                                                                    logic_new_func_964_x_964_1100,
                                                                                                    logic_new_func_982_x_982_1101
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )]
                                                                                ),
                                                                                (UnderlyingRing)(
                                                                                    (RangeCategoryOfHomomorphismStructure)(
                                                                                        cat_1
                                                                                    )
                                                                                )
                                                                            )
                                                                        );
                                                                    fi;
                                                                    return;
                                                                end
                                                            )
                                                        )
                                                    );
                                                end
                                            )
                                        )
                                    );
                                end
                            )
                        )
                    );
                end
            )
        )
    );
end;

precompiled_func4 := function ( cat_1, mor1_1, mor2_1 )
  local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1;
    cap_jit_hoisted_expression_1_1 := (Range)(
        mor1_1
    );
    cap_jit_hoisted_expression_2_1 := (Source)(
        mor2_1
    );
    cap_jit_hoisted_expression_3_1 := (Source)(
        mor1_1
    );
    cap_jit_hoisted_expression_4_1 := (Range)(
        mor2_1
    );
    return (
        (UnionOfRows)(
            (UnderlyingRing)(
                (RangeCategoryOfHomomorphismStructure)(
                    cat_1
                )
            ),
            (Sum)(
                (Concatenation)(
                    (List)(
                        (ObjectList)(
                            (Source)(
                                mor1_1
                            )
                        ),
                        function ( logic_new_func_325_x_325_482 )
                          local cap_jit_hoisted_expression_5_482;
                            cap_jit_hoisted_expression_5_482 := (IncidenceMatrixOfBasisPaths)(
                                (UnderlyingCategory)(
                                    cat_1
                                )
                            )[(VertexIndex)(
                                (UnderlyingVertex)(
                                    logic_new_func_325_x_325_482
                                )
                            )];
                            return (
                                (List)(
                                    (ObjectList)(
                                        (Range)(
                                            mor2_1
                                        )
                                    ),
                                    function ( logic_new_func_365_x_365_483 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_5_482[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        logic_new_func_365_x_365_483
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            );
                        end
                    )
                )
            ),
            (List)(
                [ 1 .. (NumberColumns)(
                        mor1_1
                    ) ],
                function ( logic_new_func_1225_x_1225_1410 )
                  local cap_jit_hoisted_expression_6_1410;
                    cap_jit_hoisted_expression_6_1410 := (IncidenceMatrixOfBasisPaths)(
                        (UnderlyingCategory)(
                            cat_1
                        )
                    )[(VertexIndex)(
                        (UnderlyingVertex)(
                            cap_jit_hoisted_expression_1_1[logic_new_func_1225_x_1225_1410]
                        )
                    )];
                    return (
                        (UnionOfColumns)(
                            (UnderlyingRing)(
                                (RangeCategoryOfHomomorphismStructure)(
                                    cat_1
                                )
                            ),
                            (Sum)(
                                (List)(
                                    [ 1 .. (NumberRows)(
                                            mor2_1
                                        ) ],
                                    function ( logic_new_func_1205_x_1205_1411 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_6_1410[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        cap_jit_hoisted_expression_2_1[logic_new_func_1205_x_1205_1411]
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            ),
                            (List)(
                                [ 1 .. (NumberRows)(
                                        mor1_1
                                    ) ],
                                function ( logic_new_func_1253_x_1253_1412 )
                                  local cap_jit_hoisted_expression_7_1412, cap_jit_hoisted_expression_8_1412, cap_jit_hoisted_expression_9_1412, cap_jit_hoisted_expression_10_1412;
                                    cap_jit_hoisted_expression_7_1412 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            cap_jit_hoisted_expression_3_1[logic_new_func_1253_x_1253_1412]
                                        )
                                    )];
                                    cap_jit_hoisted_expression_8_1412 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            (Range)(
                                                (MatElm)(
                                                    mor1_1,
                                                    logic_new_func_1253_x_1253_1412,
                                                    logic_new_func_1225_x_1225_1410
                                                )
                                            )
                                        )
                                    )];
                                    cap_jit_hoisted_expression_9_1412 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            (Source)(
                                                (MatElm)(
                                                    mor1_1,
                                                    logic_new_func_1253_x_1253_1412,
                                                    logic_new_func_1225_x_1225_1410
                                                )
                                            )
                                        )
                                    )];
                                    cap_jit_hoisted_expression_10_1412 := (UnderlyingQuiverAlgebraElement)(
                                        (MatElm)(
                                            mor1_1,
                                            logic_new_func_1253_x_1253_1412,
                                            logic_new_func_1225_x_1225_1410
                                        )
                                    );
                                    if (ZeroOfUnderlyingQuiverAlgebra)(
                                              (UnderlyingCategory)(
                                                  cat_1
                                              )
                                          ) = (UnderlyingQuiverAlgebraElement)(
                                              (MatElm)(
                                                  mor1_1,
                                                  logic_new_func_1253_x_1253_1412,
                                                  logic_new_func_1225_x_1225_1410
                                              )
                                          )
                                    then
                                        return (
                                            (HomalgZeroMatrix)(
                                                (Sum)(
                                                    [ 1 .. (NumberRows)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_1224_x_1368_1413 )
                                                        return (
                                                            (Size)(
                                                                cap_jit_hoisted_expression_6_1410[(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        cap_jit_hoisted_expression_2_1[logic_new_func_1224_x_1368_1413]
                                                                    )
                                                                )]
                                                            )
                                                        );
                                                    end
                                                ),
                                                (Sum)(
                                                    (List)(
                                                        [ 1 .. (NumberColumns)(
                                                                mor2_1
                                                            ) ],
                                                        function ( logic_new_func_1208_x_1208_1414 )
                                                            return (
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_7_1412[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1208_x_1208_1414]
                                                                        )
                                                                    )]
                                                                )
                                                            );
                                                        end
                                                    )
                                                ),
                                                (UnderlyingRing)(
                                                    (RangeCategoryOfHomomorphismStructure)(
                                                        cat_1
                                                    )
                                                )
                                            )
                                        );
                                    else
                                        return (
                                            (UnionOfRows)(
                                                (UnderlyingRing)(
                                                    (RangeCategoryOfHomomorphismStructure)(
                                                        cat_1
                                                    )
                                                ),
                                                (Sum)(
                                                    (List)(
                                                        [ 1 .. (NumberColumns)(
                                                                mor2_1
                                                            ) ],
                                                        function ( logic_new_func_1208_x_1208_1415 )
                                                            return (
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_7_1412[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1208_x_1208_1415]
                                                                        )
                                                                    )]
                                                                )
                                                            );
                                                        end
                                                    )
                                                ),
                                                (List)(
                                                    [ 1 .. (NumberRows)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_1224_x_1369_1416 )
                                                        return (
                                                            (UnionOfColumns)(
                                                                (UnderlyingRing)(
                                                                    (RangeCategoryOfHomomorphismStructure)(
                                                                        cat_1
                                                                    )
                                                                ),
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_6_1410[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_2_1[logic_new_func_1224_x_1369_1416]
                                                                        )
                                                                    )]
                                                                ),
                                                                (List)(
                                                                    [ 1 .. (NumberColumns)(
                                                                            mor2_1
                                                                        ) ],
                                                                    function ( logic_new_func_1252_x_1362_1417 )
                                                                      local cap_jit_hoisted_expression_11_1417;
                                                                        cap_jit_hoisted_expression_11_1417 := (UnderlyingQuiverAlgebraElement)(
                                                                            (MatElm)(
                                                                                mor2_1,
                                                                                logic_new_func_1224_x_1369_1416,
                                                                                logic_new_func_1252_x_1362_1417
                                                                            )
                                                                        );
                                                                        if (ZeroOfUnderlyingQuiverAlgebra)(
                                                                                  (UnderlyingCategory)(
                                                                                      cat_1
                                                                                  )
                                                                              ) = (UnderlyingQuiverAlgebraElement)(
                                                                                  (MatElm)(
                                                                                      mor2_1,
                                                                                      logic_new_func_1224_x_1369_1416,
                                                                                      logic_new_func_1252_x_1362_1417
                                                                                  )
                                                                              )
                                                                        then
                                                                            return (
                                                                                (HomalgZeroMatrix)(
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_6_1410[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_2_1[logic_new_func_1224_x_1369_1416]
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_7_1412[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_4_1[logic_new_func_1252_x_1362_1417]
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (UnderlyingRing)(
                                                                                        (RangeCategoryOfHomomorphismStructure)(
                                                                                            cat_1
                                                                                        )
                                                                                    )
                                                                                )
                                                                            );
                                                                        else
                                                                            return (
                                                                                (HomalgMatrix)(
                                                                                    (List)(
                                                                                        cap_jit_hoisted_expression_8_1412[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                (Source)(
                                                                                                    (MatElm)(
                                                                                                        mor2_1,
                                                                                                        logic_new_func_1224_x_1369_1416,
                                                                                                        logic_new_func_1252_x_1362_1417
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )],
                                                                                        function ( path_707_1147_1418 )
                                                                                            return (
                                                                                                (CoefficientsOfPaths)(
                                                                                                    cap_jit_hoisted_expression_9_1412[(VertexIndex)(
                                                                                                        (UnderlyingVertex)(
                                                                                                            (Range)(
                                                                                                                (MatElm)(
                                                                                                                    mor2_1,
                                                                                                                    logic_new_func_1224_x_1369_1416,
                                                                                                                    logic_new_func_1252_x_1362_1417
                                                                                                                )
                                                                                                            )
                                                                                                        )
                                                                                                    )],
                                                                                                    (Representative)(
                                                                                                        cap_jit_hoisted_expression_10_1412 * (PathAsAlgebraElement)(
                                                                                                                (UnderlyingQuiverAlgebra)(
                                                                                                                    (UnderlyingCategory)(
                                                                                                                        cat_1
                                                                                                                    )
                                                                                                                ),
                                                                                                                path_707_1147_1418
                                                                                                            ) * cap_jit_hoisted_expression_11_1417
                                                                                                    )
                                                                                                )
                                                                                            );
                                                                                        end
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_8_1412[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                (Source)(
                                                                                                    (MatElm)(
                                                                                                        mor2_1,
                                                                                                        logic_new_func_1224_x_1369_1416,
                                                                                                        logic_new_func_1252_x_1362_1417
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_9_1412[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                (Range)(
                                                                                                    (MatElm)(
                                                                                                        mor2_1,
                                                                                                        logic_new_func_1224_x_1369_1416,
                                                                                                        logic_new_func_1252_x_1362_1417
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (UnderlyingRing)(
                                                                                        (RangeCategoryOfHomomorphismStructure)(
                                                                                            cat_1
                                                                                        )
                                                                                    )
                                                                                )
                                                                            );
                                                                        fi;
                                                                        return;
                                                                    end
                                                                )
                                                            )
                                                        );
                                                    end
                                                )
                                            )
                                        );
                                    fi;
                                    return;
                                end
                            )
                        )
                    );
                end
            )
        )
    );
end;

precompiled_func5 := function ( cat_1, mor1_1, mor2_1 )
  local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1;
    cap_jit_hoisted_expression_1_1 := (Range)(
        mor1_1
    );
    cap_jit_hoisted_expression_2_1 := (Source)(
        mor2_1
    );
    cap_jit_hoisted_expression_3_1 := (Source)(
        mor1_1
    );
    cap_jit_hoisted_expression_4_1 := (Range)(
        mor2_1
    );
    return (
        (UnionOfRows)(
            (UnderlyingRing)(
                (RangeCategoryOfHomomorphismStructure)(
                    cat_1
                )
            ),
            (Sum)(
                (Concatenation)(
                    (List)(
                        (ObjectList)(
                            (Source)(
                                mor1_1
                            )
                        ),
                        function ( logic_new_func_325_x_325_482 )
                          local cap_jit_hoisted_expression_5_482;
                            cap_jit_hoisted_expression_5_482 := (IncidenceMatrixOfBasisPaths)(
                                (UnderlyingCategory)(
                                    cat_1
                                )
                            )[(VertexIndex)(
                                (UnderlyingVertex)(
                                    logic_new_func_325_x_325_482
                                )
                            )];
                            return (
                                (List)(
                                    (ObjectList)(
                                        (Range)(
                                            mor2_1
                                        )
                                    ),
                                    function ( logic_new_func_365_x_365_483 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_5_482[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        logic_new_func_365_x_365_483
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            );
                        end
                    )
                )
            ),
            (List)(
                [ 1 .. (NumberColumns)(
                        mor1_1
                    ) ],
                function ( logic_new_func_1225_x_1225_1412 )
                  local cap_jit_hoisted_expression_6_1412;
                    cap_jit_hoisted_expression_6_1412 := (IncidenceMatrixOfBasisPaths)(
                        (UnderlyingCategory)(
                            cat_1
                        )
                    )[(VertexIndex)(
                        (UnderlyingVertex)(
                            cap_jit_hoisted_expression_1_1[logic_new_func_1225_x_1225_1412]
                        )
                    )];
                    return (
                        (UnionOfColumns)(
                            (UnderlyingRing)(
                                (RangeCategoryOfHomomorphismStructure)(
                                    cat_1
                                )
                            ),
                            (Sum)(
                                (List)(
                                    [ 1 .. (NumberRows)(
                                            mor2_1
                                        ) ],
                                    function ( logic_new_func_1205_x_1205_1413 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_6_1412[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        cap_jit_hoisted_expression_2_1[logic_new_func_1205_x_1205_1413]
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            ),
                            (List)(
                                [ 1 .. (NumberRows)(
                                        mor1_1
                                    ) ],
                                function ( logic_new_func_1253_x_1253_1414 )
                                  local cap_jit_hoisted_expression_7_1414, cap_jit_hoisted_expression_8_1414, cap_jit_hoisted_expression_9_1414, cap_jit_hoisted_expression_10_1414;
                                    cap_jit_hoisted_expression_7_1414 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            cap_jit_hoisted_expression_3_1[logic_new_func_1253_x_1253_1414]
                                        )
                                    )];
                                    cap_jit_hoisted_expression_8_1414 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            (Range)(
                                                (MatElm)(
                                                    mor1_1,
                                                    logic_new_func_1253_x_1253_1414,
                                                    logic_new_func_1225_x_1225_1412
                                                )
                                            )
                                        )
                                    )];
                                    cap_jit_hoisted_expression_9_1414 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            (Source)(
                                                (MatElm)(
                                                    mor1_1,
                                                    logic_new_func_1253_x_1253_1414,
                                                    logic_new_func_1225_x_1225_1412
                                                )
                                            )
                                        )
                                    )];
                                    cap_jit_hoisted_expression_10_1414 := (UnderlyingQuiverAlgebraElement)(
                                        (MatElm)(
                                            mor1_1,
                                            logic_new_func_1253_x_1253_1414,
                                            logic_new_func_1225_x_1225_1412
                                        )
                                    );
                                    if (ZeroOfUnderlyingQuiverAlgebra)(
                                              (UnderlyingCategory)(
                                                  cat_1
                                              )
                                          ) = (UnderlyingQuiverAlgebraElement)(
                                              (MatElm)(
                                                  mor1_1,
                                                  logic_new_func_1253_x_1253_1414,
                                                  logic_new_func_1225_x_1225_1412
                                              )
                                          )
                                    then
                                        return (
                                            (HomalgZeroMatrix)(
                                                (Sum)(
                                                    [ 1 .. (NumberRows)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_1224_x_1368_1415 )
                                                        return (
                                                            (Size)(
                                                                cap_jit_hoisted_expression_6_1412[(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        cap_jit_hoisted_expression_2_1[logic_new_func_1224_x_1368_1415]
                                                                    )
                                                                )]
                                                            )
                                                        );
                                                    end
                                                ),
                                                (Sum)(
                                                    (List)(
                                                        [ 1 .. (NumberColumns)(
                                                                mor2_1
                                                            ) ],
                                                        function ( logic_new_func_1208_x_1208_1416 )
                                                            return (
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_7_1414[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1208_x_1208_1416]
                                                                        )
                                                                    )]
                                                                )
                                                            );
                                                        end
                                                    )
                                                ),
                                                (UnderlyingRing)(
                                                    (RangeCategoryOfHomomorphismStructure)(
                                                        cat_1
                                                    )
                                                )
                                            )
                                        );
                                    else
                                        return (
                                            (UnionOfRows)(
                                                (UnderlyingRing)(
                                                    (RangeCategoryOfHomomorphismStructure)(
                                                        cat_1
                                                    )
                                                ),
                                                (Sum)(
                                                    (List)(
                                                        [ 1 .. (NumberColumns)(
                                                                mor2_1
                                                            ) ],
                                                        function ( logic_new_func_1208_x_1208_1417 )
                                                            return (
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_7_1414[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1208_x_1208_1417]
                                                                        )
                                                                    )]
                                                                )
                                                            );
                                                        end
                                                    )
                                                ),
                                                (List)(
                                                    [ 1 .. (NumberRows)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_1224_x_1369_1418 )
                                                        return (
                                                            (UnionOfColumns)(
                                                                (UnderlyingRing)(
                                                                    (RangeCategoryOfHomomorphismStructure)(
                                                                        cat_1
                                                                    )
                                                                ),
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_6_1412[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_2_1[logic_new_func_1224_x_1369_1418]
                                                                        )
                                                                    )]
                                                                ),
                                                                (List)(
                                                                    [ 1 .. (NumberColumns)(
                                                                            mor2_1
                                                                        ) ],
                                                                    function ( logic_new_func_1252_x_1362_1419 )
                                                                      local cap_jit_hoisted_expression_11_1419;
                                                                        cap_jit_hoisted_expression_11_1419 := (UnderlyingQuiverAlgebraElement)(
                                                                            (MatElm)(
                                                                                mor2_1,
                                                                                logic_new_func_1224_x_1369_1418,
                                                                                logic_new_func_1252_x_1362_1419
                                                                            )
                                                                        );
                                                                        if (ZeroOfUnderlyingQuiverAlgebra)(
                                                                                      (UnderlyingCategory)(
                                                                                          cat_1
                                                                                      )
                                                                                  ) = (UnderlyingQuiverAlgebraElement)(
                                                                                      (MatElm)(
                                                                                          mor2_1,
                                                                                          logic_new_func_1224_x_1369_1418,
                                                                                          logic_new_func_1252_x_1362_1419
                                                                                      )
                                                                                  ) or (Size)(
                                                                                      cap_jit_hoisted_expression_8_1414[(VertexIndex)(
                                                                                          (UnderlyingVertex)(
                                                                                              (Source)(
                                                                                                  (MatElm)(
                                                                                                      mor2_1,
                                                                                                      logic_new_func_1224_x_1369_1418,
                                                                                                      logic_new_func_1252_x_1362_1419
                                                                                                  )
                                                                                              )
                                                                                          )
                                                                                      )]
                                                                                  ) = 0 or (Size)(
                                                                                    cap_jit_hoisted_expression_9_1414[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            (Range)(
                                                                                                (MatElm)(
                                                                                                    mor2_1,
                                                                                                    logic_new_func_1224_x_1369_1418,
                                                                                                    logic_new_func_1252_x_1362_1419
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                    )]
                                                                                ) = 0
                                                                        then
                                                                            return (
                                                                                (HomalgZeroMatrix)(
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_6_1412[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_2_1[logic_new_func_1224_x_1369_1418]
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_7_1414[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_4_1[logic_new_func_1252_x_1362_1419]
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (UnderlyingRing)(
                                                                                        (RangeCategoryOfHomomorphismStructure)(
                                                                                            cat_1
                                                                                        )
                                                                                    )
                                                                                )
                                                                            );
                                                                        else
                                                                            return (
                                                                                (HomalgMatrix)(
                                                                                    (List)(
                                                                                        cap_jit_hoisted_expression_8_1414[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                (Source)(
                                                                                                    (MatElm)(
                                                                                                        mor2_1,
                                                                                                        logic_new_func_1224_x_1369_1418,
                                                                                                        logic_new_func_1252_x_1362_1419
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )],
                                                                                        function ( path_707_1147_1420 )
                                                                                            return (
                                                                                                (CoefficientsOfPaths)(
                                                                                                    cap_jit_hoisted_expression_9_1414[(VertexIndex)(
                                                                                                        (UnderlyingVertex)(
                                                                                                            (Range)(
                                                                                                                (MatElm)(
                                                                                                                    mor2_1,
                                                                                                                    logic_new_func_1224_x_1369_1418,
                                                                                                                    logic_new_func_1252_x_1362_1419
                                                                                                                )
                                                                                                            )
                                                                                                        )
                                                                                                    )],
                                                                                                    (Representative)(
                                                                                                        cap_jit_hoisted_expression_10_1414 * (PathAsAlgebraElement)(
                                                                                                                (UnderlyingQuiverAlgebra)(
                                                                                                                    (UnderlyingCategory)(
                                                                                                                        cat_1
                                                                                                                    )
                                                                                                                ),
                                                                                                                path_707_1147_1420
                                                                                                            ) * cap_jit_hoisted_expression_11_1419
                                                                                                    )
                                                                                                )
                                                                                            );
                                                                                        end
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_8_1414[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                (Source)(
                                                                                                    (MatElm)(
                                                                                                        mor2_1,
                                                                                                        logic_new_func_1224_x_1369_1418,
                                                                                                        logic_new_func_1252_x_1362_1419
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_9_1414[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                (Range)(
                                                                                                    (MatElm)(
                                                                                                        mor2_1,
                                                                                                        logic_new_func_1224_x_1369_1418,
                                                                                                        logic_new_func_1252_x_1362_1419
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (UnderlyingRing)(
                                                                                        (RangeCategoryOfHomomorphismStructure)(
                                                                                            cat_1
                                                                                        )
                                                                                    )
                                                                                )
                                                                            );
                                                                        fi;
                                                                        return;
                                                                    end
                                                                )
                                                            )
                                                        );
                                                    end
                                                )
                                            )
                                        );
                                    fi;
                                    return;
                                end
                            )
                        )
                    );
                end
            )
        )
    );
end;

precompiled_func6 := function ( cat_1, mor1_1, mor2_1 )
  local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1;
    cap_jit_hoisted_expression_1_1 := (Range)(
        mor1_1
    );
    cap_jit_hoisted_expression_2_1 := (Source)(
        mor2_1
    );
    cap_jit_hoisted_expression_3_1 := (Source)(
        mor1_1
    );
    cap_jit_hoisted_expression_4_1 := (Range)(
        mor2_1
    );
    return (
        (UnionOfRows)(
            (UnderlyingRing)(
                (RangeCategoryOfHomomorphismStructure)(
                    cat_1
                )
            ),
            (Sum)(
                (Concatenation)(
                    (List)(
                        (ObjectList)(
                            (Source)(
                                mor1_1
                            )
                        ),
                        function ( logic_new_func_353_x_353_526 )
                          local cap_jit_hoisted_expression_5_526;
                            cap_jit_hoisted_expression_5_526 := (IncidenceMatrixOfBasisPaths)(
                                (UnderlyingCategory)(
                                    cat_1
                                )
                            )[(VertexIndex)(
                                (UnderlyingVertex)(
                                    logic_new_func_353_x_353_526
                                )
                            )];
                            return (
                                (List)(
                                    (ObjectList)(
                                        (Range)(
                                            mor2_1
                                        )
                                    ),
                                    function ( logic_new_func_397_x_397_527 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_5_526[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        logic_new_func_397_x_397_527
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            );
                        end
                    )
                )
            ),
            (List)(
                [ 1 .. (NumberColumns)(
                        mor1_1
                    ) ],
                function ( logic_new_func_1329_x_1329_1536 )
                  local cap_jit_hoisted_expression_6_1536;
                    cap_jit_hoisted_expression_6_1536 := (IncidenceMatrixOfBasisPaths)(
                        (UnderlyingCategory)(
                            cat_1
                        )
                    )[(VertexIndex)(
                        (UnderlyingVertex)(
                            cap_jit_hoisted_expression_1_1[logic_new_func_1329_x_1329_1536]
                        )
                    )];
                    return (
                        (UnionOfColumns)(
                            (UnderlyingRing)(
                                (RangeCategoryOfHomomorphismStructure)(
                                    cat_1
                                )
                            ),
                            (Sum)(
                                (List)(
                                    [ 1 .. (NumberRows)(
                                            mor2_1
                                        ) ],
                                    function ( logic_new_func_1309_x_1309_1537 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_6_1536[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        cap_jit_hoisted_expression_2_1[logic_new_func_1309_x_1309_1537]
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            ),
                            (List)(
                                [ 1 .. (NumberRows)(
                                        mor1_1
                                    ) ],
                                function ( logic_new_func_1361_x_1361_1538 )
                                  local cap_jit_hoisted_expression_7_1538, cap_jit_hoisted_expression_8_1538;
                                    cap_jit_hoisted_expression_7_1538 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            cap_jit_hoisted_expression_3_1[logic_new_func_1361_x_1361_1538]
                                        )
                                    )];
                                    cap_jit_hoisted_expression_8_1538 := (UnderlyingQuiverAlgebraElement)(
                                        (MatElm)(
                                            mor1_1,
                                            logic_new_func_1361_x_1361_1538,
                                            logic_new_func_1329_x_1329_1536
                                        )
                                    );
                                    if (ZeroOfUnderlyingQuiverAlgebra)(
                                              (UnderlyingCategory)(
                                                  cat_1
                                              )
                                          ) = (UnderlyingQuiverAlgebraElement)(
                                              (MatElm)(
                                                  mor1_1,
                                                  logic_new_func_1361_x_1361_1538,
                                                  logic_new_func_1329_x_1329_1536
                                              )
                                          )
                                    then
                                        return (
                                            (HomalgZeroMatrix)(
                                                (Sum)(
                                                    [ 1 .. (NumberRows)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_1328_x_1484_1539 )
                                                        return (
                                                            (Size)(
                                                                cap_jit_hoisted_expression_6_1536[(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        cap_jit_hoisted_expression_2_1[logic_new_func_1328_x_1484_1539]
                                                                    )
                                                                )]
                                                            )
                                                        );
                                                    end
                                                ),
                                                (Sum)(
                                                    (List)(
                                                        [ 1 .. (NumberColumns)(
                                                                mor2_1
                                                            ) ],
                                                        function ( logic_new_func_1312_x_1312_1540 )
                                                            return (
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_7_1538[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1312_x_1312_1540]
                                                                        )
                                                                    )]
                                                                )
                                                            );
                                                        end
                                                    )
                                                ),
                                                (UnderlyingRing)(
                                                    (RangeCategoryOfHomomorphismStructure)(
                                                        cat_1
                                                    )
                                                )
                                            )
                                        );
                                    else
                                        return (
                                            (UnionOfRows)(
                                                (UnderlyingRing)(
                                                    (RangeCategoryOfHomomorphismStructure)(
                                                        cat_1
                                                    )
                                                ),
                                                (Sum)(
                                                    (List)(
                                                        [ 1 .. (NumberColumns)(
                                                                mor2_1
                                                            ) ],
                                                        function ( logic_new_func_1312_x_1312_1541 )
                                                            return (
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_7_1538[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1312_x_1312_1541]
                                                                        )
                                                                    )]
                                                                )
                                                            );
                                                        end
                                                    )
                                                ),
                                                (List)(
                                                    [ 1 .. (NumberRows)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_1328_x_1485_1542 )
                                                      local cap_jit_hoisted_expression_9_1542;
                                                        cap_jit_hoisted_expression_9_1542 := (Size)(
                                                              cap_jit_hoisted_expression_6_1536[(VertexIndex)(
                                                                  (UnderlyingVertex)(
                                                                      cap_jit_hoisted_expression_2_1[logic_new_func_1328_x_1485_1542]
                                                                  )
                                                              )]
                                                          ) = 0;
                                                        return (
                                                            (UnionOfColumns)(
                                                                (UnderlyingRing)(
                                                                    (RangeCategoryOfHomomorphismStructure)(
                                                                        cat_1
                                                                    )
                                                                ),
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_6_1536[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_2_1[logic_new_func_1328_x_1485_1542]
                                                                        )
                                                                    )]
                                                                ),
                                                                (List)(
                                                                    [ 1 .. (NumberColumns)(
                                                                            mor2_1
                                                                        ) ],
                                                                    function ( logic_new_func_1360_x_1478_1543 )
                                                                      local cap_jit_hoisted_expression_10_1543;
                                                                        cap_jit_hoisted_expression_10_1543 := (UnderlyingQuiverAlgebraElement)(
                                                                            (MatElm)(
                                                                                mor2_1,
                                                                                logic_new_func_1328_x_1485_1542,
                                                                                logic_new_func_1360_x_1478_1543
                                                                            )
                                                                        );
                                                                        if (ZeroOfUnderlyingQuiverAlgebra)(
                                                                                      (UnderlyingCategory)(
                                                                                          cat_1
                                                                                      )
                                                                                  ) = (UnderlyingQuiverAlgebraElement)(
                                                                                      (MatElm)(
                                                                                          mor2_1,
                                                                                          logic_new_func_1328_x_1485_1542,
                                                                                          logic_new_func_1360_x_1478_1543
                                                                                      )
                                                                                  ) or cap_jit_hoisted_expression_9_1542 or (Size)(
                                                                                    cap_jit_hoisted_expression_7_1538[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1360_x_1478_1543]
                                                                                        )
                                                                                    )]
                                                                                ) = 0
                                                                        then
                                                                            return (
                                                                                (HomalgZeroMatrix)(
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_6_1536[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_2_1[logic_new_func_1328_x_1485_1542]
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_7_1538[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_4_1[logic_new_func_1360_x_1478_1543]
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (UnderlyingRing)(
                                                                                        (RangeCategoryOfHomomorphismStructure)(
                                                                                            cat_1
                                                                                        )
                                                                                    )
                                                                                )
                                                                            );
                                                                        else
                                                                            return (
                                                                                (HomalgMatrix)(
                                                                                    (List)(
                                                                                        cap_jit_hoisted_expression_6_1536[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_2_1[logic_new_func_1328_x_1485_1542]
                                                                                            )
                                                                                        )],
                                                                                        function ( path_767_1247_1544 )
                                                                                            return (
                                                                                                (CoefficientsOfPaths)(
                                                                                                    cap_jit_hoisted_expression_7_1538[(VertexIndex)(
                                                                                                        (UnderlyingVertex)(
                                                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1360_x_1478_1543]
                                                                                                        )
                                                                                                    )],
                                                                                                    (Representative)(
                                                                                                        cap_jit_hoisted_expression_8_1538 * (PathAsAlgebraElement)(
                                                                                                                (UnderlyingQuiverAlgebra)(
                                                                                                                    (UnderlyingCategory)(
                                                                                                                        cat_1
                                                                                                                    )
                                                                                                                ),
                                                                                                                path_767_1247_1544
                                                                                                            ) * cap_jit_hoisted_expression_10_1543
                                                                                                    )
                                                                                                )
                                                                                            );
                                                                                        end
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_6_1536[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_2_1[logic_new_func_1328_x_1485_1542]
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_7_1538[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_4_1[logic_new_func_1360_x_1478_1543]
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (UnderlyingRing)(
                                                                                        (RangeCategoryOfHomomorphismStructure)(
                                                                                            cat_1
                                                                                        )
                                                                                    )
                                                                                )
                                                                            );
                                                                        fi;
                                                                        return;
                                                                    end
                                                                )
                                                            )
                                                        );
                                                    end
                                                )
                                            )
                                        );
                                    fi;
                                    return;
                                end
                            )
                        )
                    );
                end
            )
        )
    );
end;

precompiled_func7 := function ( cat_1, mor1_1, mor2_1 )
  local cap_jit_hoisted_expression_1_1, cap_jit_hoisted_expression_2_1, cap_jit_hoisted_expression_3_1, cap_jit_hoisted_expression_4_1;
    cap_jit_hoisted_expression_1_1 := (Range)(
        mor1_1
    );
    cap_jit_hoisted_expression_2_1 := (Source)(
        mor2_1
    );
    cap_jit_hoisted_expression_3_1 := (Source)(
        mor1_1
    );
    cap_jit_hoisted_expression_4_1 := (Range)(
        mor2_1
    );
    return (
        (UnionOfRowsListListHomalgMatrix)(
            (UnderlyingRing)(
                (RangeCategoryOfHomomorphismStructure)(
                    cat_1
                )
            ),
            (Sum)(
                [ 1 .. (NumberColumns)(
                        mor1_1
                    ) ],
                function ( logic_new_func_1719_x_1719_2212 )
                  local cap_jit_hoisted_expression_5_2212;
                    cap_jit_hoisted_expression_5_2212 := (IncidenceMatrixOfBasisPaths)(
                        (UnderlyingCategory)(
                            cat_1
                        )
                    )[(VertexIndex)(
                        (UnderlyingVertex)(
                            cap_jit_hoisted_expression_1_1[logic_new_func_1719_x_1719_2212]
                        )
                    )];
                    return (
                        (Sum)(
                            (List)(
                                [ 1 .. (NumberRows)(
                                        mor2_1
                                    ) ],
                                function ( logic_new_func_1699_x_1699_2002 )
                                    return (
                                        (Size)(
                                            cap_jit_hoisted_expression_5_2212[(VertexIndex)(
                                                (UnderlyingVertex)(
                                                    cap_jit_hoisted_expression_2_1[logic_new_func_1699_x_1699_2002]
                                                )
                                            )]
                                        )
                                    );
                                end
                            )
                        )
                    );
                end
            ),
            (Sum)(
                (Concatenation)(
                    (List)(
                        (ObjectList)(
                            (Source)(
                                mor1_1
                            )
                        ),
                        function ( logic_new_func_458_x_458_691 )
                          local cap_jit_hoisted_expression_6_691;
                            cap_jit_hoisted_expression_6_691 := (IncidenceMatrixOfBasisPaths)(
                                (UnderlyingCategory)(
                                    cat_1
                                )
                            )[(VertexIndex)(
                                (UnderlyingVertex)(
                                    logic_new_func_458_x_458_691
                                )
                            )];
                            return (
                                (List)(
                                    (ObjectList)(
                                        (Range)(
                                            mor2_1
                                        )
                                    ),
                                    function ( logic_new_func_517_x_517_692 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_6_691[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        logic_new_func_517_x_517_692
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            );
                        end
                    )
                )
            ),
            (List)(
                [ 1 .. (NumberColumns)(
                        mor1_1
                    ) ],
                function ( logic_new_func_1719_x_1719_2213 )
                  local cap_jit_hoisted_expression_7_2213;
                    cap_jit_hoisted_expression_7_2213 := (IncidenceMatrixOfBasisPaths)(
                        (UnderlyingCategory)(
                            cat_1
                        )
                    )[(VertexIndex)(
                        (UnderlyingVertex)(
                            cap_jit_hoisted_expression_1_1[logic_new_func_1719_x_1719_2213]
                        )
                    )];
                    return (
                        (UnionOfColumnsListListListList)(
                            (UnderlyingRing)(
                                (RangeCategoryOfHomomorphismStructure)(
                                    cat_1
                                )
                            ),
                            (Sum)(
                                (List)(
                                    [ 1 .. (NumberRows)(
                                            mor2_1
                                        ) ],
                                    function ( logic_new_func_1699_x_1699_2002 )
                                        return (
                                            (Size)(
                                                cap_jit_hoisted_expression_7_2213[(VertexIndex)(
                                                    (UnderlyingVertex)(
                                                        cap_jit_hoisted_expression_2_1[logic_new_func_1699_x_1699_2002]
                                                    )
                                                )]
                                            )
                                        );
                                    end
                                )
                            ),
                            (Sum)(
                                [ 1 .. (NumberRows)(
                                        mor1_1
                                    ) ],
                                function ( logic_new_func_1766_x_1766_2157 )
                                  local cap_jit_hoisted_expression_8_2157;
                                    cap_jit_hoisted_expression_8_2157 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            cap_jit_hoisted_expression_3_1[logic_new_func_1766_x_1766_2157]
                                        )
                                    )];
                                    return (
                                        (Sum)(
                                            (List)(
                                                [ 1 .. (NumberColumns)(
                                                        mor2_1
                                                    ) ],
                                                function ( logic_new_func_1702_x_1702_2005 )
                                                    return (
                                                        (Size)(
                                                            cap_jit_hoisted_expression_8_2157[(VertexIndex)(
                                                                (UnderlyingVertex)(
                                                                    cap_jit_hoisted_expression_4_1[logic_new_func_1702_x_1702_2005]
                                                                )
                                                            )]
                                                        )
                                                    );
                                                end
                                            )
                                        )
                                    );
                                end
                            ),
                            (List)(
                                [ 1 .. (NumberRows)(
                                        mor1_1
                                    ) ],
                                function ( logic_new_func_1766_x_1766_2158 )
                                  local cap_jit_hoisted_expression_9_2158, cap_jit_hoisted_expression_10_2158;
                                    cap_jit_hoisted_expression_9_2158 := (IncidenceMatrixOfBasisPaths)(
                                        (UnderlyingCategory)(
                                            cat_1
                                        )
                                    )[(VertexIndex)(
                                        (UnderlyingVertex)(
                                            cap_jit_hoisted_expression_3_1[logic_new_func_1766_x_1766_2158]
                                        )
                                    )];
                                    cap_jit_hoisted_expression_10_2158 := (UnderlyingQuiverAlgebraElement)(
                                        (MatElm)(
                                            mor1_1,
                                            logic_new_func_1766_x_1766_2158,
                                            logic_new_func_1719_x_1719_2213
                                        )
                                    );
                                    if (ZeroOfUnderlyingQuiverAlgebra)(
                                              (UnderlyingCategory)(
                                                  cat_1
                                              )
                                          ) = (UnderlyingQuiverAlgebraElement)(
                                              (MatElm)(
                                                  mor1_1,
                                                  logic_new_func_1766_x_1766_2158,
                                                  logic_new_func_1719_x_1719_2213
                                              )
                                          )
                                    then
                                        return (
                                            (NullMat)(
                                                (Sum)(
                                                    [ 1 .. (NumberRows)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_1718_x_1919_2004 )
                                                        return (
                                                            (Size)(
                                                                cap_jit_hoisted_expression_7_2213[(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        cap_jit_hoisted_expression_2_1[logic_new_func_1718_x_1919_2004]
                                                                    )
                                                                )]
                                                            )
                                                        );
                                                    end
                                                ),
                                                (Sum)(
                                                    (List)(
                                                        [ 1 .. (NumberColumns)(
                                                                mor2_1
                                                            ) ],
                                                        function ( logic_new_func_1702_x_1702_2005 )
                                                            return (
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_9_2158[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1702_x_1702_2005]
                                                                        )
                                                                    )]
                                                                )
                                                            );
                                                        end
                                                    )
                                                )
                                            )
                                        );
                                    else
                                        return (
                                            (UnionOfRowsListListListList)(
                                                (UnderlyingRing)(
                                                    (RangeCategoryOfHomomorphismStructure)(
                                                        cat_1
                                                    )
                                                ),
                                                (Sum)(
                                                    [ 1 .. (NumberRows)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_1718_x_1920_2150 )
                                                        return (
                                                            (Size)(
                                                                cap_jit_hoisted_expression_7_2213[(VertexIndex)(
                                                                    (UnderlyingVertex)(
                                                                        cap_jit_hoisted_expression_2_1[logic_new_func_1718_x_1920_2150]
                                                                    )
                                                                )]
                                                            )
                                                        );
                                                    end
                                                ),
                                                (Sum)(
                                                    (List)(
                                                        [ 1 .. (NumberColumns)(
                                                                mor2_1
                                                            ) ],
                                                        function ( logic_new_func_1702_x_1702_2006 )
                                                            return (
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_9_2158[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1702_x_1702_2006]
                                                                        )
                                                                    )]
                                                                )
                                                            );
                                                        end
                                                    )
                                                ),
                                                (List)(
                                                    [ 1 .. (NumberRows)(
                                                            mor2_1
                                                        ) ],
                                                    function ( logic_new_func_1718_x_1920_2151 )
                                                      local cap_jit_hoisted_expression_11_2151;
                                                        cap_jit_hoisted_expression_11_2151 := (Size)(
                                                              cap_jit_hoisted_expression_7_2213[(VertexIndex)(
                                                                  (UnderlyingVertex)(
                                                                      cap_jit_hoisted_expression_2_1[logic_new_func_1718_x_1920_2151]
                                                                  )
                                                              )]
                                                          ) = 0;
                                                        return (
                                                            (UnionOfColumnsListListListList)(
                                                                (UnderlyingRing)(
                                                                    (RangeCategoryOfHomomorphismStructure)(
                                                                        cat_1
                                                                    )
                                                                ),
                                                                (Size)(
                                                                    cap_jit_hoisted_expression_7_2213[(VertexIndex)(
                                                                        (UnderlyingVertex)(
                                                                            cap_jit_hoisted_expression_2_1[logic_new_func_1718_x_1920_2151]
                                                                        )
                                                                    )]
                                                                ),
                                                                (Sum)(
                                                                    [ 1 .. (NumberColumns)(
                                                                            mor2_1
                                                                        ) ],
                                                                    function ( logic_new_func_1765_x_1913_2143 )
                                                                        return (
                                                                            (Size)(
                                                                                cap_jit_hoisted_expression_9_2158[(VertexIndex)(
                                                                                    (UnderlyingVertex)(
                                                                                        cap_jit_hoisted_expression_4_1[logic_new_func_1765_x_1913_2143]
                                                                                    )
                                                                                )]
                                                                            )
                                                                        );
                                                                    end
                                                                ),
                                                                (List)(
                                                                    [ 1 .. (NumberColumns)(
                                                                            mor2_1
                                                                        ) ],
                                                                    function ( logic_new_func_1765_x_1913_2144 )
                                                                      local cap_jit_hoisted_expression_12_2144;
                                                                        cap_jit_hoisted_expression_12_2144 := (UnderlyingQuiverAlgebraElement)(
                                                                            (MatElm)(
                                                                                mor2_1,
                                                                                logic_new_func_1718_x_1920_2151,
                                                                                logic_new_func_1765_x_1913_2144
                                                                            )
                                                                        );
                                                                        if (ZeroOfUnderlyingQuiverAlgebra)(
                                                                                      (UnderlyingCategory)(
                                                                                          cat_1
                                                                                      )
                                                                                  ) = (UnderlyingQuiverAlgebraElement)(
                                                                                      (MatElm)(
                                                                                          mor2_1,
                                                                                          logic_new_func_1718_x_1920_2151,
                                                                                          logic_new_func_1765_x_1913_2144
                                                                                      )
                                                                                  ) or cap_jit_hoisted_expression_11_2151 or (Size)(
                                                                                    cap_jit_hoisted_expression_9_2158[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            cap_jit_hoisted_expression_4_1[logic_new_func_1765_x_1913_2144]
                                                                                        )
                                                                                    )]
                                                                                ) = 0
                                                                        then
                                                                            return (
                                                                                (NullMat)(
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_7_2213[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_2_1[logic_new_func_1718_x_1920_2151]
                                                                                            )
                                                                                        )]
                                                                                    ),
                                                                                    (Size)(
                                                                                        cap_jit_hoisted_expression_9_2158[(VertexIndex)(
                                                                                            (UnderlyingVertex)(
                                                                                                cap_jit_hoisted_expression_4_1[logic_new_func_1765_x_1913_2144]
                                                                                            )
                                                                                        )]
                                                                                    )
                                                                                )
                                                                            );
                                                                        else
                                                                            return (
                                                                                (List)(
                                                                                    cap_jit_hoisted_expression_7_2213[(VertexIndex)(
                                                                                        (UnderlyingVertex)(
                                                                                            cap_jit_hoisted_expression_2_1[logic_new_func_1718_x_1920_2151]
                                                                                        )
                                                                                    )],
                                                                                    function ( path_992_1622_2009 )
                                                                                        return (
                                                                                            (CoefficientsOfPaths)(
                                                                                                cap_jit_hoisted_expression_9_2158[(VertexIndex)(
                                                                                                    (UnderlyingVertex)(
                                                                                                        cap_jit_hoisted_expression_4_1[logic_new_func_1765_x_1913_2144]
                                                                                                    )
                                                                                                )],
                                                                                                (Representative)(
                                                                                                    cap_jit_hoisted_expression_10_2158 * (PathAsAlgebraElement)(
                                                                                                            (UnderlyingQuiverAlgebra)(
                                                                                                                (UnderlyingCategory)(
                                                                                                                    cat_1
                                                                                                                )
                                                                                                            ),
                                                                                                            path_992_1622_2009
                                                                                                        ) * cap_jit_hoisted_expression_12_2144
                                                                                                )
                                                                                            )
                                                                                        );
                                                                                    end
                                                                                )
                                                                            );
                                                                        fi;
                                                                        return;
                                                                    end
                                                                )
                                                            )
                                                        );
                                                    end
                                                )
                                            )
                                        );
                                    fi;
                                    return;
                                end
                            )
                        )
                    );
                end
            )
        )
    );
end;

#! @Example
#! #@if IsPackageMarkedForLoading( "QPA", ">= 2.0" )
SwitchGeneralizedMorphismStandard( "cospan" );;
snake_quiver := RightQuiver( "Q(6)[a:1->2,b:2->3,c:3->4]" );;
QQ := HomalgFieldOfRationals();;
A := PathAlgebra( QQ, snake_quiver );;
A := QuotientOfPathAlgebra( A, [ A.abc ] );;
#QRowsA := QuiverRows( A );;
QRowsA := QuiverRowsAsAdditiveClosureOfAlgebroid( A, false );;
SetIsProjective( DistinguishedObjectOfHomomorphismStructure( QRowsA ), true );;

a := AsQuiverRowsMorphism( A.a, QRowsA );;
b := AsQuiverRowsMorphism( A.b, QRowsA );;
c := AsQuiverRowsMorphism( A.c, QRowsA );;
aa := AsAdelmanCategoryMorphism( a );;
bb := AsAdelmanCategoryMorphism( b );;
cc := AsAdelmanCategoryMorphism( c );;
dd := CokernelProjection( aa );;
ee := CokernelColift( aa, PreCompose( bb, cc ) );;
ff := KernelEmbedding( ee );;
gg := KernelEmbedding( cc );;
hh := KernelLift( cc, PreCompose( aa, bb ) );;
ii := CokernelProjection( hh );;
fff := AsGeneralizedMorphism( ff );;
ddd := AsGeneralizedMorphism( dd );;
bbb := AsGeneralizedMorphism( bb );;
ggg := AsGeneralizedMorphism( gg );;
iii := AsGeneralizedMorphism( ii );;
p := PreCompose( [ fff, PseudoInverse( ddd ), bbb, PseudoInverse( ggg ), iii ] );;
IsHonest( p );
#! true
jj := KernelObjectFunctorial( bb, dd, ee );;
kk := CokernelObjectFunctorial( hh, gg, bb );;
# long running

n := NormalizedCospanTuple( p )[2];
Display(Runtime());
coker_proj := CokernelProjection( n );
morphism := coker_proj;
datum := (MorphismDatum)(
    morphism
);
left_coeffs := [ [ (IdentityMorphism)(
            (Source)(
                datum
            )
        ), (CorelationMorphism)(
            (Source)(
                morphism
            )
        ) ] ];
right_coeffs := [ [ (RelationMorphism)(
            (Range)(
                morphism
            )
        ), (IdentityMorphism)(
            (Range)(
                datum
            )
        ) ] ];
        
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_rows1", "list", "condA", "condB", "nr_rows2", "nr_cols", "value" ],
        src_template := """
            return UnionOfColumns( ring, nr_rows1, List( list, function( l )
                if condA or condB then
                    return HomalgZeroMatrix( nr_rows2, nr_cols, ring );
                else
                    return value;
                fi;
            end ) )
        """,
        dst_template := """
            if condA then
                return HomalgZeroMatrix( nr_rows1, Sum( list, l -> nr_cols ), ring );
            else
                return UnionOfColumns( ring, nr_rows1, List( list, function( l )
                    if condB then
                        return HomalgZeroMatrix( nr_rows2, nr_cols, ring );
                    else
                        return value;
                    fi;
                end ) );
            fi
        """,
        returns_value := false,
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "ring", "nr_cols1", "list", "condition", "nr_rows", "nr_cols2", "value" ],
        src_template := """
            return UnionOfRows( ring, nr_cols1, List( list, function( l )
                if condition then
                    return HomalgZeroMatrix( nr_rows, nr_cols2, ring );
                else
                    return value;
                fi;
            end ) )
        """,
        dst_template := """
            if condition then
                return HomalgZeroMatrix( Sum( list, l -> nr_rows ), nr_cols1, ring );
            else
                return UnionOfRows( ring, nr_cols1, List( list, function( l )
                    return value;
                end ) );
            fi
        """,
        returns_value := false,
    )
);

## TODO: only valid for AdditiveClosure
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "morphism", "index1", "index2" ],
#        src_template := """
#            Source( MatElm( morphism, index1, index2 ) )
#        """,
#        dst_template := """
#            Source( morphism )[index1]
#        """,
#        returns_value := true,
#    )
#);
#
## TODO: only valid for AdditiveClosure
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "morphism", "index1", "index2" ],
#        src_template := """
#            Range( MatElm( morphism, index1, index2 ) )
#        """,
#        dst_template := """
#            Range( morphism )[index2]
#        """,
#        returns_value := true,
#    )
#);
#
#BindGlobal( "UnionOfColumnsListListHomalgMatrix", function( ring, nr_rows, nr_cols, list )
#    
#    return HomalgMatrix( List( [ 1 .. nr_rows ], i -> Concatenation( List( list, mat -> mat[i] ) ) ), nr_rows, nr_cols, ring );
#    
#end );
#
#BindGlobal( "UnionOfColumnsListListListList", function( ring, nr_rows, nr_cols, list )
#    
#    return List( [ 1 .. nr_rows ], i -> Concatenation( List( list, mat -> mat[i] ) ) );
#    
#end );
#
#BindGlobal( "UnionOfRowsListListHomalgMatrix", function( ring, nr_rows, nr_cols, list )
#    
#    return HomalgMatrix( Concatenation( list ), nr_rows, nr_cols, ring );
#    
#end );
#
#BindGlobal( "UnionOfRowsListListListList", function( ring, nr_rows, nr_cols, list )
#    
#    return Concatenation( list );
#    
#end );
#
## TODO: only if entries is list of lists
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "ring", "nr_rows", "list", "condition", "nr_cols", "entries" ],
#        src_template := """
#            UnionOfColumns( ring, nr_rows, List( list, function( l )
#                if condition then
#                    return HomalgZeroMatrix( nr_rows, nr_cols, ring );
#                else
#                    return HomalgMatrix( entries, nr_rows, nr_cols, ring );
#                fi;
#            end ) )
#        """,
#        dst_template := """
#            UnionOfColumnsListListHomalgMatrix( ring, nr_rows, Sum( list, l -> nr_cols ), List( list, function( l )
#                if condition then
#                    return NullMat( nr_rows, nr_cols );
#                else
#                    return entries;
#                fi;
#            end ) )
#        """,
#        returns_value := true,
#    )
#);
#
## TODO: only if entries is list of lists
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "ring", "nr_cols1", "list", "nr_rows", "nr_cols2", "entries" ],
#        src_template := """
#            UnionOfRows( ring, nr_cols1, List( list, function( l )
#                return UnionOfColumnsListListHomalgMatrix( ring, nr_rows, nr_cols2, entries );
#            end ) )
#        """,
#        dst_template := """
#            UnionOfRowsListListHomalgMatrix( ring, Sum( list, l -> nr_rows ), nr_cols1, List( list, function( l )
#                return UnionOfColumnsListListListList( ring, nr_rows, nr_cols2, entries );
#            end ) )
#        """,
#        returns_value := true,
#        #debug := true,
#        #debug_path := [ "stats", "statements", 1, "obj", "args", 3, "args", 2, "stats", "statements", 1, "obj", "args", 3, "args", 2, "stats", "statements", 1, "obj", "expr_if_false" ],
#        #debug_path := [ "stats", "statements", 1, "obj", "args", 3, "args", 2, "stats", "statements", 1, "args", 3, "args", 2, "stats", "statements", 1 ],
#    )
#);
#
## TODO: only if entries is list of lists
## TODO: nr_cols1 = nr_cols2?
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "ring", "nr_rows1", "list", "condition", "nr_rows2", "nr_cols1", "nr_rows3", "nr_cols2", "entries" ],
#        src_template := """
#            UnionOfColumns( ring, nr_rows1, List( list, function( l )
#                if condition then
#                    return HomalgZeroMatrix( nr_rows2, nr_cols1, ring );
#                else
#                    return UnionOfRowsListListHomalgMatrix( ring, nr_rows3, nr_cols2, entries );
#                fi;
#            end ) )
#        """,
#        dst_template := """
#            UnionOfColumnsListListHomalgMatrix( ring, nr_rows1, Sum( list, l -> nr_cols1 ), List( list, function( l )
#                if condition then
#                    return NullMat( nr_rows2, nr_cols1 );
#                else
#                    return UnionOfRowsListListListList( ring, nr_rows3, nr_cols2, entries );
#                fi;
#            end ) )
#        """,
#        returns_value := true,
#    )
#);

Display("start");
Display(Runtime());
MYERROR := true;

ALGEBROIDS_COUNTER := 0;
QUIVER_ROWS_COUNTER := 0;
IGNORE_IMMEDIATE_METHODS := true;
#LineByLineProfileFunction(precompiled_func, [ CapCategory(datum), left_coeffs[1][1], right_coeffs[1][1] ]);
#LineByLineProfileFunction(HomomorphismStructureOnMorphisms, [ CapCategory(datum), left_coeffs[1][1], right_coeffs[1][1] ]);
#HomomorphismStructureOnMorphisms( left_coeffs[1][1], right_coeffs[1][1] );
start_time := Runtime();
#TraceImmediateMethods();
precompiled_func6( CapCategory(datum), left_coeffs[1][1], right_coeffs[1][1] );
Display(Runtime() - start_time);
Error("precompiled func finished");

#compiled_func := CapJitCompiledFunction( { cat, mor1, mor2 } -> UnderlyingMatrix( HomomorphismStructureOnMorphisms( cat, mor1, mor2 ) ), [ CapCategory(datum) ] );
compiled_func := CapJitCompiledFunction( { cat, mor1, mor2 } -> HomomorphismStructureOnMorphisms( cat, mor1, mor2 ), [ CapCategory(datum) ] );
Display(Runtime());
Display("compilation finished");
Display(Runtime());
#compiled_func( CapCategory(datum), left_coeffs[1][1], right_coeffs[1][1] );
start_time := Runtime();
HomomorphismStructureOnMorphisms( CapCategory(datum), left_coeffs[1][1], right_coeffs[1][1] );
# Ausgangswert (mit Immediate Methods): 1500
# ohne Immediate Methods: 259
# präkompiliert, ohne Immediate Methods, mit "return fail": 64
# präkompiliert, ohne Immediate Methods, mit "return fail", mit manuellem Cache für 0-Matrizen: 53
# präkompiliert, ohne Immediate Methods, mit "return fail", mit manuellem Cache für 0-Matrizen, pulled_out_value1: 49
# präkompiliert, ohne Immediate Methods, mit "return fail", mit manuellem Cache für 0-Matrizen, pulled_out_value1,2: 44
# präkompiliert, ohne Immediate Methods, mit "return fail", mit manuellem Cache für 0-Matrizen, pulled_out_value1..3: 40
# präkompiliert, ohne Immediate Methods, mit "return fail", mit manuellem Cache für 0-Matrizen, pulled_out_value1..7: 34
# Ziel (QuiverRows): 22

#LineByLineProfileFunction(compiled_func, [ CapCategory(datum), left_coeffs[1][1], right_coeffs[1][1] ]);

#(SolveLinearSystemInAbCategory)(
#    left_coeffs,
#    right_coeffs,
#    [ datum ]
#);
#WitnessPairForBeingCongruentToZero( coker_proj );
#compiled_inverse := CapJitCompiledFunction( Last(CapCategory(n)!.added_functions.InverseForMorphisms)[1], [ CapCategory(n) ] );
Display(Runtime() - start_time);
Display("end");


#Inverse(n);

#pp := HonestRepresentative( p );; # 3.8s
#Display(Runtime());

#LineByLineProfileFunction(HonestRepresentative, [p]);
#
#comp := PreCompose( jj, pp );;
#IsZero( comp );
##! true
#comp := PreCompose( pp, kk );;
#IsZero( comp );
##! true
#homology := function( alpha, beta ) return CokernelObject( LiftAlongMonomorphism( KernelEmbedding( beta ), ImageEmbedding( alpha ) ) ); end;;
#
#
## long running
#IsZero( homology( jj, pp ) );
##! true
#
#
## long running
#IsZero( homology( pp, kk ) );
#! true
#! #@fi
# @EndExample
