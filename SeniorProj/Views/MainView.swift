//
//  ContentView.swift
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

import SwiftUI

struct MainView: View {
    var testDevices :[NetworkInterface] = [NetworkInterface(iPv4Address: "127.0.0.1", deviceName: "some fake device", status: false),NetworkInterface(iPv4Address: "1.1.1.1.1.1.1.0", deviceName: "another fake test device", status: true)]
    var body: some View {
        Text(String(PcapMainClassWrapper().getNum()))
        VSplitView {
            NetworkInterfaceSelectorView(devices:testDevices)
        }.frame(minWidth: 600, minHeight: 400).frame(width: nil)
    }
}
