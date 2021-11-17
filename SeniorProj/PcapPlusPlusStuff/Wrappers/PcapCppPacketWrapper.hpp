//
//  PcapCppPacketWrapper.h
//  SeniorProj
//
//  Created by Jared on 10/8/21.
//


#import <Foundation/Foundation.h>
@interface PcapCppPacketWrappper : NSObject {
    void *packet;
    NSUUID *id;
}
- (id) initWithPacket: (void *) aPacket;
- (NSString *) getDescription;
- (NSInteger) getLength;
- (NSMutableArray*) getDescriptionAsLayers;
- (NSString *) getTimeStamp;
- (NSString *) getPacketType;
- (NSString *) getProtocolType;
- (void *) getRawPacket;
- (void) dealloc;
@end
