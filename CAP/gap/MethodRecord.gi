# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
InstallValue( CAP_INTERNAL_VALID_RETURN_TYPES,
#! @BeginCode CAP_INTERNAL_VALID_RETURN_TYPES
    [
        "object",
        "object_or_fail",
        "morphism",
        "morphism_or_fail",
        "twocell",
        "bool",
        "other_object",
        "other_morphism",
        "list_of_morphisms",
        "list_of_morphisms_or_fail",
    ]
#! @EndCode
);

InstallValue( CAP_INTERNAL_METHOD_NAME_RECORD, rec(
ObjectConstructor := rec(
  filter_list := [ "category", IsObject ],
  return_type := "object",
),

ObjectDatum := rec(
  filter_list := [ "category", "object" ],
  return_type := IsObject,
),

MorphismConstructor := rec(
  filter_list := [ "category", "object", IsObject, "object" ],
  return_type := "morphism",
),

MorphismDatum := rec(
  filter_list := [ "category", "morphism" ],
  return_type := IsObject,
),

LiftAlongMonomorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "iota", "tau" ], [ "tau_source", "iota_source" ] ],
  pre_function := function( cat, iota, tau )
    local value, category;
    
    value := IsEqualForObjects( Range( iota ), Range( tau ) );
    
    if value = fail then
        
        return [ false, "cannot decide whether the two morphisms have equal ranges" ];
        
    elif value = false then
        
        return [ false, "the two morphisms must have equal ranges" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "ColiftAlongEpimorphism" ),

IsLiftableAlongMonomorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  pre_function := function( cat, iota, tau )
    local value;
    
    value := IsEqualForObjects( Range( iota ), Range( tau ) );
    
    if value = fail then
        
        return [ false, "cannot decide whether the two morphisms have equal ranges" ];
        
    elif value = false then
        
        return [ false, "the two morphisms must have equal ranges" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool",
  dual_operation := "IsColiftableAlongEpimorphism" ),

ColiftAlongEpimorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "epsilon", "tau" ], [ "epsilon_range", "tau_range" ] ],
  pre_function := function( cat, epsilon, tau )
    local value, category;
    
    value := IsEqualForObjects( Source( epsilon ), Source( tau ) );
    
    if value = fail then
        
        return [ false, "cannot decide whether the two morphisms have equal sources" ];
        
    elif value = false then
        
        return [ false, "the two morphisms must have equal sources" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "LiftAlongMonomorphism" ),

IsColiftableAlongEpimorphism := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  pre_function := function( cat, epsilon, tau )
    local value;
    
    value := IsEqualForObjects( Source( epsilon ), Source( tau ) );
    
    if value = fail then
        
        return [ false, "cannot decide whether the two morphisms have equal sources" ];
        
    elif value = false then
        
        return [ false, "the two morphisms must have equal sources" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool",
  dual_operation := "IsLiftableAlongMonomorphism" ),

Lift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "alpha_source", "beta_source" ] ],
  pre_function := function( cat, iota, tau )
    local value;
    
    value := IsEqualForObjects( Range( iota ), Range( tau ) );
    
    if value = fail then
        
        return [ false, "cannot decide whether the two morphisms have equal ranges" ];
        
    elif value = false then
        
        return [ false, "the two morphisms must have equal ranges" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "Colift",
  dual_arguments_reversed := true,
  is_merely_set_theoretic := true ),

LiftOrFail := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "alpha_source", "beta_source" ] ],
  pre_function := ~.Lift.pre_function,
  return_type := "morphism_or_fail",
  dual_operation := "ColiftOrFail",
  dual_arguments_reversed := true,
  is_merely_set_theoretic := true ),

IsLiftable := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  pre_function := ~.Lift.pre_function,
  return_type := "bool",
  dual_operation := "IsColiftable",
  dual_arguments_reversed := true ),

Colift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "alpha_range", "beta_range" ] ],
  pre_function := function( cat, epsilon, tau )
    local value;
    
    value := IsEqualForObjects( Source( epsilon ), Source( tau ) );
    
    if value = fail then
        
        return [ false, "cannot decide whether the two morphisms have equal sources" ];
        
    elif value = false then
        
        return [ false, "the two morphisms must have equal sources" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "Lift",
  dual_arguments_reversed := true,
  is_merely_set_theoretic := true  ),

ColiftOrFail := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "alpha_range", "beta_range" ] ],
  pre_function := ~.Colift.pre_function,
  return_type := "morphism_or_fail",
  dual_operation := "LiftOrFail",
  dual_arguments_reversed := true,
  is_merely_set_theoretic := true  ),

IsColiftable := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  pre_function := ~.Colift.pre_function,
  return_type := "bool",
  dual_operation := "IsLiftable",
  dual_arguments_reversed := true ),

ProjectiveLift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "alpha_source", "beta_source" ] ],
  pre_function := function( cat, iota, tau )
    local value;
    
    value := IsEqualForObjects( Range( iota ), Range( tau ) );
    
    if value = fail then
        
        return [ false, "cannot decide whether the two morphisms have equal ranges" ];
        
    elif value = false then
        
        return [ false, "the two morphisms must have equal ranges" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "InjectiveColift" ),

InjectiveColift := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "alpha_range", "beta_range" ] ],
  pre_function := function( cat, epsilon, tau )
    local value;
    
    value := IsEqualForObjects( Source( epsilon ), Source( tau ) );
    
    if value = fail then
        
        return [ false, "cannot decide whether the two morphisms have equal sources" ];
        
    elif value = false then
        
        return [ false, "the two morphisms must have equal sources" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "ProjectiveLift" ),

IdentityMorphism := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "a" ], [ "a", "a" ] ],
  return_type := "morphism",
  dual_operation := "IdentityMorphism" ),

InverseForMorphisms := rec(
# Type check for IsIsomorphism
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "alpha_range", "alpha_source" ] ],
  return_type := "morphism",
  dual_operation := "InverseForMorphisms" ),

KernelObject := rec(
  filter_list := [ "category", "morphism" ],
  universal_type := "Limit",
  return_type := "object",
  dual_operation := "CokernelObject" ),

KernelEmbedding := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "P", "alpha_source" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CokernelProjection" ),

KernelEmbeddingWithGivenKernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "P" ], [ "P", "alpha_source" ] ],
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CokernelProjectionWithGivenCokernelObject"),

MorphismFromKernelObjectToSink := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "P", "alpha_range" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "MorphismFromSourceToCokernelObject",
  return_type := "morphism" ),

MorphismFromKernelObjectToSinkWithGivenKernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "P" ], [ "P", "alpha_range" ] ],
  universal_type := "Limit",
  dual_operation := "MorphismFromSourceToCokernelObjectWithGivenCokernelObject",
  return_type := "morphism" ),

KernelLift := rec(
  filter_list := [ "category", "morphism", "object", "morphism" ],
  io_type := [ [ "alpha", "T", "tau" ], [ "T", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CokernelColift" ),

KernelLiftWithGivenKernelObject := rec(
  filter_list := [ "category", "morphism", "object", "morphism", "object" ],
  io_type := [ [ "alpha", "T", "tau", "P" ], [ "T", "P" ] ],
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CokernelColiftWithGivenCokernelObject" ),

CokernelObject := rec(
  filter_list := [ "category", "morphism" ],
  universal_type := "Colimit",
  return_type := "object",
  dual_operation := "KernelObject" ),

CokernelProjection := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "alpha_range", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "KernelEmbedding" ),

CokernelProjectionWithGivenCokernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "P" ], [ "alpha_range", "P" ] ],
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "KernelEmbeddingWithGivenKernelObject" ),

MorphismFromSourceToCokernelObject := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "alpha_source", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "MorphismFromKernelObjectToSink",
  return_type := "morphism" ),

MorphismFromSourceToCokernelObjectWithGivenCokernelObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "P" ], [ "alpha_source", "P" ] ],
  universal_type := "Colimit",
  dual_operation := "MorphismFromKernelObjectToSinkWithGivenKernelObject",
  return_type := "morphism" ),

CokernelColift := rec(
  filter_list := [ "category", "morphism", "object", "morphism" ],
  io_type := [ [ "alpha", "T", "tau" ], [ "P", "T" ] ],
  with_given_object_position := "Source",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "KernelLift" ),

CokernelColiftWithGivenCokernelObject := rec(
  filter_list := [ "category", "morphism", "object", "morphism", "object" ],
  io_type := [ [ "alpha", "T", "tau", "P" ], [ "P", "T" ] ],
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "KernelLiftWithGivenKernelObject" ),

PreCompose := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "alpha_source", "beta_range" ] ],
  
  pre_function := function( cat, mor_left, mor_right )
    local is_equal_for_objects;
    
    is_equal_for_objects := IsEqualForObjects( Range( mor_left ), Source( mor_right ) );
    
    if is_equal_for_objects = fail then
      
      return [ false, "cannot decide whether morphisms are composable" ];
      
    elif is_equal_for_objects = false then
        
        return [ false, "morphisms not composable" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "PostCompose" ),

PostCompose := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "beta", "alpha" ], [ "alpha_source", "beta_range" ] ],
  
  pre_function := function( cat, mor_right, mor_left )
    local is_equal_for_objects;
    
    is_equal_for_objects := IsEqualForObjects( Range( mor_left ), Source( mor_right ) );
    
    if is_equal_for_objects = fail then
      
      return [ false, "cannot decide whether morphisms are composable" ];
      
    elif is_equal_for_objects = false then
        
        return [ false, "morphisms not composable" ];
        
    fi;
    
    return [ true ];
  end,
  
  return_type := "morphism",
  dual_operation := "PreCompose" ),

ZeroObject := rec(
  filter_list := [ "category" ],
  universal_type := "LimitColimit",
  return_type := "object",
  dual_operation := "ZeroObject" ),

ZeroObjectFunctorial := rec(
  filter_list := [ "category" ],
  ## TODO: io_type?
  return_type := "morphism",
  dual_operation := "ZeroObjectFunctorial",
  no_with_given := true ),

UniversalMorphismFromZeroObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "T" ], [ "P", "T" ] ],
  with_given_object_position := "Source",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoZeroObject" ),
  
UniversalMorphismFromZeroObjectWithGivenZeroObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "T", "P" ], [ "P", "T" ] ],
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoZeroObjectWithGivenZeroObject" ),

UniversalMorphismIntoZeroObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "T" ], [ "T", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromZeroObject" ),

UniversalMorphismIntoZeroObjectWithGivenZeroObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "T", "P" ], [ "T", "P" ] ],
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromZeroObjectWithGivenZeroObject" ),

IsomorphismFromZeroObjectToInitialObject := rec(
  filter_list := [ "category" ],
  ## TODO: io_type?
  return_type := "morphism",
  dual_operation := "IsomorphismFromTerminalObjectToZeroObject",
  no_with_given := true ),

IsomorphismFromInitialObjectToZeroObject := rec(
  filter_list := [ "category" ],
  ## TODO: io_type?
  return_type := "morphism",
  dual_operation := "IsomorphismFromZeroObjectToTerminalObject",
  no_with_given := true ),

IsomorphismFromZeroObjectToTerminalObject := rec(
  filter_list := [ "category" ],
  ## TODO: io_type?
  return_type := "morphism",
  dual_operation := "IsomorphismFromInitialObjectToZeroObject",
  no_with_given := true ),

IsomorphismFromTerminalObjectToZeroObject := rec(
  filter_list := [ "category" ],
  ## TODO: io_type?
  return_type := "morphism",
  dual_operation := "IsomorphismFromZeroObjectToInitialObject",
  no_with_given := true ),

ZeroMorphism := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "a", "b" ], [ "a", "b" ] ],
  return_type := "morphism",
  dual_arguments_reversed := true,
  dual_operation := "ZeroMorphism" ),

DirectSum := rec(
  filter_list := [ "category", "list_of_objects" ],
  universal_type := "LimitColimit",
  return_type := "object",
  dual_operation := "DirectSum" ),

