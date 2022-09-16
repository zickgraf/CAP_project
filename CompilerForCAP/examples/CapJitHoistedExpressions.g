#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "CompilerForCAP" );
#! true

##
# TODO

#func :=  function ( cat_1, objects_1, T_1, tau_1, P_1 )
#     return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes(
#        rec( ), cat_1,
#        T_1, P_1,
#        AsList, List( [ 1 .. Length( T_1 ) ], i_2 ->
#            Sum( [ 1 .. Length( objects_1 ) ], j_3 ->
#                \*(
#                    List( tau_1, x_4 -> AsList( x_4 ) )[j_3][i_2],
#                    Product( List( objects_1, x_4 -> Length( x_4 ) ){[ 1 .. (j_3 - 1) ]} )
#                )
#            )
#        )
#    );
# end;
#compiled_func := CapJitCompiledFunction( func );
#Display( compiled_func );
#
#Error("asd1");

func := x_1 ->
    List( [ 1 .. 2 ], x_2 ->
        List( [ 1 .. 3 ], x_3 ->
            List( [ 1 .. 4 ], x_4 ->
                List( [ 1 .. 5 ], x_5 ->
                    List( [ 1 .. x_3 ], x_6 ->
                        ((x_6 + 6) + (x_5 + 5)) + (x_4 + 4)
                    )
                )
            )
        )
    );

func := x_1 ->
    List( [ 1 .. 2 ], x_2 ->
        List( [ 1 .. 3 ], x_3 ->
            List( [ 1 .. 4 ], x_4 ->
                List( [ 1 .. 5 ], x_5 ->
                    List( [ 1 .. x_3 ], function ( x_6 )
                        local tmp_6;
                        tmp_6 := x_6 + 6;
                        return (tmp_6 + (x_5 + 5)) + (x_4 + 4);
                    end )
                )
            )
        )
    );

func := x_1 ->
    List( [ 1 .. x_1 ], x_2 ->
        List( [ 1 .. x_2 ], x_3 ->
            List( [ 1 .. x_3 ], x_4 ->
                List( [ 1 .. x_4 ], x_5 ->
                    List( [ 1 .. x_5 ], x_6 ->
                        ((x_6 + 6) + (x_5 + 5)) + ((x_6 + 6) + (x_4 + 4))
                    )
                )
            )
        )
    );

#func := x_1 ->
#    extracted_1 := List( [ 1 .. 3 ], x_3 ->
#        List( [ 1 .. x_3 ], x_6 ->
#            x_6 + 6
#        )
#    );
#    extracted_2 := List( [ 1 .. 5 ], x_5 ->
#        x_5 + 5
#    );
#    extracted_3 := List( [ 1 .. 3 ], x_3 ->
#        List( [ 1 .. 5 ], x_5 ->
#            List( [ 1 .. x_3 ], x_6 ->
#                extracted_1[x_3][x_6] + extracted_2[x_5]
#            )
#        )
#    )
#    extracted_4 := List( [ 1 .. 4 ], x_4 ->
#        x_4 + 4
#    );
#    extraced_5 := List( [ 1 .. 3 ], x_3 ->
#        List( [ 1 .. 4 ], x_4 ->
#            List( [ 1 .. 5 ], x_5 ->
#                List( [ 1 .. x_3 ], x_6 ->
#                    extracted_3[x_3][x_5][x_6] + extracted_4[x_4]
#                )
#            )
#        )
#    );
#    List( [ 1 .. 2 ], x_2 ->
#        extraced_5
#    );
#
#func := x_1 ->
#    hoisted_1 := [ 1 .. 2 ];
#    hoisted_2 := [ 1 .. 3 ];
#    hoisted_3 := [ 1 .. 4 ];
#    hoisted_4 := [ 1 .. 5 ];
#    hoisted_5 := List( hoisted_2, x_3 ->
#        [ 1 .. x_3 ];
#    );
#    hoisted_6 := List( hoisted_2, x_3 ->
#        List( hoisted_5[x_3], x_6 ->
#            x_6 + 6;
#        )
#    );
#    hoisted_7 := List( hoisted_4, x_5 ->
#        x_5 + 5;
#    );
#    hoisted_8 := List( hoisted_2, x_3 ->
#        List( hoisted_4, x_5 ->
#            List( hoisted_5[x_3], x_6 ->
#                hoisted_6[x_3][x_6] + hoisted_7[x_5];
#            )
#        )
#    );
#    hoisted_9 := List( hoisted_3, x_4 ->
#        x_4 + 4;
#    );
#    hoisted_10 := List( hoisted_2, x_3 ->
#        List( hoisted_3, x_4 ->
#            List( hoisted_4, x_5 ->
#                List( hoisted_5[x_3], x_6 ->
#                    hoisted_8[x_3][x_5][x_6] + hoisted_9[x_4]
#                )
#            )
#        )
#    );
#    List( hoisted_1, x_2 ->
#        hoisted_10
#    );

