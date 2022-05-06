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
    @Binding var captureWindowIsopenInOther : Bool

    var body: some View {
        if captureWindowIsOpen {
            CaptureWindowView(device: device,captureWindowIsOpen: $captureWindowIsOpen).transition(.asymmetric(insertion: .opacity, removal: .opacity))
        } else {
            VStack {
                Text( "Device: " + device.getDevDescription()).bold().font(.system(size: 20))
                Text("Name: " + device.getName()).font(.system(size: 17))
                Text("IPv4 address: " + device.getIPv4Address()).font(.system(size: 17))
                Text("Mac Address: " + device.getMacAddress()).font(.system(size: 17))
                Text ("MTU: " + String(device.getMTU())).font(.system(size: 17))
                Text ("Mode: " + device.getMode()).font(.system(size: 17))
                Text ("Device link layer type : " + device.getLinkLayerType()).font(.system(size: 17))
                Button(action: {
                    withAnimation(){
                        captureWindowIsopenInOther = true
                        captureWindowIsOpen.toggle()

                    }
                }) {
                    Text("Open capture window")
                }
                
            }.onAppear {
                captureWindowIsopenInOther = false
            }
        }
        
        
    }
    

    func openDevice() -> Bool {
        let openedSuccessfully :Bool = device.openDev()
        if (!openedSuccessfully) {
           return true
        } else {
            return false
        }
    }
    
    
    func stopCapture() -> Void {
        device.stopCapture()
        captureWindowIsOpen.toggle()
        captureWindowIsopenInOther.toggle()

    }
}
