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
    var packets : NSMutableArray
    @State private var showExitAlert = false
    @Binding var captureWindowIsOpen: Bool
    var body: some View {
        GroupBox() {
            Text("Packets")
            if (self.packets.count > 0) {
            ScrollView(.horizontal) {
                ForEach(0..<packets.count) { _packet in
                    Text("sda")
                }
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity, alignment: .center)
             }
            
        }.toolbar {
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
                                aDevice.emptyArray()
                                captureWindowIsOpen.toggle()
                            }
                        },secondaryButton: .cancel(Text("No"))
                        
                    )
                }
            }
            
        }
        //Section where current selected packet data is shown
        GroupBox(label: Label("Should be bound to current selected packet",systemImage: "")) {
            
        }.frame(minWidth:0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        
        
    }
    
    //constructor for view
        init (device : PcapCppDevWrapper, captureWindowIsOpen: Binding <Bool>) {
            self.aDevice = device
            self.packets =  aDevice.getPacketArray()
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
    
    //sends message to dev wrapper to dealloc all packets
    func emptyPacketArray () -> Void {
        self.aDevice.emptyArray()
    }
}

//struct CaptureWindowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CaptureWindowView()
//    }
//}
