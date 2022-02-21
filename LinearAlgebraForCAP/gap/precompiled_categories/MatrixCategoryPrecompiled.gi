# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_MatrixCategoryPrecompiled", function ( cat )
    
    ##
    AddAdditionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + UnderlyingMatrix( b_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAdditiveInverseForMorphisms( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, -1 * UnderlyingMatrix( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddAssociatorLeftToRight( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_4_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( s_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddAssociatorRightToLeft( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_4_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * (Dimension( b_1 ) * Dimension( c_1 )) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( s_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddAstrictionToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1;
    deduped_8_1 := UnderlyingMatrix( alpha_1 );
    deduped_7_1 := SyzygiesOfRows( deduped_8_1 );
    morphism_attr_10_1 := deduped_7_1;
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_10_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_9_1 := deduped_4_1;
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_6_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_5_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_9_1 ) ), UnderlyingMatrix, morphism_attr_9_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_1_1 ), Range( alpha_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_1_1 ), deduped_8_1 ) );
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddAstrictionToCoimageWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1;
    deduped_8_1 := UnderlyingMatrix( alpha_1 );
    deduped_7_1 := SyzygiesOfRows( deduped_8_1 );
    morphism_attr_10_1 := deduped_7_1;
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_10_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_9_1 := deduped_4_1;
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_6_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_5_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_9_1 ) ), UnderlyingMatrix, morphism_attr_9_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_1_1 ), Range( alpha_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_1_1 ), deduped_8_1 ) );
end
########
        
    , 705 : IsPrecompiledDerivation := true );
    
    ##
    AddBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, hoisted_4_1;
    deduped_3_1 := Dimension( arg3_1 );
    deduped_2_1 := Dimension( arg2_1 );
    deduped_1_1 := deduped_2_1 * deduped_3_1;
    hoisted_4_1 := HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) );
    return List( [ 1 .. deduped_1_1 ], function ( logic_new_func_x_2 )
            return function ( mat_3 )
                    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                           ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, mat_3 );
                end( function ( i_3 )
                      return ConvertRowToMatrix( CertainRows( hoisted_4_1, [ i_3 ] ), deduped_2_1, deduped_3_1 );
                  end( logic_new_func_x_2 ) );
        end );
end
########
        
    , 100 );
    
    ##
    AddBraiding( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := Dimension( a_1 );
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_5_1 * deduped_6_1 );
    deduped_3_1 := Dimension( deduped_4_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, deduped_6_1 ) * deduped_5_1 + QUO_INT( deduped_1_2, deduped_6_1 ) + 1;
                end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddBraidingInverse( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := Dimension( a_1 );
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_5_1 * deduped_6_1 );
    deduped_3_1 := Dimension( deduped_4_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, deduped_5_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_5_1 ) + 1;
                end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_3_1, hoisted_4_1, hoisted_5_1;
    hoisted_5_1 := Dimension( a_1 );
    hoisted_4_1 := Dimension( b_1 );
    deduped_3_1 := Dimension( s_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2, deduped_2_2;
                    deduped_2_2 := hoisted_5_1;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, deduped_2_2 ) * hoisted_4_1 + QUO_INT( deduped_1_2, deduped_2_2 ) + 1;
                end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_3_1, hoisted_4_1, hoisted_5_1;
    hoisted_5_1 := Dimension( b_1 );
    hoisted_4_1 := Dimension( a_1 );
    deduped_3_1 := Dimension( s_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                    local deduped_1_2, deduped_2_2;
                    deduped_2_2 := hoisted_5_1;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, deduped_2_2 ) * hoisted_4_1 + QUO_INT( deduped_1_2, deduped_2_2 ) + 1;
                end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoDualOnMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Source( alpha_1 ), UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddCoDualOnMorphismsWithGivenCoDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoDualOnObjects( cat,
        
########
function ( cat_1, a_1 )
    return a_1;
end
########
        
    , 100 );
    
    ##
    AddCoDualityTensorProductCompatibilityMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, morphism_attr_24_1, deduped_25_1;
    deduped_25_1 := UnderlyingRing( cat_1 );
    deduped_23_1 := Dimension( b_1 );
    deduped_22_1 := Dimension( a_1 );
    deduped_21_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    deduped_20_1 := [ deduped_21_1, deduped_21_1, a_1, b_1 ];
    deduped_19_1 := Dimension( deduped_20_1[2] );
    deduped_18_1 := Dimension( deduped_20_1[1] );
    deduped_17_1 := Dimension( deduped_20_1[4] );
    deduped_16_1 := Dimension( deduped_20_1[3] );
    deduped_15_1 := deduped_18_1 * deduped_16_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_16_1, deduped_25_1 );
    deduped_13_1 := deduped_19_1 * deduped_17_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_17_1, deduped_25_1 );
    deduped_11_1 := HomalgIdentityMatrix( deduped_18_1, deduped_25_1 );
    deduped_10_1 := deduped_16_1 * deduped_17_1;
    deduped_9_1 := deduped_10_1 * deduped_10_1;
    deduped_8_1 := deduped_15_1 * deduped_13_1;
    deduped_7_1 := deduped_16_1 * deduped_13_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_10_1, deduped_25_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_25_1 );
    deduped_4_1 := deduped_8_1 * deduped_10_1;
    deduped_3_1 := KroneckerMat( deduped_6_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_25_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_25_1 ), deduped_5_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_6_1 ), deduped_5_1 );
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_6_1 ), KroneckerMat( deduped_11_1, KroneckerMat( HomalgIdentityMatrix( deduped_19_1, deduped_25_1 ), ConvertMatrixToRow( deduped_12_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                            end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_25_1 ), deduped_12_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_17_1 * deduped_19_1), deduped_25_1 ), deduped_12_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_11_1, ConvertMatrixToRow( deduped_14_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                              end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_25_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_16_1 * deduped_18_1), deduped_25_1 ), deduped_14_1 )), HomalgIdentityMatrix( deduped_13_1, deduped_25_1 ) ), deduped_12_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_25_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_13_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_13_1 ) + 1);
                      end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_25_1 ) ), deduped_12_1 ) );
    deduped_1_1 := deduped_2_1 * deduped_3_1 * KroneckerMat( HomalgIdentityMatrix( deduped_22_1, deduped_25_1 ), HomalgIdentityMatrix( deduped_23_1, deduped_25_1 ) );
    morphism_attr_24_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
end
########
        
    , 15766 : IsPrecompiledDerivation := true );
    
    ##
    AddCoDualityTensorProductCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1;
    hoisted_4_1 := Dimension( b_1 );
    hoisted_3_1 := Dimension( a_1 );
    hoisted_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    hoisted_1_1 := UnderlyingRing( cat_1 );
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, deduped_15_2, deduped_16_2, deduped_17_2, deduped_18_2, deduped_19_2, deduped_20_2, deduped_21_2, deduped_22_2, deduped_23_2, deduped_24_2, deduped_25_2, deduped_26_2, deduped_27_2, morphism_attr_28_2, morphism_attr_29_2, morphism_attr_30_2;
            deduped_25_2 := hoisted_2_1;
            deduped_24_2 := [ deduped_25_2, deduped_25_2, a_1, b_1 ];
            deduped_22_2 := Dimension( deduped_24_2[2] );
            deduped_21_2 := Dimension( deduped_24_2[1] );
            deduped_20_2 := Dimension( deduped_24_2[4] );
            deduped_19_2 := Dimension( deduped_24_2[3] );
            deduped_17_2 := deduped_21_2 * deduped_19_2;
            deduped_15_2 := deduped_22_2 * deduped_20_2;
            deduped_12_2 := deduped_19_2 * deduped_20_2;
            deduped_11_2 := deduped_12_2 * deduped_12_2;
            deduped_10_2 := deduped_17_2 * deduped_15_2;
            deduped_8_2 := HomalgIdentityMatrix( deduped_12_2, hoisted_1_1 );
            deduped_7_2 := HomalgIdentityMatrix( deduped_10_2, hoisted_1_1 );
            deduped_6_2 := deduped_10_2 * deduped_12_2;
            deduped_5_2 := KroneckerMat( deduped_8_2, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := (i_3 - 1);
                                return (REM_INT( deduped_1_3, deduped_12_2 ) * deduped_10_2 + QUO_INT( deduped_1_3, deduped_12_2 ) + 1);
                            end ) ), deduped_6_2 ), deduped_6_2, deduped_6_2, hoisted_1_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := (i_3 - 1);
                                return (REM_INT( deduped_1_3, deduped_12_2 ) * deduped_12_2 + QUO_INT( deduped_1_3, deduped_12_2 ) + 1);
                            end ) ), deduped_11_2 ), deduped_11_2, deduped_11_2, hoisted_1_1 ), deduped_7_2 ) * KroneckerMat( ConvertMatrixToColumn( deduped_8_2 ), deduped_7_2 );
            morphism_attr_30_2 := deduped_5_2;
            deduped_16_2 := HomalgIdentityMatrix( deduped_19_2, hoisted_1_1 );
            deduped_14_2 := HomalgIdentityMatrix( deduped_20_2, hoisted_1_1 );
            deduped_13_2 := HomalgIdentityMatrix( deduped_21_2, hoisted_1_1 );
            deduped_9_2 := deduped_19_2 * deduped_15_2;
            deduped_3_2 := KroneckerMat( TransposedMatrix( deduped_8_2 ), KroneckerMat( deduped_13_2, KroneckerMat( HomalgIdentityMatrix( deduped_22_2, hoisted_1_1 ), ConvertMatrixToRow( deduped_14_2 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_2 ], function ( i_3 )
                                        local deduped_1_3;
                                        deduped_1_3 := (i_3 - 1);
                                        return (REM_INT( deduped_1_3, deduped_20_2 ) * deduped_22_2 + QUO_INT( deduped_1_3, deduped_20_2 ) + 1);
                                    end ) ), deduped_15_2 ), deduped_15_2, deduped_15_2, hoisted_1_1 ), deduped_14_2 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_20_2 * deduped_22_2), hoisted_1_1 ), deduped_14_2 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_13_2, ConvertMatrixToRow( deduped_16_2 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_2 ], function ( i_3 )
                                          local deduped_1_3;
                                          deduped_1_3 := (i_3 - 1);
                                          return (REM_INT( deduped_1_3, deduped_19_2 ) * deduped_21_2 + QUO_INT( deduped_1_3, deduped_19_2 ) + 1);
                                      end ) ), deduped_17_2 ), deduped_17_2, deduped_17_2, hoisted_1_1 ), deduped_16_2 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_19_2 * deduped_21_2), hoisted_1_1 ), deduped_16_2 )), HomalgIdentityMatrix( deduped_15_2, hoisted_1_1 ) ), deduped_14_2 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_17_2, hoisted_1_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_2 ], function ( i_3 )
                                  local deduped_1_3;
                                  deduped_1_3 := (i_3 - 1);
                                  return (REM_INT( deduped_1_3, deduped_15_2 ) * deduped_19_2 + QUO_INT( deduped_1_3, deduped_15_2 ) + 1);
                              end ) ), deduped_9_2 ), deduped_9_2, deduped_9_2, hoisted_1_1 ) ), deduped_14_2 ) );
            morphism_attr_29_2 := deduped_3_2;
            deduped_27_2 := hoisted_4_1;
            deduped_26_2 := hoisted_3_1;
            deduped_23_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_26_2 * deduped_27_2 );
            deduped_18_2 := KroneckerMat( HomalgIdentityMatrix( deduped_26_2, hoisted_1_1 ), HomalgIdentityMatrix( deduped_27_2, hoisted_1_1 ) );
            deduped_4_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_30_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_30_2 ) ), UnderlyingMatrix, morphism_attr_30_2 );
            deduped_2_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_29_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_29_2 ) ), UnderlyingMatrix, morphism_attr_29_2 );
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( HomalgIdentityMatrix( Dimension( deduped_23_2 ), hoisted_1_1 ), UnderlyingMatrix( deduped_2_2 ) * UnderlyingMatrix( deduped_4_2 ) ), deduped_18_2 );
            morphism_attr_28_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_28_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_28_2 ) ), UnderlyingMatrix, morphism_attr_28_2 );
        end(  );
end
########
        
    , 15265 : IsPrecompiledDerivation := true );
    
    ##
    AddCoLambdaElimination( cat,
        
########
function ( cat_1, a_1, b_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, morphism_attr_11_1, morphism_attr_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := Dimension( b_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_10_1, deduped_13_1 );
    deduped_5_1 := KroneckerMat( UnderlyingMatrix( alpha_1 ), deduped_7_1 );
    morphism_attr_12_1 := deduped_5_1;
    deduped_9_1 := Dimension( a_1 );
    deduped_8_1 := deduped_9_1 * deduped_10_1;
    deduped_3_1 := KroneckerMat( HomalgIdentityMatrix( deduped_9_1, deduped_13_1 ), ConvertMatrixToRow( deduped_7_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_13_1 ), deduped_7_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_10_1 * deduped_9_1), deduped_13_1 ), deduped_7_1 );
    morphism_attr_11_1 := deduped_3_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, b_1, b_1, UnderlyingMatrix, deduped_7_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_12_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_12_1 ) ), UnderlyingMatrix, morphism_attr_12_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_11_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_11_1 ) ), UnderlyingMatrix, morphism_attr_11_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_4_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_4_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_6_1 ) );
end
########
        
    , 3315 : IsPrecompiledDerivation := true );
    
    ##
    AddCoLambdaIntroduction( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, morphism_attr_13_1, morphism_attr_14_1, deduped_15_1;
    deduped_15_1 := UnderlyingRing( cat_1 );
    deduped_12_1 := Range( alpha_1 );
    deduped_11_1 := Dimension( deduped_12_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_11_1, deduped_15_1 );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_12_1, deduped_12_1, UnderlyingMatrix, deduped_8_1 );
    deduped_4_1 := KroneckerMat( TransposedMatrix( deduped_8_1 ), UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_14_1 := deduped_4_1;
    deduped_10_1 := 1;
    deduped_9_1 := deduped_11_1 * deduped_11_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_10_1, deduped_15_1 );
    deduped_6_1 := deduped_10_1 * deduped_11_1;
    deduped_2_1 := KroneckerMat( deduped_8_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_15_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_15_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_8_1 ), deduped_7_1 );
    morphism_attr_13_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_14_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_14_1 ) ), UnderlyingMatrix, morphism_attr_14_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_13_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_13_1 ) ), UnderlyingMatrix, morphism_attr_13_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 5125 : IsPrecompiledDerivation := true );
    
    ##
    AddCoRankMorphism( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, morphism_attr_11_1, deduped_12_1;
    deduped_12_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := HomalgIdentityMatrix( 1, deduped_12_1 );
    deduped_9_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), deduped_12_1 ) );
    deduped_8_1 := Dimension( Range( deduped_9_1 ) );
    deduped_7_1 := Dimension( Source( deduped_9_1 ) );
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_5_1 := 1 * deduped_8_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_8_1, deduped_12_1 );
    deduped_3_1 := KroneckerMat( TransposedMatrix( deduped_4_1 ), UnderlyingMatrix( deduped_9_1 ) * deduped_4_1 );
    deduped_2_1 := KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * 1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_12_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_12_1 ), deduped_10_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_10_1 );
    deduped_1_1 := ConvertMatrixToRow( HomalgIdentityMatrix( deduped_7_1, deduped_12_1 ) ) * (deduped_3_1 * deduped_2_1);
    morphism_attr_11_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_11_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_11_1 ) ), UnderlyingMatrix, morphism_attr_11_1 );
end
########
        
    , 5929 : IsPrecompiledDerivation := true );
    
    ##
    AddCoTraceMap( cat,
        
########
function ( cat_1, alpha_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := HomalgIdentityMatrix( 1, deduped_6_1 );
    hoisted_4_1 := Range( alpha_1 );
    hoisted_3_1 := Dimension( Source( alpha_1 ) );
    hoisted_2_1 := UnderlyingMatrix( alpha_1 );
    hoisted_1_1 := deduped_6_1;
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, morphism_attr_15_2, morphism_attr_16_2, morphism_attr_17_2;
            deduped_13_2 := hoisted_4_1;
            deduped_12_2 := Dimension( deduped_13_2 );
            deduped_8_2 := HomalgIdentityMatrix( deduped_12_2, hoisted_1_1 );
            deduped_5_2 := KroneckerMat( TransposedMatrix( deduped_8_2 ), hoisted_2_1 * deduped_8_2 );
            morphism_attr_17_2 := deduped_5_2;
            deduped_14_2 := hoisted_5_1;
            deduped_10_2 := deduped_12_2 * deduped_12_2;
            deduped_9_2 := 1 * deduped_12_2;
            deduped_3_2 := KroneckerMat( deduped_8_2, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := (i_3 - 1);
                                return (REM_INT( deduped_1_3, deduped_12_2 ) * 1 + QUO_INT( deduped_1_3, deduped_12_2 ) + 1);
                            end ) ), deduped_9_2 ), deduped_9_2, deduped_9_2, hoisted_1_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := (i_3 - 1);
                                return (REM_INT( deduped_1_3, deduped_12_2 ) * deduped_12_2 + QUO_INT( deduped_1_3, deduped_12_2 ) + 1);
                            end ) ), deduped_10_2 ), deduped_10_2, deduped_10_2, hoisted_1_1 ), deduped_14_2 ) * KroneckerMat( ConvertMatrixToColumn( deduped_8_2 ), deduped_14_2 );
            morphism_attr_16_2 := deduped_3_2;
            deduped_11_2 := hoisted_3_1;
            deduped_7_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_11_2 * deduped_11_2 );
            deduped_6_2 := ConvertMatrixToRow( HomalgIdentityMatrix( deduped_11_2, hoisted_1_1 ) );
            deduped_4_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_17_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_17_2 ) ), UnderlyingMatrix, morphism_attr_17_2 );
            deduped_2_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_16_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_16_2 ) ), UnderlyingMatrix, morphism_attr_16_2 );
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( deduped_6_2, HomalgIdentityMatrix( Dimension( deduped_7_2 ), hoisted_1_1 ) ), UnderlyingMatrix( deduped_4_2 ) * UnderlyingMatrix( deduped_2_2 ) );
            morphism_attr_15_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_15_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_15_2 ) ), UnderlyingMatrix, morphism_attr_15_2 );
        end(  );
end
########
        
    , 5828 : IsPrecompiledDerivation := true );
    
    ##
    AddCoastrictionToImage( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1;
    deduped_8_1 := UnderlyingMatrix( alpha_1 );
    deduped_7_1 := SyzygiesOfColumns( deduped_8_1 );
    morphism_attr_10_1 := deduped_7_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_4_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_9_1 := deduped_4_1;
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_9_1 ) ), Source( deduped_6_1 ), UnderlyingMatrix, morphism_attr_9_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( deduped_1_1 ), UnderlyingMatrix, RightDivide( deduped_8_1, UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddCoastrictionToImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1;
    deduped_8_1 := UnderlyingMatrix( alpha_1 );
    deduped_7_1 := SyzygiesOfColumns( deduped_8_1 );
    morphism_attr_10_1 := deduped_7_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_4_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_9_1 := deduped_4_1;
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_9_1 ) ), Source( deduped_6_1 ), UnderlyingMatrix, morphism_attr_9_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( deduped_1_1 ), UnderlyingMatrix, RightDivide( deduped_8_1, UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 705 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedCoevaluationForCoDual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := Dimension( a_1 );
    morphism_attr_2_1 := ConvertMatrixToColumn( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_2_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedCoevaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoclosedCoevaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, morphism_attr_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( b_1 );
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_6_1, deduped_9_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_7_1, deduped_9_1 );
    deduped_3_1 := deduped_7_1 * deduped_7_1;
    deduped_2_1 := deduped_6_1 * deduped_7_1;
    deduped_1_1 := KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_2_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_2_1 ), deduped_2_1, deduped_2_1, deduped_9_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, deduped_9_1 ), deduped_5_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_4_1 ), deduped_5_1 );
    morphism_attr_8_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_8_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 );
end
########
        
    , 2811 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedCoevaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1;
    hoisted_3_1 := Dimension( b_1 );
    hoisted_2_1 := Dimension( a_1 );
    hoisted_1_1 := UnderlyingRing( cat_1 );
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, morphism_attr_15_2;
            deduped_14_2 := hoisted_3_1;
            deduped_13_2 := hoisted_2_1;
            deduped_12_2 := HomalgIdentityMatrix( deduped_14_2, hoisted_1_1 );
            deduped_11_2 := ConvertMatrixToColumn( deduped_12_2 );
            deduped_10_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_14_2 * deduped_14_2 );
            deduped_9_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_13_2 * deduped_14_2 );
            deduped_8_2 := HomalgIdentityMatrix( deduped_13_2, hoisted_1_1 );
            deduped_7_2 := Dimension( deduped_10_2 );
            deduped_6_2 := Dimension( deduped_9_2 );
            deduped_5_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_6_2 * deduped_14_2 );
            deduped_4_2 := KroneckerMat( deduped_11_2, deduped_8_2 );
            deduped_3_2 := KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_2 ], function ( i_3 )
                            local deduped_1_3;
                            deduped_1_3 := i_3 - 1;
                            return REM_INT( deduped_1_3, deduped_14_2 ) * deduped_14_2 + QUO_INT( deduped_1_3, deduped_14_2 ) + 1;
                        end ) ), deduped_7_2 ), deduped_7_2, deduped_7_2, hoisted_1_1 ), deduped_8_2 );
            deduped_2_2 := KroneckerMat( deduped_12_2, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_2 ], function ( i_3 )
                            local deduped_1_3;
                            deduped_1_3 := i_3 - 1;
                            return REM_INT( deduped_1_3, deduped_14_2 ) * deduped_13_2 + QUO_INT( deduped_1_3, deduped_14_2 ) + 1;
                        end ) ), deduped_6_2 ), deduped_6_2, deduped_6_2, hoisted_1_1 ) );
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( function ( alpha_3, beta_3 )
                        return alpha_3 * beta_3;
                    end( HomalgIdentityMatrix( Dimension( deduped_5_2 ), hoisted_1_1 ), deduped_2_2 ), deduped_3_2 ), deduped_4_2 );
            morphism_attr_15_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_15_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_15_2 ) ), UnderlyingMatrix, morphism_attr_15_2 );
        end(  );
end
########
        
    , 2408 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedEvaluationForCoDual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := Dimension( a_1 );
    morphism_attr_2_1 := ConvertMatrixToRow( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedEvaluationForCoDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoclosedEvaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, morphism_attr_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := Dimension( b_1 );
    deduped_4_1 := Dimension( a_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_5_1, deduped_7_1 );
    deduped_2_1 := deduped_4_1 * deduped_5_1;
    deduped_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_4_1, deduped_7_1 ), ConvertMatrixToRow( deduped_3_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_2_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_5_1 ) * deduped_4_1 + QUO_INT( deduped_1_2, deduped_5_1 ) + 1);
                    end ) ), deduped_2_1 ), deduped_2_1, deduped_2_1, deduped_7_1 ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_5_1 * deduped_4_1), deduped_7_1 ), deduped_3_1 );
    morphism_attr_6_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_6_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_6_1 ) ), UnderlyingMatrix, morphism_attr_6_1 );
end
########
        
    , 2610 : IsPrecompiledDerivation := true );
    
    ##
    AddCoclosedEvaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1;
    hoisted_3_1 := Dimension( b_1 );
    hoisted_2_1 := Dimension( a_1 );
    hoisted_1_1 := UnderlyingRing( cat_1 );
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, morphism_attr_13_2;
            deduped_12_2 := hoisted_3_1;
            deduped_11_2 := hoisted_2_1;
            deduped_10_2 := HomalgIdentityMatrix( deduped_12_2, hoisted_1_1 );
            deduped_9_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_12_2 * deduped_11_2 );
            deduped_8_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_11_2 * deduped_12_2 );
            deduped_7_2 := ConvertMatrixToRow( deduped_10_2 );
            deduped_6_2 := deduped_10_2;
            deduped_5_2 := Dimension( deduped_8_2 );
            deduped_4_2 := KroneckerMat( HomalgIdentityMatrix( Dimension( deduped_9_2 ), hoisted_1_1 ), deduped_6_2 );
            deduped_3_2 := KroneckerMat( HomalgIdentityMatrix( deduped_11_2, hoisted_1_1 ), deduped_7_2 );
            deduped_2_2 := KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_2 ], function ( i_3 )
                            local deduped_1_3;
                            deduped_1_3 := i_3 - 1;
                            return REM_INT( deduped_1_3, deduped_12_2 ) * deduped_11_2 + QUO_INT( deduped_1_3, deduped_12_2 ) + 1;
                        end ) ), deduped_5_2 ), deduped_5_2, deduped_5_2, hoisted_1_1 ), deduped_6_2 );
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( deduped_3_2, deduped_2_2 ), deduped_4_2 );
            morphism_attr_13_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_13_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_13_2 ) ), UnderlyingMatrix, morphism_attr_13_2 );
        end(  );
end
########
        
    , 2207 : IsPrecompiledDerivation := true );
    
    ##
    AddCoefficientsOfMorphismWithGivenBasisOfExternalHom( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return EntriesOfHomalgMatrix( UnderlyingMatrix( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCoevaluationForDual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := Dimension( a_1 );
    morphism_attr_2_1 := ConvertMatrixToRow( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToRow( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddCoevaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, morphism_attr_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := Dimension( b_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_9_1 );
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_9_1 );
    deduped_3_1 := deduped_6_1 * deduped_7_1;
    deduped_2_1 := deduped_6_1 * deduped_6_1;
    deduped_1_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_2_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_6_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_6_1 ) + 1);
                    end ) ), deduped_2_1 ), deduped_2_1, deduped_2_1, deduped_9_1 ), deduped_5_1 ) * KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, deduped_9_1 ) );
    morphism_attr_8_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_8_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 );
end
########
        
    , 2811 : IsPrecompiledDerivation := true );
    
    ##
    AddCoevaluationMorphismWithGivenRange( cat,
        
########
function ( cat_1, a_1, b_1, r_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1;
    hoisted_3_1 := Dimension( a_1 );
    hoisted_2_1 := Dimension( b_1 );
    hoisted_1_1 := UnderlyingRing( cat_1 );
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, morphism_attr_15_2;
            deduped_14_2 := hoisted_3_1;
            deduped_13_2 := hoisted_2_1;
            deduped_12_2 := HomalgIdentityMatrix( deduped_13_2, hoisted_1_1 );
            deduped_11_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_13_2 * deduped_14_2 );
            deduped_10_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_13_2 * deduped_13_2 );
            deduped_9_2 := ConvertMatrixToRow( deduped_12_2 );
            deduped_8_2 := Dimension( deduped_11_2 );
            deduped_7_2 := Dimension( deduped_10_2 );
            deduped_6_2 := HomalgIdentityMatrix( deduped_14_2, hoisted_1_1 );
            deduped_5_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_13_2 * (deduped_14_2 * deduped_13_2) );
            deduped_4_2 := KroneckerMat( deduped_9_2, deduped_6_2 );
            deduped_3_2 := KroneckerMat( deduped_12_2, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_2 ], function ( i_3 )
                            local deduped_1_3;
                            deduped_1_3 := i_3 - 1;
                            return REM_INT( deduped_1_3, deduped_14_2 ) * deduped_13_2 + QUO_INT( deduped_1_3, deduped_14_2 ) + 1;
                        end ) ), deduped_8_2 ), deduped_8_2, deduped_8_2, hoisted_1_1 ) );
            deduped_2_2 := KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_2 ], function ( i_3 )
                            local deduped_1_3;
                            deduped_1_3 := i_3 - 1;
                            return REM_INT( deduped_1_3, deduped_13_2 ) * deduped_13_2 + QUO_INT( deduped_1_3, deduped_13_2 ) + 1;
                        end ) ), deduped_7_2 ), deduped_7_2, deduped_7_2, hoisted_1_1 ), deduped_6_2 );
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( function ( alpha_3, beta_3 )
                        return alpha_3 * beta_3;
                    end( deduped_4_2, deduped_2_2 ), deduped_3_2 ), HomalgIdentityMatrix( Dimension( deduped_5_2 ), hoisted_1_1 ) );
            morphism_attr_15_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_15_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_15_2 ) ), UnderlyingMatrix, morphism_attr_15_2 );
        end(  );
