# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Implementations
#

InstallValue( CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

## Basic Operations for Cartesian Categories

DirectProductOnMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, Source( alpha ), Source( beta ) )",
  output_range_getter_string := "BinaryDirectProduct( cat, Range( alpha ), Range( beta ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CoproductOnMorphisms",
  dual_arguments_reversed := false,
),

DirectProductOnMorphismsWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "object" ],
  io_type := [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CoproductOnMorphismsWithGivenCoproducts",
  dual_arguments_reversed := false,
),

CartesianAssociatorRightToLeft := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, a, BinaryDirectProduct( cat, b, c ) )",
  output_range_getter_string := "BinaryDirectProduct( cat, BinaryDirectProduct( cat, a, b ), c )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorLeftToRight",
  dual_arguments_reversed := false,
),

CartesianAssociatorRightToLeftWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorLeftToRightWithGivenCoproducts",
  dual_preprocessor_func :=
    { cat, s, a, b, c, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( c ), Opposite( s ) ],
  dual_arguments_reversed := false,
),

CartesianAssociatorLeftToRight := rec(
  filter_list := [ "category", "object", "object", "object" ],
  io_type := [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, BinaryDirectProduct( cat, a, b ), c )",
  output_range_getter_string := "BinaryDirectProduct( cat, a, BinaryDirectProduct( cat, b, c ) )",
  with_given_object_position := "both",
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorRightToLeft",
  dual_arguments_reversed := false,
),

CartesianAssociatorLeftToRightWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "object", "object", "object", "object" ],
  io_type := [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianAssociatorRightToLeftWithGivenCoproducts",
  dual_preprocessor_func := { cat, s, a, b, c, r } -> [ Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( c ), Opposite( s ) ],
  dual_arguments_reversed := false,
),

CartesianLeftUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, TerminalObject( cat ), a )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitorInverse",
),

CartesianLeftUnitorWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitorInverseWithGivenCoproduct",
  dual_arguments_reversed := false,
),

CartesianLeftUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "BinaryDirectProduct( cat, TerminalObject( cat ), a )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitor",
),

CartesianLeftUnitorInverseWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianLeftUnitorWithGivenCoproduct",
  dual_arguments_reversed := false,
),

CartesianRightUnitor := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string := "BinaryDirectProduct( cat, a, TerminalObject( cat ) )",
  output_range_getter_string := "a",
  with_given_object_position := "Source",
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitorInverse",
),

CartesianRightUnitorWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "s" ], [ "s", "a" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitorInverseWithGivenCoproduct",
  dual_arguments_reversed := false,
),

CartesianRightUnitorInverse := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string := "a",
  output_range_getter_string := "BinaryDirectProduct( cat, a, TerminalObject( cat ) )",
  with_given_object_position := "Range",
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitor",
),

CartesianRightUnitorInverseWithGivenDirectProduct := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "r" ], [ "a", "r" ] ],
  return_type := "morphism",
  dual_operation := "CocartesianRightUnitorWithGivenCoproduct",
  dual_arguments_reversed := false,
),

) );
