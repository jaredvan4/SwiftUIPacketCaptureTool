//
//  PcapThreadCaptureHolder.cpp
//  SeniorProj
//
//  Created by Jared on 10/27/21.
//

#include "PcapThreadCaptureHolder.hpp"

PcapThreadCaptureHolder::PcapThreadCaptureHolder() {
    
}

void PcapThreadCaptureHolder::onPacketArrives(pcpp::RawPacket *packet, pcpp::PcapLiveDevice *dev, void *cookie) {
    std::cout << "thread captured!\n";
}
