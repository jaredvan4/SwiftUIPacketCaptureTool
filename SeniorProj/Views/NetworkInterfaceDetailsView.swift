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
    @Environment(\.openURL) var openURL
    var body: some View {
        VStack {
//            NavigationView {
//                NavigationLink(destination: CaptureWindowView(aDevice: device),label: {
//                    Text("captureing")
//                })
//            }
            Text( "Description!" + device.getDevDescription()).bold()
            Text("Name: " + device.getName())
            Text("IPv4 address: " + device.getIPv4Address())
            Text("Mac Address: " + device.getMacAddress())

            Button(action: {
                if let url = URL(string: "myappname://CaptureWindowView"){
                openURL(url)}
                
            }) {
                Text("Open capture window")
            }
            Button(action: {openDevice()}) {
                Text("Open Device")
            }
            Button(action: {stopCapture()}) {
                Text("Stop packet capture")
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
        } else {
            
        }
    }
    func stopCapture() -> Void {
        device.stopCapture()
//        var packetArray : [PcapCppPacketWrappper] =  device.getPacketArray() as! [PcapCppPacketWrappper];
//        print(packetArray.count)
    }
}

//struct NetworkInterfaceDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetworkInterfaceDetailsView()
//    }
//}
