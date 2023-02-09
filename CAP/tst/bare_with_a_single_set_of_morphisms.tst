gap> START_TEST( "bare" );

#
gap> LoadPackage( "CAP", false );
true
gap> LoadPackage( "MatricesForHomalg", false );
true

#
gap> ZZ := HomalgRingOfIntegers( );;
gap> cat := CreateCapCategory( "Mat_ZZ", IsCapCategory, IsInt, IsHomalgMatrix, IsCapCategoryTwoCell );
WARNING: filter <Category "IsInt"> does not imply `IsCapCategoryObject`. This \
will probably cause errors.
WARNING: filter <Category "IsHomalgMatrix"> does not imply `IsCapCategoryMorph\
ism`. This will probably cause errors.
Mat_ZZ
gap> cat!.category_as_first_argument := true;;
gap> AddIsEqualForObjects( cat, { cat, dim1, dim2 } -> dim1 = dim2 );
gap> AddIsWellDefinedForObjects( cat, { cat, dim } -> IsInt( dim ) and dim >= 0 );
gap> AddIsWellDefinedForMorphisms( cat, { cat, matrix } -> IsHomalgMatrix( matrix ) and IsIdenticalObj( HomalgRing( matrix ), ZZ ) and ForAll( [ 1 .. NrRows( matrix ) ], i -> ForAll( [ 1 .. NrCols( matrix ) ], j -> IsInt( matrix[i,j] ) ) ) );
gap> AddIsEqualForMorphismsOnMor( cat, { cat, matrix1, matrix2 } -> NrRows( matrix1 ) = NrRows( matrix2 ) and NrCols( matrix1 ) = NrCols( matrix2 ) and ForAll( [ 1 .. NrRows( matrix1 ) ], i -> ForAll( [ 1 .. NrCols( matrix1 ) ], j -> matrix1[i,j] = matrix2[i,j] ) ) );
gap> InstallOtherMethod( Source, [ IsHomalgMatrix ], matrix -> NrRows( matrix ) );
gap> InstallOtherMethod( Range, [ IsHomalgMatrix ], matrix -> NrCols( matrix ) );
gap> AddIsCongruentForMorphisms( cat, { cat, matrix1, matrix2 } -> IsEqualForMorphisms( cat, matrix1, matrix2 ) );
gap> AddPreCompose( cat, { cat, matrix1, matrix2 } -> matrix1 * matrix2 );
gap> AddIdentityMorphism( cat, { cat, dim } -> HomalgIdentityMatrix( dim, ZZ ) );
gap> Finalize( cat );;
gap> IsWellDefinedForObjects( cat, 2 );
true
gap> id := IdentityMorphism( cat, 2 );;
gap> IsWellDefinedForMorphisms( cat, id );
true
gap> IsCongruentForMorphisms( cat, id, PreCompose( cat, id, id ) );
true

#
gap> STOP_TEST( "bare" );
