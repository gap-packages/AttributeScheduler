#############################################################################
##
##                                                    AttributeSchedulerGraph
##
##  Copyright 2025,                            Markus Baumeister, RWTH Aachen
##                                       Sebastian Gutsche, Siegen University
##
##
#############################################################################

DeclareGlobalFunction( "__ATTRIBUTESCHEDULER_evaluate_recursive" );

DeclareCategory( "IsAttributeSchedulerGraph", IsObject );
#! @Chapter Introduction
#! @Section Overview
#! This manual describes the AttributeScheduler package, a GAP package for constructing
#! a graph to compute attributes with dependencies. The graph describes which
#! attribute implies other attributes. That means in detail that the nodes of the graph are the
#! attributes and the edges describe the dependencies. The graph can be constructed with
#! the method <Ref Subsect="Section_AttributeSchedulerGraph"/> and 
#! edges can be added with <Ref Subsect="AddPropertyIncidence"/>.
#! @Section Example
#! To understand how an attribute scheduler graph works consider an example.
#! Think about three attributes <A>A</A>, <A>B</A> and <A>C</A>.
#! @BeginExample
#! gap> DeclareAttribute( "A", IsAttributeStoringRep );
#! gap> DeclareAttribute( "B", IsAttributeStoringRep );
#! gap> DeclareAttribute( "C", IsAttributeStoringRep );
#! @EndExample
#! Where an attribute of an object can be calculated if the object has a certain other attribute.
#! @BeginExample
#! gap> InstallMethod( A, [ HasB ], i -> B( i )*2 );
#! gap> InstallMethod( B, [ HasC ], i -> C( i )*5 );
#! @EndExample
#! Construct now the attribute scheduler graph with this three attributes.
#! @BeginExample
#! gap> graph := AttributeSchedulerGraph( [ "A", "B", "C"] );
#! @EndExample
#! The goal of the graph is to describe dependencies of the attributes. 
#! For example, if attribute <A>B</A> is known for an object and one uses that to calculate attribute <A>A</A>
#! for this object. This is represented as adding an incidence between the two attributes in the graph.
#! Analogously add an incidence for the attribute <A>B</A> which can be calculated if attribute <A>C</A> is known for the object.
#! @BeginExampleSession
#! gap> AddPropertyIncidence( graph, "A", "B" );
#! gap> AddPropertyIncidence( graph, "B", "C" );
#! @EndExampleSession
#! Look at an example, where the attribute <A>A</A> is tried to calculate by knowing attribute <A>C</A>:
#! @BeginExampleSession
#! gap> S := SymmetricGroup( 3 );;
#! gap> SetC( S, 1 );
#! gap> ComputeProperty( graph, A, S );
#! 10
#! @EndExampleSession
#! Because of the dependencies it is possible to calculate attribute <A>A</A> by knowing attribute <A>C</A>.
#! The attribute <A>B</A> stores the value 5 because it calculates 5*1, since the value of <A>C</A> for <A>S</A> is 1. 
#! With this the result is 10 since the value of attribute <A>A</A> can be computed for <A>S</A> which is 2*5=10.
#!
#! Another way to calculate this is to use the method <A>AddAttribute</A>.
#! This offers a way to compute the value of <A>A</A> for some known property.
#! Internally, it calls the method <A>ComputeProperty</A> described above.
#! For the example above this method offers the opportunity to compute the attribute <A>A</A> for the object <A>S</A>. 
#! @BeginExampleSession
#! gap> S := SymmetricGroup( 3 );;
#! gap> SetC( S, 1 );
#! gap> AddAttribute(graph, A, IsAttributeStoringRep,"example");
#! gap> A(S);
#! 10
#! @EndExampleSession
#! 
#! The attribute scheduler can be imagine like a graph. 
#! Where the nodes are the attributes and an edge goes from <A>X</A> to <A>Y</A>
#! if the value of attribute <A>Y</A> can be calculated if the value attribute <A>X</A> is known.
#! In this example we have three nodes <A>A</A>, <A>B</A> and <A>C</A>, an edge from <A>C</A> to <A>B</A> and an edge from <A>B</A> to <A>A</A>.
#! In this sense the method <C>ComputeProperty</C> tries to find a path from a known attribute to the attribute that we want to compute.
#! If there are different paths resp. different ways to compute the attribute, the method returns just the first solution it finds.
#! That mean the order of adding property incidences can leads to different results. 

#! @Chapter Attribute Scheduler Graph
#! 
#! @Section Construction
#! @BeginGroup Section_AttributeSchedulerGraph
#! @Description
#! Constructor for the attribute scheduler graph.
#! Takes an optional argument <A>list</A>, which is a list of
#! strings that are attributes and serves as nodes for the graph.
#! Nodes can be added later by adding edges via <C>AddPropertyIncidence</C>.
#! @Returns An attribute scheduler graph
#! @Arguments [list]
DeclareOperation( "AttributeSchedulerGraph", [ IsList ] );
#! @EndGroup
#
#DeclareOperat( "AttributeSchedulerGraph", [ ] );

#! @BeginGroup AddAttribute
#! @Description
#! Add an attribute to the attribute scheduler graph. This method will
#! install a method for the attribute that calls the attribute 
#! scheduler graph.
#! <Par/>
#! Careful: This operation does not check whether <A>attribute</A> is an attribute or <A>filter</A>
#! is a filter.
#! @Arguments graph, attribute, filter, description
DeclareOperation( "AddAttribute", [IsAttributeSchedulerGraph, IsObject, IsObject, IsString] );
#! @EndGroup

#! @BeginGroup AddPropertyIncidence
#! @Description
#! Adds an edge to <A>graph</A>. Tells the graph that the property 
#! <A>property</A> can be computed if the properties in <A>requirements</A> 
#! are computed and the properties in <A>dependencies</A> are true (the
#! dependencies are not computed by the graph).
#!
#! Here, <A>requirements</A> can be a list of strings naming required 
#! properties, or a single string naming a single required property. The 
#! argument <A>dependencies</A> has to be a list of strings.
#!
#! @Arguments graph, property, requirements[, dependencies]
DeclareOperation( "AddPropertyIncidence", [ IsAttributeSchedulerGraph, IsString, IsList, IsList ] );
#! @EndGroup

#! @Section Computation of properties
#! 
#! @BeginGroup ComputeProperty
#! @Description
#! Checks the attribute scheduler graph <A>graph</A> if there is a way to compute
#! <A>attribute</A> for <A>object</A>. If so, the value is returned. If not, an error
#! is raised.
#! @Returns Value for <A>attribute</A>
#! @Arguments graph, attribute, object
DeclareOperation( "ComputeProperty", [ IsAttributeSchedulerGraph, IsFunction, IsObject ] );
#! @EndGroup
