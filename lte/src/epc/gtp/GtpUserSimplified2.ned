
package lte.epc.gtp;
simple GtpUserSimplified2
{
    parameters:
        int localPort = default(32);
        int tunnelPeerPort = default(31);
        bool filter = default(true);
        
        @display("i=block/tunnel");

    gates:
        output udpOut;
        input udpIn;

        input trafficFlowFilterGate;
        output pppGate;
}