ProjectionInFactorOfDirectSum := rec(
  filter_list := [ "category", "list_of_objects", IsInt ],
  io_type := [ [ "objects", "k" ], [ "P", "objects_k" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfDirectSum" ),

ProjectionInFactorOfDirectSumWithGivenDirectSum := rec(
  filter_list := [ "category", "list_of_objects", IsInt, "object" ],
  io_type := [ [ "objects", "k", "P" ], [ "P", "objects_k" ] ],
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfDirectSumWithGivenDirectSum" ),

UniversalMorphismIntoDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms" ],
  io_type := [ [ "objects", "T", "tau" ], [ "T", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromDirectSum",
  
  pre_function := function( cat, diagram, test_object, source )
    local current_morphism, current_return;
    
    for current_morphism in source do
        
        current_return := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether sources of morphisms in given source diagram are equal to the test object" ];
            
        elif current_return = false then
            
            return [ false, "sources of morphisms must be equal to the test object in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

UniversalMorphismIntoDirectSumWithGivenDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms", "object" ],
  io_type := [ [ "objects", "T", "tau", "P" ], [ "T", "P" ] ],
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromDirectSumWithGivenDirectSum",
  
  pre_function := function( cat, diagram, test_object, source, direct_sum )
    local current_morphism, current_return;
    
    for current_morphism in source do
        
        current_return := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether sources of morphisms in given source diagram are equal to the test object" ];
            
        elif current_return = false then
            
            return [ false, "sources of morphisms must be equal to the test object in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

InjectionOfCofactorOfDirectSum := rec(
  filter_list := [ "category", "list_of_objects", IsInt ],
  io_type := [ [ "objects", "k" ], [ "objects_k", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectSum" ),

InjectionOfCofactorOfDirectSumWithGivenDirectSum := rec(
  filter_list := [ "category", "list_of_objects", IsInt, "object" ],
  io_type := [ [ "objects", "k", "P" ], [ "objects_k", "P" ] ],
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectSumWithGivenDirectSum" ),

UniversalMorphismFromDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms" ],
  io_type := [ [ "objects", "T", "tau" ], [ "P", "T" ] ],
  with_given_object_position := "Source",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoDirectSum",
  
  pre_function := function( cat, diagram, test_object, sink )
    local current_morphism, current_return;
    
    for current_morphism in sink do
        
        current_return := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether ranges of morphisms in given sink diagram are equal to the test object" ];
            
        elif current_return = false then
            
            return [ false, "ranges of morphisms must be equal to the test object in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

UniversalMorphismFromDirectSumWithGivenDirectSum := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms", "object" ],
  io_type := [ [ "objects", "T", "tau", "P" ], [ "P", "T" ] ],
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoDirectSumWithGivenDirectSum",
  
  pre_function := function( cat, diagram, test_object, sink, direct_sum )
    local current_morphism, current_return;
    
    for current_morphism in sink do
        
        current_return := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether ranges of morphisms in given sink diagram are equal to the test object" ];
            
        elif current_return = false then
            
            return [ false, "ranges of morphisms must be equal to the test object in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

TerminalObject := rec(
  filter_list := [ "category" ],
  universal_type := "Limit",
  return_type := "object",
  dual_operation := "InitialObject" ),

UniversalMorphismIntoTerminalObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "T" ], [ "T", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromInitialObject" ),

UniversalMorphismIntoTerminalObjectWithGivenTerminalObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "T", "P" ], [ "T", "P" ] ],
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromInitialObjectWithGivenInitialObject" ),

InitialObject := rec(
  filter_list := [ "category" ],
  universal_type := "Colimit",
  return_type := "object",
  dual_operation := "TerminalObject" ),

UniversalMorphismFromInitialObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "T" ], [ "P", "T" ] ],
  with_given_object_position := "Source",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoTerminalObject" ),

UniversalMorphismFromInitialObjectWithGivenInitialObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "T", "P" ], [ "P", "T" ] ],
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoTerminalObjectWithGivenTerminalObject" ),

DirectProduct := rec(
  filter_list := [ "category", "list_of_objects" ],
  universal_type := "Limit",
  return_type := "object",
  dual_operation := "Coproduct" ),

ProjectionInFactorOfDirectProduct := rec(
  filter_list := [ "category", "list_of_objects", IsInt ],
  io_type := [ [ "objects", "k" ], [ "P", "objects_k" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfCoproduct" ),

ProjectionInFactorOfDirectProductWithGivenDirectProduct := rec(
  filter_list := [ "category", "list_of_objects", IsInt, "object" ],
  io_type := [ [ "objects", "k", "P" ], [ "P", "objects_k" ] ],
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "InjectionOfCofactorOfCoproductWithGivenCoproduct" ),

UniversalMorphismIntoDirectProduct := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms" ],
  io_type := [ [ "objects", "T", "tau" ], [ "T", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromCoproduct",
  
  pre_function := function( cat, diagram, test_object, source )
    local current_morphism, current_return;
    
    for current_morphism in source do
        
        current_return := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether sources of morphisms in given source diagram are equal to the test object" ];
            
        elif current_return = false then
            
            return [ false, "sources of morphisms must be equal to the test object in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

UniversalMorphismIntoDirectProductWithGivenDirectProduct := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms", "object" ],
  io_type := [ [ "objects", "T", "tau", "P" ], [ "T", "P" ] ],
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromCoproductWithGivenCoproduct",
  
  pre_function := function( cat, diagram, test_object, source, direct_product )
    local current_morphism, current_return;
    
    for current_morphism in source do
        
        current_return := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether sources of morphisms in given source diagram are equal to the test object" ];
            
        elif current_return = false then
            
            return [ false, "sources of morphisms must be equal to the test object in given source diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

IsCongruentForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  well_defined_todo := false,
  dual_operation := "IsCongruentForMorphisms",
  
  pre_function := function( cat, morphism_1, morphism_2 )
    local value_1, value_2;
    
    value_1 := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if value_1 = fail then
      
      return [ false, "cannot decide whether sources are equal" ];
      
    fi;
    
    value_2 := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if value_2 = fail then
      
      return [ false, "cannot decide whether ranges are equal" ];
      
    fi;
    
    
    if value_1 and value_2 then
        
        return [ true ];
        
    elif value_1 then
        
        return [ false, "ranges are not equal" ];
        
    else
        
        return [ false, "sources are not equal" ];
        
    fi;
    
  end,
  
  redirect_function := function( cat, morphism_1, morphism_2 )
    
    if IsIdenticalObj( morphism_1, morphism_2 ) then 
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  post_function := function( cat, morphism_1, morphism_2, return_value )
    
    if cat!.predicate_logic_propagation_for_morphisms and
       cat!.predicate_logic and return_value = true then
          
          INSTALL_TODO_LIST_FOR_EQUAL_MORPHISMS( morphism_1, morphism_2 );
          
    fi;
    
  end,
  
  return_type := "bool" ),

IsEqualForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  well_defined_todo := false,
  dual_operation := "IsEqualForMorphisms",
  
  pre_function := function( cat, morphism_1, morphism_2 )
    local value_1, value_2;
    
    value_1 := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if value_1 = fail then
      
      return [ false, "cannot decide whether sources are equal" ];
      
    fi;
    
    value_2 := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if value_2 = fail then
      
      return [ false, "cannot decide whether ranges are equal" ];
      
    fi;
    
    
    if value_1 and value_2 then
        
        return [ true ];
        
    elif value_1 then
        
        return [ false, "ranges are not equal" ];
        
    else
        
        return [ false, "sources are not equal" ];
        
    fi;
    
  end,
  
  redirect_function := function( cat, morphism_1, morphism_2 )
    
    if IsIdenticalObj( morphism_1, morphism_2 ) then 
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  return_type := "bool" ),

IsEqualForMorphismsOnMor := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  well_defined_todo := false,
  dual_operation := "IsEqualForMorphismsOnMor",
  
  redirect_function := function( cat, morphism_1, morphism_2 )
    
    if IsIdenticalObj( morphism_1, morphism_2 ) then 
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  return_type := "bool" ),

IsEqualForObjects := rec(
  filter_list := [ "category", "object", "object" ],
  well_defined_todo := false,
  dual_operation := "IsEqualForObjects",
  
  redirect_function := function( cat, object_1, object_2 )
    
    if IsIdenticalObj( object_1, object_2 ) then
      
      return [ true, true ];
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  post_function := function( cat, object_1, object_2, return_value )
    
    if cat!.predicate_logic_propagation_for_objects and
       cat!.predicate_logic and return_value = true and not IsIdenticalObj( object_1, object_2 ) then
        
        INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS( object_1, object_2 );
        
    fi;
    
  end,
  
  return_type := "bool" ),
  
IsEqualForCacheForObjects := rec(
  filter_list := [ "category", "object", "object" ],
  dual_operation := "IsEqualForCacheForObjects",
  well_defined_todo := false,
  return_type := "bool" ),

IsEqualForCacheForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  dual_operation := "IsEqualForCacheForMorphisms",
  well_defined_todo := false,
  return_type := "bool" ),
  
IsZeroForMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsZeroForMorphisms",
  property_of := "morphism",
  is_reflected_by_faithful_functor := true ),

AdditionForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "a_source", "a_range" ] ],
  dual_operation := "AdditionForMorphisms",
  
  pre_function := function( cat, morphism_1, morphism_2 )
    local value_1, value_2;
    
    value_1 := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if value_1 = fail then
      
      return [ false, "cannot decide whether sources are equal" ];
      
    fi;
    
    value_2 := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if value_2 = fail then
      
      return [ false, "cannot decide whether ranges are equal" ];
      
    fi;
    
    
    if value_1 and value_2 then
        
        return [ true ];
        
    elif value_1 then
        
        return [ false, "ranges are not equal" ];
        
    else
        
        return [ false, "sources are not equal" ];
        
    fi;
    
  end,
  return_type := "morphism" ),

SubtractionForMorphisms := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "a", "b" ], [ "a_source", "a_range" ] ],
  dual_operation := "SubtractionForMorphisms",
  
  pre_function := function( cat, morphism_1, morphism_2 )
    local value_1, value_2;
    
    value_1 := IsEqualForObjects( Source( morphism_1 ), Source( morphism_2 ) );
    
    if value_1 = fail then
      
      return [ false, "cannot decide whether sources are equal" ];
      
    fi;
    
    value_2 := IsEqualForObjects( Range( morphism_1 ), Range( morphism_2 ) );
    
    if value_2 = fail then
      
      return [ false, "cannot decide whether ranges are equal" ];
      
    fi;
    
    
    if value_1 and value_2 then
        
        return [ true ];
        
    elif value_1 then
        
        return [ false, "ranges are not equal" ];
        
    else
        
        return [ false, "sources are not equal" ];
        
    fi;
    
  end,
  return_type := "morphism" ),

MultiplyWithElementOfCommutativeRingForMorphisms := rec(
  filter_list := [ "category", IsRingElement, "morphism" ],
  io_type := [ [ "r", "a" ], [ "a_source", "a_range" ] ],
  
  pre_function := function( cat, r, morphism )
    
    if not r in CommutativeRingOfLinearCategory( CapCategory( morphism ) ) then
      
      return [ false, "the first argument is not an element of the ring of the category of the morphism" ];
      
    fi;
    
    return [ true ];
  end,
  dual_operation := "MultiplyWithElementOfCommutativeRingForMorphisms",
  return_type := "morphism" ),

AdditiveInverseForMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "a" ], [ "a_source", "a_range" ] ],
  dual_operation := "AdditiveInverseForMorphisms",
  return_type := "morphism" ),

Coproduct := rec(
  filter_list := [ "category", "list_of_objects" ],
  universal_type := "Colimit",
  return_type := "object",
  dual_operation := "DirectProduct" ),

InjectionOfCofactorOfCoproduct := rec(
  filter_list := [ "category", "list_of_objects", IsInt ],
  io_type := [ [ "objects", "k" ], [ "objects_k", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectProduct" ),

InjectionOfCofactorOfCoproductWithGivenCoproduct := rec(
  filter_list := [ "category", "list_of_objects", IsInt, "object" ],
  io_type := [ [ "objects", "k", "P" ], [ "objects_k", "P" ] ],
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ProjectionInFactorOfDirectProductWithGivenDirectProduct" ),

UniversalMorphismFromCoproduct := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms" ],
  io_type := [ [ "objects",  "T", "tau" ], [ "P", "T" ] ],
  with_given_object_position := "Source",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoDirectProduct",
  
  pre_function := function( cat, diagram, test_object, sink )
    local current_morphism, current_return;
    
    for current_morphism in sink do
        
        current_return := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether ranges of morphisms in given sink diagram are equal to the test object" ];
            
        elif current_return = false then
            
            return [ false, "ranges of morphisms must be equal to the test object in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

UniversalMorphismFromCoproductWithGivenCoproduct := rec(
  filter_list := [ "category", "list_of_objects", "object", "list_of_morphisms", "object" ],
  io_type := [ [ "objects", "T", "tau", "P" ], [ "P", "T" ] ],
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoDirectProductWithGivenDirectProduct",
  
  pre_function := function( cat, diagram, test_object, sink, coproduct )
    local current_morphism, current_return;
    
    for current_morphism in sink do
        
        current_return := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_return = fail then
            
            return [ false, "cannot decide whether ranges of morphisms in given sink diagram are equal to the test object" ];
            
        elif current_return = false then
            
            return [ false, "ranges of morphisms must be equal to the test object in given sink diagram" ];
            
        fi;
        
    od;
    
    return [ true ];
    
  end,
  return_type := "morphism" ),

IsEqualAsSubobjects := rec(
  filter_list := [ "category", [ "morphism", IsSubobject ], [ "morphism", IsSubobject ] ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsEqualAsFactorobjects" ),

IsEqualAsFactorobjects := rec(
  filter_list := [ "category", [ "morphism", IsFactorobject ], [ "morphism", IsFactorobject ] ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsEqualAsSubobjects" ),

IsDominating := rec(
  filter_list := [ "category", [ "morphism", IsSubobject ], [ "morphism", IsSubobject ] ],
  well_defined_todo := false,
  dual_operation := "IsCodominating",
  
  pre_function := function( cat, sub1, sub2 )
    local is_equal_for_objects;
    
    is_equal_for_objects := IsEqualForObjects( Range( sub1 ), Range( sub2 ) );
    
    if is_equal_for_objects = fail then
        
        return [ false, "cannot decide whether those are subobjects of the same object" ];
    
    elif is_equal_for_objects = false then
        
        return [ false, "subobjects of different objects are not comparable by dominates" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool" ),

IsCodominating := rec(
  filter_list := [ "category", [ "morphism", IsFactorobject ], [ "morphism", IsFactorobject ] ],
  well_defined_todo := false,
  dual_operation := "IsDominating",
  
  pre_function := function( cat, factor1, factor2 )
    local is_equal_for_objects;
    
    is_equal_for_objects := IsEqualForObjects( Source( factor1 ), Source( factor2 ) );
    
    if is_equal_for_objects = fail then
        
        return [ false, "cannot decide whether those are factors of the same object" ];
    
    elif is_equal_for_objects = false then
        
        return [ false, "factors of different objects are not comparable by codominates" ];
        
    fi;
    
    return [ true ];
  end,
  return_type := "bool" ),

Equalizer := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  return_type := "object",
  universal_type := "Limit",
  dual_operation := "Coequalizer",
  
  pre_function := function( cat, diagram )
    local cobase, base, current_morphism, current_value;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the equalizer diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the equalizer diagram must have equal sources" ];
        fi;
        
    od;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the equalizer diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the equalizer diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end ),

EmbeddingOfEqualizer := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  return_type := "morphism",
  io_type := [ [ "morphisms" ], [ "P", "morphisms_1_source" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "ProjectionOntoCoequalizer",
  
  pre_function := ~.Equalizer.pre_function ),

EmbeddingOfEqualizerWithGivenEqualizer := rec(
  filter_list := [ "category", "list_of_morphisms", "object" ],
  return_type := "morphism",
  io_type := [ [ "morphisms", "P" ], [ "P", "morphisms_1_source" ] ],
  universal_type := "Limit",
  dual_operation := "ProjectionOntoCoequalizerWithGivenCoequalizer" ),

MorphismFromEqualizerToSink := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "morphisms" ], [ "P", "morphisms_1_range" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "MorphismFromSourceToCoequalizer",
  return_type := "morphism" ),

MorphismFromEqualizerToSinkWithGivenEqualizer := rec(
  filter_list := [ "category", "list_of_morphisms", "object" ],
  io_type := [ [ "morphisms", "P" ], [ "P", "morphisms_1_range" ] ],
  universal_type := "Limit",
  dual_operation := "MorphismFromSourceToCoequalizerWithGivenCoequalizer",
  return_type := "morphism" ),

UniversalMorphismIntoEqualizer := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "morphism" ],
  io_type := [ [ "morphisms", "T", "tau" ], [ "T", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromCoequalizer",
  
  pre_function := function( cat, diagram, test_object, tau )
    local cobase, base, current_morphism, current_value, current_morphism_position;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the equalizer diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the equalizer diagram must have equal sources" ];
        fi;
        
    od;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the equalizer diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the equalizer diagram must have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Source( diagram[ current_morphism_position ] ), Range( tau ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether source and range are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end ),

UniversalMorphismIntoEqualizerWithGivenEqualizer := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "morphism", "object" ],
  io_type := [ [ "morphisms", "T", "tau", "P" ], [ "T", "P" ] ],
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromCoequalizerWithGivenCoequalizer" ),

FiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  universal_type := "Limit",
  dual_operation := "Pushout",
  
  pre_function := function( cat, diagram )
    local base, current_morphism, current_value;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "object" ),

ProjectionInFactorOfFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", IsInt ],
  io_type := [ [ "morphisms", "k" ], [ "P", "morphisms_k_source" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "InjectionOfCofactorOfPushout",
  
  pre_function := function( cat, diagram, projection_number )
    local base, current_morphism, current_value;
    
    if projection_number < 1 or projection_number > Length( diagram ) then
        return[ false, Concatenation( "there does not exist a ", String( projection_number ), "th projection" ) ];
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

ProjectionInFactorOfFiberProductWithGivenFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", IsInt, "object" ],
  io_type := [ [ "morphisms", "k", "P" ], [ "P", "morphisms_k_source" ] ],
  universal_type := "Limit",
  dual_operation := "InjectionOfCofactorOfPushoutWithGivenPushout",
  
  pre_function := function( cat, diagram, projection_number, pullback )
    local base, current_morphism, current_value;
    
    if projection_number < 1 or projection_number > Length( diagram ) then
        return[ false, Concatenation( "there does not exist a ", String( projection_number ), "th projection" ) ];
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

MorphismFromFiberProductToSink := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "morphisms" ], [ "P", "morphisms_1_range" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "MorphismFromSourceToPushout",
  
  pre_function := function( cat, diagram )
    local base, current_morphism, current_value;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

MorphismFromFiberProductToSinkWithGivenFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", "object" ],
  io_type := [ [ "morphisms", "P" ], [ "P", "morphisms_1_range" ] ],
  universal_type := "Limit",
  dual_operation := "MorphismFromSourceToPushoutWithGivenPushout",
  
  pre_function := function( cat, diagram, pullback )
    local base, current_morphism, current_value;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismIntoFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "list_of_morphisms" ],
  io_type := [ [ "morphisms", "T", "tau" ], [ "T", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromPushout",
  
  pre_function := function( cat, diagram, test_object, source )
    local base, current_morphism, current_value, current_morphism_position;
    
    if Length( diagram ) <> Length( source ) then
        return [ false, "fiber product diagram and test diagram must have equal length" ];
    fi;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism in source do
        
        current_value := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the test source have sources equal to the test object" ];
        elif current_value = false then
            return [ false, "the given morphisms of the test source do not have sources equal to the test object" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Source( diagram[ current_morphism_position ] ), Range( source[ current_morphism_position ] ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether source and range are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismIntoFiberProductWithGivenFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "list_of_morphisms", "object" ],
  io_type := [ [ "morphisms", "T", "tau", "P" ], [ "T", "P" ] ],
  universal_type := "Limit",
  dual_operation := "UniversalMorphismFromPushoutWithGivenPushout",
  
  pre_function := function( cat, diagram, test_object, source, pullback )
    local base, current_morphism, current_value, current_morphism_position;
    
    if Length( diagram ) <> Length( source ) then
        return [ false, "fiber product diagram and test diagram must have equal length" ];
    fi;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the fiber product diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber product diagram must have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism in source do
        
        current_value := IsEqualForObjects( Source( current_morphism ), test_object );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the test source have sources equal to the test object" ];
        elif current_value = false then
            return [ false, "the given morphisms of the test source do not have sources equal to the test object" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Source( diagram[ current_morphism_position ] ), Range( source[ current_morphism_position ] ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether source and range are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

Coequalizer := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  return_type := "object",
  universal_type := "Colimit",
  dual_operation := "Equalizer",
  
  pre_function := function( cat, diagram )
    local base, cobase, current_morphism, current_value;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the coequalizer diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the coequalizer diagram must have equal sources" ];
        fi;
        
    od;
    
    cobase := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the coequalizer diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the coequalizer diagram must have equal ranges" ];
        fi;
        
    od;
    
    return [ true ];
  end ),

ProjectionOntoCoequalizer := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  return_type := "morphism",
  io_type := [ [ "morphisms" ], [ "morphisms_1_range", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "EmbeddingOfEqualizer",
  
  pre_function := ~.Coequalizer.pre_function ),

ProjectionOntoCoequalizerWithGivenCoequalizer := rec(
  filter_list := [ "category", "list_of_morphisms", "object" ],
  return_type := "morphism",
  io_type := [ [ "morphisms", "P" ], [ "morphisms_1_range", "P" ] ],
  universal_type := "Colimit",
  dual_operation := "EmbeddingOfEqualizerWithGivenEqualizer" ),

MorphismFromSourceToCoequalizer := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "morphisms" ], [ "morphisms_1_source", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "MorphismFromEqualizerToSink",
  return_type := "morphism" ),

MorphismFromSourceToCoequalizerWithGivenCoequalizer := rec(
  filter_list := [ "category", "list_of_morphisms", "object" ],
  io_type := [ [ "morphisms", "P" ], [ "morphisms_1_source", "P" ] ],
  universal_type := "Colimit",
  dual_operation := "MorphismFromEqualizerToSinkWithGivenEqualizer",
  return_type := "morphism" ),

UniversalMorphismFromCoequalizer := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "morphism" ],
  io_type := [ [ "morphisms", "T", "tau" ], [ "P", "T" ] ],
  with_given_object_position := "Source",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoEqualizer",
  
  pre_function := function( cat, diagram, test_object, tau )
    local base, cobase, current_morphism, current_value, current_morphism_position;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    base := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), base );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the coequalizer diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the coequalizer diagram must have equal sources" ];
        fi;
        
    od;
    
    cobase := Range( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Range( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the coequalizer diagram have equal ranges" ];
        elif current_value = false then
            return [ false, "the given morphisms of the coequalizer diagram must have equal ranges" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Range( diagram[ current_morphism_position ] ), Source( tau ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether range and source are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": range and source are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end ),

UniversalMorphismFromCoequalizerWithGivenCoequalizer := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "morphism", "object" ],
  io_type := [ [ "morphisms", "T", "tau", "P" ], [ "P", "T" ] ],
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "UniversalMorphismIntoEqualizerWithGivenEqualizer" ),

Pushout := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  universal_type := "Colimit",
  dual_operation := "FiberProduct",
  
  pre_function := function( cat, diagram )
    local cobase, current_morphism, current_value;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "object" ),

InjectionOfCofactorOfPushout := rec(
  filter_list := [ "category", "list_of_morphisms", IsInt ],
  io_type := [ [ "morphisms", "k" ], [ "morphisms_k_range", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "ProjectionInFactorOfFiberProduct",
  
  pre_function := function( cat, diagram, injection_number )
    local cobase, current_morphism, current_value;
    
    if injection_number < 1 or injection_number > Length( diagram ) then
        return[ false, Concatenation( "there does not exist a ", String( injection_number ), "th injection" ) ];
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

InjectionOfCofactorOfPushoutWithGivenPushout := rec(
  filter_list := [ "category", "list_of_morphisms", IsInt, "object" ],
  io_type := [ [ "morphisms", "k", "P" ], [ "morphisms_k_range", "P" ] ],
  universal_type := "Colimit",
  dual_operation := "ProjectionInFactorOfFiberProductWithGivenFiberProduct",
  
  pre_function := function( cat, diagram, injection_number, pushout )
    local cobase, current_morphism, current_value;
    
    if injection_number < 1 or injection_number > Length( diagram ) then
        return[ false, Concatenation( "there does not exist a ", String( injection_number ), "th injection" ) ];
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

MorphismFromSourceToPushout := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "morphisms" ], [ "morphisms_1_source", "P" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  dual_operation := "MorphismFromFiberProductToSink",
  
  pre_function := function( cat, diagram )
    local cobase, current_morphism, current_value;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

MorphismFromSourceToPushoutWithGivenPushout := rec(
  filter_list := [ "category", "list_of_morphisms", "object" ],
  io_type := [ [ "morphisms", "P" ], [ "morphisms_1_source", "P" ] ],
  universal_type := "Colimit",
  dual_operation := "MorphismFromFiberProductToSinkWithGivenFiberProduct",
  
  pre_function := function( cat, diagram, pushout )
    local cobase, current_morphism, current_value;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the pushout diagram must have equal sources" ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismFromPushout := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "list_of_morphisms" ],
  io_type := [ [ "morphisms", "T", "tau" ], [ "P", "T" ] ],
  with_given_object_position := "Source",
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoFiberProduct",
  
  pre_function := function( cat, diagram, test_object, sink )
    local cobase, current_morphism, current_value, current_morphism_position;
    
    if Length( diagram ) <> Length( sink ) then
        return [ false, "pushout diagram and test diagram must have equal length" ];
    fi;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber pushout must have equal sources" ];
        fi;
        
    od;
    
    for current_morphism in sink do
        
        current_value := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the test sink have ranges equal to the test object" ];
        elif current_value = false then
            return [ false, "the given morphisms of the test sink do not have ranges equal to the test object" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Range( diagram[ current_morphism_position ] ), Source( sink[ current_morphism_position ] ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether source and range are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismFromPushoutWithGivenPushout := rec(
  filter_list := [ "category", "list_of_morphisms", "object", "list_of_morphisms", "object" ],
  io_type := [ [ "morphisms", "T", "tau", "P" ], [ "P", "T" ] ],
  universal_type := "Colimit",
  dual_operation := "UniversalMorphismIntoFiberProductWithGivenFiberProduct",
  
  pre_function := function( cat, diagram, test_object, sink, pushout )
    local cobase, current_morphism, current_value, current_morphism_position;
    
    if Length( diagram ) <> Length( sink ) then
        return [ false, "pushout diagram and test diagram must have equal length" ];
    fi;
    
    if IsEmpty( diagram ) then
        
        return [ true ];
        
    fi;
    
    cobase := Source( diagram[1] );
    
    for current_morphism in diagram{[ 2 .. Length( diagram ) ]} do
        
        current_value := IsEqualForObjects( Source( current_morphism ), cobase );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the pushout diagram have equal sources" ];
        elif current_value = false then
            return [ false, "the given morphisms of the fiber pushout must have equal sources" ];
        fi;
        
    od;
    
    for current_morphism in sink do
        
        current_value := IsEqualForObjects( Range( current_morphism ), test_object );
        
        if current_value = fail then
            return [ false, "cannot decide whether the given morphisms of the test sink have ranges equal to the test object" ];
        elif current_value = false then
            return [ false, "the given morphisms of the test sink do not have ranges equal to the test object" ];
        fi;
        
    od;
    
    for current_morphism_position in [ 1 .. Length( diagram ) ] do
        
        current_value := IsEqualForObjects( Range( diagram[ current_morphism_position ] ), Source( sink[ current_morphism_position ] ) );
        
        if current_value = fail then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": cannot decide whether source and range are equal" ) ];
        elif current_value = false then
            return [ false, Concatenation( "in diagram position ", String( current_morphism_position ), ": source and range are not equal" ) ];
        fi;
        
    od;
    
    return [ true ];
  end,
  return_type := "morphism" ),

ImageObject := rec(
  filter_list := [ "category", "morphism" ],
  universal_type := "Limit",
  return_type := "object",
  dual_operation := "Coimage" ),

ImageEmbedding := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "I", "alpha_range" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CoimageProjection" ),

ImageEmbeddingWithGivenImageObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "I" ], [ "I", "alpha_range" ] ],
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "CoimageProjectionWithGivenCoimage" ),

Coimage := rec(
  filter_list := [ "category", "morphism" ],
  universal_type := "Colimit",
  return_type := "object",
  dual_operation := "ImageObject" ),

CoimageProjection := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "alpha_source", "C" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ImageEmbedding" ),

CoimageProjectionWithGivenCoimage := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "C" ], [ "alpha_source", "C" ] ],
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "ImageEmbeddingWithGivenImageObject" ),

AstrictionToCoimage := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "C", "alpha_range" ] ],
  with_given_object_position := "Source",
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "CoastrictionToImage" ),

AstrictionToCoimageWithGivenCoimage := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "C" ], [ "C", "alpha_range" ] ],
  universal_type := "Colimit",
  return_type := "morphism",
  dual_operation := "CoastrictionToImageWithGivenImageObject" ),

UniversalMorphismIntoCoimage := rec(
  filter_list := [ "category", "morphism", IsList ],
  io_type := [ [ "alpha", "tau" ], [ "tau_1_range", "C" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit",
  dual_preprocessor_func := CAP_INTERNAL_REVERSE_LISTS_IN_ARGUMENTS_FOR_OPPOSITE,
  pre_function := function( cat, morphism, test_factorization )
    local value;
    
    value := IsEqualForObjects( Source( morphism ), Source( test_factorization[ 1 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( morphism ), Range( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether range of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source and range of test factorization are equal" ];
    elif value = false then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromImage" ),

UniversalMorphismIntoCoimageWithGivenCoimage := rec(
  filter_list := [ "category", "morphism", IsList, "object" ],
  io_type := [ [ "alpha", "tau", "C" ], [ "tau_1_range", "C" ] ],
  universal_type := "Colimit",
  dual_preprocessor_func := CAP_INTERNAL_REVERSE_LISTS_IN_ARGUMENTS_FOR_OPPOSITE,
  pre_function := function( cat, morphism, test_factorization, image )
    local value;
    
    value := IsEqualForObjects( Source( morphism ), Source( test_factorization[ 1 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( morphism ), Range( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether range of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source and range of test factorization are equal" ];
    elif value = false then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism",
  dual_operation := "UniversalMorphismFromImageWithGivenImageObject" ),

MorphismFromCoimageToImageWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "C", "alpha", "I" ], [ "C", "I" ] ],
  dual_operation := "MorphismFromCoimageToImageWithGivenObjects",
  dual_arguments_reversed := true,
  return_type := "morphism" ),

InverseMorphismFromCoimageToImageWithGivenObjects := rec(
  filter_list := [ "category", "object", "morphism", "object" ],
  io_type := [ [ "C", "alpha", "I" ], [ "I", "C" ] ],
  dual_operation := "InverseMorphismFromCoimageToImageWithGivenObjects",
  dual_arguments_reversed := true,
  return_type := "morphism" ),

IsWellDefinedForMorphisms := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  dual_operation := "IsWellDefinedForMorphisms",
  
  redirect_function := function( cat, morphism )
    local category, source, range;
    
    source := Source( morphism );
    
    range := Range( morphism );
    
    category := CapCategory( morphism );
    
    if not ( IsWellDefined( source ) and IsWellDefined( range ) )
       or not ( IsIdenticalObj( CapCategory( source ), category ) and IsIdenticalObj( CapCategory( range ), category ) ) then
      
      return [ true, false ];
      
      
    else
      
      return [ false ];
      
    fi;
    
  end,
  
  return_type := "bool" ),

IsWellDefinedForObjects := rec(
  filter_list := [ "category", "object" ],
  well_defined_todo := false,
  dual_operation := "IsWellDefinedForObjects",
  return_type := "bool" ),

IsZeroForObjects := rec(
  filter_list := [ "category", "object" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsZeroForObjects",
  property_of := "object" ),

IsMonomorphism := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsEpimorphism",
  property_of := "morphism",
  is_reflected_by_faithful_functor := true ),

IsEpimorphism := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsMonomorphism",
  property_of := "morphism",
  is_reflected_by_faithful_functor := true ),

IsIsomorphism := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  dual_operation := "IsIsomorphism",
  return_type := "bool",
  property_of := "morphism" ),

IsEndomorphism := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsEndomorphism",
  property_of := "morphism" ),

IsAutomorphism := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsAutomorphism",
  property_of := "morphism" ),

IsOne := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  property_of := "morphism",
  dual_operation := "IsOne",
  pre_function := function( cat, morphism )
    local is_equal_for_objects;
    
    is_equal_for_objects := IsEqualForObjects( Source( morphism ), Range( morphism ) );
    
    if is_equal_for_objects = fail then
      
      return [ false, "cannot decide whether morphism is the identity" ];
      
    fi;
    
    if is_equal_for_objects = false then
        
        return [ false, "source and range of the given morphism are not equal" ];
        
    fi;
    
    return [ true ];
  end ),

IsSplitMonomorphism := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsSplitEpimorphism",
  property_of := "morphism" ),

IsSplitEpimorphism := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsSplitMonomorphism",
  property_of := "morphism" ),

IsIdempotent := rec(
   pre_function := function( cat, morphism )
    
    #do not use IsEndomorphism( morphism ) here because you don't know if
    #the user has given an own IsEndomorphism function
    if not IsEqualForObjects( Source( morphism ), Range( morphism ) ) then 
      
      return [ false, "the given morphism has to be an endomorphism" ];
      
    fi;
    
    return [ true ];
  end,
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsIdempotent",
  property_of := "morphism" ),

IsProjective := rec(
  filter_list := [ "category", "object" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsInjective",
  property_of := "object" ),

IsInjective := rec(
  filter_list := [ "category", "object" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsProjective",
  property_of := "object" ),

IsTerminal := rec(
  filter_list := [ "category", "object" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsInitial",
  property_of := "object" ),

IsInitial := rec(
  filter_list := [ "category", "object" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsTerminal",
  property_of := "object" ),

IsIdenticalToIdentityMorphism := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsIdenticalToIdentityMorphism",
  property_of := "morphism" ),

IsIdenticalToZeroMorphism := rec(
  filter_list := [ "category", "morphism" ],
  well_defined_todo := false,
  return_type := "bool",
  dual_operation := "IsIdenticalToZeroMorphism",
  property_of := "morphism" ),

CoastrictionToImage := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "alpha_source", "I" ] ],
  with_given_object_position := "Range",
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "AstrictionToCoimage" ),

CoastrictionToImageWithGivenImageObject := rec(
  filter_list := [ "category", "morphism", "object" ],
  io_type := [ [ "alpha", "I" ], [ "alpha_source", "I" ] ],
  universal_type := "Limit",
  return_type := "morphism",
  dual_operation := "AstrictionToCoimageWithGivenCoimage" ),

UniversalMorphismFromImage := rec(
  filter_list := [ "category", "morphism", IsList ],
  io_type := [ [ "alpha", "tau" ], [ "I", "tau_1_range" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit",
  dual_operation := "UniversalMorphismIntoCoimage",
  dual_preprocessor_func := CAP_INTERNAL_REVERSE_LISTS_IN_ARGUMENTS_FOR_OPPOSITE,
  pre_function := function( cat, morphism, test_factorization )
    local value;
    
    value := IsEqualForObjects( Source( morphism ), Source( test_factorization[ 1 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( morphism ), Range( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether range of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source and range of test factorization are equal" ];
    elif value = false then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism" ),

UniversalMorphismFromImageWithGivenImageObject := rec(
  filter_list := [ "category", "morphism", IsList, "object" ],
  io_type := [ [ "alpha", "tau", "I" ], [ "I", "tau_1_range" ] ],
  universal_type := "Limit",
  dual_operation := "UniversalMorphismIntoCoimageWithGivenCoimage",
  dual_preprocessor_func := CAP_INTERNAL_REVERSE_LISTS_IN_ARGUMENTS_FOR_OPPOSITE,
  pre_function := function( cat, morphism, test_factorization, image )
    local value;
    
    value := IsEqualForObjects( Source( morphism ), Source( test_factorization[ 1 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "source of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( morphism ), Range( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether range of morphism and test factorization are equal" ];
    elif value = false then
        return [ false, "range of morphism and test factorization are not equal" ];
    fi;
    
    value := IsEqualForObjects( Range( test_factorization[ 1 ] ), Source( test_factorization[ 2 ] ) );
    if value = fail then
        return [ false, "cannot decide whether source and range of test factorization are equal" ];
    elif value = false then
        return [ false, "source and range of test factorization are not equal" ];
    fi;
    
    return [ true ];
  end,
  return_type := "morphism" ),

KernelObjectFunctorialWithGivenKernelObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "P", "alpha", "mu", "alphap", "Pp" ], [ "P", "Pp" ] ],
  return_type := "morphism",
  dual_operation := "CokernelObjectFunctorialWithGivenCokernelObjects",
  dual_arguments_reversed := true ),

CokernelObjectFunctorialWithGivenCokernelObjects := rec(
  filter_list := [ "category", "object", "morphism", "morphism", "morphism", "object" ],
  io_type := [ [ "P", "alpha", "mu", "alphap", "Pp" ], [ "P", "Pp" ] ],
  return_type := "morphism",
  dual_operation := "KernelObjectFunctorialWithGivenKernelObjects",
  dual_arguments_reversed := true ),

TerminalObjectFunctorial := rec(
  filter_list := [ "category" ],
  ## TODO: io_type?
  return_type := "morphism",
  dual_operation := "InitialObjectFunctorial",
  no_with_given := true ),

InitialObjectFunctorial := rec(
  filter_list := [ "category" ],
  ## TODO: io_type?
  return_type := "morphism",
  dual_operation := "TerminalObjectFunctorial",
  no_with_given := true ),

DirectProductFunctorialWithGivenDirectProducts := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_morphisms", "list_of_objects", "object" ],
  io_type := [ [ "P", "objects", "L", "objectsp", "Pp" ], [ "P", "Pp" ] ],
  return_type := "morphism",
  dual_operation := "CoproductFunctorialWithGivenCoproducts",
  dual_arguments_reversed := true ),

CoproductFunctorialWithGivenCoproducts := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_morphisms", "list_of_objects", "object" ],
  io_type := [ [ "P", "objects", "L", "objectsp", "Pp" ], [ "P", "Pp" ] ],
  return_type := "morphism",
  dual_operation := "DirectProductFunctorialWithGivenDirectProducts",
  dual_arguments_reversed := true ),

DirectSumFunctorialWithGivenDirectSums := rec(
  filter_list := [ "category", "object", "list_of_objects", "list_of_morphisms", "list_of_objects", "object" ],
  io_type := [ [ "P", "objects", "L", "objectsp", "Pp" ], [ "P", "Pp" ] ],
  return_type := "morphism",
  dual_operation := "DirectSumFunctorialWithGivenDirectSums",
  dual_arguments_reversed := true ),

EqualizerFunctorialWithGivenEqualizers := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "morphism", "list_of_morphisms", "object" ],
  io_type := [ [ "P", "morphisms", "mu", "morphismsp", "Pp" ], [ "P", "Pp" ] ],
  return_type := "morphism",
  dual_operation := "CoequalizerFunctorialWithGivenCoequalizers",
  dual_arguments_reversed := true ),

FiberProductFunctorialWithGivenFiberProducts := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "list_of_morphisms", "list_of_morphisms", "object" ],
  io_type := [ [ "P", "morphisms", "L", "morphismsp", "Pp" ], [ "P", "Pp" ] ],
  return_type := "morphism",
  dual_operation := "PushoutFunctorialWithGivenPushouts",
  dual_arguments_reversed := true ),

CoequalizerFunctorialWithGivenCoequalizers := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "morphism", "list_of_morphisms", "object" ],
  io_type := [ [ "P", "morphisms", "mu", "morphismsp", "Pp" ], [ "P", "Pp" ] ],
  return_type := "morphism",
  dual_operation := "EqualizerFunctorialWithGivenEqualizers",
  dual_arguments_reversed := true ),

PushoutFunctorialWithGivenPushouts := rec(
  filter_list := [ "category", "object", "list_of_morphisms", "list_of_morphisms", "list_of_morphisms", "object" ],
  io_type := [ [ "P", "morphisms", "L", "morphismsp", "Pp" ], [ "P", "Pp" ] ],
  return_type := "morphism",
  dual_operation := "FiberProductFunctorialWithGivenFiberProducts",
  dual_arguments_reversed := true ),

HorizontalPreCompose := rec(
  filter_list := [ "category", "twocell", "twocell" ],
  dual_operation := "HorizontalPostCompose",
  
  pre_function := function( cat, twocell_1, twocell_2 )
    local value;
    
    value := IsEqualForObjects( Range( Source( twocell_1 ) ), Source( Source( twocell_2 ) ) );
    if value = fail then
        return [ false, "cannot decide whether 2-cells are horizontally composable" ];
    elif value = false then
        return [ false, "2-cells are not horizontally composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

HorizontalPostCompose := rec(
  filter_list := [ "category", "twocell", "twocell" ],
  dual_operation := "HorizontalPreCompose",
  
  pre_function := function( cat, twocell_2, twocell_1 )
    local value;
    
    value := IsEqualForObjects( Range( Source( twocell_1 ) ), Source( Source( twocell_2 ) ) );
    if value = fail then
        return [ false, "cannot decide whether 2-cells are horizontally composable" ];
    elif value = false then
        return [ false, "2-cells are not horizontally composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

VerticalPreCompose := rec(
  filter_list := [ "category", "twocell", "twocell" ],
  dual_operation := "VerticalPostCompose",
  
  pre_function := function( cat, twocell_1, twocell_2 )
    local value;
    
    value := IsEqualForMorphisms( Range( twocell_1 ), Source( twocell_2 ) );
    if value = fail then
        return [ false, "cannot decide whether 2-cells are vertically composable" ];
    elif value = false then
        return [ false, "2-cells are not vertically composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

VerticalPostCompose := rec(
  filter_list := [ "category", "twocell", "twocell" ],
  dual_operation := "VerticalPreCompose",
  
  pre_function := function( cat, twocell_2, twocell_1 )
    local value;
    
    value := IsEqualForMorphisms( Range( twocell_1 ), Source( twocell_2 ) );
    if value = fail then
        return [ false, "cannot decide whether 2-cells are vertically composable" ];
    elif value = false then
        return [ false, "2-cells are not vertically composable" ];
    fi;
    
    return [ true ];
  end,
  return_type := "twocell" ),

IdentityTwoCell := rec(
  filter_list := [ "category", "morphism" ],
  dual_operation := "IdentityTwoCell",
  return_type := "twocell" ),

IsWellDefinedForTwoCells := rec(
  filter_list := [ "category", "twocell" ],
  well_defined_todo := false,
  dual_operation := "IsWellDefinedForTwoCells",
  
  redirect_function := function( cat, twocell )
    
    if not( IsWellDefined( Source( twocell ) ) and IsWellDefined( Range( twocell ) ) ) then
      
      return [ true, false ];
      
    fi;
    
    return [ false ];
    
  end,
  
  return_type := "bool" ),
  
DirectSumDiagonalDifference := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "S", "D_1_range" ] ],
  return_type := "morphism",
  dual_operation := "DirectSumCodiagonalDifference",
  no_with_given := true ),
  
FiberProductEmbeddingInDirectSum := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "P", "S" ] ],
  return_type := "morphism",
  dual_operation := "DirectSumProjectionInPushout",
  no_with_given := true ),
  
IsomorphismFromFiberProductToKernelOfDiagonalDifference := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "P", "Delta" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCokernelOfDiagonalDifferenceToPushout",
  no_with_given := true ),
  
IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "Delta", "P" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromPushoutToCokernelOfDiagonalDifference",
  no_with_given := true ),
  
IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "P", "Delta" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoequalizerOfCoproductDiagramToPushout",
  no_with_given := true ),
  
IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "Delta", "P" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromPushoutToCoequalizerOfCoproductDiagram",
  no_with_given := true ),
  
