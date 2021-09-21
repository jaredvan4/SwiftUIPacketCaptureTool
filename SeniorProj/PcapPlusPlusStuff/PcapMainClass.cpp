//
//  PcapMainClass.cpp
//  SeniorProj
//
//  Created by Jared on 9/20/21.
//
#include "PcapMainClass.hpp"

int PcapMainClass::getNum() {
    srand(time(nullptr));
    return rand() % 150;
}
std::vector<int> getDevices() {
    std::vector<int> nums;
    for (int i = 0; i < 10; i ++) {
        srand(time(nullptr));
        nums.push_back(rand() % 105);
    }
    return nums;
}
