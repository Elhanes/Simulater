
#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "common/LteCommon.h"
#include "corenetwork/binder/LteBinder.h"
#include "corenetwork/binder/DCinstance.h"

using namespace inet;

const char* DC::getDCname(){
    return this->dc;
}
std::string DC::getDCstring(){
    return this->dcstr;
}
int DC::getnumUE()
{
    return UE.size();
}

void DC::setmacNodeIDofUE(MacNodeId ue)
{
    //static int i=0;
    //UE[i++]=ue;

}
MacNodeId DC::getmacNodeIDofUE()
{
    for(int j=0;j<numUE;j++)
    {
        EV<< "connected UE is "<< UE[j]<<endl;
    }

    return 0;
}

void DC::setsrcUE(MacNodeId macId){
   //UE[end++]=macId;
    UE.push_back(macId);
    //increasepower();
    updatepower();
}
void DC::releaseUE(MacNodeId macId){
    int size=(int)UE.size();
    for(int i=0;i<size;)
    {
        printf("releaseUE\n");
        if(UE[i]==macId){
            const char* uename=binder->getModuleNameByMacNodeId(macId);
            std::cout<<"IN DC: "<<this->dc<<"UEIID: "<<uename<<"is released"<<endl;
            UE.erase(UE.begin()+i);
            numUE--;
            updatepower();
            return;

        }
        else i++;
    }

}
void DC::registerPGW(char *name){
    //Pgw* temp;
    //temp=new Pgw(name);
    pgwlist[numPGW++]=new Pgw(name);
   // pgwmap.insert(pair<&pgwlist[numPGW],pgwaddress>);
    //pgwlist.push_back(temp);
    EV<<"successfully registerd DC name:"<< this->dc<<"pgwname"<<pgwlist[pgwlist.size()]->getPGWname();

}
void DC:: updatepower(){
       power=0;
       for(int i=0;i<numPGW;i++){
           power=power+pgwlist[i]->getpower();
       }
   }
