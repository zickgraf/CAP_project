LoadPackage( "FreydCategoriesForCAP" : OnlyNeeded );
LoadPackage( "CompilerForCAP" : OnlyNeeded );

CapJitEnableProofAssistantMode( );

# FIXME
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Source( MorphismMatrix( additive_closure_morphism )[i][j] )",
        dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Target( MorphismMatrix( additive_closure_morphism )[i][j] )",
        dst_template := "ObjectList( Target( additive_closure_morphism ) )[j]",
    )
);

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsWellDefinedForObjects",
        "IsWellDefinedForMorphisms",
		"IsEqualForObjects",
        "IsCongruentForMorphisms",
        "PreCompose",
        "IdentityMorphism",
        "SumOfMorphisms",
        "ZeroMorphism",
        "AdditionForMorphisms",
        "AdditiveInverseForMorphisms",
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

StateProposition( "is_preadditive_category", function ( name )
    
    if name = "a" then
        
        return "A";
        
    fi;
    
    if name = "b" then
        
        return "B";
        
    fi;
    
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

# AdditionForMorphisms well-defined
StateNextLemma( );

PrintLemma( );

AssumeValidInputs( );

PrintLemma( );
AssertLemma( );

# AdditionForMorphisms associative
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "beta", "gamma" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "AdditionForMorphisms( cat, AdditionForMorphisms( cat, alpha, beta ), gamma )",
        dst_template := "AdditionForMorphisms( cat, alpha, AdditionForMorphisms( cat, beta, gamma ) )",
    ),
    dummy, [ "category", "morphism", "morphism", "morphism" ], " = ", "."
);

PrintLemma( );
AssertLemma( );

# AdditionForMorphisms commutative
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "AdditionForMorphisms( cat, alpha, beta )",
        dst_template := "AdditionForMorphisms( cat, beta, alpha )",
    ),
    dummy, [ "category", "morphism", "morphism" ], " = ", "."
);

PrintLemma( );
AssertLemma( );

# AdditionForMorphisms bilinear from the left
StateNextLemma( );

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "list", "func1", "func2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsFunction, IsFunction ],
        src_template := "AdditionForMorphisms( cat, SumOfMorphisms( cat, source, List( list, func1 ), target ), SumOfMorphisms( cat, source, List( list, func2 ), target ) )",
        dst_template := "SumOfMorphisms( cat, source, List( list, x -> AdditionForMorphisms( cat, func1( x ), func2( x ) ) ), target )",
        new_funcs := [ [ "x" ] ],
    )#,
    #dummy, [ "category", "morphism", "morphism" ], " = ", "."
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "mor", "alpha", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "PreCompose( cat, mor, AdditionForMorphisms( cat, alpha, beta ) )",
        dst_template := "AdditionForMorphisms( cat, PreCompose( cat, mor, alpha ), PreCompose( cat, mor, beta ) )",
    )#,
    #dummy, [ "category", "morphism", "morphism" ], " = ", "."
);

PrintLemma( );
AssertLemma( );

# AdditionForMorphisms bilinear from the right
StateNextLemma( );

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "source", "target", "list", "func1", "func2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryObject, IsDummyCategoryObject, IsList, IsFunction, IsFunction ],
        src_template := "AdditionForMorphisms( cat, SumOfMorphisms( cat, source, List( list, func1 ), target ), SumOfMorphisms( cat, source, List( list, func2 ), target ) )",
        dst_template := "SumOfMorphisms( cat, source, List( list, x -> AdditionForMorphisms( cat, func1( x ), func2( x ) ) ), target )",
        new_funcs := [ [ "x" ] ],
    )#,
    #dummy, [ "category", "morphism", "morphism" ], " = ", "."
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "mor", "alpha", "beta" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "PreCompose( cat, AdditionForMorphisms( cat, alpha, beta ), mor )",
        dst_template := "AdditionForMorphisms( cat, PreCompose( cat, alpha, mor ), PreCompose( cat, beta, mor ) )",
    )#,
    #dummy, [ "category", "morphism", "morphism" ], " = ", "."
);

PrintLemma( );
AssertLemma( );

# Zero well-defined
StateNextLemma( );

AssumeValidInputs( );

PrintLemma( );
AssertLemma( );

# Zero left neutral
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "A", "B" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "AdditionForMorphisms( cat, ZeroMorphism( cat, A, B ), alpha )",
        dst_template := "alpha",
    ),
    dummy, [ "category", "morphism", "object", "object" ], " = ", "."
);

PrintLemma( );
AssertLemma( );

# Zero right neutral
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "A", "B" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "AdditionForMorphisms( cat, alpha, ZeroMorphism( cat, A, B ) )",
        dst_template := "alpha",
    ),
    dummy, [ "category", "morphism", "object", "object" ], " = ", "."
);

PrintLemma( );
AssertLemma( );

# AdditiveInverse well-defined
StateNextLemma( );

AssumeValidInputs( );

PrintLemma( );
AssertLemma( );

# AdditiveInverse left inverse
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism ],
        src_template := "AdditionForMorphisms( cat, AdditiveInverseForMorphisms( cat, alpha ), alpha )",
        dst_template := "ZeroMorphism( cat, Source( alpha ), Target( alpha ) )",
    ),
    dummy, [ "category", "morphism" ], " = ", "."
);

PrintLemma( );
AssertLemma( );

# AdditiveInverse right inverse
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism ],
        src_template := "AdditionForMorphisms( cat, alpha, AdditiveInverseForMorphisms( cat, alpha ) )",
        dst_template := "ZeroMorphism( cat, Source( alpha ), Target( alpha ) )",
    ),
    dummy, [ "category", "morphism" ], " = ", "."
);

PrintLemma( );
AssertLemma( );

AssertProposition( );
