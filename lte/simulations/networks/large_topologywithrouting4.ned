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
network large_topologywithrouting4
{
    parameters:
        int numUe = default(1);
        @display("i=block/network2;bgb=3877.5425,2586.2686;bgi=background/budapest");


    submodules:
        channelControl: LteChannelControl {
            @display("p=3137.0137,1447.5662;is=vl");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=3137.0137,1499.6637;is=s");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=3137.0137,1548.0399");
            config = xmldoc("demo.xml");
        }
        controller: controller {
            @display("p=3137.6357,1777.389");
        }

        binder: LteBinder {
            @display("p=3137.0137,1596.4161;is=s");
        }
        server: StandardHost {
            @display("p=772.554,81.69;is=n;i=device/server");
        }
        router: Router {
            @display("p=772.554,154.044;i=device/smallrouter");
        }
        pgw1DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1909.7864,2109.2893;is=l");
        }
        pgwbinder2: PgwBinder2 {
            @display("p=3137.0137,1376.8624;is=s");
        }
        DC1: DC_Router {
            @display("p=1993.2148,2210.8542");
        }
        pgw2DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1984.1466,2109.2893;is=l");
        }
        pgw3DC1: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2024.0471,2109.2893;is=l");
        }
        upperrouter1: Router {
            @display("p=1949.687,2029.4882");
        }
        upper2router1: Router {
            @display("p=1029.2941,252.072");
        }
        router2: Router {
            @display("p=774.888,774.888");
        }
        router3: Router {
            @display("p=954.606,641.85004");
        }
        router4: Router {
            @display("p=683.7507,983.00494");
        }
        router6: Router {
            @display("p=1113.5886,1548.8676");
        }
        eNodeB2: eNB_UEset3 {
            @display("p=427.122,686.19604");
        }
        eNodeB1: eNB_UEset3 {
            @display("p=235.7761,983.00494");
        }
        ue1[numUe]: Ue2 {
            @display("p=462.13202,1145.994");
        }
        ue2[numUe]: Ue2 {
            @display("p=298.752,686.19604");
        }
        eNodeB3: eNB_UEset3 {
            @display("p=1135.3525,1777.389");
        }
        ue3[numUe]: Ue2 {
            @display("p=1382.0106,1817.2897");
        }
        router8: Router {
            @display("p=1523.1135,582.36694");
        }
        router9: Router {
            @display("p=1786.4574,1479.9485");
        }
        router10: Router {
            @display("p=2156.4446,857.86224");
        }
        eNodeB5: eNB_UEset3 {
            @display("p=1492.4626,346.59085");
        }
        eNodeB4: eNB_UEset3 {
            @display("p=1360.2468,298.55673");
        }
        ue4[numUe]: Ue2 {
            @display("p=1305.8369,194.06186");
        }
        ue5[numUe]: Ue2 {
            @display("p=1659.8636,325.371");
        }
        router1: Router {
            @display("p=1787.1827,653.0998");
        }
        router7: Router {
            @display("p=2102.0347,1160.7439");
        }
        router11: Router {
            @display("p=1581.5135,1568.8179");
        }
        router12: Router {
            @display("p=825.2164,1499.8987");
        }
        router13: Router {
            @display("p=687.378,1244.1724");
        }
        pgw2DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=330.08655,1429.1659;is=l");
        }
        upperrouter2: Router {
            @display("p=279.304,1666.7556");
        }
        pgw1DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=255.72638,1429.1659;is=l");
        }
        DC2: DC_Router {
            @display("p=330.08655,1336.6691");
        }
        pgw3DC2: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=369.98712,1429.1659;is=l");
        }
        DC3: DC_Router {
            @display("p=1735.6748,1614.1594");
        }
        upperrouter3: Router {
            @display("p=1712.0972,1891.6498");
        }
        pgw3DC3: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1826.3579,1719.3518;is=l");
        }
        pgw2DC3: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1786.4574,1719.3518;is=l");
        }
        pgw1DC3: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1712.0972,1719.3518;is=l");
        }
        DC4: DC_Router {
            @display("p=2180.022,1356.6194");
        }
        pgw2DC4: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2230.8047,1461.8118;is=l");
        }
        upperrouter4: Router {
            @display("p=2156.4446,1634.1097");
        }
        pgw3DC4: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2270.705,1461.8118;is=l");
        }
        pgw1DC4: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2156.4446,1461.8118;is=l");
        }
        upper2router2: Router {
            @display("p=573.1173,2071.2024");
        }
        eNodeB6: eNB_UEset3 {
            @display("p=834.28467,1701.2152");
        }
        ue6[numUe]: Ue2 {
            @display("p=885.0672,1799.153");
        }
        eNodeB7: eNB_UEset3 {
            @display("p=1478.1348,1706.6562");
        }
        ue7[numUe]: Ue2 {
            @display("p=1545.2402,1819.1033");
        }
        eNodeB8: eNB_UEset3 {
            @display("p=1956.9417,1559.7496");
        }
        ue8[numUe]: Ue2 {
            @display("p=1991.4012,1761.066");
        }
        eNodeB9: eNB_UEset3 {
            @display("p=2138.3079,442.5336");
        }
        ue9[numUe]: Ue2 {
            @display("p=2232.6184,369.98712");
        }
        pgw2DC5: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1956.9417,355.4778;is=l");
        }
        upperrouter5: Router {
            @display("p=2029.4882,215.82582");
        }
        DC5: DC_Router {
            @display("p=1849.9355,545.91235");
        }
        pgw1DC5: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1882.5814,355.4778;is=l");
        }
        pgw3DC5: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=1995.0286,355.4778;is=l");
        }
        pgw2DC6: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2417.6118,1213.3401;is=l");
        }
        upperrouter6: Router {
            @display("p=2343.2517,1385.638");
        }
        DC6: DC_Router {
            @display("p=2365.0156,1108.1477");
        }
        pgw1DC6: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2343.2517,1213.3401;is=l");
        }
        pgw3DC6: PgwStandardSimplified2 {
            nodeType = "PGW";
            @display("p=2455.6987,1213.3401;is=l");
        }
        eNodeB10: eNB_UEset3 {
            @display("p=482.43417,569.49");
        }
        ue10[numUe]: Ue2 {
            @display("p=328.2729,569.49");
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

        router2.pppg++ <--> Eth10G <--> router3.pppg++;
        router2.pppg++ <--> Eth10G <--> router4.pppg++;
        router4.pppg++ <--> Eth10G <--> router6.pppg++;
        router7.pppg++ <--> Eth10G <--> DC1.pppg++;
        eNodeB2.ppp <--> Eth10G <--> router2.pppg++;
        eNodeB1.ppp <--> Eth10G <--> router4.pppg++;
        eNodeB3.ppp <--> Eth10G <--> router6.pppg++;
        router3.pppg++ <--> Eth10G <--> router8.pppg++;
        router6.pppg++ <--> Eth10G <--> router9.pppg++;
        router9.pppg++ <--> Eth10G <--> router10.pppg++;
        router10.pppg++ <--> Eth10G <--> router8.pppg++;
        router8.pppg++ <--> Eth10G <--> eNodeB4.ppp;
        router8.pppg++ <--> Eth10G <--> eNodeB5.ppp;
        router3.pppg++ <--> Eth10G <--> router10.pppg++;
        router4.pppg++ <--> Eth10G <--> router10.pppg++;
        router6.pppg++ <--> Eth10G <--> router10.pppg++;
        router4.pppg++ <--> Eth10G <--> router3.pppg++;
        router6.pppg++ <--> Eth10G <--> router3.pppg++;
        router6.pppg++ <--> Eth10G <--> router8.pppg++;
        router2.pppg++ <--> Eth10G <--> router8.pppg++;
        router2.pppg++ <--> Eth10G <--> router10.pppg++;
        router2.pppg++ <--> Eth10G <--> router9.pppg++;
        router2.pppg++ <--> Eth10G <--> router6.pppg++;
        router3.pppg++ <--> Eth10G <--> router9.pppg++;
        router8.pppg++ <--> Eth10G <--> router4.pppg++;
        router8.pppg++ <--> Eth10G <--> router9.pppg++;
        router9.pppg++ <--> Eth10G <--> router4.pppg++;
        router1.pppg++ <--> Eth10G <--> router8.pppg++;
        router1.pppg++ <--> Eth10G <--> router10.pppg++;
        router1.pppg++ <--> Eth10G <--> router7.pppg++;
        router1.pppg++ <--> Eth10G <--> router9.pppg++;
        router1.pppg++ <--> Eth10G <--> router6.pppg++;
        router1.pppg++ <--> Eth10G <--> router12.pppg++;
        router1.pppg++ <--> Eth10G <--> router13.pppg++;
        router1.pppg++ <--> Eth10G <--> router4.pppg++;
        router1.pppg++ <--> Eth10G <--> router2.pppg++;
        router1.pppg++ <--> Eth10G <--> router3.pppg++;
        router1.pppg++ <--> Eth10G <--> router11.pppg++;
        router10.pppg++ <--> Eth10G <--> router7.pppg++;
        router7.pppg++ <--> Eth10G <--> router9.pppg++;
        router7.pppg++ <--> Eth10G <--> router8.pppg++;
        router7.pppg++ <--> Eth10G <--> router3.pppg++;
        router7.pppg++ <--> Eth10G <--> router2.pppg++;
        router7.pppg++ <--> Eth10G <--> router4.pppg++;
        router7.pppg++ <--> Eth10G <--> router13.pppg++;
        router7.pppg++ <--> Eth10G <--> router12.pppg++;
        router7.pppg++ <--> Eth10G <--> router6.pppg++;
        router7.pppg++ <--> Eth10G <--> router11.pppg++;
        router11.pppg++ <--> Eth10G <--> router8.pppg++;
        router11.pppg++ <--> Eth10G <--> router3.pppg++;
        router11.pppg++ <--> Eth10G <--> router2.pppg++;
        router11.pppg++ <--> Eth10G <--> router4.pppg++;
        router11.pppg++ <--> Eth10G <--> router13.pppg++;
        router11.pppg++ <--> Eth10G <--> router12.pppg++;
        router11.pppg++ <--> Eth10G <--> router6.pppg++;
        router11.pppg++ <--> Eth10G <--> router9.pppg++;
        router11.pppg++ <--> Eth10G <--> router7.pppg++;
        router12.pppg++ <--> Eth10G <--> router6.pppg++;
        router12.pppg++ <--> Eth10G <--> router8.pppg++;
        router12.pppg++ <--> Eth10G <--> router13.pppg++;
        router12.pppg++ <--> Eth10G <--> router4.pppg++;
        router13.pppg++ <--> Eth10G <--> router4.pppg++;
        router13.pppg++ <--> Eth10G <--> router3.pppg++;
        router13.pppg++ <--> Eth10G <--> router8.pppg++;
        router13.pppg++ <--> Eth10G <--> router2.pppg++;
        router13.pppg++ <--> Eth10G <--> router6.pppg++;
        //dc1_begin
        DC2.pppg++ <--> Eth10G <--> pgw1DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw2DC2.pppg++;
        DC2.pppg++ <--> Eth10G <--> pgw3DC2.pppg++;
        pgw1DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        pgw2DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        pgw3DC2.filterGate <--> Eth10G <--> upperrouter2.pppg++;
        //dc1_end

        DC2.pppg++ <--> Eth10G <--> router13.pppg++;
        //dc1_begin
        DC3.pppg++ <--> Eth10G <--> pgw1DC3.pppg++;
        DC3.pppg++ <--> Eth10G <--> pgw2DC3.pppg++;
        DC3.pppg++ <--> Eth10G <--> pgw3DC3.pppg++;
        pgw1DC3.filterGate <--> Eth10G <--> upperrouter3.pppg++;
        pgw2DC3.filterGate <--> Eth10G <--> upperrouter3.pppg++;
        pgw3DC3.filterGate <--> Eth10G <--> upperrouter3.pppg++;
        //dc1_end

        DC3.pppg++ <--> Eth10G <--> router11.pppg++;
        //dc1_begin
        DC4.pppg++ <--> Eth10G <--> pgw1DC4.pppg++;
        DC4.pppg++ <--> Eth10G <--> pgw2DC4.pppg++;
        DC4.pppg++ <--> Eth10G <--> pgw3DC4.pppg++;
        pgw1DC4.filterGate <--> Eth10G <--> upperrouter4.pppg++;
        pgw2DC4.filterGate <--> Eth10G <--> upperrouter4.pppg++;
        pgw3DC4.filterGate <--> Eth10G <--> upperrouter4.pppg++;
        //dc1_end

        DC4.pppg++ <--> Eth10G <--> router3.pppg++;
        upperrouter3.pppg++ <--> Eth10G <--> upper2router2.pppg++;
        upperrouter4.pppg++ <--> Eth10G <--> upper2router2.pppg++;
        upperrouter2.pppg++ <--> Eth10G <--> upper2router2.pppg++;
        upper2router2.pppg++ <--> Eth10G <--> upper2router1.pppg++;
        router10.pppg++ <--> Eth10G <--> eNodeB9.ppp;
        router9.pppg++ <--> Eth10G <--> eNodeB8.ppp;
        eNodeB7.ppp <--> Eth10G <--> router11.pppg++;
        eNodeB6.ppp <--> Eth10G <--> router12.pppg++;
        router3.pppg++ <--> Eth10G <--> router12.pppg++;
        router2.pppg++ <--> Eth10G <--> router12.pppg++;
        router13.pppg++ <--> Eth10G <--> router10.pppg++;
        router13.pppg++ <--> Eth10G <--> router9.pppg++;
        router12.pppg++ <--> Eth10G <--> router10.pppg++;
        router12.pppg++ <--> Eth10G <--> router9.pppg++;
        router11.pppg++ <--> Eth10G <--> router10.pppg++;
        //dc1_begin
        DC5.pppg++ <--> Eth10G <--> pgw1DC5.pppg++;
        DC5.pppg++ <--> Eth10G <--> pgw2DC5.pppg++;
        DC5.pppg++ <--> Eth10G <--> pgw3DC5.pppg++;
        pgw1DC5.filterGate <--> Eth10G <--> upperrouter5.pppg++;
        pgw2DC5.filterGate <--> Eth10G <--> upperrouter5.pppg++;
        pgw3DC5.filterGate <--> Eth10G <--> upperrouter5.pppg++;
        //dc1_end

        router3.pppg++ <--> Eth10G <--> DC5.pppg++;
        upperrouter5.pppg++ <--> Eth10G <--> upper2router1.pppg++;
        //dc1_begin
        DC6.pppg++ <--> Eth10G <--> pgw1DC6.pppg++;
        DC6.pppg++ <--> Eth10G <--> pgw2DC6.pppg++;
        DC6.pppg++ <--> Eth10G <--> pgw3DC6.pppg++;
        pgw1DC6.filterGate <--> Eth10G <--> upperrouter6.pppg++;
        pgw2DC6.filterGate <--> Eth10G <--> upperrouter6.pppg++;
        pgw3DC6.filterGate <--> Eth10G <--> upperrouter6.pppg++;
        //dc1_end

        DC6.pppg++ <--> Eth10G <--> router7.pppg++;
        upperrouter6.pppg++ <--> Eth10G <--> upper2router2.pppg++;
        eNodeB10.ppp <--> Eth10G <--> router2.pppg++;
}
