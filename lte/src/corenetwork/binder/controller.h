//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#ifndef _LTE_CONTROLLER_H_
#define _LTE_CONTROLLER_H_

#include <omnetpp.h>
#include <string>
#include <vector>
#include <cstdlib>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "corenetwork/binder/PgwBinder2.h"
#include "corenetwork/binder/UeSet.h"

using namespace inet;



class controller: public cSimpleModule
{
private:
    PgwBinder2* pgwbinder;
    std::vector<ueset*> UE;
    std::vector<ueset*> R;
    int numUE;
    int numUEon;
    int numUEoff;
    cMessage* selfmsg;
    bool random;
    simtime_t randomtime;
    int counter;
protected:
    virtual int numInitStages() const override { return NUM_INIT_STAGES; }
    virtual void initialize  (int stage) override;
    virtual void refreshDisplay() const override;
    virtual void handleMessage(cMessage *msg) override;
public:
    void registerUEtoCtrl(ueset* ueset_);


    void randomreverse();

    int getactiveUEnum(){
        return numUE-numUEoff;
    }
};
#endif
