//
//  ContentView.swift
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

import SwiftUI

struct MainView: View {
    var devicesArray : [PcapCppDevWrapper] = PcapMainWrapper().getDevices() as! [PcapCppDevWrapper]
    
    var testDevices :[NetworkInterface] = [NetworkInterface(iPv4Address: "127.0.0.1", deviceName: "en0", status: false),NetworkInterface(iPv4Address: "1.1.1.1.1.1.1.0", deviceName: "Etho0", status: true)]
    var body: some View {

        Text("Live devices")
        VSplitView {
            NetworkInterfaceSelectorView(devices:devicesArray)
        }.frame(minWidth: 600, minHeight: 400).frame(width: nil)
    }
}

