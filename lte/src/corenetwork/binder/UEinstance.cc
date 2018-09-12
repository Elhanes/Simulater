
#include <omnetpp.h>
#include <string>
#include "common/LteCommon.h"
#include "inet/networklayer/contract/ipv4/IPv4Address.h"
#include "inet/networklayer/common/L3Address.h"
#include "common/LteCommon.h"
#include "corenetwork/binder/LteBinder.h"
#include "corenetwork/binder/UEinstance.h"

using namespace inet;


char* UEinstance::getUEname(){
    return this->UEname;
}
