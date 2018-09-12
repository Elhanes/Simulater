#ifndef _LTE_UEINSTANCE_H_
#define _LTE_UEINSTANCE_H_

#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "common/LteCommon.h"
#include "corenetwork/binder/LteBinder.h"
//#include "apps/voip/VoIPSender2.h"

#include <map>
using namespace inet;
class ueset;
class UEinstance
{
private:
    char* UEname;
    std::string UEnamestr;
  //  VoIPSender2 *app;
   // ueset *ueset_;
public:
    UEinstance(char *name){
        int len=strlen(name)+1;
        this->UEname=new char[len];
        strcpy(this->UEname,name);
        this->UEnamestr=name;

        EV<<this->UEname<<" "<<"Successfully registered";
       // ueset_=check_and_cast<ueset*>(getSimulation()->getModuleByPath(name)->getSubmodule("ueset"));

    }

    char* getUEname();
};


#endif