end
########
        
    , 2408 : IsPrecompiledDerivation := true );
    
    ##
    AddCoimageObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfRows( UnderlyingMatrix( arg2_1 ) );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return deduped_1_1;
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddCoimageProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, morphism_attr_8_1;
    deduped_6_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_8_1 := deduped_6_1;
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_8_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_8_1 );
    deduped_3_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_4_1 ) );
    morphism_attr_7_1 := deduped_3_1;
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_4_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_7_1 ) ), UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_2_1 ) );
end
########
        
    , 602 : IsPrecompiledDerivation := true );
    
    ##
    AddCoimageProjectionWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, C_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, morphism_attr_8_1;
    deduped_6_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_8_1 := deduped_6_1;
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_8_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_8_1 );
    deduped_3_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_4_1 ) );
    morphism_attr_7_1 := deduped_3_1;
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_4_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_7_1 ) ), UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_2_1 ) );
end
########
        
    , 603 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelColift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1;
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_3_1 := deduped_2_1;
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_1_1 ), Range( tau_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( tau_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1;
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_3_1 := deduped_2_1;
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_1_1 ), Range( tau_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( tau_1 ) ) );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_1_1 ) - RowRankOfMatrix( deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, morphism_attr_6_1, morphism_attr_7_1;
    deduped_5_1 := SyzygiesOfColumns( UnderlyingMatrix( alphap_1 ) );
    morphism_attr_7_1 := deduped_5_1;
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_6_1 := deduped_4_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alphap_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_7_1 ) ), UnderlyingMatrix, morphism_attr_7_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_6_1 ) ), UnderlyingMatrix, morphism_attr_6_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( mu_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( mu_1 ) * UnderlyingMatrix( deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_2_1 ), Range( deduped_1_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_2_1 ), UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 606 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelObjectFunctorialWithGivenCokernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, morphism_attr_6_1, morphism_attr_7_1;
    deduped_5_1 := SyzygiesOfColumns( UnderlyingMatrix( alphap_1 ) );
    morphism_attr_7_1 := deduped_5_1;
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_6_1 := deduped_4_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alphap_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_7_1 ) ), UnderlyingMatrix, morphism_attr_7_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_6_1 ) ), UnderlyingMatrix, morphism_attr_6_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( mu_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( mu_1 ) * UnderlyingMatrix( deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_2_1 ), Range( deduped_1_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_2_1 ), UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 405 : IsPrecompiledDerivation := true );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_2_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjectionWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_2_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( epsilon_1 ), Range( tau_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( epsilon_1 ), UnderlyingMatrix( tau_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddComponentOfMorphismFromDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, Dimension );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1[i_1], Range( alpha_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddComponentOfMorphismIntoDirectSum( cat,
        
########
function ( cat_1, alpha_1, S_1, i_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := List( S_1, Dimension );
    deduped_1_1 := Sum( deduped_2_1{[ 1 .. i_1 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), S_1[i_1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( alpha_1 ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1[i_1] ] ) );
end
########
        
    , 100 );
    
    ##
    AddCoproduct( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( arg2_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    return deduped_1_1;
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddCoproductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objectsp_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_4_1 := Dimension( deduped_6_1 );
    hoisted_10_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( deduped_4_1, deduped_11_1 ) );
    hoisted_9_1 := Length( objectsp_1 );
    hoisted_8_1 := deduped_11_1;
    deduped_2_1 := UnionOfRows( deduped_11_1, deduped_4_1, List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, morphism_attr_8_2;
              deduped_7_2 := objectsp_1[logic_new_func_x_2];
              deduped_5_2 := Dimension( deduped_7_2 );
              deduped_4_2 := UnionOfColumns( HomalgZeroMatrix( deduped_5_2, Sum( objectsp_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_8_1 ), HomalgIdentityMatrix( deduped_5_2, hoisted_8_1 ), HomalgZeroMatrix( deduped_5_2, Sum( objectsp_1{[ logic_new_func_x_2 + 1 .. hoisted_9_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_8_1 ) );
              morphism_attr_8_2 := deduped_4_2;
              deduped_6_2 := L_1[logic_new_func_x_2];
              deduped_3_2 := hoisted_10_1;
              deduped_2_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, deduped_7_2, ObjectifyObjectForCAPWithAttributes( rec(
                       ), cat_1, Dimension, NumberColumns( morphism_attr_8_2 ) ), UnderlyingMatrix, morphism_attr_8_2 );
              deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, Source( deduped_2_2 ), Range( deduped_3_2 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_2 ) * UnderlyingMatrix( deduped_3_2 ) );
              return UnderlyingMatrix( deduped_6_2 ) * UnderlyingMatrix( deduped_1_2 );
          end ) );
    morphism_attr_7_1 := deduped_2_1;
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_1 ), deduped_11_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_7_1 ) ), deduped_6_1, UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 2118 : IsPrecompiledDerivation := true );
    
    ##
    AddCoproductFunctorialWithGivenCoproducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    hoisted_8_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objectsp_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    hoisted_7_1 := Length( objectsp_1 );
    hoisted_6_1 := deduped_9_1;
    deduped_2_1 := UnionOfRows( deduped_9_1, Dimension( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              return function ( s_3 )
                      return UnderlyingMatrix( s_3 );
                  end( function ( i_3 )
                        local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3, deduped_5_3, deduped_6_3, deduped_7_3, deduped_8_3, morphism_attr_9_3;
                        deduped_8_3 := objectsp_1[i_3];
                        deduped_6_3 := Dimension( deduped_8_3 );
                        deduped_4_3 := UnionOfColumns( HomalgZeroMatrix( deduped_6_3, Sum( objectsp_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_6_1 ), HomalgIdentityMatrix( deduped_6_3, hoisted_6_1 ), HomalgZeroMatrix( deduped_6_3, Sum( objectsp_1{[ i_3 + 1 .. hoisted_7_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_6_1 ) );
                        morphism_attr_9_3 := deduped_4_3;
                        deduped_7_3 := L_1[i_3];
                        deduped_5_3 := hoisted_8_1;
                        deduped_3_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, deduped_5_3, deduped_5_3, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_3 ), hoisted_6_1 ) );
                        deduped_2_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, deduped_8_3, ObjectifyObjectForCAPWithAttributes( rec(
                                 ), cat_1, Dimension, NumberColumns( morphism_attr_9_3 ) ), UnderlyingMatrix, morphism_attr_9_3 );
                        deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_2_3 ), Range( deduped_3_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_3 ) * UnderlyingMatrix( deduped_3_3 ) );
                        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_7_3 ), Range( deduped_1_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_7_3 ) * UnderlyingMatrix( deduped_1_3 ) );
                    end( logic_new_func_x_2 ) );
          end ) );
    morphism_attr_5_1 := deduped_2_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), deduped_9_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_5_1 ) ), Pp_1, UnderlyingMatrix, morphism_attr_5_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 1713 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectProduct( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( arg2_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    return deduped_1_1;
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectProductFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_4_1 := Dimension( deduped_5_1 );
    hoisted_10_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( deduped_4_1, deduped_11_1 ) );
    hoisted_9_1 := Length( objects_1 );
    hoisted_8_1 := deduped_11_1;
    deduped_2_1 := UnionOfColumns( deduped_11_1, deduped_4_1, List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, morphism_attr_8_2;
              deduped_6_2 := objects_1[logic_new_func_x_2];
              deduped_5_2 := Dimension( deduped_6_2 );
              deduped_4_2 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_5_2, hoisted_8_1 ), HomalgIdentityMatrix( deduped_5_2, hoisted_8_1 ), HomalgZeroMatrix( Sum( objects_1{[ logic_new_func_x_2 + 1 .. hoisted_9_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_5_2, hoisted_8_1 ) );
              morphism_attr_8_2 := deduped_4_2;
              deduped_7_2 := L_1[logic_new_func_x_2];
              deduped_3_2 := hoisted_10_1;
              deduped_2_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), cat_1, Dimension, NumberRows( morphism_attr_8_2 ) ), deduped_6_2, UnderlyingMatrix, morphism_attr_8_2 );
              deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, Source( deduped_3_2 ), Range( deduped_2_2 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_2 ) * UnderlyingMatrix( deduped_2_2 ) );
              return UnderlyingMatrix( deduped_1_2 ) * UnderlyingMatrix( deduped_7_2 );
          end ) );
    morphism_attr_7_1 := deduped_2_1;
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objectsp_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_6_1 ), deduped_11_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_7_1 ) ), UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 2118 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectProductFunctorialWithGivenDirectProducts( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    hoisted_8_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    hoisted_7_1 := Length( objects_1 );
    hoisted_6_1 := deduped_9_1;
    deduped_2_1 := UnionOfColumns( deduped_9_1, Dimension( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              return function ( s_3 )
                      return UnderlyingMatrix( s_3 );
                  end( function ( i_3 )
                        local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3, deduped_5_3, deduped_6_3, deduped_7_3, deduped_8_3, morphism_attr_9_3;
                        deduped_7_3 := objects_1[i_3];
                        deduped_6_3 := Dimension( deduped_7_3 );
                        deduped_4_3 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_6_3, hoisted_6_1 ), HomalgIdentityMatrix( deduped_6_3, hoisted_6_1 ), HomalgZeroMatrix( Sum( objects_1{[ i_3 + 1 .. hoisted_7_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_6_3, hoisted_6_1 ) );
                        morphism_attr_9_3 := deduped_4_3;
                        deduped_8_3 := L_1[i_3];
                        deduped_5_3 := hoisted_8_1;
                        deduped_3_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, deduped_5_3, deduped_5_3, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_3 ), hoisted_6_1 ) );
                        deduped_2_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                                 ), cat_1, Dimension, NumberRows( morphism_attr_9_3 ) ), deduped_7_3, UnderlyingMatrix, morphism_attr_9_3 );
                        deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_3_3 ), Range( deduped_2_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_3 ) * UnderlyingMatrix( deduped_2_3 ) );
                        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_1_3 ), Range( deduped_8_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_3 ) * UnderlyingMatrix( deduped_8_3 ) );
                    end( logic_new_func_x_2 ) );
          end ) );
    morphism_attr_5_1 := deduped_2_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objectsp_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), deduped_9_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_5_1 ) ), UnderlyingMatrix, morphism_attr_5_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 1713 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( arg2_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSumCodiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, hoisted_10_1, hoisted_11_1, deduped_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( D_1, Range );
    hoisted_11_1 := Length( deduped_7_1 );
    hoisted_10_1 := deduped_13_1;
    deduped_8_1 := Length( D_1 );
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_7_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_4_1 := List( [ 1 .. deduped_8_1 ], function ( i_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := D_1[i_2];
            deduped_3_2 := deduped_7_1[i_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_3_2, deduped_6_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_2, Sum( deduped_7_1{[ 1 .. i_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_10_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_10_1 ), HomalgZeroMatrix( deduped_2_2, Sum( deduped_7_1{[ i_2 + 1 .. hoisted_11_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_10_1 ) ) );
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, Source( deduped_4_2 ), Range( deduped_1_2 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_2 ) * UnderlyingMatrix( deduped_1_2 ) );
        end );
    deduped_12_1 := List( deduped_4_1, function ( s_2 )
            return UnderlyingMatrix( s_2 );
        end );
    deduped_5_1 := Dimension( deduped_6_1 );
    deduped_2_1 := UnionOfRows( deduped_13_1, deduped_5_1, deduped_12_1{[ 1 .. deduped_8_1 - 1 ]} );
    morphism_attr_9_1 := deduped_2_1;
    deduped_3_1 := UnionOfRows( deduped_13_1, deduped_5_1, deduped_12_1{[ 2 .. deduped_8_1 ]} );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_9_1 ) ), deduped_6_1, UnderlyingMatrix, morphism_attr_9_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) + -1 * deduped_3_1 );
end
########
        
    , 1706 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectSumDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, hoisted_10_1, hoisted_11_1, deduped_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := List( D_1, Source );
    hoisted_11_1 := Length( deduped_7_1 );
    hoisted_10_1 := deduped_13_1;
    deduped_8_1 := Length( D_1 );
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_7_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_4_1 := List( [ 1 .. deduped_8_1 ], function ( i_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := D_1[i_2];
            deduped_3_2 := deduped_7_1[i_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_6_1, deduped_3_2, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_7_1{[ 1 .. i_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_10_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_10_1 ), HomalgZeroMatrix( Sum( deduped_7_1{[ i_2 + 1 .. hoisted_11_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_10_1 ) ) );
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, Source( deduped_1_2 ), Range( deduped_4_2 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_2 ) * UnderlyingMatrix( deduped_4_2 ) );
        end );
    deduped_12_1 := List( deduped_4_1, function ( s_2 )
            return UnderlyingMatrix( s_2 );
        end );
    deduped_5_1 := Dimension( deduped_6_1 );
    deduped_2_1 := UnionOfColumns( deduped_13_1, deduped_5_1, deduped_12_1{[ 1 .. deduped_8_1 - 1 ]} );
    morphism_attr_9_1 := deduped_2_1;
    deduped_3_1 := UnionOfColumns( deduped_13_1, deduped_5_1, deduped_12_1{[ 2 .. deduped_8_1 ]} );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_9_1 ) ), UnderlyingMatrix, morphism_attr_9_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) + -1 * deduped_3_1 );
end
########
        
    , 1706 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectSumFunctorial( cat,
        
########
function ( cat_1, objects_1, L_1, objectsp_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := DiagMat( UnderlyingRing( cat_1 ), List( L_1, function ( mor_2 )
              return UnderlyingMatrix( mor_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, DiagMat( UnderlyingRing( cat_1 ), List( L_1, function ( mor_2 )
                return UnderlyingMatrix( mor_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSumProjectionInPushout( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, morphism_attr_20_1, morphism_attr_21_1, hoisted_22_1, deduped_23_1;
    deduped_23_1 := UnderlyingRing( cat_1 );
    hoisted_22_1 := deduped_23_1;
    deduped_19_1 := Length( D_1 );
    deduped_18_1 := List( D_1, Range );
    deduped_16_1 := [ 1 .. deduped_19_1 ];
    deduped_15_1 := Length( deduped_18_1 );
    deduped_14_1 := [ 1 .. deduped_19_1 - 1 ];
    deduped_13_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_18_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_12_1 := Dimension( deduped_13_1 );
    deduped_10_1 := List( deduped_16_1, function ( logic_new_func_x_2 )
            return function ( s_3 )
                    return UnderlyingMatrix( s_3 );
                end( function ( i_3 )
                      local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3;
                      deduped_4_3 := D_1[i_3];
                      deduped_3_3 := deduped_18_1[i_3];
                      deduped_2_3 := Dimension( deduped_3_3 );
                      deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, deduped_3_3, deduped_13_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_3, Sum( deduped_18_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_22_1 ), HomalgIdentityMatrix( deduped_2_3, hoisted_22_1 ), HomalgZeroMatrix( deduped_2_3, Sum( deduped_18_1{[ i_3 + 1 .. deduped_15_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_22_1 ) ) );
                      return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, Source( deduped_4_3 ), Range( deduped_1_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_3 ) * UnderlyingMatrix( deduped_1_3 ) );
                  end( logic_new_func_x_2 ) );
        end );
    deduped_8_1 := UnionOfRows( deduped_23_1, deduped_12_1, deduped_10_1{deduped_14_1} );
    morphism_attr_21_1 := deduped_8_1;
    deduped_17_1 := [ 2 .. deduped_19_1 ];
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_21_1 ) ), deduped_13_1, UnderlyingMatrix, morphism_attr_21_1 );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_7_1 ), Range( deduped_7_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_7_1 ) + -1 * UnionOfRows( deduped_23_1, deduped_12_1, deduped_10_1{deduped_17_1} ) );
    deduped_3_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_20_1 := deduped_3_1;
    deduped_11_1 := List( deduped_16_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := D_1[logic_new_func_x_2];
            deduped_3_2 := deduped_18_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_3_2, deduped_13_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_2, Sum( deduped_18_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_22_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_22_1 ), HomalgZeroMatrix( deduped_2_2, Sum( deduped_18_1{[ logic_new_func_x_2 + 1 .. deduped_15_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_22_1 ) ) );
            return UnderlyingMatrix( deduped_4_2 ) * UnderlyingMatrix( deduped_1_2 );
        end );
    deduped_9_1 := UnionOfRows( deduped_23_1, deduped_12_1, deduped_11_1{deduped_14_1} );
    deduped_6_1 := deduped_9_1 + -1 * UnionOfRows( deduped_23_1, deduped_12_1, deduped_11_1{deduped_17_1} );
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), deduped_23_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_5_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_20_1 ) ), UnderlyingMatrix, morphism_attr_20_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_2_1 ) );
end
########
        
    , 3814 : IsPrecompiledDerivation := true );
    
    ##
    AddDistinguishedObjectOfHomomorphismStructure( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
end
########
        
    , 100 );
    
    ##
    AddDualOnMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Source( alpha_1 ), UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddDualOnMorphismsWithGivenDuals( cat,
        
########
function ( cat_1, s_1, alpha_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, TransposedMatrix( UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddDualOnObjects( cat,
        
########
function ( cat_1, a_1 )
    return a_1;
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddEvaluationForDual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := Dimension( a_1 );
    morphism_attr_2_1 := ConvertMatrixToColumn( HomalgIdentityMatrix( deduped_1_1, UnderlyingRing( cat_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_2_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, ConvertMatrixToColumn( HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddEvaluationMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, morphism_attr_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := Dimension( b_1 );
    deduped_4_1 := Dimension( a_1 );
    deduped_3_1 := HomalgIdentityMatrix( deduped_4_1, deduped_7_1 );
    deduped_2_1 := deduped_4_1 * deduped_5_1;
    deduped_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_2_1, deduped_7_1 ), deduped_3_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_2_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_5_1 ) * deduped_4_1 + QUO_INT( deduped_1_2, deduped_5_1 ) + 1);
                    end ) ), deduped_2_1 ), deduped_2_1, deduped_2_1, deduped_7_1 ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_7_1 ), ConvertMatrixToColumn( deduped_3_1 ) );
    morphism_attr_6_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_6_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_6_1 ) ), UnderlyingMatrix, morphism_attr_6_1 );
end
########
        
    , 2610 : IsPrecompiledDerivation := true );
    
    ##
    AddEvaluationMorphismWithGivenSource( cat,
        
########
function ( cat_1, a_1, b_1, s_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1;
    hoisted_3_1 := Dimension( b_1 );
    hoisted_2_1 := Dimension( a_1 );
    hoisted_1_1 := UnderlyingRing( cat_1 );
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, morphism_attr_12_2;
            deduped_11_2 := hoisted_3_1;
            deduped_10_2 := hoisted_2_1;
            deduped_9_2 := HomalgIdentityMatrix( deduped_10_2, hoisted_1_1 );
            deduped_8_2 := ConvertMatrixToColumn( deduped_9_2 );
            deduped_7_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_10_2 * deduped_11_2 );
            deduped_6_2 := deduped_9_2;
            deduped_5_2 := Dimension( deduped_7_2 );
            deduped_4_2 := KroneckerMat( HomalgIdentityMatrix( deduped_11_2, hoisted_1_1 ), deduped_8_2 );
            deduped_3_2 := KroneckerMat( HomalgIdentityMatrix( deduped_5_2, hoisted_1_1 ), deduped_6_2 );
            deduped_2_2 := KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_2 ], function ( i_3 )
                            local deduped_1_3;
                            deduped_1_3 := i_3 - 1;
                            return REM_INT( deduped_1_3, deduped_11_2 ) * deduped_10_2 + QUO_INT( deduped_1_3, deduped_11_2 ) + 1;
                        end ) ), deduped_5_2 ), deduped_5_2, deduped_5_2, hoisted_1_1 ), deduped_6_2 );
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( deduped_3_2, deduped_2_2 ), deduped_4_2 );
            morphism_attr_12_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_12_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_12_2 ) ), UnderlyingMatrix, morphism_attr_12_2 );
        end(  );
end
########
        
    , 2207 : IsPrecompiledDerivation := true );
    
    ##
    AddFiberProduct( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, morphism_attr_19_1, morphism_attr_20_1, hoisted_21_1, deduped_22_1;
    deduped_22_1 := UnderlyingRing( cat_1 );
    hoisted_21_1 := deduped_22_1;
    deduped_18_1 := Length( arg2_1 );
    deduped_17_1 := List( arg2_1, Source );
    deduped_15_1 := [ 1 .. deduped_18_1 ];
    deduped_14_1 := Length( deduped_17_1 );
    deduped_13_1 := [ 1 .. deduped_18_1 - 1 ];
    deduped_12_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_17_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_11_1 := Dimension( deduped_12_1 );
    deduped_9_1 := List( deduped_15_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := arg2_1[logic_new_func_x_2];
            deduped_3_2 := deduped_17_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_12_1, deduped_3_2, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_17_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_21_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_21_1 ), HomalgZeroMatrix( Sum( deduped_17_1{[ logic_new_func_x_2 + 1 .. deduped_14_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_21_1 ) ) );
            return UnderlyingMatrix( deduped_1_2 ) * UnderlyingMatrix( deduped_4_2 );
        end );
    deduped_8_1 := UnionOfColumns( deduped_22_1, deduped_11_1, deduped_9_1{deduped_13_1} );
    morphism_attr_20_1 := deduped_8_1;
    deduped_16_1 := [ 2 .. deduped_18_1 ];
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_12_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_20_1 ) ), UnderlyingMatrix, morphism_attr_20_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_6_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_1 ) + -1 * UnionOfColumns( deduped_22_1, deduped_11_1, deduped_9_1{deduped_16_1} ) );
    deduped_2_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_4_1 ) );
    morphism_attr_19_1 := deduped_2_1;
    deduped_10_1 := List( deduped_15_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_17_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_17_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_21_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_21_1 ), HomalgZeroMatrix( Sum( deduped_17_1{[ (logic_new_func_x_2 + 1) .. deduped_14_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_21_1 ) ) * UnderlyingMatrix( arg2_1[logic_new_func_x_2] );
        end );
    deduped_7_1 := UnionOfColumns( deduped_22_1, deduped_11_1, deduped_10_1{deduped_13_1} ) + -1 * UnionOfColumns( deduped_22_1, deduped_11_1, deduped_10_1{deduped_16_1} );
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_1 ), deduped_22_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_19_1 ) ), Source( deduped_4_1 ), UnderlyingMatrix, morphism_attr_19_1 );
    return Source( deduped_3_1 );
end
########
        
    , 3815 : IsPrecompiledDerivation := true );
    
    ##
    AddFiberProductEmbeddingInDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, morphism_attr_20_1, morphism_attr_21_1, hoisted_22_1, deduped_23_1;
    deduped_23_1 := UnderlyingRing( cat_1 );
    hoisted_22_1 := deduped_23_1;
    deduped_19_1 := Length( D_1 );
    deduped_18_1 := List( D_1, Source );
    deduped_16_1 := [ 1 .. deduped_19_1 ];
    deduped_15_1 := Length( deduped_18_1 );
    deduped_14_1 := [ 1 .. deduped_19_1 - 1 ];
    deduped_13_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_18_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_12_1 := Dimension( deduped_13_1 );
    deduped_11_1 := List( deduped_16_1, function ( logic_new_func_x_2 )
            return function ( s_3 )
                    return UnderlyingMatrix( s_3 );
                end( function ( i_3 )
                      local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3;
                      deduped_4_3 := D_1[i_3];
                      deduped_3_3 := deduped_18_1[i_3];
                      deduped_2_3 := Dimension( deduped_3_3 );
                      deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, deduped_13_1, deduped_3_3, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_18_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_2_3, hoisted_22_1 ), HomalgIdentityMatrix( deduped_2_3, hoisted_22_1 ), HomalgZeroMatrix( Sum( deduped_18_1{[ i_3 + 1 .. deduped_15_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_2_3, hoisted_22_1 ) ) );
                      return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, Source( deduped_1_3 ), Range( deduped_4_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_3 ) * UnderlyingMatrix( deduped_4_3 ) );
                  end( logic_new_func_x_2 ) );
        end );
    deduped_9_1 := UnionOfColumns( deduped_23_1, deduped_12_1, deduped_11_1{deduped_14_1} );
    morphism_attr_21_1 := deduped_9_1;
    deduped_17_1 := [ 2 .. deduped_19_1 ];
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_13_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_21_1 ) ), UnderlyingMatrix, morphism_attr_21_1 );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_7_1 ), Range( deduped_7_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_7_1 ) + -1 * UnionOfColumns( deduped_23_1, deduped_12_1, deduped_11_1{deduped_17_1} ) );
    deduped_4_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_20_1 := deduped_4_1;
    deduped_10_1 := List( deduped_16_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := D_1[logic_new_func_x_2];
            deduped_3_2 := deduped_18_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_13_1, deduped_3_2, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_18_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_22_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_22_1 ), HomalgZeroMatrix( Sum( deduped_18_1{[ logic_new_func_x_2 + 1 .. deduped_15_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_22_1 ) ) );
            return UnderlyingMatrix( deduped_1_2 ) * UnderlyingMatrix( deduped_4_2 );
        end );
    deduped_8_1 := UnionOfColumns( deduped_23_1, deduped_12_1, deduped_10_1{deduped_14_1} );
    deduped_6_1 := deduped_8_1 + -1 * UnionOfColumns( deduped_23_1, deduped_12_1, deduped_10_1{deduped_17_1} );
    deduped_3_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_20_1 ) ), Source( deduped_5_1 ), UnderlyingMatrix, morphism_attr_20_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_3_1, deduped_3_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_3_1 ), deduped_23_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_2_1 ) );
