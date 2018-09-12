//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#include "corenetwork/binder/DCset.h"
#include "inet/common/ModuleAccess.h"
#include "inet/applications/pingapp/PingApp2.h"
//#include "apps/pingapp/PingApp2.h"
#include "common/LteCommon.h"
#include <string>
using namespace inet;
Define_Module(DCset);

   void DCset::initialize(int stage)
   {
       cSimpleModule::initialize(stage);
       pgwbinder=getPgwBinder2();
       if(stage == INITSTAGE_LOCAL){

       char* name=(char *)getParentModule()->getFullName();
       EV<<"register this DC which of name is [ "<<name<<"]!!!!!!!!!!!!!!!!!!"<<endl;
       pgwbinder->registerDC(name);
       }
   }
