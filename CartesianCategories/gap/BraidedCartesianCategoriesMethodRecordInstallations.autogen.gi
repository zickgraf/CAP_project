# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecordTools.gi

## CartesianBraiding
InstallMethod( AddCartesianBraiding,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "CartesianBraiding", category, func, -1 );
    
end );

InstallMethod( AddCartesianBraiding,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "CartesianBraiding", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## CartesianBraidingInverse
InstallMethod( AddCartesianBraidingInverse,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "CartesianBraidingInverse", category, func, -1 );
    
end );

InstallMethod( AddCartesianBraidingInverse,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "CartesianBraidingInverse", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## CartesianBraidingInverseWithGivenDirectProducts
InstallMethod( AddCartesianBraidingInverseWithGivenDirectProducts,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "CartesianBraidingInverseWithGivenDirectProducts", category, func, -1 );
    
end );

InstallMethod( AddCartesianBraidingInverseWithGivenDirectProducts,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "CartesianBraidingInverseWithGivenDirectProducts", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( CartesianBraidingInverseWithGivenDirectProducts,
                    "CartesianBraidingInverseWithGivenDirectProducts by calling CartesianBraidingInverse with the WithGiven argument(s) dropped",
                    [
                        [ CartesianBraidingInverse, 1 ],
                    ],
  function( cat, s, a, b, r )
    
    return CartesianBraidingInverse( cat, a, b );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( CartesianBraidingInverse,
                    "CartesianBraidingInverse by calling CartesianBraidingInverseWithGivenDirectProducts with the WithGiven object(s)",
                    [
                        [ CartesianBraidingInverseWithGivenDirectProducts, 1 ],
                        [ DirectProduct, 2 ],
                    ],
  function( cat, a, b )
    
    return CartesianBraidingInverseWithGivenDirectProducts( cat, BinaryDirectProduct( cat, b, a ), a, b, BinaryDirectProduct( cat, a, b ) );
    
end : is_with_given_derivation := true );

## CartesianBraidingWithGivenDirectProducts
InstallMethod( AddCartesianBraidingWithGivenDirectProducts,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "CartesianBraidingWithGivenDirectProducts", category, func, -1 );
    
end );

InstallMethod( AddCartesianBraidingWithGivenDirectProducts,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "CartesianBraidingWithGivenDirectProducts", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
                    "CartesianBraidingWithGivenDirectProducts by calling CartesianBraiding with the WithGiven argument(s) dropped",
                    [
                        [ CartesianBraiding, 1 ],
                    ],
  function( cat, s, a, b, r )
    
    return CartesianBraiding( cat, a, b );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( CartesianBraiding,
                    "CartesianBraiding by calling CartesianBraidingWithGivenDirectProducts with the WithGiven object(s)",
                    [
                        [ CartesianBraidingWithGivenDirectProducts, 1 ],
                        [ DirectProduct, 2 ],
                    ],
  function( cat, a, b )
    
    return CartesianBraidingWithGivenDirectProducts( cat, BinaryDirectProduct( cat, a, b ), a, b, BinaryDirectProduct( cat, b, a ) );
    
end : is_with_given_derivation := true );