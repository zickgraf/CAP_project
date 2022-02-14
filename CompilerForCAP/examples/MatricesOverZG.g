#! @Chapter Examples and tests

#! @Section Examples

#! @Example

LoadPackage( "FreydCategoriesForCAP", false );;
#! true
LoadPackage( "FinSetsForCAP", false );;
#! true

# NumberRows( additive_closure_morphism ) => Length( ObjectList( Source( additive_closure_morphism ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism" ],
        variable_filters := [ IsAdditiveClosureMorphism ],
        src_template := "NumberRows( additive_closure_morphism )",
        dst_template := "Length( ObjectList( Source( additive_closure_morphism ) ) )",
        returns_value := true,
    )
);

# NumberColumns( additive_closure_morphism ) => Length( ObjectList( Range( additive_closure_morphism ) ) )
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "additive_closure_morphism" ],
        variable_filters := [ IsAdditiveClosureMorphism ],
        src_template := "NumberColumns( additive_closure_morphism )",
        dst_template := "Length( ObjectList( Range( additive_closure_morphism ) ) )",
        returns_value := true,
    )
);

category_constructor := function ( )
  local G, CG, ZZ, ZCG, RowsG;
    
    G := SymmetricGroup( 3 );;
    CG := GroupAsCategory( G : FinalizeCategory := true );;
    ZZ := HomalgRingOfIntegers( );;
    ZCG := LinearClosure( ZZ, CG : FinalizeCategory := true );;
    RowsG := AdditiveClosure( ZCG );;
    
    return RowsG;
    
end;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    [ ],
    "FreydCategoriesForCAP",
    "AdditiveClosureOfLinearClosureOverZOfGroupAsCategoryOfSymmetricGroupOf3Precompiled" :
    operations := "HomomorphismStructureOnMorphisms"
);

#! @EndExample
