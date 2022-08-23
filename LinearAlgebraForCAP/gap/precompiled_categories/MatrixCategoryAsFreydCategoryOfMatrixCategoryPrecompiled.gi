# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_MatrixCategoryAsFreydCategoryOfMatrixCategoryPrecompiled", function ( cat )
    
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
    AddCokernelColift( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) ), UnderlyingMatrix( tau_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), T_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddCokernelColiftWithGivenCokernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, UnderlyingMatrix( tau_1 ) );
end
########
        
    , 100 );
    
    ##
    AddCokernelProjection( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := SyzygiesOfColumns( UnderlyingMatrix( alpha_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Range( alpha_1 ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddColiftAlongEpimorphism( cat,
        
########
function ( cat_1, epsilon_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Range( epsilon_1 );
    deduped_2_1 := Dimension( Source( epsilon_1 ) );
    deduped_1_1 := Sum( [ 0, deduped_2_1 ]{[ 1 .. 2 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, deduped_3_1, Range( tau_1 ), UnderlyingMatrix, CertainColumns( RightDivide( HomalgIdentityMatrix( Dimension( deduped_3_1 ), UnderlyingRing( cat_1 ) ), UnderlyingMatrix( epsilon_1 ) ), [ deduped_1_1 .. (deduped_1_1 - 1 + deduped_2_1) ] ) * UnderlyingMatrix( tau_1 ) );
end
########
        
    , 100 );
    
    ##
    AddDirectSum( cat,
        
########
function ( cat_1, arg2_1 )
    return ObjectifyObjectForCAPWithAttributes( rec(
           ), cat_1, Dimension, Sum( List( arg2_1, function ( logic_new_func_x_2 )
                  return Dimension( logic_new_func_x_2 );
              end ) ) - 0 );
end
########
        
    , 100 );
    
    ##
    AddDirectSumFunctorialWithGivenDirectSums( cat,
        
########
function ( cat_1, P_1, objects_1, L_1, objectsp_1, Pp_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, Pp_1, UnderlyingMatrix, DiagMat( UnderlyingRing( cat_1 ), List( L_1, function ( logic_new_func_x_2 )
                return UnderlyingMatrix( logic_new_func_x_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObject( cat,
        
########
function ( cat_1, A_1 )
    local morphism_attr_1_1;
    morphism_attr_1_1 := HomalgIdentityMatrix( Dimension( A_1 ), UnderlyingRing( cat_1 ) );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), A_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddEpimorphismFromSomeProjectiveObjectForKernelObject( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1;
    deduped_8_1 := UnderlyingRing( cat_1 );
    deduped_7_1 := [ 1 .. 2 - 1 ];
    deduped_6_1 := Dimension( Source( alpha_1 ) );
    deduped_5_1 := [ deduped_6_1, 0 ];
    deduped_4_1 := Sum( deduped_5_1 );
    deduped_3_1 := UnionOfRows( HomalgZeroMatrix( Sum( deduped_5_1{[ 1 .. 1 - 1 ]} ), deduped_6_1, deduped_8_1 ), HomalgIdentityMatrix( deduped_6_1, deduped_8_1 ), HomalgZeroMatrix( Sum( deduped_5_1{[ 1 + 1 .. 2 ]} ), deduped_6_1, deduped_8_1 ) );
    deduped_2_1 := [ deduped_3_1 * UnderlyingMatrix( alpha_1 ), UnionOfRows( HomalgZeroMatrix( Sum( deduped_5_1{deduped_7_1} ), 0, deduped_8_1 ), HomalgIdentityMatrix( 0, deduped_8_1 ), HomalgZeroMatrix( Sum( deduped_5_1{[ (2 + 1) .. 2 ]} ), 0, deduped_8_1 ) ) * HomalgZeroMatrix( 0, Dimension( Range( alpha_1 ) ), deduped_8_1 ) ];
    morphism_attr_1_1 := SyzygiesOfRows( (UnionOfColumns( deduped_8_1, deduped_4_1, deduped_2_1{deduped_7_1} ) + -1 * UnionOfColumns( deduped_8_1, deduped_4_1, deduped_2_1{[ 2 ]} )) ) * deduped_3_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberColumns( morphism_attr_1_1 ) ), UnderlyingMatrix, morphism_attr_1_1 );
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
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local hoisted_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := List( objects_1, function ( logic_new_func_x_2 )
            return Dimension( logic_new_func_x_2 );
        end );
    deduped_2_1 := deduped_3_1[k_1];
    hoisted_1_1 := deduped_4_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, objects_1[k_1], P_1, UnderlyingMatrix, LeftDivide( List( objects_1, function ( logic_new_func_x_2 )
                  return HomalgIdentityMatrix( Dimension( logic_new_func_x_2 ), hoisted_1_1 );
              end )[k_1], UnionOfColumns( HomalgZeroMatrix( deduped_2_1, Sum( deduped_3_1{[ 1 .. k_1 - 1 ]} ), deduped_4_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), HomalgZeroMatrix( deduped_2_1, Sum( deduped_3_1{[ k_1 + 1 .. Length( objects_1 ) ]} ), deduped_4_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsCongruentForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg2_1 ) + -1 * UnderlyingMatrix( arg3_1 ), HomalgZeroMatrix( 0, Dimension( Range( arg2_1 ) ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return UnderlyingMatrix( arg2_1 ) = UnderlyingMatrix( arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_5_1 := Dimension( arg3_1 );
    deduped_4_1 := Dimension( arg2_1 );
    if true and deduped_4_1 = deduped_5_1 then
        deduped_6_1 := UnderlyingRing( cat_1 );
        return HomalgZeroMatrix( 0, deduped_4_1, deduped_6_1 ) = HomalgZeroMatrix( 0, deduped_5_1, deduped_6_1 );
    else
        return false;
    fi;
    return;
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1;
    deduped_6_1 := UnderlyingRing( cat_1 );
    deduped_5_1 := UnderlyingMatrix( arg2_1 );
    deduped_4_1 := Dimension( Range( arg2_1 ) );
    deduped_3_1 := Dimension( Source( arg2_1 ) );
    if not function (  )
                 if NumberRows( deduped_5_1 ) <> deduped_3_1 then
                     return false;
                 elif NumberColumns( deduped_5_1 ) <> deduped_4_1 then
                     return false;
                 else
                     return true;
                 fi;
                 return;
             end(  ) then
        return false;
    elif not IsZero( DecideZeroRows( HomalgZeroMatrix( 0, deduped_3_1, deduped_6_1 ) * deduped_5_1, HomalgZeroMatrix( 0, deduped_4_1, deduped_6_1 ) ) ) then
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
    local deduped_3_1, deduped_4_1;
    deduped_4_1 := Dimension( arg2_1 );
    deduped_3_1 := HomalgZeroMatrix( 0, deduped_4_1, UnderlyingRing( cat_1 ) );
    if not function (  )
                 if NumberRows( deduped_3_1 ) <> 0 then
                     return false;
                 elif NumberColumns( deduped_3_1 ) <> deduped_4_1 then
                     return false;
                 else
                     return true;
                 fi;
                 return;
             end(  ) then
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
    return IsZero( DecideZeroRows( UnderlyingMatrix( arg2_1 ), HomalgZeroMatrix( 0, Dimension( Range( arg2_1 ) ), UnderlyingRing( cat_1 ) ) ) );
end
########
        
    , 100 );
    
    ##
    AddKernelEmbedding( cat,
        
########
function ( cat_1, alpha_1 )
    local morphism_attr_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1;
    deduped_21_1 := [ 2 ];
    deduped_20_1 := UnderlyingRing( cat_1 );
    deduped_19_1 := Source( alpha_1 );
    deduped_18_1 := [ 2 + 1 .. 2 ];
    deduped_17_1 := [ 1 .. 2 - 1 ];
    deduped_16_1 := [ 1 + 1 .. 2 ];
    deduped_15_1 := [ 1 .. 1 - 1 ];
    deduped_14_1 := HomalgIdentityMatrix( 0, deduped_20_1 );
    deduped_13_1 := Dimension( deduped_19_1 );
    deduped_12_1 := [ deduped_13_1, 0 ];
    deduped_11_1 := Sum( deduped_12_1 );
    deduped_10_1 := UnionOfRows( HomalgZeroMatrix( Sum( deduped_12_1{deduped_15_1} ), deduped_13_1, deduped_20_1 ), HomalgIdentityMatrix( deduped_13_1, deduped_20_1 ), HomalgZeroMatrix( Sum( deduped_12_1{deduped_16_1} ), deduped_13_1, deduped_20_1 ) );
    deduped_9_1 := [ deduped_10_1 * UnderlyingMatrix( alpha_1 ), UnionOfRows( HomalgZeroMatrix( Sum( deduped_12_1{deduped_17_1} ), 0, deduped_20_1 ), deduped_14_1, HomalgZeroMatrix( Sum( deduped_12_1{deduped_18_1} ), 0, deduped_20_1 ) ) * HomalgZeroMatrix( 0, Dimension( Range( alpha_1 ) ), deduped_20_1 ) ];
    deduped_8_1 := SyzygiesOfRows( UnionOfColumns( deduped_20_1, deduped_11_1, deduped_9_1{deduped_17_1} ) + -1 * UnionOfColumns( deduped_20_1, deduped_11_1, deduped_9_1{deduped_21_1} ) );
    deduped_7_1 := deduped_8_1 * deduped_10_1;
    deduped_6_1 := NumberRows( deduped_8_1 );
    deduped_5_1 := [ deduped_6_1, 0 ];
    deduped_4_1 := Sum( deduped_5_1 );
    deduped_3_1 := UnionOfRows( HomalgZeroMatrix( Sum( deduped_5_1{deduped_15_1} ), deduped_6_1, deduped_20_1 ), HomalgIdentityMatrix( deduped_6_1, deduped_20_1 ), HomalgZeroMatrix( Sum( deduped_5_1{deduped_16_1} ), deduped_6_1, deduped_20_1 ) );
    deduped_2_1 := [ deduped_3_1 * deduped_7_1, UnionOfRows( HomalgZeroMatrix( Sum( deduped_5_1{deduped_17_1} ), 0, deduped_20_1 ), deduped_14_1, HomalgZeroMatrix( Sum( deduped_5_1{deduped_18_1} ), 0, deduped_20_1 ) ) * HomalgZeroMatrix( 0, deduped_13_1, deduped_20_1 ) ];
    morphism_attr_1_1 := LeftDivide( SyzygiesOfColumns( SyzygiesOfRows( (UnionOfColumns( deduped_20_1, deduped_4_1, deduped_2_1{deduped_17_1} ) + -1 * UnionOfColumns( deduped_20_1, deduped_4_1, deduped_2_1{deduped_21_1} )) ) * deduped_3_1 ), deduped_7_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, ObjectifyObjectForCAPWithAttributes( rec(
             ), cat_1, Dimension, NumberRows( morphism_attr_1_1 ) ), deduped_19_1, UnderlyingMatrix, morphism_attr_1_1 );
end
########
        
    , 100 );
    
    ##
    AddKernelLiftWithGivenKernelObject( cat,
        
########
function ( cat_1, alpha_1, T_1, tau_1, P_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := UnderlyingRing( cat_1 );
    deduped_6_1 := [ 1 .. 2 - 1 ];
    deduped_5_1 := Dimension( Source( alpha_1 ) );
    deduped_4_1 := [ deduped_5_1, 0 ];
    deduped_3_1 := Sum( deduped_4_1 );
    deduped_2_1 := UnionOfRows( HomalgZeroMatrix( Sum( deduped_4_1{[ 1 .. 1 - 1 ]} ), deduped_5_1, deduped_7_1 ), HomalgIdentityMatrix( deduped_5_1, deduped_7_1 ), HomalgZeroMatrix( Sum( deduped_4_1{[ 1 + 1 .. 2 ]} ), deduped_5_1, deduped_7_1 ) );
    deduped_1_1 := [ deduped_2_1 * UnderlyingMatrix( alpha_1 ), UnionOfRows( HomalgZeroMatrix( Sum( deduped_4_1{deduped_6_1} ), 0, deduped_7_1 ), HomalgIdentityMatrix( 0, deduped_7_1 ), HomalgZeroMatrix( Sum( deduped_4_1{[ (2 + 1) .. 2 ]} ), 0, deduped_7_1 ) ) * HomalgZeroMatrix( 0, Dimension( Range( alpha_1 ) ), deduped_7_1 ) ];
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, RightDivide( UnderlyingMatrix( tau_1 ), SyzygiesOfRows( (UnionOfColumns( deduped_7_1, deduped_3_1, deduped_1_1{deduped_6_1} ) + -1 * UnionOfColumns( deduped_7_1, deduped_3_1, deduped_1_1{[ 2 ]} )) ) * deduped_2_1 ) );
end
########
        
    , 100 );
    
    ##
    AddLiftAlongMonomorphism( cat,
        
########
function ( cat_1, iota_1, tau_1 )
    local deduped_1_1, deduped_2_1, deduped_3_1;
    deduped_3_1 := Source( iota_1 );
    deduped_2_1 := Dimension( deduped_3_1 );
    deduped_1_1 := Sum( [ 0, deduped_2_1 ]{[ 1 .. 2 - 1 ]} ) + 1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( tau_1 ), deduped_3_1, UnderlyingMatrix, CertainColumns( RightDivide( UnderlyingMatrix( tau_1 ), UnderlyingMatrix( iota_1 ) ), [ deduped_1_1 .. deduped_1_1 - 1 + deduped_2_1 ] ) );
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
    AddMultiplyWithElementOfCommutativeRingForMorphisms( cat,
        
########
function ( cat_1, r_1, a_1 )
    local deduped_1_1;
    deduped_1_1 := Range( a_1 );
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( a_1 ), deduped_1_1, UnderlyingMatrix, r_1 * UnderlyingMatrix( a_1 ) * HomalgIdentityMatrix( Dimension( deduped_1_1 ), UnderlyingRing( cat_1 ) ) );
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
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, Source( alpha_1 ), Range( beta_1 ), UnderlyingMatrix, UnderlyingMatrix( alpha_1 ) * UnderlyingMatrix( beta_1 ) );
end
########
        
    , 100 );
    
    ##
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, k_1, P_1 )
    local hoisted_1_1, deduped_2_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := UnderlyingRing( cat_1 );
    deduped_3_1 := List( objects_1, function ( logic_new_func_x_2 )
            return Dimension( logic_new_func_x_2 );
        end );
    deduped_2_1 := deduped_3_1[k_1];
    hoisted_1_1 := deduped_4_1;
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, objects_1[k_1], UnderlyingMatrix, UnionOfRows( HomalgZeroMatrix( Sum( deduped_3_1{[ 1 .. (k_1 - 1) ]} ), deduped_2_1, deduped_4_1 ), HomalgIdentityMatrix( deduped_2_1, deduped_4_1 ), HomalgZeroMatrix( Sum( deduped_3_1{[ (k_1 + 1) .. Length( objects_1 ) ]} ), deduped_2_1, deduped_4_1 ) ) * List( objects_1, function ( logic_new_func_x_2 )
                  return HomalgIdentityMatrix( Dimension( logic_new_func_x_2 ), hoisted_1_1 );
              end )[k_1] );
end
########
        
    , 100 );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, P_1, T_1, UnderlyingMatrix, UnionOfRows( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( logic_new_func_x_2 )
                return UnderlyingMatrix( logic_new_func_x_2 );
            end ) ) );
end
########
        
    , 100 );
    
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
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( cat,
        
########
function ( cat_1, objects_1, T_1, tau_1, P_1 )
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec(
           ), cat_1, T_1, P_1, UnderlyingMatrix, UnionOfColumns( UnderlyingRing( cat_1 ), Dimension( T_1 ), List( tau_1, function ( logic_new_func_x_2 )
                return UnderlyingMatrix( logic_new_func_x_2 );
            end ) ) );
end
########
        
    , 100 );
    
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
           ), cat_1, Dimension, 0 - 0 );
end
########
        
    , 100 );
    
end );

BindGlobal( "MatrixCategoryAsFreydCategoryOfMatrixCategoryPrecompiled", function ( homalg_ring )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function ( homalg_ring )
    return MatrixCategoryAsFreydCategoryOfMatrixCategory( homalg_ring );
end;
        
        
    
    cat := category_constructor( homalg_ring : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_MatrixCategoryAsFreydCategoryOfMatrixCategoryPrecompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
