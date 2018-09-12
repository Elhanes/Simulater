//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#ifndef _LTE_UESET_H_
#define _LTE_UESET_H_

#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/common/L3Address.h"
#include "corenetwork/binder/LteBinder.h"
#include "apps/voip/VoIPSender2.h"
#include "corenetwork/binder/PgwBinder2.h"
#include "corenetwork/binder/controller.h"
#include "corenetwork/binder/DCinstance.h"
using namespace inet;



class ueset: public cSimpleModule
{

private:
    char* name;
    L3Address pgwaddress_;
    bool isaddress_=false; //if this ue has pgw address isaddress_ is ture, or false;
    LteBinder* binder_;
    PgwBinder2* pgwbinder_;
    MacNodeId UEId;
    VoIPSender2 *app;
    controller* controller_;
    simtime_t selectedping;
    bool state; // off==0, on==1; defined by enum in LteCommon. default is 0;
    DC* DCptr; //inital value=-1; which means there is no assigned DC
    int pgwindex; //inital value=-1; which means there is no assigned pgw;
    friend VoIPSender2;
    friend controller;
public:
    virtual int numInitStages() const { return inet::NUM_INIT_STAGES; }
    void initialize(int stage);
    L3Address& getpgwaddress();
    void setpgwaddress(L3Address &pgwaddress,DC* DCindex, int pgwindex);
    void releasepgwaddress();
void   setping(simtime_t ping){
    selectedping=ping;
}
simtime_t getping()
{
    return selectedping;
}
   bool isaddress();
   void setMacNodeId();
   void turnonstate();
   void turnoffstate();
   char* getuename(){
       return name;
   }
   bool ison(){
       return state;
   }

};


#endif
