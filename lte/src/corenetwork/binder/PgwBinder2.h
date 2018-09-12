//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#ifndef _LTE_LTEPGWBINDER2_H_
#define _LTE_LTEPGWBINDER2_H_

#include <omnetpp.h>
#include <string>
#include <iostream>
#include <fstream>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "corenetwork/binder/Pgwinstance.h"
#include "corenetwork/binder/LteBinder.h"
#include "inet/networklayer/contract/ipv4/IPv4ControlInfo.h"
#include "corenetwork/binder/eNBset.h"
#include "corenetwork/binder/DCset.h"
#include "corenetwork/binder/DCinstance.h"
#include "corenetwork/binder/UeSet.h"
#include "corenetwork/binder/controller.h"
#define MAIMUMUEINPGW 10
using namespace inet;


typedef std::pair <std::string,simtime_t> pingpair;
typedef std::vector<std::pair<std::string,simtime_t>> pingvector;
class PgwBinder2 : public cSimpleModule
{
  private:
     // Pgw* pgwlist[50]; // It would be better dynamically allocate by pgwnum
      DC *DClist[50]; // It would be better dynamically allocate by DCnum
      int numPGW;
      int numDC;
      int activeDC;
      int activePGW;
      int activeUE;
      int maximumUEinPGW;
      int maximumUEinDC;
      const char *textname;
      const char *powertextname;
      LteBinder *binder;
      eNBset *eNBsetptr; //not yet used.
      controller *controller_;
      simtime_t selectedping;
      friend class ueset;
  protected:
    virtual int numInitStages() const override { return NUM_INIT_STAGES; }
    virtual void initialize(int stages){
    if(stages==INITSTAGE_PHYSICAL_ENVIRONMENT_2){
        textname=par("textname");
        maximumUEinPGW=par("maximumUEinPGW");
        maximumUEinDC=maximumUEinPGW*3;
        activeDC=0;
        activePGW=0;
        activeUE=0;
        binder=getBinder();
        controller_=check_and_cast<controller*>(getSimulation()->getModuleByPath("controller"));
        showingAssets();
        std::ofstream outFile(textname);
        outFile<<"t connectivity RTT UEname DCname PGWname connectedUE activeDC activePGW DCpower"<<endl;
        outFile.close();
    }
    }

    virtual void handleMessage(cMessage *msg)
    {
    }

      virtual void refreshDisplay() const override;
  public:
      PgwBinder2(): numPGW(0),numDC(0){}
            ~PgwBinder2()
            {
                for(int i=0;i<numDC;i++)
                {
                    delete DClist[i];
                }
            }

    L3Address getPgwAddress();
    L3Address assignPgwAddress();
    //L3Address assignPgwAddress(IPv4Datagram *  address);
    L3Address assignPgwAddress(IPv4Datagram *  address,eNBset *eNBsetptr);
    void registerPGW(char* name);
    //nt findPGWwithMinUE();
    int make_vPGW_for_DC(DC* DCinstance);
    void registerDC(char* name);
    DC* selecDCamonglessRTT(eNBset* eNBsetptr);
    int findDCbystring(std::string name);
    DC* selectDC( std::vector<std::pair<pingpair,DC*>> DCvector);
    DC* RandomselectDC(eNBset* eNBsetptr);
    DC* VoronoiselectDC(eNBset* eNBsetptr);
    void showingAssets();
    int getnumDC(){
        return numDC;
    }
    //L3Address RandomAssign(const char* uename);
    void updateUEinfotoEPC(DC* selectedDC,int PGWindex);
    void updateUEset(const char* uename);
    void decreaseUE(){
        activeUE--;
    }
    void increaseUE(){
            activeUE++;
    }
    void decreaseDC()
    {
        activeDC--;

    }
    void decreasePGW(){
        activePGW--;
    }

    int getactiveUE(){
        return activeUE;
    }
    int getactivePGW(){
        return activePGW;
    }
    int getactiveDC(){
        return activeDC;
    }
};


#endif