#myfunc := function( args... )
#    return args;
#end;
#
#func := x_1 ->
#    List( [ 1 .. 2 ], x_2 ->
#        List( [ 1 .. 3 ], x_3 ->
#            List( [ 1 .. 4 ], x_4 ->
#                List( [ 1 .. 5 ], x_5 ->
#                    List( [ 1 .. x_3 ], x_6 ->
#                        myfunc( myfunc( myfunc( x_6 + 6 ), x_5 + 5 ), x_4 + 4 )
#                    )
#                )
#            )
#        )
#    );



#func := x_1 ->
#    extracted_3 := List( [ 1 .. 3 ], x_3 ->
#        [ 1 .. x_3 ]
#    );
#    extracted_4 := List( [ 1 .. 4 ], x_4 ->
#        x_4 + 4
#    );
#    extracted_5 := List( [ 1 .. 5 ], x_5 ->
#        x_5 + 5
#    );
#    List( [ 1 .. 2 ], x_2 ->
#        List( [ 1 .. 3 ], x_3 ->
#            extracted_6 := List( extracted_3[key_3], x_6 ->
#                x_6 + 6
#            );
#            List( [ 1 .. 4 ], x_4 ->
#                List( [ 1 .. 5 ], x_5 ->
#                    List( extracted_3[key_3], x_6 ->
#                        (extracted_6[key_6] + extraced_5[x_5]) + extracted_4[key_4]
#                    )
#                )
#            )
#        )
#    );

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
tree := CapJitDeduplicatedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!   local domain_1_1, extracted_2_1, extracted_3_1, hoisted_4_1, hoisted_5_1, hoisted_6_1, hoisted_7_1, deduped_8_1;
#!     domain_1_1 := [ 1 .. 2 ];
#!     deduped_8_1 := ListWithKeys(
#!         domain_1_1,
#!         function ( key_2, x_2 )
#!             return (
#!                 [ 1 .. x_2 ]
#!             );
#!         end
#!     );
#!     hoisted_5_1 := [ 1 .. 3 ];
#!     hoisted_4_1 := [ 1 .. 4 ];
#!     hoisted_7_1 := ListWithKeys(
#!         hoisted_5_1,
#!         function ( key_2, x_2 )
#!             return (
#!                 ListWithKeys(
#!                     hoisted_4_1,
#!                     function ( key_3, x_3 )
#!                         return (
#!                             x_3 + 4
#!                         );
#!                     end
#!                 )
#!             );
#!         end
#!     );
#!     hoisted_6_1 := ListWithKeys(
#!         hoisted_5_1,
#!         function ( key_2, x_2 )
#!             return (
#!                 x_2 + 3
#!             );
#!         end
#!     );
#!     extracted_3_1 := deduped_8_1;
#!     extracted_2_1 := deduped_8_1;
#!     return (
#!         ListWithKeys(
#!             domain_1_1,
#!             function ( key_2, x_2 )
#!               local hoisted_1_2, hoisted_2_2, hoisted_3_2;
#!                 hoisted_3_2 := extracted_3_1[key_2];
#!                 hoisted_1_2 := extracted_2_1[key_2];
#!                 hoisted_2_2 := ListWithKeys(
#!                     hoisted_1_2,
#!                     function ( key_3, x_3 )
#!                         return (
#!                             x_3 + 5
#!                         );
#!                     end
#!                 );
#!                 return (
#!                     ListWithKeys(
#!                         hoisted_5_1,
#!                         function ( key_3, x_3 )
#!                           local extracted_2_3, extracted_4_3, hoisted_5_3;
#!                             hoisted_5_3 := hoisted_6_1[key_3];
#!                             extracted_4_3 := ListWithKeys(
#!                                 hoisted_4_1,
#!                                 function ( key_4, x_4 )
#!                                     return (
#!                                         ListWithKeys(
#!                                             hoisted_1_2,
#!                                             function ( key_5, x_5 )
#!                                                 return (
#!                                                     hoisted_2_2[key_5] + hoisted_5_3
#!                                                 );
#!                                             end
#!                                         )
#!                                     );
#!                                 end
#!                             );
#!                             extracted_2_3 := hoisted_7_1[key_3];
#!                             return (
#!                                 ListWithKeys(
#!                                     hoisted_4_1,
#!                                     function ( key_4, x_4 )
#!                                       local extracted_3_4, hoisted_4_4;
#!                                         hoisted_4_4 := extracted_2_3[key_4];
#!                                         extracted_3_4 := extracted_4_3[key_4];
#!                                         return (
#!                                             ListWithKeys(
#!                                                 hoisted_3_2,
#!                                                 function ( key_5, x_5 )
#!                                                     return (
#!                                                         extracted_3_4[key_5] + hoisted_4_4
#!                                                     );
#!                                                 end
#!                                             )
#!                                         );
#!                                     end
#!                                 )
#!                             );
#!                         end
#!                     )
#!                 );
#!             end
#!         )
#!     );
#! end
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + hoisted_1_1 + (y_2 + hoisted_1_1);
#!         end );
#! end

Error("asd");

