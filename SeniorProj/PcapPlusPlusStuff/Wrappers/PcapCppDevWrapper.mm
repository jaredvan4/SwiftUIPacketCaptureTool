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
#include "PcapFileDevice.h"


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
- (NSInteger) getMTU {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
     int mtu = tempDev->getMtu();
    return mtu;
}

- (NSString *) getMode {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    if (tempDev->Promiscuous) {
        return @"Promiscuous";
    } else  {
        return @"Normal";
    }
}

- (NSString *) getLinkLayerType {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    pcpp::LinkLayerType aType = tempDev->getLinkType();
    std::cout << aType << "\n";
    if (aType == 0) {
        return @"Loopback";
    }
    if (aType == pcpp::LINKTYPE_ETHERNET) {
        return @"Ethernet";
    }
    return @"Unknown";
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
    if (result) {
        [self startCapture];
        return true;
    }
    
    return false;
}


- (void) startCapture {
//    tempDev->startCapture(PcapThreadCaptureHolder::onPacketArrives,&tempDev);
    [self performSelectorInBackground:@selector(asyncCaptureStart) withObject:nil];
    captureActive = true;
    return;


}


- (Boolean) isCapturing {
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

- (void) onPacketArrive : (void*) packetArrived : (void*) pcapLiveDev : (void *)cookie {
    pcpp::Packet parsedPacket ((pcpp::RawPacket*) packetArrived);
}

//hand nsobj over to corefoundation framework from obj c land
- (void) asyncCaptureStart {
    pcpp::PcapLiveDevice *tempDev = (pcpp::PcapLiveDevice*) dev;
    tempDev->startCapture(onPacketArrives,(void *)CFBridgingRetain(self));
    return;
}

- (void)addToPacketArray:(PcapCppPacketWrappper*) aPacket {
    [packetArray addObject:aPacket];
//    NSLog(@"array is size: %lu ",(unsigned long)packetArray.count);
}

- (NSMutableArray<PcapCppPacketWrappper*>*) getPacketArray {
    return packetArray;
}

- (Boolean) savePcapFile : (NSString *) filePath {
    std::string filePathTemp = std::string([filePath UTF8String]);
    pcpp::PcapNgFileWriterDevice writer(filePathTemp);
    // try to open the file for writing
    if (!writer.open()){
        std::cerr << "Cannot open" << filePathTemp << "for writing" << std::endl;
        return false;
    }

    for (PcapCppPacketWrappper* aPacketWrapper in packetArray) {
        std::cout << "writing packets\n";
        pcpp::RawPacket *aPacketPtr = (pcpp::RawPacket*)aPacketWrapper.getRawPacket;
        std::cout << "a description of file being saved : " <<  aPacketWrapper.getDescription << "\n";
               writer.writePacket(*aPacketPtr);
    }
    writer.close();
    return true;
}

//Bridge pointer back to Obj c type
//Add to packet array when packet arrives
//Note : Temp raw should be free'd by Packet class deconstructor automatically
 static void onPacketArrives (pcpp::RawPacket *rawPacket, pcpp::PcapLiveDevice *dev, void *cookie) {
     PcapCppDevWrapper *aDev = (__bridge PcapCppDevWrapper*)cookie;
     pcpp::RawPacket* tempRawCopy = new pcpp::RawPacket;
     tempRawCopy->setRawData(rawPacket->getRawData(), rawPacket->getRawDataLen(), rawPacket->getPacketTimeStamp(),rawPacket->getLinkLayerType(),rawPacket->getFrameLength());
     pcpp::Packet *nonRawPacket = new pcpp::Packet(tempRawCopy);
     PcapCppPacketWrappper *newPacketWrapper = [[PcapCppPacketWrappper alloc] initWithPacket:nonRawPacket];
     [aDev addToPacketArray:newPacketWrapper];
}

@end

