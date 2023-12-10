LoadPackage( "FreydCategoriesForCAP" : OnlyNeeded );
LoadPackage( "CompilerForCAP" : OnlyNeeded );

CapJitEnableProofAssistantMode( );

## FIXME
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "additive_closure_morphism", "i", "j" ],
#        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
#        src_template := "Source( MorphismMatrix( additive_closure_morphism )[i][j] )",
#        dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
#    )
#);
#
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "additive_closure_morphism", "i", "j" ],
#        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
#        src_template := "Target( MorphismMatrix( additive_closure_morphism )[i][j] )",
#        dst_template := "ObjectList( Target( additive_closure_morphism ) )[j]",
#    )
#);

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsWellDefinedForObjects",
        "IsWellDefinedForMorphismsWithGivenSourceAndRange",
        "IsEqualForObjects",
        "IsCongruentForMorphisms",
        "PreCompose",
        "IdentityMorphism",
        "SumOfMorphisms",
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

result := StateProposition( "is_category", function ( name )
    
    if name = "a" then
        
        return "A";
        
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

# PreCompose well-defined
StateNextLemma( );

AssumeValidInputs( );

AssertLemma( );

# PreCompose associative
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha__A__B", "C", "A", "l", "beta_k" ],
        src_template := "PreCompose( cat, SumOfMorphisms( cat, C, List( [ 1 .. l ], k -> beta_k ), A ), alpha__A__B )",
        dst_template := "SumOfMorphisms( cat, C, List( [ 1 .. l ], k -> PreCompose( cat, beta_k, alpha__A__B ) ), Target( alpha__A__B ) )",
    ),
    dummy, [ "category", "morphism", "object", "object", "integer", "morphism" ], "="
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha__A__B", "B", "D", "l", "gamma_k" ],
        src_template := "PreCompose( cat, alpha__A__B, SumOfMorphisms( cat, B, List( [ 1 .. l ], k -> gamma_k ), D ) )",
        dst_template := "SumOfMorphisms( cat, Source( alpha__A__B ), List( [ 1 .. l ], k -> PreCompose( cat, alpha__A__B, gamma_k ) ), D )",
    ),
    dummy, [ "category", "morphism", "object", "object", "integer", "morphism" ], "=", "."
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "beta", "gamma" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryMorphism, IsDummyCategoryMorphism ],
        src_template := "PreCompose( cat, alpha, PreCompose( cat, beta, gamma ) )",
        dst_template := "PreCompose( cat, PreCompose( cat, alpha, beta ), gamma )",
    ),
    dummy, [ "category", "morphism", "morphism", "morphism" ], "=", "."
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Source( MorphismMatrix( additive_closure_morphism )[i][j] )",
        dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
    )
);
ApplyLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Target( MorphismMatrix( additive_closure_morphism )[i][j] )",
        dst_template := "ObjectList( Target( additive_closure_morphism ) )[j]",
    )
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "m", "n", "alpha", "A", "B" ],
        src_template := "SumOfMorphisms( cat, A, List( [ 1 .. m ], i -> SumOfMorphisms( cat, A, List( [ 1 .. n ], j -> alpha ), B ) ), B )",
        dst_template := "SumOfMorphisms( cat, A, List( [ 1 .. n ], j -> SumOfMorphisms( cat, A, List( [ 1 .. m ], i -> alpha ), B ) ), B )",
    ),
    dummy, [ "category", "integer", "integer", "morphism", "object", "object" ], "="
);

AssertLemma( );

# IdentityMorphism well-defined
StateNextLemma( );

AssumeValidInputs( );

#ApplyLogicTemplateAndReturnLaTeXString(
ApplyLogicTemplate(
    rec(
        variable_names := [ "i", "j", "list" ],
        src_template := "CAP_JIT_INTERNAL_EXPR_CASE( i = j, list[i], true, list[j] )",
        dst_template := "list[j]",
    )#,
    #dummy, [ "category", "integer", "integer", "morphism", "object", "object" ], "="
);

AssertLemma( );

