//
//  PcapCppDevWrapper.h
//  SeniorProj
//
//  Created by Jared on 10/5/21.
//
#import <Foundation/Foundation.h>
#import "PcapCppPacketWrapper.hpp"

//TODO: Array below being public is bad practice? I need to constantly be able to access it from
//swift views

@interface PcapCppDevWrapper : NSObject {
    void* dev;
    bool captureActive;
    NSMutableArray<PcapCppPacketWrappper *> *packetArray;
}

- (id) initWithDev:(void *) aDev;

- (NSString *) getName;
- (NSString *) getIPv4Address;
- (NSString *) getDevDescription;
- (NSString *) getMacAddress;
- (Boolean) openDev;
- (NSMutableArray<PcapCppPacketWrappper*>*) getPacketArray;
- (void) startCapture;
- (void) closeDev;
- (void) stopCapture;
- (void) onPacketArrive : (void*) packetArrived : (void*) pcapLiveDev : (void *)cookie;
- (void) lessThanIdealAsyncCapture;
@end
