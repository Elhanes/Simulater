//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#ifndef _LTE_LTEPGWBINDER_H_
#define _LTE_LTEPGWBINDER_H_

#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"

using namespace inet;



class PgwBinder : public cSimpleModule
{
  private:

  protected:
    virtual void initialize(int stages){}

    virtual void handleMessage(cMessage *msg)
    {
    }

  public:

    L3Address getPgwAddress();

};

#endif
