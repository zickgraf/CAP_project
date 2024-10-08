# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecordTools.gi

## LeftCartesianDistributivityExpanding
InstallMethod( AddLeftCartesianDistributivityExpanding,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "LeftCartesianDistributivityExpanding", category, func, -1 );
    
end );

InstallMethod( AddLeftCartesianDistributivityExpanding,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "LeftCartesianDistributivityExpanding", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## LeftCartesianDistributivityExpandingWithGivenObjects
InstallMethod( AddLeftCartesianDistributivityExpandingWithGivenObjects,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "LeftCartesianDistributivityExpandingWithGivenObjects", category, func, -1 );
    
end );

InstallMethod( AddLeftCartesianDistributivityExpandingWithGivenObjects,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "LeftCartesianDistributivityExpandingWithGivenObjects", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( LeftCartesianDistributivityExpandingWithGivenObjects,
                    "LeftCartesianDistributivityExpandingWithGivenObjects by calling LeftCartesianDistributivityExpanding with the WithGiven argument(s) dropped",
                    [
                        [ LeftCartesianDistributivityExpanding, 1 ],
                    ],
  function( cat, s, a, L, r )
    
    return LeftCartesianDistributivityExpanding( cat, a, L );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( LeftCartesianDistributivityExpanding,
                    "LeftCartesianDistributivityExpanding by calling LeftCartesianDistributivityExpandingWithGivenObjects with the WithGiven object(s)",
                    [
                        [ LeftCartesianDistributivityExpandingWithGivenObjects, 1 ],
                        [ Coproduct, 2 ],
                        [ DirectProduct, 3 ],
                    ],
  function( cat, a, L )
    
    return LeftCartesianDistributivityExpandingWithGivenObjects( cat, BinaryDirectProduct( cat, a, Coproduct( cat, L ) ), a, L, Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, a, summand ) ) ) );
    
end : is_with_given_derivation := true );

## LeftCartesianDistributivityFactoring
InstallMethod( AddLeftCartesianDistributivityFactoring,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "LeftCartesianDistributivityFactoring", category, func, -1 );
    
end );

InstallMethod( AddLeftCartesianDistributivityFactoring,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "LeftCartesianDistributivityFactoring", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## LeftCartesianDistributivityFactoringWithGivenObjects
InstallMethod( AddLeftCartesianDistributivityFactoringWithGivenObjects,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "LeftCartesianDistributivityFactoringWithGivenObjects", category, func, -1 );
    
end );

InstallMethod( AddLeftCartesianDistributivityFactoringWithGivenObjects,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "LeftCartesianDistributivityFactoringWithGivenObjects", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( LeftCartesianDistributivityFactoringWithGivenObjects,
                    "LeftCartesianDistributivityFactoringWithGivenObjects by calling LeftCartesianDistributivityFactoring with the WithGiven argument(s) dropped",
                    [
                        [ LeftCartesianDistributivityFactoring, 1 ],
                    ],
  function( cat, s, a, L, r )
    
    return LeftCartesianDistributivityFactoring( cat, a, L );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( LeftCartesianDistributivityFactoring,
                    "LeftCartesianDistributivityFactoring by calling LeftCartesianDistributivityFactoringWithGivenObjects with the WithGiven object(s)",
                    [
                        [ LeftCartesianDistributivityFactoringWithGivenObjects, 1 ],
                        [ Coproduct, 2 ],
                        [ DirectProduct, 3 ],
                    ],
  function( cat, a, L )
    
    return LeftCartesianDistributivityFactoringWithGivenObjects( cat, Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, a, summand ) ) ), a, L, BinaryDirectProduct( cat, a, Coproduct( cat, L ) ) );
    
end : is_with_given_derivation := true );

## RightCartesianDistributivityExpanding
InstallMethod( AddRightCartesianDistributivityExpanding,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "RightCartesianDistributivityExpanding", category, func, -1 );
    
