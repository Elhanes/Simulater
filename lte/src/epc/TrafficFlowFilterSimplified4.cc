//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#include "epc/TrafficFlowFilterSimplified4.h"
#include "inet/networklayer/contract/ipv4/IPv4ControlInfo.h"
#include "inet/networklayer/ipv4/IPv4Datagram.h"
#include "inet/networklayer/common/L3AddressResolver.h"

Define_Module(TrafficFlowFilterSimplified4);

void TrafficFlowFilterSimplified4::initialize(int stage)
{
    // wait until all the IP addresses are configured
    if (stage != inet::INITSTAGE_NETWORK_LAYER)
        return;

    // get reference to the binder
    binder_ = getBinder();

    fastForwarding_ = par("fastForwarding");

    // reading and setting owner type
    ownerType_ = selectOwnerType(par("ownerType"));
}

EpcNodeType TrafficFlowFilterSimplified4::selectOwnerType(const char * type)
{
    EV << "TrafficFlowFilterSimplified::selectOwnerType - setting owner type to " << type << endl;
    if(strcmp(type,"ENODEB") == 0)
        return ENB;
    else if(strcmp(type,"PGW") == 0)
        return PGW;

    error("TrafficFlowFilterSimplified::selectOwnerType - unknown owner type [%s]. Aborting...",type);
}

void TrafficFlowFilterSimplified4::handleMessage(cMessage *msg)
{
    EV << "TrafficFlowFilterSimplified::handleMessage - Received Packet:" << endl;
    EV << "name: " << msg->getFullName() << endl;

    // receive and read IP datagram
    IPv4Datagram * datagram = check_and_cast<IPv4Datagram *>(msg);
    IPv4Address &destAddr = datagram->getDestAddress();
    IPv4Address &srcAddr = datagram->getSrcAddress();
    EV<<"call register ue"<<endl;
    //mycode
    registerUE(srcAddr); //it would be erased

    // TODO check for source and dest port number

    EV << "TrafficFlowFilterSimplified::handleMessage - Received datagram : " << datagram->getName() << " - src[" << srcAddr << "] - dest[" << destAddr << "]\n";

    // run packet filter and associate a flowId to the connection (default bearer?)
    // search within tftTable the proper entry for this destination
    unsigned int tftId = findTrafficFlow(srcAddr, destAddr);   // search for the tftId in the binder
    if(tftId == UNSPECIFIED_TFT)
        error("TrafficFlowFilterSimplified::handleMessage - Cannot find corresponding tftId. Aborting...");

    // add control info to the normal ip datagram. This info will be read by the GTP-U application
    TftControlInfo * tftInfo = new TftControlInfo();
    tftInfo->setTft(tftId);
    datagram->setControlInfo(tftInfo);

    EV << "TrafficFlowFilterSimplified::handleMessage - setting tft=" << tftId << endl;

    // send the datagram to the GTP-U module
    //send(datagram,"gtpUserGateOut");

    //mycode
    /*MacNodeId checkingMacNodeId=checkingUE(srcAddr);
    std::map<L3Address, MacNodeId>::iterator it;
    int check=0;
    int gateindex=0;
    for(it=UEAddresstoMacNodeId_.begin();it!=UEAddresstoMacNodeId_.end();++it){
        if(checkingMacNodeId==it->second) gateindex=check;
            //sprintf(gatebuf,"gtpUserGateOut%d",check);
        check++;
    }
    */
    //if(checkingMacNodeId==UEAddresstoMacNodeId_(0))send(datagram,"gtpUserGateOut0");
    //else if(checkingMacNodeId==1) send(datagram,"gtpUserGateOut1");
    //send(datagram,"gtpUserGateOut",gateindex);
    //else send(datagram,"gtpUserGateOut1");
    send(datagram,"gtpUserGateOut");
}

TrafficFlowTemplateId TrafficFlowFilterSimplified4::findTrafficFlow(L3Address srcAddress, L3Address destAddress)
{
    MacNodeId destId = binder_->getMacNodeId(destAddress.toIPv4());
    if (destId == 0)
        return -1;   // the destination is outside the LTE network, so send the packet to the PGW

    MacNodeId destMaster = binder_->getNextHop(destId);

    if (ownerType_ == ENB)
    {
        MacNodeId srcMaster = binder_->getNextHop(binder_->getMacNodeId(srcAddress.toIPv4()));
        if (fastForwarding_ && srcMaster == destMaster)
            return 0;                 // local delivery
        return -1;   // send the packet to the PGW
    }

    return destMaster;
}

MacNodeId TrafficFlowFilterSimplified4::checkingUE(L3Address srcAddress){
    MacNodeId UeID = binder_->getMacNodeId(srcAddress.toIPv4());
    int check=0;
    for(int i=0;i<2;i++){
        if(UENodeID[i]==UeID){
               check=i;
        }
    }

    switch(check)
    {
    case 0:
        return 0;
    case 1:
    return 1;

    default:
        return 3;
    }
    std::map<L3Address, MacNodeId> ::iterator it;
    for(it=UEAddresstoMacNodeId_.begin();it!=UEAddresstoMacNodeId_.end();++it){
        if(it->first==srcAddress)
            return it->second;
    }
    return 0;



}
int TrafficFlowFilterSimplified4::registerUE(L3Address srcAddress){  //register UE to UENodeID UENodeID[0] is to gtpgate0, UENodeID[1] is to gtpgate
 // one UE should have One gtp tunnel so their are limit of UE number for each eNB so I have to progress more in this point Make restraint variable
    MacNodeId UeID = binder_->getMacNodeId(srcAddress.toIPv4());
    int check=0;
    for(int i=0;i<2;i++)
    {
        if(UENodeID[i]==0){
            UENodeID[i]=UeID;
            EV<<"UE ID is"<<UENodeID[i]<<"UE Address is"<<srcAddress.str()<<endl;
            check++;
            break;
        }
    }

    UEAddresstoMacNodeId_[srcAddress]=UeID;
    return check;
}
void TrafficFlowFilterSimplified4::refreshDisplay() const{
    char buf[100];
    int len=0;
    std::map<L3Address, MacNodeId>::const_iterator iter;
    int i=0;
    for(iter=UEAddresstoMacNodeId_.begin();iter!=UEAddresstoMacNodeId_.end();++iter){

        EV<<"gtpUser["<<i<<"]: UEId: "<<iter->second;
        len+=sprintf(buf+len,"gtpUser[%d]: UEId[%hd] ",i,iter->second);
        i++;

    }

    getDisplayString().setTagArg("t", 0, buf);
}

