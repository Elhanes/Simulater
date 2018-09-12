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
import lte.corenetwork.binder.controller;
import lte.corenetwork.nodes.DC_Router;
import inet.node.inet.StandardHost;
import lte.corenetwork.binder.LteBinder;
import lte.corenetwork.nodes.Ue2;
import lte.corenetwork.nodes.eNB_UEset3;
import lte.world.radio.LteChannelControl;
import lte.epc.PgwStandardSimplified2;
import lte.corenetwork.binder.PgwBinder2;

network smaller_topology
{
    parameters:
        int numUe = default(1);
        @display("i=block/network2;bgb=1898.505,1190.7");
    submodules:
        channelControl: LteChannelControl {
            @display("p=50,25;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=50,75;is=s");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=50,125");
            config = xmldoc("demo.xml");
        }
        binder: LteBinder {
            @display("p=50,175;is=s");
        }
        server: StandardHost {
            @display("p=228.2175,74.41875;is=n;i=device/server");
        }
        router: Router {
            @display("p=704.45996,121.787994;i=device/smallrouter");
        }
        pgw1DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=459.7425,325.78876;is=l");
        }
        pgwbinder2: PgwBinder2 {
            @display("p=1616.6759,229.248;is=s");
        }
        DC1: DC_Router {
            @display("p=549.045,479.5875");
        }
        router1: Router {
            @display("p=772.3013,725.9963");
        }
        pgw2DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=509.355,325.78876;is=l");
        }
        pgw3DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=575.505,325.78876;is=l");
        }
        pgw2DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=850.0275,309.25125;is=l");
        }
        DC2: DC_Router {
            @display("p=778.91626,479.5875");
        }
        pgw3DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=914.52374,309.25125;is=l");
        }
        pgw1DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=793.8,309.25125;is=l");
        }
        eNodeB1: eNB_UEset3 {
            @display("p=441.55124,725.9963");
        }
        ue1[numUe]: Ue2 {
            @display("p=322.48126,926.1");
        }
        eNodeB2: eNB_UEset3 {
            @display("p=549.045,1008.7875");
        }
        ue2[numUe]: Ue2 {
            @display("p=631.7325,1101.3975");
        }
        eNodeB3: eNB_UEset3 {
            @display("p=557.3137,861.60376");
        }
        ue3[numUe]: Ue2 {
            @display("p=461.39624,897.98627");
        }
        eNodeB4: eNB_UEset3 {
            @display("p=704.4975,897.98627");
        }
        ue4[numUe]: Ue2 {
            @display("p=816.9525,990.59625");
        }
        eNodeB5: eNB_UEset3 {
            @display("p=1253.5425,390.285");
        }
        ue5[numUe]: Ue2 {
            @display("p=1392.4575,479.5875");
        }
        router2: Router {
            @display("p=803.7225,618.5025");
        }
        router3: Router {
            @display("p=1276.695,725.9963");
        }
        router4: Router {
            @display("p=1071.63,648.27");
        }
        controller: controller {
            @display("p=1616.6759,348.64798;b=95.52,64.476");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;


        router2.pppg++ <--> Eth10G <--> DC1.pppg++;
        DC1.pppg++ <--> Eth10G <--> pgw1DC1.pppg++;
        DC1.pppg++ <--> Eth10G <--> pgw2DC1.pppg++;
        DC1.pppg++ <--> Eth10G <--> pgw3DC1.pppg++;
        pgw2DC1.filterGate <--> Eth10G <--> router.pppg++;
        pgw3DC1.filterGate <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw1DC1.filterGate;

        router2.pppg++ <--> Eth10G <--> DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw1DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw2DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw3DC2.pppg++;
        pgw1DC2.filterGate <--> Eth10G <--> router.pppg++;
        pgw2DC2.filterGate <--> Eth10G <--> router.pppg++;
        pgw3DC2.filterGate <--> Eth10G <--> router.pppg++;

        eNodeB1.ppp <--> Eth10G <--> router1.pppg++;
        router1.pppg++ <--> Eth10G <--> eNodeB2.ppp;
        eNodeB3.ppp <--> Eth10G <--> router1.pppg++;
        eNodeB4.ppp <--> Eth10G <--> router1.pppg++;
        eNodeB5.ppp <--> Eth10G <--> router3.pppg++;
        router2.pppg++ <--> Eth10G <--> router1.pppg++;
        router3.pppg++ <--> Eth10G <--> router4.pppg++;
        router4.pppg++ <--> Eth10G <--> router2.pppg++;
}
