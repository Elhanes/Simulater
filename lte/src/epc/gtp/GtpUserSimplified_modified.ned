//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

package lte.epc.gtp;

//
// Implements a simplified version of the GTP-U protocol
//
simple GtpUserSimplified_modified
{
    parameters:
        int localPort = default(31);
        int tunnelPeerPort = default(31);
        bool filter = default(true);

        @display("i=block/tunnel");

    gates:
        output udpOut;
        input udpIn;

        input trafficFlowFilterGate;
        output pppGate;
}

