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

void PcapMain::openPcapFile(std::string filePath) {
    pcpp::IFileReaderDevice* reader = pcpp::IFileReaderDevice::getReader(filePath);
    if (!reader->open()) {
        std::cerr << "Cannot open for reading on filepath " << filePath << std::endl;
        return;
    }
}
void PcapMain::saveFile(std::string filePath) {
    
}
