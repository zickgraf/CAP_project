# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_AdditiveClosureOfLinearClosureOverZOfGroupAsCategoryOfSymmetricGroupOf3Precompiled", function ( cat )
    
    ##
    AddHomomorphismStructureOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
  local morphism_attr_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, hoisted_11_1, hoisted_12_1, hoisted_13_1, hoisted_14_1, hoisted_15_1, hoisted_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1;
    deduped_24_1 := (RangeCategoryOfHomomorphismStructure)(
        cat_1
    );
    deduped_23_1 := [ 1 .. (NumberColumns)(
            alpha_1
        ) ];
    deduped_22_1 := [ 1 .. (NumberRows)(
            beta_1
        ) ];
    deduped_21_1 := [ 1 .. (NumberRows)(
            alpha_1
        ) ];
    deduped_20_1 := [ 1 .. (NumberColumns)(
            beta_1
        ) ];
    deduped_19_1 := (UnderlyingCategory)(
        (UnderlyingCategory)(
            cat_1
        )
    );
    deduped_18_1 := (UnderlyingRing)(
        deduped_24_1
    );
    deduped_17_1 := (Length)(
        (GroupAsSet)(
            deduped_19_1
        )
    );
    hoisted_16_1 := deduped_21_1;
    hoisted_15_1 := (HomalgIdentityMatrix)(
        deduped_17_1,
        deduped_18_1
    );
    hoisted_14_1 := (HomPermutationArray)(
        deduped_19_1
    );
    hoisted_13_1 := deduped_18_1;
    hoisted_11_1 := deduped_24_1;
    hoisted_10_1 := deduped_20_1;
    hoisted_4_1 := (ObjectifyObjectForCAPWithAttributes)(
        rec(
           ),
        deduped_24_1,
        RankOfObject,
        deduped_17_1
    );
    hoisted_8_1 := (List)(
        deduped_20_1,
        function ( t_2 )
            return (
                hoisted_4_1
            );
        end
    );
    hoisted_9_1 := (List)(
        deduped_21_1,
        function ( i_2 )
            return (
                hoisted_8_1
            );
        end
    );
    hoisted_12_1 := (List)(
        deduped_21_1,
        function ( i_2 )
          local hoisted_1_2;
            hoisted_1_2 := hoisted_9_1[i_2];
            return (
                (ObjectifyObjectForCAPWithAttributes)(
                    rec(
                       ),
                    hoisted_11_1,
                    RankOfObject,
                    (Sum)(
                        (List)(
                            hoisted_10_1,
                            function ( logic_new_func_x_3 )
                                return (
                                    (RankOfObject)(
                                        hoisted_1_2[logic_new_func_x_3]
                                    )
                                );
                            end
                        )
                    )
                )
            );
        end
    );
    hoisted_7_1 := deduped_22_1;
    hoisted_5_1 := (List)(
        deduped_22_1,
        function ( s_2 )
            return (
                hoisted_4_1
            );
        end
    );
    hoisted_6_1 := (List)(
        deduped_23_1,
        function ( j_2 )
            return (
                hoisted_5_1
            );
        end
    );
    hoisted_2_1 := deduped_17_1;
    hoisted_3_1 := (List)(
        (ObjectList)(
            (Range)(
                beta_1
            )
        ),
        function ( logic_new_func_x_2 )
            return (
                hoisted_2_1
            );
        end
    );
    morphism_attr_1_1 := (UnionOfRows)(
        deduped_18_1,
        (Sum)(
            (Concatenation)(
                (List)(
                    (ObjectList)(
                        (Source)(
                            alpha_1
                        )
                    ),
                    function ( logic_new_func_x_2 )
                        return (
                            hoisted_3_1
                        );
                    end
                )
            )
        ),
        (List)(
            deduped_23_1,
            function ( logic_new_func_x_2 )
              local hoisted_1_2;
                hoisted_1_2 := hoisted_6_1[logic_new_func_x_2];
                return (
                    (UnionOfColumns)(
                        hoisted_13_1,
                        (Sum)(
                            (List)(
                                hoisted_7_1,
                                function ( logic_new_func_x_3 )
                                    return (
                                        (RankOfObject)(
                                            hoisted_1_2[logic_new_func_x_3]
                                        )
                                    );
                                end
                            )
                        ),
                        (List)(
                            hoisted_16_1,
                            function ( logic_new_func_x_3 )
                              local hoisted_1_3, hoisted_2_3, hoisted_3_3, hoisted_4_3, hoisted_5_3, deduped_6_3, deduped_7_3, deduped_8_3;
                                deduped_8_3 := (MatElm)(
                                    alpha_1,
                                    logic_new_func_x_3,
                                    logic_new_func_x_2
                                );
                                deduped_7_3 := (CoefficientsList)(
                                    deduped_8_3
                                );
                                deduped_6_3 := (Size)(
                                    deduped_7_3
                                );
                                hoisted_5_3 := [ 1 .. deduped_6_3 ];
                                hoisted_4_3 := (SupportMorphisms)(
                                    deduped_8_3
                                );
                                hoisted_3_3 := deduped_7_3;
                                hoisted_2_3 := hoisted_9_1[logic_new_func_x_3];
                                hoisted_1_3 := deduped_6_3 = 0;
                                return (
                                    (UnionOfRows)(
                                        hoisted_13_1,
                                        (RankOfObject)(
                                            hoisted_12_1[logic_new_func_x_3]
                                        ),
                                        (List)(
                                            hoisted_7_1,
                                            function ( logic_new_func_x_4 )
                                              local hoisted_1_4, deduped_2_4;
                                                deduped_2_4 := (RankOfObject)(
                                                    hoisted_1_2[logic_new_func_x_4]
                                                );
                                                hoisted_1_4 := deduped_2_4;
                                                return (
                                                    (UnionOfColumns)(
                                                        hoisted_13_1,
                                                        deduped_2_4,
                                                        (List)(
                                                            hoisted_10_1,
                                                            function ( logic_new_func_x_5 )
                                                              local hoisted_1_5, hoisted_2_5, hoisted_3_5, deduped_4_5, deduped_5_5, deduped_6_5;
                                                                deduped_6_5 := (MatElm)(
                                                                    beta_1,
                                                                    logic_new_func_x_4,
                                                                    logic_new_func_x_5
                                                                );
                                                                deduped_5_5 := (CoefficientsList)(
                                                                    deduped_6_5
                                                                );
                                                                deduped_4_5 := (Size)(
                                                                    deduped_5_5
                                                                );
                                                                if hoisted_1_3 or deduped_4_5 = 0
                                                                then
                                                                    return (
                                                                        (HomalgZeroMatrix)(
                                                                            hoisted_1_4,
                                                                            (RankOfObject)(
                                                                                hoisted_2_3[logic_new_func_x_5]
                                                                            ),
                                                                            hoisted_13_1
                                                                        )
                                                                    );
                                                                else
                                                                    hoisted_3_5 := [ 1 .. deduped_4_5 ];
                                                                    hoisted_2_5 := (SupportMorphisms)(
                                                                        deduped_6_5
                                                                    );
                                                                    hoisted_1_5 := deduped_5_5;
                                                                    return (
                                                                        (Iterated)(
                                                                            (List)(
                                                                                hoisted_5_3,
                                                                                function ( logic_new_func_x_6 )
                                                                                  local hoisted_1_6, hoisted_2_6;
                                                                                    hoisted_2_6 := hoisted_14_1[(PositionWithinElements)(
                                                                                        hoisted_4_3[logic_new_func_x_6]
                                                                                    )];
                                                                                    hoisted_1_6 := hoisted_3_3[logic_new_func_x_6];
                                                                                    return (
                                                                                        (Iterated)(
                                                                                            (List)(
                                                                                                hoisted_3_5,
                                                                                                function ( logic_new_func_x_7 )
                                                                                                    return (
                                                                                                        hoisted_1_6 * hoisted_1_5[logic_new_func_x_7] * (CertainRows)(
                                                                                                              hoisted_15_1,
                                                                                                              hoisted_2_6[(PositionWithinElements)(
                                                                                                                  hoisted_2_5[logic_new_func_x_7]
                                                                                                              )]
                                                                                                          )
                                                                                                    );
                                                                                                end
                                                                                            ),
                                                                                            function ( mor1_7, mor2_7 )
                                                                                                return (
                                                                                                    mor1_7 + mor2_7
                                                                                                );
                                                                                            end
                                                                                        )
                                                                                    );
                                                                                end
                                                                            ),
                                                                            function ( mor1_6, mor2_6 )
                                                                                return (
                                                                                    mor1_6 + mor2_6
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
                            end
                        )
                    )
                );
            end
        )
    );
    return (
        (ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes)(
            rec(
               ),
            deduped_24_1,
            (ObjectifyObjectForCAPWithAttributes)(
                rec(
                   ),
                deduped_24_1,
                RankOfObject,
                (NumberRows)(
                    morphism_attr_1_1
                )
            ),
            (ObjectifyObjectForCAPWithAttributes)(
                rec(
                   ),
                deduped_24_1,
                RankOfObject,
                (NumberColumns)(
                    morphism_attr_1_1
                )
            ),
            UnderlyingMatrix,
            morphism_attr_1_1
        )
    );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
end );

BindGlobal( "AdditiveClosureOfLinearClosureOverZOfGroupAsCategoryOfSymmetricGroupOf3Precompiled", function (  )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function (  )
  local G, CG, ZZ, ZCG, RowsG;
    G := (SymmetricGroup)(
        3
    );
    CG := (GroupAsCategory)(
        G : FinalizeCategory := true
    );
    ZZ := (HomalgRingOfIntegers)(
        
    );
    ZCG := (LinearClosure)(
        ZZ,
        CG : FinalizeCategory := true
    );
    RowsG := (AdditiveClosure)(
        ZCG
    );
    return (
        RowsG
    );
end;
        
        
    
    cat := category_constructor(  : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_AdditiveClosureOfLinearClosureOverZOfGroupAsCategoryOfSymmetricGroupOf3Precompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
