LoadPackage( "CAP", false : OnlyNeeded );

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

LoadPackage( "CompilerForCAP", false : OnlyNeeded );

CapJitEnableProofAssistantMode( );

# manual version
statement := function ( cat, A, B, C, D, m, n, l )
  local left, right;
    
    #CapJitAddLocalReplacement( Source( m ), A );
    #CapJitAddLocalReplacement( Target( m ), B );
    #CapJitAddLocalReplacement( Source( n ), B );
    #CapJitAddLocalReplacement( Target( n ), C );
    #CapJitAddLocalReplacement( Source( l ), C );
    #CapJitAddLocalReplacement( Target( l ), D );
    
    left := PreCompose( PreCompose( m, n ), l );
    
    right := PreCompose( m, PreCompose( n, l ) );
    
    return IsCongruentForMorphisms( left, right );
    
end;;

SetActiveCategory( cat, "$\\boldsymbol{\\mathcal{C}}(\\mathbb{Z})$" ); # TODO

StateLemma( statement, cat, [ "category", "object", "object", "object", "object", "morphism", "morphism", "morphism" ] );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "a", "b", "c" ],
        variable_filters := [ IsInt, IsInt, IsInt ],
        src_template := "a * (b * c)",
        dst_template := "(a * b) * c",
    ),
    cat, [ "integer", "integer", "integer" ], "=", "\\rlap{.}"
);

AssertLemma( );


SetActiveCategory( cat, "$\\boldsymbol{\\mathcal{C}}(\\mathbb{Z})$" );

StateProposition( "is_category" );

# PreCompose well-defined
StateNextLemma( );

AttestValidInputs( );

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

AssertLemma( );

# IdentityMorphism well-defined
StateNextLemma( );

AttestValidInputs( );

AssertLemma( );

# IdentityMorphism left-neutral
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "a" ],
        variable_filters := [ IsInt ],
        src_template := "1 * a",
        dst_template := "a",
    ),
    cat, [ "integer" ], "=", "\\rlap{.}"
);;

AssertLemma( );

# IdentityMorphism right-neutral
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "a" ],
        variable_filters := [ IsInt ],
        src_template := "a * 1",
        dst_template := "a",
    ),
    cat, [ "integer" ], "=", "\\rlap{.}"
);;

AssertLemma( );


#
AssertProposition( );
