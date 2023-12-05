LoadPackage( "FreydCategoriesForCAP", false );

R := DummyRing( );;
k := DummyCommutativeRing( );

# we view R as a k-algebra
CapJitAddTypeSignature( "*", [ RingElementFilter( k ), RingElementFilter( R ) ], RingElementFilter( R ) );

cat := RingAsCategory( R : FinalizeCategory := false );;
SetCommutativeRingOfLinearCategory( cat, k );
AddMultiplyWithElementOfCommutativeRingForMorphisms( cat, { cat, lambda, mor } -> RingAsCategoryMorphism( cat, lambda * UnderlyingRingElement( mor ) ) );
Finalize( cat );

LoadPackage( "CompilerForCAP", false );
CapJitEnableProofAssistantMode( );
SetCurrentCategory( cat, "the category defined by a $k$-algebra $R$" );

StateProposition( "is_linear_category", function ( name )
    
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

# MultiplyWithElementOfCommutativeRingForMorphisms is well-defined
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

# MultiplyWithElementOfCommutativeRingForMorphisms is associative
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "k", "l", "r" ],
        variable_filters := [ RingElementFilter( k ), RingElementFilter( k ), RingElementFilter( R ) ],
        src_template := "k * (l * r)",
        dst_template := "(k * l) * r",
    ),
    cat, [ RingElementFilter( k ), RingElementFilter( k ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# MultiplyWithElementOfCommutativeRingForMorphisms is distributive from the right
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "k", "l", "r" ],
        variable_filters := [ RingElementFilter( k ), RingElementFilter( k ), RingElementFilter( R ) ],
        src_template := "(k + l) * r",
        dst_template := "k * r +  l * r",
    ),
    cat, [ RingElementFilter( k ), RingElementFilter( k ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# MultiplyWithElementOfCommutativeRingForMorphisms is distributive from the left
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "k", "r", "s" ],
        variable_filters := [ RingElementFilter( k ), RingElementFilter( R ), RingElementFilter( R ) ],
        src_template := "k * (r + s)",
        dst_template := "k * r +  k * s",
    ),
    cat, [ RingElementFilter( k ), RingElementFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# MultiplyWithElementOfCommutativeRingForMorphisms has a neutral element
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "k", "r" ],
        variable_filters := [ RingFilter( k ), RingElementFilter( R ) ],
        src_template := "One( k ) * r",
        dst_template := "r",
    ),
    cat, [ RingFilter( k ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# composition is linear with regard to MultiplyWithElementOfCommutativeRingForMorphisms in the first component
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "k", "r", "s" ],
        variable_filters := [ RingElementFilter( k ), RingElementFilter( R ), RingElementFilter( R ) ],
        src_template := "k * (r * s)",
        dst_template := "(k * r) * s",
    ),
    cat, [ RingElementFilter( k ), RingElementFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );

# composition is linear with regard to MultiplyWithElementOfCommutativeRingForMorphisms in the second component
StateNextLemma( );

ApplyLogicTemplateAndReturnLaTeXString(
    rec(
        variable_names := [ "k", "r", "s" ],
        variable_filters := [ RingElementFilter( k ), RingElementFilter( R ), RingElementFilter( R ) ],
        src_template := "k * (r * s)",
        dst_template := "r * (k * s)",
    ),
    cat, [ RingElementFilter( k ), RingElementFilter( R ), RingElementFilter( R ) ], "="
);

PrintLemma( );
AssertLemma( );



AssertProposition( );
