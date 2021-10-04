//
//  NetworkInterfaceDetailsView.swift
//  SeniorProj
//
//  Created by Jared on 9/21/21.
//

import SwiftUI

struct NetworkInterfaceDetailsView: View {
    let device : NetworkInterface
    var body: some View {
        VStack{
            Text("Name: " + device.deviceName!)
            Text("IPv4 address: " + device.iPv4Address!)
        }
    }
}

//struct NetworkInterfaceDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetworkInterfaceDetailsView()
//    }
//}
