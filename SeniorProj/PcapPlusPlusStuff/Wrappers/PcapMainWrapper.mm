//
//  PcapMainClassWrapper.m
//  SeniorProj
//
//  Created by Jared on 9/21/21.
//

#import "PcapMainWrapper.hpp"
#import "PcapMain.hpp"
#import "PcapCppDevWrapper.hpp"

@implementation PcapMainWrapper

- (NSMutableArray<PcapCppDevWrapper*> *) getDevices {
    PcapMain pcapMainClass;
    std::vector<pcpp::PcapLiveDevice*> devices = pcapMainClass.getDevices();
    NSMutableArray<PcapCppDevWrapper*> *devicesArray = [NSMutableArray arrayWithCapacity:devices.size()];
    for (pcpp::PcapLiveDevice* dev : devices) {
        PcapCppDevWrapper *newDevWrapper = [[PcapCppDevWrapper alloc] initWithDev:dev];
        [devicesArray addObject:newDevWrapper];
    }
    return devicesArray;
}


//TODO: not the greates error handling

- (NSMutableArray*) openPcapFile : (NSString*) filePath {
    std::string filePathTemp = std::string([filePath UTF8String]);
    pcpp::PcapFileReaderDevice reader(filePathTemp);
    NSMutableArray* anEmptyArray;
    if (!reader.open()){
        std::cerr << "Cannot open" << filePathTemp << "for writing" << std::endl;
        return anEmptyArray;
    } else {
        std::vector<pcpp::Packet*> packetVectorFromFile;
        pcpp::RawPacket aRawPacket;
        while(reader.getNextPacket(aRawPacket)) {
            pcpp::RawPacket* tempRawCopy = new pcpp::RawPacket(aRawPacket);
            pcpp::Packet *tempPacket = new pcpp::Packet(tempRawCopy);
            packetVectorFromFile.push_back(tempPacket);
        }
        NSMutableArray <PcapCppPacketWrappper*>* packetArray = [NSMutableArray arrayWithCapacity: packetVectorFromFile.size()];
        for (pcpp::Packet *aPacket : packetVectorFromFile) {
            PcapCppPacketWrappper *newPacketWrapper = [[PcapCppPacketWrappper alloc] initWithPacket:aPacket];
            [packetArray addObject:newPacketWrapper];
        }
        return packetArray;
    }
//    std::string filePathTemp = std::string([filePath UTF8String]);
//    pcpp::PcapNgFileReaderDevice reader(filePathTemp);
//    NSMutableArray* anEmptyArray;
//    if (!reader.open()){
//        std::cerr << "Cannot open" << filePathTemp << "for writing" << std::endl;
//        return anEmptyArray;
//    } else {
//        std::vector<pcpp::Packet*> packetVectorFromFile;
//        pcpp::RawPacket aRawPacket;
//        while(reader.getNextPacket(aRawPacket)) {
//            pcpp::RawPacket* tempRawCopy = new pcpp::RawPacket(aRawPacket);
//            pcpp::Packet *tempPacket = new pcpp::Packet(tempRawCopy);
//            packetVectorFromFile.push_back(tempPacket);
//        }
//        NSMutableArray <PcapCppPacketWrappper*>* packetArray = [NSMutableArray arrayWithCapacity: packetVectorFromFile.size()];
//        for (pcpp::Packet *aPacket : packetVectorFromFile) {
//            PcapCppPacketWrappper *newPacketWrapper = [[PcapCppPacketWrappper alloc] initWithPacket:aPacket];
//            [packetArray addObject:newPacketWrapper];
//        }
//        return packetArray;
//    }
}

- (void) saveFile : (NSString *) filePath {
    std::string filePathTemp = std::string([filePath UTF8String]);
    
}
@end

