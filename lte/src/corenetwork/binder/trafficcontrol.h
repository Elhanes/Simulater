//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#ifndef _LTE_TRAFFICCONTROL_H_
#define _LTE_TRAFFICCONTROL_H_


#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "corenetwork/binder/PgwBinder.h"
#include "corenetwork/binder/PgwBinder2.h"
#include "corenetwork/binder/LteBinder.h"

using namespace inet;



class trafficcontrol: public cSimpleModule
{
private:
    PgwBinder2* pgwbinder;
protected:
    virtual int numInitStages() const override { return NUM_INIT_STAGES; }
    virtual void initialize  (int stage) override
    {
    }
};

Define_Module(trafficcontrol);
#endif
