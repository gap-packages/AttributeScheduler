#############################################################################
##
##                                                    AttributeSchedulerGraph
##
##  Copyright 2017,                            Markus Baumeister, RWTH Aachen
##                                       Sebastian Gutsche, Siegen University
##
##! @Chapter Attribute scheduler Graph
##! @Section TODO
##
#############################################################################

DeclareGlobalFunction( "__ATTRIBUTESCHEDULER_evaluate_recursive" );

DeclareCategory( "IsAttributeSchedulerGraph", IsObject );

#! @BeginGroup
#! @Description
#!  Constructor for the attribute scheduler graph.
#!  Takes an optional argument <A>list</A>, which is a list of
#!  strings and serves as nodes for the graph. Nodes can always be added
#!  by adding edges via <C>AddPropertyIncidence</C>.
#! @Returns An attribute scheduling graph
#! @Arguments [list]
DeclareOperation( "AttributeSchedulerGraph", [ ] );
DeclareOperation( "AttributeSchedulerGraph", [ IsList ] );
#! @EndGroup

#! @Description
#! Add an attribute to the attribute scheduler graph. This method will
#! install a method for the attribute that calls the attribute 
#! scheduler graph.
#! <Par/>
#! Careful: Due to a limitation of GAP, attributes and filter can only
#! be given as general objects
#! @Arguments graph, attribute, filter, description
DeclareOperation( "AddAttribute", [IsAttributeSchedulerGraph, IsObject, IsObject, IsString] );

#! @Arguments graph,property,requirements
#! @Description
#!  Adds an edge to <A>graph</A>. Tells the graph that the property <A>property</A> can
#!  be computed if the properties in <A>requirements</A> are computed.
#!  Here, <A>requirements</A> can be a list of strings naming required properties, or
#!  a single string naming a single required property.
DeclareOperation( "AddPropertyIncidence", [ IsAttributeSchedulerGraph, IsString, IsList ] );


#! @Arguments graph,attribute,object
#! @Returns Value for <A>attribute</A>
#! @Description
#!  Checks the attribute scheduler graph <A>graph</A> if there is a way to compute
#!  <A>attribute</A> for <A>object</A>. If so, the value is returned. If not, an error
#! is raised.
DeclareOperation( "ComputeProperty", [ IsAttributeSchedulerGraph, IsFunction, IsObject ] );
