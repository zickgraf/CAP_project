# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecordTools.gi

## LeftCocartesianCodistributivityExpanding
InstallMethod( AddLeftCocartesianCodistributivityExpanding,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "LeftCocartesianCodistributivityExpanding", category, func, -1 );
    
end );

InstallMethod( AddLeftCocartesianCodistributivityExpanding,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "LeftCocartesianCodistributivityExpanding", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## LeftCocartesianCodistributivityExpandingWithGivenObjects
InstallMethod( AddLeftCocartesianCodistributivityExpandingWithGivenObjects,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "LeftCocartesianCodistributivityExpandingWithGivenObjects", category, func, -1 );
    
end );

InstallMethod( AddLeftCocartesianCodistributivityExpandingWithGivenObjects,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "LeftCocartesianCodistributivityExpandingWithGivenObjects", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( LeftCocartesianCodistributivityExpandingWithGivenObjects,
                    "LeftCocartesianCodistributivityExpandingWithGivenObjects by calling LeftCocartesianCodistributivityExpanding with the WithGiven argument(s) dropped",
                    [
                        [ LeftCocartesianCodistributivityExpanding, 1 ],
                    ],
  function( cat, s, a, L, r )
    
    return LeftCocartesianCodistributivityExpanding( cat, a, L );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( LeftCocartesianCodistributivityExpanding,
                    "LeftCocartesianCodistributivityExpanding by calling LeftCocartesianCodistributivityExpandingWithGivenObjects with the WithGiven object(s)",
                    [
                        [ LeftCocartesianCodistributivityExpandingWithGivenObjects, 1 ],
                        [ DirectProduct, 2 ],
                        [ Coproduct, 3 ],
                    ],
  function( cat, a, L )
    
    return LeftCocartesianCodistributivityExpandingWithGivenObjects( cat, BinaryCoproduct( cat, a, DirectProduct( cat, L ) ), a, L, DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, a, summand ) ) ) );
    
end : is_with_given_derivation := true );

## LeftCocartesianCodistributivityFactoring
InstallMethod( AddLeftCocartesianCodistributivityFactoring,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "LeftCocartesianCodistributivityFactoring", category, func, -1 );
    
end );

InstallMethod( AddLeftCocartesianCodistributivityFactoring,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "LeftCocartesianCodistributivityFactoring", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## LeftCocartesianCodistributivityFactoringWithGivenObjects
InstallMethod( AddLeftCocartesianCodistributivityFactoringWithGivenObjects,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "LeftCocartesianCodistributivityFactoringWithGivenObjects", category, func, -1 );
    
end );

InstallMethod( AddLeftCocartesianCodistributivityFactoringWithGivenObjects,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "LeftCocartesianCodistributivityFactoringWithGivenObjects", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( LeftCocartesianCodistributivityFactoringWithGivenObjects,
                    "LeftCocartesianCodistributivityFactoringWithGivenObjects by calling LeftCocartesianCodistributivityFactoring with the WithGiven argument(s) dropped",
                    [
                        [ LeftCocartesianCodistributivityFactoring, 1 ],
                    ],
  function( cat, s, a, L, r )
    
    return LeftCocartesianCodistributivityFactoring( cat, a, L );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( LeftCocartesianCodistributivityFactoring,
                    "LeftCocartesianCodistributivityFactoring by calling LeftCocartesianCodistributivityFactoringWithGivenObjects with the WithGiven object(s)",
                    [
                        [ LeftCocartesianCodistributivityFactoringWithGivenObjects, 1 ],
                        [ DirectProduct, 2 ],
                        [ Coproduct, 3 ],
                    ],
  function( cat, a, L )
    
    return LeftCocartesianCodistributivityFactoringWithGivenObjects( cat, DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, a, summand ) ) ), a, L, BinaryCoproduct( cat, a, DirectProduct( cat, L ) ) );
    
end : is_with_given_derivation := true );

## RightCocartesianCodistributivityExpanding
InstallMethod( AddRightCocartesianCodistributivityExpanding,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "RightCocartesianCodistributivityExpanding", category, func, -1 );
    
end );

InstallMethod( AddRightCocartesianCodistributivityExpanding,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "RightCocartesianCodistributivityExpanding", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## RightCocartesianCodistributivityExpandingWithGivenObjects
InstallMethod( AddRightCocartesianCodistributivityExpandingWithGivenObjects,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "RightCocartesianCodistributivityExpandingWithGivenObjects", category, func, -1 );
    
end );

InstallMethod( AddRightCocartesianCodistributivityExpandingWithGivenObjects,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "RightCocartesianCodistributivityExpandingWithGivenObjects", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( RightCocartesianCodistributivityExpandingWithGivenObjects,
                    "RightCocartesianCodistributivityExpandingWithGivenObjects by calling RightCocartesianCodistributivityExpanding with the WithGiven argument(s) dropped",
                    [
                        [ RightCocartesianCodistributivityExpanding, 1 ],
                    ],
  function( cat, s, L, a, r )
    
    return RightCocartesianCodistributivityExpanding( cat, L, a );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( RightCocartesianCodistributivityExpanding,
                    "RightCocartesianCodistributivityExpanding by calling RightCocartesianCodistributivityExpandingWithGivenObjects with the WithGiven object(s)",
                    [
                        [ RightCocartesianCodistributivityExpandingWithGivenObjects, 1 ],
                        [ DirectProduct, 2 ],
                        [ Coproduct, 3 ],
                    ],
  function( cat, L, a )
    
    return RightCocartesianCodistributivityExpandingWithGivenObjects( cat, BinaryCoproduct( cat, DirectProduct( cat, L ), a ), L, a, DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, summand, a ) ) ) );
    
end : is_with_given_derivation := true );

## RightCocartesianCodistributivityFactoring
InstallMethod( AddRightCocartesianCodistributivityFactoring,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "RightCocartesianCodistributivityFactoring", category, func, -1 );
    
end );

InstallMethod( AddRightCocartesianCodistributivityFactoring,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "RightCocartesianCodistributivityFactoring", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## RightCocartesianCodistributivityFactoringWithGivenObjects
InstallMethod( AddRightCocartesianCodistributivityFactoringWithGivenObjects,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "RightCocartesianCodistributivityFactoringWithGivenObjects", category, func, -1 );
    
end );

InstallMethod( AddRightCocartesianCodistributivityFactoringWithGivenObjects,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "RightCocartesianCodistributivityFactoringWithGivenObjects", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( RightCocartesianCodistributivityFactoringWithGivenObjects,
                    "RightCocartesianCodistributivityFactoringWithGivenObjects by calling RightCocartesianCodistributivityFactoring with the WithGiven argument(s) dropped",
                    [
                        [ RightCocartesianCodistributivityFactoring, 1 ],
                    ],
  function( cat, s, L, a, r )
    
    return RightCocartesianCodistributivityFactoring( cat, L, a );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( RightCocartesianCodistributivityFactoring,
                    "RightCocartesianCodistributivityFactoring by calling RightCocartesianCodistributivityFactoringWithGivenObjects with the WithGiven object(s)",
                    [
                        [ RightCocartesianCodistributivityFactoringWithGivenObjects, 1 ],
                        [ DirectProduct, 2 ],
                        [ Coproduct, 3 ],
                    ],
  function( cat, L, a )
    
    return RightCocartesianCodistributivityFactoringWithGivenObjects( cat, DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, summand, a ) ) ), L, a, BinaryCoproduct( cat, DirectProduct( cat, L ), a ) );
    
end : is_with_given_derivation := true );
