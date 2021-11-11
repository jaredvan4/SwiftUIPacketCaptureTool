//
//  PcapMainClassWrapper.h
//  SeniorProj
//
//  Created by Jared on 9/21/21.
#import <Foundation/Foundation.h>

@interface PcapMainWrapper : NSObject {
    
}

- (NSMutableArray *) getDevices;
- (void) openPcapFile : (NSString*)filePath;
- (void) saveFile : (NSString*)filePath;
@end