# IdentityMorphism left-neutral
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "P", "beta_1", "beta_2" ],
        src_template := "PreCompose( cat, CAP_JIT_INTERNAL_EXPR_CASE( P, beta_1, true, beta_2 ), alpha )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, PreCompose( cat, beta_1, alpha ), true, PreCompose( cat, beta_2, alpha ) )",
    ),
    dummy, [ "category", "morphism", "bool", "morphism", "morphism" ], "="
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "B" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject ],
        src_template := "PreCompose( cat, IdentityMorphism( cat, B ), alpha )",
        dst_template := "alpha",
    ),
    dummy, [ "category", "morphism", "object" ], "="
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "alpha", "B_1", "B_2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "PreCompose( cat, ZeroMorphism( cat, B_1, B_2 ), alpha )",
        dst_template := "ZeroMorphism( cat, B_1, Target( alpha ) )",
    ),
    dummy, [ "category", "morphism", "object", "object" ], "=", "."
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Target( MorphismMatrix( additive_closure_morphism )[i][j] )",
        dst_template := "ObjectList( Target( additive_closure_morphism ) )[j]",
    )
);
ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "l", "i", "alpha", "B_1", "B_2" ],
        variable_filters := [ IsDummyCategory, IsInt, IsInt, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "SumOfMorphisms( cat, B_1, List( [ 1 .. l ], k -> CAP_JIT_INTERNAL_EXPR_CASE( i = k, alpha, true, ZeroMorphism( cat, B_1, B_2 ) ) ), B_2 )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( i in [ 1 .. l ], (k -> alpha)(i), true, ZeroMorphism( cat, B_1, B_2 ) )",
    ),
    dummy, [ "category", "integer", "integer", "morphism", "object", "object" ], "="
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "cat", "P", "alpha", "beta", "gamma" ],
        src_template := "IsCongruentForMorphisms( cat, CAP_JIT_INTERNAL_EXPR_CASE( P, alpha, true, beta ), gamma )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( P, IsCongruentForMorphisms( cat, alpha, gamma ), true, IsCongruentForMorphisms( cat, beta, gamma ) )",
    ),
    dummy, [ "category", "bool", "morphism", "morphism", "morphism" ], "\\quad\\quad = \\quad\\quad"
);

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "l1", "l2", "P", "Q" ],
        src_template := "ForAll( [ 1 .. l1 ], i -> ForAll( [ 1 .. l2 ], j -> CAP_JIT_INTERNAL_EXPR_CASE( i in [ 1 .. l1 ], P, true, Q ) ) )",
        dst_template := "ForAll( [ 1 .. l1 ], i -> ForAll( [ 1 .. l2 ], j -> CAP_JIT_INTERNAL_EXPR_CASE( true, P, true, Q ) ) )",
    ),
    dummy, [ "integer", "integer", "bool", "bool" ], "="
);

AssertLemma( );

# IdentityMorphism right-neutral
StateNextLemma( );

# PreCompose( alpha, KroneckerDelta( ... ) )
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "index1", "index2", "value_if_equal", "value_if_not_equal" ],
        #src_template := "PreCompose( cat, KroneckerDelta( index1, index2, value_if_equal, value_if_not_equal ), alpha )",
        #dst_template := "KroneckerDelta( index1, index2, PreCompose( cat, value_if_equal, alpha ), PreCompose( cat, value_if_not_equal, alpha ) )",
        src_template := "PreCompose( cat, alpha, CAP_JIT_INTERNAL_EXPR_CASE( index1 = index2, value_if_equal, true, value_if_not_equal ) )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( index1 = index2, PreCompose( cat, alpha, value_if_equal ), true, PreCompose( cat, alpha, value_if_not_equal ) )",
    )
);

# PreCompose( alpha, IdentityMorphism( ... ) )
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "object" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject ],
        src_template := "PreCompose( cat, alpha, IdentityMorphism( cat, object ) )",
        dst_template := "alpha",
    )
);

# PreCompose( alpha, ZeroMorphism( ... ) )
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "alpha", "object1", "object2" ],
        variable_filters := [ IsDummyCategory, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "PreCompose( cat, alpha, ZeroMorphism( cat, object1, object2 ) )",
        dst_template := "ZeroMorphism( cat, Source( alpha ), object2 )",
    )
);

# normalize
#ApplyLogicTemplate(
#    rec(
#        variable_names := [ "additive_closure_morphism", "i", "j" ],
#        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
#        src_template := "List( MorphismMatrix( additive_closure_morphism ), row -> List( row, Source ) )[i][j]",
#        dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
#    )
#);

ApplyLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism", "i", "j" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "Source( MorphismMatrix( additive_closure_morphism )[i][j] )",
        dst_template := "ObjectList( Source( additive_closure_morphism ) )[i]",
    )
);

# SumOfMorphisms( List( ... , KroneckerDelta( ..., ..., value, 0 ) ) ) => value
ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "list", "other_index", "value", "source", "target" ],
        variable_filters := [ IsDummyCategory, IsList, IsInt, IsDummyCategoryMorphism, IsDummyCategoryObject, IsDummyCategoryObject ],
        src_template := "SumOfMorphisms( cat, source, List( list, i -> CAP_JIT_INTERNAL_EXPR_CASE( i = other_index, value, true, ZeroMorphism( cat, source, target ) ) ), target )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( other_index in list, (i -> value)(other_index), true, ZeroMorphism( cat, source, target ) )",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "cat", "condition", "value1", "value2", "mor2" ],
        src_template := "IsCongruentForMorphisms( cat, CAP_JIT_INTERNAL_EXPR_CASE( condition, value1, true, value2 ), mor2 )",
        dst_template := "CAP_JIT_INTERNAL_EXPR_CASE( condition, IsCongruentForMorphisms( cat, value1, mor2 ), true, IsCongruentForMorphisms( cat, value2, mor2 ) )",
    )
);

ApplyLogicTemplate(
    rec(
        variable_names := [ "list", "list2", "value1", "value2" ],
        src_template := "ForAll( list, x -> ForAll( list2, y -> CAP_JIT_INTERNAL_EXPR_CASE( y in list2, value1, true, value2 ) ) )",
        dst_template := "ForAll( list, x -> ForAll( list2, y -> CAP_JIT_INTERNAL_EXPR_CASE( true, value1, true, value2 ) ) )",
    )
);

AssertLemma( );



AssertProposition( );
