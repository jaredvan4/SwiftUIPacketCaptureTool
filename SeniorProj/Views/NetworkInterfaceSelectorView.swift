//
//  NetworkInterfaceSelectorView.swift
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

import SwiftUI
//TODO: Make this a searchable collection of Devices?

struct NetworkInterfaceSelectorView : View {
    @State private var searchQuery = ""
    let devices : [PcapCppDevWrapper]
    var body: some View {
        NavigationView {
            
            List {
                Text("Live Devices").font(.largeTitle)
                ForEach (devices.indices) { index in
                    HStack{
                        Divider()
                        VStack {
                            NavigationLink(
                                destination: NetworkInterfaceDetailsView(device: devices[index]),
                                label: {
                                    Text(devices[index].getName())
                                })

                        }.accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/) //vstack ends here
                    }
                }
            }
        }.navigationTitle(Text("Senior Project"))
    }
}


