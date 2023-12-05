LoadPackage( "CAP", false );

cat := CreateCapCategoryWithDataTypes(
    "MonoidAsCategory( ZZ )", IsCapCategory,
    IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryTwoCell,
    IsChar, IsInt, fail
);

unique_object := AsCapCategoryObject( cat, '*' );

AddIsWellDefinedForMorphisms( cat,
    { cat, mor } -> IsInt( AsInteger( mor ) )
);
AddIsCongruentForMorphisms( cat,
    { cat, mor1, mor2 } -> AsInteger( mor1 ) = AsInteger( mor2 )
);
AddIsEqualForObjects( cat,
    { cat, obj1, obj2 } -> true
);
AddPreCompose( cat,
    { cat, mor1, mor2 } -> AsCapCategoryMorphism( cat,
        Source( mor1 ), AsInteger( mor1 ) * AsInteger( mor2 ), Target( mor2 )
    )
);
AddIdentityMorphism( cat,
    { cat, obj } -> AsCapCategoryMorphism( cat,
        obj, 1, obj
    )
);

Finalize( cat );

LoadPackage( "CompilerForCAP", false );
CapJitEnableProofAssistantMode( );
SetCurrentCategory( cat, "$\\MonoidAsCategory(\\ZZ)$" ); # TODO: Current vs Active

StateProposition( "is_category", function ( name )
    
    #if name = "alpha" then
    #    
    #    return "M__m__n"; # TODO
    #    return rec(
    #        type := "morphism",
    #        string := "\\bboxed{M}",
    #        source := "\\bboxed{m}",
    #        target := "\\bboxed{n}",
    #    );
    #    
    #fi;
    
    return name;
    
end );

# PreCompose well-defined
StateNextLemma( );

PrintLemma( );

AssumeValidInputs( );

PrintLemma( );
AssertLemma( );

# PreCompose associative
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "a", "b", "c" ],
        variable_filters := [ IsInt, IsInt, IsInt ],
        src_template := "a * (b * c)",
        dst_template := "(a * b) * c",
    ),
    cat, [ "integer", "integer", "integer" ], "=", "\\rlap{.}"
);

PrintLemma( );
AssertLemma( );

# IdentityMorphism well-defined
StateNextLemma( );

PrintLemma( );

AssumeValidInputs( );

PrintLemma( );
AssertLemma( );

# IdentityMorphism left-neutral
StateNextLemma( );

PrintLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "a" ],
        variable_filters := [ IsInt ],
        src_template := "1 * a",
        dst_template := "a",
    ),
    cat, [ "integer" ], "=", "\\rlap{.}"
);;

PrintLemma( );
AssertLemma( );

# IdentityMorphism right-neutral
StateNextLemma( );

PrintLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "a" ],
        variable_filters := [ IsInt ],
        src_template := "a * 1",
        dst_template := "a",
    ),
    cat, [ "integer" ], "=", "\\rlap{.}"
);;

PrintLemma( );
AssertLemma( );



AssertProposition( );
