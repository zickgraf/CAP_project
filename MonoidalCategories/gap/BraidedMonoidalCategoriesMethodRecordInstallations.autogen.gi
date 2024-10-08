# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecordTools.gi

## Braiding
InstallMethod( AddBraiding,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "Braiding", category, func, -1 );
    
end );

InstallMethod( AddBraiding,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "Braiding", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## BraidingInverse
InstallMethod( AddBraidingInverse,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "BraidingInverse", category, func, -1 );
    
end );

InstallMethod( AddBraidingInverse,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "BraidingInverse", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## BraidingInverseWithGivenTensorProducts
InstallMethod( AddBraidingInverseWithGivenTensorProducts,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "BraidingInverseWithGivenTensorProducts", category, func, -1 );
    
end );

InstallMethod( AddBraidingInverseWithGivenTensorProducts,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "BraidingInverseWithGivenTensorProducts", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( BraidingInverseWithGivenTensorProducts,
                    "BraidingInverseWithGivenTensorProducts by calling BraidingInverse with the WithGiven argument(s) dropped",
                    [
                        [ BraidingInverse, 1 ],
                    ],
  function( cat, s, a, b, r )
    
    return BraidingInverse( cat, a, b );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( BraidingInverse,
                    "BraidingInverse by calling BraidingInverseWithGivenTensorProducts with the WithGiven object(s)",
                    [
                        [ BraidingInverseWithGivenTensorProducts, 1 ],
                        [ TensorProductOnObjects, 2 ],
                    ],
  function( cat, a, b )
    
    return BraidingInverseWithGivenTensorProducts( cat, TensorProductOnObjects( cat, b, a ), a, b, TensorProductOnObjects( cat, a, b ) );
    
end : is_with_given_derivation := true );

## BraidingWithGivenTensorProducts
InstallMethod( AddBraidingWithGivenTensorProducts,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "BraidingWithGivenTensorProducts", category, func, -1 );
    
end );

InstallMethod( AddBraidingWithGivenTensorProducts,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "BraidingWithGivenTensorProducts", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( BraidingWithGivenTensorProducts,
                    "BraidingWithGivenTensorProducts by calling Braiding with the WithGiven argument(s) dropped",
                    [
                        [ Braiding, 1 ],
                    ],
  function( cat, s, a, b, r )
    
    return Braiding( cat, a, b );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( Braiding,
                    "Braiding by calling BraidingWithGivenTensorProducts with the WithGiven object(s)",
                    [
                        [ BraidingWithGivenTensorProducts, 1 ],
                        [ TensorProductOnObjects, 2 ],
                    ],
  function( cat, a, b )
    
    return BraidingWithGivenTensorProducts( cat, TensorProductOnObjects( cat, a, b ), a, b, TensorProductOnObjects( cat, b, a ) );
    
end : is_with_given_derivation := true );
