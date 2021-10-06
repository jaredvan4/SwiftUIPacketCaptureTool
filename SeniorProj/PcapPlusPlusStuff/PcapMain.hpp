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
class PcapMain {
    
public:
    std::vector<pcpp::PcapLiveDevice*> getDevices();
};
