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
                    VStack {
                        Text(devices[index].deviceName!)
                        Text(devices[index].iPv4Address!)
                        Text(devices[index].saySomething())
                        
                    }.accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                }
            }
        }
    }
}
