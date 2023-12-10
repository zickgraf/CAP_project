LoadPackage( "FreydCategoriesForCAP" : OnlyNeeded );
LoadPackage( "CompilerForCAP" : OnlyNeeded );

CapJitEnableProofAssistantMode( );

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsWellDefinedForObjects",
        "IsWellDefinedForMorphismsWithGivenSourceAndRange",
        "IsEqualForObjects",
        "IsCongruentForMorphisms",
        "ZeroMorphism",
    ],
    properties := [
        "IsAbCategory",
    ],
) );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

cat := AdditiveClosure( dummy );

SetCurrentCategory( cat, "the additive closure $\\Ccat^\\oplus$ of a pre-additive category $\\Ccat$", [
    rec(
        category := cat,
        symbol := "\\Ccat^\\oplus",
        variable_name_matches := rec(
            alpha := "alpha__A__B",
            beta := "beta__C__D",
            gamma := "gamma__E__F",
            objects := "D__n",
            diagram := "D__n",
        ),
    ),
    rec(
        category := dummy,
        symbol := "\\Ccat",
        variable_name_matches := rec(
            obj := "A",
        ),
    ),
] );

StateProposition( "has_zero_object", function ( name )
    
    if name = "alpha" then
        
        return "alpha__A__B";
        
    fi;
    
    if name = "beta" then
        
        return "beta__C__D";
        
    fi;
    
    if name = "gamma" then
        
        return "gamma__E__F";
        
    fi;
    
    return name;
    
end );

# ZeroObject well-defined
StateNextLemma( );

AssumeValidInputs( );

AssertLemma( );

# UniversalMorphismIntoZeroObject well-defined
StateNextLemma( );

AssumeValidInputs( );

AssertLemma( );

# UniversalMorphismIntoZeroObject unique
StateNextLemma( );

# UniversalMorphismFromZeroObject well-defined
StateNextLemma( );

AssumeValidInputs( );

AssertLemma( );

# UniversalMorphismFromZeroObject unique
StateNextLemma( );



AssertProposition( );
