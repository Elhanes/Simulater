//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#include "corenetwork/binder/PgwBinder2.h"
#include "corenetwork/deployer/LteDeployer.h"
#include "inet/networklayer/common/L3AddressResolver.h"
#include <cctype>
#include "corenetwork/nodes/InternetMux.h"
#include "corenetwork/binder/LteBinder.h"
#include "corenetwork/binder/UeSet.h"
#include "inet/networklayer/ipv4/IPv4Datagram.h"
#include <iostream>
#include <string>
#include <cstdlib>
using namespace std;

Define_Module(PgwBinder2);



L3Address PgwBinder2::getPgwAddress(){
    //Enter_Method("getPgwAddress");
    L3Address pgwAddress_;
    pgwAddress_ = L3AddressResolver().resolve("pgw");
    return pgwAddress_;
}

L3Address PgwBinder2::assignPgwAddress(){
   /* L3Address pgwAddress_;
    int i;
    i=findPGWwithMinUE();
    const char* name=pgwlist[i]->getPGWname();
    pgwlist[i]->numUE++;

    pgwAddress_=L3AddressResolver().resolve(name);

    return pgwAddress_;
    */
    L3Address pgwAddress_;
        pgwAddress_ = L3AddressResolver().resolve("pgw");
        return pgwAddress_;
}
/*L3Address PgwBinder2::assignPgwAddress(IPv4Datagram *  address){
    L3Address pgwAddress_;
    IPv4Address &srcAddress = address->getSrcAddress();
    int i;
    i=findPGWwithMinUE();
    const char* name=pgwlist[i]->getPGWname();
    pgwlist[i]->numUE++;
    MacNodeId MacId=binder->getMacNodeId(srcAddress);
    const char* uename=binder->getModuleNameByMacNodeId(MacId);
    ueset* UE=check_and_cast<ueset*>(getSimulation()->getModuleByPath(uename)->getSubmodule("UeSet"));


    pgwAddress_=L3AddressResolver().resolve(name);
    pgwlist[i]->setsrcUE(MacId);
    UE->setpgwaddress(pgwAddress_);
    return pgwAddress_;
}*/
/*L3Address PgwBinder2:: RandomAssign(const char* uename)
{
    DC* selectedDC; //selected DC index
    int PGWindex;//selected PGW in selected DC index
    selectedDC=RandomselectDC();
    PGWindex=make_vPGW_for_DC(selectedDC); //select PGW
    updateUEinfotoEPC(selectedDC,PGWindex);
}*/
void PgwBinder2::updateUEinfotoEPC(DC* selectedDC,int PGWindex){
    selectedDC->pgwlist[PGWindex]->numUE++;
    selectedDC->numUE++;

}
void PgwBinder2::updateUEset(const char* uename){

}
L3Address PgwBinder2::assignPgwAddress(IPv4Datagram *  address,eNBset *eNBsetptr){

    //HAEIN: assigningPgwAddress as the follow up sequence 1. select DC 2. assign PGW.
      L3Address pgwAddress_;
      IPv4Address &srcAddress = address->getSrcAddress();
      DC* selectedDC; //selected DC index
      int PGWindex;//selected PGW in selected DC index
      MacNodeId MacId=binder->getMacNodeId(srcAddress);
      const char* uename=binder->getModuleNameByMacNodeId(MacId);
      string type=par("type");
      if(type=="random")
      {

         selectedDC=RandomselectDC(eNBsetptr);
         PGWindex=make_vPGW_for_DC(selectedDC); //select PGW
         if(PGWindex<0) throw cRuntimeError("DC is full\n");

             //update the UE info in DC and pgw
             //num UE

             selectedDC->pgwlist[PGWindex]->numUE++;
             selectedDC->numUE++;
             //UEID

             selectedDC->pgwlist[PGWindex]->setsrcUE(MacId);
             selectedDC->setsrcUE(MacId);

             //UESET UPDATE
             const char* name=selectedDC->pgwlist[PGWindex]->getPGWname();
             pgwAddress_=L3AddressResolver().resolve(name);
             ueset* UE=check_and_cast<ueset*>(getSimulation()->getModuleByPath(uename)->getSubmodule("UeSet"));
             UE->setpgwaddress(pgwAddress_,selectedDC,PGWindex);
             UE->setping(this->selectedping);
             //UE->setping(this->selectedping);
             activeUE++;
             std::ofstream outFile(textname,std::ios::app);
             outFile<<simTime()<<" connect "<<UE->getping()<<" "<<uename<<" "<<selectedDC->getDCname()<<" "<<name<<" "<<activeUE<<" "<<activeDC<<" "<<activePGW<<" ";
             for(int i=0;i<numDC;i++){
                 outFile<<DClist[i]->dc<<": "<<DClist[i]->getpower()<<" ";
             }
             outFile<<endl;
             outFile.close();
             EV<<"UE NAME: "<<uename<<"is connected to DC name: "<<selectedDC->getDCname()<<" PGWname: "<<name;
             std::cout<<"UE NAME: "<<uename<<"is connected to DC name: "<<selectedDC->getDCname()<<" PGWname: "<<name<<endl;
      }
      else if(type=="voronoi")
      {
          //int trial=0;
          //do{
          selectedDC=VoronoiselectDC(eNBsetptr);
          PGWindex=make_vPGW_for_DC(selectedDC); //select PGW
          if(PGWindex<0) throw cRuntimeError("DC is full\n");
         // if(PGWindex<0) trial++;
         //}while(trial<numDC);
         // if(trial>=numDC) throw cRuntimeError("All the resources are full\n");

              //update the UE info in DC and pgw
              //num UE

              selectedDC->pgwlist[PGWindex]->numUE++;
              selectedDC->numUE++;
              //UEID

              selectedDC->pgwlist[PGWindex]->setsrcUE(MacId);
              selectedDC->setsrcUE(MacId);

              //UESET UPDATE
              const char* name=selectedDC->pgwlist[PGWindex]->getPGWname();
              pgwAddress_=L3AddressResolver().resolve(name);
              ueset* UE=check_and_cast<ueset*>(getSimulation()->getModuleByPath(uename)->getSubmodule("UeSet"));
              UE->setpgwaddress(pgwAddress_,selectedDC,PGWindex);
              UE->setping(this->selectedping);
              activeUE++;
              std::ofstream outFile(textname,std::ios::app);
                          outFile<<simTime()<<" connect "<<UE->getping()<<" "<<uename<<" "<<selectedDC->getDCname()<<" "<<name<<" "<<activeUE<<" "<<activeDC<<" "<<activePGW<<" ";
                          for(int i=0;i<numDC;i++){
                              outFile<<DClist[i]->dc<<": "<<DClist[i]->getpower()<<" ";
                          }
                          outFile<<endl;
                          outFile.close();
              EV<<"UE NAME: "<<uename<<"is connected to DC name: "<<selectedDC->getDCname()<<" PGWname: "<<name;
              std::cout<<"UE NAME: "<<uename<<"is connected to DC name: "<<selectedDC->getDCname()<<" PGWname: "<<name<<endl;
      }
      else if(type=="setcover"){
          //select DC
         selectedDC=selecDCamonglessRTT(eNBsetptr); //given eNBset *eNBsetptr have a pingvector. select DC by ping info.
         PGWindex=make_vPGW_for_DC(selectedDC); //select PGW

                      //update the UE info in DC and pgw
                      //num UE
                     std::cout<<"selectedDC: "<<selectedDC->getDCname()<<"PGWindex"<<PGWindex;
                      selectedDC->pgwlist[PGWindex]->numUE++;
                      selectedDC->numUE++;
                      //UEID

                      selectedDC->pgwlist[PGWindex]->setsrcUE(MacId);
                      selectedDC->setsrcUE(MacId);

                      //UESET UPDATE
                      const char* name=selectedDC->pgwlist[PGWindex]->getPGWname();
                      pgwAddress_=L3AddressResolver().resolve(name);
                      ueset* UE=check_and_cast<ueset*>(getSimulation()->getModuleByPath(uename)->getSubmodule("UeSet"));
                      UE->setpgwaddress(pgwAddress_,selectedDC,PGWindex);
                      UE->setping(this->selectedping);
                      //activeUE=controller_->getactiveUEnum();
                      activeUE++;
                      /*std::ofstream outFile(textname,std::ios::app);
                      outFile<<simTime()<<" connect "<<UE->getping()<<" "<<uename<<" "<<selectedDC->getDCname()<<" "<<name<<" "<<activeUE<<" "<<activeDC<<" "<<activePGW<<" "<<selectedDC->getpower()<<" "<<selectedDC->pgwlist[PGWindex]->getpower()<<endl;
                      outFile.close();*/
                      std::ofstream outFile(textname,std::ios::app);
                                               outFile<<simTime()<<" connect "<<UE->getping()<<" "<<uename<<" "<<selectedDC->getDCname()<<" "<<name<<" "<<activeUE<<" "<<activeDC<<" "<<activePGW<<" ";
                                               for(int i=0;i<numDC;i++){
                                                   outFile<<DClist[i]->dc<<": "<<DClist[i]->getpower()<<" ";
                                               }
                                               outFile<<endl;
                                               outFile.close();
                      EV<<"UE NAME: "<<uename<<"is connected to DC name: "<<selectedDC->getDCname()<<" PGWname: "<<name;
                      std::cout<<"UE NAME: "<<uename<<"is connected to DC name: "<<selectedDC->getDCname()<<" PGWname: "<<name<<endl;
      }



      return pgwAddress_;
}
void PgwBinder2::registerDC(char* name){

    DClist[numDC++] = new DC(name);
}
void PgwBinder2::registerPGW(char* name)
{
    //find the DC in which PGW is involved and register it to DC.
    char* temp;
    std::string PGW=name;
    int end=PGW.length();
    std::string substring=PGW.substr(4,end);

    //pgwlist[numPGW++]=new Pgw(name); //original code
    temp=new char[5];

    for(int i=0;i<numDC;i++){
    strcpy(temp,(char*)DClist[i]->getDCname());
    EV<<"substring:"<<substring<<"temp:"<<temp<<endl;
    if(substring==temp) //if pgwname has DCname
    {
        EV<<"register "<<name<<"to "<<DClist[i]->getDCname()<<endl;
        DClist[i]->registerPGW(name);
    }
    }
}
/*int PgwBinder2::findPGWwithMinUE()
{
    int temp;
    int min;
    int i;
    int minindex;
    for(i=0;i<numPGW;i++)
    {
        if(i==0)
            {
            temp=pgwlist[i]->numUE;
            min=temp;
            minindex=i;

            }
        else
            {
            temp=pgwlist[i]->numUE;
            if(temp<min){
                min=temp;
                minindex=i;
            }

            }
    }
    return minindex;

} */
int PgwBinder2::make_vPGW_for_DC(DC* DCinstance){

    //in here implement the PGW selection algorithm
    //below one is put it to pgw with minUE
    /*
    int temp;
       int min;
       int minindex;
       std::cout<<"num PGW: "<<DCinstance->numPGW<<endl;
       for(int i=0;i<DCinstance->numPGW;i++)
       {
           if(i==0)
               {
               temp=DCinstance->pgwlist[i]->numUE;
               min=temp;
               minindex=i;


               }
           else
               {
               temp=DCinstance->pgwlist[i]->numUE;
               if(temp<min){
                   min=temp;
                   minindex=i;
               }

               }

       }
       EV<<"min UE is index: "<<minindex;

       return minindex;
       */

    //below one is put it until maximumueinsgw UE and next one.
    for(int i=0;i<DCinstance->numPGW;)
    {

        if(DCinstance->pgwlist[i]->numUE<maximumUEinPGW)
        {
            if(!DCinstance->pgwlist[i]->numUE) activePGW++;
            return i;
        }
        else{
            if(DCinstance->numUE>=maximumUEinDC) return -1;//DC is full
            i++;
        }
    }

    return -1; //DC is full;
}
DC* PgwBinder2:: selectDC( std::vector<std::pair<pingpair,DC*>> DCvector){
    // choose who has most UEs....? or choose who has sgw... 10ue is restraint for sgw.... so... we have to compare numue%10 then pick most one** %10 means maxiumUEinPGW
    //and maximun number of ue is restraintnumber of ue * numpgw.

   //return DC which has smalles ue.
    double maxfactor;
    double tempfactor;
    int selectedindex;
    int isfull=0;
    DC* ret;
    EV<<"the DCvectorsize: "<<DCvector.size()<<endl;

    for(int i=0;i<(signed int)DCvector.size();i++){  //compare with the RTT restraint.

        EV<<DCvector[i].first.first<<"is in for loop"<<endl;
        EV<<"The number of UE in "<<DCvector[i].first.first<<" is : "<<DCvector[i].second->numUE<<endl;
           if(i==0){
           //tempfactor=DCvector[i].first.second.dbl()*100000+DCvector[i].second->numUE;
               if(DCvector[i].second->numUE<maximumUEinDC){
           tempfactor=(DCvector[i].second->numUE)%maximumUEinPGW;
           maxfactor=tempfactor;
           selectedindex=i;
               }
               else maxfactor=-1;
           }
           else{
               //tempfactor=DCvector[i].first.second.dbl()*100000+DCvector[i].second->numUE;
               if(DCvector[i].second->numUE<maximumUEinDC){
               tempfactor=(DCvector[i].second->numUE)%maximumUEinPGW;
               if(tempfactor>maxfactor)
                   {
                   maxfactor=tempfactor;
                   selectedindex=i;
                   }
               }
           }
           //if(DCvector[i].second->numUE==maximumUEinDC) isfull++;

       }
    if(isfull==(signed int)DCvector.size())
        {
        std::cout<<"all resource done, voronoi"<<endl;
        ret=VoronoiselectDC(eNBsetptr);
        return ret;
        }

    EV<<"the return value is :"<<selectedindex<<DCvector[selectedindex].second->dc<<endl;
    selectedping=DCvector[selectedindex].first.second;
    return DCvector[selectedindex].second;
    //return selectedindex;
}
DC* PgwBinder2::selecDCamonglessRTT(eNBset* eNBsetptr){
    //in here implement the DC selection algoritm.
    string type=par("type");
    double RTT=par("RTT");//RTT setting later it would be easier to configure with par(RTT)

    int index;
    DC* selectedDC;

    //HAEIN: pingvec is sorted, so the smaller RTT ping is 0~itr.
    pingvector::iterator iter=eNBsetptr->lessRTT_DC_of_eNB(RTT);//if pgw have no ping info then it may not be assigned.
    pingvector::iterator temp;


    std::pair <pingpair,DC*> DCpair;// <DCname, ping/ DC pointer>
    std::vector<std::pair<pingpair,DC*>> DCvector;

    //0~itr;//if all ping is bigger then RTT select smallest one.
    if(iter==eNBsetptr->pingvec.begin())
    {  index=findDCbystring((*iter).first);
        DCpair=std::make_pair(*iter,DClist[index]);
        DCvector.push_back(DCpair);

        //selectedDC=VoronoiselectDC(eNBsetptr);
        //std::cout<<"voronoi로"<<endl;
    }
    else{
    for(temp=eNBsetptr->pingvec.begin();temp!=iter;++temp){
       index=findDCbystring((*temp).first);
       if(index<0)
           throw cRuntimeError("lessRTT_DC_of_eNB: there is no such DC %s",(*temp).first);
       EV<<"the pair is "<<(*temp).first<<" "<<DClist[index]->getDCname()<<endl;
       DCpair=std::make_pair(*temp,DClist[index]);
       DCvector.push_back(DCpair);
    }
    }

    //factor= DC ping*100000+DCnumUE.
    selectedDC=selectDC(DCvector);
    if(!selectedDC->numUE) activeDC++;//if the number of UE in DC is 0, which means new DC so increase the activeDC;
   return selectedDC;


}

