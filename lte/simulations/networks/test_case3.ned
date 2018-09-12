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
import inet.node.ethernet.Eth100G;
import inet.node.ethernet.Eth10G;
import inet.node.ethernet.Eth10M;
import inet.node.inet.Router;
import inet.node.rip.RIPRouter;
import inet.node.xmipv6.CorrespondentNode6;
import inet.routing.rip.RIPRouting;
import inet.visualizer.integrated.IntegratedVisualizer;
import lte.corenetwork.nodes.DC_Router;
import inet.node.inet.StandardHost;
import lte.corenetwork.binder.LteBinder;
import lte.corenetwork.nodes.Ue2;
import lte.corenetwork.nodes.eNB_UEset3;
import lte.corenetwork.nodes.eNBpp;
import lte.corenetwork.nodes.eNodeB;
import lte.world.radio.LteChannelControl;
import lte.epc.PgwStandardSimplified2;
import lte.corenetwork.binder.PgwBinder2;
import lte.corenetwork.binder.controller;
network test_case3
{
    parameters:
        int numUe = default(1);
        @display("i=block/network2;bgb=6379.16,4680.156;bgi=background/budapest");


    submodules:
        channelControl: LteChannelControl {
            @display("p=6132.836,1181.092;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=6139.152,164.216;is=s");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=6139.152,852.66");
            config = xmldoc("demo.xml");
        }
        controller: controller {
            @display("p=6136.04,2014.12");
        }

        binder: LteBinder {
            @display("p=6139.152,511.596;is=s");
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
            @display("p=6136.04,1526.984;is=s");
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
            @display("p=777.544,3812.7761");
        }
        router2: Router {
            @display("p=1283.416,3138.28");
        }
        router3: Router {
            @display("p=2538.728,2257.688");
        }
        eNodeB2: eNB_UEset3 {
            @display("p=5058.72,3100.808");
        }
        ue2[numUe]: Ue2 {
            @display("p=5358.496,3719.0962");
        }
        router1: Router {
            @display("p=2126.5361,2810.4001");
        }
        router5: Router {
            @display("p=5208.608,2342");
        }
        router6: Router {
            @display("p=3831.5122,3063.3362");
        }
        router7: Router {
            @display("p=3119.5442,3681.624");
        }
        router8: Router {
            @display("p=3775.3042,2257.688");
        }
        eNodeB3: eNB_UEset3 {
            @display("p=3775.3042,4009.5042");
        }
        ue3[numUe]: Ue2 {
            @display("p=3044.6,4299.912");
        }
        DC2: DC_Router {
            @display("p=3925.1921,1779.92");
        }
        pgw1DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3597.312,1302.152;is=l");
        }
        pgw2DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3915.824,1302.152;is=l");
        }
        pgw3DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=4253.0723,1302.152;is=l");
        }
        upperrouter2: Router {
            @display("p=3925.1921,805.648");
        }
        router9: Router {
            @display("p=2267.0562,3353.7441");
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
        eNodeB2.ppp <--> Eth10G <--> router5.pppg++;
        router1.pppg++ <--> Eth10G <--> router2.pppg++;
        router4.pppg++ <--> Eth10G <--> router3.pppg++;
        router3.pppg++ <--> Eth10G <--> router1.pppg++;
        router5.pppg++ <--> Eth10G <--> router8.pppg++;
        router6.pppg++ <--> Eth10G <--> router3.pppg++;
        router1.pppg++ <--> Eth10G <--> router6.pppg++;
        router6.pppg++ <--> Eth10G <--> router8.pppg++;
        router8.pppg++ <--> Eth10G <--> router3.pppg++;
        router6.pppg++ <--> Eth10G <--> router7.pppg++;
        router7.pppg++ <--> Eth10G <--> eNodeB3.ppp;
        pgw2DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        pgw3DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        //dc1_end

        //dc1_begin
        DC2.pppg++ <--> Eth10G <--> pgw1DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw2DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw3DC2.pppg++;
        pgw1DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        router8.pppg++ <--> Eth10G <--> DC2.pppg++;
        upperrouter2.pppg++ <--> Eth10G <--> upper2router1.pppg++;
        router1.pppg++ <--> Eth10G <--> router9.pppg++;
        router9.pppg++ <--> Eth10G <--> router7.pppg++;
        router9.pppg++ <--> Eth10G <--> router6.pppg++;
}
