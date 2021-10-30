//
//  PcapThreadCaptureHolder.hpp
//  SeniorProj
//
//  Created by Jared on 10/27/21.
//

#ifndef PcapThreadCaptureHolder_hpp
#define PcapThreadCaptureHolder_hpp

#include <stdio.h>
#include "PcapLiveDevice.h"
#include <iostream>
class PcapThreadCaptureHolder {
public:
    PcapThreadCaptureHolder();
    static void onPacketArrives(pcpp::RawPacket* packet, pcpp::PcapLiveDevice* dev, void* cookie);
private:
    pcpp::PcapLiveDevice *dev;
    
};
#endif /* PcapThreadCaptureHolder_hpp */
