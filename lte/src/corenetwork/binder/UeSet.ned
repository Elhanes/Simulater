// 
//                           SimuLTE
// 
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself, 
// and cannot be removed from it.
// 


package lte.corenetwork.binder;

// 
// This is the LTE Binder. At the moment it stores a table containing
// for each ip address the corresponding node id. It is used by the sender
// to find out the Id of the destination node
//
simple ueset
{
    parameters:
      
          @display("i=block/cogwheel");
          bool state=default(true);// default value is on
}
