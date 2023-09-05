LoadPackage( "FreydCategoriesForCAP", false );
LoadPackage( "QPA", false );
LoadPackage( "Algebroids", false );

quiver := RightQuiver( "Q(a)[]" );
kQ := PathAlgebra( HomalgFieldOfRationals( ), quiver );
Aoid := Algebroid( kQ );

a := SetOfObjects( Aoid )[1];

add := AdditiveClosure( Aoid );

a_add := a / add;

Assert( 0, not CanCompute( add, "ProjectionInFactorOfDirectSumWithGivenDirectSum" ) );

pi_2 := BasisOfExternalHom( DirectSum( [ a_add, a_add, a_add ] ), a_add )[2];

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsCongruentForMorphisms",
        "ZeroMorphism",
        "IdentityMorphism",
        "DirectSum",
        "UniversalMorphismIntoDirectSumWithGivenDirectSum",
        "UniversalMorphismFromDirectSumWithGivenDirectSum",
    ],
    properties := [ "IsAbCategory" ],
) );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

Assert( 0, not CanCompute( dummy, "ProjectionInFactorOfDirectSumWithGivenDirectSum" ) );

func := function ( dummy, a_dummy, aaa_dummy )
  local object_function, morphism_function, universal_functor_on_objects, universal_functor_on_morphisms, pi;
    
    # Aoid -> dummy
    object_function := function ( obj )
        
        return a_dummy;
        
    end;
    
    morphism_function := function ( source, mor, range )
        
        if IsZeroForMorphisms( Aoid, mor ) then
            
            return ZeroMorphism( dummy, source, range );
            
        else
            
            # TODO: multiple of identity
            return IdentityMorphism( dummy, source );
            
        fi;
        
    end;
    
    # lift to add -> dummy
    
    # ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource
    universal_functor_on_objects := function ( A )
        local objs;
        
        objs := ObjectList( A );
        
        objs := List( objs, obj -> object_function( obj ) );
        
        return DirectSum( add, objs );
        
    end;
    
    universal_functor_on_morphisms := function ( source, alpha, range )
        local source_diagram, range_diagram, listlist;
        
        source_diagram := List( ObjectList( Source( alpha ) ), obj -> object_function( obj ) );
        range_diagram := List( ObjectList( Range( alpha ) ), obj -> object_function( obj ) );
        
        listlist := List( [ 1 .. NrRows( alpha ) ], i -> List( [ 1 .. NrCols( alpha ) ], j -> morphism_function( source_diagram[i], alpha[i,j], range_diagram[j] ) ) );
        
        return MorphismBetweenDirectSumsWithGivenDirectSums( dummy, source, source_diagram, listlist, range_diagram, range );
        
    end;
    
    pi := MorphismConstructor( add,
        ObjectConstructor( add, [ a, a, a ] ),
        [ [ ZeroMorphism( Aoid, a, a ) ], [ IdentityMorphism( Aoid, a ) ], [ ZeroMorphism( Aoid, a, a ) ] ],
        ObjectConstructor( add, [ a ] )
    );
    
    return universal_functor_on_morphisms( aaa_dummy, pi, a_dummy );
    
end;

T := TerminalCategoryWithMultipleObjects( );
a_T := "a" / T;
aaa_T := DirectSum( T, [ a_T, a_T, a_T ] );

func( T, a_T, aaa_T );

ReadPackage( "FreydCategoriesForCAP",
    "gap/CategoryOfRowsAsAdditiveClosureOfRingAsCategory_CompilerLogic.gi");


# additive_closure_object[i] => ObjectList( additive_closure_object )[i]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_object", "index" ],
        variable_filters := [ IsAdditiveClosureObject, IsInt ],
        src_template := "additive_closure_object[index]",
        dst_template := "ObjectList( additive_closure_object )[index]",
    )
);

# additive_closure_morphism[i, j] => MorphismMatrix( additive_closure_morphism )[i, j]
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism", "row", "column" ],
        variable_filters := [ IsAdditiveClosureMorphism, IsInt, IsInt ],
        src_template := "additive_closure_morphism[row, column]",
        dst_template := "MorphismMatrix( additive_closure_morphism )[row][column]",
    )
);

# NumberRows( additive_closure_morphism ) => Length( ObjectList( Source( additive_closure_morphism ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism" ],
        variable_filters := [ IsAdditiveClosureMorphism ],
        src_template := "NumberRows( additive_closure_morphism )",
        dst_template := "Length( ObjectList( Source( additive_closure_morphism ) ) )",
    )
);

# NumberColumns( additive_closure_morphism ) => Length( ObjectList( Range( additive_closure_morphism ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism" ],
        variable_filters := [ IsAdditiveClosureMorphism ],
        src_template := "NumberColumns( additive_closure_morphism )",
        dst_template := "Length( ObjectList( Range( additive_closure_morphism ) ) )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "path_algebra" ],
        src_template := "IsZero( ZeroImmutable( path_algebra ) )",
        dst_template := "true",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "path_algebra", "vertex" ],
        src_template := "IsZero( PathAsAlgebraElement( path_algebra, QuiverVertexAsIdentityPath( vertex ) ) )",
        dst_template := "false",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list1", "list2" ],
        src_template := "ListN( list1, list2, { x, y } -> y[1] )",
        dst_template := "List( list2, l -> l[1] )",
        new_funcs := [ [ "l" ] ],
    )
);

# TODO: the following logic template only holds up to congruence
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "obj", "source", "tau" ],
        src_template := "UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, ListWithIdenticalEntries( 1, obj ), source, tau, obj )",
        dst_template := "tau[1]",
    )
);

compiled_func := CapJitCompiledFunction( func, dummy, [ "category", "object", "object" ], "morphism" );

compiled_func( T, a_T, aaa_T );

Display( compiled_func );
#! function ( dummy_1, a_dummy_1, aaa_dummy_1 )
#!     local deduped_1_1;
#!     deduped_1_1 := [ ZeroMorphism( dummy_1, a_dummy_1, a_dummy_1 ) ];
#!     return UniversalMorphismFromDirectSumWithGivenDirectSum( dummy_1, ListWithIdenticalEntries( 3, a_dummy_1 ), a_dummy_1, [ deduped_1_1, [ IdentityMorphism( dummy_1, a_dummy_1 ) ], deduped_1_1 ], aaa_dummy_1 );
#! end
