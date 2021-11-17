//
//  PacketArrayManager.swift
//  SeniorProj
//
//  Created by Jared on 11/12/21.
//

import Foundation
import SwiftUI

class PacketArrayManager: NSObject {
    var dev : PcapCppDevWrapper
    var array : [PcapCppPacketWrappper]
    init(dev: PcapCppDevWrapper, packetArray : [PcapCppPacketWrappper]) {
        self.dev = dev
        self.array = packetArray
        super.init()
        self.dev.addObserver(self,forKeyPath: #keyPath(PcapCppDevWrapper.packetArray),options: [.new],context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    }
}