end
########
        
    , 3814 : IsPrecompiledDerivation := true );
    
    ##
    AddFiberProductFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, morphism_attr_29_1, morphism_attr_30_1, morphism_attr_31_1, hoisted_32_1, hoisted_33_1, hoisted_34_1, hoisted_35_1, hoisted_36_1, deduped_37_1;
    deduped_37_1 := UnderlyingRing( cat_1 );
    deduped_25_1 := List( morphisms_1, Source );
    hoisted_36_1 := List( deduped_25_1, Dimension );
    hoisted_33_1 := Length( deduped_25_1 );
    hoisted_32_1 := deduped_37_1;
    deduped_26_1 := Length( morphisms_1 );
    deduped_23_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_25_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_21_1 := Dimension( deduped_23_1 );
    deduped_19_1 := List( [ 1 .. deduped_26_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_25_1[logic_new_func_x_2] );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_25_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_32_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_32_1 ), HomalgZeroMatrix( Sum( deduped_25_1{[ (logic_new_func_x_2 + 1) .. hoisted_33_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_32_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    deduped_17_1 := UnionOfColumns( deduped_37_1, deduped_21_1, deduped_19_1{[ 1 .. deduped_26_1 - 1 ]} );
    deduped_15_1 := -1 * UnionOfColumns( deduped_37_1, deduped_21_1, deduped_19_1{[ 2 .. deduped_26_1 ]} );
    deduped_13_1 := deduped_17_1 + deduped_15_1;
    deduped_10_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_13_1 ) - RowRankOfMatrix( deduped_13_1 ) );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_10_1, deduped_10_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_10_1 ), deduped_37_1 ) );
    hoisted_35_1 := UnderlyingMatrix( deduped_6_1 );
    deduped_27_1 := List( morphismsp_1, Source );
    hoisted_34_1 := Length( deduped_27_1 );
    deduped_28_1 := Length( morphismsp_1 );
    deduped_24_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_27_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_22_1 := Dimension( deduped_24_1 );
    deduped_20_1 := List( [ 1 .. deduped_28_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_27_1[logic_new_func_x_2] );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_27_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_32_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_32_1 ), HomalgZeroMatrix( Sum( deduped_27_1{[ (logic_new_func_x_2 + 1) .. hoisted_34_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_32_1 ) ) * UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] );
        end );
    deduped_18_1 := UnionOfColumns( deduped_37_1, deduped_22_1, deduped_20_1{[ 1 .. deduped_28_1 - 1 ]} );
    morphism_attr_29_1 := deduped_18_1;
    deduped_16_1 := -1 * UnionOfColumns( deduped_37_1, deduped_22_1, deduped_20_1{[ 2 .. deduped_28_1 ]} );
    deduped_12_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_24_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_29_1 ) ), UnderlyingMatrix, morphism_attr_29_1 );
    deduped_9_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_12_1 ), Range( deduped_12_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_12_1 ) + deduped_16_1 );
    deduped_7_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_9_1 ) );
    morphism_attr_31_1 := deduped_7_1;
    deduped_5_1 := Source( deduped_6_1 );
    deduped_3_1 := UnionOfColumns( deduped_37_1, Dimension( deduped_5_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, morphism_attr_10_2, morphism_attr_11_2;
              morphism_attr_11_2 := deduped_17_1;
              deduped_6_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, deduped_23_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), cat_1, Dimension, NumberColumns( morphism_attr_11_2 ) ), UnderlyingMatrix, morphism_attr_11_2 );
              deduped_5_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, Source( deduped_6_2 ), Range( deduped_6_2 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_2 ) + deduped_15_1 );
              deduped_4_2 := SyzygiesOfRows( UnderlyingMatrix( deduped_5_2 ) );
              morphism_attr_10_2 := deduped_4_2;
              deduped_9_2 := L_1[logic_new_func_x_2];
              deduped_8_2 := hoisted_36_1;
              deduped_7_2 := Sum( deduped_8_2{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
              deduped_3_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), cat_1, Dimension, NumberRows( morphism_attr_10_2 ) ), Source( deduped_5_2 ), UnderlyingMatrix, morphism_attr_10_2 );
              deduped_2_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, deduped_5_1, Range( deduped_3_2 ), UnderlyingMatrix, hoisted_35_1 * UnderlyingMatrix( deduped_3_2 ) );
              deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, Source( deduped_2_2 ), deduped_25_1[logic_new_func_x_2], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( deduped_2_2 ), [ deduped_7_2 .. deduped_7_2 - 1 + deduped_8_2[logic_new_func_x_2] ] ) );
              return UnderlyingMatrix( deduped_1_2 ) * UnderlyingMatrix( deduped_9_2 );
          end ) );
    morphism_attr_30_1 := deduped_3_1;
    deduped_14_1 := deduped_18_1 + deduped_16_1;
    deduped_11_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_14_1 ) - RowRankOfMatrix( deduped_14_1 ) );
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_11_1, deduped_11_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_11_1 ), deduped_37_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_31_1 ) ), Source( deduped_9_1 ), UnderlyingMatrix, morphism_attr_31_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_30_1 ) ), UnderlyingMatrix, morphism_attr_30_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Source( deduped_4_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_2_1 ), UnderlyingMatrix( deduped_4_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_8_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_8_1 ) );
end
########
        
    , 19782 : IsPrecompiledDerivation := true );
    
    ##
    AddFiberProductFunctorialWithGivenFiberProducts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, morphism_attr_22_1, morphism_attr_23_1, morphism_attr_24_1, hoisted_25_1, hoisted_26_1, hoisted_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    hoisted_27_1 := Length( morphisms_1 );
    hoisted_26_1 := List( morphisms_1, Source );
    hoisted_25_1 := deduped_28_1;
    deduped_21_1 := Length( morphismsp_1 );
    deduped_20_1 := List( morphismsp_1, Source );
    deduped_18_1 := [ 1 .. deduped_21_1 ];
    deduped_17_1 := Length( deduped_20_1 );
    deduped_16_1 := [ 1 .. deduped_21_1 - 1 ];
    deduped_15_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_20_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_14_1 := Dimension( deduped_15_1 );
    deduped_12_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_20_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_25_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_25_1 ), HomalgZeroMatrix( Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_25_1 ) ) * UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] );
        end );
    deduped_10_1 := UnionOfColumns( deduped_28_1, deduped_14_1, deduped_12_1{deduped_16_1} );
    morphism_attr_24_1 := deduped_10_1;
    deduped_19_1 := [ 2 .. deduped_21_1 ];
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_15_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_8_1 ), Range( deduped_8_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_8_1 ) + -1 * UnionOfColumns( deduped_28_1, deduped_14_1, deduped_12_1{deduped_19_1} ) );
    deduped_5_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_23_1 := deduped_5_1;
    deduped_3_1 := UnionOfColumns( deduped_28_1, Dimension( P_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              return function ( s_3 )
                      return UnderlyingMatrix( s_3 );
                  end( function ( i_3 )
                        local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3, deduped_5_3, deduped_6_3, deduped_7_3, deduped_8_3, deduped_9_3, deduped_10_3, deduped_11_3, deduped_12_3, deduped_13_3, deduped_14_3, deduped_15_3, deduped_16_3, deduped_17_3, deduped_18_3, deduped_19_3, morphism_attr_20_3, morphism_attr_21_3, hoisted_22_3;
                        deduped_17_3 := hoisted_26_1;
                        hoisted_22_3 := Length( deduped_17_3 );
                        deduped_18_3 := hoisted_27_1;
                        deduped_14_3 := ObjectifyObjectForCAPWithAttributes( rec(
                               ), cat_1, Dimension, Sum( List( deduped_17_3, function ( object_4 )
                                    return Dimension( object_4 );
                                end ) ) );
                        deduped_13_3 := Dimension( deduped_14_3 );
                        deduped_12_3 := List( [ 1 .. deduped_18_3 ], function ( logic_new_func_x_4 )
                                local deduped_1_4;
                                deduped_1_4 := Dimension( deduped_17_3[logic_new_func_x_4] );
                                return UnionOfRows( HomalgZeroMatrix( Sum( deduped_17_3{[ 1 .. (logic_new_func_x_4 - 1) ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), deduped_1_4, hoisted_25_1 ), HomalgIdentityMatrix( deduped_1_4, hoisted_25_1 ), HomalgZeroMatrix( Sum( deduped_17_3{[ (logic_new_func_x_4 + 1) .. hoisted_22_3 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), deduped_1_4, hoisted_25_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_4] );
                            end );
                        deduped_11_3 := UnionOfColumns( hoisted_25_1, deduped_13_3, deduped_12_3{[ 1 .. deduped_18_3 - 1 ]} );
                        morphism_attr_21_3 := deduped_11_3;
                        deduped_10_3 := -1 * UnionOfColumns( hoisted_25_1, deduped_13_3, deduped_12_3{[ 2 .. deduped_18_3 ]} );
                        deduped_8_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, deduped_14_3, ObjectifyObjectForCAPWithAttributes( rec(
                                 ), cat_1, Dimension, NumberColumns( morphism_attr_21_3 ) ), UnderlyingMatrix, morphism_attr_21_3 );
                        deduped_6_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_8_3 ), Range( deduped_8_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_8_3 ) + deduped_10_3 );
                        deduped_5_3 := SyzygiesOfRows( UnderlyingMatrix( deduped_6_3 ) );
                        morphism_attr_20_3 := deduped_5_3;
                        deduped_19_3 := L_1[i_3];
                        deduped_16_3 := List( deduped_17_3, Dimension );
                        deduped_15_3 := Sum( deduped_16_3{[ 1 .. i_3 - 1 ]} ) + 1;
                        deduped_9_3 := deduped_11_3 + deduped_10_3;
                        deduped_7_3 := ObjectifyObjectForCAPWithAttributes( rec(
                               ), cat_1, Dimension, NumberRows( deduped_9_3 ) - RowRankOfMatrix( deduped_9_3 ) );
                        deduped_4_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, deduped_7_3, deduped_7_3, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_7_3 ), hoisted_25_1 ) );
                        deduped_3_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                                 ), cat_1, Dimension, NumberRows( morphism_attr_20_3 ) ), Source( deduped_6_3 ), UnderlyingMatrix, morphism_attr_20_3 );
                        deduped_2_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_4_3 ), Range( deduped_3_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_3 ) * UnderlyingMatrix( deduped_3_3 ) );
                        deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_2_3 ), deduped_17_3[i_3], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( deduped_2_3 ), [ deduped_15_3 .. deduped_15_3 - 1 + deduped_16_3[i_3] ] ) );
                        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_1_3 ), Range( deduped_19_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_3 ) * UnderlyingMatrix( deduped_19_3 ) );
                    end( logic_new_func_x_2 ) );
          end ) );
    morphism_attr_22_1 := deduped_3_1;
    deduped_13_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_20_1[logic_new_func_x_2] );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_25_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_25_1 ), HomalgZeroMatrix( Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_25_1 ) ) * UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] );
        end );
    deduped_11_1 := UnionOfColumns( deduped_28_1, deduped_14_1, deduped_13_1{deduped_16_1} ) + -1 * UnionOfColumns( deduped_28_1, deduped_14_1, deduped_13_1{deduped_19_1} );
    deduped_9_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_11_1 ) - RowRankOfMatrix( deduped_11_1 ) );
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_9_1, deduped_9_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_9_1 ), deduped_28_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_23_1 ) ), Source( deduped_6_1 ), UnderlyingMatrix, morphism_attr_23_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_22_1 ) ), UnderlyingMatrix, morphism_attr_22_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Source( deduped_4_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_2_1 ), UnderlyingMatrix( deduped_4_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_7_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_7_1 ) );
end
########
        
    , 12151 : IsPrecompiledDerivation := true );
    
    ##
    AddHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    deduped_3_1 := SyzygiesOfRows( UnderlyingMatrix( beta_1 ) );
    deduped_2_1 := SyzygiesOfColumns( deduped_3_1 * deduped_4_1 );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return deduped_1_1;
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddHomologyObjectFunctorialWithGivenHomologyObjects( cat,
        
########
function ( cat_1, H_1_1, L_1, H_2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1, deduped_30_1, deduped_31_1, deduped_32_1, deduped_33_1, deduped_34_1, deduped_35_1, deduped_36_1, deduped_37_1, deduped_38_1, deduped_39_1, deduped_40_1, deduped_41_1, deduped_42_1, deduped_43_1, deduped_44_1, deduped_45_1, deduped_46_1, deduped_47_1, deduped_48_1, morphism_attr_49_1, morphism_attr_50_1, morphism_attr_51_1, morphism_attr_52_1, morphism_attr_53_1, morphism_attr_54_1, morphism_attr_55_1, morphism_attr_56_1, deduped_57_1;
    deduped_57_1 := UnderlyingRing( cat_1 );
    deduped_48_1 := L_1[5];
    deduped_43_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_48_1 ) );
    morphism_attr_54_1 := deduped_43_1;
    deduped_47_1 := L_1[4];
    deduped_42_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_47_1 ) );
    morphism_attr_53_1 := deduped_42_1;
    deduped_38_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_54_1 ) ), Source( deduped_48_1 ), UnderlyingMatrix, morphism_attr_54_1 );
    deduped_37_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_47_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_53_1 ) ), UnderlyingMatrix, morphism_attr_53_1 );
    deduped_34_1 := UnderlyingMatrix( deduped_37_1 );
    deduped_33_1 := Range( deduped_37_1 );
    deduped_28_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_38_1 ), deduped_33_1, UnderlyingMatrix, UnderlyingMatrix( deduped_38_1 ) * deduped_34_1 );
    deduped_23_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_28_1 ) );
    morphism_attr_50_1 := deduped_23_1;
    deduped_18_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_28_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_50_1 ) ), UnderlyingMatrix, morphism_attr_50_1 );
    deduped_12_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_18_1 ) );
    morphism_attr_56_1 := deduped_12_1;
    deduped_45_1 := L_1[1];
    deduped_41_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_45_1 ) );
    morphism_attr_52_1 := deduped_41_1;
    deduped_44_1 := L_1[2];
    deduped_40_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_44_1 ) );
    morphism_attr_51_1 := deduped_40_1;
    deduped_36_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_45_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_52_1 ) ), UnderlyingMatrix, morphism_attr_52_1 );
    deduped_35_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_51_1 ) ), Source( deduped_44_1 ), UnderlyingMatrix, morphism_attr_51_1 );
    deduped_32_1 := Range( deduped_36_1 );
    deduped_31_1 := UnderlyingMatrix( deduped_36_1 );
    deduped_29_1 := UnderlyingMatrix( deduped_35_1 ) * deduped_31_1;
    deduped_26_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_35_1 ), deduped_32_1, UnderlyingMatrix, deduped_29_1 );
    deduped_22_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_26_1 ) );
    morphism_attr_49_1 := deduped_22_1;
    deduped_16_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_26_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_49_1 ) ), UnderlyingMatrix, morphism_attr_49_1 );
    deduped_11_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_16_1 ) );
    morphism_attr_55_1 := deduped_11_1;
    deduped_46_1 := L_1[3];
    deduped_39_1 := SyzygiesOfColumns( deduped_43_1 * deduped_42_1 );
    deduped_30_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_39_1 ) - RowRankOfMatrix( deduped_39_1 ) );
    deduped_27_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_46_1 ), deduped_33_1, UnderlyingMatrix, UnderlyingMatrix( deduped_46_1 ) * deduped_34_1 );
    deduped_25_1 := SyzygiesOfColumns( deduped_29_1 );
    deduped_24_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_30_1, deduped_30_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_30_1 ), deduped_57_1 ) );
    deduped_21_1 := Range( deduped_24_1 );
    deduped_20_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_32_1, Range( deduped_27_1 ), UnderlyingMatrix, LeftDivide( deduped_31_1, UnderlyingMatrix( deduped_27_1 ) ) );
    deduped_19_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_25_1 ) - RowRankOfMatrix( deduped_25_1 ) );
    deduped_17_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_23_1 ) - RowRankOfMatrix( deduped_23_1 ) );
    deduped_15_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_22_1 ) - RowRankOfMatrix( deduped_22_1 ) );
    deduped_14_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_21_1, deduped_21_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_21_1 ), deduped_57_1 ) );
    deduped_13_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_19_1, deduped_19_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_19_1 ), deduped_57_1 ) );
    deduped_10_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_17_1, deduped_17_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_17_1 ), deduped_57_1 ) );
    deduped_9_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_15_1, deduped_15_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_15_1 ), deduped_57_1 ) );
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_14_1 ), Source( deduped_24_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_14_1 ), UnderlyingMatrix( deduped_24_1 ) ) );
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_56_1 ) ), Source( deduped_18_1 ), UnderlyingMatrix, morphism_attr_56_1 );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_55_1 ) ), Source( deduped_16_1 ), UnderlyingMatrix, morphism_attr_55_1 );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_10_1 ), Range( deduped_7_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_10_1 ) * UnderlyingMatrix( deduped_7_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_9_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_9_1 ) * UnderlyingMatrix( deduped_6_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_20_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_20_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Source( deduped_5_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_3_1 ), UnderlyingMatrix( deduped_5_1 ) ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_8_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_8_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_13_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_13_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 3815 : IsPrecompiledDerivation := true );
    
    ##
    AddHomomorphismStructureOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddHomomorphismStructureOnMorphismsWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, beta_1, range_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, source_1, range_1, UnderlyingMatrix, KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddHomomorphismStructureOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( arg2_1 ) * Dimension( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddImageEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, morphism_attr_8_1;
    deduped_6_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_8_1 := deduped_6_1;
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 );
    deduped_3_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_7_1 := deduped_3_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_7_1 ) ), Source( deduped_5_1 ), UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 602 : IsPrecompiledDerivation := true );
    
    ##
    AddImageEmbeddingWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, I_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, morphism_attr_8_1;
    deduped_6_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_8_1 := deduped_6_1;
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 );
    deduped_3_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_7_1 := deduped_3_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_6_1 ) - RowRankOfMatrix( deduped_6_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_7_1 ) ), Source( deduped_5_1 ), UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 603 : IsPrecompiledDerivation := true );
    
    ##
    AddImageObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( arg2_1 ) );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return deduped_1_1;
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddInitialObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return deduped_1_1;
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddInitialObjectFunctorial( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddInitialObjectFunctorialWithGivenInitialObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( Pp_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := objects_1[k_1];
    deduped_5_1 := Dimension( deduped_6_1 );
    deduped_3_1 := UnionOfColumns( HomalgZeroMatrix( deduped_5_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_8_1 ), HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), HomalgZeroMatrix( deduped_5_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_8_1 ) );
    morphism_attr_7_1 := deduped_3_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), deduped_8_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_7_1 ) ), UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_2_1 ) );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := objects_1[k_1];
    deduped_5_1 := Dimension( deduped_6_1 );
    deduped_3_1 := UnionOfColumns( HomalgZeroMatrix( deduped_5_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_8_1 ), HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), HomalgZeroMatrix( deduped_5_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_8_1 ) );
    morphism_attr_7_1 := deduped_3_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), deduped_8_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_7_1 ) ), UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_2_1 ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := objects_1[k_1];
    deduped_1_1 := Dimension( deduped_2_1 );
    morphism_attr_3_1 := UnionOfColumns( HomalgZeroMatrix( deduped_1_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_4_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_4_1 ), HomalgZeroMatrix( deduped_1_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_4_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := objects_1[k_1];
    deduped_1_1 := Dimension( deduped_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, P_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_1_1, Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( deduped_1_1, Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInjectionOfCofactorOfPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, morphism_attr_22_1, morphism_attr_23_1, hoisted_24_1, deduped_25_1;
    deduped_25_1 := UnderlyingRing( cat_1 );
    hoisted_24_1 := deduped_25_1;
    deduped_21_1 := Length( morphisms_1 );
    deduped_20_1 := List( morphisms_1, Range );
    deduped_18_1 := [ 1 .. deduped_21_1 ];
    deduped_16_1 := Length( deduped_20_1 );
    deduped_15_1 := [ 1 .. deduped_21_1 - 1 ];
    deduped_13_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_20_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_12_1 := Dimension( deduped_13_1 );
    deduped_10_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := morphisms_1[logic_new_func_x_2];
            deduped_3_2 := deduped_20_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_3_2, deduped_13_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_2, Sum( deduped_20_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_24_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_24_1 ), HomalgZeroMatrix( deduped_2_2, Sum( deduped_20_1{[ logic_new_func_x_2 + 1 .. deduped_16_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_24_1 ) ) );
            return UnderlyingMatrix( deduped_4_2 ) * UnderlyingMatrix( deduped_1_2 );
        end );
    deduped_8_1 := UnionOfRows( deduped_25_1, deduped_12_1, deduped_10_1{deduped_15_1} );
    morphism_attr_23_1 := deduped_8_1;
    deduped_19_1 := [ 2 .. deduped_21_1 ];
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_23_1 ) ), deduped_13_1, UnderlyingMatrix, morphism_attr_23_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_6_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_1 ) + -1 * UnionOfRows( deduped_25_1, deduped_12_1, deduped_10_1{deduped_19_1} ) );
    deduped_3_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_4_1 ) );
    morphism_attr_22_1 := deduped_3_1;
    deduped_17_1 := List( deduped_20_1, Dimension );
    deduped_14_1 := Sum( deduped_17_1{[ 1 .. k_1 - 1 ]} ) + 1;
    deduped_11_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_20_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_24_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_24_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_16_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_24_1 ) );
        end );
    deduped_9_1 := UnionOfRows( deduped_25_1, deduped_12_1, deduped_11_1{deduped_15_1} ) + -1 * UnionOfRows( deduped_25_1, deduped_12_1, deduped_11_1{deduped_19_1} );
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_9_1 ) - RowRankOfMatrix( deduped_9_1 ) );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_7_1, deduped_7_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_7_1 ), deduped_25_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_4_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_22_1 ) ), UnderlyingMatrix, morphism_attr_22_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_5_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_5_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_20_1[k_1], Range( deduped_1_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( deduped_1_1 ), [ deduped_14_1 .. deduped_14_1 - 1 + deduped_17_1[k_1] ] ) );
end
########
        
    , 3915 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectionOfCofactorOfPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, morphism_attr_22_1, morphism_attr_23_1, hoisted_24_1, deduped_25_1;
    deduped_25_1 := UnderlyingRing( cat_1 );
    hoisted_24_1 := deduped_25_1;
    deduped_21_1 := Length( morphisms_1 );
    deduped_20_1 := List( morphisms_1, Range );
    deduped_18_1 := [ 1 .. deduped_21_1 ];
    deduped_16_1 := Length( deduped_20_1 );
    deduped_15_1 := [ 1 .. deduped_21_1 - 1 ];
    deduped_13_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_20_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_12_1 := Dimension( deduped_13_1 );
    deduped_10_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_20_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_24_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_24_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_16_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_24_1 ) );
        end );
    deduped_8_1 := UnionOfRows( deduped_25_1, deduped_12_1, deduped_10_1{deduped_15_1} );
    morphism_attr_23_1 := deduped_8_1;
    deduped_19_1 := [ 2 .. deduped_21_1 ];
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_23_1 ) ), deduped_13_1, UnderlyingMatrix, morphism_attr_23_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_6_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_1 ) + -1 * UnionOfRows( deduped_25_1, deduped_12_1, deduped_10_1{deduped_19_1} ) );
    deduped_3_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_4_1 ) );
    morphism_attr_22_1 := deduped_3_1;
    deduped_17_1 := List( deduped_20_1, Dimension );
    deduped_14_1 := Sum( deduped_17_1{[ 1 .. k_1 - 1 ]} ) + 1;
    deduped_11_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_20_1[logic_new_func_x_2] );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_24_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_24_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_16_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_24_1 ) );
        end );
    deduped_9_1 := UnionOfRows( deduped_25_1, deduped_12_1, deduped_11_1{deduped_15_1} ) + -1 * UnionOfRows( deduped_25_1, deduped_12_1, deduped_11_1{deduped_19_1} );
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_9_1 ) - RowRankOfMatrix( deduped_9_1 ) );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_7_1, deduped_7_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_7_1 ), deduped_25_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_4_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_22_1 ) ), UnderlyingMatrix, morphism_attr_22_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_5_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_5_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_20_1[k_1], Range( deduped_1_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( deduped_1_1 ), [ deduped_14_1 .. deduped_14_1 - 1 + deduped_17_1[k_1] ] ) );
end
########
        
    , 3916 : IsPrecompiledDerivation := true );
    
    ##
    AddInjectiveColift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( beta_1 ) ), UnderlyingMatrix( alpha_1 ) );
    morphism_attr_2_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_2_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 1810 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomOnMorphismsWithGivenInternalCoHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1;
    hoisted_6_1 := Source( beta_1 );
    hoisted_5_1 := Range( beta_1 );
    hoisted_4_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( beta_1 ) ), UnderlyingMatrix( alpha_1 ) );
    hoisted_3_1 := Dimension( Range( alpha_1 ) );
    hoisted_2_1 := Dimension( Source( alpha_1 ) );
    hoisted_1_1 := UnderlyingRing( cat_1 );
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, morphism_attr_7_2;
            deduped_6_2 := hoisted_6_1;
            deduped_5_2 := hoisted_5_1;
            deduped_4_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, hoisted_3_1 * Dimension( deduped_6_2 ) );
            deduped_3_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, hoisted_2_1 * Dimension( deduped_5_2 ) );
            deduped_2_2 := hoisted_4_1;
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( HomalgIdentityMatrix( Dimension( deduped_3_2 ), hoisted_1_1 ), deduped_2_2 ), HomalgIdentityMatrix( Dimension( deduped_4_2 ), hoisted_1_1 ) );
            morphism_attr_7_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_7_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_7_2 ) ), UnderlyingMatrix, morphism_attr_7_2 );
        end(  );
end
########
        
    , 1205 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return deduped_1_1;
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphism( cat,
        
########
function ( cat_1, list_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, morphism_attr_24_1, morphism_attr_25_1, deduped_26_1;
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_23_1 := Dimension( list_1[2] );
    deduped_22_1 := Dimension( list_1[1] );
    deduped_21_1 := Dimension( list_1[4] );
    deduped_20_1 := Dimension( list_1[3] );
    deduped_19_1 := deduped_22_1 * deduped_20_1;
    deduped_17_1 := deduped_23_1 * deduped_21_1;
    deduped_14_1 := deduped_20_1 * deduped_21_1;
    deduped_13_1 := deduped_14_1 * deduped_14_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_14_1, deduped_26_1 );
    deduped_11_1 := deduped_19_1;
    deduped_10_1 := deduped_17_1;
    deduped_9_1 := deduped_11_1 * deduped_10_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_9_1, deduped_26_1 );
    deduped_7_1 := deduped_9_1 * deduped_14_1;
    deduped_5_1 := KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_26_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_26_1 ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_12_1 ), deduped_8_1 );
    morphism_attr_25_1 := deduped_5_1;
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_26_1 );
    deduped_16_1 := HomalgIdentityMatrix( deduped_21_1, deduped_26_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_22_1, deduped_26_1 );
    deduped_6_1 := deduped_20_1 * deduped_10_1;
    deduped_4_1 := KroneckerMat( deduped_15_1, KroneckerMat( HomalgIdentityMatrix( deduped_23_1, deduped_26_1 ), ConvertMatrixToRow( deduped_16_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_21_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_21_1 ) + 1);
                          end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_26_1 ), deduped_16_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_21_1 * deduped_23_1), deduped_26_1 ), deduped_16_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_15_1, ConvertMatrixToRow( deduped_18_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_22_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                            end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_26_1 ), deduped_18_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_20_1 * deduped_22_1), deduped_26_1 ), deduped_18_1 )), HomalgIdentityMatrix( deduped_10_1, deduped_26_1 ) ), deduped_16_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_11_1, deduped_26_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_26_1 ) ), deduped_16_1 );
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_12_1 ), deduped_4_1 );
    morphism_attr_24_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_25_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_25_1 ) ), UnderlyingMatrix, morphism_attr_25_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 14160 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphismInverse( cat,
        
########
function ( cat_1, list_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, morphism_attr_24_1, morphism_attr_25_1, deduped_26_1;
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_23_1 := Dimension( list_1[2] );
    deduped_22_1 := Dimension( list_1[1] );
    deduped_21_1 := Dimension( list_1[4] );
    deduped_20_1 := Dimension( list_1[3] );
    deduped_19_1 := deduped_22_1 * deduped_20_1;
    deduped_17_1 := deduped_23_1 * deduped_21_1;
    deduped_14_1 := deduped_20_1 * deduped_21_1;
    deduped_13_1 := deduped_14_1 * deduped_14_1;
    deduped_12_1 := deduped_19_1 * deduped_17_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_14_1, deduped_26_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_12_1, deduped_26_1 );
    deduped_8_1 := deduped_12_1 * deduped_14_1;
    deduped_7_1 := KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_26_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_26_1 ), deduped_9_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_10_1 ), deduped_9_1 );
    morphism_attr_25_1 := deduped_7_1;
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_26_1 );
    deduped_16_1 := HomalgIdentityMatrix( deduped_21_1, deduped_26_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_22_1, deduped_26_1 );
    deduped_11_1 := deduped_20_1 * deduped_17_1;
    deduped_5_1 := KroneckerMat( TransposedMatrix( deduped_10_1 ), KroneckerMat( deduped_15_1, KroneckerMat( HomalgIdentityMatrix( deduped_23_1, deduped_26_1 ), ConvertMatrixToRow( deduped_16_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_21_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_21_1 ) + 1);
                            end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_26_1 ), deduped_16_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_21_1 * deduped_23_1), deduped_26_1 ), deduped_16_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_15_1, ConvertMatrixToRow( deduped_18_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_22_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                              end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_26_1 ), deduped_18_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_20_1 * deduped_22_1), deduped_26_1 ), deduped_18_1 )), HomalgIdentityMatrix( deduped_17_1, deduped_26_1 ) ), deduped_16_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_19_1, deduped_26_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                      end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_26_1 ) ), deduped_16_1 ) );
    morphism_attr_24_1 := deduped_5_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_25_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_25_1 ) ), UnderlyingMatrix, morphism_attr_25_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_6_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_26_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 14363 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, morphism_attr_27_1, morphism_attr_28_1, deduped_29_1;
    deduped_29_1 := UnderlyingRing( cat_1 );
    deduped_26_1 := Dimension( list_1[2] );
    deduped_25_1 := Dimension( list_1[1] );
    deduped_24_1 := Dimension( list_1[4] );
    deduped_23_1 := Dimension( list_1[3] );
    deduped_22_1 := deduped_25_1 * deduped_23_1;
    deduped_20_1 := deduped_26_1 * deduped_24_1;
    deduped_17_1 := deduped_23_1 * deduped_24_1;
    deduped_16_1 := deduped_17_1 * deduped_17_1;
    deduped_15_1 := HomalgIdentityMatrix( deduped_17_1, deduped_29_1 );
    deduped_14_1 := deduped_22_1;
    deduped_13_1 := deduped_20_1;
    deduped_12_1 := deduped_14_1 * deduped_13_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_12_1, deduped_29_1 );
    deduped_10_1 := deduped_12_1 * deduped_17_1;
    deduped_8_1 := KroneckerMat( deduped_15_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                    end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_29_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                    end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_29_1 ), deduped_11_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_15_1 ), deduped_11_1 );
    morphism_attr_28_1 := deduped_8_1;
    deduped_21_1 := HomalgIdentityMatrix( deduped_23_1, deduped_29_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_24_1, deduped_29_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_25_1, deduped_29_1 );
    deduped_9_1 := deduped_23_1 * deduped_13_1;
    deduped_7_1 := KroneckerMat( deduped_18_1, KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_29_1 ), ConvertMatrixToRow( deduped_19_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_20_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_24_1 ) * deduped_26_1 + QUO_INT( deduped_1_2, deduped_24_1 ) + 1);
                          end ) ), deduped_20_1 ), deduped_20_1, deduped_20_1, deduped_29_1 ), deduped_19_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_24_1 * deduped_26_1), deduped_29_1 ), deduped_19_1 ) ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_18_1, ConvertMatrixToRow( deduped_21_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_22_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_25_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                            end ) ), deduped_22_1 ), deduped_22_1, deduped_22_1, deduped_29_1 ), deduped_21_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_23_1 * deduped_25_1), deduped_29_1 ), deduped_21_1 )), HomalgIdentityMatrix( deduped_13_1, deduped_29_1 ) ), deduped_19_1 ) * KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_14_1, deduped_29_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_13_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_13_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_29_1 ) ), deduped_19_1 );
    deduped_5_1 := KroneckerMat( TransposedMatrix( deduped_15_1 ), deduped_7_1 );
    morphism_attr_27_1 := deduped_5_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_28_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_28_1 ) ), UnderlyingMatrix, morphism_attr_28_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_27_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_27_1 ) ), UnderlyingMatrix, morphism_attr_27_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_6_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_29_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 13156 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomTensorProductCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, morphism_attr_23_1, morphism_attr_24_1, hoisted_25_1, hoisted_26_1, hoisted_27_1, hoisted_28_1, hoisted_29_1, hoisted_30_1, hoisted_31_1, hoisted_32_1, hoisted_33_1, hoisted_34_1, hoisted_35_1, hoisted_36_1, deduped_37_1;
    deduped_37_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := Dimension( list_1[3] );
    hoisted_36_1 := HomalgIdentityMatrix( deduped_17_1, deduped_37_1 );
    deduped_21_1 := list_1[4];
    deduped_18_1 := Dimension( deduped_21_1 );
    hoisted_35_1 := HomalgIdentityMatrix( deduped_18_1, deduped_37_1 );
    deduped_22_1 := list_1[1];
    deduped_19_1 := Dimension( deduped_22_1 );
    hoisted_34_1 := HomalgIdentityMatrix( deduped_19_1, deduped_37_1 );
    deduped_20_1 := Dimension( list_1[2] );
    deduped_15_1 := deduped_20_1 * deduped_18_1;
    deduped_13_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_15_1 );
    deduped_11_1 := Dimension( deduped_13_1 );
    hoisted_33_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_17_1 * deduped_11_1 );
    hoisted_32_1 := HomalgIdentityMatrix( deduped_17_1 * deduped_19_1, deduped_37_1 );
    deduped_16_1 := deduped_19_1 * deduped_17_1;
    hoisted_31_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, deduped_17_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1;
              end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_37_1 );
    hoisted_30_1 := HomalgIdentityMatrix( deduped_18_1 * deduped_20_1, deduped_37_1 );
    hoisted_29_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, deduped_18_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1;
              end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_37_1 );
    hoisted_28_1 := HomalgIdentityMatrix( deduped_20_1, deduped_37_1 );
    deduped_14_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_16_1 );
    deduped_12_1 := Dimension( deduped_14_1 );
    hoisted_27_1 := HomalgIdentityMatrix( deduped_12_1, deduped_37_1 );
    hoisted_26_1 := deduped_37_1;
    hoisted_25_1 := HomalgIdentityMatrix( deduped_11_1, deduped_37_1 );
    deduped_10_1 := deduped_17_1 * deduped_18_1;
    deduped_9_1 := deduped_10_1 * deduped_10_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_10_1, deduped_37_1 );
    deduped_7_1 := deduped_12_1 * deduped_11_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_7_1, deduped_37_1 );
    deduped_5_1 := deduped_7_1 * deduped_10_1;
    deduped_4_1 := KroneckerMat( deduped_8_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_37_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_37_1 ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_8_1 ), deduped_6_1 );
    morphism_attr_24_1 := deduped_4_1;
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_8_1 ), UnderlyingMatrix( function (  )
                local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, morphism_attr_15_2;
                deduped_14_2 := hoisted_36_1;
                deduped_13_2 := hoisted_35_1;
                deduped_12_2 := hoisted_34_1;
                deduped_11_2 := deduped_13_2;
                deduped_10_2 := hoisted_33_1;
                deduped_9_2 := Dimension( deduped_10_2 );
                deduped_8_2 := KroneckerMat( deduped_12_2, ConvertMatrixToRow( deduped_14_2 ) ) * KroneckerMat( hoisted_31_1, deduped_14_2 ) * KroneckerMat( hoisted_32_1, deduped_14_2 );
                deduped_7_2 := KroneckerMat( hoisted_28_1, ConvertMatrixToRow( deduped_13_2 ) ) * KroneckerMat( hoisted_29_1, deduped_13_2 ) * KroneckerMat( hoisted_30_1, deduped_13_2 );
                deduped_6_2 := KroneckerMat( hoisted_27_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := i_3 - 1;
                                return REM_INT( deduped_1_3, deduped_11_1 ) * deduped_17_1 + QUO_INT( deduped_1_3, deduped_11_1 ) + 1;
                            end ) ), deduped_9_2 ), deduped_9_2, deduped_9_2, hoisted_26_1 ) );
                deduped_5_2 := KroneckerMat( deduped_8_2, hoisted_25_1 );
                deduped_4_2 := KroneckerMat( deduped_12_2, deduped_7_2 );
                deduped_3_2 := KroneckerMat( deduped_6_2, deduped_11_2 );
                deduped_2_2 := KroneckerMat( deduped_5_2, deduped_11_2 );
                deduped_1_2 := function ( alpha_3, beta_3 )
                        return alpha_3 * beta_3;
                    end( function ( alpha_3, beta_3 )
                          return alpha_3 * beta_3;
                      end( deduped_4_2, deduped_2_2 ), deduped_3_2 );
                morphism_attr_15_2 := deduped_1_2;
                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberRows( morphism_attr_15_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberColumns( morphism_attr_15_2 ) ), UnderlyingMatrix, morphism_attr_15_2 );
            end(  ) ) );
    morphism_attr_23_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_23_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_23_1 ) ), UnderlyingMatrix, morphism_attr_23_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 12953 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalCoHomToTensorProductAdjunctionMap( cat,
        
########
function ( cat_1, a_1, b_1, f_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := Dimension( b_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_11_1 );
    deduped_4_1 := KroneckerMat( UnderlyingMatrix( f_1 ), deduped_5_1 );
    morphism_attr_10_1 := deduped_4_1;
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := deduped_7_1 * deduped_8_1;
    deduped_2_1 := KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_11_1 ), ConvertMatrixToRow( deduped_5_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_11_1 ), deduped_5_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_8_1 * deduped_7_1), deduped_11_1 ), deduped_5_1 );
    morphism_attr_9_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_10_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_9_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_9_1 ) ), UnderlyingMatrix, morphism_attr_9_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 3112 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    morphism_attr_2_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_2_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 1810 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomOnMorphismsWithGivenInternalHoms( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1;
    hoisted_6_1 := Source( alpha_1 );
    hoisted_5_1 := Range( alpha_1 );
    hoisted_4_1 := KroneckerMat( TransposedMatrix( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( beta_1 ) );
    hoisted_3_1 := Dimension( Range( beta_1 ) );
    hoisted_2_1 := Dimension( Source( beta_1 ) );
    hoisted_1_1 := UnderlyingRing( cat_1 );
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, morphism_attr_7_2;
            deduped_6_2 := hoisted_6_1;
            deduped_5_2 := hoisted_5_1;
            deduped_4_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, Dimension( deduped_6_2 ) * hoisted_3_1 );
            deduped_3_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, Dimension( deduped_5_2 ) * hoisted_2_1 );
            deduped_2_2 := hoisted_4_1;
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( HomalgIdentityMatrix( Dimension( deduped_3_2 ), hoisted_1_1 ), deduped_2_2 ), HomalgIdentityMatrix( Dimension( deduped_4_2 ), hoisted_1_1 ) );
            morphism_attr_7_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_7_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_7_2 ) ), UnderlyingMatrix, morphism_attr_7_2 );
        end(  );
