
#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/common/L3Address.h"
#include "corenetwork/binder/LteBinder.h"
#include "corenetwork/binder/UeSet.h"
#include "inet/networklayer/common/L3AddressResolver.h"
Define_Module(ueset);


    void ueset::initialize(int stage){
        EV<< "Initialize the ueset!!"<<endl;
        if(stage==13){
        name=(char *)getParentModule()->getFullName();
        binder_=getBinder();
        pgwbinder_=getPgwBinder2();
        controller_=check_and_cast<controller*>(getSimulation()->getModuleByPath("controller"));
        //pgwbinder_=check_and_cast<PgwBinder2*>(getParentModule()->getSubmodule("pgwbinder2"));
        app= check_and_cast<VoIPSender2*>(getParentModule()->getSubmodule("udpApp",0));
        state=par("state");
        setMacNodeId();
        //turnoffstate();
        controller_->registerUEtoCtrl(this); ///RegisterUEtoCtrl
        DCptr=NULL;
        pgwindex=-1;
        //app->startTime=(getParentModule()->getSubmodule("udpApp",0))-> par("startTime");
        //app->selfschedule();
        }
    };
    L3Address& ueset::getpgwaddress(){
        return this->pgwaddress_;
    };
    void ueset::setpgwaddress(L3Address &pgwaddress,DC* DCptr, int pgwindex){
        this->pgwaddress_=pgwaddress;
        this->isaddress_=true;
        this->DCptr=DCptr;
        this->pgwindex=pgwindex;

    };
    void ueset::releasepgwaddress(){
        if(isaddress_){
        pgwbinder_->decreaseUE();
        if(this->DCptr->pgwlist[this->pgwindex]->numUE==1) pgwbinder_->decreasePGW(); //if pgw has only on ue it gonna be idle, so decrease activepgwnumber
        if(this->DCptr->numUE==1)pgwbinder_->decreaseDC(); //just same as right above line decrease activeDC
        this->DCptr->releaseUE(UEId);
        this->DCptr->pgwlist[this->pgwindex]->releaseUE(UEId);
        this->DCptr->updatepower();
        this->isaddress_=false;
        this->DCptr=NULL;
        this->pgwindex=-1;
        const char* textname=getSimulation()->getModuleByPath("pgwbinder2")->par("textname");

        std::ofstream outFile(textname,std::ios::app);
        outFile<<simTime()<<" disconnect"<<" "<<"blank"<<" "<<this->name<<" "<<"blank"<<" "<<"blank"<<" "<<pgwbinder_->getactiveUE()<<" "<<pgwbinder_->getactiveDC()<<" "<<pgwbinder_->getactivePGW()<<" ";
        for(int i=0;i<pgwbinder_->numDC;i++){
                        std::cout<<pgwbinder_->DClist[i]->dc<<": "<<pgwbinder_->DClist[i]->getpower()<<" "<<endl;
                         outFile<<pgwbinder_->DClist[i]->dc<<": "<<pgwbinder_->DClist[i]->getpower()<<" ";
                     }
        outFile<<endl;
        outFile.close();
        }
    }
   bool ueset::isaddress(){
       return this->isaddress_;
   }
   void ueset::setMacNodeId(){
       getParentModule()->getSubmodule("nic")->getSubmodule("ip2lte");
       UEId=binder_->getMacNodeIdFromOmnetId(getParentModule()->getId());

   }

   void ueset:: turnonstate(){

       EV<<"turn on the UE: "<<this->name<<endl;
       std::cout<<"turn on the UE: "<<this->name<<endl;
       state=on;
       app->state=true;
   }
     void ueset::turnoffstate(){
         EV<<"turn off the UE: "<<this->name<<endl;
         std::cout<<"turn off the UE: "<<this->name<<endl;
        state=off;
        app->state=off;
        releasepgwaddress();
      // MacNodeId MacId=binder_->getMacNodeId(pgwaddress_.toIPv4());
     //  cModule* tempmodule=L3AddressResolver().findHostWithAddress(pgwaddress_);
     //  const char* pgwname=tempmodule->getFullName();


       //const char* pgwname=binder_->getModuleNameByMacNodeId(MacId);

     //  char* temp;
     //  int numPGW;
     //  numPGW=pgwbinder_->getnumDC();
     //     std::string PGW=pgwname;
     //      int end=PGW.length();
     //      std::string substring=PGW.substr(4,end);
     //      temp=new char[5];

     //     for(int i=0;i<pgwbinder_->numDC;i++){
     //     strcpy(temp,(char*)pgwbinder_->DClist[i]->getDCname());
     //     EV<<"substring:"<<substring<<"temp:"<<temp<<endl;
     //      if(substring==temp) //if pgwname has DCname
     //      {
     //          for(int j=0;j<pgwbinder_->DClist[i]->pgwlist.size();j++)
     //              if(pgwbinder_->DClist[i]->pgwlist[j]->PGWstr==pgwname)
     //              {
     //           EV<<"pgwbinder_->DClist[i]->pgwlist[j]->PGWstr"<<endl;
      //          pgwbinder_->DClist[i]->pgwlist[j]->unregisterUE(UEId);
       //         pgwbinder_->DClist[i]->unregisterUE(UEId);

        //   }
        //   }
        //   }


     }

