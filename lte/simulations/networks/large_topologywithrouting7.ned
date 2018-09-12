// 
//                           SimuLTE
// 
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself, 
// and cannot be removed from it.
// 
package lte.simulations.networks;
import ned.DatarateChannel;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import inet.node.ethernet.Eth10M;
import inet.node.inet.Router;
import lte.corenetwork.nodes.DC_Router;
import inet.node.inet.StandardHost;
import lte.corenetwork.binder.LteBinder;
import lte.corenetwork.nodes.Ue2;
import lte.corenetwork.nodes.eNB_UEset4;
import lte.world.radio.LteChannelControl;
import lte.epc.PgwStandardSimplified2;
import lte.corenetwork.binder.PgwBinder2;
import lte.corenetwork.binder.controller;
network large_topologywithrouting7
{
    parameters:
        int numUe = default(1);
        @display("i=block/network2;bgb=5666.92,3196.06;bgi=background/budapest");
    types:
        channel C extends DatarateChannel
        {
            delay = 0.1us;
            datarate = 100Mbps;
        }


    submodules:
        channelControl: LteChannelControl {
            @display("p=4144,1797.46;is=vl");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=4144,1849.26;is=s");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=4144,1895.88");
            config = xmldoc("demo.xml");
        }
        controller: controller {
            @display("p=4144,2128.98");
        }

        binder: LteBinder {
            @display("p=4144,1947.68;is=s");
        }
        server: StandardHost {
            @display("p=1781.92,429.94;is=n;i=device/server");
        }
        router: Router {
            @display("p=1781.92,502.46;i=device/smallrouter");
        }
        pgw1DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2916.34,2460.5;is=l");
        }
        pgwbinder2: PgwBinder2 {
            @display("p=4144,1724.9401;is=s");
        }
        DC1: DC_Router {
            @display("p=2999.22,2558.92");
        }
        pgw2DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2994.04,2460.5;is=l");
        }
        pgw3DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3030.3,2460.5;is=l");
        }
        upperrouter1: Router {
            @display("p=2957.78,2377.62");
        }
        upper2router1: Router {
            @display("p=1006.7639,1900.3553;is=vl");
        }
        router2: Router {
            @display("p=1781.92,1124.06");
        }
        router3: Router {
            @display("p=1963.22,989.38");
        }
        router4: Router {
            @display("p=1688.68,1331.26");
        }
        router6: Router {
            @display("p=2118.62,1901.06");
        }
        eNodeB2: eNB_UEset4 {
            @display("p=1434.86,1036");
        }
        eNodeB1: eNB_UEset4 {
            @display("p=1243.2001,1331.26");
        }
        ue1[numUe]: Ue2 {
            @display("p=1471.12,1497.02");
        }
        ue2[numUe]: Ue2 {
            @display("p=1305.36,1036");
        }
        eNodeB3: eNB_UEset4 {
            @display("p=2144.52,2128.98");
        }
        ue3[numUe]: Ue2 {
            @display("p=2387.98,2165.24");
        }
        router8: Router {
            @display("p=2533.02,932.4");
        }
        router9: Router {
            @display("p=2792.02,1828.54");
        }
        router10: Router {
            @display("p=3164.98,1206.9401");
        }
        eNodeB5: eNB_UEset4 {
            @display("p=2501.94,694.12");
        }
        eNodeB4: eNB_UEset4 {
            @display("p=2367.26,647.5");
        }
        ue4[numUe]: Ue2 {
            @display("p=2315.46,543.9");
        }
        ue5[numUe]: Ue2 {
            @display("p=2667.7,673.4");
        }
        router1: Router {
            @display("p=2797.2,1004.92");
        }
        router7: Router {
            @display("p=3108,1512.56");
        }
        router11: Router {
            @display("p=2590,1916.6");
        }
        router12: Router {
            @display("p=1833.72,1849.26");
        }
        router13: Router {
            @display("p=1693.86,1595.4401");
        }
        pgw2DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1336.4401,1776.74;is=l");
        }
        upperrouter2: Router {
            @display("p=1284.64,2015.02");
        }
        pgw1DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1263.92,1776.74;is=l");
        }
        DC2: DC_Router {
            @display("p=1336.4401,1688.68");
        }
        pgw3DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1377.88,1776.74;is=l");
        }
        DC3: DC_Router {
            @display("p=2745.4001,1963.22");
        }
        upperrouter3: Router {
            @display("p=2719.5,2242.94");
        }
        pgw3DC3: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2833.46,2066.82;is=l");
        }
        pgw2DC3: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2792.02,2066.82;is=l");
        }
        pgw1DC3: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2719.5,2066.82;is=l");
        }
        DC4: DC_Router {
            @display("p=3185.7,1704.22");
        }
        pgw2DC4: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3237.5,1813;is=l");
        }
        upperrouter4: Router {
            @display("p=3164.98,1983.9401");
        }
        pgw3DC4: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3278.94,1813;is=l");
        }
        pgw1DC4: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3164.98,1813;is=l");
        }
        upper2router2: Router {
            @display("p=1579.9,2419.06");
        }
        eNodeB6: eNB_UEset4 {
            @display("p=1844.0801,2051.28");
        }
        ue6[numUe]: Ue2 {
            @display("p=1890.7001,2149.7");
        }
        eNodeB7: eNB_UEset4 {
            @display("p=2486.4001,2056.46");
        }
        ue7[numUe]: Ue2 {
            @display("p=2553.74,2170.42");
        }
        eNodeB8: eNB_UEset4 {
            @display("p=2962.96,1911.42");
        }
        ue8[numUe]: Ue2 {
            @display("p=2999.22,2108.26");
        }
        eNodeB9: eNB_UEset4 {
            @display("p=3144.26,792.54004");
        }
        ue9[numUe]: Ue2 {
            @display("p=3242.68,720.02");
        }
        pgw2DC5: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2962.96,704.48;is=l");
        }
        upperrouter5: Router {
            @display("p=3035.48,564.62");
        }
        DC5: DC_Router {
            @display("p=2859.36,896.14");
        }
        pgw1DC5: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2890.44,704.48;is=l");
        }
        pgw3DC5: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3004.4001,704.48;is=l");
        }
        pgw2DC6: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3423.98,1564.36;is=l");
        }
        upperrouter6: Router {
            @display("p=3351.46,1735.3");
        }
        DC6: DC_Router {
            @display("p=3372.18,1455.58");
        }
        pgw1DC6: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3351.46,1564.36;is=l");
        }
        pgw3DC6: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=3465.42,1564.36;is=l");
        }
        eNodeB10: eNB_UEset4 {
            @display("p=1491.84,916.86");
        }
        ue10[numUe]: Ue2 {
            @display("p=1336.4401,916.86");
        }
        router5: Router {
            @display("p=1980.5192,1190.6693");
        }
        router14: Router {
            @display("p=1933.3639,1454.7385");
        }
        router15: Router {
            @display("p=2072.472,1629.2128");
        }
        router16: Router {
            @display("p=2367.192,1664.5792");
        }
        router17: Router {
            @display("p=2763.296,1563.1954");
        }
        router18: Router {
            @display("p=2857.6062,1329.7771");
        }
        router19: Router {
            @display("p=2555.8127,1157.6606");
        }
        router20: Router {
            @display("p=2213.9375,1329.7771");
        }
        router21: Router {
            @display("p=2555.8127,1402.8678");
        }
        router22: Router {
            @display("p=2258.7349,1122.2942");
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
       // pgw1DC1.filterGate <--> Eth10G <--> upperrouter1.pppg++;
       // pgw2DC1.filterGate <--> Eth10G <--> upperrouter1.pppg++;
       // pgw3DC1.filterGate <--> Eth10G <--> upperrouter1.pppg++;
        //dc1_end


        router7.pppg++ <--> Eth10G <--> DC1.pppg++;
        eNodeB2.ppp <--> Eth10G <--> router2.pppg++;
        eNodeB1.ppp <--> Eth10G <--> router4.pppg++;
        eNodeB3.ppp <--> Eth10G <--> router6.pppg++;

        router8.pppg++ <--> Eth10G <--> eNodeB4.ppp;
        router8.pppg++ <--> Eth10G <--> eNodeB5.ppp;
        router1.pppg++ <--> Eth10G <--> router8.pppg++;
        router1.pppg++ <--> Eth10G <--> router10.pppg++;
        router10.pppg++ <--> Eth10G <--> router7.pppg++;
        router7.pppg++ <--> Eth10G <--> router9.pppg++;
        router11.pppg++ <--> Eth10G <--> router6.pppg++;
        router11.pppg++ <--> Eth10G <--> router9.pppg++;
        router12.pppg++ <--> Eth10G <--> router6.pppg++;
        router12.pppg++ <--> Eth10G <--> router13.pppg++;
        router13.pppg++ <--> Eth10G <--> router4.pppg++;
        //dc1_begin
        DC2.pppg++ <--> Eth10G <--> pgw1DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw2DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw3DC2.pppg++;
    //  pgw1DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
     //   pgw2DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
     //   pgw3DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        //dc1_end

        DC2.pppg++ <--> Eth10G <--> router13.pppg++;
        //dc1_begin
        DC3.pppg++ <--> Eth10G <--> pgw1DC3.pppg++;
        DC3.pppg++ <--> Eth10G <--> pgw2DC3.pppg++;
        DC3.pppg++ <--> Eth10G <--> pgw3DC3.pppg++;
       // pgw1DC3.filterGate <--> Eth10G <--> upperrouter3.pppg++;
       // pgw2DC3.filterGate <--> Eth10G <--> upperrouter3.pppg++;
       // pgw3DC3.filterGate <--> Eth10G <--> upperrouter3.pppg++;
        //dc1_end

        DC3.pppg++ <--> Eth10G <--> router11.pppg++;
        //dc1_begin
        DC4.pppg++ <--> Eth10G <--> pgw1DC4.pppg++;
        DC4.pppg++ <--> Eth10G <--> pgw2DC4.pppg++;
        DC4.pppg++ <--> Eth10G <--> pgw3DC4.pppg++;
     //   pgw1DC4.filterGate <--> Eth10G <--> upperrouter4.pppg++;
     //   pgw2DC4.filterGate <--> Eth10G <--> upperrouter4.pppg++;
     //   pgw3DC4.filterGate <--> Eth10G <--> upperrouter4.pppg++;
        //dc1_end

        upperrouter3.pppg++ <--> Eth10G <--> upper2router2.pppg++;
        upperrouter4.pppg++ <--> Eth10G <--> upper2router2.pppg++;
        upperrouter2.pppg++ <--> Eth10G <--> upper2router2.pppg++;
        upper2router2.pppg++ <--> Eth10G <--> upper2router1.pppg++;
        router10.pppg++ <--> Eth10G <--> eNodeB9.ppp;
        router9.pppg++ <--> Eth10G <--> eNodeB8.ppp;
        eNodeB7.ppp <--> Eth10G <--> router11.pppg++;
        eNodeB6.ppp <--> Eth10G <--> router12.pppg++;
        //dc1_begin
        DC5.pppg++ <--> Eth10G <--> pgw1DC5.pppg++;
        DC5.pppg++ <--> Eth10G <--> pgw2DC5.pppg++;
        DC5.pppg++ <--> Eth10G <--> pgw3DC5.pppg++;
     //   pgw1DC5.filterGate <--> Eth10G <--> upperrouter5.pppg++;
     //   pgw2DC5.filterGate <--> Eth10G <--> upperrouter5.pppg++;
     //   pgw3DC5.filterGate <--> Eth10G <--> upperrouter5.pppg++;
        //dc1_end

        router3.pppg++ <--> Eth10G <--> DC5.pppg++;
        upperrouter5.pppg++ <--> Eth10G <--> upper2router1.pppg++;
        //dc1_begin
        DC6.pppg++ <--> Eth10G <--> pgw1DC6.pppg++;
        DC6.pppg++ <--> Eth10G <--> pgw2DC6.pppg++;
        DC6.pppg++ <--> Eth10G <--> pgw3DC6.pppg++;
      //  pgw1DC6.filterGate <--> Eth10G <--> upperrouter6.pppg++;
     //   pgw2DC6.filterGate <--> Eth10G <--> upperrouter6.pppg++;
     //   pgw3DC6.filterGate <--> Eth10G <--> upperrouter6.pppg++;
        //dc1_end

        DC6.pppg++ <--> Eth10G <--> router7.pppg++;
        upperrouter6.pppg++ <--> Eth10G <--> upper2router2.pppg++;
        eNodeB10.ppp <--> Eth10G <--> router2.pppg++;
        router4.pppg++ <--> Eth10G <--> router2.pppg++;
        router2.pppg++ <--> Eth10G <--> router3.pppg++;
        router2.pppg++ <--> Eth10G <--> router5.pppg++;
        router4.pppg++ <--> Eth10G <--> router5.pppg++;
        router3.pppg++ <--> Eth10G <--> router5.pppg++;
        router5.pppg++ <--> Eth10G <--> router22.pppg++;
        router3.pppg++ <--> Eth10G <--> router22.pppg++;
        router22.pppg++ <--> Eth10G <--> router8.pppg++;
        router22.pppg++ <--> Eth10G <--> router21.pppg++;
        router5.pppg++ <--> Eth10G <--> router20.pppg++;
        router20.pppg++ <--> Eth10G <--> router14.pppg++;
        router14.pppg++ <--> Eth10G <--> router13.pppg++;
        router14.pppg++ <--> Eth10G <--> router15.pppg++;
        router12.pppg++ <--> Eth10G <--> router15.pppg++;
        router15.pppg++ <--> Eth10G <--> router16.pppg++;
        router20.pppg++ <--> Eth10G <--> router21.pppg++;
        router20.pppg++ <--> Eth10G <--> router16.pppg++;
        router16.pppg++ <--> Eth10G <--> router17.pppg++;
        router17.pppg++ <--> Eth10G <--> router18.pppg++;
        router21.pppg++ <--> Eth10G <--> router18.pppg++;
        router21.pppg++ <--> Eth10G <--> router19.pppg++;
        router22.pppg++ <--> Eth10G <--> router19.pppg++;
        router19.pppg++ <--> Eth10G <--> router1.pppg++;
        router18.pppg++ <--> Eth10G <--> router10.pppg++;
        router16.pppg++ <--> Eth10G <--> router11.pppg++;
        router16.pppg++ <--> Eth10G <--> router6.pppg++;
        router17.pppg++ <--> Eth10G <--> router7.pppg++;


         //upper_router
        upperrouter1.ethg++ <--> C <--> upper2router1.ethg++;
        upper2router1.ethg++ <--> C <--> router.ethg++;
        //dc1_begin
        DC1.ethg++ <--> C <--> pgw1DC1.ethg++;
        DC1.ethg++ <--> C <--> pgw2DC1.ethg++;
        DC1.ethg++ <--> C <--> pgw3DC1.ethg++;
        pgw1DC1.filterGate <--> C <--> upperrouter1.ethg++;
        pgw2DC1.filterGate <--> C <--> upperrouter1.ethg++;
        pgw3DC1.filterGate <--> C <--> upperrouter1.ethg++;
        //dc1_end


        router7.ethg++ <--> C <--> DC1.ethg++;
        eNodeB2.ethg++ <--> C <--> router2.ethg++;
        eNodeB1.ethg++ <--> C <--> router4.ethg++;
        eNodeB3.ethg++ <--> C <--> router6.ethg++;

        router8.ethg++ <--> C <--> eNodeB4.ethg++;
        router8.ethg++ <--> C <--> eNodeB5.ethg++;
        router1.ethg++ <--> C <--> router8.ethg++;
        router1.ethg++ <--> C <--> router10.ethg++;
        router10.ethg++ <--> C <--> router7.ethg++;
        router7.ethg++ <--> C <--> router9.ethg++;
        router11.ethg++ <--> C <--> router6.ethg++;
        router11.ethg++ <--> C <--> router9.ethg++;
        router12.ethg++ <--> C <--> router6.ethg++;
        router12.ethg++ <--> C <--> router13.ethg++;
        router13.ethg++ <--> C <--> router4.ethg++;
        //dc1_begin
        DC2.ethg++ <--> C <--> pgw1DC2.ethg++;
        DC2.ethg++ <--> C <--> pgw2DC2.ethg++;
        DC2.ethg++ <--> C <--> pgw3DC2.ethg++;
        pgw1DC2.filterGate <--> C <--> upperrouter2.ethg++;
        pgw2DC2.filterGate <--> C <--> upperrouter2.ethg++;
        pgw3DC2.filterGate <--> C <--> upperrouter2.ethg++;
        //dc1_end

        DC2.ethg++ <--> C <--> router13.ethg++;
        //dc1_begin
        DC3.ethg++ <--> C <--> pgw1DC3.ethg++;
        DC3.ethg++ <--> C <--> pgw2DC3.ethg++;
        DC3.ethg++ <--> C <--> pgw3DC3.ethg++;
        pgw1DC3.filterGate <--> C <--> upperrouter3.ethg++;
        pgw2DC3.filterGate <--> C <--> upperrouter3.ethg++;
        pgw3DC3.filterGate <--> C <--> upperrouter3.ethg++;
        //dc1_end

        DC3.ethg++ <--> C <--> router11.ethg++;
        //dc1_begin
        DC4.ethg++ <--> C <--> pgw1DC4.ethg++;
        DC4.ethg++ <--> C <--> pgw2DC4.ethg++;
        DC4.ethg++ <--> C <--> pgw3DC4.ethg++;
        pgw1DC4.filterGate <--> C <--> upperrouter4.ethg++;
        pgw2DC4.filterGate <--> C <--> upperrouter4.ethg++;
        pgw3DC4.filterGate <--> C <--> upperrouter4.ethg++;
        //dc1_end

        upperrouter3.ethg++ <--> C <--> upper2router2.ethg++;
        upperrouter4.ethg++ <--> C <--> upper2router2.ethg++;
        upperrouter2.ethg++ <--> C <--> upper2router2.ethg++;
        upper2router2.ethg++ <--> C <--> upper2router1.ethg++;
        router10.ethg++ <--> C <--> eNodeB9.ethg++;
        router9.ethg++ <--> C <--> eNodeB8.ethg++;
        eNodeB7.ethg++ <--> C <--> router11.ethg++;
        eNodeB6.ethg++ <--> C <--> router12.ethg++;
        //dc1_begin
        DC5.ethg++ <--> C <--> pgw1DC5.ethg++;
        DC5.ethg++ <--> C <--> pgw2DC5.ethg++;
        DC5.ethg++ <--> C <--> pgw3DC5.ethg++;
        pgw1DC5.filterGate <--> C <--> upperrouter5.ethg++;
        pgw2DC5.filterGate <--> C <--> upperrouter5.ethg++;
        pgw3DC5.filterGate <--> C <--> upperrouter5.ethg++;
        //dc1_end

        router3.ethg++ <--> C <--> DC5.ethg++;
        upperrouter5.ethg++ <--> C <--> upper2router1.ethg++;
        //dc1_begin
        DC6.ethg++ <--> C <--> pgw1DC6.ethg++;
        DC6.ethg++ <--> C <--> pgw2DC6.ethg++;
        DC6.ethg++ <--> C <--> pgw3DC6.ethg++;
        pgw1DC6.filterGate <--> C <--> upperrouter6.ethg++;
        pgw2DC6.filterGate <--> C <--> upperrouter6.ethg++;
        pgw3DC6.filterGate <--> C <--> upperrouter6.ethg++;
        //dc1_end

        DC6.ethg++ <--> C <--> router7.ethg++;
        upperrouter6.ethg++ <--> C <--> upper2router2.ethg++;
        eNodeB10.ethg++ <--> C <--> router2.ethg++;
        router4.ethg++ <--> C <--> router2.ethg++;
        router2.ethg++ <--> C <--> router3.ethg++;
        router2.ethg++ <--> C <--> router5.ethg++;
        router4.ethg++ <--> C <--> router5.ethg++;
        router3.ethg++ <--> C <--> router5.ethg++;
        router5.ethg++ <--> C <--> router22.ethg++;
        router3.ethg++ <--> C <--> router22.ethg++;
        router22.ethg++ <--> C <--> router8.ethg++;
        router22.ethg++ <--> C <--> router21.ethg++;
        router5.ethg++ <--> C <--> router20.ethg++;
        router20.ethg++ <--> C <--> router14.ethg++;
        router14.ethg++ <--> C <--> router13.ethg++;
        router14.ethg++ <--> C <--> router15.ethg++;
        router12.ethg++ <--> C <--> router15.ethg++;
        router15.ethg++ <--> C <--> router16.ethg++;
        router20.ethg++ <--> C <--> router21.ethg++;
        router20.ethg++ <--> C <--> router16.ethg++;
        router16.ethg++ <--> C <--> router17.ethg++;
        router17.ethg++ <--> C <--> router18.ethg++;
        router21.ethg++ <--> C <--> router18.ethg++;
        router21.ethg++ <--> C <--> router19.ethg++;
        router22.ethg++ <--> C <--> router19.ethg++;
        router19.ethg++ <--> C <--> router1.ethg++;
        router18.ethg++ <--> C <--> router10.ethg++;
        router16.ethg++ <--> C <--> router11.ethg++;
        router16.ethg++ <--> C <--> router6.ethg++;
        router17.ethg++ <--> C <--> router7.ethg++;

}