end
########
        
    , 1205 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomOnObjects( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return deduped_1_1;
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddInternalHomToTensorProductAdjunctionMap( cat,
        
########
function ( cat_1, b_1, c_1, g_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( b_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_11_1 );
    deduped_4_1 := KroneckerMat( UnderlyingMatrix( g_1 ), deduped_5_1 );
    morphism_attr_10_1 := deduped_4_1;
    deduped_8_1 := Dimension( c_1 );
    deduped_6_1 := deduped_7_1 * deduped_8_1;
    deduped_2_1 := KroneckerMat( HomalgIdentityMatrix( deduped_6_1, deduped_11_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_11_1 ), deduped_5_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_11_1 ), ConvertMatrixToColumn( deduped_5_1 ) );
    morphism_attr_9_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_10_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_9_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_9_1 ) ), UnderlyingMatrix, morphism_attr_9_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 3112 : IsPrecompiledDerivation := true );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_2_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 100 );
    
    ##
    AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( cat,
        
########
function ( cat_1, source_1, alpha_1, range_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := ConvertMatrixToRow( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_2_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg3_1, UnderlyingMatrix, ConvertRowToMatrix( UnderlyingMatrix( arg4_1 ), Dimension( arg2_1 ), Dimension( arg3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddInverseForMorphisms( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Range( alpha_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), UnderlyingRing( cat_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( alpha_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( alpha_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddInverseMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, morphism_attr_21_1, morphism_attr_22_1, morphism_attr_23_1, morphism_attr_24_1, deduped_25_1;
    deduped_25_1 := UnderlyingRing( cat_1 );
    deduped_19_1 := UnderlyingMatrix( alpha_1 );
    deduped_18_1 := SyzygiesOfColumns( deduped_19_1 );
    morphism_attr_22_1 := deduped_18_1;
    deduped_20_1 := Range( alpha_1 );
    deduped_15_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_20_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_22_1 ) ), UnderlyingMatrix, morphism_attr_22_1 );
    deduped_12_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_15_1 ) );
    morphism_attr_24_1 := deduped_12_1;
    deduped_17_1 := SyzygiesOfRows( deduped_19_1 );
    morphism_attr_21_1 := deduped_17_1;
    deduped_13_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_21_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_21_1 );
    deduped_11_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_13_1 ) );
    morphism_attr_23_1 := deduped_11_1;
    deduped_16_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_18_1 ) - RowRankOfMatrix( deduped_18_1 ) );
    deduped_14_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_17_1 ) - RowRankOfMatrix( deduped_17_1 ) );
    deduped_10_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_16_1, deduped_16_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_16_1 ), deduped_25_1 ) );
    deduped_9_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_14_1, deduped_14_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_14_1 ), deduped_25_1 ) );
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), Source( deduped_15_1 ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_13_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_23_1 ) ), UnderlyingMatrix, morphism_attr_23_1 );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_7_1 ), Range( deduped_9_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_7_1 ) * UnderlyingMatrix( deduped_9_1 ) );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_6_1 ), deduped_20_1, UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_6_1 ), deduped_19_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_5_1 ), Source( deduped_8_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_5_1 ), UnderlyingMatrix( deduped_8_1 ) ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_10_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_10_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_25_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 2214 : IsPrecompiledDerivation := true );
    
    ##
    AddIsAutomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Dimension( Range( arg2_1 ) );
    deduped_1_1 := Dimension( Source( arg2_1 ) );
    return deduped_1_1 = deduped_2_1 and (deduped_2_1 = deduped_1_1 and ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = deduped_2_1);
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddIsBijectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return true and true;
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsCodominating( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddIsColiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsColiftableAlongEpimorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroColumns( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsDominating( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEndomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( Source( arg2_1 ) ) = Dimension( Range( arg2_1 ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = Dimension( Range( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualAsFactorobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingMatrix( arg3_1 );
    deduped_3_1 := UnderlyingMatrix( arg2_1 );
    return IsZero( DecideZeroColumns( deduped_3_1, deduped_4_1 ) ) and IsZero( DecideZeroColumns( deduped_4_1, deduped_3_1 ) );
end
########
        
    , 205 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualAsSubobjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingMatrix( arg3_1 );
    deduped_3_1 := UnderlyingMatrix( arg2_1 );
    return IsZero( DecideZeroRows( deduped_3_1, deduped_4_1 ) ) and IsZero( DecideZeroRows( deduped_4_1, deduped_3_1 ) );
end
########
        
    , 205 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualForMorphismsOnMor( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    if Dimension( Source( arg2_1 ) ) = Dimension( Source( arg3_1 ) ) and Dimension( Range( arg2_1 ) ) = Dimension( Range( arg3_1 ) ) then
        return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
    else
        return false;
    fi;
    return;
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return Dimension( arg2_1 ) = Dimension( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsIdempotent( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return deduped_1_1 * deduped_1_1 = deduped_1_1;
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsIdenticalToIdentityMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Source( arg2_1 );
    deduped_2_1 := Dimension( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_3_1, deduped_3_1, UnderlyingMatrix, HomalgIdentityMatrix( deduped_2_1, UnderlyingRing( cat_1 ) ) );
    if deduped_2_1 = Dimension( Source( deduped_1_1 ) ) and Dimension( Range( arg2_1 ) ) = Dimension( Range( deduped_1_1 ) ) then
        return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( deduped_1_1 );
    else
        return false;
    fi;
    return;
end
########
        
    , 403 : IsPrecompiledDerivation := true );
    
    ##
    AddIsIdenticalToZeroMorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Range( arg2_1 );
    deduped_1_1 := Source( arg2_1 );
    return UnderlyingMatrix( arg2_1 ) = HomalgZeroMatrix( Dimension( deduped_1_1 ), Dimension( deduped_2_1 ), UnderlyingRing( cat_1 ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddIsInitial( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsInjective( cat,
        
########
function ( cat_1, arg2_1 )
    return true;
end
########
        
    , 100 );
    
    ##
    AddIsIsomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := Dimension( Range( arg2_1 ) );
    return deduped_1_1 = Dimension( Source( arg2_1 ) ) and ColumnRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = deduped_1_1;
end
########
        
    , 100 );
    
    ##
    AddIsLiftable( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg2_1 ), UnderlyingMatrix( arg3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsLiftableAlongMonomorphism( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg3_1 ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    return RowRankOfMatrix( UnderlyingMatrix( arg2_1 ) ) = Dimension( Source( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsOne( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := Source( arg2_1 );
    return HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) = UnderlyingMatrix( arg2_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsProjective( cat,
        
########
function ( cat_1, arg2_1 )
    return true;
end
########
        
    , 100 );
    
    ##
    AddIsSplitEpimorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := Range( arg2_1 );
    return IsZero( DecideZeroRows( HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsSplitMonomorphism( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := Source( arg2_1 );
    return IsZero( DecideZeroColumns( HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( arg2_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsTerminal( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( arg2_1 );
    deduped_2_1 := Range( arg2_1 );
    deduped_1_1 := Source( arg2_1 );
    if not IS_IDENTICAL_OBJ( cat_1, CapCategory( deduped_1_1 ) ) then
        return false;
    elif not IS_IDENTICAL_OBJ( cat_1, CapCategory( arg2_1 ) ) then
        return false;
    elif not IS_IDENTICAL_OBJ( cat_1, CapCategory( deduped_2_1 ) ) then
        return false;
    elif NumberRows( deduped_3_1 ) <> Dimension( deduped_1_1 ) then
        return false;
    elif NumberColumns( deduped_3_1 ) <> Dimension( deduped_2_1 ) then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    if not IS_IDENTICAL_OBJ( cat_1, CapCategory( arg2_1 ) ) then
        return false;
    elif Dimension( arg2_1 ) < 0 then
        return false;
    else
        return true;
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddIsZeroForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    return IsZero( UnderlyingMatrix( arg2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddIsZeroForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 ) = 0;
end
########
        
    , 100 );
    
    ##
    AddIsomorphismFromCoDualToInternalCoHom( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromCoimageToCokernelOfKernel( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    deduped_2_1 := deduped_3_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromCokernelOfDiagonalDifferenceToPushout( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, morphism_attr_10_1, hoisted_11_1, hoisted_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, Range );
    hoisted_12_1 := Length( deduped_8_1 );
    hoisted_11_1 := deduped_13_1;
    deduped_9_1 := Length( D_1 );
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_8_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_6_1 := Dimension( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( logic_new_func_x_2 )
            return function ( s_3 )
                    return UnderlyingMatrix( s_3 );
                end( function ( i_3 )
                      local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3;
                      deduped_4_3 := D_1[i_3];
                      deduped_3_3 := deduped_8_1[i_3];
                      deduped_2_3 := Dimension( deduped_3_3 );
                      deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, deduped_3_3, deduped_7_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_3, Sum( deduped_8_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_11_1 ), HomalgIdentityMatrix( deduped_2_3, hoisted_11_1 ), HomalgZeroMatrix( deduped_2_3, Sum( deduped_8_1{[ i_3 + 1 .. hoisted_12_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_11_1 ) ) );
                      return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, Source( deduped_4_3 ), Range( deduped_1_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_3 ) * UnderlyingMatrix( deduped_1_3 ) );
                  end( logic_new_func_x_2 ) );
        end );
    deduped_4_1 := UnionOfRows( deduped_13_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} );
    morphism_attr_10_1 := deduped_4_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_10_1 ) ), deduped_7_1, UnderlyingMatrix, morphism_attr_10_1 );
    deduped_2_1 := UnderlyingMatrix( deduped_3_1 ) + -1 * UnionOfRows( deduped_13_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), deduped_13_1 ) );
end
########
        
    , 1907 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromCokernelOfKernelToCoimage( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    deduped_2_1 := deduped_3_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromCoproductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromDirectProductToDirectSum( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromDirectSumToCoproduct( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromDirectSumToDirectProduct( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( D_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromDualToInternalHom( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromFiberProductToKernelOfDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, morphism_attr_10_1, hoisted_11_1, hoisted_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, Source );
    hoisted_12_1 := Length( deduped_8_1 );
    hoisted_11_1 := deduped_13_1;
    deduped_9_1 := Length( D_1 );
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_8_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_6_1 := Dimension( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( logic_new_func_x_2 )
            return function ( s_3 )
                    return UnderlyingMatrix( s_3 );
                end( function ( i_3 )
                      local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3;
                      deduped_4_3 := D_1[i_3];
                      deduped_3_3 := deduped_8_1[i_3];
                      deduped_2_3 := Dimension( deduped_3_3 );
                      deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, deduped_7_1, deduped_3_3, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_8_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_2_3, hoisted_11_1 ), HomalgIdentityMatrix( deduped_2_3, hoisted_11_1 ), HomalgZeroMatrix( Sum( deduped_8_1{[ i_3 + 1 .. hoisted_12_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_2_3, hoisted_11_1 ) ) );
                      return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, Source( deduped_1_3 ), Range( deduped_4_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_3 ) * UnderlyingMatrix( deduped_4_3 ) );
                  end( logic_new_func_x_2 ) );
        end );
    deduped_4_1 := UnionOfColumns( deduped_13_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} );
    morphism_attr_10_1 := deduped_4_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_7_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_2_1 := UnderlyingMatrix( deduped_3_1 ) + -1 * UnionOfColumns( deduped_13_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), deduped_13_1 ) );
end
########
        
    , 1907 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromHomologyObjectToItsConstructionAsAnImageObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, morphism_attr_8_1;
    deduped_6_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_8_1 := deduped_6_1;
    deduped_5_1 := SyzygiesOfRows( UnderlyingMatrix( beta_1 ) );
    morphism_attr_7_1 := deduped_5_1;
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_7_1 ) ), Source( beta_1 ), UnderlyingMatrix, morphism_attr_7_1 );
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_4_1 ) );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 703 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromImageObjectToKernelOfCokernel( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    deduped_2_1 := deduped_3_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInitialObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToCoDual( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToObject( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, morphism_attr_11_1, morphism_attr_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := Dimension( a_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_10_1, deduped_13_1 );
    deduped_8_1 := 1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_13_1 );
    deduped_4_1 := KroneckerMat( TransposedMatrix( deduped_5_1 ), deduped_9_1 );
    morphism_attr_12_1 := deduped_4_1;
    deduped_7_1 := deduped_8_1 * deduped_8_1;
    deduped_6_1 := deduped_10_1 * deduped_8_1;
    deduped_2_1 := KroneckerMat( deduped_5_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_13_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_13_1 ), deduped_9_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_5_1 ), deduped_9_1 );
    morphism_attr_11_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_12_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_12_1 ) ), UnderlyingMatrix, morphism_attr_12_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_11_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_11_1 ) ), UnderlyingMatrix, morphism_attr_11_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 5025 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToObjectWithGivenInternalCoHom( cat,
        
########
function ( cat_1, a_1, s_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, morphism_attr_12_1, morphism_attr_13_1, deduped_14_1;
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := Dimension( a_1 );
    deduped_10_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_11_1, deduped_14_1 );
    deduped_8_1 := Dimension( deduped_10_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_14_1 );
    deduped_4_1 := KroneckerMat( TransposedMatrix( deduped_5_1 ), deduped_9_1 );
    morphism_attr_13_1 := deduped_4_1;
    deduped_7_1 := deduped_8_1 * deduped_8_1;
    deduped_6_1 := deduped_11_1 * deduped_8_1;
    deduped_2_1 := KroneckerMat( deduped_5_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_14_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_14_1 ), deduped_9_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_5_1 ), deduped_9_1 );
    morphism_attr_12_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_13_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_13_1 ) ), UnderlyingMatrix, morphism_attr_13_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_12_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_12_1 ) ), UnderlyingMatrix, morphism_attr_12_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 5024 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalCoHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToDual( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToObject( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, morphism_attr_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := HomalgIdentityMatrix( 1, deduped_9_1 );
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := 1 * deduped_6_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_9_1 );
    deduped_2_1 := KroneckerMat( HomalgIdentityMatrix( deduped_5_1, deduped_9_1 ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_6_1 ) * 1 + QUO_INT( deduped_1_2, deduped_6_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_9_1 ), deduped_7_1 ) * KroneckerMat( deduped_4_1, ConvertMatrixToColumn( deduped_7_1 ) );
    morphism_attr_8_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, deduped_4_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_8_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 2914 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToObjectWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, s_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, morphism_attr_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := 1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_9_1 );
    deduped_3_1 := deduped_6_1 * deduped_7_1;
    deduped_2_1 := KroneckerMat( HomalgIdentityMatrix( deduped_3_1, deduped_9_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_3_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_6_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_3_1 ), deduped_3_1, deduped_3_1, deduped_9_1 ), deduped_4_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), ConvertMatrixToColumn( deduped_4_1 ) );
    morphism_attr_8_1 := deduped_2_1;
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( s_1 ), deduped_9_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_8_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_5_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_5_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 2913 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromInternalHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromItsConstructionAsAnImageObjectToHomologyObject( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    deduped_6_1 := SyzygiesOfRows( UnderlyingMatrix( beta_1 ) );
    deduped_5_1 := SyzygiesOfColumns( deduped_6_1 * deduped_7_1 );
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_5_1 ) - RowRankOfMatrix( deduped_5_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), deduped_8_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_8_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 906 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromKernelOfCokernelToImageObject( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    deduped_2_1 := deduped_3_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromKernelOfDiagonalDifferenceToFiberProduct( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, morphism_attr_10_1, hoisted_11_1, hoisted_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, Source );
    hoisted_12_1 := Length( deduped_8_1 );
    hoisted_11_1 := deduped_13_1;
    deduped_9_1 := Length( D_1 );
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_8_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_6_1 := Dimension( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( logic_new_func_x_2 )
            return function ( s_3 )
                    return UnderlyingMatrix( s_3 );
                end( function ( i_3 )
                      local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3;
                      deduped_4_3 := D_1[i_3];
                      deduped_3_3 := deduped_8_1[i_3];
                      deduped_2_3 := Dimension( deduped_3_3 );
                      deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, deduped_7_1, deduped_3_3, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_8_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_2_3, hoisted_11_1 ), HomalgIdentityMatrix( deduped_2_3, hoisted_11_1 ), HomalgZeroMatrix( Sum( deduped_8_1{[ i_3 + 1 .. hoisted_12_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_2_3, hoisted_11_1 ) ) );
                      return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, Source( deduped_1_3 ), Range( deduped_4_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_3 ) * UnderlyingMatrix( deduped_4_3 ) );
                  end( logic_new_func_x_2 ) );
        end );
    deduped_4_1 := UnionOfColumns( deduped_13_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} );
    morphism_attr_10_1 := deduped_4_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_7_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_2_1 := UnderlyingMatrix( deduped_3_1 ) + -1 * UnionOfColumns( deduped_13_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), deduped_13_1 ) );
end
########
        
    , 1907 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromObjectToInternalCoHom( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, morphism_attr_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := HomalgIdentityMatrix( 1, deduped_9_1 );
    deduped_6_1 := Dimension( a_1 );
    deduped_5_1 := deduped_6_1 * 1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_6_1, deduped_9_1 );
    deduped_2_1 := KroneckerMat( deduped_4_1, ConvertMatrixToRow( deduped_7_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, 1 ) * deduped_6_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_9_1 ), deduped_7_1 ) * KroneckerMat( HomalgIdentityMatrix( (1 * deduped_6_1), deduped_9_1 ), deduped_7_1 );
    morphism_attr_8_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, deduped_4_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_8_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 2914 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromObjectToInternalCoHomWithGivenInternalCoHom( cat,
        
########
function ( cat_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, morphism_attr_8_1, deduped_9_1;
    deduped_9_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := Dimension( a_1 );
    deduped_6_1 := 1;
    deduped_4_1 := deduped_7_1 * deduped_6_1;
    deduped_3_1 := HomalgIdentityMatrix( deduped_6_1, deduped_9_1 );
    deduped_2_1 := KroneckerMat( HomalgIdentityMatrix( deduped_7_1, deduped_9_1 ), ConvertMatrixToRow( deduped_3_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_4_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_6_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_6_1 ) + 1);
                    end ) ), deduped_4_1 ), deduped_4_1, deduped_4_1, deduped_9_1 ), deduped_3_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_6_1 * deduped_7_1), deduped_9_1 ), deduped_3_1 );
    morphism_attr_8_1 := deduped_2_1;
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, r_1, r_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( r_1 ), deduped_9_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_8_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_8_1 ) ), UnderlyingMatrix, morphism_attr_8_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_5_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_5_1 ) );
end
########
        
    , 2913 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromObjectToInternalHom( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, morphism_attr_11_1, morphism_attr_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_10_1 := Dimension( a_1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_10_1, deduped_13_1 );
    deduped_8_1 := 1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_13_1 );
    deduped_4_1 := KroneckerMat( TransposedMatrix( deduped_5_1 ), deduped_9_1 );
    morphism_attr_12_1 := deduped_4_1;
    deduped_7_1 := deduped_8_1 * deduped_10_1;
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_2_1 := KroneckerMat( ConvertMatrixToRow( deduped_5_1 ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_13_1 ), deduped_9_1 ) * KroneckerMat( deduped_5_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_13_1 ) );
    morphism_attr_11_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_12_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_12_1 ) ), UnderlyingMatrix, morphism_attr_12_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_11_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_11_1 ) ), UnderlyingMatrix, morphism_attr_11_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 5025 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromObjectToInternalHomWithGivenInternalHom( cat,
        
########
function ( cat_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, morphism_attr_12_1, morphism_attr_13_1, deduped_14_1;
    deduped_14_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := Dimension( a_1 );
    deduped_10_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    deduped_9_1 := HomalgIdentityMatrix( deduped_11_1, deduped_14_1 );
    deduped_8_1 := Dimension( deduped_10_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_8_1, deduped_14_1 );
    deduped_4_1 := KroneckerMat( TransposedMatrix( deduped_5_1 ), deduped_9_1 );
    morphism_attr_13_1 := deduped_4_1;
    deduped_7_1 := deduped_8_1 * deduped_11_1;
    deduped_6_1 := deduped_8_1 * deduped_8_1;
    deduped_2_1 := KroneckerMat( ConvertMatrixToRow( deduped_5_1 ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_14_1 ), deduped_9_1 ) * KroneckerMat( deduped_5_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                  end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_14_1 ) );
    morphism_attr_12_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_13_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_13_1 ) ), UnderlyingMatrix, morphism_attr_13_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_12_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_12_1 ) ), UnderlyingMatrix, morphism_attr_12_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 5024 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromPushoutToCokernelOfDiagonalDifference( cat,
        
########
function ( cat_1, D_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, morphism_attr_10_1, hoisted_11_1, hoisted_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_8_1 := List( D_1, Range );
    hoisted_12_1 := Length( deduped_8_1 );
    hoisted_11_1 := deduped_13_1;
    deduped_9_1 := Length( D_1 );
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_8_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_6_1 := Dimension( deduped_7_1 );
    deduped_5_1 := List( [ 1 .. deduped_9_1 ], function ( logic_new_func_x_2 )
            return function ( s_3 )
                    return UnderlyingMatrix( s_3 );
                end( function ( i_3 )
                      local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3;
                      deduped_4_3 := D_1[i_3];
                      deduped_3_3 := deduped_8_1[i_3];
                      deduped_2_3 := Dimension( deduped_3_3 );
                      deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, deduped_3_3, deduped_7_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_3, Sum( deduped_8_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_11_1 ), HomalgIdentityMatrix( deduped_2_3, hoisted_11_1 ), HomalgZeroMatrix( deduped_2_3, Sum( deduped_8_1{[ i_3 + 1 .. hoisted_12_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_11_1 ) ) );
                      return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, Source( deduped_4_3 ), Range( deduped_1_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_3 ) * UnderlyingMatrix( deduped_1_3 ) );
                  end( logic_new_func_x_2 ) );
        end );
    deduped_4_1 := UnionOfRows( deduped_13_1, deduped_6_1, deduped_5_1{[ 1 .. deduped_9_1 - 1 ]} );
    morphism_attr_10_1 := deduped_4_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_10_1 ) ), deduped_7_1, UnderlyingMatrix, morphism_attr_10_1 );
    deduped_2_1 := UnderlyingMatrix( deduped_3_1 ) + -1 * UnionOfRows( deduped_13_1, deduped_6_1, deduped_5_1{[ 2 .. deduped_9_1 ]} );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), deduped_13_1 ) );
