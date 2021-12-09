//
//  NetworkInterfaceSelectorView.swift
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

import SwiftUI
//TODO: Make this a searchable collection of Devices?
//TODO: Disable device picker when active cpature 
struct NetworkInterfaceSelectorView : View {
    @State private var searchQuery = ""
    @State var captureWindowisOpenInOther = false
    let devices : [PcapCppDevWrapper]
    var body: some View {
        
        NavigationView {
            List {
                Text("Live Devices").font(.largeTitle)
                ForEach (devices.indices) { index in
                    HStack {
                        Divider()
                        VStack {
                            NavigationLink(                                destination: NetworkInterfaceDetailsView(device: devices[index], captureWindowIsopenInOther: $captureWindowisOpenInOther),
                                                                           label: {
                                Text(devices[index].getName())
                            }).disabled(captureWindowisOpenInOther)
                            
                        }//vstack ends here
                    }
                }
            }
        }.navigationTitle(Text(""))
        
    }
}



