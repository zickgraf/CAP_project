#! @Chapter Examples and Tests

#! @Section Adelman snake lemma

LoadPackage( "FreydCategoriesForCAP" );;
LoadPackage( "GeneralizedMorphismsForCAP" );;

#! @Example
#! #@if IsPackageMarkedForLoading( "QPA", ">= 2.0" )
LoadPackage( "Algebroids", false );
#! true
DeactivateDefaultCaching();
SwitchGeneralizedMorphismStandard( "span" );;
snake_quiver := RightQuiver( "Q(6)[a:1->2,b:2->3,c:3->4]" );;
kQ := PathAlgebra( HomalgFieldOfRationals(), snake_quiver );;
Aoid := Algebroid( kQ, [ kQ.abc ] );;
CapCategorySwitchLogicOff( Aoid );;
m := SetOfGeneratingMorphisms( Aoid );;
a := m[1];;
b := m[2];;
c := m[3];;
add := AdditiveClosure( Aoid );;
DisableInputSanityChecks( add );;
adelman := AdelmanCategory( add );;
#a := AsAdditiveClosureMorphism( a );;
#b := AsAdditiveClosureMorphism( b );;
#c := AsAdditiveClosureMorphism( c );;
#aa := AsAdelmanCategoryMorphism( a );;
#bb := AsAdelmanCategoryMorphism( b );;
#cc := AsAdelmanCategoryMorphism( c );;
#dd := CokernelProjection( aa );;
#ee := CokernelColift( aa, PreCompose( bb, cc ) );;
#ff := KernelEmbedding( ee );;
#gg := KernelEmbedding( cc );;
#hh := KernelLift( cc, PreCompose( aa, bb ) );;
#ii := CokernelProjection( hh );;
#fff := AsGeneralizedMorphism( ff );;
#ddd := AsGeneralizedMorphism( dd );;
#bbb := AsGeneralizedMorphism( bb );;
#ggg := AsGeneralizedMorphism( gg );;
#iii := AsGeneralizedMorphism( ii );;
#p := PreCompose( [ fff, PseudoInverse( ddd ), bbb, PseudoInverse( ggg ), iii ] );;
#IsHonest( p );
#Error("finished");
##! true
#jj := KernelObjectFunctorial( bb, dd, ee );;
#pp := HonestRepresentative( p );;
#comp := PreCompose( jj, pp );;
#IsZero( comp );
#! true
#! #@fi
# @EndExample

ReadPackage( "Algebroids", "gap/CompilerLogic.gi" );

# only valid for the construction above
# FIXME: IsInt should be IsRat, but specializations of types are not yet supported by CompilerForCAP
CapJitAddTypeSignature( "CoefficientsOfPaths", [ IsList, IsPathAlgebraElement ], rec( filter := IsList, element_type := rec( filter := IsInt ) ) );
CapJitAddTypeSignature( "CoefficientsOfPaths", [ IsList, IsQuotientOfPathAlgebraElement ], rec( filter := IsList, element_type := rec( filter := IsInt ) ) );

tree := CapJitCompiledCAPOperationAsEnhancedSyntaxTree( add, "MereExistenceOfSolutionOfLinearSystemInAbCategory" );

func := function ( cat, a_arg, b_arg, c_arg )
  local a, b, c, aa, bb, cc, dd, ee, ff, gg, hh, ii;
    a := AsAdditiveClosureMorphism( UnderlyingCategory( cat ), a_arg );;
    b := AsAdditiveClosureMorphism( UnderlyingCategory( cat ), b_arg );;
    c := AsAdditiveClosureMorphism( UnderlyingCategory( cat ), c_arg );;
    aa := AsAdelmanCategoryMorphism( cat, a );;
    bb := AsAdelmanCategoryMorphism( cat, b );;
    cc := AsAdelmanCategoryMorphism( cat, c );;
    dd := CokernelProjection( cat, aa );
    ee := CokernelColift( cat, aa, PreCompose( cat, bb, cc ) );
    ff := KernelEmbedding( cat, ee );
    gg := KernelEmbedding( cat, cc );
    hh := KernelLift( cat, cc, PreCompose( cat, aa, bb ) );
    ii := CokernelProjection( cat, hh );
    return [ dd, ee ];
    #fff := AsGeneralizedMorphism( ff );
    #ddd := AsGeneralizedMorphism( dd );
    #bbb := AsGeneralizedMorphism( bb );
    #ggg := AsGeneralizedMorphism( gg );
    #iii := AsGeneralizedMorphism( ii );
    #p := PreComposeList( [ fff, PseudoInverse( ddd ), bbb, PseudoInverse( ggg ), iii ] );
    #return HonestRepresentative( p );
end;

compiled_func := CapJitCompiledFunction( func, [ [
    rec( filter := IsCapCategory, category := adelman ),
    rec( filter := Aoid!.morphism_representation, category := Aoid ),
    rec( filter := Aoid!.morphism_representation, category := Aoid ),
    rec( filter := Aoid!.morphism_representation, category := Aoid ),
], fail ] );
