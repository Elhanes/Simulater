//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#ifndef _LTE_VOIPSENDER2_H_
#define _LTE_VOIPSENDER2_H_

#include <string.h>
#include <omnetpp.h>

#include "inet/transportlayer/contract/udp/UDPSocket.h"
#include "inet/networklayer/common/L3AddressResolver.h"
#include "apps/voip/VoipPacket_m.h"
#include "corenetwork/binder/UeSet.h"
#include "corenetwork/binder/PgwBinder2.h"
class VoIPSender2 : public cSimpleModule
{
    inet::UDPSocket socket;
    bool state;
    //has the sender been initialized?

    bool initialized_;

    //source
    simtime_t durTalk_;
    simtime_t durSil_;
    double scaleTalk_;
    double shapeTalk_;
    double scaleSil_;
    double shapeSil_;
    bool isTalk_;
    cMessage* selfSource_;
    //sender
    int iDtalk_;
    int nframes_;
    int iDframe_;
    int nframesTmp_;
    int size_;
    simtime_t sampling_time;

    bool silences_;
    simtime_t startTime;

    simsignal_t voIPGeneratedThroughtput_;
    // ----------------------------

    cMessage *selfSender_;
    cMessage *selfmsg;
    simtime_t timestamp_;
    int localPort_;
    int destPort_;
    inet::L3Address destAddress_;
    ueset *uesetptr;
    void talkspurt(simtime_t dur);
    void selectPeriodTime();
    void sendVoIPPacket();

    //friend ueset;
    friend class ueset;
  public:
    ~VoIPSender2();
    VoIPSender2();

  protected:

    virtual int numInitStages() const { return inet::NUM_INIT_STAGES; }
    void initialize(int stage);
    void handleMessage(cMessage *msg);
    void selfschedule();
};

#endif

