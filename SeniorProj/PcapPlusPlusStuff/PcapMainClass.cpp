//
//  PcapMainClass.cpp
//  SeniorProj
//
//  Created by Jared on 9/20/21.
//
#include "PcapMainClass.hpp"
#include "PcapLiveDeviceList.h"
#include "SystemUtils.h"

int PcapMainClass::getNum() {
    srand(time(nullptr));
    std::string interfaceIPAddr = "35.24.105.9";
    pcpp::PcapLiveDevice* dev = pcpp::PcapLiveDeviceList::getInstance().getPcapLiveDeviceByIp(interfaceIPAddr.c_str());
    std::string result =  dev->getName().c_str();
    std::cout << result;
    return rand() % 150;
}
std::vector<int> PcapMainClass::getDevices() {
    std::vector<int> nums;
    for (int i = 0; i < 10; i++) {
        srand(time(nullptr));
        nums.push_back(rand() % 105);
    }
    return nums;
}

void PcapMainClass::doThing() {

}
