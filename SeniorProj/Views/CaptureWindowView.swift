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
    let fileTypes = ["pcapng"]
    var packetManager : PacketArrayManager? = nil
    @State var captureActive = false
    @State var tempPacketArr : [PcapCppPacketWrappper]
    @State private var showExitAlert = false
    @Binding var captureWindowIsOpen: Bool
    var body: some View {
        GroupBox() {
            Text("Packets")
            ScrollView(.horizontal) {
                ForEach(tempPacketArr.indices) { index in
                    Text("dsdasd")
                }
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity, alignment: .center)
             
            
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
                                saveAsFile()
                                
                            }) {
                                Text("Save as file").foregroundColor(Color.black)
                            }.background(Color.green).cornerRadius(8).disabled(captureActive)
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
                                self.stopCapture()
                                self.emptyPacketArray()
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
            self.packets = aDevice.packetArray
            self._captureWindowIsOpen = captureWindowIsOpen
            self.tempPacketArr = [PcapCppPacketWrappper]()
            self.packetManager = PacketArrayManager(dev: self.aDevice, packetArray: self.tempPacketArr)
        }
    
    func stopCapture() -> Void {
        aDevice.stopCapture()
        captureActive = false
    }
    
    func startCapture () -> Bool {
        if (aDevice.openDev()) {
            captureActive = true
            return true
        }
        return true
    }
    
    //sends message to dev wrapper to dealloc all packets
    func emptyPacketArray () -> Void {
        self.aDevice.emptyArray()
    }
    
    //TODO: Exclude user from saving any filetype besides .pcapng
    func saveAsFile () -> Bool {
        var filePath = ""
        let panel = NSSavePanel()
//        panel.allowedContentTypes = fileTypes
        if panel.runModal() == .OK {
            filePath = panel.url?.path ?? ""
            self.aDevice.savePcapFile(filePath)
        }
        return true
    }
}

//struct CaptureWindowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CaptureWindowView()
//    }
//}
