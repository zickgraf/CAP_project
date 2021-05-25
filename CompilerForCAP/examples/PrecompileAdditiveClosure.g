#! @Chapter Examples and tests

#! @Section Examples

LoadPackage( "FreydCategoriesForCAP" );
LoadPackage( "ModulePresentationsForCAP" );
ReadPackage( "ModulePresentationsForCAP", "gap/CompilerLogic.gi");

#! @Example

QQ := HomalgFieldOfRationalsInSingular( );;

R := QQ * "x,y";

EEE := KoszulDualRing( R );

CE := RingAsCategory( EEE );

CEplus := AdditiveClosure( CE : enable_compilation := [ "HomomorphismStructureOnMorphismsWithGivenObjects" ] );

o := AsAdditiveClosureObject( RingAsCategoryUniqueObject( CE ) );
id := IdentityMorphism( o );

HomomorphismStructureOnMorphisms( id, id );

Display( Last( CEplus!.compiled_functions.HomomorphismStructureOnMorphismsWithGivenObjects ) );

# be careful not to use `MatrixCategory` because attributes are not supported
#category_constructor := field -> MATRIX_CATEGORY( field );;
#given_arguments := [ QQ ];;
#compiled_category_name := "MatrixCategoryPrecompiled";;
#package_name := "LinearAlgebraForCAP";;
#operations := [
#    "AdditionForMorphisms",
#    "PreCompose",
#    "KernelEmbedding",
#];;
#
#filepath := "precompiled_categories/MatrixCategoryPrecompiled.gi";;
#old_file_content := ReadFileFromPackageForHomalg( package_name, filepath );;
#
#CapJitPrecompileCategory(
#    category_constructor,
#    given_arguments,
#    package_name,
#    compiled_category_name :
#    operations := operations
#);
#
#new_file_content := ReadFileFromPackageForHomalg( package_name, filepath );;
#
#old_file_content = new_file_content;
##! true
#
#MatrixCategoryPrecompiled( QQ );
##! Category of matrices over Q

#! @EndExample
