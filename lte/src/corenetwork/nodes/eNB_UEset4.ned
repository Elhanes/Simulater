//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//


package lte.corenetwork.nodes;

import inet.applications.contract.IUDPApp;
import inet.routing.contract.IBGPRouting;
import inet.routing.contract.IIPRouting;
import inet.routing.contract.IPIMRouting;
import inet.transportlayer.contract.ITCP;
import inet.transportlayer.contract.IUDP;

import lte.stack.phy.ILteNic;//
import lte.stack.phy.LteNicEnb;//
import lte.stack.phy.LteNicEnbD2D;//
import lte.epc.TrafficFlowFilterSimplified;//
import lte.corenetwork.deployer.LteDeployer;//


import inet.common.packet.PcapRecorder;
import inet.applications.contract.IUDPApp;
import inet.linklayer.ppp.PPPInterface;
import inet.mobility.static.StationaryMobility;
import inet.networklayer.common.InterfaceTable;
import inet.networklayer.ipv4.IPv4RoutingTable;
import inet.networklayer.contract.IRoutingTable;
import inet.networklayer.contract.INetworkLayer;
import inet.transportlayer.udp.UDP;
import lte.corenetwork.deployer.LteDeployer;
import lte.epc.TrafficFlowFilterSimplified4;
import lte.epc.gtp.GtpUserSimplified5;
import lte.stack.phy.LteNicENBModified;
import inet.applications.contract.IPingApp;
import lte.corenetwork.binder.eNBset;
import inet.routing.contract.IIPRouting;
import inet.linklayer.contract.IWiredNic;

//
// eNodeB module with support for EPC (GTP-U, etc).
//
module eNB_UEset4
{
    parameters:
        @networkNode();
        @display("i=device/antennatower;bgb=980,511");

        //# Node specs
        string nodeType = "ENODEB";        // DO NOT CHANGE
        int macNodeId = default(0); // TODO: this is not a real parameter
        int macCellId = default(0);  // TODO: this is not a real parameter
        double txPower @unit(mw) = default(100mw);
        bool d2dCapable = true; //default(false);
        string nicType = d2dCapable ? "LteNicEnbD2D" : "LteNicEnb";

        //# Network Layer specs
        string networkLayerType = default("IPv4NetworkLayer");
        string routingTableType = default("IPv4RoutingTable");
        *.interfaceTableModule = default(absPath(".interfaceTable"));
        *.routingTableModule = default(routingTableType != "" ? absPath(".routingTable") : "");
        bool forwarding = default(false);
        bool hasRIP = default(false);
        int numTcpApps = default(0);  // no of TCP apps. Specify the app types in INI file with tcpApp[0..1].typename="TCPEchoApp" syntax
        int numUdpApps = default(0);  // no of UDP apps. Specify the app types in INI file with udpApp[0..1].typename="UDPVideoStreamCli" syntax
        int numX2Apps = default(0);   // no of X2 apps. Specify the app types in INI file with x2App[0..1].typename="X2AppClient" syntax
        int numPingApps = default(0);
        bool hasOSPF = default(false);
    gates:
        inout ppp;     // connection to LteIP peer
        input radioIn @directIn;  // connection to slave
        inout ethg[] @labels(EtherFrame-conn);
 
    submodules:

        rip: <"RIPRouting"> like IUDPApp if hasRIP {
            parameters:
                @display("p=575,44");
        }
        ospf: <"OSPFRouting"> like IIPRouting if hasOSPF {
            parameters:
                @display("p=662,269,row");
        }
        interfaceTable: InterfaceTable {
            @display("p=50,75;is=s");
        }
        // TODO: should not include a routing table
        // routing table
        routingTable: <routingTableType> like IRoutingTable if routingTableType != "" {
            parameters:
                @display("p=50,125;is=s");
        }
        mobility: StationaryMobility {
            @display("p=50,175;is=s");
        }
        // NOTE: LteDeployer must be created first
        deployer: LteDeployer {
            @display("p=50,225;is=s");
        }
        // NOTE: instance must be named "nic"
        // TODO: rename to something like lte?
        nic: LteNicENBModified {
            nodeType = nodeType;

            d2dCapable = d2dCapable;
            @display("p=200,311");
        }
        pppIf: PPPInterface {
            @display("p=569,311");
        }
        trafficFlowFilter: TrafficFlowFilterSimplified4 {
            ownerType = nodeType;
            @display("p=200,144");
        }
        udp: UDP {
            @display("p=569,144");
        }
        // network layer
        networkLayer: <networkLayerType> like INetworkLayer {
            parameters:
                @display("p=501,269;q=queue");
        }
        gtpUser: GtpUserSimplified5 {
            @display("p=381,83");
        }
        eNBset: eNBset {
            @display("p=50,280;is=s");
        }
        pingApp[numPingApps]: <default("PingApp2")> like IPingApp {
            parameters:
                @display("p=662,94,row,60");
        }
        eth[sizeof(ethg)]: <default("EthernetInterface")> like IWiredNic {
            parameters:
                @display("p=375,311,row,60;q=txQueue");
        }
       // pingApp: <default("PingApp2")> like IPingApp {
       //     parameters:
       //         @display("p=662,94,row,60");
       // }
       
       pcapRecorder: PcapRecorder {
            @display("p=50,329;b=19,10");
        }
    connections allowunconnected:
        //#
        //# Internal LTE stack to PHY and
        //# Lte IP connections
        //#


        //#
        //# External connection to peer Lte Ip and air interface
        //#

        nic.radioIn <-- radioIn;
        pppIf.phys <--> ppp;

        udp.ipOut --> networkLayer.transportIn++;
        udp.ipIn <-- networkLayer.transportOut++;

        gtpUser.udpOut --> udp.appIn++;
        gtpUser.udpIn <-- udp.appOut++;

        networkLayer.ifOut++ --> pppIf.upperLayerIn;
        pppIf.upperLayerOut --> networkLayer.ifIn++;

        nic.upperLayerOut --> trafficFlowFilter.internetFilterGateIn;
        gtpUser.pppGate --> nic.upperLayerIn;
        for i=0..numPingApps-1 {
            networkLayer.pingOut++ --> pingApp[i].pingIn;
            networkLayer.pingIn++ <-- pingApp[i].pingOut;
        }
        trafficFlowFilter.gtpUserGateOut --> gtpUser.trafficFlowFilterGate;

        if hasOSPF {
            ospf.ipOut --> networkLayer.transportIn++;
            ospf.ipIn <-- networkLayer.transportOut++;
        }
        if hasRIP {
            rip.udpOut --> udp.appIn++;
            rip.udpIn <-- udp.appOut++;
        }

        for i=0..sizeof(ethg)-1 {
            ethg[i] <--> { @display("m=s"); } <--> eth[i].phys;
            eth[i].upperLayerOut --> networkLayer.ifIn++;
            eth[i].upperLayerIn <-- networkLayer.ifOut++;
        }
}
