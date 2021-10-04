//
//  NetworkInterfaceSelectorView.swift
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

import SwiftUI

struct NetworkInterfaceSelectorView : View {
    let devices : [NetworkInterface]
    var body: some View {
        NavigationView {
            List {
                Text("Devices").font(.largeTitle)
                ForEach (devices.indices) { index in
                    HStack{
                        Circle().fill(devices[index].status == true ? Color.green : Color.red).frame(width: 15, height: 15).help(devices[index].status == true ? "Device available" : "Device offline")
                        Divider()
                        VStack {
                            NavigationLink(
                                destination: NetworkInterfaceDetailsView(device: devices[index]),
                                label: {
                                }).disabled(!devices[index].status!)
                            Text(devices[index].deviceName!)
                            
                        }.accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/) //vstack ends here
                    }
                    
                }
            }
        }.navigationTitle(Text("Senior Project"))
    }
}
