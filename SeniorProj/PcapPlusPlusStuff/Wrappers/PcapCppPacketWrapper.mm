//
//  PcapPacketWrapper.m
//  SeniorProj
//
//  Created by Jared on 10/8/21.
//

#import "PcapCppPacketWrapper.hpp"

@implementation PcapCppPacketWrappper

- (id) initWithInt: (NSInteger) packetLength {
    if (self) {
        length = packetLength;
    }
    return self;
}
- (NSInteger) getLength {
    return length;
}

@end
