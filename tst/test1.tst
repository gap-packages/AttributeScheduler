gap> START_TEST("AtttributeScheduler: test1.tst");
gap> DeclareAttribute( "A", IsAttributeStoringRep );
gap> DeclareAttribute( "B", IsAttributeStoringRep );
gap> DeclareAttribute( "C", IsAttributeStoringRep );
gap> DeclareAttribute( "D", IsAttributeStoringRep );
gap> InstallMethod( A, [ HasB ], i -> B( i )*2 );
gap> InstallMethod( B, [ HasA ], i -> A( i )*3 );
gap> InstallMethod( B, [ HasC ], i -> C( i )*5 );
gap> InstallMethod( C, [ HasB ], i -> C( i )*7 );
gap> InstallMethod( C, [ HasD ], i -> D( i )*11 );
gap> InstallMethod( D, [ HasC ], i -> C( i )*13 );
gap> InstallMethod( A, [ HasD ], i -> D( i )*17 );
gap> InstallMethod( D, [ HasA ], i -> A( i )*19 );
gap> graph := AttributeSchedulerGraph( [ "A", "B", "C", "D" ] );
<Attribute scheduler graph>
gap> AddPropertyIncidence( graph, "A", "B" );
gap> AddPropertyIncidence( graph, "A", "D" );
gap> AddPropertyIncidence( graph, "B", "A" );
gap> AddPropertyIncidence( graph, "B", "C" );
gap> AddPropertyIncidence( graph, "C", "B" );
gap> AddPropertyIncidence( graph, "C", "D" );
gap> AddPropertyIncidence( graph, "D", "C" );
gap> AddPropertyIncidence( graph, "D", "A" );
gap> S := SymmetricGroup( 3 );
Sym( [ 1 .. 3 ] )
gap> SetC( S, 1 );
gap> ComputeProperty( graph, A, S );
10
gap> ComputeProperty( graph, D, S );
190
gap> STOP_TEST("bugfix.tst", 0);
