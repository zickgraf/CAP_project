LoadPackage( "FreydCategoriesForCAP", false );

R := DummyRing( );;
cat := RingAsCategory( R );;

LoadPackage( "CompilerForCAP", false );
CapJitEnableProofAssistantMode( );
SetCurrentCategory( cat, "the category defined by a ring $R$" );

StateProposition( "is_preadditive_category", function ( name )
    
    #if name = "alpha" then
    #    
    #    return "M__m__n"; # TODO
    #    return rec(
    #        type := "morphism",
    #        string := "\\myboxed{M}",
    #        source := "\\myboxed{m}",
    #        target := "\\myboxed{n}",
    #    );
    #    
    #fi;
    
    return name;
    
end );;

# AdditionForMorphisms well-defined
StateNextLemma( );

PrintLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "ring", "a" ],
        variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
        src_template := "a in ring",
        dst_template := "true",
    ),
    cat, [ RingFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# AdditionForMorphisms associative
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "a", "b", "c" ],
        src_template := "a + (b + c)",
        dst_template := "(a + b) + c",
    ),
    cat, [ RingElementFilter( R ), RingElementFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# AdditionForMorphisms commutative
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "a", "b" ],
        src_template := "b + a",
        dst_template := "a + b",
    ),
    cat, [ RingElementFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# AdditionForMorphisms bilinear from the left
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "r", "a", "b" ],
        src_template := "r * (a + b)",
        dst_template := "r * a + r * b",
    ),
    cat, [ RingElementFilter( R ), RingElementFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# AdditionForMorphisms bilinear from the right
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "r", "a", "b" ],
        src_template := "(a + b) * r",
        dst_template := "a * r + b * r",
    ),
    cat, [ RingElementFilter( R ), RingElementFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# Zero well-defined
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "ring", "a" ],
        variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
        src_template := "a in ring",
        dst_template := "true",
    ),
    cat, [ RingFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# Zero left neutral
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "ring", "a" ],
        variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
        src_template := "Zero( ring ) + a",
        dst_template := "a",
    ),
    cat, [ RingFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# Zero right neutral
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "ring", "a" ],
        variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
        src_template := "a + Zero( ring )",
        dst_template := "a",
    ),
    cat, [ RingFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# AdditiveInverse well-defined
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "ring", "a" ],
        variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
        src_template := "-a in ring",
        dst_template := "true",
    ),
    cat, [ RingFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# AdditiveInverse left inverse
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "ring", "a" ],
        variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
        src_template := "-a + a = Zero( ring )",
        dst_template := "true",
    ),
    cat, [ RingFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# AdditiveInverse right inverse
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "ring", "a" ],
        variable_filters := [ RingFilter( R ), RingElementFilter( R ) ],
        src_template := "a + (-a) = Zero( ring )",
        dst_template := "true",
    ),
    cat, [ RingFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );



AssertProposition( );