end
########
        
    , 1907 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromTensorProductToInternalCoHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromTensorProductToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromTerminalObjectToZeroObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromZeroObjectToInitialObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddIsomorphismFromZeroObjectToTerminalObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_2_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_2_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 100 );
    
    ##
    AddKernelEmbeddingWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_2_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_2_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelLift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1;
    deduped_2_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_3_1 := deduped_2_1;
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_3_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_3_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), Source( deduped_1_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1;
    deduped_2_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_3_1 := deduped_2_1;
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_3_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_3_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), Source( deduped_1_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 203 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelObject( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1;
    deduped_1_1 := UnderlyingMatrix( arg2_1 );
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_1_1 ) - RowRankOfMatrix( deduped_1_1 ) );
end
########
        
    , 100 );
    
    ##
    AddKernelObjectFunctorial( cat,
        
########
function ( cat_1, alpha_1, mu_1, alphap_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, morphism_attr_6_1, morphism_attr_7_1;
    deduped_5_1 := SyzygiesOfRows( UnderlyingMatrix( alphap_1 ) );
    morphism_attr_7_1 := deduped_5_1;
    deduped_4_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_6_1 := deduped_4_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_7_1 ) ), Source( alphap_1 ), UnderlyingMatrix, morphism_attr_7_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_6_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_6_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( mu_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( mu_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 606 : IsPrecompiledDerivation := true );
    
    ##
    AddKernelObjectFunctorialWithGivenKernelObjects( cat,
        
########
function ( cat_1, P_1, alpha_1, mu_1, alphap_1, Pp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, morphism_attr_6_1, morphism_attr_7_1;
    deduped_5_1 := SyzygiesOfRows( UnderlyingMatrix( alphap_1 ) );
    morphism_attr_7_1 := deduped_5_1;
    deduped_4_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_6_1 := deduped_4_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_7_1 ) ), Source( alphap_1 ), UnderlyingMatrix, morphism_attr_7_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_6_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_6_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( mu_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( mu_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 405 : IsPrecompiledDerivation := true );
    
    ##
    AddLambdaElimination( cat,
        
########
function ( cat_1, a_1, b_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, morphism_attr_11_1, morphism_attr_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( a_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_13_1 );
    deduped_6_1 := KroneckerMat( UnderlyingMatrix( alpha_1 ), deduped_7_1 );
    morphism_attr_12_1 := deduped_6_1;
    deduped_10_1 := Dimension( b_1 );
    deduped_8_1 := deduped_9_1 * deduped_10_1;
    deduped_3_1 := KroneckerMat( HomalgIdentityMatrix( deduped_8_1, deduped_13_1 ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_13_1 ), deduped_7_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_10_1, deduped_13_1 ), ConvertMatrixToColumn( deduped_7_1 ) );
    morphism_attr_11_1 := deduped_3_1;
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, deduped_7_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_12_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_12_1 ) ), UnderlyingMatrix, morphism_attr_12_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_11_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_11_1 ) ), UnderlyingMatrix, morphism_attr_11_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_5_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_5_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 3315 : IsPrecompiledDerivation := true );
    
    ##
    AddLambdaIntroduction( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, morphism_attr_13_1, morphism_attr_14_1, deduped_15_1;
    deduped_15_1 := UnderlyingRing( cat_1 );
    deduped_12_1 := Source( alpha_1 );
    deduped_11_1 := Dimension( deduped_12_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_11_1, deduped_15_1 );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_12_1, deduped_12_1, UnderlyingMatrix, deduped_8_1 );
    deduped_4_1 := KroneckerMat( TransposedMatrix( deduped_8_1 ), UnderlyingMatrix( deduped_5_1 ) * UnderlyingMatrix( alpha_1 ) );
    morphism_attr_14_1 := deduped_4_1;
    deduped_10_1 := 1;
    deduped_9_1 := deduped_11_1 * deduped_11_1;
    deduped_7_1 := deduped_11_1 * deduped_10_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_10_1, deduped_15_1 );
    deduped_2_1 := KroneckerMat( ConvertMatrixToRow( deduped_8_1 ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_15_1 ), deduped_6_1 ) * KroneckerMat( deduped_8_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_15_1 ) );
    morphism_attr_13_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_14_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_14_1 ) ), UnderlyingMatrix, morphism_attr_14_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_13_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_13_1 ) ), UnderlyingMatrix, morphism_attr_13_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 5125 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftDistributivityExpanding( cat,
        
########
function ( cat_1, a_1, L_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    hoisted_7_1 := deduped_8_1;
    deduped_3_1 := Dimension( a_1 );
    hoisted_6_1 := HomalgIdentityMatrix( deduped_3_1, deduped_8_1 );
    deduped_4_1 := Length( L_1 );
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_3_1 * Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ) );
    deduped_1_1 := UnionOfColumns( deduped_8_1, Dimension( deduped_2_1 ), List( [ 1 .. deduped_4_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
              deduped_4_2 := L_1[logic_new_func_x_2];
              deduped_3_2 := Dimension( deduped_4_2 );
              deduped_2_2 := UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_3_2, hoisted_7_1 ), HomalgIdentityMatrix( deduped_3_2, hoisted_7_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. deduped_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_3_2, hoisted_7_1 ) );
              deduped_1_2 := KroneckerMat( hoisted_6_1, deduped_2_2 );
              return deduped_1_2;
          end ) );
    morphism_attr_5_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_5_1 ) ), UnderlyingMatrix, morphism_attr_5_1 );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := deduped_6_1;
    hoisted_4_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_6_1 );
    deduped_2_1 := Length( L_1 );
    deduped_1_1 := UnionOfColumns( deduped_6_1, Dimension( s_1 ), List( [ 1 .. deduped_2_1 ], function ( logic_new_func_x_2 )
              return function ( s_3 )
                      return UnderlyingMatrix( s_3 );
                  end( function ( logic_new_func_x_3 )
                        return function ( mor_4 )
                                local deduped_1_4, morphism_attr_2_4;
                                deduped_1_4 := KroneckerMat( hoisted_4_1, UnderlyingMatrix( mor_4 ) );
                                morphism_attr_2_4 := deduped_1_4;
                                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                                         ), cat_1, Dimension, NumberRows( morphism_attr_2_4 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                                         ), cat_1, Dimension, NumberColumns( morphism_attr_2_4 ) ), UnderlyingMatrix, morphism_attr_2_4 );
                            end( function ( i_4 )
                                  local deduped_1_4, deduped_2_4, deduped_3_4, morphism_attr_4_4;
                                  deduped_3_4 := L_1[i_4];
                                  deduped_2_4 := Dimension( deduped_3_4 );
                                  deduped_1_4 := UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. i_4 - 1 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), deduped_2_4, hoisted_5_1 ), HomalgIdentityMatrix( deduped_2_4, hoisted_5_1 ), HomalgZeroMatrix( Sum( L_1{[ i_4 + 1 .. deduped_2_1 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), deduped_2_4, hoisted_5_1 ) );
                                  morphism_attr_4_4 := deduped_1_4;
                                  return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                         ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                                           ), cat_1, Dimension, NumberRows( morphism_attr_4_4 ) ), deduped_3_4, UnderlyingMatrix, morphism_attr_4_4 );
                              end( logic_new_func_x_3 ) );
                    end( logic_new_func_x_2 ) );
          end ) );
    morphism_attr_3_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftDistributivityFactoring( cat,
        
########
function ( cat_1, a_1, L_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    hoisted_7_1 := deduped_8_1;
    deduped_3_1 := Dimension( a_1 );
    hoisted_6_1 := HomalgIdentityMatrix( deduped_3_1, deduped_8_1 );
    deduped_4_1 := Length( L_1 );
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_3_1 * Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ) );
    deduped_1_1 := UnionOfRows( deduped_8_1, Dimension( deduped_2_1 ), List( [ 1 .. deduped_4_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
              deduped_4_2 := L_1[logic_new_func_x_2];
              deduped_3_2 := Dimension( deduped_4_2 );
              deduped_2_2 := UnionOfColumns( HomalgZeroMatrix( deduped_3_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_7_1 ), HomalgIdentityMatrix( deduped_3_2, hoisted_7_1 ), HomalgZeroMatrix( deduped_3_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. deduped_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_7_1 ) );
              deduped_1_2 := KroneckerMat( hoisted_6_1, deduped_2_2 );
              return deduped_1_2;
          end ) );
    morphism_attr_5_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_5_1 ) ), deduped_2_1, UnderlyingMatrix, morphism_attr_5_1 );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, L_1, r_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := deduped_6_1;
    hoisted_4_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_6_1 );
    deduped_2_1 := Length( L_1 );
    deduped_1_1 := UnionOfRows( deduped_6_1, Dimension( r_1 ), List( [ 1 .. deduped_2_1 ], function ( logic_new_func_x_2 )
              return function ( s_3 )
                      return UnderlyingMatrix( s_3 );
                  end( function ( logic_new_func_x_3 )
                        return function ( mor_4 )
                                local deduped_1_4, morphism_attr_2_4;
                                deduped_1_4 := KroneckerMat( hoisted_4_1, UnderlyingMatrix( mor_4 ) );
                                morphism_attr_2_4 := deduped_1_4;
                                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                                         ), cat_1, Dimension, NumberRows( morphism_attr_2_4 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                                         ), cat_1, Dimension, NumberColumns( morphism_attr_2_4 ) ), UnderlyingMatrix, morphism_attr_2_4 );
                            end( function ( i_4 )
                                  local deduped_1_4, deduped_2_4, deduped_3_4, morphism_attr_4_4;
                                  deduped_3_4 := L_1[i_4];
                                  deduped_2_4 := Dimension( deduped_3_4 );
                                  deduped_1_4 := UnionOfColumns( HomalgZeroMatrix( deduped_2_4, Sum( L_1{[ 1 .. i_4 - 1 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), hoisted_5_1 ), HomalgIdentityMatrix( deduped_2_4, hoisted_5_1 ), HomalgZeroMatrix( deduped_2_4, Sum( L_1{[ i_4 + 1 .. deduped_2_1 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), hoisted_5_1 ) );
                                  morphism_attr_4_4 := deduped_1_4;
                                  return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                         ), cat_1, deduped_3_4, ObjectifyObjectForCAPWithAttributes( rec(
                                           ), cat_1, Dimension, NumberColumns( morphism_attr_4_4 ) ), UnderlyingMatrix, morphism_attr_4_4 );
                              end( logic_new_func_x_3 ) );
                    end( logic_new_func_x_2 ) );
          end ) );
    morphism_attr_3_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_3_1 ) ), r_1, UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitor( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), Source( iota_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( iota_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddMereExistenceOfSolutionOfLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, hoisted_10_1, hoisted_11_1, deduped_12_1;
    deduped_12_1 := UnderlyingRing( cat_1 );
    hoisted_11_1 := arg3_1[1];
    hoisted_10_1 := deduped_12_1;
    deduped_9_1 := arg2_1[1];
    deduped_8_1 := [ 1 .. Length( arg2_1 ) ];
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    deduped_6_1 := [ 1 .. Length( deduped_9_1 ) ];
    deduped_5_1 := List( deduped_6_1, function ( j_2 )
            return ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, Dimension( Range( deduped_9_1[j_2] ) ) * Dimension( Source( hoisted_11_1[j_2] ) ) );
        end );
    deduped_4_1 := List( deduped_8_1, function ( i_2 )
            return ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, Dimension( Source( arg2_1[i_2][1] ) ) * Dimension( Range( arg3_1[i_2][1] ) ) );
        end );
    deduped_3_1 := UnionOfColumns( deduped_12_1, Dimension( deduped_7_1 ), List( deduped_8_1, function ( logic_new_func_x_2 )
              return function ( s_3 )
                      return UnderlyingMatrix( s_3 );
                  end( function ( i_3 )
                        local deduped_1_3, morphism_attr_2_3;
                        deduped_1_3 := ConvertMatrixToRow( UnderlyingMatrix( arg4_1[i_3] ) );
                        morphism_attr_2_3 := deduped_1_3;
                        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, deduped_7_1, ObjectifyObjectForCAPWithAttributes( rec(
                                 ), cat_1, Dimension, NumberColumns( morphism_attr_2_3 ) ), UnderlyingMatrix, morphism_attr_2_3 );
                    end( logic_new_func_x_2 ) );
          end ) );
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_4_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_1_1 := UnionOfRows( deduped_12_1, Dimension( deduped_2_1 ), ListN( deduped_5_1, List( deduped_6_1, function ( logic_new_func_x_2 )
                return function ( row_3 )
                        return List( row_3, UnderlyingMatrix );
                    end( function ( j_3 )
                          local hoisted_1_3;
                          hoisted_1_3 := deduped_5_1[j_3];
                          return List( deduped_8_1, function ( i_4 )
                                  return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                         ), cat_1, hoisted_1_3, deduped_4_1[i_4], UnderlyingMatrix, KroneckerMat( TransposedMatrix( UnderlyingMatrix( arg2_1[i_4][j_3] ) ), UnderlyingMatrix( arg3_1[i_4][j_3] ) ) );
                              end );
                      end( logic_new_func_x_2 ) );
            end ), function ( source_2, row_2 )
              return UnionOfColumns( hoisted_10_1, Dimension( source_2 ), row_2 );
          end ) );
    return IsZero( DecideZeroRows( deduped_3_1, deduped_1_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPostCoComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, morphism_attr_18_1, morphism_attr_19_1, deduped_20_1;
    deduped_20_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := Dimension( b_1 );
    deduped_16_1 := Dimension( a_1 );
    deduped_15_1 := Dimension( c_1 );
    deduped_14_1 := deduped_15_1 * deduped_15_1;
    deduped_13_1 := deduped_17_1 * deduped_15_1;
    deduped_12_1 := deduped_16_1 * deduped_17_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_15_1, deduped_20_1 );
    deduped_9_1 := deduped_12_1;
    deduped_8_1 := deduped_9_1 * deduped_13_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_8_1, deduped_20_1 );
    deduped_6_1 := deduped_8_1 * deduped_15_1;
    deduped_4_1 := KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_8_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_20_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                    end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_20_1 ), deduped_7_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_10_1 ), deduped_7_1 );
    morphism_attr_19_1 := deduped_4_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_17_1, deduped_20_1 );
    deduped_5_1 := KroneckerMat( HomalgIdentityMatrix( deduped_16_1, deduped_20_1 ), ConvertMatrixToRow( deduped_11_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                      end ) ), deduped_12_1 ), deduped_12_1, deduped_12_1, deduped_20_1 ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_17_1 * deduped_16_1), deduped_20_1 ), deduped_11_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_9_1, deduped_20_1 ), (KroneckerMat( deduped_11_1, ConvertMatrixToRow( deduped_10_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                        end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_20_1 ), deduped_10_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_15_1 * deduped_17_1), deduped_20_1 ), deduped_10_1 )) );
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_10_1 ), deduped_5_1 );
    morphism_attr_18_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_19_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_19_1 ) ), UnderlyingMatrix, morphism_attr_19_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_18_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_18_1 ) ), UnderlyingMatrix, morphism_attr_18_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 12155 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPostCoComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, morphism_attr_17_1, morphism_attr_18_1, hoisted_19_1, hoisted_20_1, hoisted_21_1, hoisted_22_1, hoisted_23_1, hoisted_24_1, hoisted_25_1, hoisted_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := Dimension( b_1 );
    hoisted_26_1 := HomalgIdentityMatrix( deduped_16_1, deduped_27_1 );
    deduped_14_1 := Dimension( c_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_14_1, deduped_27_1 );
    hoisted_25_1 := KroneckerMat( HomalgIdentityMatrix( deduped_14_1 * deduped_16_1, deduped_27_1 ), deduped_10_1 );
    deduped_12_1 := deduped_16_1 * deduped_14_1;
    hoisted_24_1 := KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, deduped_14_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1;
                end ) ), deduped_12_1 ), deduped_12_1, deduped_12_1, deduped_27_1 ), deduped_10_1 );
    hoisted_23_1 := ConvertMatrixToRow( deduped_10_1 );
    deduped_15_1 := Dimension( a_1 );
    hoisted_22_1 := HomalgIdentityMatrix( deduped_16_1 * deduped_15_1, deduped_27_1 );
    deduped_11_1 := deduped_15_1 * deduped_16_1;
    hoisted_21_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, deduped_16_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1;
              end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_27_1 );
    hoisted_20_1 := HomalgIdentityMatrix( deduped_15_1, deduped_27_1 );
    deduped_9_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_11_1 );
    deduped_8_1 := Dimension( deduped_9_1 );
    hoisted_19_1 := HomalgIdentityMatrix( deduped_8_1, deduped_27_1 );
    deduped_13_1 := deduped_14_1 * deduped_14_1;
    deduped_7_1 := deduped_8_1 * deduped_12_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_7_1, deduped_27_1 );
    deduped_5_1 := deduped_7_1 * deduped_14_1;
    deduped_4_1 := KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_27_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_27_1 ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_10_1 ), deduped_6_1 );
    morphism_attr_18_1 := deduped_4_1;
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_10_1 ), UnderlyingMatrix( function (  )
                local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, morphism_attr_6_2;
                deduped_5_2 := hoisted_26_1;
                deduped_4_2 := KroneckerMat( deduped_5_2, hoisted_23_1 ) * hoisted_24_1 * hoisted_25_1;
                deduped_3_2 := KroneckerMat( hoisted_20_1, ConvertMatrixToRow( deduped_5_2 ) ) * KroneckerMat( hoisted_21_1, deduped_5_2 ) * KroneckerMat( hoisted_22_1, deduped_5_2 );
                deduped_2_2 := KroneckerMat( hoisted_19_1, deduped_4_2 );
                deduped_1_2 := function ( alpha_3, beta_3 )
                        return alpha_3 * beta_3;
                    end( deduped_3_2, deduped_2_2 );
                morphism_attr_6_2 := deduped_1_2;
                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberRows( morphism_attr_6_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberColumns( morphism_attr_6_2 ) ), UnderlyingMatrix, morphism_attr_6_2 );
            end(  ) ) );
    morphism_attr_17_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_18_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_18_1 ) ), UnderlyingMatrix, morphism_attr_18_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_17_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_17_1 ) ), UnderlyingMatrix, morphism_attr_17_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 11148 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPostComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, morphism_attr_18_1, morphism_attr_19_1, deduped_20_1;
    deduped_20_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := Dimension( c_1 );
    deduped_16_1 := Dimension( b_1 );
    deduped_15_1 := Dimension( a_1 );
    deduped_13_1 := deduped_15_1 * deduped_15_1;
    deduped_12_1 := deduped_15_1 * deduped_16_1;
    deduped_11_1 := deduped_16_1 * deduped_17_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_15_1, deduped_20_1 );
    deduped_9_1 := deduped_11_1;
    deduped_8_1 := deduped_9_1 * deduped_12_1;
    deduped_7_1 := deduped_15_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_8_1, deduped_20_1 );
    deduped_4_1 := KroneckerMat( ConvertMatrixToRow( deduped_10_1 ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                    end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_20_1 ), deduped_6_1 ) * KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_8_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_8_1 ) + 1);
                  end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_20_1 ) );
    morphism_attr_19_1 := deduped_4_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_16_1, deduped_20_1 );
    deduped_5_1 := KroneckerMat( HomalgIdentityMatrix( deduped_9_1, deduped_20_1 ), KroneckerMat( HomalgIdentityMatrix( deduped_12_1, deduped_20_1 ), deduped_10_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                        end ) ), deduped_12_1 ), deduped_12_1, deduped_12_1, deduped_20_1 ), deduped_10_1 ) * KroneckerMat( deduped_14_1, ConvertMatrixToColumn( deduped_10_1 ) ) ) * (KroneckerMat( HomalgIdentityMatrix( deduped_11_1, deduped_20_1 ), deduped_14_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                      end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_20_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_17_1, deduped_20_1 ), ConvertMatrixToColumn( deduped_14_1 ) ));
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_10_1 ), deduped_5_1 );
    morphism_attr_18_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_19_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_19_1 ) ), UnderlyingMatrix, morphism_attr_19_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_18_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_18_1 ) ), UnderlyingMatrix, morphism_attr_18_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 12155 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPostComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, morphism_attr_17_1, morphism_attr_18_1, hoisted_19_1, hoisted_20_1, hoisted_21_1, hoisted_22_1, hoisted_23_1, hoisted_24_1, hoisted_25_1, deduped_26_1;
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_15_1 := Dimension( b_1 );
    hoisted_25_1 := HomalgIdentityMatrix( deduped_15_1, deduped_26_1 );
    deduped_16_1 := Dimension( c_1 );
    hoisted_24_1 := HomalgIdentityMatrix( deduped_16_1, deduped_26_1 );
    deduped_11_1 := deduped_15_1 * deduped_16_1;
    hoisted_23_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, deduped_16_1 ) * deduped_15_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1;
              end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_26_1 );
    hoisted_22_1 := HomalgIdentityMatrix( deduped_11_1, deduped_26_1 );
    deduped_14_1 := Dimension( a_1 );
    deduped_12_1 := deduped_14_1 * deduped_15_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_14_1, deduped_26_1 );
    hoisted_21_1 := KroneckerMat( HomalgIdentityMatrix( deduped_12_1, deduped_26_1 ), deduped_10_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_15_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_15_1 ) + 1);
                  end ) ), deduped_12_1 ), deduped_12_1, deduped_12_1, deduped_26_1 ), deduped_10_1 );
    hoisted_20_1 := ConvertMatrixToColumn( deduped_10_1 );
    deduped_9_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_11_1 );
    deduped_8_1 := Dimension( deduped_9_1 );
    hoisted_19_1 := HomalgIdentityMatrix( deduped_8_1, deduped_26_1 );
    deduped_13_1 := deduped_14_1 * deduped_14_1;
    deduped_7_1 := deduped_8_1 * deduped_12_1;
    deduped_6_1 := deduped_14_1 * deduped_7_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_26_1 );
    deduped_4_1 := KroneckerMat( ConvertMatrixToRow( deduped_10_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_26_1 ), deduped_5_1 ) * KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_26_1 ) );
    morphism_attr_18_1 := deduped_4_1;
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_10_1 ), UnderlyingMatrix( function (  )
                local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, morphism_attr_6_2;
                deduped_5_2 := hoisted_25_1;
                deduped_4_2 := KroneckerMat( hoisted_22_1, deduped_5_2 ) * KroneckerMat( hoisted_23_1, deduped_5_2 ) * KroneckerMat( hoisted_24_1, ConvertMatrixToColumn( deduped_5_2 ) );
                deduped_3_2 := hoisted_21_1 * KroneckerMat( deduped_5_2, hoisted_20_1 );
                deduped_2_2 := KroneckerMat( hoisted_19_1, deduped_3_2 );
                deduped_1_2 := function ( alpha_3, beta_3 )
                        return alpha_3 * beta_3;
                    end( deduped_2_2, deduped_4_2 );
                morphism_attr_6_2 := deduped_1_2;
                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberRows( morphism_attr_6_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberColumns( morphism_attr_6_2 ) ), UnderlyingMatrix, morphism_attr_6_2 );
            end(  ) ) );
    morphism_attr_17_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_18_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_18_1 ) ), UnderlyingMatrix, morphism_attr_18_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_17_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_17_1 ) ), UnderlyingMatrix, morphism_attr_17_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 11148 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreCoComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, morphism_attr_21_1, morphism_attr_22_1, deduped_23_1;
    deduped_23_1 := UnderlyingRing( cat_1 );
    deduped_20_1 := Dimension( b_1 );
    deduped_19_1 := Dimension( a_1 );
    deduped_18_1 := Dimension( c_1 );
    deduped_17_1 := deduped_18_1 * deduped_18_1;
    deduped_16_1 := deduped_20_1 * deduped_18_1;
    deduped_15_1 := deduped_19_1 * deduped_20_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_18_1, deduped_23_1 );
    deduped_12_1 := deduped_16_1;
    deduped_11_1 := deduped_15_1;
    deduped_10_1 := deduped_12_1 * deduped_11_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_10_1, deduped_23_1 );
    deduped_8_1 := deduped_10_1 * deduped_18_1;
    deduped_5_1 := KroneckerMat( deduped_13_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_23_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                    end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_23_1 ), deduped_9_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_13_1 ), deduped_9_1 );
    morphism_attr_22_1 := deduped_5_1;
    deduped_14_1 := HomalgIdentityMatrix( deduped_20_1, deduped_23_1 );
    deduped_7_1 := deduped_18_1 * deduped_11_1;
    deduped_6_1 := deduped_11_1 * deduped_20_1;
    deduped_4_1 := KroneckerMat( HomalgIdentityMatrix( deduped_19_1, deduped_23_1 ), ConvertMatrixToRow( deduped_14_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                          end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_23_1 ), deduped_14_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_20_1 * deduped_19_1), deduped_23_1 ), deduped_14_1 ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_23_1 ) * KroneckerMat( (KroneckerMat( deduped_14_1, ConvertMatrixToRow( deduped_13_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                          end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_23_1 ), deduped_13_1 ) * KroneckerMat( HomalgIdentityMatrix( (deduped_18_1 * deduped_20_1), deduped_23_1 ), deduped_13_1 )), HomalgIdentityMatrix( deduped_11_1, deduped_23_1 ) ) * KroneckerMat( HomalgIdentityMatrix( deduped_12_1, deduped_23_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                  end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_23_1 ) );
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_13_1 ), deduped_4_1 );
    morphism_attr_21_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_22_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_22_1 ) ), UnderlyingMatrix, morphism_attr_22_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_21_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_21_1 ) ), UnderlyingMatrix, morphism_attr_21_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 12958 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreCoComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, morphism_attr_19_1, morphism_attr_20_1, hoisted_21_1, hoisted_22_1, hoisted_23_1, hoisted_24_1, hoisted_25_1, hoisted_26_1, hoisted_27_1, hoisted_28_1, hoisted_29_1, hoisted_30_1, hoisted_31_1, hoisted_32_1, deduped_33_1;
    deduped_33_1 := UnderlyingRing( cat_1 );
    deduped_18_1 := Dimension( b_1 );
    deduped_17_1 := Dimension( a_1 );
    deduped_16_1 := Dimension( c_1 );
    deduped_13_1 := deduped_17_1 * deduped_18_1;
    deduped_10_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_13_1 );
    deduped_8_1 := Dimension( deduped_10_1 );
    hoisted_32_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_16_1 * deduped_8_1 );
    hoisted_31_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_8_1 * deduped_18_1 );
    hoisted_30_1 := HomalgIdentityMatrix( deduped_18_1, deduped_33_1 );
    deduped_12_1 := HomalgIdentityMatrix( deduped_16_1, deduped_33_1 );
    hoisted_29_1 := KroneckerMat( HomalgIdentityMatrix( deduped_16_1 * deduped_18_1, deduped_33_1 ), deduped_12_1 );
    deduped_14_1 := deduped_18_1 * deduped_16_1;
    hoisted_28_1 := KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                    local deduped_1_2;
                    deduped_1_2 := i_2 - 1;
                    return REM_INT( deduped_1_2, deduped_16_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1;
                end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_33_1 ), deduped_12_1 );
    hoisted_27_1 := ConvertMatrixToRow( deduped_12_1 );
    hoisted_26_1 := HomalgIdentityMatrix( deduped_18_1 * deduped_17_1, deduped_33_1 );
    hoisted_25_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, deduped_18_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1;
              end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_33_1 );
    hoisted_24_1 := HomalgIdentityMatrix( deduped_17_1, deduped_33_1 );
    deduped_11_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_14_1 );
    deduped_9_1 := Dimension( deduped_11_1 );
    hoisted_23_1 := HomalgIdentityMatrix( deduped_9_1, deduped_33_1 );
    hoisted_22_1 := HomalgIdentityMatrix( deduped_8_1, deduped_33_1 );
    hoisted_21_1 := deduped_33_1;
    deduped_15_1 := deduped_16_1 * deduped_16_1;
    deduped_7_1 := deduped_9_1 * deduped_8_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_7_1, deduped_33_1 );
    deduped_5_1 := deduped_7_1 * deduped_16_1;
    deduped_4_1 := KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_33_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                    end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_33_1 ), deduped_6_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_12_1 ), deduped_6_1 );
    morphism_attr_20_1 := deduped_4_1;
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_12_1 ), UnderlyingMatrix( function (  )
                local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, morphism_attr_11_2;
                deduped_10_2 := hoisted_30_1;
                deduped_9_2 := hoisted_32_1;
                deduped_8_2 := hoisted_31_1;
                deduped_7_2 := Dimension( deduped_9_2 );
                deduped_6_2 := Dimension( deduped_8_2 );
                deduped_5_2 := KroneckerMat( deduped_10_2, hoisted_27_1 ) * hoisted_28_1 * hoisted_29_1;
                deduped_4_2 := KroneckerMat( hoisted_24_1, ConvertMatrixToRow( deduped_10_2 ) ) * KroneckerMat( hoisted_25_1, deduped_10_2 ) * KroneckerMat( hoisted_26_1, deduped_10_2 );
                deduped_3_2 := KroneckerMat( hoisted_23_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := i_3 - 1;
                                return REM_INT( deduped_1_3, deduped_8_1 ) * deduped_16_1 + QUO_INT( deduped_1_3, deduped_8_1 ) + 1;
                            end ) ), deduped_7_2 ), deduped_7_2, deduped_7_2, hoisted_21_1 ) );
                deduped_2_2 := KroneckerMat( deduped_5_2, hoisted_22_1 );
                deduped_1_2 := function ( alpha_3, beta_3 )
                        return alpha_3 * beta_3;
                    end( function ( alpha_3, beta_3 )
                          return alpha_3 * beta_3;
                      end( function ( alpha_3, beta_3 )
                            return alpha_3 * beta_3;
                        end( deduped_4_2, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_2 ], function ( i_3 )
                                    local deduped_1_3;
                                    deduped_1_3 := i_3 - 1;
                                    return REM_INT( deduped_1_3, deduped_18_1 ) * deduped_8_1 + QUO_INT( deduped_1_3, deduped_18_1 ) + 1;
                                end ) ), deduped_6_2 ), deduped_6_2, deduped_6_2, hoisted_21_1 ) ), deduped_2_2 ), deduped_3_2 );
                morphism_attr_11_2 := deduped_1_2;
                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberRows( morphism_attr_11_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberColumns( morphism_attr_11_2 ) ), UnderlyingMatrix, morphism_attr_11_2 );
            end(  ) ) );
    morphism_attr_19_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_20_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_20_1 ) ), UnderlyingMatrix, morphism_attr_20_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_19_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_19_1 ) ), UnderlyingMatrix, morphism_attr_19_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 11951 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreComposeMorphism( cat,
        
########
function ( cat_1, a_1, b_1, c_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, morphism_attr_21_1, morphism_attr_22_1, deduped_23_1;
    deduped_23_1 := UnderlyingRing( cat_1 );
    deduped_20_1 := Dimension( c_1 );
    deduped_19_1 := Dimension( b_1 );
    deduped_18_1 := Dimension( a_1 );
    deduped_16_1 := deduped_18_1 * deduped_18_1;
    deduped_15_1 := deduped_19_1 * deduped_20_1;
    deduped_14_1 := deduped_18_1 * deduped_19_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_18_1, deduped_23_1 );
    deduped_12_1 := deduped_15_1;
    deduped_11_1 := deduped_14_1;
    deduped_10_1 := deduped_11_1 * deduped_12_1;
    deduped_9_1 := deduped_18_1 * deduped_10_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_10_1, deduped_23_1 );
    deduped_5_1 := KroneckerMat( ConvertMatrixToRow( deduped_13_1 ), deduped_8_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                    end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_23_1 ), deduped_8_1 ) * KroneckerMat( deduped_13_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_23_1 ) );
    morphism_attr_22_1 := deduped_5_1;
    deduped_17_1 := HomalgIdentityMatrix( deduped_19_1, deduped_23_1 );
    deduped_7_1 := deduped_19_1 * deduped_12_1;
    deduped_6_1 := deduped_12_1 * deduped_18_1;
    deduped_4_1 := KroneckerMat( HomalgIdentityMatrix( deduped_11_1, deduped_23_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_23_1 ) ) * KroneckerMat( (KroneckerMat( HomalgIdentityMatrix( deduped_14_1, deduped_23_1 ), deduped_13_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_19_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1);
                            end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_23_1 ), deduped_13_1 ) * KroneckerMat( deduped_17_1, ConvertMatrixToColumn( deduped_13_1 ) )), HomalgIdentityMatrix( deduped_12_1, deduped_23_1 ) ) * HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                  end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_23_1 ) * (KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_23_1 ), deduped_17_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                      end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_23_1 ), deduped_17_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_20_1, deduped_23_1 ), ConvertMatrixToColumn( deduped_17_1 ) ));
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_13_1 ), deduped_4_1 );
    morphism_attr_21_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_22_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_22_1 ) ), UnderlyingMatrix, morphism_attr_22_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_21_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_21_1 ) ), UnderlyingMatrix, morphism_attr_21_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 12958 : IsPrecompiledDerivation := true );
    
    ##
    AddMonoidalPreComposeMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, morphism_attr_19_1, morphism_attr_20_1, hoisted_21_1, hoisted_22_1, hoisted_23_1, hoisted_24_1, hoisted_25_1, hoisted_26_1, hoisted_27_1, hoisted_28_1, hoisted_29_1, hoisted_30_1, hoisted_31_1, deduped_32_1;
    deduped_32_1 := UnderlyingRing( cat_1 );
    deduped_18_1 := Dimension( c_1 );
    deduped_17_1 := Dimension( b_1 );
    deduped_14_1 := deduped_17_1 * deduped_18_1;
    deduped_11_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_14_1 );
    deduped_9_1 := Dimension( deduped_11_1 );
    hoisted_31_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_17_1 * deduped_9_1 );
    deduped_16_1 := Dimension( a_1 );
    hoisted_30_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_9_1 * deduped_16_1 );
    hoisted_29_1 := HomalgIdentityMatrix( deduped_17_1, deduped_32_1 );
    hoisted_28_1 := HomalgIdentityMatrix( deduped_18_1, deduped_32_1 );
    hoisted_27_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, deduped_18_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1;
              end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_32_1 );
    hoisted_26_1 := HomalgIdentityMatrix( deduped_14_1, deduped_32_1 );
    deduped_13_1 := deduped_16_1 * deduped_17_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_16_1, deduped_32_1 );
    hoisted_25_1 := KroneckerMat( HomalgIdentityMatrix( deduped_13_1, deduped_32_1 ), deduped_12_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                  end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_32_1 ), deduped_12_1 );
    hoisted_24_1 := ConvertMatrixToColumn( deduped_12_1 );
    deduped_10_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_13_1 );
    deduped_8_1 := Dimension( deduped_10_1 );
    hoisted_23_1 := HomalgIdentityMatrix( deduped_8_1, deduped_32_1 );
    hoisted_22_1 := HomalgIdentityMatrix( deduped_9_1, deduped_32_1 );
    hoisted_21_1 := deduped_32_1;
    deduped_15_1 := deduped_16_1 * deduped_16_1;
    deduped_7_1 := deduped_8_1 * deduped_9_1;
    deduped_6_1 := deduped_16_1 * deduped_7_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_32_1 );
    deduped_4_1 := KroneckerMat( ConvertMatrixToRow( deduped_12_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                    end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_32_1 ), deduped_5_1 ) * KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_32_1 ) );
    morphism_attr_20_1 := deduped_4_1;
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_12_1 ), UnderlyingMatrix( function (  )
                local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, morphism_attr_11_2;
                deduped_10_2 := hoisted_29_1;
                deduped_9_2 := hoisted_31_1;
                deduped_8_2 := hoisted_30_1;
                deduped_7_2 := Dimension( deduped_9_2 );
                deduped_6_2 := Dimension( deduped_8_2 );
                deduped_5_2 := KroneckerMat( hoisted_26_1, deduped_10_2 ) * KroneckerMat( hoisted_27_1, deduped_10_2 ) * KroneckerMat( hoisted_28_1, ConvertMatrixToColumn( deduped_10_2 ) );
                deduped_4_2 := hoisted_25_1 * KroneckerMat( deduped_10_2, hoisted_24_1 );
                deduped_3_2 := KroneckerMat( hoisted_23_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := i_3 - 1;
                                return REM_INT( deduped_1_3, deduped_16_1 ) * deduped_9_1 + QUO_INT( deduped_1_3, deduped_16_1 ) + 1;
                            end ) ), deduped_6_2 ), deduped_6_2, deduped_6_2, hoisted_21_1 ) );
                deduped_2_2 := KroneckerMat( deduped_4_2, hoisted_22_1 );
                deduped_1_2 := function ( alpha_3, beta_3 )
                        return alpha_3 * beta_3;
                    end( function ( alpha_3, beta_3 )
                          return alpha_3 * beta_3;
                      end( function ( alpha_3, beta_3 )
                            return alpha_3 * beta_3;
                        end( deduped_3_2, deduped_2_2 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_2 ], function ( i_3 )
                                  local deduped_1_3;
                                  deduped_1_3 := i_3 - 1;
                                  return REM_INT( deduped_1_3, deduped_9_1 ) * deduped_17_1 + QUO_INT( deduped_1_3, deduped_9_1 ) + 1;
                              end ) ), deduped_7_2 ), deduped_7_2, deduped_7_2, hoisted_21_1 ) ), deduped_5_2 );
                morphism_attr_11_2 := deduped_1_2;
                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberRows( morphism_attr_11_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberColumns( morphism_attr_11_2 ) ), UnderlyingMatrix, morphism_attr_11_2 );
            end(  ) ) );
    morphism_attr_19_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_20_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_20_1 ) ), UnderlyingMatrix, morphism_attr_20_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_19_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_19_1 ) ), UnderlyingMatrix, morphism_attr_19_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 11951 : IsPrecompiledDerivation := true );
    
    ##
    AddMonomorphismIntoSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject( cat,
        
########
function ( cat_1, A_1, I_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, A_1, A_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismBetweenDirectSums( cat,
        
########
function ( cat_1, source_diagram_1, mat_1, range_diagram_1 )
    local deduped_1_1, morphism_attr_2_1, hoisted_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    hoisted_3_1 := deduped_4_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( range_diagram_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    morphism_attr_2_1 := UnionOfRows( deduped_4_1, Dimension( deduped_1_1 ), ListN( source_diagram_1, List( mat_1, function ( row_2 )
                return List( row_2, UnderlyingMatrix );
            end ), function ( source_2, row_2 )
              return UnionOfColumns( hoisted_3_1, Dimension( source_2 ), row_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_2_1 ) ), deduped_1_1, UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismBetweenDirectSumsWithGivenDirectSums( cat,
        
########
function ( cat_1, S_1, source_diagram_1, mat_1, range_diagram_1, T_1 )
    local hoisted_1_1, deduped_2_1;
    deduped_2_1 := UnderlyingRing( cat_1 );
    hoisted_1_1 := deduped_2_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, S_1, T_1, UnderlyingMatrix, UnionOfRows( deduped_2_1, Dimension( T_1 ), ListN( source_diagram_1, List( mat_1, function ( row_2 )
                  return List( row_2, UnderlyingMatrix );
              end ), function ( source_2, row_2 )
                return UnionOfColumns( hoisted_1_1, Dimension( source_2 ), row_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, arg2_1, arg4_1, UnderlyingMatrix, arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return UnderlyingMatrix( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismFromBidual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), deduped_4_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_4_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, s_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), deduped_4_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_4_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromCoBidual( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromCoBidualWithGivenCoBidual( cat,
        
########
function ( cat_1, a_1, s_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismFromCoimageToImageWithGivenObjects( cat,
        
########
function ( cat_1, C_1, alpha_1, I_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, morphism_attr_18_1, morphism_attr_19_1, morphism_attr_20_1, morphism_attr_21_1, deduped_22_1;
    deduped_22_1 := UnderlyingRing( cat_1 );
    deduped_16_1 := UnderlyingMatrix( alpha_1 );
    deduped_15_1 := SyzygiesOfColumns( deduped_16_1 );
    morphism_attr_19_1 := deduped_15_1;
    deduped_17_1 := Range( alpha_1 );
    deduped_12_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_17_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_19_1 ) ), UnderlyingMatrix, morphism_attr_19_1 );
    deduped_9_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_12_1 ) );
    morphism_attr_21_1 := deduped_9_1;
    deduped_14_1 := SyzygiesOfRows( deduped_16_1 );
    morphism_attr_18_1 := deduped_14_1;
    deduped_10_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_18_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_18_1 );
    deduped_8_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_10_1 ) );
    morphism_attr_20_1 := deduped_8_1;
    deduped_13_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_15_1 ) - RowRankOfMatrix( deduped_15_1 ) );
    deduped_11_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_14_1 ) - RowRankOfMatrix( deduped_14_1 ) );
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_13_1, deduped_13_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_13_1 ), deduped_22_1 ) );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_11_1, deduped_11_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_11_1 ), deduped_22_1 ) );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_21_1 ) ), Source( deduped_12_1 ), UnderlyingMatrix, morphism_attr_21_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_10_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_20_1 ) ), UnderlyingMatrix, morphism_attr_20_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_6_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_3_1 ), deduped_17_1, UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_3_1 ), deduped_16_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Source( deduped_5_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_2_1 ), UnderlyingMatrix( deduped_5_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_7_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_7_1 ) );
end
########
        
    , 2011 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromFiberProductToSink( cat,
        
########
function ( cat_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, morphism_attr_24_1, morphism_attr_25_1, hoisted_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    hoisted_26_1 := deduped_27_1;
    deduped_22_1 := Length( morphisms_1 );
    deduped_21_1 := List( morphisms_1, Source );
    deduped_19_1 := [ 1 .. deduped_22_1 ];
    deduped_17_1 := Length( deduped_21_1 );
    deduped_16_1 := [ 1 .. deduped_22_1 - 1 ];
    deduped_14_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_21_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_13_1 := Dimension( deduped_14_1 );
    deduped_11_1 := List( deduped_19_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_21_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_21_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_26_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_26_1 ), HomalgZeroMatrix( Sum( deduped_21_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_26_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    deduped_10_1 := UnionOfColumns( deduped_27_1, deduped_13_1, deduped_11_1{deduped_16_1} );
    morphism_attr_25_1 := deduped_10_1;
    deduped_20_1 := [ 2 .. deduped_22_1 ];
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_14_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_25_1 ) ), UnderlyingMatrix, morphism_attr_25_1 );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_8_1 ), Range( deduped_8_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_8_1 ) + -1 * UnionOfColumns( deduped_27_1, deduped_13_1, deduped_11_1{deduped_20_1} ) );
    deduped_4_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_24_1 := deduped_4_1;
    deduped_23_1 := morphisms_1[1];
    deduped_18_1 := List( deduped_21_1, Dimension );
    deduped_15_1 := Sum( deduped_18_1{[ 1 .. 1 - 1 ]} ) + 1;
    deduped_12_1 := List( deduped_19_1, function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_21_1[logic_new_func_x_2] );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_21_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_26_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_26_1 ), HomalgZeroMatrix( Sum( deduped_21_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_26_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    deduped_9_1 := UnionOfColumns( deduped_27_1, deduped_13_1, deduped_12_1{deduped_16_1} ) + -1 * UnionOfColumns( deduped_27_1, deduped_13_1, deduped_12_1{deduped_20_1} );
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_9_1 ) - RowRankOfMatrix( deduped_9_1 ) );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_7_1, deduped_7_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_7_1 ), deduped_27_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), Source( deduped_6_1 ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_5_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_5_1 ) * UnderlyingMatrix( deduped_3_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), deduped_21_1[1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( deduped_2_1 ), [ deduped_15_1 .. deduped_15_1 - 1 + deduped_18_1[1] ] ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_23_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_23_1 ) );
end
########
        
    , 4016 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromFiberProductToSinkWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, morphism_attr_20_1, morphism_attr_21_1, hoisted_22_1, hoisted_23_1, deduped_24_1;
    deduped_24_1 := UnderlyingRing( cat_1 );
    deduped_17_1 := List( morphisms_1, Source );
    hoisted_23_1 := Length( deduped_17_1 );
    hoisted_22_1 := deduped_24_1;
    deduped_18_1 := Length( morphisms_1 );
    deduped_14_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_17_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_13_1 := Dimension( deduped_14_1 );
    deduped_12_1 := List( [ 1 .. deduped_18_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_17_1[logic_new_func_x_2] );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_17_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_22_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_22_1 ), HomalgZeroMatrix( Sum( deduped_17_1{[ (logic_new_func_x_2 + 1) .. hoisted_23_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_22_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    deduped_11_1 := UnionOfColumns( deduped_24_1, deduped_13_1, deduped_12_1{[ 1 .. deduped_18_1 - 1 ]} );
    morphism_attr_21_1 := deduped_11_1;
    deduped_10_1 := -1 * UnionOfColumns( deduped_24_1, deduped_13_1, deduped_12_1{[ 2 .. deduped_18_1 ]} );
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_14_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_21_1 ) ), UnderlyingMatrix, morphism_attr_21_1 );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_8_1 ), Range( deduped_8_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_8_1 ) + deduped_10_1 );
    deduped_5_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_20_1 := deduped_5_1;
    deduped_19_1 := morphisms_1[1];
    deduped_16_1 := List( deduped_17_1, Dimension );
    deduped_15_1 := Sum( deduped_16_1{[ 1 .. 1 - 1 ]} ) + 1;
    deduped_9_1 := deduped_11_1 + deduped_10_1;
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_9_1 ) - RowRankOfMatrix( deduped_9_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_7_1, deduped_7_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_7_1 ), deduped_24_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_20_1 ) ), Source( deduped_6_1 ), UnderlyingMatrix, morphism_attr_20_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_3_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), deduped_17_1[1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( deduped_2_1 ), [ deduped_15_1 .. deduped_15_1 - 1 + deduped_16_1[1] ] ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_19_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_19_1 ) );
end
########
        
    , 4017 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromInternalCoHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromInternalCoHomToTensorProductWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromInternalHomToTensorProduct( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromInternalHomToTensorProductWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromKernelObjectToSink( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Range( alpha_1 );
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_3_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( deduped_1_1 ), Dimension( deduped_3_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromKernelObjectToSinkWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Range( alpha_1 );
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_3_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( deduped_1_1 ), Dimension( deduped_3_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromSourceToCokernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := Source( alpha_1 );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_1_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( deduped_2_1 ), Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromSourceToCokernelObjectWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingMatrix( alpha_1 );
    deduped_2_1 := Source( alpha_1 );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_3_1 ) - RowRankOfMatrix( deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_1_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( deduped_2_1 ), Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromSourceToPushout( cat,
        
########
function ( cat_1, morphisms_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, morphism_attr_24_1, morphism_attr_25_1, hoisted_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    hoisted_26_1 := deduped_27_1;
    deduped_23_1 := Length( morphisms_1 );
    deduped_22_1 := List( morphisms_1, Range );
    deduped_19_1 := [ 1 .. deduped_23_1 ];
    deduped_17_1 := Length( deduped_22_1 );
    deduped_16_1 := [ 1 .. deduped_23_1 - 1 ];
    deduped_14_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_22_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_13_1 := Dimension( deduped_14_1 );
    deduped_11_1 := List( deduped_19_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_22_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_22_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_26_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_26_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_22_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_26_1 ) );
        end );
    deduped_9_1 := UnionOfRows( deduped_27_1, deduped_13_1, deduped_11_1{deduped_16_1} );
    morphism_attr_25_1 := deduped_9_1;
    deduped_20_1 := [ 2 .. deduped_23_1 ];
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_25_1 ) ), deduped_14_1, UnderlyingMatrix, morphism_attr_25_1 );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_7_1 ), Range( deduped_7_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_7_1 ) + -1 * UnionOfRows( deduped_27_1, deduped_13_1, deduped_11_1{deduped_20_1} ) );
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_24_1 := deduped_4_1;
    deduped_21_1 := morphisms_1[1];
    deduped_18_1 := List( deduped_22_1, Dimension );
    deduped_15_1 := Sum( deduped_18_1{[ 1 .. 1 - 1 ]} ) + 1;
    deduped_12_1 := List( deduped_19_1, function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_22_1[logic_new_func_x_2] );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_22_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_26_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_26_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_22_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_26_1 ) );
        end );
    deduped_10_1 := UnionOfRows( deduped_27_1, deduped_13_1, deduped_12_1{deduped_16_1} ) + -1 * UnionOfRows( deduped_27_1, deduped_13_1, deduped_12_1{deduped_20_1} );
    deduped_8_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_10_1 ) - RowRankOfMatrix( deduped_10_1 ) );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_8_1, deduped_8_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_8_1 ), deduped_27_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_5_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_6_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_22_1[1], Range( deduped_2_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( deduped_2_1 ), [ deduped_15_1 .. deduped_15_1 - 1 + deduped_18_1[1] ] ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_21_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_21_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 4016 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromSourceToPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, morphism_attr_20_1, morphism_attr_21_1, hoisted_22_1, hoisted_23_1, deduped_24_1;
    deduped_24_1 := UnderlyingRing( cat_1 );
    deduped_18_1 := List( morphisms_1, Range );
    hoisted_23_1 := Length( deduped_18_1 );
    hoisted_22_1 := deduped_24_1;
    deduped_19_1 := Length( morphisms_1 );
    deduped_14_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_18_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_13_1 := Dimension( deduped_14_1 );
    deduped_12_1 := List( [ 1 .. deduped_19_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_18_1[logic_new_func_x_2] );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_18_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_22_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_22_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_18_1{[ (logic_new_func_x_2 + 1) .. hoisted_23_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_22_1 ) );
        end );
    deduped_11_1 := UnionOfRows( deduped_24_1, deduped_13_1, deduped_12_1{[ 1 .. deduped_19_1 - 1 ]} );
    morphism_attr_21_1 := deduped_11_1;
    deduped_10_1 := -1 * UnionOfRows( deduped_24_1, deduped_13_1, deduped_12_1{[ 2 .. deduped_19_1 ]} );
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_21_1 ) ), deduped_14_1, UnderlyingMatrix, morphism_attr_21_1 );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_8_1 ), Range( deduped_8_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_8_1 ) + deduped_10_1 );
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_20_1 := deduped_4_1;
    deduped_17_1 := morphisms_1[1];
    deduped_16_1 := List( deduped_18_1, Dimension );
    deduped_15_1 := Sum( deduped_16_1{[ 1 .. 1 - 1 ]} ) + 1;
    deduped_9_1 := deduped_11_1 + deduped_10_1;
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_9_1 ) - RowRankOfMatrix( deduped_9_1 ) );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_7_1, deduped_7_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_7_1 ), deduped_24_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_6_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_20_1 ) ), UnderlyingMatrix, morphism_attr_20_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_5_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_5_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_18_1[1], Range( deduped_2_1 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( deduped_2_1 ), [ deduped_15_1 .. deduped_15_1 - 1 + deduped_16_1[1] ] ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_17_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_17_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 4017 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromTensorProductToInternalCoHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromTensorProductToInternalCoHomWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromTensorProductToInternalHom( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 805 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismFromTensorProductToInternalHomWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( a_1 ) * Dimension( b_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 302 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismToBidual( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismToBidualWithGivenBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, r_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismToCoBidual( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), deduped_4_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_4_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddMorphismToCoBidualWithGivenCoBidual( cat,
        
########
function ( cat_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, r_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), deduped_4_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_4_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, r_1 * UnderlyingMatrix( a_1 ) );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return Dimension( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddPostCompose( cat,
        
########
function ( cat_1, beta_1, alpha_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := objects_1[k_1];
    deduped_5_1 := Dimension( deduped_6_1 );
    deduped_3_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_5_1, deduped_8_1 ), HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_5_1, deduped_8_1 ) );
    morphism_attr_7_1 := deduped_3_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), deduped_8_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_7_1 ) ), deduped_6_1, UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, morphism_attr_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := objects_1[k_1];
    deduped_5_1 := Dimension( deduped_6_1 );
    deduped_3_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_5_1, deduped_8_1 ), HomalgIdentityMatrix( deduped_5_1, deduped_8_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_5_1, deduped_8_1 ) );
    morphism_attr_7_1 := deduped_3_1;
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), deduped_8_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_7_1 ) ), deduped_6_1, UnderlyingMatrix, morphism_attr_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := objects_1[k_1];
    deduped_1_1 := Dimension( deduped_2_1 );
    morphism_attr_3_1 := UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_1_1, deduped_4_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_4_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                return Dimension( c_2 );
            end ), deduped_1_1, deduped_4_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_3_1 ) ), deduped_2_1, UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := objects_1[k_1];
    deduped_1_1 := Dimension( deduped_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, deduped_2_1, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( objects_1{[ 1 .. k_1 - 1 ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), deduped_1_1, deduped_3_1 ), HomalgIdentityMatrix( deduped_1_1, deduped_3_1 ), HomalgZeroMatrix( Sum( objects_1{[ k_1 + 1 .. Length( objects_1 ) ]}, function ( c_2 )
                  return Dimension( c_2 );
              end ), deduped_1_1, deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, morphism_attr_22_1, morphism_attr_23_1, hoisted_24_1, deduped_25_1;
    deduped_25_1 := UnderlyingRing( cat_1 );
    hoisted_24_1 := deduped_25_1;
    deduped_21_1 := Length( morphisms_1 );
    deduped_20_1 := List( morphisms_1, Source );
    deduped_18_1 := [ 1 .. deduped_21_1 ];
    deduped_16_1 := Length( deduped_20_1 );
    deduped_15_1 := [ 1 .. deduped_21_1 - 1 ];
    deduped_13_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_20_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_12_1 := Dimension( deduped_13_1 );
    deduped_10_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := morphisms_1[logic_new_func_x_2];
            deduped_3_2 := deduped_20_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_13_1, deduped_3_2, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_20_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_24_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_24_1 ), HomalgZeroMatrix( Sum( deduped_20_1{[ logic_new_func_x_2 + 1 .. deduped_16_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_24_1 ) ) );
            return UnderlyingMatrix( deduped_1_2 ) * UnderlyingMatrix( deduped_4_2 );
        end );
    deduped_9_1 := UnionOfColumns( deduped_25_1, deduped_12_1, deduped_10_1{deduped_15_1} );
    morphism_attr_23_1 := deduped_9_1;
    deduped_19_1 := [ 2 .. deduped_21_1 ];
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_13_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_23_1 ) ), UnderlyingMatrix, morphism_attr_23_1 );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_7_1 ), Range( deduped_7_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_7_1 ) + -1 * UnionOfColumns( deduped_25_1, deduped_12_1, deduped_10_1{deduped_19_1} ) );
    deduped_3_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_22_1 := deduped_3_1;
    deduped_17_1 := List( deduped_20_1, Dimension );
    deduped_14_1 := Sum( deduped_17_1{[ 1 .. k_1 - 1 ]} ) + 1;
    deduped_11_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_20_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_24_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_24_1 ), HomalgZeroMatrix( Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_16_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_24_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    deduped_8_1 := UnionOfColumns( deduped_25_1, deduped_12_1, deduped_11_1{deduped_15_1} ) + -1 * UnionOfColumns( deduped_25_1, deduped_12_1, deduped_11_1{deduped_19_1} );
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_8_1 ) - RowRankOfMatrix( deduped_8_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_6_1 ), deduped_25_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_22_1 ) ), Source( deduped_5_1 ), UnderlyingMatrix, morphism_attr_22_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), deduped_20_1[k_1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( deduped_1_1 ), [ deduped_14_1 .. deduped_14_1 - 1 + deduped_17_1[k_1] ] ) );
end
########
        
    , 3915 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectionInFactorOfFiberProductWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, k_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, morphism_attr_22_1, morphism_attr_23_1, hoisted_24_1, deduped_25_1;
    deduped_25_1 := UnderlyingRing( cat_1 );
    hoisted_24_1 := deduped_25_1;
    deduped_21_1 := Length( morphisms_1 );
    deduped_20_1 := List( morphisms_1, Source );
    deduped_18_1 := [ 1 .. deduped_21_1 ];
    deduped_16_1 := Length( deduped_20_1 );
    deduped_15_1 := [ 1 .. deduped_21_1 - 1 ];
    deduped_13_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_20_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_12_1 := Dimension( deduped_13_1 );
    deduped_10_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_20_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_24_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_24_1 ), HomalgZeroMatrix( Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_16_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_24_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    deduped_9_1 := UnionOfColumns( deduped_25_1, deduped_12_1, deduped_10_1{deduped_15_1} );
    morphism_attr_23_1 := deduped_9_1;
    deduped_19_1 := [ 2 .. deduped_21_1 ];
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_13_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_23_1 ) ), UnderlyingMatrix, morphism_attr_23_1 );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_7_1 ), Range( deduped_7_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_7_1 ) + -1 * UnionOfColumns( deduped_25_1, deduped_12_1, deduped_10_1{deduped_19_1} ) );
    deduped_3_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_22_1 := deduped_3_1;
    deduped_17_1 := List( deduped_20_1, Dimension );
    deduped_14_1 := Sum( deduped_17_1{[ 1 .. k_1 - 1 ]} ) + 1;
    deduped_11_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_20_1[logic_new_func_x_2] );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_24_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_24_1 ), HomalgZeroMatrix( Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_16_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_24_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    deduped_8_1 := UnionOfColumns( deduped_25_1, deduped_12_1, deduped_11_1{deduped_15_1} ) + -1 * UnionOfColumns( deduped_25_1, deduped_12_1, deduped_11_1{deduped_19_1} );
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_8_1 ) - RowRankOfMatrix( deduped_8_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_6_1 ), deduped_25_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_22_1 ) ), Source( deduped_5_1 ), UnderlyingMatrix, morphism_attr_22_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), deduped_20_1[k_1], UnderlyingMatrix, CertainColumns( UnderlyingMatrix( deduped_1_1 ), [ deduped_14_1 .. deduped_14_1 - 1 + deduped_17_1[k_1] ] ) );
end
########
        
    , 3916 : IsPrecompiledDerivation := true );
    
    ##
    AddProjectiveLift( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Source( beta_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddPushout( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, morphism_attr_19_1, morphism_attr_20_1, hoisted_21_1, deduped_22_1;
    deduped_22_1 := UnderlyingRing( cat_1 );
    hoisted_21_1 := deduped_22_1;
    deduped_18_1 := Length( arg2_1 );
    deduped_17_1 := List( arg2_1, Range );
    deduped_15_1 := [ 1 .. deduped_18_1 ];
    deduped_14_1 := Length( deduped_17_1 );
    deduped_13_1 := [ 1 .. deduped_18_1 - 1 ];
    deduped_12_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_17_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_11_1 := Dimension( deduped_12_1 );
    deduped_9_1 := List( deduped_15_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := arg2_1[logic_new_func_x_2];
            deduped_3_2 := deduped_17_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_3_2, deduped_12_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_2, Sum( deduped_17_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_21_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_21_1 ), HomalgZeroMatrix( deduped_2_2, Sum( deduped_17_1{[ logic_new_func_x_2 + 1 .. deduped_14_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_21_1 ) ) );
            return UnderlyingMatrix( deduped_4_2 ) * UnderlyingMatrix( deduped_1_2 );
        end );
    deduped_7_1 := UnionOfRows( deduped_22_1, deduped_11_1, deduped_9_1{deduped_13_1} );
    morphism_attr_20_1 := deduped_7_1;
    deduped_16_1 := [ 2 .. deduped_18_1 ];
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_20_1 ) ), deduped_12_1, UnderlyingMatrix, morphism_attr_20_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_5_1 ), Range( deduped_5_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_5_1 ) + -1 * UnionOfRows( deduped_22_1, deduped_11_1, deduped_9_1{deduped_16_1} ) );
    deduped_2_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_3_1 ) );
    morphism_attr_19_1 := deduped_2_1;
    deduped_10_1 := List( deduped_15_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_17_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnderlyingMatrix( arg2_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_17_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_21_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_21_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_17_1{[ (logic_new_func_x_2 + 1) .. deduped_14_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_21_1 ) );
        end );
    deduped_8_1 := UnionOfRows( deduped_22_1, deduped_11_1, deduped_10_1{deduped_13_1} ) + -1 * UnionOfRows( deduped_22_1, deduped_11_1, deduped_10_1{deduped_16_1} );
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_8_1 ) - RowRankOfMatrix( deduped_8_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_6_1 ), deduped_22_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_3_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_19_1 ) ), UnderlyingMatrix, morphism_attr_19_1 );
    return Range( deduped_4_1 );
