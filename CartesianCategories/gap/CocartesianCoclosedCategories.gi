# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( IsomorphismFromCoexponentialToObject,
                    [ [ IsomorphismFromCoexponentialToObjectWithGivenCoexponential, 1 ] ],
                    
  function( cat, object )

    return IsomorphismFromCoexponentialToObjectWithGivenCoexponential( cat, object, object );

end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

##
AddDerivationToCAP( IsomorphismFromObjectToCoexponential,
                    [ [ IsomorphismFromObjectToCoexponentialWithGivenCoexponential, 1 ] ],
                    
  function( cat, object )

    return IsomorphismFromObjectToCoexponentialWithGivenCoexponential( cat, object, object );

end : CategoryFilter := IsSkeletalCategory,
      Description := "calling the WithGiven operation in a skeletal setting" );

####################################
# Convenience Methods
####################################

##
InstallMethod( Coexponential,
        [ IsCapCategoryObject, IsCapCategoryObject ],
        
  CoexponentialOnObjects );

##
InstallMethod( Coexponential,
        [ IsCapCategoryMorphism, IsCapCategoryMorphism ],
        
  CoexponentialOnMorphisms );

##
InstallMethod( Coexponential,
        [ IsCapCategoryObject, IsCapCategoryMorphism ],
        
  function( a, beta )
    
    return CoexponentialOnMorphisms( IdentityMorphism( a ), beta );
    
end );

##
InstallMethod( Coexponential,
        [ IsCapCategoryMorphism, IsCapCategoryObject ],
        
  function( alpha, b )
    
    return CoexponentialOnMorphisms( alpha, IdentityMorphism( b ) );
    
end );