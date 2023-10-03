LoadPackage( "FreydCategoriesForCAP", false );
LoadPackage( "QPA", false );
LoadPackage( "Algebroids", false );

CapJitAddTypeSignature( "Label", [ IsObjectInFpCategory ], IsStringRep );

quiver := RightQuiver( "Q(a,b,c)[]" );
F := FreeCategory( quiver );
ZZZ := HomalgRingOfIntegers( );
L := LinearClosure( ZZZ, F, ReturnTrue );
#kQ := PathAlgebra( HomalgFieldOfRationals( ), quiver );
#Aoid := Algebroid( kQ );

#a := SetOfObjects( Aoid )[1];

#add := AdditiveClosure( Aoid );

a := SetOfObjects( F )[1];
b := SetOfObjects( F )[2];
c := SetOfObjects( F )[3];

a_L := LinearClosureObject( L, a );
b_L := LinearClosureObject( L, b );
c_L := LinearClosureObject( L, c );

add := AdditiveClosure( L );

a_add := a_L / add;
b_add := b_L / add;
c_add := c_L / add;

Assert( 0, not CanCompute( add, "ProjectionInFactorOfDirectSumWithGivenDirectSum" ) );

#pi_2 := BasisOfExternalHom( DirectSum( [ a_add, a_add, a_add ] ), a_add )[2];
pi_2 := BasisOfExternalHom( DirectSum( [ a_add, b_add, c_add ] ), b_add )[1];

#SetInfoLevel( InfoCategoryConstructor, 3 );

dummy := DummyCategory( rec(
    list_of_operations_to_install := [
        "IsCongruentForMorphisms",
        "ZeroMorphism",
        "IdentityMorphism",
        "MultiplyWithElementOfCommutativeRingForMorphisms",
        "SumOfMorphisms",
        "DirectSum",
        "UniversalMorphismIntoDirectSumWithGivenDirectSum",
        "UniversalMorphismFromDirectSumWithGivenDirectSum",
    ],
    properties := [ "IsLinearCategoryOverCommutativeRing", "IsAbCategory" ],
    commutative_ring_of_linear_category := ZZZ,
) );

StopCompilationAtPrimitivelyInstalledOperationsOfCategory( dummy );

Assert( 0, not CanCompute( dummy, "ProjectionInFactorOfDirectSumWithGivenDirectSum" ) );

func := function ( dummy, a_dummy, b_dummy, c_dummy, abc_dummy )
  local object_function_F, morphism_function_F, object_function_L, morphism_function_L, universal_functor_on_objects, universal_functor_on_morphisms, a_L, b_L, c_L, pi;
    
    # F -> dummy
    object_function_F := function ( obj )
        
        if Label( obj ) = "a" then
            
            return a_dummy;
            
        elif Label( obj ) = "b" then
            
            return b_dummy;
            
        else # TODO
            
            return c_dummy;
            
        fi;
        
    end;
    
    morphism_function_F := function ( source, mor, range )
        
        # TODO: composition of identities
        return IdentityMorphism( dummy, source );
        
    end;
    
    # lift to L -> dummy
    object_function_L := function ( obj )
        
        return object_function_F( UnderlyingOriginalObject( obj ) );
        
    end;
    
    morphism_function_L := function ( source, mor, range )
      local coeffs, support, support_range;
        
        coeffs := CoefficientsList( mor );
        support := SupportMorphisms( mor );
        support_range := List( support, s -> morphism_function_F( object_function_F( Source( s ) ), s, object_function_F( Range( s ) ) ) );
        
        return LinearCombinationOfMorphisms( dummy, source, coeffs, support_range, range );
        
    end;
    
    # lift to add -> dummy
    
    # ExtendFunctorWithAdditiveRangeToFunctorFromAdditiveClosureOfSource
    universal_functor_on_objects := function ( A )
        local objs;
        
        objs := ObjectList( A );
        
        objs := List( objs, obj -> object_function_L( obj ) );
        
        return DirectSum( add, objs );
        
    end;
    
    universal_functor_on_morphisms := function ( source, alpha, range )
        local source_diagram, range_diagram, listlist;
        
        source_diagram := List( ObjectList( Source( alpha ) ), obj -> object_function_L( obj ) );
        range_diagram := List( ObjectList( Range( alpha ) ), obj -> object_function_L( obj ) );
        
        listlist := List( [ 1 .. NrRows( alpha ) ], i -> List( [ 1 .. NrCols( alpha ) ], j -> morphism_function_L( source_diagram[i], alpha[i,j], range_diagram[j] ) ) );
        
        return MorphismBetweenDirectSumsWithGivenDirectSums( dummy, source, source_diagram, listlist, range_diagram, range );
        
    end;
    
    a_L := LinearClosureObject( L, a );
    b_L := LinearClosureObject( L, b );
    c_L := LinearClosureObject( L, c );
    
    pi := MorphismConstructor( add,
        ObjectConstructor( add, [ a_L, b_L, c_L ] ),
        [ [ ZeroMorphism( L, a_L, b_L ) ], [ LinearClosureMorphismNC( L, b_L, [ 1 ], [ IdentityMorphism( F, b ) ], b_L ) ], [ ZeroMorphism( L, c_L, b_L ) ] ],
        ObjectConstructor( add, [ b_L ] )
    );
    
    return universal_functor_on_morphisms( abc_dummy, pi, b_dummy );
    