end
########
        
    , 3815 : IsPrecompiledDerivation := true );
    
    ##
    AddPushoutFunctorial( cat,
        
########
function ( cat_1, morphisms_1, L_1, morphismsp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, morphism_attr_29_1, morphism_attr_30_1, morphism_attr_31_1, hoisted_32_1, hoisted_33_1, hoisted_34_1, hoisted_35_1, hoisted_36_1, deduped_37_1;
    deduped_37_1 := UnderlyingRing( cat_1 );
    deduped_27_1 := List( morphismsp_1, Range );
    hoisted_36_1 := List( deduped_27_1, Dimension );
    hoisted_34_1 := Length( deduped_27_1 );
    hoisted_32_1 := deduped_37_1;
    deduped_28_1 := Length( morphismsp_1 );
    deduped_24_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_27_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_22_1 := Dimension( deduped_24_1 );
    deduped_20_1 := List( [ 1 .. deduped_28_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_27_1[logic_new_func_x_2] );
            return UnderlyingMatrix( morphismsp_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_27_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_32_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_32_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_27_1{[ (logic_new_func_x_2 + 1) .. hoisted_34_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_32_1 ) );
        end );
    deduped_18_1 := UnionOfRows( deduped_37_1, deduped_22_1, deduped_20_1{[ 1 .. deduped_28_1 - 1 ]} );
    deduped_16_1 := -1 * UnionOfRows( deduped_37_1, deduped_22_1, deduped_20_1{[ 2 .. deduped_28_1 ]} );
    deduped_14_1 := deduped_18_1 + deduped_16_1;
    deduped_11_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_14_1 ) - RowRankOfMatrix( deduped_14_1 ) );
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_11_1, deduped_11_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_11_1 ), deduped_37_1 ) );
    hoisted_35_1 := UnderlyingMatrix( deduped_8_1 );
    deduped_25_1 := List( morphisms_1, Range );
    hoisted_33_1 := Length( deduped_25_1 );
    deduped_26_1 := Length( morphisms_1 );
    deduped_23_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_25_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_21_1 := Dimension( deduped_23_1 );
    deduped_19_1 := List( [ 1 .. deduped_26_1 ], function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_25_1[logic_new_func_x_2] );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_25_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_32_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_32_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_25_1{[ (logic_new_func_x_2 + 1) .. hoisted_33_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_32_1 ) );
        end );
    deduped_17_1 := UnionOfRows( deduped_37_1, deduped_21_1, deduped_19_1{[ 1 .. deduped_26_1 - 1 ]} );
    morphism_attr_29_1 := deduped_17_1;
    deduped_15_1 := -1 * UnionOfRows( deduped_37_1, deduped_21_1, deduped_19_1{[ 2 .. deduped_26_1 ]} );
    deduped_12_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_29_1 ) ), deduped_23_1, UnderlyingMatrix, morphism_attr_29_1 );
    deduped_9_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_12_1 ), Range( deduped_12_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_12_1 ) + deduped_15_1 );
    deduped_7_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_9_1 ) );
    morphism_attr_31_1 := deduped_7_1;
    deduped_5_1 := Range( deduped_8_1 );
    deduped_3_1 := UnionOfRows( deduped_37_1, Dimension( deduped_5_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, morphism_attr_10_2, morphism_attr_11_2;
              morphism_attr_11_2 := deduped_18_1;
              deduped_6_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                       ), cat_1, Dimension, NumberRows( morphism_attr_11_2 ) ), deduped_24_1, UnderlyingMatrix, morphism_attr_11_2 );
              deduped_5_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, Source( deduped_6_2 ), Range( deduped_6_2 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_2 ) + deduped_16_1 );
              deduped_4_2 := SyzygiesOfColumns( UnderlyingMatrix( deduped_5_2 ) );
              morphism_attr_10_2 := deduped_4_2;
              deduped_9_2 := L_1[logic_new_func_x_2];
              deduped_8_2 := hoisted_36_1;
              deduped_7_2 := Sum( deduped_8_2{[ 1 .. logic_new_func_x_2 - 1 ]} ) + 1;
              deduped_3_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, Range( deduped_5_2 ), ObjectifyObjectForCAPWithAttributes( rec(
                       ), cat_1, Dimension, NumberColumns( morphism_attr_10_2 ) ), UnderlyingMatrix, morphism_attr_10_2 );
              deduped_2_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, Source( deduped_3_2 ), deduped_5_1, UnderlyingMatrix, UnderlyingMatrix( deduped_3_2 ) * hoisted_35_1 );
              deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                     ), cat_1, deduped_27_1[logic_new_func_x_2], Range( deduped_2_2 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( deduped_2_2 ), [ deduped_7_2 .. deduped_7_2 - 1 + deduped_8_2[logic_new_func_x_2] ] ) );
              return UnderlyingMatrix( deduped_9_2 ) * UnderlyingMatrix( deduped_1_2 );
          end ) );
    morphism_attr_30_1 := deduped_3_1;
    deduped_13_1 := deduped_17_1 + deduped_15_1;
    deduped_10_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_13_1 ) - RowRankOfMatrix( deduped_13_1 ) );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_10_1, deduped_10_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_10_1 ), deduped_37_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_9_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_31_1 ) ), UnderlyingMatrix, morphism_attr_31_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_30_1 ) ), deduped_5_1, UnderlyingMatrix, morphism_attr_30_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_4_1 ), Range( deduped_2_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_4_1 ), UnderlyingMatrix( deduped_2_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_6_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 19782 : IsPrecompiledDerivation := true );
    
    ##
    AddPushoutFunctorialWithGivenPushouts( cat,
        
########
function ( cat_1, P_1, morphisms_1, L_1, morphismsp_1, Pp_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, morphism_attr_22_1, morphism_attr_23_1, morphism_attr_24_1, hoisted_25_1, hoisted_26_1, hoisted_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    hoisted_27_1 := Length( morphismsp_1 );
    hoisted_26_1 := List( morphismsp_1, Range );
    hoisted_25_1 := deduped_28_1;
    deduped_21_1 := Length( morphisms_1 );
    deduped_20_1 := List( morphisms_1, Range );
    deduped_18_1 := [ 1 .. deduped_21_1 ];
    deduped_17_1 := Length( deduped_20_1 );
    deduped_16_1 := [ 1 .. deduped_21_1 - 1 ];
    deduped_15_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_20_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_14_1 := Dimension( deduped_15_1 );
    deduped_12_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_20_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_25_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_25_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_25_1 ) );
        end );
    deduped_11_1 := UnionOfRows( deduped_28_1, deduped_14_1, deduped_12_1{deduped_16_1} );
    morphism_attr_24_1 := deduped_11_1;
    deduped_19_1 := [ 2 .. deduped_21_1 ];
    deduped_9_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), deduped_15_1, UnderlyingMatrix, morphism_attr_24_1 );
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_9_1 ), Range( deduped_9_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_9_1 ) + -1 * UnionOfRows( deduped_28_1, deduped_14_1, deduped_12_1{deduped_19_1} ) );
    deduped_5_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_7_1 ) );
    morphism_attr_23_1 := deduped_5_1;
    deduped_3_1 := UnionOfRows( deduped_28_1, Dimension( Pp_1 ), List( [ 1 .. Length( L_1 ) ], function ( logic_new_func_x_2 )
              return function ( s_3 )
                      return UnderlyingMatrix( s_3 );
                  end( function ( i_3 )
                        local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3, deduped_5_3, deduped_6_3, deduped_7_3, deduped_8_3, deduped_9_3, deduped_10_3, deduped_11_3, deduped_12_3, deduped_13_3, deduped_14_3, deduped_15_3, deduped_16_3, deduped_17_3, deduped_18_3, deduped_19_3, morphism_attr_20_3, morphism_attr_21_3, hoisted_22_3;
                        deduped_18_3 := hoisted_26_1;
                        hoisted_22_3 := Length( deduped_18_3 );
                        deduped_19_3 := hoisted_27_1;
                        deduped_14_3 := ObjectifyObjectForCAPWithAttributes( rec(
                               ), cat_1, Dimension, Sum( List( deduped_18_3, function ( object_4 )
                                    return Dimension( object_4 );
                                end ) ) );
                        deduped_13_3 := Dimension( deduped_14_3 );
                        deduped_12_3 := List( [ 1 .. deduped_19_3 ], function ( logic_new_func_x_4 )
                                local deduped_1_4;
                                deduped_1_4 := Dimension( deduped_18_3[logic_new_func_x_4] );
                                return UnderlyingMatrix( morphismsp_1[logic_new_func_x_4] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_4, Sum( deduped_18_3{[ 1 .. (logic_new_func_x_4 - 1) ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), hoisted_25_1 ), HomalgIdentityMatrix( deduped_1_4, hoisted_25_1 ), HomalgZeroMatrix( deduped_1_4, Sum( deduped_18_3{[ (logic_new_func_x_4 + 1) .. hoisted_22_3 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), hoisted_25_1 ) );
                            end );
                        deduped_11_3 := UnionOfRows( hoisted_25_1, deduped_13_3, deduped_12_3{[ 1 .. deduped_19_3 - 1 ]} );
                        morphism_attr_21_3 := deduped_11_3;
                        deduped_10_3 := -1 * UnionOfRows( hoisted_25_1, deduped_13_3, deduped_12_3{[ 2 .. deduped_19_3 ]} );
                        deduped_8_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                                 ), cat_1, Dimension, NumberRows( morphism_attr_21_3 ) ), deduped_14_3, UnderlyingMatrix, morphism_attr_21_3 );
                        deduped_6_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_8_3 ), Range( deduped_8_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_8_3 ) + deduped_10_3 );
                        deduped_4_3 := SyzygiesOfColumns( UnderlyingMatrix( deduped_6_3 ) );
                        morphism_attr_20_3 := deduped_4_3;
                        deduped_17_3 := L_1[i_3];
                        deduped_16_3 := List( deduped_18_3, Dimension );
                        deduped_15_3 := Sum( deduped_16_3{[ 1 .. i_3 - 1 ]} ) + 1;
                        deduped_9_3 := deduped_11_3 + deduped_10_3;
                        deduped_7_3 := ObjectifyObjectForCAPWithAttributes( rec(
                               ), cat_1, Dimension, NumberColumns( deduped_9_3 ) - RowRankOfMatrix( deduped_9_3 ) );
                        deduped_5_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, deduped_7_3, deduped_7_3, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_7_3 ), hoisted_25_1 ) );
                        deduped_3_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Range( deduped_6_3 ), ObjectifyObjectForCAPWithAttributes( rec(
                                 ), cat_1, Dimension, NumberColumns( morphism_attr_20_3 ) ), UnderlyingMatrix, morphism_attr_20_3 );
                        deduped_2_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_3_3 ), Range( deduped_5_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_3 ) * UnderlyingMatrix( deduped_5_3 ) );
                        deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, deduped_18_3[i_3], Range( deduped_2_3 ), UnderlyingMatrix, CertainRows( UnderlyingMatrix( deduped_2_3 ), [ deduped_15_3 .. deduped_15_3 - 1 + deduped_16_3[i_3] ] ) );
                        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                               ), cat_1, Source( deduped_17_3 ), Range( deduped_1_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_17_3 ) * UnderlyingMatrix( deduped_1_3 ) );
                    end( logic_new_func_x_2 ) );
          end ) );
    morphism_attr_22_1 := deduped_3_1;
    deduped_13_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2;
            deduped_1_2 := Dimension( deduped_20_1[logic_new_func_x_2] );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_25_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_25_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_25_1 ) );
        end );
    deduped_10_1 := UnionOfRows( deduped_28_1, deduped_14_1, deduped_13_1{deduped_16_1} ) + -1 * UnionOfRows( deduped_28_1, deduped_14_1, deduped_13_1{deduped_19_1} );
    deduped_8_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_10_1 ) - RowRankOfMatrix( deduped_10_1 ) );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_8_1, deduped_8_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_8_1 ), deduped_28_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_7_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_23_1 ) ), UnderlyingMatrix, morphism_attr_23_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_22_1 ) ), Pp_1, UnderlyingMatrix, morphism_attr_22_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_4_1 ), Range( deduped_2_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_4_1 ), UnderlyingMatrix( deduped_2_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_6_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 12151 : IsPrecompiledDerivation := true );
    
    ##
    AddRankMorphism( cat,
        
########
function ( cat_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, morphism_attr_10_1, deduped_11_1;
    deduped_11_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := HomalgIdentityMatrix( 1, deduped_11_1 );
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), deduped_11_1 ) );
    deduped_7_1 := Dimension( Source( deduped_8_1 ) );
    deduped_6_1 := deduped_7_1 * 1;
    deduped_5_1 := deduped_7_1 * deduped_7_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_7_1, deduped_11_1 );
    deduped_3_1 := KroneckerMat( TransposedMatrix( deduped_4_1 ), deduped_4_1 * UnderlyingMatrix( deduped_8_1 ) );
    deduped_2_1 := KroneckerMat( ConvertMatrixToRow( deduped_4_1 ), deduped_9_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_7_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                    end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_11_1 ), deduped_9_1 ) * KroneckerMat( deduped_4_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, 1 ) * deduped_7_1 + QUO_INT( deduped_1_2, 1 ) + 1);
                  end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_11_1 ) );
    deduped_1_1 := deduped_2_1 * deduped_3_1 * ConvertMatrixToColumn( deduped_4_1 );
    morphism_attr_10_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_10_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 );
