LoadPackage( "FreydCategoriesForCAP", false : OnlyNeeded );

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
        "AdditionForMorphisms",
        "AdditiveInverseForMorphisms",
    ],
    properties := [
        "IsAbCategory",
    ],
) );

cat := AdditiveClosure( dummy );

LoadPackage( "CompilerForCAP", false : OnlyNeeded );

CapJitEnableProofAssistantMode( );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

SetActiveCategory( cat, "the additive closure $\\Ccat^\\oplus$ of a pre-additive category $\\Ccat$", [
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

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "lengths", "lists" ],
        variable_filters := [ IsList, IsList ],
        src_template := "DecatenationWithGivenLengths( lengths, ConcatenationWithGivenLengths( lengths, lists ) )",
        dst_template := "lists",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list", "lengths" ],
        src_template := "ConcatenationWithGivenLengths( lengths, DecatenationWithGivenLengths( lengths, list ) )",
        dst_template := "list",
    )
);

StateProposition( "has_direct_sums_via_components_of_morphisms", function ( name )
    
    if name = "alpha" then
        
        return "alpha__A__B";
        
    fi;
    
    if name = "beta" then
        
        return "beta__C__D";
        
    fi;
    
    if name = "gamma" then
        
        return "gamma__E__F";
        
    fi;
    
    if name = "objects" then
        
        return "A__l";
        
    fi;
    
    if name = "diagram" then
        
        return "A__l";
        
    fi;
    
    if name = "obj" then
        
        return "A";
        
    fi;
    
    return name;
    
end );

# DirectSum well-defined
StateNextLemma( );

AttestValidInputs( );

AssertLemma( );

# TODO
proposition := function ( cat, diagram, T, tau, i )
	
	#CapJitAddLocalReplacement( List( tau, m -> Length( ObjectList( Source( m ) ) ) )[i], Length( ObjectList( T ) ) );
    #CapJitAddLocalReplacement( List( tau, m -> Length( ObjectList( Target( m ) ) ) )[i], Length( ObjectList( diagram[i] ) ) );
    
	CapJitAddLocalReplacement( Length( ObjectList( Source( tau[i] ) ) ), Length( ObjectList( T ) ) );
    CapJitAddLocalReplacement( Length( ObjectList( Target( tau[i] ) ) ), Length( ObjectList( diagram[i] ) ) );
    
    return IsCongruentForMorphisms( cat,
		ComponentOfMorphismIntoDirectSum( cat, UniversalMorphismIntoDirectSum( cat, diagram, T, tau ), diagram, i ),
		tau[i]
	);
    
end;
StateLemma( proposition, cat, [ "category", "list_of_objects", "object", "list_of_morphisms", "integer" ] );

# TODO
proposition := function ( cat, diagram, u )
    
	CapJitAddLocalReplacement( Target( u ), DirectSum( cat, diagram ) );
	
    return IsCongruentForMorphisms( cat,
		UniversalMorphismIntoDirectSum( cat, diagram, Source( u ), List( [ 1 .. Length( diagram ) ], i -> ComponentOfMorphismIntoDirectSum( cat, u, diagram, i ) ) ),
		u
	);
    
end;
result := StateLemma( proposition, cat, [ "category", "list_of_objects", "morphism" ] );

ApplyLogicTemplate(
    rec(
        variable_names := [ "length", "func", "list" ],
        src_template := "List( [ 1 .. length ], j -> DecatenationWithGivenLengths( List( [ 1 .. length ], func ), list )[j] )",
        dst_template := "DecatenationWithGivenLengths( List( [ 1 .. length ], func ), list )",
    )
);
AssertLemma();



AssertProposition( );
