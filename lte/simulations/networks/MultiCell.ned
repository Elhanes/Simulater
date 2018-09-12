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
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import lte.corenetwork.binder.LteBinder;
import lte.corenetwork.nodes.Ue;
import lte.corenetwork.nodes.eNodeB;
import lte.corenetwork.nodes.ExtCell;
import lte.epc.PgwStandardSimplified;
import lte.world.radio.LteChannelControl;


network MultiCell
{
    parameters:
        int numExtCells = default(0);
        @display("i=block/network2;bgb=991,558;bgi=background/budapest");
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
            @display("p=212,118;is=n;i=device/server");
        }
        pgw: PgwStandardSimplified {
            nodeType = "PGW";
            @display("p=172,287;is=l");
        }
        router: Router {
            @display("p=321,136;i=device/smallrouter");
        }
        eNodeB1: eNodeB {
            @display("p=465.1625,136.8125;is=vl");
        }
        eNodeB2: eNodeB {
            @display("p=760,125;is=vl");
        }
        ue11: Ue {
            @display("p=275,289");
        }
        ue12: Ue {
            @display("p=477,363");
        }
        ue21: Ue {
            @display("p=789,280");
        }
        ue22: Ue {
            @display("p=915,183");
        }
        extCell[numExtCells]: ExtCell {
            @display("p=100,480;is=vl");
        }
        router1: Router {
            @display("p=399.24374,259.94376");
        }
        router2: Router {
            @display("p=227.60625,478.84375");
        }
        router3: Router {
            @display("p=598.2438,298.5");
        }
        eNodeB3: eNodeB {
            @display("p=723.8625,406.70624;is=vl");
        }
        ue31: Ue {
            @display("p=813.4125,490.0375");
        }
        ue32: Ue {
            @display("p=939.03125,393.025");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;
        router1.pppg++ <--> Eth10G <--> eNodeB1.ppp;
        router1.pppg++ <--> Eth10G <--> eNodeB2.ppp;

        //# X2 connections
        eNodeB1.x2++ <--> Eth10G <--> eNodeB2.x2++;
        router2.pppg++ <--> Eth10G <--> pgw.pppg++;
        router1.pppg++ <--> Eth10G <--> router2.pppg++;
        router3.pppg++ <--> Eth10G <--> router1.pppg++;
        eNodeB3.ppp <-->  Eth10G <--> router3.pppg++;
}