IsomorphismFromPushoutToCokernelOfDiagonalDifference := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "I", "Delta" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromKernelOfDiagonalDifferenceToFiberProduct",
  no_with_given := true ),
  
IsomorphismFromCokernelOfDiagonalDifferenceToPushout := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "Delta", "I" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromFiberProductToKernelOfDiagonalDifference",
  no_with_given := true ),
  
IsomorphismFromPushoutToCoequalizerOfCoproductDiagram := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "P", "Delta" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromEqualizerOfDirectProductDiagramToFiberProduct",
  no_with_given := true ),
  
IsomorphismFromCoequalizerOfCoproductDiagramToPushout := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "Delta", "P" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromFiberProductToEqualizerOfDirectProductDiagram",
  no_with_given := true ),

IsomorphismFromImageObjectToKernelOfCokernel := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "I", "P" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCokernelOfKernelToCoimage",
  no_with_given := true ),

IsomorphismFromKernelOfCokernelToImageObject := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "P", "I" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoimageToCokernelOfKernel",
  no_with_given := true ),

IsomorphismFromCoimageToCokernelOfKernel := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "CI", "C" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromKernelOfCokernelToImageObject",
  no_with_given := true ),

IsomorphismFromCokernelOfKernelToCoimage := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "I", "CI" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromImageObjectToKernelOfCokernel",
  no_with_given := true ),

