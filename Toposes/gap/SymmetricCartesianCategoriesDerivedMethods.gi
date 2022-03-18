# THIS FILE WAS AUTOMATICALLY GENERATED

# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

##
AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
                  
  function( cat, object_1_x_object_2, object_1, object_2, object_2_x_object_1 )
    
    return CartesianBraidingInverseWithGivenDirectProducts( cat,
                            object_1_x_object_2,
                            object_2, object_1,
                            object_2_x_object_1 );
    
end : CategoryFilter := IsCartesianCategory,
      Description := "CartesianBraidingWithGivenDirectProducts using CartesianBraidingInverseWithGivenDirectProducts" );

##
AddDerivationToCAP( CartesianBraidingInverseWithGivenDirectProducts,
                  
  function( cat, object_2_x_object_1, object_1, object_2, object_1_x_object_2 )
    
    return CartesianBraidingWithGivenDirectProducts( cat,
                     object_2_x_object_1,
                     object_2, object_1,
                     object_1_x_object_2 );
    
end : CategoryFilter := IsCartesianCategory,
      Description := "CartesianBraidingInverseWithGivenDirectProducts using CartesianBraidingWithGivenDirectProducts" );
