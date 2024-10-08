# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Declarations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE CAP_project/CAP/gap/MethodRecordTools.gi

#! @Chapter Monoidal Categories

#! @Section Add-methods

#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CoevaluationForDual`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( a ) \mapsto \mathtt{CoevaluationForDual}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddCoevaluationForDual",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `CoevaluationForDualWithGivenTensorProduct`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( s, a, r ) \mapsto \mathtt{CoevaluationForDualWithGivenTensorProduct}(s, a, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddCoevaluationForDualWithGivenTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `IsomorphismFromInternalHomToTensorProductWithDualObject`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( a, b ) \mapsto \mathtt{IsomorphismFromInternalHomToTensorProductWithDualObject}(a, b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromInternalHomToTensorProductWithDualObject",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddIsomorphismFromInternalHomToTensorProductWithDualObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `IsomorphismFromTensorProductWithDualObjectToInternalHom`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( a, b ) \mapsto \mathtt{IsomorphismFromTensorProductWithDualObjectToInternalHom}(a, b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddIsomorphismFromTensorProductWithDualObjectToInternalHom",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddIsomorphismFromTensorProductWithDualObjectToInternalHom",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismFromBidual`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( a ) \mapsto \mathtt{MorphismFromBidual}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddMorphismFromBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismFromBidualWithGivenBidual`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( a, s ) \mapsto \mathtt{MorphismFromBidualWithGivenBidual}(a, s)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddMorphismFromBidualWithGivenBidual",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismFromInternalHomToTensorProduct`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( a, b ) \mapsto \mathtt{MorphismFromInternalHomToTensorProduct}(a, b)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddMorphismFromInternalHomToTensorProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `MorphismFromInternalHomToTensorProductWithGivenObjects`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( s, a, b, r ) \mapsto \mathtt{MorphismFromInternalHomToTensorProductWithGivenObjects}(s, a, b, r)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddMorphismFromInternalHomToTensorProductWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `RankMorphism`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( a ) \mapsto \mathtt{RankMorphism}(a)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddRankMorphism",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `TensorProductInternalHomCompatibilityMorphismInverse`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( list ) \mapsto \mathtt{TensorProductInternalHomCompatibilityMorphismInverse}(list)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverse",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverse",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( source, list, range ) \mapsto \mathtt{TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects}(source, list, range)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddTensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup


#! @BeginGroup
#! @Description
#! The arguments are a category $C$ and a function $F$.
#! This operation adds the given function $F$
#! to the category for the basic operation `TraceMap`.
#! Optionally, a weight (default: 100) can be specified which should roughly correspond
#! to the computational complexity of the function (lower weight = less complex = faster execution).
#! $F: ( alpha ) \mapsto \mathtt{TraceMap}(alpha)$.
#! @Returns nothing
#! @Arguments C, F
DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction ] );

#! @Arguments C, F, weight
DeclareOperation( "AddTraceMap",
                  [ IsCapCategory, IsFunction, IsInt ] );
#! @EndGroup