CanonicalIdentificationFromImageObjectToCoimage := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "I", "C" ] ],
  return_type := "morphism",
  dual_operation := "CanonicalIdentificationFromCoimageToImageObject",
  no_with_given := true ),

CanonicalIdentificationFromCoimageToImageObject := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "C", "I" ] ],
  return_type := "morphism",
  dual_operation := "CanonicalIdentificationFromImageObjectToCoimage",
  no_with_given := true ),

IsomorphismFromDirectSumToDirectProduct := rec(
  filter_list := [ "category", "list_of_objects" ],
  io_type := [ [ "D" ], [ "S", "P" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromCoproductToDirectSum",
  no_with_given := true ),

IsomorphismFromDirectSumToCoproduct := rec(
  filter_list := [ "category", "list_of_objects" ],
  io_type := [ [ "D" ], [ "S", "C" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromDirectProductToDirectSum",
  no_with_given := true ),

IsomorphismFromDirectProductToDirectSum := rec(
  filter_list := [ "category", "list_of_objects" ],
  io_type := [ [ "D" ], [ "P", "S" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromDirectSumToCoproduct",
  no_with_given := true ),

IsomorphismFromCoproductToDirectSum := rec(
  filter_list := [ "category", "list_of_objects" ],
  io_type := [ [ "D" ], [ "C", "S" ] ],
  return_type := "morphism",
  dual_operation := "IsomorphismFromDirectSumToDirectProduct",
  no_with_given := true ),

DirectSumCodiagonalDifference := rec(
  io_type := [ [ "D" ], [ "D_1_source", "S" ] ],
  filter_list := [ "category", "list_of_morphisms" ],
  return_type := "morphism",
  dual_operation := "DirectSumDiagonalDifference",
  no_with_given := true ),

DirectSumProjectionInPushout := rec(
  filter_list := [ "category", "list_of_morphisms" ],
  io_type := [ [ "D" ], [ "S", "I" ] ],
  return_type := "morphism",
  dual_operation := "FiberProductEmbeddingInDirectSum",
  no_with_given := true ),

SomeProjectiveObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  dual_operation := "SomeInjectiveObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "A" ], [ "P", "A" ] ],
  with_given_object_position := "Source",
  universal_type := "Limit", #FIXME: this is not a limit, but on a technical level, it behaves as if it was
  return_type := "morphism",
  dual_operation := "MonomorphismIntoSomeInjectiveObject",
  is_merely_set_theoretic := true ),

EpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "A", "P" ], [ "P", "A" ] ],
  universal_type := "Limit", #FIXME: this is not a limit, but on a technical level, it behaves as if it was
  return_type := "morphism",
  dual_operation := "MonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject",
  is_merely_set_theoretic := true ),

SomeInjectiveObject := rec(
  filter_list := [ "category", "object" ],
  return_type := "object",
  dual_operation := "SomeProjectiveObject",
  is_merely_set_theoretic := true ),

MonomorphismIntoSomeInjectiveObject := rec(
  filter_list := [ "category", "object" ],
  io_type := [ [ "A" ], [ "A", "I" ] ],
  with_given_object_position := "Range",
  universal_type := "Colimit", #FIXME: this is not a colimit, but on a technical level, it behaves as if it was
  return_type := "morphism",
  dual_operation := "EpimorphismFromSomeProjectiveObject",
  is_merely_set_theoretic := true ),

MonomorphismIntoSomeInjectiveObjectWithGivenSomeInjectiveObject := rec(
  filter_list := [ "category", "object", "object" ],
  io_type := [ [ "A", "I" ], [ "A", "I" ] ],
  universal_type := "Colimit", #FIXME: this is not a colimit, but on a technical level, it behaves as if it was
  return_type := "morphism",
  dual_operation := "EpimorphismFromSomeProjectiveObjectWithGivenSomeProjectiveObject",
  is_merely_set_theoretic := true ),

ComponentOfMorphismIntoDirectSum := rec(
  filter_list := [ "category", "morphism", "list_of_objects", IsInt ],
  io_type := [ [ "alpha", "S", "i" ], [ "alpha_source", "S_i" ] ],
  return_type := "morphism",
  dual_operation := "ComponentOfMorphismFromDirectSum" ),

ComponentOfMorphismFromDirectSum := rec(
  filter_list := [ "category", "morphism", "list_of_objects", IsInt ],
  io_type := [ [ "alpha", "S", "i" ], [ "S_i", "alpha_range" ] ],
  return_type := "morphism",
  dual_operation := "ComponentOfMorphismIntoDirectSum" ),

MorphismBetweenDirectSumsWithGivenDirectSums := rec(
  filter_list := [ "category", "object", "list_of_objects", IsList, "list_of_objects", "object" ],
  io_type := [ [ "S", "source_diagram", "mat", "range_diagram", "T" ], [ "S", "T" ] ],
  return_type := "morphism",
  pre_function := function( cat, source, source_diagram, listlist, range_diagram, range )
    local result, i, j;
      
      if Length( listlist ) <> Length( source_diagram ) then
          
          return [ false, "the number of rows does not match the length of the source diagram" ];
          
      fi;
      
      for i in [ 1 .. Length( listlist ) ] do
          
          if Length( listlist[i] ) <> Length( range_diagram ) then
              
              return [ false, Concatenation( "the ", String(i), "-th row has not the same length as the range diagram" ) ];
              
          fi;
          
          for j in [ 1 .. Length( range_diagram ) ] do
              
              result := IsEqualForObjects( source_diagram[i], Source( listlist[i][j] ) );
              
              if result = fail then
                  
                  return [ false, Concatenation( "cannot decide whether the sources of the morphisms in the ", String(i), "-th row are equal to the ", String(i), "-th entry of the source diagram" ) ];
                  
              elif result = false then
                  
                  return [ false, Concatenation( "the sources of the morphisms in the ", String(i), "-th row must be equal to the ", String(i), "-th entry of the source diagram" ) ];
                  
              fi;
              
              result := IsEqualForObjects( range_diagram[j], Range( listlist[i][j] ) );
              
              if result = fail then
                  
                  return [ false, Concatenation( "cannot decide whether the ranges of the morphisms in the ", String(j), "-th column are equal to the ", String(j), "-th entry of the range diagram" ) ];
                  
              elif result = false then
                  
                  return [ false, Concatenation( "the ranges of the morphisms in the ", String(j), "-th column must be equal to the ", String(j), "-th entry of the range diagram" ) ];
                  
              fi;
              
          od;
          
      od;
      
      return [ true ];
      
  end,
  dual_operation := "MorphismBetweenDirectSumsWithGivenDirectSums",
  dual_preprocessor_func := function( arg )
      local list;
      list := CAP_INTERNAL_OPPOSITE_RECURSIVE( arg );
      return [ list[1], list[6], list[5], TransposedMat( list[4] ), list[3], list[2] ];
  end
),

IsHomSetInhabited := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "bool",
  dual_operation := "IsHomSetInhabited",
  dual_arguments_reversed := true,
),

HomomorphismStructureOnObjects := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "other_object",
  dual_operation := "HomomorphismStructureOnObjects",
  dual_arguments_reversed := true,
  dual_postprocessor_func := IdFunc
),

