// 
//                           SimuLTE
// 
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself, 
// and cannot be removed from it.
// 
package lte.simulations.networks;

import inet.examples.sctp.cmttest.BottlePath;
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
network test_case1
{
    parameters:
        int numUe = default(1);
        @display("i=block/network2;bgb=6379.16,4680.156;bgi=background/budapest");


    submodules:
        channelControl: LteChannelControl {
            @display("p=2894.7122,1564.456;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=2904.08,543.344;is=s");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=2904.08,1236.576");
            config = xmldoc("demo.xml");
        }
        controller: controller {
            @display("p=2904.08,2164.008");
        }

        binder: LteBinder {
            @display("p=2904.08,889.96;is=s");
        }
        server: StandardHost {
            @display("p=164.216,454.75198;is=n;i=device/server");
        }
        router: Router {
            @display("p=574.756,448.436;i=device/smallrouter");
        }
        pgw1DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1149.512,1307.412;is=l");
        }
        pgwbinder2: PgwBinder2 {
            @display("p=2904.08,1854.864;is=s");
        }
        DC1: DC_Router {
            @display("p=1471.628,1781.1119");
        }
        pgw2DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1465.312,1307.412;is=l");
        }
        pgw3DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1806.376,1307.412;is=l");
        }
        upperrouter1: Router {
            @display("p=1471.628,808.448");
        }
        upper2router1: Router {
            @display("p=2904.08,449.664");
        }
        router4: Router {
            @display("p=1471.628,2172.704");
        }
        eNodeB1: eNB_UEset3 {
            @display("p=777.544,3100.808");
        }
        ue1[numUe]: Ue2 {
            @display("p=777.544,3494.2642");
        }
        DC2: DC_Router {
            @display("p=4383.304,1781.1119");
        }
        pgw1DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=4067.504,1307.412;is=l");
        }
        pgw2DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=4383.304,1307.412;is=l");
        }
        pgw3DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=4724.368,1307.412;is=l");
        }
        router1: Router {
            @display("p=4383.304,2172.704");
        }
        upperrouter2: Router {
            @display("p=4383.304,808.448");
        }
        router2: Router {
            @display("p=1470.776,3100.808");
        }
        router3: Router {
            @display("p=4384.224,3100.808");
        }
        eNodeB2: eNB_UEset3 {
            @display("p=5058.72,3100.808");
        }
        ue2[numUe]: Ue2 {
            @display("p=5358.496,3597.312");
        }
        router5: Router {
            @display("p=2904.08,2379.4722");
        }
        router6: Router {
            @display("p=3138.28,3737.832");
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

        eNodeB1.ppp <--> Eth10G <--> router2.pppg++;
        router4.pppg++ <--> Eth10G <--> DC1.pppg++;
        //dc1_begin
        DC2.pppg++ <--> Eth10G <--> pgw1DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw2DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw3DC2.pppg++;
        router1.pppg++ <--> Eth10G <--> DC2.pppg++;
        pgw3DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        //dc1_end

        pgw1DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        pgw2DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        router2.pppg++ <--> Eth10G <--> router6.pppg++;
        upper2router1.pppg++ <--> Eth10G <--> upperrouter2.pppg++;
        eNodeB2.ppp <--> Eth10G <--> router3.pppg++;
        router4.pppg++ <--> Eth10G <--> router5.pppg++;
        router5.pppg++ <--> Eth10G <--> router3.pppg++;
        router5.pppg++ <--> Eth10G <--> router1.pppg++;
        router6.pppg++ <--> Eth10G <--> router5.pppg++;
}
