//
//  PcapMainClassWrapper.m
//  SeniorProj
//
//  Created by Jared on 9/21/21.
//

#import <Foundation/Foundation.h>
#import "PcapMainClassWrapper.h"
#import "PcapMainClass.hpp"

@implementation PcapMainClassWrapper

- (int) getNum {
    PcapMainClass pcapClass;
    int num = pcapClass.getNum();
    return num;
}
//- (NSArray *) getDevices {
//    PcapMainClass pcapInstance;
//    NSArray devices = pcapInstance.getDevices();
//}
@end