HomomorphismStructureOnMorphismsWithGivenObjects := rec(
  filter_list := [ "category", "other_object", "morphism", "morphism", "other_object" ],
  return_type := "other_morphism",
  dual_operation := "HomomorphismStructureOnMorphismsWithGivenObjects",
  dual_preprocessor_func := function( cat, source, alpha, beta, range )
    return [ Opposite( cat ), source, MorphismDatum( cat, beta ), MorphismDatum( cat, alpha ), range ];
  end,
  dual_postprocessor_func := IdFunc
),

DistinguishedObjectOfHomomorphismStructure := rec(
  filter_list := [ "category" ],
  return_type := "other_object",
  dual_operation := "DistinguishedObjectOfHomomorphismStructure",
  dual_postprocessor_func := IdFunc ),

InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure := rec(
  filter_list := [ "category", "morphism" ],
  return_type := "other_morphism",
  dual_operation := "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
  dual_postprocessor_func := IdFunc
),

InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism := rec(
  filter_list := [ "category", "object", "object", "other_morphism" ],
  return_type := "morphism",
  dual_operation := "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
  dual_preprocessor_func := function( cat, A, B, morphism )
    return [ Opposite( cat ), ObjectDatum( cat, B ), ObjectDatum( cat, A ), morphism ];
  end
),

SolveLinearSystemInAbCategory := rec(
  filter_list := [ "category", IsList, IsList, "list_of_morphisms" ],
  return_type := "list_of_morphisms",
  pre_function := function( cat, left_coeffs, right_coeffs, rhs )
    
    if not Length( left_coeffs ) > 0 then
        return [ false, "the list of left coefficients is empty" ];
    fi;
    
    if not Length( left_coeffs ) = Length( right_coeffs ) then
        return [ false, "the list of left coefficients and the list of right coefficients do not have the same length" ];
    fi;
    
    if not Length( left_coeffs ) = Length( rhs ) then
        return [ false, "the list of left coefficients does not have the same length as the right hand side" ];
    fi;
    
    if not ForAll( Concatenation( left_coeffs, right_coeffs ), x -> IsList( x ) and Length( x ) = Length( left_coeffs[1] ) and ForAll( x, y -> IsCapCategoryMorphism( y ) and IsIdenticalObj( CapCategory( y ), cat ) ) ) then
        return [ false, "the left coefficients and the right coefficients must be given by lists of lists of the same length containing morphisms in the current category" ];
    fi;
    
    return [ true ];
    
  end,
  pre_function_full := function( cat, left_coeffs, right_coeffs, rhs )
    
    if not ForAll( [ 1 .. Length( left_coeffs ) ], i -> ForAll( left_coeffs[i], coeff -> IsEqualForObjects( Source( coeff ), Source( rhs[i] ) ) <> false ) ) then
        return [ false, "the sources of the left coefficients must correspond to the sources of the right hand side" ];
    fi;
    
    if not ForAll( [ 1 .. Length( right_coeffs ) ], i -> ForAll( right_coeffs[i], coeff -> IsEqualForObjects( Range( coeff ), Range( rhs[i] ) ) <> false ) ) then
        return [ false, "the ranges of the right coefficients must correspond to the ranges of the right hand side" ];
    fi;
    
    if not ForAll( [ 1 .. Length( left_coeffs[1] ) ], j -> ForAll( left_coeffs, x -> IsEqualForObjects( Range( x[j] ), Range( left_coeffs[1][j] ) ) <> false ) ) then
        return [ false, "all ranges in a column of the left coefficients must be equal" ];
    fi;
    
    if not ForAll( [ 1 .. Length( right_coeffs[1] ) ], j -> ForAll( right_coeffs, x -> IsEqualForObjects( Source( x[j] ), Source( right_coeffs[1][j] ) ) <> false ) ) then
        return [ false, "all sources in a column of the right coefficients must be equal" ];
    fi;
    
    return [ true ];
    
  end,
),

SolveLinearSystemInAbCategoryOrFail := rec(
  filter_list := [ "category", IsList, IsList, "list_of_morphisms" ],
  return_type := "list_of_morphisms_or_fail",
  pre_function := ~.SolveLinearSystemInAbCategory.pre_function,
  pre_function_full := ~.SolveLinearSystemInAbCategory.pre_function_full
),

MereExistenceOfSolutionOfLinearSystemInAbCategory := rec(
  filter_list := [ "category", IsList, IsList, "list_of_morphisms" ],
  return_type := "bool",
  pre_function := ~.SolveLinearSystemInAbCategory.pre_function,
  pre_function_full := ~.SolveLinearSystemInAbCategory.pre_function_full
),

BasisOfExternalHom := rec(
  filter_list := [ "category", "object", "object" ],
  return_type := "list_of_morphisms",
  dual_operation := "BasisOfExternalHom",
  dual_arguments_reversed := true
),

CoefficientsOfMorphismWithGivenBasisOfExternalHom := rec(
  filter_list := [ "category", "morphism", "list_of_morphisms" ],
  return_type := IsList,
  dual_operation := "CoefficientsOfMorphismWithGivenBasisOfExternalHom",
  dual_postprocessor_func := IdFunc
),

RandomObjectByInteger := rec(
  filter_list := [ "category", IsInt ],
  io_type := [ [ "n" ], [ "A" ] ],
  return_type := "object_or_fail"
),

RandomMorphismByInteger := rec(
  filter_list := [ "category", IsInt ],
  io_type := [ [ "n" ], [ "alpha" ] ],
  return_type := "morphism_or_fail"
),

RandomMorphismWithFixedSourceByInteger := rec(
  filter_list := [ "category", "object", IsInt ],
  io_type := [ [ "A", "n" ], [ "A", "B" ] ],
  return_type := "morphism_or_fail",
),

RandomMorphismWithFixedRangeByInteger := rec(
  filter_list := [ "category", "object", IsInt ],
  io_type := [ [ "B", "n" ], [ "A", "B" ] ],
  return_type := "morphism_or_fail",
),

RandomMorphismWithFixedSourceAndRangeByInteger := rec(
  filter_list := [ "category", "object", "object", IsInt ],
  io_type := [ [ "A", "B", "n" ], [ "A", "B" ] ],
  return_type := "morphism_or_fail",
),

RandomObjectByList := rec(
  filter_list := [ "category", IsList ],
  io_type := [ [ "L" ], [ "A" ] ],
  return_type := "object_or_fail"
),

RandomMorphismByList := rec(
  filter_list := [ "category", IsList ],
  io_type := [ [ "L" ], [ "alpha" ] ],
  return_type := "morphism_or_fail"
),

RandomMorphismWithFixedSourceByList := rec(
  filter_list := [ "category", "object", IsList ],
  io_type := [ [ "A", "L" ], [ "A", "B" ] ],
  return_type := "morphism_or_fail",
),

RandomMorphismWithFixedRangeByList := rec(
  filter_list := [ "category", "object", IsList ],
  io_type := [ [ "B", "L" ], [ "A", "B" ] ],
  return_type := "morphism_or_fail"
),

RandomMorphismWithFixedSourceAndRangeByList := rec(
  filter_list := [ "category", "object", "object", IsList ],
  io_type := [ [ "A", "B", "L" ], [ "A", "B" ] ],
  return_type := "morphism_or_fail"
),

HomologyObject := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "H" ] ],
  return_type := "object",
  pre_function := function( cat, alpha, beta )
      if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then
            
            return [ false, "the range of the first morphism has to be equal to the source of the second morphism" ];
            
      fi;
      
      return [ true ];
      
  end,
  dual_operation := "HomologyObject",
  dual_arguments_reversed := true
),

HomologyObjectFunctorialWithGivenHomologyObjects := rec(
  filter_list := [ "category", "object", IsList, "object" ],
  io_type := [ [ "H_1", "L", "H_2" ], [ "H_1", "H_2" ] ],
  return_type := "morphism",
  pre_function := function( cat, H_1, L, H2 )
      local alpha, beta, epsilon, gamma, delta;
      
      alpha := L[1];
      
      beta := L[2];
      
      epsilon := L[3];
      
      gamma := L[4];
      
      delta := L[5];
      
      if not IsEqualForObjects( Range( alpha ), Source( beta ) ) then
            
            return [ false, "the range of the first morphism has to be equal to the source of the second morphism" ];
            
      fi;
      
      if not IsEqualForObjects( Range( gamma ), Source( delta ) ) then
            
            return [ false, "the range of the fourth morphism has to be equal to the source of the fifth morphism" ];
            
      fi;
      
      if not IsEqualForObjects( Source( epsilon ), Source( beta ) ) then
            
            return [ false, "the source of the third morphism has to be equal to the source of the second morphism" ];
            
      fi;
      
      if not IsEqualForObjects( Range( epsilon ), Range( gamma ) ) then
            
            return [ false, "the range of the third morphism has to be equal to the range of the fourth morphism" ];
            
      fi;
      
      return [ true ];
      
  end,
  dual_operation := "HomologyObjectFunctorialWithGivenHomologyObjects",
  dual_preprocessor_func := function( arg )
      local list;
      list := CAP_INTERNAL_OPPOSITE_RECURSIVE( arg );
      return [ list[1], list[4], Reversed( list[3] ), list[2] ];
  end
),

IsomorphismFromHomologyObjectToItsConstructionAsAnImageObject := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "A", "B" ] ],
  return_type := "morphism" ),

IsomorphismFromItsConstructionAsAnImageObjectToHomologyObject := rec(
  filter_list := [ "category", "morphism", "morphism" ],
  io_type := [ [ "alpha", "beta" ], [ "A", "B" ] ],
  return_type := "morphism" ),
  
## SimplifyObject*
SimplifyObject := rec(
  filter_list := [ "category", "object", IsCyclotomic ],
  io_type := [ [ "A", "n" ], [ "B" ] ],
  return_type := "object",
  dual_operation := "SimplifyObject",
  redirect_function := function( cat, A, n )
    
    if n = 0 then
        return [ true, A ];
    fi;
    
    return [ false ];
    
  end,
  pre_function := function( cat, A, n )
    
    if not ( IsPosInt( n ) or IsInfinity( n ) ) then
        return [ false, "the second argument must be a non-negative integer or infinity" ];
    fi;
    
    return [ true ];
    
  end 
  ),

SimplifyObject_IsoFromInputObject := rec(
  filter_list := [ "category", "object", IsCyclotomic ],
  io_type := [ [ "A", "n" ], [ "A", "B" ] ],
  return_type := "morphism",
  dual_operation := "SimplifyObject_IsoToInputObject",
  redirect_function := function( cat, A, n )
    
    if n = 0 then
        return [ true, IdentityMorphism( A ) ];
    fi;
    
    return [ false ];
    
  end,
  pre_function := ~.SimplifyObject.pre_function
  ),

SimplifyObject_IsoToInputObject := rec(
  filter_list := [ "category", "object", IsCyclotomic ],
  io_type := [ [ "A", "n" ], [ "B", "A" ] ],
  return_type := "morphism",
  dual_operation := "SimplifyObject_IsoFromInputObject",
  redirect_function := ~.SimplifyObject_IsoFromInputObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),

## SimplifyMorphism
SimplifyMorphism := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "mor_source", "mor_range" ] ],
  return_type := "morphism",
  dual_operation := "SimplifyMorphism",
  redirect_function := ~.SimplifyObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),

## SimplifySource*
SimplifySource := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "Ap", "mor_range" ] ],
  return_type := "morphism",
  dual_operation := "SimplifyRange",
  redirect_function := ~.SimplifyObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),

SimplifySource_IsoToInputObject := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "Ap", "mor_source" ] ],
  return_type := "morphism",
  dual_operation := "SimplifyRange_IsoFromInputObject",
  redirect_function := function( cat, alpha, n )
    
    if n = 0 then
        return [ true, IdentityMorphism( Source( alpha ) ) ];
    fi;
    
    return [ false ];
    
  end,
  pre_function := ~.SimplifyObject.pre_function
  ),
  
SimplifySource_IsoFromInputObject := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "mor_source", "Ap" ] ],
  return_type := "morphism",
  dual_operation := "SimplifyRange_IsoToInputObject",
  redirect_function := ~.SimplifySource_IsoToInputObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),

## SimplifyRange*
SimplifyRange := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "mor_source", "Bp" ] ],
  return_type := "morphism",
  dual_operation := "SimplifySource",
  redirect_function := ~.SimplifyObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),

SimplifyRange_IsoToInputObject := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "Bp", "mor_range" ] ],
  return_type := "morphism",
  dual_operation := "SimplifySource_IsoFromInputObject",
  redirect_function := function( cat, alpha, n )
    
    if n = 0 then
        return [ true, IdentityMorphism( Range( alpha ) ) ];
    fi;
    
    return [ false ];
    
  end,
  pre_function := ~.SimplifyObject.pre_function
  ),
  
