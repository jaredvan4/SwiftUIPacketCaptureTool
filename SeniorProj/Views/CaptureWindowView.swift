//
//  CaptureWindowView.swift
//  SeniorProj
//
//  Created by Jared on 10/27/21.
//

import SwiftUI
//TODO: Packet array not updating dynamically

struct CaptureWindowView: View {
    var aDevice : PcapCppDevWrapper
    @State var packets : [PcapCppPacketWrappper]
    @State private var showExitAlert = false
    @Binding var captureWindowIsOpen: Bool
    var body: some View {
        //having the random toolbar is probably stupid, but idk what else to put there to allow a toolbar to exist
        
        Divider().toolbar {
            ToolbarItem(placement:.principal) {
                Button(action: {
                            startCapture()}) {
                                Text("Start Capture").foregroundColor(Color.black)
                            }.background(Color.green).cornerRadius(8)
            }
            ToolbarItem(placement: .principal ){
                Button(action: {
                                stopCapture()
                                
                            }) {
                                Text("stop capture").foregroundColor(Color.black)
                            }.background(Color.red).cornerRadius(8)
            }
            ToolbarItem(placement: .principal) {
                Button(action: {
                    showExitAlert = true
                }) {
                    Text("exit").foregroundColor(Color.white).cornerRadius(8)
                    
                }.alert(isPresented: $showExitAlert){
                    Alert(
                        title: Text("Exit"), message: Text("Are you sure you want to exit?\nThis will stop any active capture on this device & any unsaved data will be lost"), primaryButton: .destructive(Text("Yes")) {
                            withAnimation() {
                                aDevice.stopCapture()
                                captureWindowIsOpen.toggle()
                            }
                        },secondaryButton: .cancel()
                        
                    )
                }
            }
            
        }
            ScrollView  {
                ForEach (self.packets.indices) { index in
                    
                }
            }
        
    }
    
    //constructor for view
    init (device : PcapCppDevWrapper, captureWindowIsOpen: Binding <Bool>) {
        self.aDevice = device
        self.packets = device.getPacketArray() as! [PcapCppPacketWrappper]
        self._captureWindowIsOpen = captureWindowIsOpen
    }
    
    func stopCapture() -> Void {
        aDevice.stopCapture()
    }
    
    func startCapture () -> Bool {
        if (aDevice.openDev()) {
            Alert(title: Text("Attempting to open device"), message: Text("Failed to open device :("),primaryButton: .destructive(Text("Ok")),secondaryButton:.cancel() )
            return true
        }
        return true
    }
}

//struct CaptureWindowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CaptureWindowView()
//    }
//}