##
# hoisting with deduplication
func := function( x )
    return List( [ 1 .. 9 ], y -> (y + (x + 1)) + (y + (x + 1)) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + hoisted_1_1 + (y_2 + hoisted_1_1);
#!         end );
#! end

##
# hoisting of whole functions
func := function( x )
    return List( [ 1 .. 9 ], y -> y + List( [ 1 .. 9 ], z -> x + z ) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := List( [ 1 .. 9 ], function ( z_2 )
#!             return x_1 + z_2;
#!         end );
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + hoisted_1_1;
#!         end );
#! end

##
# no hoisting of constants
func := function( x )
    return List( [ 1 .. 9 ], y -> y + 1 ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + 1;
#!         end );
#! end

##
# hoisting of returned expressions
func := function( x )
    return List( [ 1 .. 9 ], y -> x + 1 ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return hoisted_1_1;
#!         end );
#! end

##
# hoisting of assigned expressions
func := function( x )
    return List( [ 1 .. 9 ], function( y )
        local z; z := x + 1; return z; end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             local z_2;
#!             z_2 := hoisted_1_1;
#!             return z_2;
#!         end );
#! end

##
# hosted expressions inside hosted expressions
func := function( x )
    return List( [ 1 .. 9 ], function( y )
        return List( [ 1 .. 9 ], z -> z + (1 + 1) ); end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1, hoisted_2_1;
#!     hoisted_1_1 := 1 + 1;
#!     hoisted_2_1 := List( [ 1 .. 9 ], function ( z_2 )
#!             return z_2 + hoisted_1_1;
#!         end );
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return hoisted_2_1;
#!         end );
#! end

##
# deduplication of more complex trees, e.g. functions
func := function( list )
    return List( [ 1 .. 9 ], function( y )
        return (y + Sum( list, a -> a )) + Sum( list, a -> a ); end ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( list_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := Sum( list_1, function ( a_2 )
#!             return a_2;
#!         end );
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return y_2 + hoisted_1_1 + hoisted_1_1;
#!         end );
#! end

##
# hosting of expressions in lists, e.g. function call arguments
func := function( x, func )
    return List( [ 1 .. 9 ], y -> func( x + 1, x + 1, y ) ); end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1, func_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     return List( [ 1 .. 9 ], function ( y_2 )
#!             return func_1( hoisted_1_1, hoisted_1_1, y_2 );
#!         end );
#! end

##
# restrict hoisting to if/else branches (where possible)
func := function( x )
    if x < 0 then return 0; else return y -> [ x + 1, z -> y + 1 ]; fi; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     if x_1 < 0 then
#!         return 0;
#!     else
#!         hoisted_1_1 := x_1 + 1;
#!         return function ( y_2 )
#!               local hoisted_1_2;
#!               hoisted_1_2 := y_2 + 1;
#!               return [ hoisted_1_1, function ( z_3 )
#!                         return hoisted_1_2;
#!                     end ];
#!           end;
#!     fi;
#!     return;
#! end

func := function( x )
    if x < 0 then return y -> [ x + 1, z -> y + 1 ]; else return 0; fi; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     if x_1 < 0 then
#!         hoisted_1_1 := x_1 + 1;
#!         return function ( y_2 )
#!               local hoisted_1_2;
#!               hoisted_1_2 := y_2 + 1;
#!               return [ hoisted_1_1, function ( z_3 )
#!                         return hoisted_1_2;
#!                     end ];
#!           end;
#!     else
#!         return 0;
#!     fi;
#!     return;
#! end

func := function( x )
  if x < 0 then return y -> [ y, x+1 ]; else return y -> [ y, x+1 ]; fi; end;;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedExpressions( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function ( x_1 )
#!     local hoisted_1_1;
#!     hoisted_1_1 := x_1 + 1;
#!     if x_1 < 0 then
#!         return function ( y_2 )
#!               return [ y_2, hoisted_1_1 ];
#!           end;
#!     else
#!         return function ( y_2 )
#!               return [ y_2, hoisted_1_1 ];
#!           end;
#!     fi;
#!     return;
#! end

# CapJitHoistedBindings

# we have to work hard to not write semicolons so AutoDoc
# does not begin a new statement
func := EvalString( ReplacedString( """function (  )
  local var1, func1, func2@
    
    var1 := 1@
    
    func1 := function ( )
      local var2, var3@
        
        var2 := var1 + 1@
        
        var3 := var2 + 2@
        
        return var3@
        
    end@
    
    func2 := function ( )
      local var4, var5@
        
        var4 := var1 + 1@
        
        var5 := var4 + 2@
        
        return var5@
        
    end@
    
    return [ func1, func2 ]@
    
end""", "@", ";" ) );;

tree := ENHANCED_SYNTAX_TREE( func );;
tree := CapJitHoistedBindings( tree );;
compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );;
Display( compiled_func );
#! function (  )
#!     local var1_1, func1_1, func2_1, hoisted_3_1, hoisted_4_1;
#!     var1_1 := 1;
#!     hoisted_3_1 := var1_1 + 1;
#!     hoisted_4_1 := hoisted_3_1 + 2;
#!     func2_1 := function (  )
#!           return hoisted_4_1;
#!       end;
#!     func1_1 := function (  )
#!           return hoisted_4_1;
#!       end;
#!     return [ func1_1, func2_1 ];
#! end

#! @EndExample
