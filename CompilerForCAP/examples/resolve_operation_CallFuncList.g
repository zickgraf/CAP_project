LoadPackage( "CompilerForCAP" );

#! @Chapter Examples and tests

#! @Section Tests

#! @Example

DeclareOperation( "MyOperation", [ IsInt ] );

InstallMethod( MyOperation, [ IsInt ], function( i )
    #% CAP_JIT_RESOLVE_FUNCTION
    return i; end );

myfunction := {} -> CallFuncList( MyOperation, [ 1 ] );;

compiled_func := CapJitCompiledFunction( myfunction, [] );;
Display( compiled_func );
#! function (  )
#!     return 1;
#! end

#! @EndExample
