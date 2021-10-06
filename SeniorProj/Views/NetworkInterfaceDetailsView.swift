//
//  NetworkInterfaceDetailsView.swift
//  SeniorProj
//
//  Created by Jared on 9/21/21.
//

import SwiftUI

struct NetworkInterfaceDetailsView: View {
    let device : PcapCppDevWrapper
    var body: some View {
        VStack {
            Text( "Description!" + device.getDevDescription()).bold()
            Text("Name: " + device.getName())
            Text("IPv4 address: " + device.getIPv4Address())
        }
    }
}

//struct NetworkInterfaceDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetworkInterfaceDetailsView()
//    }
//}
