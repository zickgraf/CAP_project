# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecord.gi

#! @Chapter Monoidal Categories

#! @Section Rigid Symmetric Coclosed Monoidal Categories

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CoRankMorphism`.
#! $F: ( a ) \mapsto \mathtt{CoRankMorphism}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoRankMorphism",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoRankMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoRankMorphism",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoRankMorphism",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CoTraceMap`.
#! $F: ( alpha ) \mapsto \mathtt{CoTraceMap}(alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoTraceMap",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoTraceMap",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoTraceMap",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoTraceMap",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CoclosedCoevaluationForCoDual`.
#! $F: ( a ) \mapsto \mathtt{CoclosedCoevaluationForCoDual}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoclosedCoevaluationForCoDual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoclosedCoevaluationForCoDual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoclosedCoevaluationForCoDual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoclosedCoevaluationForCoDual",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CoclosedCoevaluationForCoDualWithGivenTensorProduct`.
#! $F: ( s, a, r ) \mapsto \mathtt{CoclosedCoevaluationForCoDualWithGivenTensorProduct}(s, a, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoclosedCoevaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCoclosedCoevaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddCoclosedCoevaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddCoclosedCoevaluationForCoDualWithGivenTensorProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `InternalCoHomTensorProductCompatibilityMorphismInverse`.
#! $F: ( list ) \mapsto \mathtt{InternalCoHomTensorProductCompatibilityMorphismInverse}(list)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverse",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverse",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverse",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects`.
#! $F: ( source, list, range ) \mapsto \mathtt{InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects}(source, list, range)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddInternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `IsomorphismFromInternalCoHomToTensorProduct`.
#! $F: ( a, b ) \mapsto \mathtt{IsomorphismFromInternalCoHomToTensorProduct}(a, b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromInternalCoHomToTensorProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `IsomorphismFromTensorProductToInternalCoHom`.
#! $F: ( a, b ) \mapsto \mathtt{IsomorphismFromTensorProductToInternalCoHom}(a, b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsomorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismFromTensorProductToInternalCoHom`.
#! $F: ( a, b ) \mapsto \mathtt{MorphismFromTensorProductToInternalCoHom}(a, b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalCoHom",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismFromTensorProductToInternalCoHomWithGivenObjects`.
#! $F: ( s, a, b, r ) \mapsto \mathtt{MorphismFromTensorProductToInternalCoHomWithGivenObjects}(s, a, b, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromTensorProductToInternalCoHomWithGivenObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismToCoBidual`.
#! $F: ( a ) \mapsto \mathtt{MorphismToCoBidual}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismToCoBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToCoBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToCoBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToCoBidual",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismToCoBidualWithGivenCoBidual`.
#! $F: ( a, r ) \mapsto \mathtt{MorphismToCoBidualWithGivenCoBidual}(a, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToCoBidualWithGivenCoBidual",
                  [ IsCapCategory, IsList ] );