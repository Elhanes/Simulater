//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#ifndef _LTE_DCset_H_
#define _LTE_DCset_H_

#include <omnetpp.h>
#include<iostream>
#include <string>
#include <utility>
#include <vector>
#include <map>
#include "common/LteCommon.h"
#include "inet/networklayer/common/L3Address.h"
#include "corenetwork/binder/LteBinder.h"
#include "inet/applications/pingapp/PingApp2.h"
//#include "apps/pingapp/PingApp2.h"
#include "inet/networklayer/common/L3Address.h"
#include "inet/common/lifecycle/ILifecycle.h"
#include "inet/common/lifecycle/LifecycleOperation.h"
#include "inet/common/lifecycle/NodeStatus.h"
#include "corenetwork/binder/PgwBinder2.h"
using namespace inet;

typedef std::pair <std::string,simtime_t> pingpair;
typedef std::vector<std::pair<std::string,simtime_t>> pingvector;

class DCset: public cSimpleModule
{
private:
    PgwBinder2* pgwbinder;
public:
    virtual int numInitStages() const override { return NUM_INIT_STAGES; }
    virtual void initialize  (int stage) override;

};


#endif