end
########
        
    , 5929 : IsPrecompiledDerivation := true );
    
    ##
    AddRightDistributivityExpanding( cat,
        
########
function ( cat_1, L_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    hoisted_7_1 := deduped_8_1;
    deduped_3_1 := Dimension( a_1 );
    hoisted_6_1 := HomalgIdentityMatrix( deduped_3_1, deduped_8_1 );
    deduped_4_1 := Length( L_1 );
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ) * deduped_3_1 );
    deduped_1_1 := UnionOfColumns( deduped_8_1, Dimension( deduped_2_1 ), List( [ 1 .. deduped_4_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
              deduped_4_2 := L_1[logic_new_func_x_2];
              deduped_3_2 := Dimension( deduped_4_2 );
              deduped_2_2 := UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_3_2, hoisted_7_1 ), HomalgIdentityMatrix( deduped_3_2, hoisted_7_1 ), HomalgZeroMatrix( Sum( L_1{[ logic_new_func_x_2 + 1 .. deduped_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_3_2, hoisted_7_1 ) );
              deduped_1_2 := KroneckerMat( deduped_2_2, hoisted_6_1 );
              return deduped_1_2;
          end ) );
    morphism_attr_5_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_5_1 ) ), UnderlyingMatrix, morphism_attr_5_1 );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    AddRightDistributivityExpandingWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := deduped_6_1;
    hoisted_4_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_6_1 );
    deduped_2_1 := Length( L_1 );
    deduped_1_1 := UnionOfColumns( deduped_6_1, Dimension( s_1 ), List( [ 1 .. deduped_2_1 ], function ( logic_new_func_x_2 )
              return function ( s_3 )
                      return UnderlyingMatrix( s_3 );
                  end( function ( logic_new_func_x_3 )
                        return function ( mor_4 )
                                local deduped_1_4, morphism_attr_2_4;
                                deduped_1_4 := KroneckerMat( UnderlyingMatrix( mor_4 ), hoisted_4_1 );
                                morphism_attr_2_4 := deduped_1_4;
                                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                                         ), cat_1, Dimension, NumberRows( morphism_attr_2_4 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                                         ), cat_1, Dimension, NumberColumns( morphism_attr_2_4 ) ), UnderlyingMatrix, morphism_attr_2_4 );
                            end( function ( i_4 )
                                  local deduped_1_4, deduped_2_4, deduped_3_4, morphism_attr_4_4;
                                  deduped_3_4 := L_1[i_4];
                                  deduped_2_4 := Dimension( deduped_3_4 );
                                  deduped_1_4 := UnionOfRows( HomalgZeroMatrix( Sum( L_1{[ 1 .. i_4 - 1 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), deduped_2_4, hoisted_5_1 ), HomalgIdentityMatrix( deduped_2_4, hoisted_5_1 ), HomalgZeroMatrix( Sum( L_1{[ i_4 + 1 .. deduped_2_1 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), deduped_2_4, hoisted_5_1 ) );
                                  morphism_attr_4_4 := deduped_1_4;
                                  return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                         ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                                           ), cat_1, Dimension, NumberRows( morphism_attr_4_4 ) ), deduped_3_4, UnderlyingMatrix, morphism_attr_4_4 );
                              end( logic_new_func_x_3 ) );
                    end( logic_new_func_x_2 ) );
          end ) );
    morphism_attr_3_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_3_1 ) ), UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    AddRightDistributivityFactoring( cat,
        
########
function ( cat_1, L_1, a_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    hoisted_7_1 := deduped_8_1;
    deduped_3_1 := Dimension( a_1 );
    hoisted_6_1 := HomalgIdentityMatrix( deduped_3_1, deduped_8_1 );
    deduped_4_1 := Length( L_1 );
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( L_1, function ( object_2 )
                  return Dimension( object_2 );
              end ) ) * deduped_3_1 );
    deduped_1_1 := UnionOfRows( deduped_8_1, Dimension( deduped_2_1 ), List( [ 1 .. deduped_4_1 ], function ( logic_new_func_x_2 )
              local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
              deduped_4_2 := L_1[logic_new_func_x_2];
              deduped_3_2 := Dimension( deduped_4_2 );
              deduped_2_2 := UnionOfColumns( HomalgZeroMatrix( deduped_3_2, Sum( L_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_7_1 ), HomalgIdentityMatrix( deduped_3_2, hoisted_7_1 ), HomalgZeroMatrix( deduped_3_2, Sum( L_1{[ logic_new_func_x_2 + 1 .. deduped_4_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_7_1 ) );
              deduped_1_2 := KroneckerMat( deduped_2_2, hoisted_6_1 );
              return deduped_1_2;
          end ) );
    morphism_attr_5_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_5_1 ) ), deduped_2_1, UnderlyingMatrix, morphism_attr_5_1 );
end
########
        
    , 1707 : IsPrecompiledDerivation := true );
    
    ##
    AddRightDistributivityFactoringWithGivenObjects( cat,
        
########
function ( cat_1, s_1, L_1, a_1, r_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1, hoisted_4_1, hoisted_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    hoisted_5_1 := deduped_6_1;
    hoisted_4_1 := HomalgIdentityMatrix( Dimension( a_1 ), deduped_6_1 );
    deduped_2_1 := Length( L_1 );
    deduped_1_1 := UnionOfRows( deduped_6_1, Dimension( r_1 ), List( [ 1 .. deduped_2_1 ], function ( logic_new_func_x_2 )
              return function ( s_3 )
                      return UnderlyingMatrix( s_3 );
                  end( function ( logic_new_func_x_3 )
                        return function ( mor_4 )
                                local deduped_1_4, morphism_attr_2_4;
                                deduped_1_4 := KroneckerMat( UnderlyingMatrix( mor_4 ), hoisted_4_1 );
                                morphism_attr_2_4 := deduped_1_4;
                                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                                         ), cat_1, Dimension, NumberRows( morphism_attr_2_4 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                                         ), cat_1, Dimension, NumberColumns( morphism_attr_2_4 ) ), UnderlyingMatrix, morphism_attr_2_4 );
                            end( function ( i_4 )
                                  local deduped_1_4, deduped_2_4, deduped_3_4, morphism_attr_4_4;
                                  deduped_3_4 := L_1[i_4];
                                  deduped_2_4 := Dimension( deduped_3_4 );
                                  deduped_1_4 := UnionOfColumns( HomalgZeroMatrix( deduped_2_4, Sum( L_1{[ 1 .. i_4 - 1 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), hoisted_5_1 ), HomalgIdentityMatrix( deduped_2_4, hoisted_5_1 ), HomalgZeroMatrix( deduped_2_4, Sum( L_1{[ i_4 + 1 .. deduped_2_1 ]}, function ( c_5 )
                                              return Dimension( c_5 );
                                          end ), hoisted_5_1 ) );
                                  morphism_attr_4_4 := deduped_1_4;
                                  return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                         ), cat_1, deduped_3_4, ObjectifyObjectForCAPWithAttributes( rec(
                                           ), cat_1, Dimension, NumberColumns( morphism_attr_4_4 ) ), UnderlyingMatrix, morphism_attr_4_4 );
                              end( logic_new_func_x_3 ) );
                    end( logic_new_func_x_2 ) );
          end ) );
    morphism_attr_3_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_3_1 ) ), r_1, UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 1506 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitor( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitorInverse( cat,
        
########
function ( cat_1, a_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( a_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddSolveLinearSystemInAbCategory( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    local deduped_1_1, deduped_2_1, hoisted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1;
    hoisted_6_1 := arg3_1[1];
    hoisted_5_1 := [ 1 .. Length( arg2_1 ) ];
    hoisted_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    hoisted_3_1 := UnderlyingRing( cat_1 );
    deduped_2_1 := arg2_1[1];
    deduped_1_1 := [ 1 .. Length( deduped_2_1 ) ];
    return List( deduped_1_1, function ( j_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, deduped_15_2, morphism_attr_16_2, morphism_attr_17_2;
            deduped_14_2 := hoisted_5_1;
            deduped_13_2 := hoisted_4_1;
            deduped_7_2 := UnionOfColumns( hoisted_3_1, Dimension( deduped_13_2 ), List( deduped_14_2, function ( logic_new_func_x_3 )
                      return function ( s_4 )
                              return UnderlyingMatrix( s_4 );
                          end( function ( i_4 )
                                local deduped_1_4, morphism_attr_2_4;
                                deduped_1_4 := ConvertMatrixToRow( UnderlyingMatrix( arg4_1[i_4] ) );
                                morphism_attr_2_4 := deduped_1_4;
                                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                       ), cat_1, deduped_13_2, ObjectifyObjectForCAPWithAttributes( rec(
                                         ), cat_1, Dimension, NumberColumns( morphism_attr_2_4 ) ), UnderlyingMatrix, morphism_attr_2_4 );
                            end( logic_new_func_x_3 ) );
                  end ) );
            morphism_attr_17_2 := deduped_7_2;
            deduped_15_2 := hoisted_6_1;
            deduped_10_2 := List( deduped_1_1, function ( j_3 )
                    return ObjectifyObjectForCAPWithAttributes( rec(
                           ), cat_1, Dimension, Dimension( Range( deduped_2_1[j_3] ) ) * Dimension( Source( deduped_15_2[j_3] ) ) );
                end );
            deduped_9_2 := List( deduped_14_2, function ( i_3 )
                    return ObjectifyObjectForCAPWithAttributes( rec(
                           ), cat_1, Dimension, Dimension( Source( arg2_1[i_3][1] ) ) * Dimension( Range( arg3_1[i_3][1] ) ) );
                end );
            deduped_6_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, Sum( List( deduped_9_2, function ( object_3 )
                        return Dimension( object_3 );
                    end ) ) );
            deduped_3_2 := UnionOfRows( hoisted_3_1, Dimension( deduped_6_2 ), ListN( deduped_10_2, List( deduped_1_1, function ( logic_new_func_x_3 )
                        return function ( row_4 )
                                return List( row_4, UnderlyingMatrix );
                            end( function ( j_4 )
                                  local hoisted_1_4;
                                  hoisted_1_4 := deduped_10_2[j_4];
                                  return List( deduped_14_2, function ( i_5 )
                                          return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                                                 ), cat_1, hoisted_1_4, deduped_9_2[i_5], UnderlyingMatrix, KroneckerMat( TransposedMatrix( UnderlyingMatrix( arg2_1[i_5][j_4] ) ), UnderlyingMatrix( arg3_1[i_5][j_4] ) ) );
                                      end );
                              end( logic_new_func_x_3 ) );
                    end ), function ( source_3, row_3 )
                      return UnionOfColumns( hoisted_3_1, Dimension( source_3 ), row_3 );
                  end ) );
            morphism_attr_16_2 := deduped_3_2;
            deduped_12_2 := Source( deduped_15_2[j_2] );
            deduped_11_2 := Range( deduped_2_1[j_2] );
            deduped_8_2 := List( deduped_10_2, Dimension );
            deduped_5_2 := Sum( deduped_8_2{[ 1 .. j_2 - 1 ]} ) + 1;
            deduped_4_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_13_2, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_17_2 ) ), UnderlyingMatrix, morphism_attr_17_2 );
            deduped_2_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_16_2 ) ), deduped_6_2, UnderlyingMatrix, morphism_attr_16_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, Source( deduped_4_2 ), Source( deduped_2_2 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_4_2 ), UnderlyingMatrix( deduped_2_2 ) ) );
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_11_2, deduped_12_2, UnderlyingMatrix, ConvertRowToMatrix( CertainColumns( UnderlyingMatrix( deduped_1_2 ), [ deduped_5_2 .. deduped_5_2 - 1 + deduped_8_2[j_2] ] ), Dimension( deduped_11_2 ), Dimension( deduped_12_2 ) ) );
        end );
end
########
        
    , 401 : IsPrecompiledDerivation := true );
    
    ##
    AddSomeInjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return arg2_1;
end
########
        
    , 100 );
    
    ##
    AddSomeProjectiveObject( cat,
        
########
function ( cat_1, arg2_1 )
    return arg2_1;
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, morphism_attr_3_1;
    deduped_2_1 := UnderlyingMatrix( alpha_1 );
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_2_1 ) - RowRankOfMatrix( deduped_2_1 ) );
    morphism_attr_3_1 := HomalgZeroMatrix( 0, Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), deduped_1_1, UnderlyingMatrix, morphism_attr_3_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismFromInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, morphism_attr_2_1;
    deduped_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_2_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_2_1 ) ), UnderlyingMatrix, morphism_attr_2_1 );
end
########
        
    , 100 );
    
    ##
    AddSomeReductionBySplitEpiSummand_MorphismToInputRange( cat,
        
########
function ( cat_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1;
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_5_1 := deduped_4_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_5_1 ) ), UnderlyingMatrix, morphism_attr_5_1 );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), UnderlyingRing( cat_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddSubtractionForMorphisms( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), Range( a_1 ), UnderlyingMatrix, UnderlyingMatrix( a_1 ) + -1 * UnderlyingMatrix( b_1 ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductDualityCompatibilityMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, morphism_attr_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    deduped_25_1 := Dimension( b_1 );
    deduped_24_1 := Dimension( a_1 );
    deduped_23_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    deduped_22_1 := [ a_1, deduped_23_1, b_1, deduped_23_1 ];
    deduped_21_1 := Dimension( deduped_22_1[4] );
    deduped_20_1 := Dimension( deduped_22_1[2] );
    deduped_19_1 := Dimension( deduped_22_1[3] );
    deduped_18_1 := Dimension( deduped_22_1[1] );
    deduped_17_1 := HomalgIdentityMatrix( deduped_20_1, deduped_27_1 );
    deduped_16_1 := HomalgIdentityMatrix( deduped_18_1, deduped_27_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_19_1, deduped_27_1 );
    deduped_14_1 := deduped_19_1 * deduped_21_1;
    deduped_13_1 := deduped_18_1 * deduped_20_1;
    deduped_12_1 := deduped_18_1 * deduped_19_1;
    deduped_11_1 := HomalgIdentityMatrix( deduped_14_1, deduped_27_1 );
    deduped_10_1 := deduped_14_1 * deduped_18_1;
    deduped_9_1 := HomalgIdentityMatrix( deduped_13_1, deduped_27_1 );
    deduped_8_1 := deduped_12_1 * deduped_12_1;
    deduped_7_1 := deduped_13_1 * deduped_14_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_12_1, deduped_27_1 );
    deduped_5_1 := deduped_12_1 * deduped_7_1;
    deduped_4_1 := HomalgIdentityMatrix( deduped_7_1, deduped_27_1 );
    deduped_3_1 := KroneckerMat( ConvertMatrixToRow( deduped_6_1 ), deduped_4_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_27_1 ), deduped_4_1 ) * KroneckerMat( deduped_6_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_5_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_5_1 ), deduped_5_1, deduped_5_1, deduped_27_1 ) );
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_6_1 ), KroneckerMat( KroneckerMat( deduped_9_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_18_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_18_1 ) + 1);
                        end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_27_1 ) ), deduped_15_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_9_1, deduped_16_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                              end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_27_1 ), deduped_16_1 ) * KroneckerMat( deduped_17_1, ConvertMatrixToColumn( deduped_16_1 ) )), deduped_11_1 ), deduped_15_1 ) * KroneckerMat( deduped_17_1, (KroneckerMat( deduped_11_1, deduped_15_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_21_1 ) * deduped_19_1 + QUO_INT( deduped_1_2, deduped_21_1 ) + 1);
                          end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_27_1 ), deduped_15_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_21_1, deduped_27_1 ), ConvertMatrixToColumn( deduped_15_1 ) )) ) );
    deduped_1_1 := KroneckerMat( HomalgIdentityMatrix( deduped_24_1, deduped_27_1 ), HomalgIdentityMatrix( deduped_25_1, deduped_27_1 ) ) * (deduped_3_1 * deduped_2_1);
    morphism_attr_26_1 := deduped_1_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_26_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_26_1 ) ), UnderlyingMatrix, morphism_attr_26_1 );
end
########
        
    , 15766 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductDualityCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1;
    hoisted_4_1 := Dimension( b_1 );
    hoisted_3_1 := Dimension( a_1 );
    hoisted_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
    hoisted_1_1 := UnderlyingRing( cat_1 );
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, deduped_15_2, deduped_16_2, deduped_17_2, deduped_18_2, deduped_19_2, deduped_20_2, deduped_21_2, deduped_22_2, deduped_23_2, deduped_24_2, deduped_25_2, deduped_26_2, deduped_27_2, deduped_28_2, deduped_29_2, morphism_attr_30_2, morphism_attr_31_2, morphism_attr_32_2;
            deduped_27_2 := hoisted_2_1;
            deduped_26_2 := [ a_1, deduped_27_2, b_1, deduped_27_2 ];
            deduped_24_2 := Dimension( deduped_26_2[4] );
            deduped_23_2 := Dimension( deduped_26_2[2] );
            deduped_22_2 := Dimension( deduped_26_2[3] );
            deduped_21_2 := Dimension( deduped_26_2[1] );
            deduped_16_2 := deduped_22_2 * deduped_24_2;
            deduped_15_2 := deduped_21_2 * deduped_23_2;
            deduped_14_2 := deduped_21_2 * deduped_22_2;
            deduped_10_2 := deduped_14_2 * deduped_14_2;
            deduped_9_2 := deduped_15_2 * deduped_16_2;
            deduped_8_2 := HomalgIdentityMatrix( deduped_14_2, hoisted_1_1 );
            deduped_7_2 := deduped_14_2 * deduped_9_2;
            deduped_6_2 := HomalgIdentityMatrix( deduped_9_2, hoisted_1_1 );
            deduped_5_2 := KroneckerMat( ConvertMatrixToRow( deduped_8_2 ), deduped_6_2 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := (i_3 - 1);
                                return (REM_INT( deduped_1_3, deduped_14_2 ) * deduped_14_2 + QUO_INT( deduped_1_3, deduped_14_2 ) + 1);
                            end ) ), deduped_10_2 ), deduped_10_2, deduped_10_2, hoisted_1_1 ), deduped_6_2 ) * KroneckerMat( deduped_8_2, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_2 ], function ( i_3 )
                              local deduped_1_3;
                              deduped_1_3 := (i_3 - 1);
                              return (REM_INT( deduped_1_3, deduped_9_2 ) * deduped_14_2 + QUO_INT( deduped_1_3, deduped_9_2 ) + 1);
                          end ) ), deduped_7_2 ), deduped_7_2, deduped_7_2, hoisted_1_1 ) );
            morphism_attr_32_2 := deduped_5_2;
            deduped_19_2 := HomalgIdentityMatrix( deduped_23_2, hoisted_1_1 );
            deduped_18_2 := HomalgIdentityMatrix( deduped_21_2, hoisted_1_1 );
            deduped_17_2 := HomalgIdentityMatrix( deduped_22_2, hoisted_1_1 );
            deduped_13_2 := HomalgIdentityMatrix( deduped_16_2, hoisted_1_1 );
            deduped_12_2 := deduped_16_2 * deduped_21_2;
            deduped_11_2 := HomalgIdentityMatrix( deduped_15_2, hoisted_1_1 );
            deduped_3_2 := KroneckerMat( TransposedMatrix( deduped_8_2 ), KroneckerMat( KroneckerMat( deduped_11_2, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_2 ], function ( i_3 )
                                    local deduped_1_3;
                                    deduped_1_3 := (i_3 - 1);
                                    return (REM_INT( deduped_1_3, deduped_21_2 ) * deduped_16_2 + QUO_INT( deduped_1_3, deduped_21_2 ) + 1);
                                end ) ), deduped_12_2 ), deduped_12_2, deduped_12_2, hoisted_1_1 ) ), deduped_17_2 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_11_2, deduped_18_2 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_2 ], function ( i_3 )
                                          local deduped_1_3;
                                          deduped_1_3 := (i_3 - 1);
                                          return (REM_INT( deduped_1_3, deduped_23_2 ) * deduped_21_2 + QUO_INT( deduped_1_3, deduped_23_2 ) + 1);
                                      end ) ), deduped_15_2 ), deduped_15_2, deduped_15_2, hoisted_1_1 ), deduped_18_2 ) * KroneckerMat( deduped_19_2, ConvertMatrixToColumn( deduped_18_2 ) )), deduped_13_2 ), deduped_17_2 ) * KroneckerMat( deduped_19_2, (KroneckerMat( deduped_13_2, deduped_17_2 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_2 ], function ( i_3 )
                                      local deduped_1_3;
                                      deduped_1_3 := (i_3 - 1);
                                      return (REM_INT( deduped_1_3, deduped_24_2 ) * deduped_22_2 + QUO_INT( deduped_1_3, deduped_24_2 ) + 1);
                                  end ) ), deduped_16_2 ), deduped_16_2, deduped_16_2, hoisted_1_1 ), deduped_17_2 ) * KroneckerMat( HomalgIdentityMatrix( deduped_24_2, hoisted_1_1 ), ConvertMatrixToColumn( deduped_17_2 ) )) ) );
            morphism_attr_31_2 := deduped_3_2;
            deduped_29_2 := hoisted_4_1;
            deduped_28_2 := hoisted_3_1;
            deduped_25_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_28_2 * deduped_29_2 );
            deduped_20_2 := KroneckerMat( HomalgIdentityMatrix( deduped_28_2, hoisted_1_1 ), HomalgIdentityMatrix( deduped_29_2, hoisted_1_1 ) );
            deduped_4_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_32_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_32_2 ) ), UnderlyingMatrix, morphism_attr_32_2 );
            deduped_2_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_31_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_31_2 ) ), UnderlyingMatrix, morphism_attr_31_2 );
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( deduped_20_2, UnderlyingMatrix( deduped_4_2 ) * UnderlyingMatrix( deduped_2_2 ) ), HomalgIdentityMatrix( Dimension( deduped_25_2 ), hoisted_1_1 ) );
            morphism_attr_30_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_30_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_30_2 ) ), UnderlyingMatrix, morphism_attr_30_2 );
        end(  );
end
########
        
    , 15265 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphism( cat,
        
########
function ( cat_1, list_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, morphism_attr_24_1, morphism_attr_25_1, deduped_26_1;
    deduped_26_1 := UnderlyingRing( cat_1 );
    deduped_23_1 := Dimension( list_1[4] );
    deduped_22_1 := Dimension( list_1[2] );
    deduped_21_1 := Dimension( list_1[3] );
    deduped_20_1 := Dimension( list_1[1] );
    deduped_16_1 := deduped_21_1 * deduped_23_1;
    deduped_15_1 := deduped_20_1 * deduped_22_1;
    deduped_14_1 := deduped_20_1 * deduped_21_1;
    deduped_13_1 := deduped_14_1 * deduped_14_1;
    deduped_12_1 := HomalgIdentityMatrix( deduped_14_1, deduped_26_1 );
    deduped_11_1 := deduped_16_1;
    deduped_10_1 := deduped_15_1;
    deduped_9_1 := deduped_10_1 * deduped_11_1;
    deduped_8_1 := deduped_14_1 * deduped_9_1;
    deduped_7_1 := HomalgIdentityMatrix( deduped_9_1, deduped_26_1 );
    deduped_5_1 := KroneckerMat( ConvertMatrixToRow( deduped_12_1 ), deduped_7_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_13_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_14_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_14_1 ) + 1);
                    end ) ), deduped_13_1 ), deduped_13_1, deduped_13_1, deduped_26_1 ), deduped_7_1 ) * KroneckerMat( deduped_12_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                  end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_26_1 ) );
    morphism_attr_25_1 := deduped_5_1;
    deduped_19_1 := HomalgIdentityMatrix( deduped_22_1, deduped_26_1 );
    deduped_18_1 := HomalgIdentityMatrix( deduped_20_1, deduped_26_1 );
    deduped_17_1 := HomalgIdentityMatrix( deduped_21_1, deduped_26_1 );
    deduped_6_1 := deduped_11_1 * deduped_20_1;
    deduped_4_1 := KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_10_1, deduped_26_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_20_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1);
                      end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_26_1 ) ), deduped_17_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( HomalgIdentityMatrix( deduped_15_1, deduped_26_1 ), deduped_18_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_22_1 ) * deduped_20_1 + QUO_INT( deduped_1_2, deduped_22_1 ) + 1);
                            end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_26_1 ), deduped_18_1 ) * KroneckerMat( deduped_19_1, ConvertMatrixToColumn( deduped_18_1 ) )), HomalgIdentityMatrix( deduped_11_1, deduped_26_1 ) ), deduped_17_1 ) * KroneckerMat( deduped_19_1, (KroneckerMat( HomalgIdentityMatrix( deduped_16_1, deduped_26_1 ), deduped_17_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_21_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                        end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_26_1 ), deduped_17_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_23_1, deduped_26_1 ), ConvertMatrixToColumn( deduped_17_1 ) )) );
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_12_1 ), deduped_4_1 );
    morphism_attr_24_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_25_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_25_1 ) ), UnderlyingMatrix, morphism_attr_25_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 14160 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverse( cat,
        
########
function ( cat_1, list_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, morphism_attr_26_1, morphism_attr_27_1, deduped_28_1;
    deduped_28_1 := UnderlyingRing( cat_1 );
    deduped_25_1 := Dimension( list_1[4] );
    deduped_24_1 := Dimension( list_1[2] );
    deduped_23_1 := Dimension( list_1[3] );
    deduped_22_1 := Dimension( list_1[1] );
    deduped_18_1 := deduped_23_1 * deduped_25_1;
    deduped_17_1 := deduped_22_1 * deduped_24_1;
    deduped_16_1 := deduped_22_1 * deduped_23_1;
    deduped_12_1 := deduped_16_1 * deduped_16_1;
    deduped_11_1 := deduped_17_1 * deduped_18_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_16_1, deduped_28_1 );
    deduped_9_1 := deduped_16_1 * deduped_11_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_11_1, deduped_28_1 );
    deduped_7_1 := KroneckerMat( ConvertMatrixToRow( deduped_10_1 ), deduped_8_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_12_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_16_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_16_1 ) + 1);
                    end ) ), deduped_12_1 ), deduped_12_1, deduped_12_1, deduped_28_1 ), deduped_8_1 ) * KroneckerMat( deduped_10_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_16_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                  end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_28_1 ) );
    morphism_attr_27_1 := deduped_7_1;
    deduped_21_1 := HomalgIdentityMatrix( deduped_24_1, deduped_28_1 );
    deduped_20_1 := HomalgIdentityMatrix( deduped_22_1, deduped_28_1 );
    deduped_19_1 := HomalgIdentityMatrix( deduped_23_1, deduped_28_1 );
    deduped_15_1 := HomalgIdentityMatrix( deduped_18_1, deduped_28_1 );
    deduped_14_1 := deduped_18_1 * deduped_22_1;
    deduped_13_1 := HomalgIdentityMatrix( deduped_17_1, deduped_28_1 );
    deduped_5_1 := KroneckerMat( TransposedMatrix( deduped_10_1 ), KroneckerMat( KroneckerMat( deduped_13_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_14_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_22_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_22_1 ) + 1);
                        end ) ), deduped_14_1 ), deduped_14_1, deduped_14_1, deduped_28_1 ) ), deduped_19_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( deduped_13_1, deduped_20_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_17_1 ], function ( i_2 )
                                  local deduped_1_2;
                                  deduped_1_2 := (i_2 - 1);
                                  return (REM_INT( deduped_1_2, deduped_24_1 ) * deduped_22_1 + QUO_INT( deduped_1_2, deduped_24_1 ) + 1);
                              end ) ), deduped_17_1 ), deduped_17_1, deduped_17_1, deduped_28_1 ), deduped_20_1 ) * KroneckerMat( deduped_21_1, ConvertMatrixToColumn( deduped_20_1 ) )), deduped_15_1 ), deduped_19_1 ) * KroneckerMat( deduped_21_1, (KroneckerMat( deduped_15_1, deduped_19_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                              local deduped_1_2;
                              deduped_1_2 := (i_2 - 1);
                              return (REM_INT( deduped_1_2, deduped_25_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_25_1 ) + 1);
                          end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_28_1 ), deduped_19_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_25_1, deduped_28_1 ), ConvertMatrixToColumn( deduped_19_1 ) )) ) );
    morphism_attr_26_1 := deduped_5_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_27_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_27_1 ) ), UnderlyingMatrix, morphism_attr_27_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_26_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_26_1 ) ), UnderlyingMatrix, morphism_attr_26_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_6_1 ), Range( deduped_4_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_1 ) * UnderlyingMatrix( deduped_4_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_28_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 14363 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, morphism_attr_27_1, morphism_attr_28_1, deduped_29_1;
    deduped_29_1 := UnderlyingRing( cat_1 );
    deduped_26_1 := Dimension( list_1[4] );
    deduped_25_1 := Dimension( list_1[2] );
    deduped_24_1 := Dimension( list_1[3] );
    deduped_23_1 := Dimension( list_1[1] );
    deduped_19_1 := deduped_24_1 * deduped_26_1;
    deduped_18_1 := deduped_23_1 * deduped_25_1;
    deduped_17_1 := deduped_23_1 * deduped_24_1;
    deduped_16_1 := deduped_17_1 * deduped_17_1;
    deduped_15_1 := HomalgIdentityMatrix( deduped_17_1, deduped_29_1 );
    deduped_14_1 := deduped_19_1;
    deduped_13_1 := deduped_18_1;
    deduped_12_1 := deduped_13_1 * deduped_14_1;
    deduped_11_1 := deduped_17_1 * deduped_12_1;
    deduped_10_1 := HomalgIdentityMatrix( deduped_12_1, deduped_29_1 );
    deduped_8_1 := KroneckerMat( ConvertMatrixToRow( deduped_15_1 ), deduped_10_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_17_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_17_1 ) + 1);
                    end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_29_1 ), deduped_10_1 ) * KroneckerMat( deduped_15_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_11_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                  end ) ), deduped_11_1 ), deduped_11_1, deduped_11_1, deduped_29_1 ) );
    morphism_attr_28_1 := deduped_8_1;
    deduped_22_1 := HomalgIdentityMatrix( deduped_25_1, deduped_29_1 );
    deduped_21_1 := HomalgIdentityMatrix( deduped_23_1, deduped_29_1 );
    deduped_20_1 := HomalgIdentityMatrix( deduped_24_1, deduped_29_1 );
    deduped_9_1 := deduped_14_1 * deduped_23_1;
    deduped_7_1 := KroneckerMat( KroneckerMat( HomalgIdentityMatrix( deduped_13_1, deduped_29_1 ), HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                          local deduped_1_2;
                          deduped_1_2 := (i_2 - 1);
                          return (REM_INT( deduped_1_2, deduped_23_1 ) * deduped_14_1 + QUO_INT( deduped_1_2, deduped_23_1 ) + 1);
                      end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_29_1 ) ), deduped_20_1 ) * KroneckerMat( KroneckerMat( (KroneckerMat( HomalgIdentityMatrix( deduped_18_1, deduped_29_1 ), deduped_21_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_18_1 ], function ( i_2 )
                                local deduped_1_2;
                                deduped_1_2 := (i_2 - 1);
                                return (REM_INT( deduped_1_2, deduped_25_1 ) * deduped_23_1 + QUO_INT( deduped_1_2, deduped_25_1 ) + 1);
                            end ) ), deduped_18_1 ), deduped_18_1, deduped_18_1, deduped_29_1 ), deduped_21_1 ) * KroneckerMat( deduped_22_1, ConvertMatrixToColumn( deduped_21_1 ) )), HomalgIdentityMatrix( deduped_14_1, deduped_29_1 ) ), deduped_20_1 ) * KroneckerMat( deduped_22_1, (KroneckerMat( HomalgIdentityMatrix( deduped_19_1, deduped_29_1 ), deduped_20_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_19_1 ], function ( i_2 )
                            local deduped_1_2;
                            deduped_1_2 := (i_2 - 1);
                            return (REM_INT( deduped_1_2, deduped_26_1 ) * deduped_24_1 + QUO_INT( deduped_1_2, deduped_26_1 ) + 1);
                        end ) ), deduped_19_1 ), deduped_19_1, deduped_19_1, deduped_29_1 ), deduped_20_1 ) * KroneckerMat( HomalgIdentityMatrix( deduped_26_1, deduped_29_1 ), ConvertMatrixToColumn( deduped_20_1 ) )) );
    deduped_5_1 := KroneckerMat( TransposedMatrix( deduped_15_1 ), deduped_7_1 );
    morphism_attr_27_1 := deduped_5_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_28_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_28_1 ) ), UnderlyingMatrix, morphism_attr_28_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_27_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_27_1 ) ), UnderlyingMatrix, morphism_attr_27_1 );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_6_1 ), Range( deduped_4_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_1 ) * UnderlyingMatrix( deduped_4_1 ) );
    deduped_2_1 := Range( deduped_3_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_2_1 ), deduped_29_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_3_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_3_1 ) ) );
