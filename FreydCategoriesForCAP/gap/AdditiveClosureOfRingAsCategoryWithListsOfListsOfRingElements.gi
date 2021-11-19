# SPDX-License-Identifier: GPL-2.0-or-later
# FreydCategoriesForCAP: Freyd categories - Formal (co)kernels for additive categories
#
# Implementations
#

####################################
##
## Constructors
##
####################################

DeclareFilter( "MySpecialObjectFilter", IsCapCategoryObject );
DeclareFilter( "MySpecialMorphismFilter", IsCapCategoryMorphism );

MyObjectConstructor := function ( cat, rank )
    #% CAP_JIT_RESOLVE_FUNCTION
    
    return ObjectifyObjectForCAPWithAttributes( rec( ), cat, RankOfObject, rank );
    
end;

MyMorphismConstructor := function ( cat, source, morphism_matrix, range )
    #% CAP_JIT_RESOLVE_FUNCTION
    
    return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat, source, range, MorphismMatrix, morphism_matrix );
    
end;

InstallOtherMethod( UnderlyingMatrix,
    [ MySpecialMorphismFilter ],
    
  function( morphism )
    local nr_rows, nr_cols;
    
    nr_rows := RankOfObject( Source( morphism ) );
    nr_cols := RankOfObject( Range( morphism ) );
    
    return HomalgMatrix( MorphismMatrix( morphism ), nr_rows, nr_cols, UnderlyingRing( CapCategory( morphism ) ) );
    
end );

