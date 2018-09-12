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
import inet.node.inet.StandardHost;
import lte.corenetwork.binder.LteBinder;
import lte.corenetwork.nodes.Ue;
import lte.corenetwork.nodes.eNodeB;
import lte.world.radio.LteChannelControl;
import lte.epc.PgwStandardSimplified;


network SingleCell2
{
    parameters:
        int numUe = default(1);
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
            @display("p=215.16875,111.9375;is=n;i=device/server");
        }
        router: Router {
            @display("p=324.61874,130.59375;i=device/smallrouter");
        }
        pgw: PgwStandardSimplified {
            nodeType = "PGW";
            @display("p=677.84375,78.35625;is=l");
        }
        eNodeB: eNodeB {
            @display("p=444.01874,406.70624;is=vl");
        }
        ue[numUe]: Ue {
            @display("p=783,278");
        }
        router1: Router {
            @display("p=444.01874,233.825");
        }
        router2: Router {
            @display("p=615.65625,253.72499");
        }
        router3: Router {
            @display("p=354.46875,297.25626");
        }
        router4: Router {
            @display("p=182.83125,277.35626");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;
        router1.pppg++ <--> Eth10G <--> eNodeB.ppp;
        router1.pppg++ <--> Eth10G <--> pgw.pppg++;
        eNodeB.x2++ <--> Eth10G <--> router2.pppg++;
        router2.pppg++ <--> Eth10G <--> pgw.pppg++;
        router2.pppg++ <--> Eth10G <--> router1.pppg++;
        router3.pppg++ <--> Eth10G <--> router4.pppg++;
        eNodeB.x2++ <--> router4.pppg++;
        eNodeB.x2++ <--> router3.pppg++;
        router3.pppg++ <--> router1.pppg++;
        router4.pppg++ <--> router1.pppg++;
}