end
########
        
    , 13156 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductInternalHomCompatibilityMorphismWithGivenObjects( cat,
        
########
function ( cat_1, source_1, list_1, range_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, morphism_attr_23_1, morphism_attr_24_1, hoisted_25_1, hoisted_26_1, hoisted_27_1, hoisted_28_1, hoisted_29_1, hoisted_30_1, hoisted_31_1, hoisted_32_1, hoisted_33_1, hoisted_34_1, hoisted_35_1, hoisted_36_1, deduped_37_1;
    deduped_37_1 := UnderlyingRing( cat_1 );
    deduped_22_1 := list_1[2];
    deduped_19_1 := Dimension( deduped_22_1 );
    hoisted_36_1 := HomalgIdentityMatrix( deduped_19_1, deduped_37_1 );
    deduped_17_1 := Dimension( list_1[1] );
    hoisted_35_1 := HomalgIdentityMatrix( deduped_17_1, deduped_37_1 );
    deduped_21_1 := list_1[3];
    deduped_18_1 := Dimension( deduped_21_1 );
    hoisted_34_1 := HomalgIdentityMatrix( deduped_18_1, deduped_37_1 );
    deduped_20_1 := Dimension( list_1[4] );
    deduped_16_1 := deduped_18_1 * deduped_20_1;
    deduped_14_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_16_1 );
    deduped_12_1 := Dimension( deduped_14_1 );
    hoisted_33_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_12_1 * deduped_17_1 );
    hoisted_32_1 := HomalgIdentityMatrix( deduped_20_1, deduped_37_1 );
    hoisted_31_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_16_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, deduped_20_1 ) * deduped_18_1 + QUO_INT( deduped_1_2, deduped_20_1 ) + 1;
              end ) ), deduped_16_1 ), deduped_16_1, deduped_16_1, deduped_37_1 );
    hoisted_30_1 := HomalgIdentityMatrix( deduped_16_1, deduped_37_1 );
    deduped_15_1 := deduped_17_1 * deduped_19_1;
    hoisted_29_1 := HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_15_1 ], function ( i_2 )
                  local deduped_1_2;
                  deduped_1_2 := i_2 - 1;
                  return REM_INT( deduped_1_2, deduped_19_1 ) * deduped_17_1 + QUO_INT( deduped_1_2, deduped_19_1 ) + 1;
              end ) ), deduped_15_1 ), deduped_15_1, deduped_15_1, deduped_37_1 );
    hoisted_28_1 := HomalgIdentityMatrix( deduped_15_1, deduped_37_1 );
    deduped_13_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, deduped_15_1 );
    deduped_11_1 := Dimension( deduped_13_1 );
    hoisted_27_1 := HomalgIdentityMatrix( deduped_11_1, deduped_37_1 );
    hoisted_26_1 := deduped_37_1;
    hoisted_25_1 := HomalgIdentityMatrix( deduped_12_1, deduped_37_1 );
    deduped_10_1 := deduped_17_1 * deduped_18_1;
    deduped_9_1 := deduped_10_1 * deduped_10_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_10_1, deduped_37_1 );
    deduped_7_1 := deduped_11_1 * deduped_12_1;
    deduped_6_1 := deduped_10_1 * deduped_7_1;
    deduped_5_1 := HomalgIdentityMatrix( deduped_7_1, deduped_37_1 );
    deduped_4_1 := KroneckerMat( ConvertMatrixToRow( deduped_8_1 ), deduped_5_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_37_1 ), deduped_5_1 ) * KroneckerMat( deduped_8_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_7_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_7_1 ) + 1);
                  end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_37_1 ) );
    morphism_attr_24_1 := deduped_4_1;
    deduped_2_1 := KroneckerMat( TransposedMatrix( deduped_8_1 ), UnderlyingMatrix( function (  )
                local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, deduped_14_2, morphism_attr_15_2;
                deduped_14_2 := hoisted_36_1;
                deduped_13_2 := hoisted_35_1;
                deduped_12_2 := hoisted_34_1;
                deduped_11_2 := deduped_12_2;
                deduped_10_2 := hoisted_33_1;
                deduped_9_2 := Dimension( deduped_10_2 );
                deduped_8_2 := KroneckerMat( hoisted_30_1, deduped_12_2 ) * KroneckerMat( hoisted_31_1, deduped_12_2 ) * KroneckerMat( hoisted_32_1, ConvertMatrixToColumn( deduped_12_2 ) );
                deduped_7_2 := KroneckerMat( hoisted_28_1, deduped_13_2 ) * KroneckerMat( hoisted_29_1, deduped_13_2 ) * KroneckerMat( deduped_14_2, ConvertMatrixToColumn( deduped_13_2 ) );
                deduped_6_2 := KroneckerMat( hoisted_27_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := i_3 - 1;
                                return REM_INT( deduped_1_3, deduped_17_1 ) * deduped_12_1 + QUO_INT( deduped_1_3, deduped_17_1 ) + 1;
                            end ) ), deduped_9_2 ), deduped_9_2, deduped_9_2, hoisted_26_1 ) );
                deduped_5_2 := KroneckerMat( deduped_14_2, deduped_8_2 );
                deduped_4_2 := KroneckerMat( deduped_7_2, hoisted_25_1 );
                deduped_3_2 := KroneckerMat( deduped_6_2, deduped_11_2 );
                deduped_2_2 := KroneckerMat( deduped_4_2, deduped_11_2 );
                deduped_1_2 := function ( alpha_3, beta_3 )
                        return alpha_3 * beta_3;
                    end( function ( alpha_3, beta_3 )
                          return alpha_3 * beta_3;
                      end( deduped_3_2, deduped_2_2 ), deduped_5_2 );
                morphism_attr_15_2 := deduped_1_2;
                return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                       ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberRows( morphism_attr_15_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                         ), cat_1, Dimension, NumberColumns( morphism_attr_15_2 ) ), UnderlyingMatrix, morphism_attr_15_2 );
            end(  ) ) );
    morphism_attr_23_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_23_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_23_1 ) ), UnderlyingMatrix, morphism_attr_23_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 12953 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductOnMorphisms( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := KroneckerMat( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 301 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, s_1, r_1, UnderlyingMatrix, KroneckerMat( UnderlyingMatrix( alpha_1 ), UnderlyingMatrix( beta_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Dimension( arg2_1 ) * Dimension( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductToInternalCoHomAdjunctionMap( cat,
        
########
function ( cat_1, c_1, b_1, g_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, morphism_attr_11_1, morphism_attr_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( b_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_13_1 );
    deduped_4_1 := KroneckerMat( TransposedMatrix( deduped_5_1 ), UnderlyingMatrix( g_1 ) );
    morphism_attr_12_1 := deduped_4_1;
    deduped_10_1 := Dimension( c_1 );
    deduped_8_1 := HomalgIdentityMatrix( deduped_10_1, deduped_13_1 );
    deduped_7_1 := deduped_9_1 * deduped_9_1;
    deduped_6_1 := deduped_10_1 * deduped_9_1;
    deduped_2_1 := KroneckerMat( deduped_5_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_6_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_10_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                    end ) ), deduped_6_1 ), deduped_6_1, deduped_6_1, deduped_13_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_13_1 ), deduped_8_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_5_1 ), deduped_8_1 );
    morphism_attr_11_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_12_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_12_1 ) ), UnderlyingMatrix, morphism_attr_12_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_11_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_11_1 ) ), UnderlyingMatrix, morphism_attr_11_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 4822 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorProductToInternalHomAdjunctionMap( cat,
        
########
function ( cat_1, a_1, b_1, f_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, morphism_attr_11_1, morphism_attr_12_1, deduped_13_1;
    deduped_13_1 := UnderlyingRing( cat_1 );
    deduped_9_1 := Dimension( b_1 );
    deduped_5_1 := HomalgIdentityMatrix( deduped_9_1, deduped_13_1 );
    deduped_4_1 := KroneckerMat( TransposedMatrix( deduped_5_1 ), UnderlyingMatrix( f_1 ) );
    morphism_attr_12_1 := deduped_4_1;
    deduped_10_1 := Dimension( a_1 );
    deduped_8_1 := deduped_9_1 * deduped_10_1;
    deduped_7_1 := deduped_9_1 * deduped_9_1;
    deduped_6_1 := HomalgIdentityMatrix( deduped_10_1, deduped_13_1 );
    deduped_2_1 := KroneckerMat( ConvertMatrixToRow( deduped_5_1 ), deduped_6_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_7_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_9_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_9_1 ) + 1);
                    end ) ), deduped_7_1 ), deduped_7_1, deduped_7_1, deduped_13_1 ), deduped_6_1 ) * KroneckerMat( deduped_5_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_10_1 ) * deduped_9_1 + QUO_INT( deduped_1_2, deduped_10_1 ) + 1);
                  end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_13_1 ) );
    morphism_attr_11_1 := deduped_2_1;
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_12_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_12_1 ) ), UnderlyingMatrix, morphism_attr_12_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_11_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_11_1 ) ), UnderlyingMatrix, morphism_attr_11_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 4822 : IsPrecompiledDerivation := true );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 1 );
end
########
        
    , 100 );
    
    ##
    AddTerminalObject( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return deduped_1_1;
end
########
        
    , 202 : IsPrecompiledDerivation := true );
    
    ##
    AddTerminalObjectFunctorial( cat,
        
########
function ( cat_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, deduped_1_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddTerminalObjectFunctorialWithGivenTerminalObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( Pp_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 102 : IsPrecompiledDerivation := true );
    
    ##
    AddTraceMap( cat,
        
########
function ( cat_1, alpha_1 )
    local hoisted_1_1, hoisted_2_1, hoisted_3_1, hoisted_4_1, deduped_5_1;
    deduped_5_1 := UnderlyingRing( cat_1 );
    hoisted_4_1 := HomalgIdentityMatrix( 1, deduped_5_1 );
    hoisted_3_1 := Source( alpha_1 );
    hoisted_2_1 := UnderlyingMatrix( alpha_1 );
    hoisted_1_1 := deduped_5_1;
    return function (  )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2, deduped_9_2, deduped_10_2, deduped_11_2, deduped_12_2, deduped_13_2, morphism_attr_14_2, morphism_attr_15_2, morphism_attr_16_2;
            deduped_12_2 := hoisted_3_1;
            deduped_11_2 := Dimension( deduped_12_2 );
            deduped_8_2 := HomalgIdentityMatrix( deduped_11_2, hoisted_1_1 );
            deduped_5_2 := KroneckerMat( TransposedMatrix( deduped_8_2 ), deduped_8_2 * hoisted_2_1 );
            morphism_attr_16_2 := deduped_5_2;
            deduped_13_2 := hoisted_4_1;
            deduped_10_2 := deduped_11_2 * 1;
            deduped_9_2 := deduped_11_2 * deduped_11_2;
            deduped_3_2 := KroneckerMat( ConvertMatrixToRow( deduped_8_2 ), deduped_13_2 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_2 ], function ( i_3 )
                                local deduped_1_3;
                                deduped_1_3 := (i_3 - 1);
                                return (REM_INT( deduped_1_3, deduped_11_2 ) * deduped_11_2 + QUO_INT( deduped_1_3, deduped_11_2 ) + 1);
                            end ) ), deduped_9_2 ), deduped_9_2, deduped_9_2, hoisted_1_1 ), deduped_13_2 ) * KroneckerMat( deduped_8_2, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_2 ], function ( i_3 )
                              local deduped_1_3;
                              deduped_1_3 := (i_3 - 1);
                              return (REM_INT( deduped_1_3, 1 ) * deduped_11_2 + QUO_INT( deduped_1_3, 1 ) + 1);
                          end ) ), deduped_10_2 ), deduped_10_2, deduped_10_2, hoisted_1_1 ) );
            morphism_attr_15_2 := deduped_3_2;
            deduped_7_2 := ConvertMatrixToColumn( deduped_8_2 );
            deduped_6_2 := ObjectifyObjectForCAPWithAttributes( rec(
                   ), cat_1, Dimension, deduped_9_2 );
            deduped_4_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_16_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_16_2 ) ), UnderlyingMatrix, morphism_attr_16_2 );
            deduped_2_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_15_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_15_2 ) ), UnderlyingMatrix, morphism_attr_15_2 );
            deduped_1_2 := function ( alpha_3, beta_3 )
                    return alpha_3 * beta_3;
                end( function ( alpha_3, beta_3 )
                      return alpha_3 * beta_3;
                  end( UnderlyingMatrix( deduped_2_2 ) * UnderlyingMatrix( deduped_4_2 ), HomalgIdentityMatrix( Dimension( deduped_6_2 ), hoisted_1_1 ) ), deduped_7_2 );
            morphism_attr_14_2 := deduped_1_2;
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberRows( morphism_attr_14_2 ) ), ObjectifyObjectForCAPWithAttributes( rec(
                     ), cat_1, Dimension, NumberColumns( morphism_attr_14_2 ) ), UnderlyingMatrix, morphism_attr_14_2 );
        end(  );
end
########
        
    , 5828 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := UnionOfRows( deduped_6_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    morphism_attr_5_1 := deduped_4_1;
    deduped_3_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_5_1 ) ), T_1, UnderlyingMatrix, morphism_attr_5_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_3_1, deduped_3_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_3_1 ), deduped_6_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_2_1 ) );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromCoproductWithGivenCoproduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := UnionOfRows( deduped_6_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    morphism_attr_5_1 := deduped_4_1;
    deduped_3_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_5_1 ) ), T_1, UnderlyingMatrix, morphism_attr_5_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_3_1, deduped_3_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_3_1 ), deduped_6_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_2_1 ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromImage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1;
    deduped_7_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_10_1 := deduped_7_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_4_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_9_1 := deduped_4_1;
    deduped_8_1 := tau_1[2];
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_9_1 ) ), Source( deduped_6_1 ), UnderlyingMatrix, morphism_attr_9_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_8_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_8_1 ) ) );
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromImageWithGivenImageObject( cat,
        
########
function ( cat_1, alpha_1, tau_1, I_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1;
    deduped_7_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_10_1 := deduped_7_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_10_1 ) ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_4_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_9_1 := deduped_4_1;
    deduped_8_1 := tau_1[2];
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_9_1 ) ), Source( deduped_6_1 ), UnderlyingMatrix, morphism_attr_9_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_3_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_3_1 ) * UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Source( deduped_8_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_1_1 ), UnderlyingMatrix( deduped_8_1 ) ) );
end
########
        
    , 705 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromInitialObject( cat,
        
########
function ( cat_1, T_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_1_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( deduped_1_1 ), Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromInitialObjectWithGivenInitialObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromPushout( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, morphism_attr_23_1, morphism_attr_24_1, morphism_attr_25_1, hoisted_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    hoisted_26_1 := deduped_27_1;
    deduped_22_1 := Length( morphisms_1 );
    deduped_21_1 := List( morphisms_1, Range );
    deduped_19_1 := [ 1 .. deduped_22_1 ];
    deduped_18_1 := Length( deduped_21_1 );
    deduped_17_1 := [ 1 .. deduped_22_1 - 1 ];
    deduped_15_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_21_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_14_1 := Dimension( deduped_15_1 );
    deduped_12_1 := List( deduped_19_1, function ( logic_new_func_x_2 )
            return function ( s_3 )
                    return UnderlyingMatrix( s_3 );
                end( function ( i_3 )
                      local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3;
                      deduped_4_3 := morphisms_1[i_3];
                      deduped_3_3 := deduped_21_1[i_3];
                      deduped_2_3 := Dimension( deduped_3_3 );
                      deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, deduped_3_3, deduped_15_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_3, Sum( deduped_21_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_26_1 ), HomalgIdentityMatrix( deduped_2_3, hoisted_26_1 ), HomalgZeroMatrix( deduped_2_3, Sum( deduped_21_1{[ i_3 + 1 .. deduped_18_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), hoisted_26_1 ) ) );
                      return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, Source( deduped_4_3 ), Range( deduped_1_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_3 ) * UnderlyingMatrix( deduped_1_3 ) );
                  end( logic_new_func_x_2 ) );
        end );
    deduped_10_1 := UnionOfRows( deduped_27_1, deduped_14_1, deduped_12_1{deduped_17_1} );
    morphism_attr_25_1 := deduped_10_1;
    deduped_20_1 := [ 2 .. deduped_22_1 ];
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_25_1 ) ), deduped_15_1, UnderlyingMatrix, morphism_attr_25_1 );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_8_1 ), Range( deduped_8_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_8_1 ) + -1 * UnionOfRows( deduped_27_1, deduped_14_1, deduped_12_1{deduped_20_1} ) );
    deduped_5_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_24_1 := deduped_5_1;
    deduped_16_1 := UnionOfRows( deduped_27_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    morphism_attr_23_1 := deduped_16_1;
    deduped_13_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_23_1 ) ), T_1, UnderlyingMatrix, morphism_attr_23_1 );
    deduped_11_1 := List( deduped_19_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := morphisms_1[logic_new_func_x_2];
            deduped_3_2 := deduped_21_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_3_2, deduped_15_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_2, Sum( deduped_21_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_26_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_26_1 ), HomalgZeroMatrix( deduped_2_2, Sum( deduped_21_1{[ logic_new_func_x_2 + 1 .. deduped_18_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_26_1 ) ) );
            return UnderlyingMatrix( deduped_4_2 ) * UnderlyingMatrix( deduped_1_2 );
        end );
    deduped_9_1 := UnionOfRows( deduped_27_1, deduped_14_1, deduped_11_1{deduped_17_1} );
    deduped_7_1 := deduped_9_1 + -1 * UnionOfRows( deduped_27_1, deduped_14_1, deduped_11_1{deduped_20_1} );
    deduped_4_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_6_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_4_1, deduped_4_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_4_1 ), deduped_27_1 ) );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_3_1 ), Range( deduped_13_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_3_1 ), UnderlyingMatrix( deduped_13_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 4117 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromPushoutWithGivenPushout( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, morphism_attr_22_1, morphism_attr_23_1, morphism_attr_24_1, hoisted_25_1, deduped_26_1;
    deduped_26_1 := UnderlyingRing( cat_1 );
    hoisted_25_1 := deduped_26_1;
    deduped_21_1 := Length( morphisms_1 );
    deduped_20_1 := List( morphisms_1, Range );
    deduped_18_1 := [ 1 .. deduped_21_1 ];
    deduped_17_1 := Length( deduped_20_1 );
    deduped_16_1 := [ 1 .. deduped_21_1 - 1 ];
    deduped_14_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_20_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_13_1 := Dimension( deduped_14_1 );
    deduped_10_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := morphisms_1[logic_new_func_x_2];
            deduped_3_2 := deduped_20_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_3_2, deduped_14_1, UnderlyingMatrix, UnionOfColumns( HomalgZeroMatrix( deduped_2_2, Sum( deduped_20_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_25_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_25_1 ), HomalgZeroMatrix( deduped_2_2, Sum( deduped_20_1{[ logic_new_func_x_2 + 1 .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_25_1 ) ) );
            return UnderlyingMatrix( deduped_4_2 ) * UnderlyingMatrix( deduped_1_2 );
        end );
    deduped_9_1 := UnionOfRows( deduped_26_1, deduped_13_1, deduped_10_1{deduped_16_1} );
    morphism_attr_24_1 := deduped_9_1;
    deduped_19_1 := [ 2 .. deduped_21_1 ];
    deduped_7_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), deduped_14_1, UnderlyingMatrix, morphism_attr_24_1 );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_7_1 ), Range( deduped_7_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_7_1 ) + -1 * UnionOfRows( deduped_26_1, deduped_13_1, deduped_10_1{deduped_19_1} ) );
    deduped_3_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_23_1 := deduped_3_1;
    deduped_15_1 := UnionOfRows( deduped_26_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    morphism_attr_22_1 := deduped_15_1;
    deduped_12_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_22_1 ) ), T_1, UnderlyingMatrix, morphism_attr_22_1 );
    deduped_11_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_20_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnderlyingMatrix( morphisms_1[logic_new_func_x_2] ) * UnionOfColumns( HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_25_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_25_1 ), HomalgZeroMatrix( deduped_1_2, Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), hoisted_25_1 ) );
        end );
    deduped_8_1 := UnionOfRows( deduped_26_1, deduped_13_1, deduped_11_1{deduped_16_1} ) + -1 * UnionOfRows( deduped_26_1, deduped_13_1, deduped_11_1{deduped_19_1} );
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_8_1 ) - RowRankOfMatrix( deduped_8_1 ) );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_6_1 ), deduped_26_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_5_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_23_1 ) ), UnderlyingMatrix, morphism_attr_23_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_2_1 ), Range( deduped_12_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_2_1 ), UnderlyingMatrix( deduped_12_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 4118 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismFromZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, HomalgZeroMatrix( 0, Dimension( T_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoCoimage( cat,
        
########
function ( cat_1, alpha_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1;
    deduped_7_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_10_1 := deduped_7_1;
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_10_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_9_1 := deduped_4_1;
    deduped_8_1 := tau_1[1];
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_6_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_5_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_9_1 ) ), UnderlyingMatrix, morphism_attr_9_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_8_1 ), Range( deduped_1_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_8_1 ), UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 704 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoCoimageWithGivenCoimageObject( cat,
        
########
function ( cat_1, alpha_1, tau_1, C_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, morphism_attr_9_1, morphism_attr_10_1;
    deduped_7_1 := SyzygiesOfRows( UnderlyingMatrix( alpha_1 ) );
    morphism_attr_10_1 := deduped_7_1;
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_10_1 ) ), Source( alpha_1 ), UnderlyingMatrix, morphism_attr_10_1 );
    deduped_4_1 := SyzygiesOfColumns( UnderlyingMatrix( deduped_5_1 ) );
    morphism_attr_9_1 := deduped_4_1;
    deduped_8_1 := tau_1[1];
    deduped_6_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberColumns( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_6_1, deduped_6_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_6_1 ), UnderlyingRing( cat_1 ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_5_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_9_1 ) ), UnderlyingMatrix, morphism_attr_9_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_3_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( deduped_8_1 ), Range( deduped_1_1 ), UnderlyingMatrix, LeftDivide( UnderlyingMatrix( deduped_8_1 ), UnderlyingMatrix( deduped_1_1 ) ) );
end
########
        
    , 705 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := UnionOfColumns( deduped_6_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    morphism_attr_5_1 := deduped_4_1;
    deduped_3_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_5_1 ) ), UnderlyingMatrix, morphism_attr_5_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_3_1, deduped_3_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_3_1 ), deduped_6_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 503 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoDirectProductWithGivenDirectProduct( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, morphism_attr_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_4_1 := UnionOfColumns( deduped_6_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    morphism_attr_5_1 := deduped_4_1;
    deduped_3_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( objects_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_5_1 ) ), UnderlyingMatrix, morphism_attr_5_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_3_1, deduped_3_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_3_1 ), deduped_6_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 504 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( s_2 )
                return UnderlyingMatrix( s_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismIntoFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, morphism_attr_23_1, morphism_attr_24_1, morphism_attr_25_1, hoisted_26_1, deduped_27_1;
    deduped_27_1 := UnderlyingRing( cat_1 );
    hoisted_26_1 := deduped_27_1;
    deduped_22_1 := Length( morphisms_1 );
    deduped_21_1 := List( morphisms_1, Source );
    deduped_19_1 := [ 1 .. deduped_22_1 ];
    deduped_18_1 := Length( deduped_21_1 );
    deduped_17_1 := [ 1 .. deduped_22_1 - 1 ];
    deduped_15_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_21_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_14_1 := Dimension( deduped_15_1 );
    deduped_11_1 := List( deduped_19_1, function ( logic_new_func_x_2 )
            return function ( s_3 )
                    return UnderlyingMatrix( s_3 );
                end( function ( i_3 )
                      local deduped_1_3, deduped_2_3, deduped_3_3, deduped_4_3;
                      deduped_4_3 := morphisms_1[i_3];
                      deduped_3_3 := deduped_21_1[i_3];
                      deduped_2_3 := Dimension( deduped_3_3 );
                      deduped_1_3 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, deduped_15_1, deduped_3_3, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_21_1{[ 1 .. i_3 - 1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_2_3, hoisted_26_1 ), HomalgIdentityMatrix( deduped_2_3, hoisted_26_1 ), HomalgZeroMatrix( Sum( deduped_21_1{[ i_3 + 1 .. deduped_18_1 ]}, function ( c_4 )
                                    return Dimension( c_4 );
                                end ), deduped_2_3, hoisted_26_1 ) ) );
                      return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                             ), cat_1, Source( deduped_1_3 ), Range( deduped_4_3 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_3 ) * UnderlyingMatrix( deduped_4_3 ) );
                  end( logic_new_func_x_2 ) );
        end );
    deduped_9_1 := UnionOfColumns( deduped_27_1, deduped_14_1, deduped_11_1{deduped_17_1} );
    morphism_attr_25_1 := deduped_9_1;
    deduped_20_1 := [ 2 .. deduped_22_1 ];
    deduped_8_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_15_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_25_1 ) ), UnderlyingMatrix, morphism_attr_25_1 );
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_8_1 ), Range( deduped_8_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_8_1 ) + -1 * UnionOfColumns( deduped_27_1, deduped_14_1, deduped_11_1{deduped_20_1} ) );
    deduped_4_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_6_1 ) );
    morphism_attr_24_1 := deduped_4_1;
    deduped_16_1 := UnionOfColumns( deduped_27_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    morphism_attr_23_1 := deduped_16_1;
    deduped_13_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_23_1 ) ), UnderlyingMatrix, morphism_attr_23_1 );
    deduped_12_1 := List( deduped_19_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := morphisms_1[logic_new_func_x_2];
            deduped_3_2 := deduped_21_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_15_1, deduped_3_2, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_21_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_26_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_26_1 ), HomalgZeroMatrix( Sum( deduped_21_1{[ logic_new_func_x_2 + 1 .. deduped_18_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_26_1 ) ) );
            return UnderlyingMatrix( deduped_1_2 ) * UnderlyingMatrix( deduped_4_2 );
        end );
    deduped_10_1 := UnionOfColumns( deduped_27_1, deduped_14_1, deduped_12_1{deduped_17_1} );
    deduped_7_1 := deduped_10_1 + -1 * UnionOfColumns( deduped_27_1, deduped_14_1, deduped_12_1{deduped_20_1} );
    deduped_5_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_7_1 ) - RowRankOfMatrix( deduped_7_1 ) );
    deduped_3_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_5_1, deduped_5_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_5_1 ), deduped_27_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_24_1 ) ), Source( deduped_6_1 ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_13_1 ), Source( deduped_2_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_13_1 ), UnderlyingMatrix( deduped_2_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_3_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_3_1 ) );
end
########
        
    , 4117 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoFiberProductWithGivenFiberProduct( cat,
        
########
function ( cat_1, morphisms_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, morphism_attr_22_1, morphism_attr_23_1, morphism_attr_24_1, hoisted_25_1, deduped_26_1;
    deduped_26_1 := UnderlyingRing( cat_1 );
    hoisted_25_1 := deduped_26_1;
    deduped_21_1 := Length( morphisms_1 );
    deduped_20_1 := List( morphisms_1, Source );
    deduped_18_1 := [ 1 .. deduped_21_1 ];
    deduped_17_1 := Length( deduped_20_1 );
    deduped_16_1 := [ 1 .. deduped_21_1 - 1 ];
    deduped_14_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( deduped_20_1, function ( object_2 )
                return Dimension( object_2 );
            end ) ) );
    deduped_13_1 := Dimension( deduped_14_1 );
    deduped_10_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2, deduped_3_2, deduped_4_2;
            deduped_4_2 := morphisms_1[logic_new_func_x_2];
            deduped_3_2 := deduped_20_1[logic_new_func_x_2];
            deduped_2_2 := Dimension( deduped_3_2 );
            deduped_1_2 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
                   ), cat_1, deduped_14_1, deduped_3_2, UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_20_1{[ 1 .. logic_new_func_x_2 - 1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_25_1 ), HomalgIdentityMatrix( deduped_2_2, hoisted_25_1 ), HomalgZeroMatrix( Sum( deduped_20_1{[ logic_new_func_x_2 + 1 .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_2_2, hoisted_25_1 ) ) );
            return UnderlyingMatrix( deduped_1_2 ) * UnderlyingMatrix( deduped_4_2 );
        end );
    deduped_8_1 := UnionOfColumns( deduped_26_1, deduped_13_1, deduped_10_1{deduped_16_1} );
    morphism_attr_24_1 := deduped_8_1;
    deduped_19_1 := [ 2 .. deduped_21_1 ];
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_14_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_24_1 ) ), UnderlyingMatrix, morphism_attr_24_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_6_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_1 ) + -1 * UnionOfColumns( deduped_26_1, deduped_13_1, deduped_10_1{deduped_19_1} ) );
    deduped_3_1 := SyzygiesOfRows( UnderlyingMatrix( deduped_4_1 ) );
    morphism_attr_23_1 := deduped_3_1;
    deduped_15_1 := UnionOfColumns( deduped_26_1, Dimension( T_1 ), List( tau_1, function ( s_2 )
              return UnderlyingMatrix( s_2 );
          end ) );
    morphism_attr_22_1 := deduped_15_1;
    deduped_12_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_22_1 ) ), UnderlyingMatrix, morphism_attr_22_1 );
    deduped_11_1 := List( deduped_18_1, function ( logic_new_func_x_2 )
            local deduped_1_2, deduped_2_2;
            deduped_2_2 := deduped_20_1[logic_new_func_x_2];
            deduped_1_2 := Dimension( deduped_2_2 );
            return UnionOfRows( HomalgZeroMatrix( Sum( deduped_20_1{[ 1 .. (logic_new_func_x_2 - 1) ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_25_1 ), HomalgIdentityMatrix( deduped_1_2, hoisted_25_1 ), HomalgZeroMatrix( Sum( deduped_20_1{[ (logic_new_func_x_2 + 1) .. deduped_17_1 ]}, function ( c_3 )
                          return Dimension( c_3 );
                      end ), deduped_1_2, hoisted_25_1 ) ) * UnderlyingMatrix( morphisms_1[logic_new_func_x_2] );
        end );
    deduped_9_1 := UnionOfColumns( deduped_26_1, deduped_13_1, deduped_11_1{deduped_16_1} ) + -1 * UnionOfColumns( deduped_26_1, deduped_13_1, deduped_11_1{deduped_19_1} );
    deduped_7_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, NumberRows( deduped_9_1 ) - RowRankOfMatrix( deduped_9_1 ) );
    deduped_5_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_7_1, deduped_7_1, UnderlyingMatrix, HomalgIdentityMatrix( Dimension( deduped_7_1 ), deduped_26_1 ) );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_23_1 ) ), Source( deduped_4_1 ), UnderlyingMatrix, morphism_attr_23_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_12_1 ), Source( deduped_2_1 ), UnderlyingMatrix, RightDivide( UnderlyingMatrix( deduped_12_1 ), UnderlyingMatrix( deduped_2_1 ) ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_5_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_5_1 ) );
end
########
        
    , 4118 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoTerminalObject( cat,
        
########
function ( cat_1, T_1 )
    local deduped_1_1;
    deduped_1_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, deduped_1_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 303 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoTerminalObjectWithGivenTerminalObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), Dimension( P_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoZeroObject( cat,
        
########
function ( cat_1, T_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, 0 ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalMorphismIntoZeroObjectWithGivenZeroObject( cat,
        
########
function ( cat_1, T_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( T_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddUniversalPropertyOfCoDual( cat,
        
########
function ( cat_1, t_1, a_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, morphism_attr_13_1, morphism_attr_14_1, deduped_15_1;
    deduped_15_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := Dimension( a_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_11_1, deduped_15_1 );
    deduped_5_1 := KroneckerMat( TransposedMatrix( deduped_7_1 ), UnderlyingMatrix( alpha_1 ) );
    morphism_attr_14_1 := deduped_5_1;
    deduped_12_1 := Dimension( t_1 );
    deduped_10_1 := HomalgIdentityMatrix( deduped_12_1, deduped_15_1 );
    deduped_9_1 := deduped_11_1 * deduped_11_1;
    deduped_8_1 := deduped_12_1 * deduped_11_1;
    deduped_3_1 := KroneckerMat( deduped_7_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_8_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_12_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                    end ) ), deduped_8_1 ), deduped_8_1, deduped_8_1, deduped_15_1 ) ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_15_1 ), deduped_10_1 ) * KroneckerMat( ConvertMatrixToColumn( deduped_7_1 ), deduped_10_1 );
    morphism_attr_13_1 := deduped_3_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, deduped_7_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_14_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_14_1 ) ), UnderlyingMatrix, morphism_attr_14_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_13_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_13_1 ) ), UnderlyingMatrix, morphism_attr_13_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_4_1 ), Range( deduped_2_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_4_1 ) * UnderlyingMatrix( deduped_2_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_6_1 ), Range( deduped_1_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_6_1 ) * UnderlyingMatrix( deduped_1_1 ) );
end
########
        
    , 5124 : IsPrecompiledDerivation := true );
    
    ##
    AddUniversalPropertyOfDual( cat,
        
########
function ( cat_1, t_1, a_1, alpha_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, morphism_attr_13_1, morphism_attr_14_1, deduped_15_1;
    deduped_15_1 := UnderlyingRing( cat_1 );
    deduped_11_1 := Dimension( a_1 );
    deduped_7_1 := HomalgIdentityMatrix( deduped_11_1, deduped_15_1 );
    deduped_5_1 := KroneckerMat( TransposedMatrix( deduped_7_1 ), UnderlyingMatrix( alpha_1 ) );
    morphism_attr_14_1 := deduped_5_1;
    deduped_12_1 := Dimension( t_1 );
    deduped_10_1 := deduped_11_1 * deduped_12_1;
    deduped_9_1 := deduped_11_1 * deduped_11_1;
    deduped_8_1 := HomalgIdentityMatrix( deduped_12_1, deduped_15_1 );
    deduped_3_1 := KroneckerMat( ConvertMatrixToRow( deduped_7_1 ), deduped_8_1 ) * KroneckerMat( HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_9_1 ], function ( i_2 )
                        local deduped_1_2;
                        deduped_1_2 := (i_2 - 1);
                        return (REM_INT( deduped_1_2, deduped_11_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_11_1 ) + 1);
                    end ) ), deduped_9_1 ), deduped_9_1, deduped_9_1, deduped_15_1 ), deduped_8_1 ) * KroneckerMat( deduped_7_1, HomalgMatrix( PermutationMat( PermList( List( [ 1 .. deduped_10_1 ], function ( i_2 )
                      local deduped_1_2;
                      deduped_1_2 := (i_2 - 1);
                      return (REM_INT( deduped_1_2, deduped_12_1 ) * deduped_11_1 + QUO_INT( deduped_1_2, deduped_12_1 ) + 1);
                  end ) ), deduped_10_1 ), deduped_10_1, deduped_10_1, deduped_15_1 ) );
    morphism_attr_13_1 := deduped_3_1;
    deduped_6_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, a_1, UnderlyingMatrix, deduped_7_1 );
    deduped_4_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_14_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_14_1 ) ), UnderlyingMatrix, morphism_attr_14_1 );
    deduped_2_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_13_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_13_1 ) ), UnderlyingMatrix, morphism_attr_13_1 );
    deduped_1_1 := ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_2_1 ), Range( deduped_4_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_2_1 ) * UnderlyingMatrix( deduped_4_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( deduped_1_1 ), Range( deduped_6_1 ), UnderlyingMatrix, UnderlyingMatrix( deduped_1_1 ) * UnderlyingMatrix( deduped_6_1 ) );
end
########
        
    , 5124 : IsPrecompiledDerivation := true );
    
    ##
    AddZeroMorphism( cat,
        
########
function ( cat_1, a_1, b_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, a_1, b_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( a_1 ), Dimension( b_1 ), UnderlyingRing( cat_1 ) ) );
end
########
        
    , 100 );
    
    ##
    AddZeroObject( cat,
        
########
function ( cat_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
end
########
        
    , 100 );
    
    ##
    AddZeroObjectFunctorial( cat,
        
########
function ( cat_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, 0 );
    deduped_1_1 := Dimension( deduped_2_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_2_1, deduped_2_1, UnderlyingMatrix, HomalgZeroMatrix( deduped_1_1, deduped_1_1, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 201 : IsPrecompiledDerivation := true );
    
    ##
    AddZeroObjectFunctorialWithGivenZeroObjects( cat,
        
########
function ( cat_1, P_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, HomalgZeroMatrix( Dimension( P_1 ), 0, UnderlyingRing( cat_1 ) ) );
end
########
        
    , 101 : IsPrecompiledDerivation := true );
    
end );

BindGlobal( "MatrixCategoryPrecompiled", function ( field )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( field )
    return MATRIX_CATEGORY( field );
end;
        
        
    
    cat := category_constructor( field : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_MatrixCategoryPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