int PgwBinder2::findDCbystring(std::string name){
    for(int i=0;i<numDC;i++){
        if(DClist[i]->dcstr==name)
            return i;
    }
    return -1;
}

void PgwBinder2::showingAssets()
{
    std::cout<<"DCname||#PGWs||#UEs||pgw||#UEs numDC: "<<numDC<<endl;;
    for(int i=0;i<numDC;i++){
        std::cout<<DClist[i]->dc<<"   ||"<<DClist[i]->numPGW<<"    ||"<<DClist[i]->numUE;
        for(int j=0;j<DClist[i]->numPGW;j++){
            std::cout<<"   ||"<<DClist[i]->pgwlist[j]->PGW<<" ||"<<DClist[i]->pgwlist[j]->numUE;
        }
        std::cout<<endl;
    }
   /* string displaymsg;
       string temp1,temp2,temp3;

       for(int i=0;i<numDC;i++){
           temp1=DClist[i]->dc;
           temp2=itoa(DClist[i]->numPGW);
           temp3=itoa(DClist[i]->numUE);
           displaymsg+=temp1+"   ||"+temp2+"   ||"+temp3;
               for(int j=0;j<DClist[i]->numPGW;j++){

                   temp1=DClist[i]->pgwlist[j]->PGW;
                   temp2=itoa(DClist[i]->pgwlist[j]->numUE);
                   displaymsg+="   ||"+temp1+"   ||"+temp2;
               }
               displaymsg+="\n";
           }
       std::cout<<displaymsg;
       */
}
DC* PgwBinder2::RandomselectDC(eNBset* eNBsetptr){
   int randomindex=rand()%numDC;
   selectedping=(eNBsetptr->pingvec[randomindex]).second;
   int index=findDCbystring(eNBsetptr->pingvec[randomindex].first);
   EV<<"Random selected DC name: "<<DClist[index]->dc<<endl;
   std:cout<<"Random selected DC name: "<<DClist[index]->dc<<endl;
   while(DClist[index]->numUE>=maximumUEinDC) // elhanes
       {

           index=(index+1)%numDC;
           if (index > numDC) index = 0;

       }
   if(!DClist[index]->numUE) activeDC++; //if the number of UE in DC is 0 which means new one.
   return DClist[index];
}

