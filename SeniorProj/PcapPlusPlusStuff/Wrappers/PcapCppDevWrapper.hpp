//
//  PcapCppDevWrapper.h
//  SeniorProj
//
//  Created by Jared on 10/5/21.
//
#import <Foundation/Foundation.h>
#import "PcapCppPacketWrapper.hpp"



@interface PcapCppDevWrapper : NSObject {
    void* dev;
    bool captureActive;
    NSMutableArray<PcapCppPacketWrappper*>* packetArray;
}


- (id) initWithDev:(void *) aDev;
-(void)addToPacketArray:(PcapCppPacketWrappper*) aPacket;
- (void)emptyArray;
- (NSString *) getLinkLayerType;
- (NSInteger) getMTU;
- (NSString *) getName;
- (NSString *) getMode;
- (NSString *) getIPv4Address;
- (NSString *) getDevDescription;
- (NSString *) getMacAddress;
- (Boolean) openDev;
- (NSMutableArray<PcapCppPacketWrappper*>*) getPacketArray;
- (Boolean) isCapturing;
- (void) startCapture;
- (void) closeDev;
- (void) stopCapture;
- (void) onPacketArrive : (void*) packetArrived : (void*) pcapLiveDev : (void *)cookie;
- (void) asyncCaptureStart;
- (Boolean) savePcapFile : (NSString *) filePath;
@end
