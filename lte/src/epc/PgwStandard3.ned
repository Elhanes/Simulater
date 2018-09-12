//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//
package lte.epc;
import inet.applications.contract.IUDPApp;
import lte.epc.gtp.GtpUser;
import lte.epc.gtp.GtpUserSimplified_PGW;
import inet.linklayer.ppp.PPPInterface;
import inet.node.inet.NodeBase;
import lte.epc.TrafficFlowFilter;
import inet.transportlayer.udp.UDP;
import lte.corenetwork.binder.pgwset;

//
// Implements a simplified version of the EPC PDN Gateway (P-GW)
//
module PgwStandardSimplified3 extends NodeBase
{
    parameters:
        string nodeType; // must be one between ENB and PGW
        @display("bgb=920,462;i=device/mainframe");
        bool hasRIP = default(false);
    gates:
        inout filterGate @labels(PPPFrame-conn);

    submodules:
          rip: <"RIPRouting"> like IUDPApp if hasRIP {
            parameters:
                @display("p=575,44");
        }
        trafficFlowFilter: TrafficFlowFilterSimplified {
            ownerType = nodeType;
            @display("p=813,206");
        }
        pppInterface: PPPInterface {
            @display("p=727,386");
        }
        udp: UDP {
            @display("p=329,206");
        }
        gtp_user: GtpUserSimplified_PGW {
            @display("p=591,206");
        }
        pgwset: pgwset {
            @display("p=113.19,49.665;is=s");
        }
    connections:
        udp.ipOut --> networkLayer.transportIn++;
        udp.ipIn <-- networkLayer.transportOut++;

        pppInterface.upperLayerOut --> trafficFlowFilter.internetFilterGateIn;
        pppInterface.upperLayerIn <-- gtp_user.pppGate;
        pppInterface.phys <--> filterGate;

        udp.appOut++ --> gtp_user.udpIn;
        gtp_user.udpOut --> udp.appIn++;
        trafficFlowFilter.gtpUserGateOut --> gtp_user.trafficFlowFilterGate;
          if hasRIP {
            rip.udpOut --> udp.appIn++;
            rip.udpIn <-- udp.appOut++;
        }
}
