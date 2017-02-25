#############################################################################
##
##                                                    AttributeSchedulerGraph
##
##  Copyright 2017,                            Markus Baumeister, RWTH Aachen
##                                       Sebastian Gutsche, Siegen University
##
#############################################################################

DeclareGlobalFunction( "__ATTRIBUTESCHEDULER_evaluate_recursive" );

DeclareCategory( "IsAttributeSchedulerGraph", IsObject );

DeclareOperation( "AttributeSchedulerGraph", [ IsList ] );

DeclareOperation( "AddPropertyIncidence", [ IsAttributeSchedulerGraph, IsString, IsList ] );

DeclareOperation( "ComputeProperty", [ IsAttributeSchedulerGraph, IsFunction, IsObject ] );
