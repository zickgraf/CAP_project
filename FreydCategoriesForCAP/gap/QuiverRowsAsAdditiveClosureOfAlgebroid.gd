# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Quiver rows

####################################
##
#! @Section GAP Categories
##
####################################

#DeclareCategory( "IsQuiverRowsObject",
#                 IsCapCategoryObject );
#
#DeclareCategory( "IsQuiverRowsMorphism",
#                 IsCapCategoryMorphism );
#
#DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_QUIVER_ROWS" );
#
#DeclareCategory( "IsQuiverRowsCategory",
#                 IsCapCategory );
#
#####################################
###
##! @Section Constructors
###
#####################################
#
#DeclareAttribute( "QuiverRows",
#                  IsQuiverAlgebra );
#
#DeclareAttribute( "QuiverRowsDescentToZDefinedByBasisPaths",
#                  IsQuiverAlgebra );
#
#DeclareAttribute( "QuiverRowsDescentToZDefinedByBasisPaths",
#                  IsQuiverRowsCategory );
#
DeclareOperation( "QuiverRowsAsAdditiveClosureOfAlgebroid",
                  [ IsQuiverAlgebra, IsBool ] );

#DeclareOperation( "QuiverRowsObject",
#                  [ IsList, IsQuiverRowsCategory ] );
#
#DeclareOperation( "AsQuiverRowsObject",
#                  [ IsQuiverVertex, IsQuiverRowsCategory ] );
#
#DeclareOperation( "QuiverRowsMorphism",
#                  [ IsQuiverRowsObject, IsList, IsQuiverRowsObject ] );
#
#DeclareOperation( "AsQuiverRowsMorphism",
#                  [ IsQuiverAlgebraElement, IsQuiverRowsCategory ] );
#
#DeclareOperation( "\/",
#                  [ IsQuiverAlgebraElement, IsQuiverRowsCategory ] );
#
#DeclareOperation( "\/",
#                  [ IsPath, IsQuiverRowsCategory ] );
#
#####################################
###
##! @Section Attributes
###
#####################################
#
#DeclareAttribute( "UnderlyingQuiverAlgebra",
#                  IsQuiverRowsCategory );
#
#DeclareAttribute( "UnderlyingQuiver",
#                  IsQuiverRowsCategory );
#
#DeclareAttribute( "ListOfQuiverVertices",
#                  IsQuiverRowsObject );
#
#DeclareAttribute( "NrSummands",
#                  IsQuiverRowsObject );
#
#DeclareAttribute( "MorphismMatrix",
#                  IsQuiverRowsMorphism );
#
#DeclareAttribute( "NrRows",
#                  IsQuiverRowsMorphism );
#
#DeclareAttribute( "NrCols",
#                  IsQuiverRowsMorphism );
#
#DeclareAttribute( "AsListListOfMatrices",
#                  IsQuiverRowsMorphism );
#
#DeclareAttribute( "SortedRepresentative",
#                  IsQuiverRowsObject );
#
#DeclareAttribute( "IsomorphismToSortedRepresentative",
#                  IsQuiverRowsObject );
#
#DeclareAttribute( "IsomorphismFromSortedRepresentative",
#                  IsQuiverRowsObject );
#
#DeclareAttribute( "PermutationToSortedRepresentative",
#                  IsQuiverRowsObject );
#
#####################################
###
##! @Section Operators
###
#####################################
#
#DeclareOperation( "\[\]",
#                  [ IsQuiverRowsMorphism, IsInt ] );
#
#DeclareOperation( "\[\]",
#                  [ IsQuiverRowsObject, IsInt ] );
#
#DeclareOperation( "\*",
#                  [ IsQuiverRowsMorphism, IsQuiverRowsMorphism ] );
#
#DeclareGlobalFunction( "CAP_INTERNAL_MORPHISM_BETWEEN_DIRECT_SUMS_LIST_LIST" );
#
#DeclareGlobalFunction( "CAP_INTERNAL_QUIVER_ROWS_MORPHISM_AS_LIST_LIST" );