DC* PgwBinder2::VoronoiselectDC(eNBset* eNBsetptr){
    pingvector::iterator iter=eNBsetptr->pingvec.begin();
    selectedping=(*iter).second;
    int index=findDCbystring((*iter).first);
    while((DClist[index]->numUE)>=maximumUEinDC)
    {
        ++iter;
        index=findDCbystring((*iter).first);
        std::cout<<"Selected index"<<index<<" "<<DClist[index]->numUE<<" "<<maximumUEinDC<<endl;
    }
    //selectedping=eNBsetptr->pingvec[trial].second;
    //int index=findDCbystring(eNBsetptr->pingvec[trial].first);
    //while(DClist[index]->isfull){
    //  iter++;
     // if(iter==eNBsetptr->pingvec.end())
          //return NULL;//full
    //}
    if(!DClist[index]->numUE) activeDC++; //if the number of UE in DC is 0 which means new one.
    return DClist[index];
}
void PgwBinder2::refreshDisplay() const
{

   char buf[100000];
   int len=0;
   int ue=0;
  len=sprintf(buf,"DC    ||#P||#U||pgw||#U  numDC:%d",numDC);
  for(int i=0;i<numDC;i++){
       len+=sprintf(buf+len,"\n%s ||%d   ||%d",DClist[i]->dc,DClist[i]->numPGW,DClist[i]->numUE);
       for(int j=0;j<DClist[i]->numPGW;j++){
           len+=sprintf(buf+len,"   ||%s   ||%d",DClist[i]->pgwlist[j]->PGW,DClist[i]->pgwlist[j]->numUE);
       }

   }
  for(int i=0;i<numDC;i++){
        len+=sprintf(buf+len,"\n%s ||\n",DClist[i]->dc);
        for(int j=0;j<DClist[i]->numPGW;j++){
            len+=sprintf(buf+len,"  ||%s   ||%d",DClist[i]->pgwlist[j]->PGW,DClist[i]->pgwlist[j]->numUE);
            for(int k=0;k<DClist[i]->pgwlist[j]->numUE;k++){
                ue++;
                const char* uename=binder->getModuleNameByMacNodeId(DClist[i]->pgwlist[j]->UE[k]);
                len+=sprintf(buf+len,"|| %s",uename);
            }
            len+=sprintf(buf+len,"\n");
        }

    }
  len+=sprintf(buf+len,"the number of assigned UE: %d",ue);
    getDisplayString().setTagArg("t", 0, buf);
}







