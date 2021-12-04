//
//  CaptureWindowView.swift
//  SeniorProj
//
//  Created by Jared on 10/27/21.
//

import SwiftUI
import Foundation
//TODO: Packet array not updating dynamically

struct CaptureWindowView: View {
    var aDevice : PcapCppDevWrapper
    var packets : NSMutableArray
    let fileTypes = ["pcapng"]
    var timer : Timer? = Timer()
    var packetManager : PacketArrayManager? = nil
    @State private var isAnimating = false
    @State var captureActive = false
    @State var showPackets = false
    @State private var showExitAlert = false
    @Binding var captureWindowIsOpen: Bool
    var body: some View {
        if showPackets && !captureActive {
            GroupBox() {
                FileView(packets: aDevice.getPacketArray() as! [PcapCppPacketWrappper], showPackets: $showPackets)
            }
        } else {
            GroupBox() {
                Group {
                if !captureActive {
                    Text("No capture active on device \(self.aDevice.getName())").font(.system(size: 25))
                } else {
                    Text("Capture active on device \(self.aDevice.getName())").font(.system(size: 25))
                    Circle()
                                .trim(from: 0, to: 0.7)
                                .stroke(Color.green, lineWidth: 5)
                                .frame(width: 75, height: 75)
                                .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0))
                                .animation(Animation.default.repeatForever(autoreverses: false).speed(0.5))
                                .onAppear {
                                    self.isAnimating = true
                                }.onDisappear(){
                                    self.isAnimating = false
                                }
                            
                        
                }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).toolbar {
                ToolbarItem(placement:.principal) {
                    Button(action: {
                            startCapture()
                        
                    }) {
                            Text("Start Capture").foregroundColor(Color.black)
                        }.background(Color.green).cornerRadius(8)
                }
                ToolbarItem(placement: .principal ){
                    Button(action: {
                        withAnimation() {
                            stopCapture()
                        }
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
                        withAnimation() {
                            self.showPackets = true
                        }
                    }) {
                        Text("View Packets").foregroundColor(Color.black)
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
            }.frame(minWidth:0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
    }
    
    //constructor for view
    init (device : PcapCppDevWrapper, captureWindowIsOpen: Binding <Bool>) {
        self.aDevice = device
        self.packets = aDevice.getPacketArray()
        self._captureWindowIsOpen = captureWindowIsOpen
        self.packetManager = PacketArrayManager(dev: self.aDevice)
    }
    
    func stopCapture() -> Void {
        aDevice.stopCapture()
        captureActive = false
        self.packetManager?.stopTimerFunction()
        
    }
    func invalidateTimer () -> Void {
        self.timer?.invalidate()
    }
    func startCapture () -> Bool {
        if (aDevice.openDev()) {
            captureActive = true
//            self.packetManager?.startTimerFunction()
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
            return self.aDevice.savePcapFile(filePath)
        }
        return false
    }
    
    //mutating keyword is needed to change a property of the view struct, as a view is a value type
    func startPacketUpdateTimer () -> Void {
        
    }
    
    
}

//struct CaptureWindowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CaptureWindowView()
//    }
//}
