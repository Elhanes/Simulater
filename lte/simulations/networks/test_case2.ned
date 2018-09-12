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
import lte.epc.PgwStandardSimplified;
import lte.world.radio.LteChannelControl;
import lte.epc.PgwStandardSimplified2;
import lte.corenetwork.binder.PgwBinder2;
import lte.corenetwork.binder.controller;

network test_case2
{
    parameters:
        int numUe = default(1);
        @display("i=block/network2;bgb=9892.152,5911.164;bgi=background/budapest");



    submodules:
        channelControl: LteChannelControl {
            @display("p=9153.8,4626.38;is=vl");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=9153.8,3377.01;is=s");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=8498.19,3970.77");
            config = xmldoc("demo.xml");
        }
        controller: controller {
            @display("p=9153.8,5479.91");
        }

        binder: LteBinder {
            @display("p=9153.8,3970.77;is=s");
        }
        pgwbinder2: PgwBinder2 {
            @display("p=9153.8,4972.7397;is=s");
        }
        server: StandardHost {
            @display("p=2115.27,903.01;is=n;i=device/server");
        }
        router2: Router {
            @display("p=5628.35,383.47");
        }
        PGW1DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=5319.1,903.01;is=l");
        }
        PGW2DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=5628.35,903.01;is=l");
        }
        PGW3DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=5962.34,903.01;is=l");
        }
        DC1: DC_Router {
            @display("p=5838.64,1694.69");
        }
        router3: Router {
            @display("p=4688.23,2016.3099");
        }
        eNodeB1: eNB_UEset3 {
            @display("p=4799.56,1175.15");
        }
        ue1[numUe]: Ue2 {
            @display("p=5034.59,1026.71");
        }
        eNodeB2: eNB_UEset3 {
            @display("p=1583.36,3475.97");
        }
        ue2[numUe]: Ue2 {
            @display("p=1187.52,3587.3");
        }
        eNodeB3: eNB_UEset3 {
            @display("p=3673.89,4675.86");
        }
        ue3[numUe]: Ue2 {
            @display("p=4069.73,4861.41");
        }
        router4: Router {
            @display("p=5257.25,2350.3");
        }
        router5: Router {
            @display("p=2016.3099,3067.76");
        }
        router6: Router {
            @display("p=3673.89,4143.95");
        }
        DC2: DC_Router {
            @display("p=7582.81,3673.89");
        }
        PGW1DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=7310.67,2956.43;is=l");
        }
        PGW2DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=7619.92,2956.43;is=l");
        }
        PGW3DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=7953.91,2956.43;is=l");
        }
        router7: Router {
            @display("p=7446.7397,2449.26");
        }
        router8: Router {
            @display("p=3005.91,2164.75");
        }

        router9: Router {
            @display("p=2263.71,3537.82");
        }
        router10: Router {
            @display("p=2375.04,2585.33");
        }
        router11: Router {
            @display("p=3129.61,2721.4");
        }
        router12: Router {
            @display("p=2857.47,3970.77");
        }
        router13: Router {
            @display("p=3779.9282,2171.448");
        }
        router14: Router {
            @display("p=4465.57,4057.3599");
        }
        router15: Router {
            @display("p=5987.08,2585.33");
        }
        router16: Router {
            @display("p=5838.64,3265.68");
        }
        eNodeB4: eNB_UEset3 {
            @display("p=1422.55,2511.11");
        }
        ue4[numUe]: Ue2 {
            @display("p=1187.52,2350.3");
        }
        eNodeB5: eNB_UEset3 {
            @display("p=1917.35,2065.79");
        }
        ue5[numUe]: Ue2 {
            @display("p=1707.0599,1781.28");
        }
        router17: Router {
            @display("p=4539.79,2511.11");
        }
        router18: Router {
            @display("p=4539.79,2993.54");
        }
        router19: Router {
            @display("p=3753.12,3002.496");
        }
        router20: Router {
            @display("p=5257.25,2894.58");
        }
        router21: Router {
            @display("p=5039.9043,3538.656");
        }
        router22: Router {
            @display("p=4155.24,3686.1");
        }
        router23: Router {
            @display("p=3270.5762,3592.2722");
        }
        router24: Router {
            @display("p=2747.82,3270.5762");
        }
        router25: Router {
            @display("p=5504.65,3772.85");
        }
        DC3: DC_Router {
            @display("p=1373.07,5232.51");
        }
        PGW1DC3: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1051.45,4663.4897;is=l");
        }
        PGW2DC3: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1373.07,4663.4897;is=l");
        }
        PGW3DC3: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1694.69,4663.4897;is=l");
        }
        router26: Router {
            @display("p=1274.11,3970.77");
        }
        eNodeB6: eNB_UEset3 {
            @display("p=2597.7,4527.42");
        }
        ue6[numUe]: Ue2 {
            @display("p=2807.99,4886.15");
        }
        eNodeB7: eNB_UEset3 {
            @display("p=4539.79,4651.12");
        }
        ue7[numUe]: Ue2 {
            @display("p=5034.59,5022.22");
        }
        DC4: DC_Router {
            @display("p=5987.08,5319.1");
        }
        PGW1DC4: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=5900.4897,4502.68;is=l");
        }
        PGW2DC4: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=6222.11,4502.68;is=l");
        }
        PGW3DC4: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=6543.73,4502.68;is=l");
        }
        router27: Router {
            @display("p=6123.15,4057.3599");
        }
        eNodeB8: eNB_UEset3 {
            @display("p=5578.87,4378.98");
        }
        ue8[numUe]: Ue2 {
            @display("p=5838.64,4675.86");
        }
        eNodeB9: eNB_UEset3 {
            @display("p=5875.75,2115.27");
        }
        ue9[numUe]: Ue2 {
            @display("p=6123.15,1929.72");
        }
        eNodeB10: eNB_UEset3 {
            @display("p=4230.54,1348.33");
        }
        ue10[numUe]: Ue2 {
            @display("p=3908.92,1261.74");
        }
        DC5: DC_Router {
            @display("p=6617.95,2832.73");
        }
        PGW1DC5: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=6543.73,2016.3099;is=l");
        }
        PGW2DC5: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=6852.98,2016.3099;is=l");
        }
        PGW3DC5: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=7186.9697,2016.3099;is=l");
        }
        router28: Router {
            @display("p=6865.35,1496.77");
        }
        DC6: DC_Router {
            @display("p=7100.38,5022.22");
        }
        PGW1DC6: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=6605.58,3822.33;is=l");
        }
        PGW2DC6: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=6927.2,3822.33;is=l");
        }
        PGW3DC6: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=7310.67,3822.33;is=l");
        }
        router29: Router {
            @display("p=6617.95,3302.79");
        }
        router31: Router {
            @display("p=5170.66,1781.28");
        }
        router32: Router {
            @display("p=5034.59,4527.42");
        }
        router33: Router {
            @display("p=6308.7,3673.89");
        }
    connections:
        eNodeB1.ppp <--> Eth10G <--> router3.pppg++;
        eNodeB2.ppp <--> Eth10G <--> router5.pppg++;
        eNodeB3.ppp <--> Eth10G <--> router6.pppg++;

        router2.pppg++ <--> Eth10G <--> server.pppg++;
        PGW1DC1.filterGate <--> Eth10G <--> router2.pppg++;
        PGW2DC1.filterGate <--> Eth10G <--> router2.pppg++;
        PGW3DC1.filterGate <--> Eth10G <--> router2.pppg++;
        DC1.pppg++ <--> Eth10G <--> PGW1DC1.pppg++;
        DC1.pppg++ <--> Eth10G <--> PGW2DC1.pppg++;
        DC1.pppg++ <--> Eth10G <--> PGW3DC1.pppg++;
        DC1.pppg++ <--> Eth10G <--> router31.pppg++;

        PGW1DC2.filterGate <--> Eth10G <--> router7.pppg++;
        PGW2DC2.filterGate <--> Eth10G <--> router7.pppg++;
        PGW3DC2.filterGate <--> Eth10G <--> router7.pppg++;
        DC2.pppg++ <--> Eth10G <--> PGW1DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> PGW2DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> PGW3DC2.pppg++;
        router15.pppg++ <--> Eth10G <--> router4.pppg++;

        router5.pppg++ <--> Eth10G <--> router9.pppg++;
        router10.pppg++ <--> Eth10G <--> router5.pppg++;
        router6.pppg++ <--> Eth10G <--> router14.pppg++;
        router8.pppg++ <--> Eth10G <--> router10.pppg++;
        server.pppg++ <--> Eth10G <--> router7.pppg++;
        router13.pppg++ <--> Eth10G <--> router11.pppg++;
        router6.pppg++ <--> Eth10G <--> router12.pppg++;
        router3.pppg++ <--> Eth10G <--> router4.pppg++;
        router3.pppg++ <--> Eth10G <--> router13.pppg++;
        router3.pppg++ <--> Eth10G <--> router8.pppg++;
        router33.pppg++ <--> Eth10G <--> DC2.pppg++;
        router12.pppg++ <--> Eth10G <--> router9.pppg++;
        router15.pppg++ <--> Eth10G <--> router16.pppg++;
        router16.pppg++ <--> Eth10G <--> router25.pppg++;
        router10.pppg++ <--> Eth10G <--> eNodeB4.ppp;
        router10.pppg++ <--> Eth10G <--> eNodeB5.ppp;
        router5.pppg++ <--> Eth10G <--> router11.pppg++;
        router11.pppg++ <--> Eth10G <--> router10.pppg++;
        router11.pppg++ <--> Eth10G <--> router8.pppg++;
        router13.pppg++ <--> Eth10G <--> router8.pppg++;
        router13.pppg++ <--> Eth10G <--> router17.pppg++;
        router17.pppg++ <--> Eth10G <--> router4.pppg++;
        router17.pppg++ <--> Eth10G <--> router18.pppg++;
        router18.pppg++ <--> Eth10G <--> router13.pppg++;
        router11.pppg++ <--> Eth10G <--> router19.pppg++;
        router19.pppg++ <--> Eth10G <--> router18.pppg++;
        router18.pppg++ <--> Eth10G <--> router20.pppg++;
        router20.pppg++ <--> Eth10G <--> router15.pppg++;
        router9.pppg++ <--> Eth10G <--> router24.pppg++;
        router24.pppg++ <--> Eth10G <--> router23.pppg++;
        router23.pppg++ <--> Eth10G <--> router12.pppg++;
        router23.pppg++ <--> Eth10G <--> router22.pppg++;
        router22.pppg++ <--> Eth10G <--> router6.pppg++;
        router22.pppg++ <--> Eth10G <--> router14.pppg++;
        router22.pppg++ <--> Eth10G <--> router21.pppg++;
        router21.pppg++ <--> Eth10G <--> router16.pppg++;
        router25.pppg++ <--> Eth10G <--> router14.pppg++;
        router20.pppg++ <--> Eth10G <--> router21.pppg++;
        router24.pppg++ <--> Eth10G <--> router19.pppg++;
        router19.pppg++ <--> Eth10G <--> router22.pppg++;
        PGW1DC3.filterGate <--> Eth10G <--> router26.pppg++;
        PGW2DC3.filterGate <--> Eth10G <--> router26.pppg++;
        DC3.pppg++ <--> Eth10G <--> PGW1DC3.pppg++;
        DC3.pppg++ <--> Eth10G <--> PGW2DC3.pppg++;
        DC3.pppg++ <--> Eth10G <--> PGW3DC3.pppg++;
        PGW3DC3.filterGate <--> Eth10G <--> router26.pppg++;
        DC3.pppg++ <--> Eth10G <--> router9.pppg++;
        router26.pppg++ <--> Eth10G <--> server.pppg++;
        router12.pppg++ <--> Eth10G <--> eNodeB6.ppp;
        router14.pppg++ <--> Eth10G <--> eNodeB7.ppp;
        PGW1DC4.filterGate <--> Eth10G <--> router27.pppg++;
        PGW2DC4.filterGate <--> Eth10G <--> router27.pppg++;
        DC4.pppg++ <--> Eth10G <--> PGW1DC4.pppg++;
        DC4.pppg++ <--> Eth10G <--> PGW2DC4.pppg++;
        DC4.pppg++ <--> Eth10G <--> PGW3DC4.pppg++;
        PGW3DC4.filterGate <--> Eth10G <--> router27.pppg++;
        router32.pppg++ <--> Eth10G <--> DC4.pppg++;
        router27.pppg++ <--> Eth10G <--> server.pppg++;
        router25.pppg++ <--> Eth10G <--> eNodeB8.ppp;
        router4.pppg++ <--> Eth10G <--> eNodeB9.ppp;
        router3.pppg++ <--> Eth10G <--> eNodeB10.ppp;
        PGW1DC5.filterGate <--> Eth10G <--> router28.pppg++;
        PGW2DC5.filterGate <--> Eth10G <--> router28.pppg++;
        DC5.pppg++ <--> Eth10G <--> PGW1DC5.pppg++;
        DC5.pppg++ <--> Eth10G <--> PGW2DC5.pppg++;
        DC5.pppg++ <--> Eth10G <--> PGW3DC5.pppg++;
        PGW3DC5.filterGate <--> Eth10G <--> router28.pppg++;
        router15.pppg++ <--> Eth10G <--> DC5.pppg++;
        router28.pppg++ <--> Eth10G <--> server.pppg++;
        PGW1DC6.filterGate <--> Eth10G <--> router29.pppg++;
        PGW2DC6.filterGate <--> Eth10G <--> router29.pppg++;
        PGW3DC6.filterGate <--> Eth10G <--> router29.pppg++;
        DC6.pppg++ <--> Eth10G <--> PGW1DC6.pppg++;
        DC6.pppg++ <--> Eth10G <--> PGW2DC6.pppg++;
        DC6.pppg++ <--> Eth10G <--> PGW3DC6.pppg++;
        DC6.pppg++ <--> Eth10G <--> router16.pppg++;
        router29.pppg++ <--> Eth10G <--> server.pppg++;
        router31.pppg++ <--> Eth10G <--> router3.pppg++;
        router32.pppg++ <--> Eth10G <--> router14.pppg++;
        router33.pppg++ <--> Eth10G <--> router25.pppg++;
        router16.pppg++ <--> Eth10G <--> router33.pppg++;
        router32.pppg++ <--> Eth10G <--> router25.pppg++;
        router4.pppg++ <--> Eth10G <--> router31.pppg++;
        router6.pppg++ <--> Eth10G <--> router23.pppg++;
}
