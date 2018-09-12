//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#include "corenetwork/binder/eNBset.h"
#include "inet/common/ModuleAccess.h"
#include "inet/applications/pingapp/PingApp2.h"
//#include "apps/pingapp/PingApp2.h"
#include "common/LteCommon.h"
#include <string>
#include <algorithm>
using namespace inet;
Define_Module(eNBset);

bool comparepair(const pingpair &ping1,const pingpair &ping2){
           return ping1.second<ping2.second;
       }
void eNBset::initialize(int stage)
{
    if(stage==INITSTAGE_APPLICATION_LAYER){
    numPingApps=getParentModule()->par("numPingApps");
    timer=new cMessage("selfmsg");
    ping=new pingpair[numPingApps];
    pingapp= new PingApp2* [numPingApps];
    simtime_t startTime = par("mediatestep_");
  //  pingapp=check_and_cast<PingApp2 *>(getParentModule()->getSubmodule("pingApp[0]"));
    for(int i=0;i<numPingApps;i++)
    {
    pingapp[i]=check_and_cast<PingApp2 *>(getParentModule()->getSubmodule("pingApp",i));
    }
    //scheduleAt(mediate_step,timer);
    scheduleAt(startTime,timer);
    }
//else if (stage == INITSTAGE_APPLICATION_LAYER) {
       // startup
  //  EV<<"INITISTAGE 이니셜라이즈!!";
    // pingapp->doelseif();
   //}
}
pingvector eNBset::getpingvector(){
return this->pingvec;
}
void eNBset::handleMessage(cMessage *msg){
    pingvector::iterator iter;
    pingvector::iterator tempiter;
if(msg->isSelfMessage())
{
    for(int i=0;i<numPingApps;i++){
   ping[i]=pingapp[i]->getpinginfo();
   temp=pingapp[i]->getpinginfo();
   pingvec.push_back(temp);
   EV<<"here is the ping info "<<ping[i].first<<" "<<ping[i].second<<endl;
   EV<<"here is the pingvec info"<<pingvec[i].first<<" "<<pingvec[i].second<<endl;
    }
    sortpingvector();// sort the pingvector for make easier to find pings which have less RTT then given number.
for(int i=0;i<pingvec.size();i++)
{
    EV<<"sorted ping "<<pingvec[i].first<<" "<<pingvec[i].second<<endl;
}
}

}

void eNBset::sortpingvector(){
    sort(pingvec.begin(),pingvec.end(),comparepair);
}
pingvector::iterator eNBset::lessRTT_DC_of_eNB(double RTT){
    EV<<"The pings of DCs less then "<<RTT<<endl;
    pingvector::iterator iter;
    for(iter=pingvec.begin();iter!=pingvec.end();++iter)
    {
        EV<<(*iter).first<<" "<<(*iter).second<<endl;
        if((*iter).second>RTT) return iter;
    }
    return pingvec.end();

}