SimplifyRange_IsoFromInputObject := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "mor_range", "Bp" ] ],
  return_type := "morphism",
  dual_operation := "SimplifySource_IsoToInputObject",
  redirect_function := ~.SimplifySource_IsoToInputObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),

## SimplifySourceAndRange*
SimplifySourceAndRange := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "Ap", "Bp" ] ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange",
  redirect_function := ~.SimplifyObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),

SimplifySourceAndRange_IsoToInputSource := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "Ap", "mor_source" ] ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange_IsoFromInputRange",
  redirect_function := ~.SimplifySource_IsoToInputObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),
  
SimplifySourceAndRange_IsoFromInputSource := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "mor_source", "Ap" ] ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange_IsoToInputRange",
  redirect_function := ~.SimplifySource_IsoToInputObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),

SimplifySourceAndRange_IsoToInputRange := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "Bp", "mor_range" ] ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange_IsoFromInputSource",
  redirect_function := ~.SimplifySource_IsoToInputObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),
  
SimplifySourceAndRange_IsoFromInputRange := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "mor_range", "Bp" ] ],
  return_type := "morphism",
  dual_operation := "SimplifySourceAndRange_IsoToInputSource",
  redirect_function := ~.SimplifySource_IsoToInputObject.redirect_function,
  pre_function := ~.SimplifyObject.pre_function
  ),

## SimplifyEndo*
SimplifyEndo := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "Ap", "Ap" ] ],
  return_type := "morphism",
  dual_operation := "SimplifyEndo",
  redirect_function := ~.SimplifyObject.redirect_function,
  pre_function := function( cat, endo, n )
    
    if not ( IsPosInt( n ) or IsInfinity( n ) ) then
        return [ false, "the second argument must be a non-negative integer or infinity" ];
    fi;
    
    if not IsEndomorphism( endo ) then
        return [ false, "the first argument must be an endomorphism" ];
    fi;
    
    return [ true ];
    
  end 
  ),

SimplifyEndo_IsoFromInputObject := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "mor_source", "Ap" ] ],
  return_type := "morphism",
  dual_operation := "SimplifyEndo_IsoToInputObject",
  redirect_function := ~.SimplifySource_IsoToInputObject.redirect_function,
  pre_function := ~.SimplifyEndo.pre_function
  ),

SimplifyEndo_IsoToInputObject := rec(
  filter_list := [ "category", "morphism", IsCyclotomic ],
  io_type := [ [ "mor", "n" ], [ "Ap", "mor_range" ] ],
  return_type := "morphism",
  dual_operation := "SimplifyEndo_IsoFromInputObject",
  redirect_function := ~.SimplifySource_IsoToInputObject.redirect_function,
  pre_function := ~.SimplifyEndo.pre_function
  ),

SomeReductionBySplitEpiSummand := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "Ap", "Bp" ] ],
  return_type := "morphism",
  ),

SomeReductionBySplitEpiSummand_MorphismToInputRange := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "Bp", "B" ] ],
  return_type := "morphism",
  ),

SomeReductionBySplitEpiSummand_MorphismFromInputRange := rec(
  filter_list := [ "category", "morphism" ],
  io_type := [ [ "alpha" ], [ "B", "Bp" ] ],
  return_type := "morphism",
  )

) );

InstallValue( CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS, [
rec(
  object_specification := [ "varobject" ],
  morphism_specification := [  ],
  limit_object_name := "DirectProduct",
  colimit_object_name := "Coproduct",
),

rec(
  object_specification := [ "varobject" ],
  morphism_specification := [  ],
  limit_object_name := "DirectSum",
  colimit_object_name := "DirectSum",
),

rec(
  object_specification := [ "fixedobject", "varobject" ],
  morphism_specification := [ [ 2, "varmorphism", 1 ] ],
  limit_object_name := "FiberProduct",
  colimit_object_name := "Pushout",
),

rec(
  object_specification := [ "fixedobject", "fixedobject" ],
  morphism_specification := [ [ 1, "varmorphism", 2 ] ],
  limit_object_name := "Equalizer",
  limit_projection_name := "EmbeddingOfEqualizer",
  colimit_object_name := "Coequalizer",
  colimit_injection_name := "ProjectionOntoCoequalizer",
),

rec(
  object_specification := [ "fixedobject", "fixedobject" ],
  morphism_specification := [ [ 1, "fixedmorphism", 2 ], [ 1, "zeromorphism", 2 ] ],
  limit_object_name := "KernelObject",
  limit_projection_name := "KernelEmbedding",
  limit_universal_morphism_name := "KernelLift",
  colimit_object_name := "CokernelObject",
  colimit_injection_name := "CokernelProjection",
  colimit_universal_morphism_name := "CokernelColift",
),

rec(
  object_specification := [ ],
  morphism_specification := [ ],
  limit_object_name := "TerminalObject",
  colimit_object_name := "InitialObject",
),

rec(
  object_specification := [ ],
  morphism_specification := [ ],
  limit_object_name := "ZeroObject",
  colimit_object_name := "ZeroObject",
)

] );

InstallGlobalFunction( "CAP_INTERNAL_ENHANCE_NAME_RECORD_LIMITS",
  function ( limits )
    local object_specification, morphism_specification, source_position, type, range_position, unbound_morphism_positions, number_of_unbound_morphisms, unbound_objects, morphism, unbound_object_positions, number_of_unbound_objects, targets, target_positions, nontarget_positions, number_of_targets, number_of_nontargets, diagram_filter_list, diagram_input_type, limit, position;
    
    for limit in limits do
        object_specification := limit.object_specification;
        morphism_specification := limit.morphism_specification;
        
        #### check that given diagram is well-defined
        if not (IsDenseList( object_specification ) and IsDenseList( morphism_specification )) then
            Error( "the given diagram is not well-defined" );
        fi;

        if Length( object_specification ) = 0 and Length( morphism_specification ) > 0 then
            Error( "the given diagram is not well-defined" );
        fi;
        
        if not (ForAll( object_specification, object -> object in [ "fixedobject", "varobject" ] )) then
            Error( "the given diagram is not well-defined" );
        fi;

        for morphism in morphism_specification do
            if not (IsList( morphism ) and Length( morphism ) = 3) then
                Error( "the given diagram is not well-defined" );
            fi;
            source_position := morphism[1];
            type := morphism[2];
            range_position := morphism[3];

            if not (IsInt( source_position ) and source_position >= 1 and source_position <= Length( object_specification )) then
                Error( "the given diagram is not well-defined" );
            fi;

            if not (IsInt( range_position ) and range_position >= 1 and range_position <= Length( object_specification )) then
                Error( "the given diagram is not well-defined" );
            fi;

            if not type in [ "fixedmorphism", "varmorphism", "zeromorphism" ] then
                Error( "the given diagram is not well-defined" );
            fi;

            if type = "fixedmorphism" and (object_specification[source_position] = "varobject" or object_specification[range_position] = "varobject") then
                Error( "the given diagram is not well-defined" );
            fi;
        od;

        #### get number of variables
        # morphisms
        unbound_morphism_positions := PositionsProperty( morphism_specification, x -> x[2] = "varmorphism" or x[2] = "fixedmorphism" );
        if Length( unbound_morphism_positions ) = 0 then
            number_of_unbound_morphisms := 0;
        elif Length( unbound_morphism_positions ) = 1 and morphism_specification[unbound_morphism_positions[1]][2] = "fixedmorphism" then
            number_of_unbound_morphisms := 1;
        else
            number_of_unbound_morphisms := 2;
        fi;

        limit.unbound_morphism_positions := unbound_morphism_positions;
        limit.number_of_unbound_morphisms := number_of_unbound_morphisms;

        if not ForAll( unbound_morphism_positions, i -> morphism_specification[i][2] = "fixedmorphism" or i = Length( unbound_morphism_positions ) ) then
            Error( "diagrams of the given type are not supported" );
        fi;

        # objects
        unbound_objects := StructuralCopy( object_specification );
        for position in unbound_morphism_positions do
            morphism := morphism_specification[position];
            source_position := morphism[1];
            range_position := morphism[3];

            unbound_objects[source_position] := "";
            unbound_objects[range_position] := "";
        od;
        unbound_object_positions := PositionsProperty( unbound_objects, x -> x <> "" );
        if Length( unbound_object_positions ) = 0 then
            number_of_unbound_objects := 0;
        elif Length( unbound_object_positions ) = 1 and object_specification[unbound_object_positions[1]] = "fixedobject" then
            number_of_unbound_objects := 1;
        else
            number_of_unbound_objects := 2;
        fi;

        limit.unbound_object_positions := unbound_object_positions;
        limit.number_of_unbound_objects := number_of_unbound_objects;

        if not ForAll( unbound_object_positions, i -> object_specification[i] = "fixedobject" or i = Length( unbound_object_positions ) ) then
            Error( "diagrams of the given type are not supported" );
        fi;

        # (non-)targets
        targets := StructuralCopy( object_specification );
        for morphism in morphism_specification do
            range_position := morphism[3];
            
            targets[range_position] := "";
        od;
        target_positions := PositionsProperty( targets, x -> x <> "" );
        nontarget_positions := PositionsProperty( targets, x -> x = "" );
        if Length( target_positions ) = 0 then
            number_of_targets := 0;
        elif Length( target_positions ) = 1 and object_specification[target_positions[1]] = "fixedobject" then
            number_of_targets := 1;
        else
            number_of_targets := 2;
        fi;
        if Length( nontarget_positions ) = 0 then
            number_of_nontargets := 0;
        elif Length( nontarget_positions ) = 1 and object_specification[nontarget_positions[1]] = "fixedobject" then
            number_of_nontargets := 1;
        else
            number_of_nontargets := 2;
        fi;

        limit.target_positions := target_positions;
        limit.number_of_targets := number_of_targets;
        limit.nontarget_positions := nontarget_positions;
        limit.number_of_nontargets := number_of_nontargets;

        #### get filter list and input type of the diagram
        diagram_filter_list := [ ];
        diagram_input_type := [ ];
        if number_of_unbound_objects = 1 then
            Add( diagram_filter_list, "object" );
            Add( diagram_input_type, "X" );
        elif number_of_unbound_objects > 1 then
            Add( diagram_filter_list, "list_of_objects" );
            Add( diagram_input_type, "objects" );
        fi;
        if number_of_unbound_morphisms = 1 then
            Add( diagram_filter_list, "morphism" );
            Add( diagram_input_type, "alpha" );
        elif number_of_unbound_morphisms > 1 then
            Add( diagram_filter_list, "list_of_morphisms" );
            Add( diagram_input_type, "morphisms" );
        fi;

        limit.diagram_filter_list := diagram_filter_list;
        limit.diagram_input_type := diagram_input_type;
        
        #### set default projection/injection/universal morphism names
        if number_of_targets > 0 and not IsBound( limit.limit_projection_name ) then
            limit.limit_projection_name := Concatenation( "ProjectionInFactorOf", limit.limit_object_name );
        fi;
        if not IsBound( limit.limit_universal_morphism_name ) then
            limit.limit_universal_morphism_name := Concatenation( "UniversalMorphismInto", limit.limit_object_name );
        fi;

        if number_of_targets > 0 and not IsBound( limit.colimit_injection_name ) then
            limit.colimit_injection_name := Concatenation( "InjectionOfCofactorOf", limit.colimit_object_name );
        fi;
        if not IsBound( limit.colimit_universal_morphism_name ) then
            limit.colimit_universal_morphism_name := Concatenation( "UniversalMorphismFrom", limit.colimit_object_name );
        fi;

        limit.limit_functorial_name := Concatenation( limit.limit_object_name, "Functorial" );
        limit.colimit_functorial_name := Concatenation( limit.colimit_object_name, "Functorial" );

        limit.limit_functorial_with_given_name := Concatenation( limit.limit_functorial_name, "WithGiven", limit.limit_object_name, "s" );
        limit.colimit_functorial_with_given_name := Concatenation( limit.colimit_functorial_name, "WithGiven", limit.colimit_object_name, "s" );

        if limit.number_of_nontargets = 1 then
            limit.limit_morphism_to_sink_name := Concatenation( "MorphismFrom", limit.limit_object_name, "ToSink" );
            limit.colimit_morphism_from_source_name := Concatenation( "MorphismFromSourceTo", limit.colimit_object_name );
        fi;

        if Length( diagram_filter_list ) > 0 then
            if limit.number_of_targets = 1 then
                limit.diagram_morphism_filter_list := [ "morphism" ];
                limit.diagram_morphism_input_type := [ "mu" ];
            else
                limit.diagram_morphism_filter_list := [ "list_of_morphisms" ];
                limit.diagram_morphism_input_type := [ "L" ];
            fi;
        fi;
    od;
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD_LIMITS( CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS );


BindGlobal( "CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES", function ( method_record, entry_name, generated_entry )
    local excluded_names, method_record_entry, name;
    
    excluded_names := [ "function_name", "pre_function", "pre_function_full", "post_function" ];

    if not IsBound( method_record.(entry_name) ) then
        Display( Concatenation( "WARNING: The method record is missing a component named \"", entry_name, "\" which is expected by the validator.\n" ) );
        return;
    fi;

    method_record_entry := method_record.(entry_name);
    
    for name in RecNames( method_record_entry ) do
        if name in excluded_names then
            continue;
        fi;
        if not IsBound( generated_entry.(name) ) then
            Display( Concatenation( "WARNING: The entry \"", entry_name, "\" in the method record has a component named \"", name, "\" which is not expected by the validator.\n" ) );
        elif method_record_entry.(name) <> generated_entry.(name) then
            Display( Concatenation( "WARNING: The entry \"", entry_name, "\" in the method record has a component named \"", name, "\" with value \"", String( method_record_entry.(name) ), "\". The value expected by the validator is \"", String( generated_entry.(name) ), "\".\n" ) );
        fi;
    od;
    for name in RecNames( generated_entry ) do
        if name in excluded_names then
            continue;
        fi;
        if not IsBound( method_record_entry.(name) ) then
            Display( Concatenation( "WARNING: The entry \"", entry_name, "\" in the method record is missing a component named \"", name, "\" which is expected by the validator.\n" ) );
        fi;
    od;
end );

InstallGlobalFunction( CAP_INTERNAL_VALIDATE_LIMITS_IN_NAME_RECORD,
  function ( method_name_record, limits )
    local make_record_with_given, make_colimit, object_universal_type, object_filter_list, projection_filter_list, projection_io_type, morphism_to_sink_filter_list, morphism_to_sink_io_type, universal_morphism_filter_list, universal_morphism_io_type, object_record, projection_record, morphism_to_sink_record, filter_list, io_type, with_given_object_position, universal_type, return_type, dual_operation, universal_morphism_record, functorial_record, no_with_given, dual_arguments_reversed, limit;
    
    #### helper functions
    make_record_with_given := function ( record, object_name, coobject_name )
        record := StructuralCopy( record );
        
        record.function_name := Concatenation( record.function_name, "WithGiven", object_name );
        Add( record.filter_list, "object" );
        if record.with_given_object_position = "Source" then
            Add( record.io_type[1], record.io_type[2][1] );
        else
            Add( record.io_type[1], record.io_type[2][2] );
        fi;
        record.dual_operation := Concatenation( record.dual_operation, "WithGiven", coobject_name );
        Unbind( record.with_given_object_position );

        return record;
    end;

    make_colimit := function ( record, args... )
        local reverse_output_type, orig_function_name;
        
        
        if Length( args ) > 1 then
            Error( "make_colimit must be called with at most two arguments" );
        elif Length( args ) = 1 then
            reverse_output_type := args[1];
        else
            reverse_output_type := true;
        fi;
        
        record := StructuralCopy( record );
        
        orig_function_name := record.function_name;
        record.function_name := record.dual_operation;
        record.dual_operation := orig_function_name;
        
        if IsBound( record.io_type ) and reverse_output_type then
            record.io_type[2] := Reversed( record.io_type[2] );
            record.io_type[2] := List( record.io_type[2], x -> ReplacedString( x, "source", "tmp" ) );
            record.io_type[2] := List( record.io_type[2], x -> ReplacedString( x, "range", "source" ) );
            record.io_type[2] := List( record.io_type[2], x -> ReplacedString( x, "tmp", "range" ) );
        fi;

        if IsBound( record.with_given_object_position ) then
            if record.with_given_object_position = "Source" then
                record.with_given_object_position := "Range";
            else
                record.with_given_object_position := "Source";
            fi;
        fi;

        if IsBound( record.universal_type ) then
            if record.universal_type = "Limit" then
                record.universal_type := "Colimit";
            fi;
        fi;

        return record;
    end;

    for limit in limits do
        #### get universal type
        if limit.limit_object_name = limit.colimit_object_name then
            object_universal_type := "LimitColimit";
        else
            object_universal_type := "Limit";
        fi;

        #### get filter lists and io types
        object_filter_list := Concatenation( [ "category" ], StructuralCopy( limit.diagram_filter_list ) );
        
        # only used if limit.number_of_targets > 0
        projection_filter_list := Concatenation( [ "category" ], StructuralCopy( limit.diagram_filter_list ) );
        projection_io_type := [ StructuralCopy( limit.diagram_input_type ), [ ] ];
        if limit.number_of_targets > 1 then
            Add( projection_filter_list, IsInt );
            Add( projection_io_type[1], "k" );
        fi;
        if limit.target_positions = limit.unbound_object_positions then
            # io_type can be derived from the objects
            if limit.number_of_targets = 1 then
                projection_io_type[2] := [ "P", "X" ];
            else
                projection_io_type[2] := [ "P", "objects_k" ];
            fi;
        elif limit.target_positions = List( limit.unbound_morphism_positions, i -> limit.morphism_specification[i][1] ) then
            # io_type can be derived from the morphisms as sources
            if limit.number_of_unbound_morphisms = 1 then
                projection_io_type[2] := [ "P", "alpha_source" ];
            elif limit.number_of_targets = 1 then
                projection_io_type[2] := [ "P", "morphisms_1_source" ];
            else
                projection_io_type[2] := [ "P", "morphisms_k_source" ];
            fi;
        elif limit.target_positions = List( limit.unbound_morphism_positions, i -> limit.morphism_specification[i][3] ) then
            # io_type can be derived from the morphisms as ranges
            if limit.number_of_unbound_morphisms = 1 then
                projection_io_type[2] := [ "P", "alpha_range" ];
            elif limit.number_of_targets = 1 then
                projection_io_type[2] := [ "P", "morphisms_1_range" ];
            else
                projection_io_type[2] := [ "P", "morphisms_k_range" ];
            fi;
        else
            Error( "Warning: cannot express io_type" );
        fi;

        # only used if limit.number_of_nontargets = 1
        morphism_to_sink_filter_list := Concatenation( [ "category" ], StructuralCopy( limit.diagram_filter_list ) );
        morphism_to_sink_io_type := [ StructuralCopy( limit.diagram_input_type ), [ ] ];
        if limit.number_of_unbound_morphisms = 1 then
            morphism_to_sink_io_type[2] := [ "P", "alpha_range" ];
        elif limit.number_of_unbound_morphisms > 1 then
            morphism_to_sink_io_type[2] := [ "P", "morphisms_1_range" ];
        fi;

        universal_morphism_filter_list := Concatenation( [ "category" ], StructuralCopy( limit.diagram_filter_list ), [ "object" ] );
        universal_morphism_io_type := [ Concatenation( StructuralCopy( limit.diagram_input_type ), [ "T" ] ), [ "T", "P" ] ];
        if limit.number_of_targets = 1 then
            Add( universal_morphism_filter_list, "morphism" );
            Add( universal_morphism_io_type[1], "tau" );
        elif limit.number_of_targets > 1 then
            Add( universal_morphism_filter_list, "list_of_morphisms" );
            Add( universal_morphism_io_type[1], "tau" );
        fi;

        
        #### get base records
        object_record :=  rec(
            function_name := limit.limit_object_name,
            filter_list := object_filter_list,
            universal_type := object_universal_type,
            return_type := "object",
            dual_operation := limit.colimit_object_name,
        );

        if limit.number_of_targets > 0 then
            projection_record := rec(
                function_name := limit.limit_projection_name,
                filter_list := projection_filter_list,
                io_type := projection_io_type,
                with_given_object_position := "Source",
                universal_type := "Limit",
                return_type := "morphism",
                dual_operation := limit.colimit_injection_name,
            );
        fi;

        if limit.number_of_nontargets = 1 then
            morphism_to_sink_record := rec(
                function_name := Concatenation( "MorphismFrom", limit.limit_object_name, "ToSink" ),
                filter_list := morphism_to_sink_filter_list,
                io_type := morphism_to_sink_io_type,
                with_given_object_position := "Source",
                universal_type := "Limit",
                return_type := "morphism",
                dual_operation := limit.colimit_morphism_from_source_name,
            );
        fi;

        universal_morphism_record := rec(
            function_name := limit.limit_universal_morphism_name,
            filter_list := universal_morphism_filter_list,
            io_type := universal_morphism_io_type,
            with_given_object_position := "Range",
            universal_type := "Limit",
            return_type := "morphism",
            dual_operation := limit.colimit_universal_morphism_name,
        );

        if IsEmpty( limit.diagram_filter_list ) then
            functorial_record := rec(
                function_name := limit.limit_functorial_name,
                filter_list := [ "category" ],
                return_type := "morphism",
                dual_operation := limit.colimit_functorial_name,
                no_with_given := true,
            );
        else
            functorial_record := rec(
                function_name := limit.limit_functorial_with_given_name,
                filter_list := Concatenation( [ "category", "object" ], limit.diagram_filter_list, limit.diagram_morphism_filter_list, limit.diagram_filter_list, [ "object" ] ),
                io_type := [ Concatenation( [ "P" ], limit.diagram_input_type, limit.diagram_morphism_input_type, List( limit.diagram_input_type, x -> Concatenation( x, "p" ) ), [ "Pp" ] ), [ "P", "Pp" ] ],
                return_type := "morphism",
                dual_operation := limit.colimit_functorial_with_given_name,
                dual_arguments_reversed := true,
            );
        fi;
        
        #### validate limit records
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_object_name, object_record );

        if limit.number_of_targets > 0 then
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_projection_name, projection_record );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, Concatenation( limit.limit_projection_name, "WithGiven", limit.limit_object_name ), make_record_with_given( projection_record, limit.limit_object_name, limit.colimit_object_name ) );
        fi;
        
        if limit.number_of_nontargets = 1 then
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_morphism_to_sink_name, morphism_to_sink_record );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, Concatenation( limit.limit_morphism_to_sink_name, "WithGiven", limit.limit_object_name ), make_record_with_given( morphism_to_sink_record, limit.limit_object_name, limit.colimit_object_name ) );
        fi;
        
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.limit_universal_morphism_name, universal_morphism_record );
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, Concatenation( limit.limit_universal_morphism_name, "WithGiven", limit.limit_object_name ), make_record_with_given( universal_morphism_record, limit.limit_object_name, limit.colimit_object_name ) );

        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, functorial_record.function_name, functorial_record );

        #### validate colimit records
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_object_name, make_colimit( object_record ) );
        
        if limit.number_of_targets > 0 then
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_injection_name, make_colimit( projection_record ) );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, Concatenation( limit.colimit_injection_name, "WithGiven", limit.colimit_object_name ), make_record_with_given( make_colimit( projection_record ), limit.colimit_object_name, limit.limit_object_name ) );
        fi;
        
        if limit.number_of_nontargets = 1 then
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_morphism_from_source_name, make_colimit( morphism_to_sink_record ) );
            CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, Concatenation( limit.colimit_morphism_from_source_name, "WithGiven", limit.colimit_object_name ), make_record_with_given( make_colimit( morphism_to_sink_record ), limit.colimit_object_name, limit.limit_object_name ) );
        fi;
        
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, limit.colimit_universal_morphism_name, make_colimit( universal_morphism_record ) );
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, Concatenation( limit.colimit_universal_morphism_name, "WithGiven", limit.colimit_object_name ), make_record_with_given( make_colimit( universal_morphism_record ), limit.colimit_object_name, limit.limit_object_name ) );
        
        CAP_INTERNAL_IS_EQUAL_FOR_METHOD_RECORD_ENTRIES( method_name_record, functorial_record.dual_operation, make_colimit( functorial_record, false ) );
    od;
    
