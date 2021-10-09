//
//  PcapMainClassWrapper.m
//  SeniorProj
//
//  Created by Jared on 9/21/21.
//

#import "PcapMainWrapper.hpp"
#import "PcapMain.hpp"
#import "PcapCppDevWrapper.hpp"

@implementation PcapMainWrapper

- (NSMutableArray<PcapCppDevWrapper*> *) getDevices {
    PcapMain pcapMainClass;
    std::vector<pcpp::PcapLiveDevice*> devices = pcapMainClass.getDevices();
    NSMutableArray<PcapCppDevWrapper*> *devicesArray = [NSMutableArray arrayWithCapacity:devices.size()];
    for (pcpp::PcapLiveDevice* dev : devices) {
        PcapCppDevWrapper *newDevWrapper = [[PcapCppDevWrapper alloc] initWithDev:dev];
        [devicesArray addObject:newDevWrapper];
    }
    return devicesArray;
}

@end

