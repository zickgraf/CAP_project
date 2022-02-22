#! @Chapter Examples and tests

#! @Section Examples

#! @Example

LoadPackage( "LinearAlgebraForCAP", false );
#! true

ReadPackage( "LinearAlgebraForCAP", "gap/CompilerLogic.gi" );
#! true

QQ := HomalgFieldOfRationals( );;


#func := function ( cat_1, arg2_1, arg3_1, arg4_1 )
#  local m_1, n_1, H_B_C_1, deduped_1_1, deduped_2_1, deduped_3_1, inline_72_inline_62_underlying_matrix_1, inline_72_inline_62_inline_61_homalg_matrix_1, inline_72_inline_62_inline_70_dimension_1, inline_47_inline_46_dimension_1, inline_87_inline_83_underlying_matrix_of_universal_morphism_1, hoisted_4_1, hoisted_5_1;
#    deduped_3_1 := [ 1 .. arg2_1 ];
#    H_B_C_1 := (List)(
#        deduped_3_1,
#        function ( j_2 )
#          return j_2;
#        end
#    );
#    return (ListN)(
#        H_B_C_1,
#        (List)(
#            deduped_3_1,
#            function ( logic_new_func_x_2 )
#              return logic_new_func_x_2;
#            end
#        ),
#        function ( source_2, row_2 )
#            return source_2;
#        end
#    );
#end;
#
#
#tree := ENHANCED_SYNTAX_TREE( func );
#
#tree := CapJitInlinedBindings( tree );
#Display( tree.bindings.BINDING_RETURN_VALUE.args.1.resolved_value.args.1 );
#Error("asd");
#tree := CapJitAppliedLogicTemplates( tree );
#
#compiled_func := ENHANCED_SYNTAX_TREE_CODE( tree );
#
#Display( compiled_func );
#
#Display( PositionSublist( String( compiled_func ), "ListN" ) <> fail );
#
#Error("finished");




# be careful not to use `MatrixCategory` because attributes are not supported
category_constructor := field -> MATRIX_CATEGORY( field );;
given_arguments := [ QQ ];;
compiled_category_name := "MatrixCategoryPrecompiled";;
package_name := "LinearAlgebraForCAP";;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name
    # hack until we can compile Toposes
    : operations := #"IsWellDefinedForObjects"
    Intersection(
        ListInstalledOperationsOfCategory(
            MATRIX_CATEGORY( QQ : no_precompiled_code )
        ),
        Union(
            RecNames( CAP_INTERNAL_CORE_METHOD_NAME_RECORD ),
            RecNames( MONOIDAL_CATEGORIES_BASIC_METHOD_NAME_RECORD ),
            RecNames( MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ),
            RecNames( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ),
            RecNames( CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ),
            RecNames( COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ),
            RecNames( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ),
            RecNames(
                RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD
            ),
            RecNames(
                RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD
            )
        )
    )
);;

MatrixCategoryPrecompiled( QQ );
#! Category of matrices over Q

# check that the compiled code is loaded automatically
# for this, we use the name of the argument of `ZeroObject`:
# for non-compiled code it is "cat", while for compiled code it is "cat_1"
cat := MatrixCategory( QQ );;
NamesLocalVariablesFunction( Last( cat!.added_functions.ZeroObject )[1] )[1];
#! "cat_1"

#! @EndExample
