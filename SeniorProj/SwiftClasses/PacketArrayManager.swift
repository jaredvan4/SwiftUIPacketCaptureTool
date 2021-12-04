//
//  PacketArrayManager.swift
//  SeniorProj
//
//  Created by Jared on 11/12/21.
//

import Foundation
import SwiftUI

class PacketArrayManager: ObservableObject {
    var dev : PcapCppDevWrapper
    var timer : Timer? = Timer()
    @Published var tempPacketArr = [PcapCppPacketWrappper]()

    init(dev: PcapCppDevWrapper) {
        self.dev = dev
   }
    
    func startTimerFunction() -> Void {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.tempPacketArr = self.dev.getPacketArray() as NSArray as! [PcapCppPacketWrappper]
            })
    }
    func stopTimerFunction() -> Void {
        self.timer?.invalidate()
    }
    //    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    //
    //    }
}
