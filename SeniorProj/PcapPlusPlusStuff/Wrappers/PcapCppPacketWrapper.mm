//
//  PcapPacketWrapper.m
//  SeniorProj
//
//  Created by Jared on 10/8/21.
//

#import "PcapCppPacketWrapper.hpp"

@implementation PcapCppPacketWrappper

- (id) initWithPacket: (void *) aPacket {
    if (self) {
        packet = aPacket;
    }
    return self;
}
- (NSInteger) getLength {
    return length;
}

@end
