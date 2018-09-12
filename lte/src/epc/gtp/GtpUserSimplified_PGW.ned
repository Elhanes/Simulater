
package lte.epc.gtp;
simple GtpUserSimplified_PGW
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