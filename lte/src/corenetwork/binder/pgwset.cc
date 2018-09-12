//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//


#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "corenetwork/binder/PgwBinder.h"
#include "corenetwork/binder/PgwBinder2.h"
#include "corenetwork/binder/pgwset.h"
Define_Module(pgwset);
using namespace inet;

   void pgwset::initialize  (int stage)
    {
        cSimpleModule::initialize(stage);
        pgwbinder=getPgwBinder2();
        if(stage ==INITSTAGE_PHYSICAL_ENVIRONMENT){

        char* name=(char *)getParentModule()->getFullName();
        EV<<"register this pgw which of name is [ "<<name<<"]!!!!!!!!!!!!!!!!!!"<<endl;
        pgwbinder->registerPGW(name);
        }
    }


