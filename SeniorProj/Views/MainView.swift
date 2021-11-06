//
//  ContentView.swift
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

import SwiftUI

struct MainView: View {
    var pcapMainInstance : PcapMainWrapper
    var devicesArray : [PcapCppDevWrapper]
    var body: some View {
        VSplitView {
            NetworkInterfaceSelectorView(devices:devicesArray)
//            CaptureWindowView()
        }.frame(minWidth: 800, minHeight: 500).frame(width: nil)
    }
    
    init (pcapMain : PcapMainWrapper) {
        self.pcapMainInstance = pcapMain
        self.devicesArray  = pcapMain.getDevices() as! [PcapCppDevWrapper]
    }
 
}

