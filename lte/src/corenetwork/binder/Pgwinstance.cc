
#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "common/LteCommon.h"
#include "corenetwork/binder/LteBinder.h"
#include "corenetwork/binder/Pgwinstance.h"

using namespace inet;

const char* Pgw::getPGWname(){
    return this->PGW;
}
std::string Pgw::getPGWstr(){
    return this->PGWstr;
}
int Pgw::getnumUE()
{
    return UE.size();
}

void Pgw::setmacNodeIDofUE(MacNodeId ue)
{
    //static int i=0;
    //UE[i++]=ue;

}
MacNodeId Pgw::getmacNodeIDofUE()
{
    for(int j=0;j<numUE;j++)
    {
        EV<< "connected UE is "<< UE[j]<<endl;
    }

    return 0;
}

void Pgw::setsrcUE(MacNodeId macId){
   //UE[end++]=macId;
   //EV<<"UE["<<end-1<<"]= %hd"<<macId;
    UE.push_back(macId);
    //increasepower();
    updatepower();
}
void Pgw::releaseUE(MacNodeId macId){
    int size=(int)UE.size();
    for(int i=0;i<size;)
       {
           if(UE[i]==macId)
           {
               const char* uename=binder->getModuleNameByMacNodeId(macId);
               std::cout<<"IN pgw: "<<this->PGW<<"UEIID: "<<uename<<"is released"<<endl;
                        UE.erase(UE.begin()+i);
                        --numUE;
                        std::cout<<"num UE: "<<numUE<<endl;
                        //decreasepower();
                        updatepower();
                        return;
           }
           else i++;
       }
}
void Pgw::updatepower(){
    power=load(numUE);

}
int Pgw::load(int load_){
    switch(load_)
    {
    case 0:
                std::cout<<"return 0"<<endl;
                return 0;
    case 1:
        std::cout<<"return 1"<<endl;
                return _1;
    case 2:
        std::cout<<"return 2"<<endl;
                return _2;
    case 3:
        std::cout<<"return 3"<<endl;
                return _3;
    case 4:
        std::cout<<"return 4"<<endl;
                return _4;
    case 5:
        std::cout<<"return 5"<<endl;
                return _5;
    case 6:
        std::cout<<"return 6"<<endl;
                return _6;
    case 7:
        std::cout<<"return 7"<<endl;
                return _7;
    case 8:
        std::cout<<"return 8"<<endl;
                return _8;
    case 9:
        std::cout<<"return 9"<<endl;
                return _9;
    case 10:
        std::cout<<"return 10"<<endl;
                return _10;

    default:
        return 0;
    }

}
