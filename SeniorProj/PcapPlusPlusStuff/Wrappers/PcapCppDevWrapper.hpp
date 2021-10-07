//
//  PcapCppDevWrapper.h
//  SeniorProj
//
//  Created by Jared on 10/5/21.
//
#import <Foundation/Foundation.h>


@interface PcapCppDevWrapper : NSObject {
    void* dev;
}

- (id) initWithDev:(void *) aDev;

- (NSString *) getName;
- (NSString *) getIPv4Address;
- (NSString *) getDevDescription;
- (NSString *) getMacAddress;
- (Boolean) openDev;
@end
