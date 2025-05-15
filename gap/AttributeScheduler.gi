#############################################################################
##
##                                                    AttributeSchedulerGraph
##
##  Copyright 2025,                            Markus Baumeister, RWTH Aachen
##                                       Sebastian Gutsche, Siegen University
##
#############################################################################

DeclareRepresentation( "IsAttributeSchedulerGraphRep",
        IsAttributeSchedulerGraph and IsAttributeStoringRep,
        [ ] );

BindGlobal( "TheFamilyOfAttributeSchedulerGraphs",
        NewFamily( "TheFamilyOfAttributeSchedulerGraphs" ) );

BindGlobal( "TheTypeAttributeSchedulerGraph",
        NewType( TheFamilyOfAttributeSchedulerGraphs,
                IsAttributeSchedulerGraphRep ) );

##
InstallOtherMethod( AttributeSchedulerGraph,
               [ ],
               
  function( )
    return AttributeSchedulerGraph( [ ] );
end );

##
InstallMethod( AttributeSchedulerGraph,
               [ IsList ],
               
  function( methods )
    local graph, i;
    
    graph := rec( );
    
    for i in methods do
	#if IsBound(i) and IsAttribute(i) then
        	graph.(i) := [ ];
	#else
	#	Error(Concatenation("The entries in the list ", String(methods), " must be attributes"));
	#fi;
    od;
    
    Objectify( TheTypeAttributeSchedulerGraph, graph );
    
    return graph;
    
end );

InstallOtherMethod( AddPropertyIncidence,
               [ IsAttributeSchedulerGraph, IsString, IsList ],
               
  function( graph, property_to_compute, property_depends_on )

    AddPropertyIncidence( graph, property_to_compute, property_depends_on, [] );
    
end );

InstallMethod( AddPropertyIncidence,
               [ IsAttributeSchedulerGraph, IsString, IsList, IsList ],
               
  function( graph, property_to_compute, property_depends_on, requirements )
    local name;
    
    # Check whether the elements of property_depends_on are already part
    # of the graph
    for name in property_depends_on do
        if not IsBound( graph!.(name) ) then
            graph!.(name) := [];
        fi;
    od;
    
    # Check whether property_to_compute is already part of the graph
    if not IsBound( graph!.(property_to_compute) ) then
        graph!.(property_to_compute) := [];
    fi;
    
    Add( graph!.(property_to_compute), rec( dependencies := property_depends_on, requirements := requirements ) );
    
end );

InstallOtherMethod( AddPropertyIncidence,
                    [ IsAttributeSchedulerGraph, IsString, IsString ],
                    
  function( graph, property_to_compute, property_depends_on )
    AddPropertyIncidence( graph, property_to_compute, [ property_depends_on ] );
end );

InstallMethod( AddPropertyIncidence,
                    [ IsAttributeSchedulerGraph, IsString, IsString, IsList ],
                    
  function( graph, property_to_compute, property_depends_on, requirements )
    AddPropertyIncidence( graph, property_to_compute, [ property_depends_on ], requirements );
end );

InstallGlobalFunction( __ATTRIBUTESCHEDULER_evaluate_recursive,
                       function( graph, name_property, object, spanning_tree )
    local i, props;
    
    if spanning_tree.( name_property ) = 0 then
        return VALUE_GLOBAL( name_property )( object );
    fi;
    
    props := graph!.( name_property )[ spanning_tree.( name_property ) ].dependencies;
    
    for i in props do
        __ATTRIBUTESCHEDULER_evaluate_recursive( graph, i, object, spanning_tree );
    od;
    
    return VALUE_GLOBAL( name_property )( object );
    
end );

InstallMethod( ComputeProperty,
               [ IsAttributeSchedulerGraph, IsFunction, IsObject ],
  function( graph, property, object )
    local all_names, how_to_compute, i, property_name, possibilities, max, j,
        computable, valid, val, k;
    
    all_names := NamesOfComponents( graph );
    
    how_to_compute := rec();
    
    for i in all_names do
        how_to_compute.( i ) := -1;
    od;
    
    for i in [ 1 .. Length( all_names ) ] do
        if Tester( VALUE_GLOBAL( all_names[ i ] ) )( object ) then
            how_to_compute.( all_names[ i ] ) := 0;
        fi;
    od;
    
    property_name := NameFunction( property );
    
    if how_to_compute.( property_name ) > -1 then
        return property( object );
    fi;
    
    for max in [ 1 .. Length( all_names ) ] do
        
        for i in [ 1 .. Length( all_names ) ] do
            
            if how_to_compute.( all_names[ i ] ) > -1 then
                continue;
            fi;
            
            possibilities := graph!.( all_names[ i ] );
            
            for j in [ 1 .. Length( possibilities ) ] do
                
                # Check whether the attribute is computable in principle

                computable := true;

                for k in possibilities[ j ].dependencies do
                
                    if how_to_compute.( k ) = -1 then
                
                        computable := false;
                        break;

                    fi;
                
                od;

                if not computable then
                
                    continue;

                fi;

                # Check whether the requirements of these possibilities are met

                valid := true;

                for k in possibilities[ j ].requirements do

                    val := VALUE_GLOBAL( k );

                    if Tester( val )( object ) then # requirement can be tested directly
                        
                        if not ( IsBool( val( object ) ) and val( object ) ) then
                        
                            valid := false;
                            break;
                    
                        fi;

                    else # requirement may be computed with the scheduler

                        if IsBound( how_to_compute.( k ) ) and how_to_compute.( k ) > 0 then
                        
                            __ATTRIBUTESCHEDULER_evaluate_recursive( graph, k, object, how_to_compute );
                            
                            if not ( IsBool( val( object ) ) and val( object ) ) then
                            
                                valid := false;
                                break;

                            fi;
                        
                        else
                            
                            valid := false;
                            break;

                        fi;
                        
                    fi;

                od;

                if valid then
                    
                    how_to_compute.( all_names[ i ] ) := j;
                    break;
                
                fi;
                
            od;
            
        od;
        
        if how_to_compute.( property_name ) > -1 then
            break;
        fi;
        
    od;
    
    if how_to_compute.( property_name ) = -1 then
        
        Error( "cannot compute property" );
        
    fi;
    
    return __ATTRIBUTESCHEDULER_evaluate_recursive( graph, property_name, object, how_to_compute );
    
end );

InstallMethod( AddAttribute, 
    [ IsAttributeSchedulerGraph, IsObject, IsObject, IsString ],

    function( graph, attr, filter, descr )

        InstallMethod( attr, descr, [ filter ],

            function( obj )

                return ComputeProperty( graph, attr, obj );

            end );

    end
);

##
InstallMethod( ViewObj,
               [ IsAttributeSchedulerGraph ],
               
  function( graph )
    
    Print( "<Attribute scheduler graph>" );
    
end );

##
InstallMethod( Display,
               [ IsAttributeSchedulerGraph ],
               
  function( graph )
    
    Print( "Attribute scheduler graph" );
    
end );