##
BindGlobal( "AdditiveClosureOfHomalgRingAsCategoryWithListsOfListsOfRingElements",
  function( homalg_ring )
    local ring_as_category, add, wrapper, name, object_constructor, object_datum, category;
    
    Assert( 0, IsHomalgRing( homalg_ring ) );
    
    ring_as_category := RingAsCategory( homalg_ring : FinalizeCategory := true );
    
    add := AdditiveClosure( ring_as_category : FinalizeCategory := true );
    
    wrapper := WrapperCategory( add, rec(
        name := Concatenation( "AdditiveClosureOfRingAsCategoryWithListsOfListsOfRingElements( ", RingName( homalg_ring )," )" ),
        object_constructor := function ( cat, object_datum )
            
            return ObjectifyObjectForCAPWithAttributes( rec( ), cat, RankOfObject, Length( ObjectList( object_datum ) ) );
            
        end,
        object_datum := function ( cat, object )
          local add, ring_as_category, unique_object;
            
            add := UnderlyingCategory( cat );
            ring_as_category := UnderlyingCategory( add );
            
            unique_object := RingAsCategoryUniqueObject( ring_as_category );
            
            return AdditiveClosureObject( ListWithIdenticalEntries( RankOfObject( object ), unique_object ), add );
            
        end,
        morphism_constructor := function ( cat, source, morphism_datum, range )
          local matrix_entries;
            
            matrix_entries := List( MorphismMatrix( morphism_datum ),
                row -> List( row,
                    c -> UnderlyingRingElement( c )
                )
            );
            
            return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat, source, range, MorphismMatrix, matrix_entries );
            
        end,
        morphism_datum := function ( cat, morphism )
          local add, ring_as_category, unique_object, nr_rows, nr_cols, source, range, matrix_entries, listlist;
            
            add := UnderlyingCategory( cat );
            ring_as_category := UnderlyingCategory( add );
            
            #unique_object := RingAsCategoryUniqueObject( ring_as_category );
            
            #nr_rows := NrRows( UnderlyingMatrix( morphism ) );
            #nr_cols := NrCols( UnderlyingMatrix( morphism ) );
            
            ##% CAP_JIT_DROP_NEXT_STATEMENT
            #Assert( 0, RankOfObject( Source( morphism ) ) = nr_rows );
            ##% CAP_JIT_DROP_NEXT_STATEMENT
            #Assert( 0, RankOfObject( Range( morphism ) ) = nr_cols );
            
            source := ObjectDatum( cat, Source( morphism ) );
            range := ObjectDatum( cat, Range( morphism ) );
            
            matrix_entries := MorphismMatrix( morphism );
            
            ##% CAP_JIT_DROP_NEXT_STATEMENT
            #Assert( 0, Length( matrix_entries ) = nr_rows );
            ##% CAP_JIT_DROP_NEXT_STATEMENT
            #Assert( 0, ForAll( matrix_entries, row -> Length( row ) = nr_cols ) );
            
            listlist := List( matrix_entries,
                row -> List( row,
                    c -> RingAsCategoryMorphism( ring_as_category, c )
                )
            );
            
            #% CAP_JIT_DROP_NEXT_STATEMENT
            Assert( 0, Length( listlist ) = Length( ObjectList( source ) ) );
            #% CAP_JIT_DROP_NEXT_STATEMENT
            Assert( 0, ForAll( listlist, row -> Length( row ) = Length( ObjectList( range ) ) ) );
            
            return AdditiveClosureMorphism( source, listlist, range );
            
        end
    ) : FinalizeCategory := false );
    
    category := wrapper;
    
    #category!.compiler_hints := rec(
    #    category_attribute_names := [
    #        "UnderlyingRing",
    #        "GeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure",
    #        "ColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure",
    #    ],
    #    source_and_range_attributes_from_morphism_attribute := rec(
    #        object_attribute_name := "RankOfObject",
    #        morphism_attribute_name := "UnderlyingMatrix",
    #        source_attribute_getter_name := "NrRows",
    #        range_attribute_getter_name := "NrColumns",
    #    ),
    #);
    
    # this cache replaces the KeyDependentOperation caching when using ObjectConstructor directly instead of CategoryOfRowsObject
    #SetCachingToWeak( category, "ObjectConstructor" );
    
    #SetFilterObj( category, IsCategoryOfRows );
    
    #if HasHasInvariantBasisProperty( homalg_ring ) and HasInvariantBasisProperty( homalg_ring ) then
    #    SetIsSkeletalCategory( category, true );
    #fi;
    
    #SetIsAdditiveCategory( category, true );
    
    #SetIsRigidSymmetricClosedMonoidalCategory( category, true );
    
    #SetIsStrictMonoidalCategory( category, true );
    
    #SetUnderlyingRing( category, homalg_ring );
    
    #SetGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( category, GeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure( ring_as_category ) );
    #SetColumnVectorOfGeneratingSystemOfRingAsModuleInRangeCategoryOfHomomorphismStructure( category, ColumnVectorOfGeneratingSystemAsModuleInRangeCategoryOfHomomorphismStructure( ring_as_category ) );
    
    #if HasIsFieldForHomalg( homalg_ring ) and IsFieldForHomalg( homalg_ring ) then
    #    
    #    AddObjectRepresentation( category, IsCategoryOfRowsObject and HasIsProjective and IsProjective );
    #    
    #    SetIsAbelianCategory( category, true );
    #    
    #else
    #    
    #    AddObjectRepresentation( category, IsCategoryOfRowsObject );
    #    
    #fi;
    
    #AddMorphismRepresentation( category, IsCategoryOfRowsMorphism and HasUnderlyingMatrix );
    
    Assert( 0, HasIsField( homalg_ring ) and IsField( homalg_ring ) );
    
    AddObjectRepresentation( category, MySpecialObjectFilter and HasIsProjective and IsProjective );
    AddMorphismRepresentation( category, MySpecialMorphismFilter );
    
    SetIsAbelianCategory( category, true );
    
    ##
    AddHomomorphismStructureOnObjects( category,
      function( cat, object_1, object_2 )
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat, RankOfObject, RankOfObject( object_1 ) * RankOfObject( object_2 ) );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, source, range )
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat, source, range, MorphismMatrix, NullMat( RankOfObject( source ), RankOfObject( range ) ) );
        
    end );
    
    ##
    AddDirectSum( category,
      function( cat, object_list )
        local rank;
        
        rank := Sum( List( object_list, object -> RankOfObject( object ) ) );
        
        return ObjectifyObjectForCAPWithAttributes( rec( ), cat, RankOfObject, rank );
        
    end );
    
    ##
    AddUniversalMorphismIntoDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, morphisms, direct_sum )
        local nr_rows, nr_cols, list;
        
        nr_rows := RankOfObject( test_object );
        nr_cols := RankOfObject( direct_sum );
        
        list := List( morphisms, tau -> MorphismMatrix( tau ) );
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat, test_object, direct_sum, MorphismMatrix, UnionOfColumnsListListListList( homalg_ring, nr_rows, nr_cols, list ) );
        
    end );
    
    ##
    AddUniversalMorphismFromDirectSumWithGivenDirectSum( category,
      function( cat, diagram, test_object, morphisms, direct_sum )
        local nr_rows, nr_cols, list;
        
        nr_rows := RankOfObject( direct_sum );
        nr_cols := RankOfObject( test_object );
        
        list := List( morphisms, tau -> MorphismMatrix( tau ) );
        
        return ObjectifyMorphismWithSourceAndRangeForCAPWithAttributes( rec( ), cat, direct_sum, test_object, MorphismMatrix, UnionOfRowsListListListList( homalg_ring, nr_rows, nr_cols, list ) );
        
    end );
    
    if HasIsCommutative( homalg_ring ) and IsCommutative( homalg_ring ) then
        
        SetCommutativeRingOfLinearCategory( category, homalg_ring );
        
        ##
        AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
          function( cat, r, alpha )
            
            return MyMorphismConstructor( cat, Source( alpha ), r * MorphismMatrix( alpha ), Range( alpha ) );
            
        end );
        
    fi;
    
    if HasIsFieldForHomalg( homalg_ring ) and IsFieldForHomalg( homalg_ring ) then
        
        ##
        AddKernelEmbedding( category,
          function( cat, morphism )
            local nr_rows, nr_cols, kernel_emb, kernel_object;
            
            nr_rows := RankOfObject( Source( morphism ) );
            nr_cols := RankOfObject( Range( morphism ) );
            
            kernel_emb := SyzygiesOfRows( HomalgMatrix( MorphismMatrix( morphism ), nr_rows, nr_cols, homalg_ring ) );
            
            kernel_object := MyObjectConstructor( cat, NrRows( kernel_emb ) );
            
            return MyMorphismConstructor( cat, kernel_object, EntriesOfHomalgMatrixAsListList( kernel_emb ), Source( morphism ) );
            
        end );
        
        ##
        AddCokernelProjection( category,
          function( cat, morphism )
            local nr_rows, nr_cols, cokernel_proj, cokernel_obj;
            
            nr_rows := RankOfObject( Source( morphism ) );
            nr_cols := RankOfObject( Range( morphism ) );
            
            cokernel_proj := SyzygiesOfColumns( HomalgMatrix( MorphismMatrix( morphism ), nr_rows, nr_cols, homalg_ring ) );
            
            cokernel_obj := MyObjectConstructor( cat, NrColumns( cokernel_proj ) );
            
            return MyMorphismConstructor( cat, Range( morphism ), EntriesOfHomalgMatrixAsListList( cokernel_proj ), cokernel_obj );
            
        end );
        
        ##
        AddBasisOfExternalHom( category,
          function( cat, S, T )
            local s, t, identity, matrices;
            
            s := RankOfObject( S );
            
            t := RankOfObject( T );
            
            identity := HomalgIdentityMatrix( s * t, UnderlyingRing( cat ) );
            
            matrices := List( [ 1 .. s * t ], i -> ConvertRowToMatrix( CertainRows( identity, [ i ] ), s, t ) );
            
            return List( matrices, mat -> MyMorphismConstructor( cat, S, EntriesOfHomalgMatrixAsListList( mat ), T ) );
            
        end );
      
    fi;
    
    SetUnderlyingRing( category, homalg_ring );
    
    Finalize( category );
    
    return category;
    
end );
