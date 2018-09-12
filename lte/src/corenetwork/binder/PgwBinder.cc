//
//                           SimuLTE
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

#include "corenetwork/binder/PgwBinder.h"
#include "corenetwork/deployer/LteDeployer.h"
#include "inet/networklayer/common/L3AddressResolver.h"
#include <cctype>
#include "corenetwork/nodes/InternetMux.h"

using namespace std;

Define_Module(PgwBinder);



L3Address PgwBinder::getPgwAddress(){
    Enter_Method("getPgwAddress");
    L3Address pgwAddress_;
    pgwAddress_ = L3AddressResolver().resolve("pgw");
    return pgwAddress_;
}