end );

InstallMethod( AddRightCartesianDistributivityExpanding,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "RightCartesianDistributivityExpanding", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## RightCartesianDistributivityExpandingWithGivenObjects
InstallMethod( AddRightCartesianDistributivityExpandingWithGivenObjects,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "RightCartesianDistributivityExpandingWithGivenObjects", category, func, -1 );
    
end );

InstallMethod( AddRightCartesianDistributivityExpandingWithGivenObjects,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "RightCartesianDistributivityExpandingWithGivenObjects", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( RightCartesianDistributivityExpandingWithGivenObjects,
                    "RightCartesianDistributivityExpandingWithGivenObjects by calling RightCartesianDistributivityExpanding with the WithGiven argument(s) dropped",
                    [
                        [ RightCartesianDistributivityExpanding, 1 ],
                    ],
  function( cat, s, L, a, r )
    
    return RightCartesianDistributivityExpanding( cat, L, a );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( RightCartesianDistributivityExpanding,
                    "RightCartesianDistributivityExpanding by calling RightCartesianDistributivityExpandingWithGivenObjects with the WithGiven object(s)",
                    [
                        [ RightCartesianDistributivityExpandingWithGivenObjects, 1 ],
                        [ Coproduct, 2 ],
                        [ DirectProduct, 3 ],
                    ],
  function( cat, L, a )
    
    return RightCartesianDistributivityExpandingWithGivenObjects( cat, BinaryDirectProduct( cat, Coproduct( cat, L ), a ), L, a, Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, summand, a ) ) ) );
    
end : is_with_given_derivation := true );

## RightCartesianDistributivityFactoring
InstallMethod( AddRightCartesianDistributivityFactoring,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "RightCartesianDistributivityFactoring", category, func, -1 );
    
end );

InstallMethod( AddRightCartesianDistributivityFactoring,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "RightCartesianDistributivityFactoring", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

## RightCartesianDistributivityFactoringWithGivenObjects
InstallMethod( AddRightCartesianDistributivityFactoringWithGivenObjects,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    
    AddCapOperation( "RightCartesianDistributivityFactoringWithGivenObjects", category, func, -1 );
    
end );

InstallMethod( AddRightCartesianDistributivityFactoringWithGivenObjects,
               [ IsCapCategory, IsFunction, IsInt ],
               
    FunctionWithNamedArguments(
        [
            [ "IsPrecompiledDerivation", false ],
        ],
        function( CAP_NAMED_ARGUMENTS, category, func, weight )
            
            AddCapOperation( "RightCartesianDistributivityFactoringWithGivenObjects", category, func, weight : IsPrecompiledDerivation := CAP_NAMED_ARGUMENTS.IsPrecompiledDerivation );
            
        end
    )
);

AddDerivationToCAP( RightCartesianDistributivityFactoringWithGivenObjects,
                    "RightCartesianDistributivityFactoringWithGivenObjects by calling RightCartesianDistributivityFactoring with the WithGiven argument(s) dropped",
                    [
                        [ RightCartesianDistributivityFactoring, 1 ],
                    ],
  function( cat, s, L, a, r )
    
    return RightCartesianDistributivityFactoring( cat, L, a );
        
end : is_with_given_derivation := true );

AddDerivationToCAP( RightCartesianDistributivityFactoring,
                    "RightCartesianDistributivityFactoring by calling RightCartesianDistributivityFactoringWithGivenObjects with the WithGiven object(s)",
                    [
                        [ RightCartesianDistributivityFactoringWithGivenObjects, 1 ],
                        [ Coproduct, 2 ],
                        [ DirectProduct, 3 ],
                    ],
  function( cat, L, a )
    
    return RightCartesianDistributivityFactoringWithGivenObjects( cat, Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, summand, a ) ) ), L, a, BinaryDirectProduct( cat, Coproduct( cat, L ), a ) );
    
end : is_with_given_derivation := true );
