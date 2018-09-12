#ifndef _LTE_PGWINSTANCE_H_
#define _LTE_PGWINSTANCE_H_

#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "common/LteCommon.h"
#include "corenetwork/binder/LteBinder.h"
#include "corenetwork/binder/UeSet.h"
using namespace inet;


class Pgw
{
private:
    char* PGW;
    std::string PGWstr;
    int numUE;
    int power;
    std::vector<MacNodeId> UE;
    LteBinder* binder;
    int end=0;
    friend class PgwBinder2;
    friend class ueset;
public:

    Pgw(char* PGW):numUE(0)
{
        int len=strlen(PGW)+1;
        this->PGW=new char[len];
        strcpy(this->PGW,PGW);
        this->PGWstr=PGW;
        power=0;
        binder=getBinder();
        EV<<this->PGW<<" "<<"Successfully registered";
}

    //const char* getnameofPGW(MacNodeId pgwID);
    const char* getPGWname();
    std::string getPGWstr();
    int getnumUE();
    void setmacNodeIDofUE(MacNodeId ue);
    MacNodeId getmacNodeIDofUE();
    void setsrcUE(MacNodeId macId);
    void releaseUE(MacNodeId macId);
    void increasepower(){
       // char *buf;
        //int len;
        //len=sprintf(buf,"_%d",numUE);
        //power=buf;
        power++;
    }
    void updatepower();
    int load(int load_);
    void decreasepower(){
        power--;
    }

   int getpower(){
        return power;
    }
};


#endif
