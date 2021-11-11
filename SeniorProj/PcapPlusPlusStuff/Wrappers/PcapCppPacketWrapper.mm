//
//  PcapPacketWrapper.m
//  SeniorProj
//
//  Created by Jared on 10/8/21.
//

#import "PcapCppPacketWrapper.hpp"
#import "PcapLiveDevice.h"
#include <iostream>

@implementation PcapCppPacketWrappper

- (id) initWithPacket: (void *) aPacket {
    if (self) {
        packet = aPacket;
        id = [NSUUID UUID];
    }
    return self;
}

- (void) dealloc {
    delete (pcpp::Packet *)packet;
}

- (NSInteger) getLength {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    return tempPacket->getRawPacket()->getRawDataLen();
}

- (NSString *) getDescription {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    NSString *description = [NSString stringWithCString: tempPacket->toString().c_str() encoding:[NSString defaultCStringEncoding]];
    return description;
}

- (NSMutableArray *) getDescriptionAsLayers {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    std::vector<std::string> descriptionAsLayers;
    tempPacket->toStringList(descriptionAsLayers);
    NSMutableArray *resultArrayOfStrings = [NSMutableArray arrayWithCapacity:descriptionAsLayers.size()];
    for (std::string str : descriptionAsLayers) {
        NSString *aLayerStr = [NSString stringWithCString: str.c_str() encoding: [NSString defaultCStringEncoding]];
        [resultArrayOfStrings addObject:aLayerStr];
    }
    return resultArrayOfStrings;
}
- (NSString *) getPacketType {
    return @"placeholder";
}

//TODO: return string from timespec struct
- (NSString *) getTimeStamp {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    pcpp::RawPacket *rawPacket = tempPacket->getRawPacket();
    timespec timeStampStruct =  rawPacket->getPacketTimeStamp();
    return @"placeholder";
}

- (NSString *) getProtocolType {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    pcpp::RawPacket *rawPacket = tempPacket->getRawPacket();
    return @"Placeholder";
}

@end
