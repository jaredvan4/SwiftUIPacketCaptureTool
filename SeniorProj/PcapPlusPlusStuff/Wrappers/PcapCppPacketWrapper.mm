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
        pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
        tempPacket->computeCalculateFields();
        id = [NSUUID UUID];
    }
    return self;
}

- (void) dealloc {
    delete (pcpp::Packet *)packet;
}

- (NSInteger) getPacketsDropped {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    return 0;
}
- (NSString *) getSrcAddr {
    return @"placeholder";
}

- (NSInteger) getRawDataLength {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    return tempPacket->getRawPacket()->getRawDataLen();
}

- (NSInteger) getFullLength {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    return 1;
}

- (NSString *)getRawData {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    std::string aStr = std::string((char *)tempPacket->getRawPacket()->getRawData());
    NSString *rawDataStr = [NSString stringWithCString: aStr.c_str() encoding:[NSString defaultCStringEncoding]];
    return rawDataStr;
}

- (NSString *) getDescription {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    std::cout << "obj type" << tempPacket->getRawPacket()->getObjectType();
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
- (NSString *) getLinkType {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
   pcpp::LinkLayerType linkLayerType = tempPacket->getRawPacket()->getLinkLayerType();
    if (linkLayerType == pcpp::LINKTYPE_ETHERNET ) {
        return @"Ethernet";
    }
    if (linkLayerType == pcpp::LINKTYPE_LOOP) {
        return @"Loopback";
    }
    return @"";
}

- (NSString *) getFirstLayerType {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    pcpp::ProtocolType aProtocolType =  tempPacket->getLastLayer()->getProtocol();
    
    std::vector<std::string> list;
    tempPacket->toStringList(list);
    std::cout << "LAYERS------------\n";
    for (std::string aStr : list) {
        std::cout << aStr << "\n";
    }
    std::cout << "end of layers------------\n";

    if (aProtocolType == 1) {
        return @"Ethernet";
    }
//    std::string aProtcolString
    
    return @"hi";
}

- (NSString *) getPacketType {
    return @"placeholder";
}

- (NSInteger) getFrameLength {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    NSInteger frameLen = tempPacket->getRawPacket()->getFrameLength();
    return frameLen;
}

//TODO: return string from timespec struct
- (NSString *) getTimeStamp {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    pcpp::RawPacket *rawPacket = tempPacket->getRawPacket();
    timespec timeStampStruct =  rawPacket->getPacketTimeStamp();
    std::string timeStr = std::to_string(timeStampStruct.tv_nsec);
    NSString *finalTimeStr = [NSString stringWithCString: timeStr.c_str() encoding:[NSString defaultCStringEncoding]];
    return finalTimeStr;
}

- (NSString *) getProtocolType {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
    pcpp::ProtocolType aProtocol = tempPacket->getLastLayer()->getProtocol();
    std::cout << "protocol! " << aProtocol << "\n";
    if (aProtocol == pcpp::SSH) {
        return @"SSH";
    }
    
    if (aProtocol == pcpp::HTTP) {
        return @"HTTP";
    }
    
    if (aProtocol == 32) {
        return @"HTTP Request";
    }
    
    if (aProtocol == 64) {
        return @"HTTP Response";
    }
    if (aProtocol == pcpp::SSL) {
        return @"SSL";
    }
   
    if (aProtocol == pcpp::DNS) {
        return @"DNS";
    }
    
    if (aProtocol == pcpp::UDP) {
        return @"UDP";
    }
    if (aProtocol == pcpp::TCP) {
        return @"TCP";
    }
    
    if (aProtocol == pcpp::IPv6) {
        return @"IPv6";
    }
    
    if (aProtocol == pcpp::IPv4) {
        return @"IPv4";
    }
    
    if (aProtocol == pcpp::ARP_REPLY) {
        return @"ARP reply";
    }
    
    if (aProtocol == pcpp::ARP_REQUEST) {
        return @"ARP request";
    }
    
    if (aProtocol == pcpp::ARP)
        return @"ARP";
    
    if (aProtocol == 16777216) {
        return @"UDP";
    }
    
    if (aProtocol == 536870912) {
        return @"Packet trailer";
    }
    
    if (aProtocol == 524288) {
        return @"DHCP";
    }
    
    if (aProtocol == pcpp::IGMPv1) {
        return @"IGMPv1";
    }
    
    if (aProtocol == pcpp::IGMPv2) {
        return @"IGMPv2";
    }
    
    if (aProtocol == pcpp::IGMPv3) {
        return @"IGMPv3";
    }
    
    if (aProtocol == pcpp::IGMP) {
        return @"IMGP";
    }
    
    if (aProtocol == pcpp::BGP) {
        return @"BGP";
    }
    if (aProtocol == pcpp::ICMP) {
        return @"ICMP";
    }
    
    std::cout << "Unknown" << aProtocol << "\n";
    return @"Unknown";
}
- (void *) getRawPacket {
    pcpp::Packet *tempPacket = (pcpp::Packet*) packet;
//    pcpp::RawPacket *tempRawPacket = new pcpp::RawPacket(*tempPacket->getRawPacket());
//    return tempRawPacket;
    return tempPacket->getRawPacket();

}

@end
