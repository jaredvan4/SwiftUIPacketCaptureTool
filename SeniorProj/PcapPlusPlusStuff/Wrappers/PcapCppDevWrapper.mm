//
//  PcapDevWrapper.m
//  SeniorProj
//
//  Created by Jared on 10/5/21.
//

#import <Foundation/Foundation.h>
#import "PcapCppDevWrapper.hpp"
#import "PcapLiveDevice.h"
#import "PcapThreadCaptureHolder.hpp"

@implementation PcapCppDevWrapper

//init with 35 as it seems like reasonable starting size for the packet array

- (id) initWithDev:(void*) aDev {
    if (self) {
        dev = aDev;
        captureActive = false;
        packetArray = [NSMutableArray arrayWithCapacity:35];
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

//opens device and starts capture
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
//    tempDev->startCapture(PcapThreadCaptureHolder::onPacketArrives,&tempDev);
    [self performSelectorInBackground:@selector(asyncCaptureStart) withObject:nil];
    captureActive = true;
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


- (bool) isCapturing {
    return captureActive;
}
- (void) emptyArray {
    [packetArray removeAllObjects];
}

- (void) stopCapture {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    if (tempDev->captureActive()) {
        tempDev->stopCapture();
        [self closeDev];
        return;
    }
    NSLog(@"Device already closed");
}

- (void) closeDev {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    tempDev->close();
}
//below not used

- (void) onPacketArrive : (void*) packetArrived : (void*) pcapLiveDev : (void *)cookie {
    pcpp::Packet parsedPacket ((pcpp::RawPacket*) packetArrived);
}

- (void) asyncCaptureStart {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    tempDev->startCapture(onPacketArrives,(void *)CFBridgingRetain(self));
    return;
//    while (captureActive) {
//    }
//    tempDev->stopCapture();
//    packetArray = [NSMutableArray arrayWithCapacity:packetVector.size()];
//    for (pcpp::RawPacket *packet : packetVector) {
//        PcapCppPacketWrappper *newPacketWrapper = [[PcapCppPacketWrappper alloc] initWithInt:packet->getRawDataLen()];
//        [packetArray addObject:newPacketWrapper];
//        NSLog(@"%i",packet->getRawDataLen());
//    }
}

- (void)addToPacketArray:(PcapCppPacketWrappper*) aPacket {
    [packetArray addObject:aPacket];
//    NSLog(@"array is size: %lu ",(unsigned long)packetArray.count);
}

- (NSMutableArray<PcapCppPacketWrappper*>*) getPacketArray {
    return packetArray;
}


//Add to packet array when packet arrives
//TODO: Fix memory leak of nonRawPacket

 static void onPacketArrives (pcpp::RawPacket *rawPacket, pcpp::PcapLiveDevice *dev, void *cookie) {
     PcapCppDevWrapper *aDev = (__bridge PcapCppDevWrapper*)cookie;
     pcpp::Packet *nonRawPacket;
     nonRawPacket = new pcpp::Packet(rawPacket);
     PcapCppPacketWrappper *newPacketWrapper = [[PcapCppPacketWrappper alloc] initWithPacket:nonRawPacket];
     [aDev addToPacketArray:newPacketWrapper];
}

@end

