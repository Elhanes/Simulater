#ifndef _LTE_DCINSTANCE_H_
#define _LTE_DCINSTANCE_H_

#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "common/LteCommon.h"
#include "corenetwork/binder/LteBinder.h"
#include "corenetwork/binder/Pgwinstance.h"
#include "corenetwork/binder/UeSet.h"
#include <map>
using namespace inet;
typedef std::pair <std::string,simtime_t> pingpair;
typedef std::vector<std::pair<std::string,simtime_t>> pingvector;
class Pgw;
class DC
{
private:
    char* dc;
    std::string dcstr;
    std::vector<Pgw*> pgwlist;
    //std::map<Pgw*,L3Address> pgwmap;
    int numUE;
    int numPGW;
    std::vector<MacNodeId> UE;
    LteBinder* binder;
    int end=0;
    int power;
    bool isfull;
    friend class PgwBinder2;
    friend class ueset;
public:

    DC(char* dc):numUE(0),numPGW(0)
{
        int len=strlen(dc)+1;
        this->dc=new char[len];
        strcpy(this->dc,dc);
        this->dcstr=dc;
        binder=getBinder();
        pgwlist.reserve(5);
        UE.reserve(10);
        power=0;
        isfull=false;
        EV<<this->dc<<" "<<"Successfully registered";
}

    //const char* getnameofPGW(MacNodeId pgwID);
    const char* getDCname();
    std::string getDCstring();
    void registerPGW(char *name);
    void releaseUE(MacNodeId macId);
    int getnumUE();
    void setmacNodeIDofUE(MacNodeId ue);
    MacNodeId getmacNodeIDofUE();
    void setsrcUE(MacNodeId macId);
    void increasepower(){
        power++;
    }
    void decreasepower(){
        power--;
    }
    double getpower(){
        std::cout<<"power: "<<power<<endl;
        return power;
    }
    void updatepower();
};


#endif