end );

CAP_INTERNAL_VALIDATE_LIMITS_IN_NAME_RECORD( CAP_INTERNAL_METHOD_NAME_RECORD, CAP_INTERNAL_METHOD_NAME_RECORD_LIMITS );


InstallValue( CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS, rec() );

InstallGlobalFunction( CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD,
  function( replacement_data )
    local current_name;

    for current_name in RecNames( replacement_data ) do
        if IsBound( CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS.(current_name) ) then
            Error( Concatenation( current_name, " already has a replacement" ) );
        fi;
        CAP_INTERNAL_METHOD_RECORD_REPLACEMENTS.(current_name) := replacement_data.(current_name);
    od;
    
end );

BindGlobal( "CAP_INTERNAL_PREPARE_INHERITED_PRE_FUNCTION",
  function( func )
    
    return function( arg_list... )
        return CallFuncList( func, arg_list{[ 1 .. Length( arg_list ) - 1]} );
    end;
end );

BindGlobal( "CAP_INTERNAL_CREATE_REDIRECTION",
  
  function( with_given_name, object_function_name, object_arguments_positions )
    local return_func, has_name, has_function, object_function, with_given_name_function, is_attribute, attribute_tester;
    
    object_function := ValueGlobal( object_function_name );
    
    with_given_name_function := ValueGlobal( with_given_name );
    
    is_attribute := IsOperation( object_function ) and Tester( object_function ) <> false;
    
    if not is_attribute then
        
        return function( arg )
          local category, object_args, cache, cache_value;
            
            category := arg[ 1 ];
            
            object_args := arg{ object_arguments_positions };
            
            cache := GET_METHOD_CACHE( category, object_function_name, Length( object_arguments_positions ) );
            
            cache_value := CallFuncList( CacheValue, [ cache, object_args ] );
            
            if cache_value = [ ] then
                
                return [ false ];
                
            fi;
            
            return [ true, CallFuncList( with_given_name_function, Concatenation( arg, [ cache_value[ 1 ] ] ) ) ];
            
        end;
        
    else
        
        if not Length( object_arguments_positions ) in [ 1, 2 ] then
            
            Error( "we can only handle attributes of the category or of a single object/morphism/twocell" );
            
        fi;
        
        attribute_tester := Tester( object_function );
        
        return function( arg )
            local object_args, cache_value, category, cache;
            
            category := arg[ 1 ];
            
            object_args := arg{ object_arguments_positions };

            if attribute_tester( object_args[ Length( object_args ) ] ) then
                
                cache_value := [ object_function( object_args[ Length( object_args ) ] ) ];
                
            else
                
                cache := GET_METHOD_CACHE( category, object_function_name, Length( object_arguments_positions ) );
                
                cache_value := CallFuncList( CacheValue, [ cache, object_args ] );
                
                if cache_value = [ ] then
                    
                    return [ false ];
                    
                fi;
                
            fi;
            
            return [ true, CallFuncList( with_given_name_function, Concatenation( arg, [ cache_value[ 1 ] ] ) ) ];
            
        end;
        
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_POST_FUNCTION",
  
  function( source_range_object, object_function_name, object_arguments_positions )
    local object_getter, object_function, setter_function, is_attribute, cache_key_length;
    
    if source_range_object = "Source" then
        object_getter := Source;
    elif source_range_object = "Range" then
        object_getter := Range;
    else
        Error( "the first argument of CAP_INTERNAL_CREATE_POST_FUNCTION must be 'Source' or 'Range'" );
    fi;
    
    object_function := ValueGlobal( object_function_name );
    
    is_attribute := IsOperation( object_function ) and Setter( object_function ) <> false;
    cache_key_length := Length( object_arguments_positions );
    
    if not is_attribute then
    
        return function( arg )
            local result, object, category;
            
            category := arg[ 1 ];
            
            result := arg[ Length( arg ) ];
            Remove( arg );
            object := object_getter( result );
            
            SET_VALUE_OF_CATEGORY_CACHE( category, object_function_name, cache_key_length, arg{ object_arguments_positions }, object );
            
        end;
        
    else
        
        if not Length( object_arguments_positions ) in [ 1, 2 ] then
            
            Error( "we can only handle attributes of the category or of a single object/morphism/twocell" );
            
        fi;
        
        setter_function := Setter( object_function );
        
        return function( arg )
          local category, object_args, result, object;
            
            category := arg[ 1 ];

            object_args := arg{ object_arguments_positions };
            
            result := arg[ Length( arg ) ];
            Remove( arg );
            object := object_getter( result );
            
            SET_VALUE_OF_CATEGORY_CACHE( category, object_function_name, cache_key_length, arg{ object_arguments_positions }, object );
            setter_function( object_args[ Length( object_args ) ], object );
            
        end;
        
    fi;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_NEW_FUNC_WITH_ONE_MORE_ARGUMENT_WITH_RETURN",
  
  function( func )
    
    return function( arg ) return CallFuncList( func, arg{[ 2 .. Length( arg ) ]} ); end;
    
end );

BindGlobal( "CAP_INTERNAL_CREATE_NEW_FUNC_WITH_ONE_MORE_ARGUMENT_WITHOUT_RETURN",
  
  function( func )
    
    return function( arg ) CallFuncList( func, arg{[ 2 .. Length( arg ) ]} ); end;
    
end );

