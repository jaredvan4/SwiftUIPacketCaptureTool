//
//  NetworkInterfaceDetailsView.swift
//  SeniorProj
//
//  Created by Jared on 9/21/21.
//

import SwiftUI

struct NetworkInterfaceDetailsView: View {
    @State private var deviceOpened = false
    let device : PcapCppDevWrapper
    var body: some View {
        VStack {
            Text( "Description!" + device.getDevDescription()).bold()
            Text("Name: " + device.getName())
            Text("IPv4 address: " + device.getIPv4Address())
            Text("Mac Address: " + device.getMacAddress())
            
                            Button(action: {openDevice()}) {
                                Text("Open Device")
                            }
            
            //                Button (action: {stopCapture()}) {
            //                    Text("Stop cpature")
            //                }
            
            
            
        }
    }
    //TODO: Fix alert to alert properly
    func openDevice() -> Void {
        let openedSuccessfully :Bool = device.openDev()
        if (!openedSuccessfully) {
            Alert(title: Text("Attempting to open device"), message: Text("Failed to open device :("),primaryButton: .destructive(Text("Ok")),secondaryButton:.cancel() )
        }
    }
    func stopCapture() -> Void {
        device.stopCapture()
    }
}

//struct NetworkInterfaceDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetworkInterfaceDetailsView()
//    }
//}
