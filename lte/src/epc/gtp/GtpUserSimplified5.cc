//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#include "epc/gtp/GtpUserSimplified5.h"
#include "inet/networklayer/contract/ipv4/IPv4ControlInfo.h"
#include "inet/networklayer/common/L3AddressResolver.h"
#include "corenetwork/binder/UeSet.h"
#include "corenetwork/binder/eNBset.h"
#include <iostream>


Define_Module(GtpUserSimplified5);

void GtpUserSimplified5::initialize(int stage)
{
    cSimpleModule::initialize(stage);

    // wait until all the IP addresses are configured
    if (stage != inet::INITSTAGE_APPLICATION_LAYER)
        return;
    localPort_ = par("localPort");

    // get reference to the binder
    binder_ = getBinder();
    pgwbinder_= getPgwBinder2();

    socket_.setOutputGate(gate("udpOut"));
    socket_.bind(localPort_);

    tunnelPeerPort_ = par("tunnelPeerPort");

    // get the address of the PGW
    //pgwAddress_ = L3AddressResolver().resolve("pgw");
    //HAEIN: originally getting pgwaddress in this line in this way, but in my code the pgwaddress is assigned when the packet is coming.
    //see the handleFromTrafficFlowFilter(datagram);
    ownerType_ = selectOwnerType(getAncestorPar("nodeType"));
}

EpcNodeType GtpUserSimplified5::selectOwnerType(const char * type)
{
    EV << "GtpUserSimplified::selectOwnerType - setting owner type to " << type << endl;
    if(strcmp(type,"ENODEB") == 0)
        return ENB;
    else if(strcmp(type,"PGW") == 0)
        return PGW;

    error("GtpUserSimplified::selectOwnerType - unknown owner type [%s]. Aborting...",type);
}

void GtpUserSimplified5::handleMessage(cMessage *msg)
{
    if (strcmp(msg->getArrivalGate()->getFullName(), "trafficFlowFilterGate") == 0)
    {
        EV << "GtpUserSimplified::handleMessage - message from trafficFlowFilter" << endl;
        // obtain the encapsulated IPv4 datagram
        IPv4Datagram * datagram = check_and_cast<IPv4Datagram*>(msg);
        handleFromTrafficFlowFilter(datagram);
    }
    else if(strcmp(msg->getArrivalGate()->getFullName(),"udpIn")==0)
    {
        EV << "GtpUserSimplified::handleMessage - message from udp layer" << endl;

        GtpUserMsg * gtpMsg = check_and_cast<GtpUserMsg *>(msg);
        handleFromUdp(gtpMsg);
    }
}

void GtpUserSimplified5::handleFromTrafficFlowFilter(IPv4Datagram * datagram)
{
    //HAEIN: packet is coming from TrafficFlpwFilter means the packet is going server from UE (UL)
    //I only dealing with UL.

    // extract control info from the datagram
    TftControlInfo * tftInfo = check_and_cast<TftControlInfo *>(datagram->removeControlInfo());
    TrafficFlowTemplateId flowId = tftInfo->getTft();
    IPv4Address &srcAddress = datagram->getSrcAddress();
    delete (tftInfo);

    EV << "GtpUserSimplified::handleFromTrafficFlowFilter - Received a tftMessage with flowId[" << flowId << "]" << endl;

    // If we are on the eNB and the flowId represents the ID of this eNB, forward the packet locally
    if (flowId == 0)
    {
        // local delivery
        send(datagram,"pppGate");
    }
    else
    {
        // create a new GtpUserSimplifiedMessage
        GtpUserMsg * gtpMsg = new GtpUserMsg();
        gtpMsg->setName("GtpUserMessage");

        // encapsulate the datagram within the GtpUserSimplifiedMessage
        gtpMsg->encapsulate(datagram);

        L3Address tunnelPeerAddress;
        if (flowId == -1) // send to the PGW
        {

            //HAEIN: getting UeSet module in src UE.
            MacNodeId MacId=binder_->getMacNodeId(srcAddress);
            //HAEIN: original code can't find Modulename by macNodeID
            //so I register not only macNodeID to binder but also its name. If you want to see the code, plese see the UE2.nic.ip2lte.
            const char* uename=binder_->getModuleNameByMacNodeId(MacId);
            ueset* UE=check_and_cast<ueset*>(getSimulation()->getModuleByPath(uename)->getSubmodule("UeSet"));
            eNBset* eNB=check_and_cast<eNBset*>(getParentModule()->getSubmodule("eNBset"));
            //HAEIN: I modified below if and else.
            if(!(UE->ison()))
                {
                EV<< "Frame is dropped"<<endl;
                return;

                }
            if(UE->isaddress())
                {
                //If UEset has pgwaddress then just getting address from here. this is for preventing the UE and PGW connection to be changed without algorithm.
                pgwAddress_=UE->getpgwaddress();
                tunnelPeerAddress = pgwAddress_;
                EV<<"if is called"<<pgwAddress_;}
            else
            {
                //If UeSet has no pgwaddress assigning pgwaddress. below assignPgwAddress(datagram)function will put pgwAddress to UeSet.
            //pgwAddress_ = pgwbinder_->assignPgwAddress(datagram);
            pgwAddress_ = pgwbinder_->assignPgwAddress(datagram,eNB);

            tunnelPeerAddress = pgwAddress_;
            EV<<"else is called"<<pgwAddress_;
            }
        }
        else
        {
            // get the symbolic IP address of the tunnel destination ID
            // then obtain the address via IPvXAddressResolver
            const char* symbolicName = binder_->getModuleNameByMacNodeId(flowId);
            tunnelPeerAddress = L3AddressResolver().resolve(symbolicName);
        }
        socket_.sendTo(gtpMsg, tunnelPeerAddress, tunnelPeerPort_);
    }
}

void GtpUserSimplified5::handleFromUdp(GtpUserMsg * gtpMsg)
{
    EV << "GtpUserSimplified::handleFromUdp - Decapsulating and sending to local connection." << endl;

    // obtain the original IP datagram and send it to the local network
    IPv4Datagram * datagram = check_and_cast<IPv4Datagram*>(gtpMsg->decapsulate());
    delete(gtpMsg);

    if (ownerType_ == PGW)
    {
        IPv4Address& destAddr = datagram->getDestAddress();
        MacNodeId destId = binder_->getMacNodeId(destAddr);
        if (destId != 0)
        {
             // create a new GtpUserSimplifiedMessage
             GtpUserMsg * gtpMsg = new GtpUserMsg();
             gtpMsg->setName("GtpUserMessage");

             // encapsulate the datagram within the GtpUserSimplifiedMessage
             gtpMsg->encapsulate(datagram);

             MacNodeId destMaster = binder_->getNextHop(destId);
             const char* symbolicName = binder_->getModuleNameByMacNodeId(destMaster);
             L3Address tunnelPeerAddress = L3AddressResolver().resolve(symbolicName);
             socket_.sendTo(gtpMsg, tunnelPeerAddress, tunnelPeerPort_);
             return;
        }
    }

    // destination is outside the LTE network
    send(datagram,"pppGate");
}
