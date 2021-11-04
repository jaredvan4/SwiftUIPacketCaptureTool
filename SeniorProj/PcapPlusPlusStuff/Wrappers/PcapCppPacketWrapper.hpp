//
//  PcapCppPacketWrapper.h
//  SeniorProj
//
//  Created by Jared on 10/8/21.
//


#import <Foundation/Foundation.h>
@interface PcapCppPacketWrappper : NSObject {
    void *packet;
}
- (id) initWithPacket: (void *) aPacket;
- (NSString *) getDescription;
- (NSInteger) getLength;
- (void) dealloc;
@end
