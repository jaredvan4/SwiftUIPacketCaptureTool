//
//  PcapMainClass.hpp
//  SeniorProj
//
//  Created by Jared on 9/20/21.
//
#include <iostream>
#include <time.h>
#include <stdlib.h>
#include <vector>
#include "PcapLiveDeviceList.h"
#include "SystemUtils.h"
#include "PcapFileDevice.h"

class PcapMain {
    
public:
    std::vector<pcpp::PcapLiveDevice*> getDevices();
    void openPcapFile(std::string filePath);
    void saveFile(std::string filePath);
};