InstallGlobalFunction( CAP_INTERNAL_ENHANCE_NAME_RECORD,
  function( record )
    local recnames, current_recname, current_rec, io_type, number_of_arguments, flattened_filter_list, position, without_given_name, object_name, functorial,
          installation_name, with_given_name, with_given_name_length, i, object_filter_list,
          output_list, input_list, argument_names, return_list, current_output, input_position, list_position;
    
    recnames := RecNames( record );
    
    for current_recname in recnames do
        
        current_rec := record.(current_recname);
        
        # validity checks
        if not IsBound( current_rec.return_type ) then
            Error( "<current_rec> has no return_type" );
        fi;
        
        if not ( IsFilter( current_rec.return_type ) or current_rec.return_type in CAP_INTERNAL_VALID_RETURN_TYPES ) then
            Error( "the return_type of <current_rec> is not a filter and does not appear in CAP_INTERNAL_VALID_RETURN_TYPES" );
        fi;
        
        if IsBound( current_rec.argument_list ) then
            
            Display( Concatenation( 
                "WARNING: the functionality previously provided by `argument_list` was removed. You will probably run into errors. ",
                "Please use the category as the first argument instead of method selections objects/morphisms and adjust pre, post and redirect functions as well as derivations appropriately. ",
                "Search for `category_as_first_argument` in the documentation for more details."
            ) );
            
        fi;
        
        if IsBound( current_rec.io_type ) then
            
            io_type := current_rec.io_type;
            
            if not IsList( io_type ) or not Length( io_type ) = 2 then
                Error( "the io_type of <current_rec> is not a list of length 2" );
            fi;
            
            if not ForAll( io_type[1], x -> IsString( x ) ) then
                Error( "the input type of <current_rec> contains non-strings" );
            fi;
            
            if (current_rec.filter_list[1] = "category" and Length( io_type[1] ) <> Length( current_rec.filter_list ) - 1) or
               (current_rec.filter_list[1] <> "category" and Length( io_type[1] ) <> Length( current_rec.filter_list )) then
                
                Error( "the input type of <current_rec> has the wrong length" );
                
            fi;
            
        fi;
        
        current_rec.function_name := current_recname;
        
        number_of_arguments := Length( current_rec.filter_list );
        
        if IsBound( current_rec.pre_function ) and NumberArgumentsFunction( current_rec.pre_function ) >= 0 and NumberArgumentsFunction( current_rec.pre_function ) <> number_of_arguments then
            Error( "the pre function of <current_rec> has the wrong number of arguments" );
        fi;
        
        if IsBound( current_rec.pre_function_full ) and NumberArgumentsFunction( current_rec.pre_function_full ) >= 0 and NumberArgumentsFunction( current_rec.pre_function_full ) <> number_of_arguments then
            Error( "the full pre function of <current_rec> has the wrong number of arguments" );
        fi;
        
        if IsBound( current_rec.redirect_function ) and NumberArgumentsFunction( current_rec.redirect_function ) >= 0 and NumberArgumentsFunction( current_rec.redirect_function ) <> number_of_arguments then
            Error( "the redirect function of <current_rec> has the wrong number of arguments" );
        fi;
        
        if IsBound( current_rec.post_function ) and NumberArgumentsFunction( current_rec.post_function ) >= 0 and NumberArgumentsFunction( current_rec.post_function ) <> number_of_arguments + 1 then
            Error( "the post function of <current_rec> has the wrong number of arguments" );
        fi;
        
        if IsBound( current_rec.dual_preprocessor_func ) and NumberArgumentsFunction( current_rec.dual_preprocessor_func ) >= 0 and NumberArgumentsFunction( current_rec.dual_preprocessor_func ) <> number_of_arguments then
            Error( "the dual preprocessor function of <current_rec> has the wrong number of arguments" );
        fi;
        
        if not ForAll( current_rec.filter_list, x -> IsFilter( x ) or IsString( x ) or (IsList( x ) and Length( x ) = 2 and IsString( x[1] ) and IsFilter( x[2] )) ) then
            Error( "the filter list of <current_rec> does not fulfill the requirements" );
        fi;
        
        if IsBound( current_rec.install_convenience_without_category ) then
            
            if current_rec.install_convenience_without_category = true and current_rec.filter_list[1] <> "category" then
                
                Error( "install_convenience_without_category = true assumes that the first entry of the filter list is the category" );
                
            fi;
            
        else
            
            # we cannot use `Flat` for lists of strings :-(
            flattened_filter_list := Concatenation( List( current_rec.filter_list,
              function( x )
                
                if IsString( x ) or IsFilter( x ) then
                    
                    return [ x ];
                    
                elif IsList( x ) then
                    
                    return x;
                    
                else
                    
                    Error( "entries of filter_list must be strings, filters or lists" );
                    
                fi;
                
            end ) );
            
            if current_rec.filter_list[1] = "category" and not IsEmpty( Intersection( [ "object", "morphism", "twocell", "list_of_objects", "list_of_morphisms" ], Filtered( flattened_filter_list, IsString ) ) ) then
                
                current_rec.install_convenience_without_category := true;
                
            else
                
                current_rec.install_convenience_without_category := false;
                
            fi;
            
        fi;
        
        if IsBound( current_rec.universal_object_position ) then
            
            Display( "WARNING: universal_object_position was renamed to with_given_object_position" );
            
            current_rec.with_given_object_position := current_rec.universal_object_position;
            
        fi;
        
        if IsBound( current_rec.with_given_object_position ) and not current_rec.with_given_object_position in [ "Source", "Range" ] then
            
            Error( "with_given_object_position must be \"Source\" or \"Range\", not ", current_rec.with_given_object_position );
            
        fi;
        
        position := PositionSublist( current_recname, "WithGiven" );
        
        current_rec.is_with_given := false;
        current_rec.with_given_without_given_name_pair := fail;
        
        if position <> fail then
            
            without_given_name := current_recname{[ 1 .. position - 1 ]};
            object_name := current_recname{[ position + 9 .. Length( current_recname ) ]};
            
            if without_given_name in recnames then
                
                if not object_name in recnames then
                    
                    Error( "detected with(out) given pair ", without_given_name , "(WithGiven", object_name,
                           ") but the object is not given by a CAP operation" );
                    
                fi;
                
                if not IsBound( record.( without_given_name ).with_given_object_position ) then
                    
                    Error( "detected with(out) given pair ", without_given_name , "(WithGiven", object_name,
                           ") but with_given_object_position of the without given method is not set" );
                    
                fi;
                
                current_rec.is_with_given := true;
                
                current_rec.with_given_without_given_name_pair := [ without_given_name, current_recname ];
                
                current_rec.with_given_object_name := object_name;
                
                if IsBound( record.(without_given_name).pre_function ) and not IsBound( current_rec.pre_function ) then
                    current_rec.pre_function := CAP_INTERNAL_PREPARE_INHERITED_PRE_FUNCTION( record.(without_given_name).pre_function );
                fi;
                if IsBound( record.(without_given_name).pre_function_full ) and not IsBound( current_rec.pre_function_full ) then
                    current_rec.pre_function_full := CAP_INTERNAL_PREPARE_INHERITED_PRE_FUNCTION( record.(without_given_name).pre_function_full );
                fi;
                
            fi;
            
        fi;
        
        if not IsBound( current_rec.functorial ) then
            
            functorial := PositionProperty( recnames, i -> StartsWith( i, Concatenation( current_recname, "Functorial" ) ) );
            
            if functorial <> fail then
                
                current_rec.functorial := recnames[ functorial ];
                
            fi;
            
        fi;
          
        if not IsBound( current_rec.dual_arguments_reversed ) then
            
            current_rec.dual_arguments_reversed := false;
            
        fi;
        
        if IsOperation( ValueGlobal( current_recname ) ) then
            
            installation_name := current_recname;
            
        elif IsFunction( ValueGlobal( current_recname ) ) then
            
            installation_name := Concatenation( current_recname, "Op" );
            
        else
            
            Error( "`ValueGlobal( current_recname )` is neither an operation nor a function" );
            
        fi;
        
        if IsBound( current_rec.installation_name ) then
            
            if current_rec.installation_name <> installation_name then
                
                Display( Concatenation(
                    "WARNING: Manually setting installation_name is not supported anymore. You will probably run into errors. ",
                    "To avoid this warning, remove installation_name from the method record ",
                    "and make sure your code supports the automatically chosen installation name \"", installation_name, "\"."
                ) );
                
            fi;
            
        else
            
            current_rec.installation_name := installation_name;
            
        fi;
        
        if IsBound( current_rec.cache_name ) and current_rec.cache_name <> current_rec.function_name then
            
            Display( Concatenation(
                "WARNING: Manually setting cache_name is not supported anymore. The function name will be used instead. ",
                "To avoid this warning, remove cache_name from the method record."
            ) );
            
        fi;
        
        if IsBound( current_rec.zero_arguments_for_add_method ) then
            
            Display( "zero_arguments_for_add_method has no effect anymore, please remove it." );
            
        fi;
        
        if IsBound( current_rec.number_of_diagram_arguments ) then
            
            Display( "number_of_diagram_arguments has no effect anymore, please remove it." );
            
        fi;
        
        if not IsBound( current_rec.input_arguments_names ) then
            
            if IsBound( current_rec.io_type ) then
                
                if current_rec.filter_list[1] = "category" then
                    
                    current_rec.input_arguments_names := Concatenation( [ "cat" ], current_rec.io_type[1] );
                    
                else
                    
                    current_rec.input_arguments_names := current_rec.io_type[1];
                    
                fi;
                
            else
                
                current_rec.input_arguments_names := List( [ 1 .. Length( current_rec.filter_list ) ], i -> Concatenation( "arg", String( i ) ) );
                
                if current_rec.filter_list[1] = "category" then
                    
                    current_rec.input_arguments_names[1] := "cat";
                    
                fi;
                
            fi;
            
        fi;
        
        if current_rec.filter_list[1] = "category" and current_rec.input_arguments_names[1] <> "cat" then
            
            Error( "the category argument must always be called \"cat\", please adjust the method record entry of ", current_recname );
            
        fi;
        
        if not ForAll( current_rec.input_arguments_names, x -> IsString( x ) ) then
            
            Error( "the entries of input_arguments_names must be strings, please adjust the method record entry of ", current_recname );
            
        fi;
        
        if not current_rec.is_with_given and IsBound( current_rec.with_given_object_position ) then
            
            ## find with given name
            
            without_given_name := current_recname;
            
            with_given_name := Concatenation( without_given_name, "WithGiven" );
            
            with_given_name_length := Length( with_given_name );
            
            for i in recnames do
                
                if PositionSublist( i, with_given_name ) <> fail then
                    
                    with_given_name := i;
                    
                    break;
                    
                fi;
                
            od;
            
            if Length( with_given_name ) = with_given_name_length then
                
                Error( Concatenation( "Name not found: ", with_given_name ) );
                
            fi;
            
            current_rec.with_given_without_given_name_pair := [ without_given_name, with_given_name ];
            
            if not record.( with_given_name ).filter_list = Concatenation( current_rec.filter_list, [ "object" ] ) then
                
                Error( "the filter list of the with given method must be the same as the filter list of the without given method with an additional object" );
                
            fi;
            
            object_name := with_given_name{[ with_given_name_length + 1 .. Length( with_given_name ) ]};
            
            if not object_name in recnames then
                
                Error( "detected with(out) given pair ", without_given_name , "(WithGiven", object_name,
                       ") but the object is not given by a CAP operation" );
                
            fi;
            
            object_filter_list := record.( object_name ).filter_list;
            
            if not StartsWith( current_rec.filter_list, object_filter_list ) then
                
                Error( "the object arguments must be the first arguments of the without given method, but the corresponding filters do not match" );
                
            fi;
            
            current_rec.object_arguments_positions := [ 1 .. Length( object_filter_list ) ];
            
            if not IsBound( current_rec.redirect_function ) then
                
                if record.( without_given_name ).filter_list[1] <> "category" or record.( object_name ).filter_list[1] <> "category" or record.( with_given_name ).filter_list[1] <> "category" then
                    
                    Display( Concatenation(
                        "WARNING: You seem to be relying on automatically installed redirect functions but the first arguments of the functions involved are not the category. ",
                        "No automatic redirect function will be installed. ",
                        "To prevent this warning, add the category as the first argument to all functions involved. ",
                        "Search for `category_as_first_argument` in the documentation for more details."
                    ) );
                    
                elif Length( record.( without_given_name ).filter_list ) + 1 <> Length( record.( with_given_name ).filter_list ) then
                    
                    Display( Concatenation(
                        "WARNING: You seem to be relying on automatically installed redirect functions. ",
                        "For this, the with given method must have exactly one additional argument compared to the without given method. ",
                        "This is not the case, so no automatic redirect function will be installed. ",
                        "Install a custom redirect function to prevent this warning."
                    ) );
                    
                else
                    
                    current_rec.redirect_function := CAP_INTERNAL_CREATE_REDIRECTION( with_given_name, object_name, current_rec.object_arguments_positions );
                    
                fi;
                
            fi;
            
            if not IsBound( current_rec.post_function ) then
                
                if current_rec.filter_list[1] <> "category" or record.( object_name ).filter_list[1] <> "category" then
                    
                    Display( Concatenation(
                        "WARNING: You seem to be relying on automatically installed post functions but the first arguments of the functions involved are not the category. ",
                        "No automatic post function will be installed. ",
                        "To prevent this warning, add the category as the first argument to all functions involved. ",
                        "Search for `category_as_first_argument` in the documentation for more details."
                    ) );
                    
                else
                    
                    current_rec.post_function := CAP_INTERNAL_CREATE_POST_FUNCTION( current_rec.with_given_object_position, object_name, current_rec.object_arguments_positions );
                    
                fi;
                
            fi;
            
        fi;
        
        if IsBound( current_rec.io_type ) and current_rec.return_type = "morphism" and not IsString( current_rec.io_type[ 2 ] ) and IsList( current_rec.io_type[ 2 ] ) then
            
            output_list := current_rec.io_type[ 2 ];
            
            if not Length( output_list ) = 2 then
                
                Error( "the output type is not a list of length 2" );
                
            fi;
            
            output_list := List( output_list, i -> SplitString( i, "_" ) );
            
            input_list := current_rec.io_type[ 1 ];
            
            argument_names := input_list;
            
            return_list := [ ];
            
            for i in [ 1 .. Length( output_list ) ] do
                
                current_output := output_list[ i ];
                
                input_position := Position( input_list, current_output[ 1 ] );
                
                if input_position = fail then
                    
                    return_list[ i ] := fail;
                    
                    continue;
                    
                fi;
                
                if Length( current_output ) = 1 then
                    
                   return_list[ i ] := argument_names[ input_position ];
                   
                elif Length( current_output ) = 2 then
                    
                    if LowercaseString( current_output[ 2 ] ) = "source" then
                        return_list[ i ] := Concatenation( "Source( ", argument_names[ input_position ], " )" );
                    elif LowercaseString( current_output[ 2 ] ) = "range" then
                        return_list[ i ] := Concatenation( "Range( ", argument_names[ input_position ], " )" );
                    elif Position( input_list, current_output[ 2 ] ) <> fail then
                        return_list[ i ] := Concatenation( argument_names[ input_position ], "[", argument_names[ Position( input_list, current_output[ 2 ] ) ], "]" );
                    else
                        Error( "wrong input type" );
                    fi;
                    
                elif Length( current_output ) = 3 then
                    
                    if ForAll( current_output[ 2 ], i -> i in "0123456789" ) then
                        list_position := String( Int( current_output[ 2 ] ) );
                    else
                        list_position := Position( input_list, current_output[ 2 ] );
                        if list_position = fail then
                            Error( "unable to find ", current_output[ 2 ], " in input_list" );
                        fi;
                        list_position := argument_names[ list_position ];
                    fi;
                    
                    if list_position = fail then
                        Error( "list index variable not found" );
                    fi;
                    
                    if LowercaseString( current_output[ 3 ] ) = "source" then
                        return_list[ i ] := Concatenation( "Source( ", argument_names[ input_position ], "[", list_position, "] )" );
                    elif LowercaseString( current_output[ 3 ] ) = "range" then
                        return_list[ i ] := Concatenation( "Range( ", argument_names[ input_position ], "[", list_position, "] )" );
                    else
                        Error( "wrong output syntax" );
                    fi;
                    
                else
                    
                    Error( "wrong entry length" );
                    
                fi;
                
            od;
            
            if IsBound( return_list[1] ) and return_list[1] <> fail then
                
                current_rec.output_source_getter_string := return_list[1];
                
            fi;
            
            if IsBound( return_list[2] ) and return_list[2] <> fail then
                
                current_rec.output_range_getter_string := return_list[2];
                
            fi;
            
        fi;
        
    od;
    
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( CAP_INTERNAL_METHOD_NAME_RECORD );

##
InstallGlobalFunction( CAP_INTERNAL_REVERSE_LISTS_IN_ARGUMENTS_FOR_OPPOSITE,
  function( arg )
    local list;
      
    list := CAP_INTERNAL_OPPOSITE_RECURSIVE( arg );
      
    return List( list, function( l )
        if IsList( l ) then
            return Reversed( l );
        else
            return l;
        fi;
    end );

end );
