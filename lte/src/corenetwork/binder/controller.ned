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
simple controller
{
    parameters:
      
          @display("i=block/cogwheel");
          bool random=default(true);
          double randomtime @unit("s")=default(0.1ms);
}
