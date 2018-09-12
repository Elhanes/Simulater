// 
//                           SimuLTE
// 
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself, 
// and cannot be removed from it.
// 
package lte.simulations.networks;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import inet.node.ethernet.Eth10M;
import inet.node.inet.Router;
import lte.corenetwork.nodes.DC_Router;
import inet.node.inet.StandardHost;
import lte.corenetwork.binder.LteBinder;
import lte.corenetwork.nodes.Ue2;
import lte.corenetwork.nodes.eNB_UEset3;
import lte.world.radio.LteChannelControl;
import lte.epc.PgwStandardSimplified2;
import lte.corenetwork.binder.PgwBinder2;
import lte.corenetwork.binder.controller;
network example
{
    parameters:
        int numUe = default(1);
        @display("i=block/network2;bgb=4518.585,3154.0618;bgi=background/budapest");


    submodules:
        channelControl: LteChannelControl {
            @display("p=2955.888,454.75198;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=3915.92,587.388;is=s");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=3606.436,1010.56");
            config = xmldoc("demo.xml");
        }
        controller: controller {
            @display("p=1800.1277,1624.7476");
        }

        binder: LteBinder {
            @display("p=3044.312,1212.672;is=s");
        }
        server: StandardHost {
            @display("p=743.777,184.54616;is=n;i=device/server");
        }
        router: Router {
            @display("p=738.18463,475.34616;i=device/smallrouter");
        }
        pgw1DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1029.508,1408.468;is=l");
        }
        pgwbinder2: PgwBinder2 {
            @display("p=1800.1277,1217.7334;is=s");
        }
        DC1: DC_Router {
            @display("p=1155.828,1806.376");
        }
        pgw2DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1149.512,1408.468;is=l");
        }
        pgw3DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1250.568,1408.468;is=l");
        }
        upperrouter1: Router {
            @display("p=1143.196,896.872");
        }
        upper2router1: Router {
            @display("p=1148.2432,476.50436");
        }
        router4: Router {
            @display("p=1282.148,2349.552");
        }
        eNodeB1: eNB_UEset3 {
            @display("p=877.924,2090.596");
        }
        ue1[numUe]: Ue2 {
            @display("p=877.924,2349.552");
        }
        router1: Router {
            @display("p=1888.484,2349.552");
        }
        router2: Router {
            @display("p=2671.668,2153.756");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;

        //upper_router
        upperrouter1.pppg++ <--> Eth10G <--> upper2router1.pppg++;
        upper2router1.pppg++ <--> Eth10G <--> router.pppg++;
        //dc1_begin
        DC1.pppg++ <--> Eth10G <--> pgw1DC1.pppg++;
        DC1.pppg++ <--> Eth10G <--> pgw2DC1.pppg++;
        DC1.pppg++ <--> Eth10G <--> pgw3DC1.pppg++;
        pgw1DC1.filterGate <--> Eth10G <--> upperrouter1.pppg++;
        pgw2DC1.filterGate <--> Eth10G <--> upperrouter1.pppg++;
        pgw3DC1.filterGate <--> Eth10G <--> upperrouter1.pppg++;
        //dc1_end

        eNodeB1.ppp <--> Eth10G <--> router4.pppg++;
        router2.pppg++ <--> Eth10G <--> DC1.pppg++;
        router4.pppg++ <--> Eth10G <--> router1.pppg++;
        router1.pppg++ <--> Eth10G <--> router2.pppg++;
}
