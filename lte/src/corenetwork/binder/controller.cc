//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//


#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "corenetwork/binder/PgwBinder.h"
#include "corenetwork/binder/PgwBinder2.h"
#include "corenetwork/binder/pgwset.h"
#include "corenetwork/binder/controller.h"
Define_Module(controller);
using namespace inet;

   void controller::initialize  (int stage)
    {
       if(stage==13){
        cSimpleModule::initialize(stage);
        selfmsg = new cMessage("selfmsg");
        pgwbinder=getPgwBinder2();
        numUE=0;
        UE.reserve(50);
        R.reserve(50);
        numUE=0;
        counter=1;
        random=par("random");
        randomtime=par("randomtime");
        simtime_t offset=simTime()+randomtime;
        numUEoff=0;
        numUEon=0;
        scheduleAt(offset,selfmsg);
        EV << "\t random starting traffic in " << offset << " seconds " << endl;
       }
    }
void controller::handleMessage(cMessage *msg)
{
    if (msg->isSelfMessage()&&random)
     {
        EV<<"controller received selfmsg"<<endl;
         randomreverse();
     }
}
void controller::randomreverse(){
    /*int temp;
    for(int i=0;i<numUE;i++)
    {
        temp=rand();
        std::cout<<simTime()<<" random: "<<temp<<endl;
        if(temp%10==1)
        {
            std::cout<<simTime()<<" selected: "<<temp<<endl;
            if(UE[i]->state&&UE[i]->isaddress())
                {

                numUEoff++;
                UE[i]->turnoffstate();
                //pgwbinder->decreaseUE();

                }

            else if(!UE[i]->state)
                {
                numUEoff--;
                  UE[i]->turnonstate();
                  //pgwbinder->increaseUE();
                }


            else continue;
        }
    }
    */

    srand(counter++);
    int temp=rand();
    int i=temp%numUE;
    std::cout<<simTime()<<" selected: "<<i<<endl;
                if(UE[i]->state&&UE[i]->isaddress())
                    {

                    numUEoff++;
                    UE[i]->turnoffstate();
                    //pgwbinder->decreaseUE();

                    }

                else if(!UE[i]->state)
                    {
                    numUEoff--;
                      UE[i]->turnonstate();
                      //pgwbinder->increaseUE();
                    }


    scheduleAt(simTime()+0.01,selfmsg);

}
   void controller::refreshDisplay() const
   {

      char buf[100000];
      int len=0;
      int lf=0;  //line feed
     len+=sprintf(buf,"Total UE: %d\n",numUE);
     len+=sprintf(buf+len,"UE ON: %d\n",numUE-numUEoff);

     for(int i=0;i<numUE;i++)
     {
         if(UE[i]->state==1)
         {

             len+=sprintf(buf+len,"[%s]   ",UE[i]->name);
             lf++;
         }
         if(lf==5)
                {
                    len+=sprintf(buf+len,"\n");
                    lf=0;
                }
     }
     len+=sprintf(buf+len,"\n UE off: %d\n",numUEoff);
     lf=0;
     for(int i=0;i<numUE;i++)
          {
              if(UE[i]->state==0)
              {

                  len+=sprintf(buf+len,"[%s]   ",UE[i]->name);
                  lf++;
              }
              if(lf==5)
                             {
                                 len+=sprintf(buf+len,"\n");
                                 lf=0;
                             }
          }

       getDisplayString().setTagArg("t", 0, buf);
   }
   void controller::registerUEtoCtrl(ueset* ueset_)
    {
        char* name=ueset_->getuename();
        EV<<name<<"is registered"<<endl;
        UE[numUE++]=ueset_;

    }
