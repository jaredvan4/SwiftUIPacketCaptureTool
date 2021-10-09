//
//  PcapMainClass.cpp
//  SeniorProj
//
//  Created by Jared on 9/20/21.
//
#include "PcapMain.hpp"


std::vector<pcpp::PcapLiveDevice*> PcapMain::getDevices() {
    std::vector<pcpp::PcapLiveDevice*> devices = pcpp::PcapLiveDeviceList::getInstance().getPcapLiveDevicesList();
    return devices;
    
}
