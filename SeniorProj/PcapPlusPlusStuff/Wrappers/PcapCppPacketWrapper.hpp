//
//  PcapCppPacketWrapper.h
//  SeniorProj
//
//  Created by Jared on 10/8/21.
//


#import <Foundation/Foundation.h>
@interface PcapCppPacketWrappper : NSObject {
    NSInteger length;
    void *packet;
}
- (id) initWithPacket: (void *) aPacket;
- (NSInteger) getLength;
@end
