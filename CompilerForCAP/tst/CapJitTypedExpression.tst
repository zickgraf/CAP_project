gap> START_TEST( "CapJitTypedExpression" );

#
gap> LoadPackage( "CompilerForCAP", false );
true

#
gap> func := { cat } -> CapJitTypedExpression( [ ], { cat } -> rec( filter := IsList, element_type := rec( filter := IsInt ) ) );;
gap> ENHANCED_SYNTAX_TREE( func : given_arguments := [ CreateCapCategory( ) ] ).bindings.BINDING_RETURN_VALUE.data_type;
rec( element_type := rec( filter := <Category "IsInt"> ), 
  filter := <Category "IsList"> )

#
gap> data_type_getter := { cat } -> rec( filter := IsList, element_type := rec( filter := IsInt ) );;
gap> func := { cat } -> CapJitTypedExpression( [ ], data_type_getter );;
gap> ENHANCED_SYNTAX_TREE( func : given_arguments := [ CreateCapCategory( ) ] ).bindings.BINDING_RETURN_VALUE.data_type;
rec( element_type := rec( filter := <Category "IsInt"> ), 
  filter := <Category "IsList"> )

#
gap> STOP_TEST( "CapJitTypedExpression" );
