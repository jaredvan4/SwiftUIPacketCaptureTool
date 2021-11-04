//
//  PcapPacketWrapper.m
//  SeniorProj
//
//  Created by Jared on 10/8/21.
//

#import "PcapCppPacketWrapper.hpp"
#import "PcapLiveDevice.h"

@implementation PcapCppPacketWrappper

- (id) initWithPacket: (void *) aPacket {
    if (self) {
        packet = aPacket;
    }
    return self;
}

- (void) dealloc {
    
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

@end
