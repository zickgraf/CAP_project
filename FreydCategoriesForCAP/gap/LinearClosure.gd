# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Declarations
#
#! @Chapter Linear closure of a category

####################################
##
#! @Section GAP Categories
##
####################################

##
DeclareCategory( "IsLinearClosureObject",
                 IsCapCategoryObject );

DeclareCategory( "IsLinearClosureMorphism",
                 IsCapCategoryMorphism );

DeclareCategory( "IsLinearClosure",
                 IsCapCategory );

DeclareGlobalFunction( "LINEAR_CLOSURE_CONSTRUCTOR" );

DeclareGlobalFunction( "LINEAR_CLOSURE_MORPHISM_SIMPLIFY" );

DeclareGlobalFunction( "INSTALL_FUNCTIONS_FOR_LINEAR_CLOSURE" );

####################################
##
#! @Section Constructors
##
####################################

DeclareOperation( "TwistedLinearClosure",
                  [ IsHomalgRing, IsCapCategory, IsFunction, IsFunction ] );

DeclareOperation( "TwistedLinearClosure",
                  [ IsHomalgRing, IsCapCategory, IsFunction ] );

DeclareOperation( "LinearClosure",
                  [ IsHomalgRing, IsCapCategory ] );

DeclareOperation( "LinearClosure",
                  [ IsHomalgRing, IsCapCategory, IsFunction ] );

DeclareOperation( "LinearClosureObject",
                  [ IsCapCategory, IsLinearClosure ] );

DeclareOperation( "LinearClosureObject",
                  [ IsLinearClosure, IsCapCategoryObject ] );

CapJitAddTypeSignature( "LinearClosureObject", [ IsLinearClosure, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

DeclareOperation( "LinearClosureMorphism",
                  [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ] );

DeclareOperation( "LinearClosureMorphismNC",
                  [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ] );

CapJitAddTypeSignature( "LinearClosureMorphismNC", [ IsLinearClosure, IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ], function ( input_types )
    
    return CapJitDataTypeOfMorphismOfCategory( input_types[1].category );
    
end );

####################################
##
#! @Section Attributes
##
####################################


DeclareAttribute( "UnderlyingCategory",
                   IsLinearClosure );

CapJitAddTypeSignature( "UnderlyingCategory", [ IsLinearClosure ], function ( input_types )
    
    return CapJitDataTypeOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareAttribute( "UnderlyingRing",
                   IsLinearClosure );

DeclareAttribute( "UnderlyingOriginalObject",
                   IsLinearClosureObject );

CapJitAddTypeSignature( "UnderlyingOriginalObject", [ IsLinearClosureObject ], function ( input_types )
    
    Assert( 0, IsLinearClosure( input_types[1].category ) );
    
    return CapJitDataTypeOfObjectOfCategory( UnderlyingCategory( input_types[1].category ) );
    
end );

DeclareAttribute( "CoefficientsList",
                  IsLinearClosureMorphism );

CapJitAddTypeSignature( "CoefficientsList", [ IsLinearClosureMorphism ], function ( input_types )
  local category, ring, ring_element_filter;
    
    category := input_types[1].category;
    
    Assert( 0, IsLinearClosure( category ) );
    
    ring := UnderlyingRing( category );
    
    if IsHomalgRing( ring ) then
        
        if IsHomalgInternalRingRep( ring ) then
            
            if IsIntegersForHomalg( ring ) then
                
                ring_element_filter := IsInt;
                
            elif IsRationalsForHomalg( ring ) then
                
                ring_element_filter := IsRat;
                
            else
                
                Error( "this case is not yet handled" );
                
            fi;
            
        elif IsHomalgExternalRingRep( ring ) then
            
            ring_element_filter := IsHomalgRingElement;
            
        else
            
            Error( "this case is not yet handled" );
            
        fi;
        
    else
        
        ring_element_filter := IsRingElement;
        
    fi;
    
    return CapJitDataTypeOfListOf( ring_element_filter );
    
end );

DeclareAttribute( "SupportMorphisms",
                  IsLinearClosureMorphism );

CapJitAddTypeSignature( "SupportMorphisms", [ IsLinearClosureMorphism ], function ( input_types )
    
    Assert( 0, IsLinearClosure( input_types[1].category ) );
    
    return CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( input_types[1].category ) ) );
    
end );

####################################
##
#! @Section Functors
##
####################################

#! @Description
#!  The arguments are a functor <A>F</A>$:C\to D$, some linear closure <A>linear_closure</A> of $C$ over some
#!  commutative ring $S$ and a function <A>ring_map</A>; where $D$ is a linear category over some commutative ring $R$.
#!  The <A>ring_map</A> is a function that converts an element $s$ in $S$ to an element in $R$,
#!  such that <A>ring_map</A> defines a ring homomorphism.
#!  The output is the linear extension functor of <A>F</A> from <A>linear_closure</A> to $D$.
#! @Arguments F, linear_closure, ring_map
#! @Returns
DeclareOperation( "ExtendFunctorToLinearClosureOfSource",
      [ IsCapFunctor, IsLinearClosure, IsFunction ] );

#! @Description
#!  The arguments are a functor <A>F</A>$:C\to D$, some linear closure <A>linear_closure</A> of $C$ over some
#!  commutative ring $S$; where $D$ is a linear category over $S$.
#!  The output is the linear extension functor of <A>F</A> from <A>linear_closure</A> to $D$.
#! @Arguments F, linear_closure
#! @Returns
DeclareOperation( "ExtendFunctorToLinearClosureOfSource",
      [ IsCapFunctor, IsLinearClosure ] );

####################################
##
#! @Section Operations
##
####################################

DeclareOperation( "\*",
                  [ IsLinearClosureMorphism, IsLinearClosureMorphism ] );

DeclareOperation( "\/",
                  [ IsCapCategoryMorphism, IsLinearClosure ] );