end;

T := TerminalCategoryWithMultipleObjects( );
a_T := "a" / T;
b_T := "b" / T;
c_T := "c" / T;
abc_T := DirectSum( T, [ a_T, b_T, c_T ] );

func( T, a_T, b_T, c_T, abc_T );

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

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "obj" ],
        src_template := "UnderlyingOriginalObject( LinearClosureObject( cat, obj ) )",
        dst_template := "obj",
    )
);

#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "cat", "source", "coefficients", "support_morphisms", "range" ],
#        src_template := "CoefficientsList( LinearClosureMorphismNC( cat, source, coefficients, support_morphisms, range ) )",
#        dst_template := "coefficients",
#    )
#);
#
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "cat", "source", "coefficients", "support_morphisms", "range" ],
#        src_template := "SupportMorphisms( LinearClosureMorphismNC( cat, source, coefficients, support_morphisms, range ) )",
#        dst_template := "support_morphisms",
#    )
#);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "IsEmpty( [ ] )",
        dst_template := "true",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "element" ],
        src_template := "IsEmpty( [ element ] )",
        dst_template := "false",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "entry" ],
        src_template := "ListWithIdenticalEntries( 0, entry )",
        dst_template := "[ ]",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "entry" ],
        src_template := "ListWithIdenticalEntries( 1, entry )",
        dst_template := "[ entry ]",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "func" ],
        src_template := "ListN( [ ], [ ], func )",
        dst_template := "[ ]",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "entry_1", "entry_2", "func" ],
        src_template := "ListN( [ entry_1 ], [ entry_2 ], func )",
        dst_template := "[ func( entry_1, entry_2 ) ]",
    )
);

# TODO: the following logic templates only holds up to congruence
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "cat", "obj", "source", "tau" ],
#        src_template := "UniversalMorphismIntoDirectSumWithGivenDirectSum( cat, [ obj ], source, tau, obj )",
#        dst_template := "tau[1]",
#    )
#);

#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "cat", "source", "range" ],
#        src_template := "SumOfMorphisms( cat, source, [ ], range )",
#        dst_template := "ZeroMorphism( cat, source, range )",
#    )
#);
#
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "cat", "source", "range", "mor" ],
#        src_template := "SumOfMorphisms( cat, source, [ mor ], range )",
#        dst_template := "mor",
#    )
#);
#
#CapJitAddLogicTemplate(
#    rec(
#        variable_names := [ "cat", "mor" ],
#        src_template := "MultiplyWithElementOfCommutativeRingForMorphisms( cat, 1, mor )",
#        dst_template := "mor",
#    )
#);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "Label( a )",
        dst_template := "\"a\"",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "Label( b )",
        dst_template := "\"b\"",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "Label( c )",
        dst_template := "\"c\"",
    )
);

compiled_func := CapJitCompiledFunction( func, dummy, [ "category", "object", "object", "object", "object" ], "morphism" );

compiled_func( T, a_T, b_T, c_T, abc_T );

Display( compiled_func );
#! function ( dummy_1, a_dummy_1, aaa_dummy_1 )
#!     local deduped_1_1;
#!     deduped_1_1 := [ ZeroMorphism( dummy_1, a_dummy_1, a_dummy_1 ) ];
#!     return UniversalMorphismFromDirectSumWithGivenDirectSum( dummy_1, ListWithIdenticalEntries( 3, a_dummy_1 ), a_dummy_1, [ deduped_1_1, [ IdentityMorphism( dummy_1, a_dummy_1 ) ], deduped_1_1 ], aaa_dummy_1 );
#! end
