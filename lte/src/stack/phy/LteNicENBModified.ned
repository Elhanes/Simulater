// 
//                           SimuLTE
// 
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself, 
// and cannot be removed from it.
// 


package lte.stack.phy;

import inet.linklayer.contract.IWirelessNic;
import lte.stack.mac.LteMac;
import lte.stack.pdcp_rrc.LtePdcpRrc;
import lte.stack.phy.feedback.LteDlFeedbackGenerator;
import lte.stack.rlc.LteRlc;
import lte.corenetwork.lteip.IP2lte;
import lte.x2.LteX2Manager;
import lte.stack.compManager.LteCompManager;
import lte.stack.d2dModeSelection.D2DModeSelection;
import lte.stack.handoverManager.LteHandoverManager;


// 
// Interface for the LTE Stack.
//

moduleinterface ILteNic2 extends IWirelessNic
{
    string nodeType;
    bool d2dCapable;            // inherit the value from the parent module
    gates:
        inout EUTRAN_RRC_Sap;   // Control of RRC Layer

}

// 
// Base module for the LTE Stack.
//
// TODO: implement IWirelessNic
module LteNicENBModified like ILteNic2
{
    parameters:
        @display("i=block/ifcard;bgb=250,444;bgl=3");
        string interfaceTableModule;
        string LtePdcpRrcType;      // One of: "LtePdcpRrcUe", "LtePdcpRrcEnb", "LtePdcpRrcRelayUe", "LtePdcpRrcRelayEnb"
        string LteMacType;          // One of: "LteMacUe", "LteMacEnb", "LteMacEnbExperimental", "LteMacRelayUe", "LteMacRelayEnb"
        string LtePhyType;
        string nodeType;
        bool d2dCapable;            // inherit the value from the parent module
        LtePdcpRrcType = "LtePdcpRrcEnb";
        LteMacType = default("LteMacEnbRealistic");
        LtePhyType = "LtePhyEnb";
        bool compEnabled = default(false);
        string LteCompManagerType = default("LteCompManagerProportional");

    gates:
        //#
        //# Gates connecting UE/eNB and LTE Stack
        //#
        //# Control Ports
        inout EUTRAN_RRC_Sap;   // Control of RRC Layer
        input upperLayerIn;
        output upperLayerOut;
        input radioIn @loose;  // to receive messages sent using sendDirect()


    submodules:
        // bridge between lte stack and network layer
        ip2lte: IP2lte {
            nodeType = nodeType;
            interfaceTableModule = interfaceTableModule;
            @display("p=150,68");
        }
        // PDCP-RRC Layer
        pdcpRrc: <LtePdcpRrcType> like LtePdcpRrc {
            @display("p=150,142");
        }
        // RLC Layer
        rlc: LteRlc {
            @display("p=150,227");
            d2dCapable = d2dCapable;
        }
        // MAC Layer
        mac: <LteMacType> like LteMac {
            interfaceTableModule = interfaceTableModule;
            @display("p=151,315");
        }
        // LtePhy submodule
        phy: <LtePhyType> like LtePhy {
            @display("p=151,390");
            @class(LtePhyType);
        }

    connections:
        ip2lte.stackLte <--> pdcpRrc.DataPort;

        //#
        //# Internal LTE Stack Connections 
        //# 

        EUTRAN_RRC_Sap <--> pdcpRrc.EUTRAN_RRC_Sap;

        //# PDCP <-> RLC
        pdcpRrc.UM_Sap <--> rlc.UM_Sap;
        pdcpRrc.AM_Sap <--> rlc.AM_Sap;
        pdcpRrc.TM_Sap <--> rlc.TM_Sap;

        //# RLC <-> MAC
        rlc.RLC_to_MAC --> mac.RLC_to_MAC;
        rlc.MAC_to_RLC <-- mac.MAC_to_RLC;

        //#
        //# Connections from LTE Stack to radio interface
        //#
        mac.MAC_to_PHY --> phy.upperGateIn;
        mac.PHY_to_MAC <-- phy.upperGateOut;

        //# external: lower connection
        radioIn --> phy.radioIn;
        ip2lte.upperLayerOut --> upperLayerOut;
        upperLayerIn --> ip2lte.upperLayerIn;
                //# connections between X2 Manager and its users
}

