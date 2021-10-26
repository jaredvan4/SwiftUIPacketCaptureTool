//
//  PcapDevWrapper.m
//  SeniorProj
//
//  Created by Jared on 10/5/21.
//

#import <Foundation/Foundation.h>
#import "PcapCppDevWrapper.hpp"
#import "PcapLiveDevice.h"
#include <thread>

@implementation PcapCppDevWrapper


- (id) initWithDev:(void*) aDev {
    if (self) {
        dev = aDev;
        captureActive = false;
    }
    return self;
}

- (NSString *) getName {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    NSString *str  = [NSString stringWithCString:tempDev->getName().c_str() encoding:[NSString defaultCStringEncoding]];
    return str;
}

- (NSString *) getIPv4Address {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    std::string tempStr = tempDev->getIPv4Address().toString();
    NSString *strOfIPv4Address = [NSString stringWithCString:tempStr.c_str() encoding:[NSString defaultCStringEncoding]];
    return strOfIPv4Address;
}

- (NSString *) getDevDescription {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    std::string tempStr = tempDev->getDesc();
    NSString *descriptionStr = [NSString stringWithCString:tempStr.c_str() encoding:[NSString defaultCStringEncoding]];
    return descriptionStr;
}

- (NSString *) getMacAddress {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    std::string tempStr = tempDev->getMacAddress().toString();
    NSString *macAddressStr = [NSString stringWithCString:tempStr.c_str() encoding:[NSString defaultCStringEncoding]];
    return macAddressStr;
}

- (Boolean) openDev {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    Boolean result = tempDev->open();
    if(result == true) {
        [self startCapture];
        return true;
    }
    return false;
}

//TODO: Fix below to be asynchronous ( <--- spelled wrong) , at the moment it just sleeps to allow capture to occur

- (void) startCapture {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
//    tempDev->startCapture([self onPacketArrives],&tempDev);
    [self performSelectorInBackground:@selector(lessThanIdealAsyncCapture) withObject:nil];
    return;
//    pcpp::RawPacketVector packetVector;
//    tempDev->startCapture(packetVector);
//    pcpp::multiPlatformSleep(6);
//    tempDev->stopCapture();
//    for (pcpp::RawPacket *packet : packetVector) {
//                pcpp::Packet aPacket = packet;
//                printf("len of packet data: %u\n", packet->getRawDataLen());
//            }
//    tempDev->close();
//    tempDev->startCapture([self onPacketArrive], void *onPacketArrivesUserCookie);
    //    pcpp::RawPacketVector packetVector;
//    if (tempDev->isOpened()) {
//        tempDev->startCapture(packetVector);
//        sleep(4);
//        tempDev->stopCapture();
//        for (pcpp::RawPacket *packet : packetVector) {
//            pcpp::Packet aPacket = packet;
//            printf("len of packet data: %u\n", packet->getRawDataLen());
//        }
//        tempDev->close();
//    }
    
}
- (void) onPacketArrives {
    
}

- (void) stopCapture {
    captureActive = false;
}

- (void) closeDev {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    tempDev->close();
}

- (void) onPacketArrive : (void*) packetArrived : (void*) pcapLiveDev : (void *)cookie {
    pcpp::Packet parsedPacket ((pcpp::RawPacket*) packetArrived);
}
//TODO: use async callback, high cpu usage
- (void) lessThanIdealAsyncCapture {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    pcpp::RawPacketVector packetVector;
    tempDev->startCapture(packetVector);
    captureActive = true;
    while (captureActive) {
        //wait for user to end capture
    }
    tempDev->stopCapture();
    packetArray = [NSMutableArray arrayWithCapacity:packetVector.size()];
    for (pcpp::RawPacket *packet : packetVector) {
        PcapCppPacketWrappper *newPacketWrapper = [[PcapCppPacketWrappper alloc] initWithInt:packet->getRawDataLen()];
        [packetArray addObject:newPacketWrapper];
    }
}

- (NSMutableArray<PcapCppPacketWrappper*>*) getPacketArray {
    return packetArray;
}

@end

