//
//  NetworkInterfaceDetailsView.swift
//  SeniorProj
//
//  Created by Jared on 9/21/21.
//

import SwiftUI

struct NetworkInterfaceDetailsView: View {
    let device : PcapCppDevWrapper
    @State var captureWindowIsOpen = false
//    @EnvironmentObject var captureWindowIsOpenGlobal : GlobalIIsCaptureWindowIsOpen
    @ViewBuilder
    var body: some View {
        if captureWindowIsOpen {
            CaptureWindowView(device: device,captureWindowIsOpen: $captureWindowIsOpen).transition(.asymmetric(insertion: .opacity, removal: .opacity))
            
        } else {
            VStack {
                Text( "Device: " + device.getDevDescription()).bold()
                Text("Name: " + device.getName())
                Text("IPv4 address: " + device.getIPv4Address())
                Text("Mac Address: " + device.getMacAddress())
                
                Button(action: {
                    withAnimation(){
                        captureWindowIsOpen.toggle()
//                        captureWindowIsOpenGlobal.captureWindowIsOpen.toggle()
                    }
                }) {
                    Text("Open capture window")
                }
                //            Button(action: {
                //                openDevice()}) {
                //                Text("Open Device")
                //            }
                //            Button(action: {stopCapture()}) {
                //                Text("Stop packet capture")
                //            }
                
            }
        }
        //        .disabled(device.isCapturing())
        
    }
    
    //TODO: Fix alert to alert properly
    func openDevice() -> Void {
        let openedSuccessfully :Bool = device.openDev()
        if (!openedSuccessfully) {
           
        } else {
            
        }
    }
    
    //not needed?
    func stopCapture() -> Void {
        device.stopCapture()
        captureWindowIsOpen.toggle()
        //        var packetArray : [PcapCppPacketWrappper] =  device.getPacketArray() as! [PcapCppPacketWrappper];
        //        print(packetArray.count)
    }
}

//struct NetworkInterfaceDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetworkInterfaceDetailsView()
//    }
//}
