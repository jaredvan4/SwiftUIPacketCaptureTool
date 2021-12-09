//
//  CaptureWindowView.swift
//  SeniorProj
//
//  Created by Jared on 10/27/21.
//

import SwiftUI
import Foundation
import UniformTypeIdentifiers
//TODO: Packet array not updating dynamically

struct CaptureWindowView: View {
    var aDevice : PcapCppDevWrapper
    var packets : NSMutableArray
    private var fileTypes = [UTType("com.app.pcapng")]
    var timer : Timer? = Timer()
    var packetManager : PacketArrayManager? = nil
    @State private var isAnimating = false
    @State private var areTherePackets:Bool = false
    @State var captureActive = false
    @State var showPackets = false
    @State var noOfPacketsCaptured:Int = 0
    @State private var showExitAlert = false
    @State private var showSavedAlert = false
    @State private var showPacketEmptyAlert = false
    @State private var showDidNotStartCapturingAlert = false
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
                    Text("No capture active on device \(self.aDevice.getName())").font(.system(size: 23))
                    Text("No of Packets captured : \(noOfPacketsCaptured)").font(.system(size: 23))

                } else {
                    Text("Capture active on device \(self.aDevice.getName())").font(.system(size: 23))
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
                        if !startCapture() {
                            showDidNotStartCapturingAlert = true
                        }
                        
                    }) {
                            Text("Start Capture").foregroundColor(Color.black)
                        }.background(Color.green).cornerRadius(8).alert(isPresented: self.$showDidNotStartCapturingAlert) {
                            Alert(title: Text(""), message: Text("Capture not supported on this device!"), dismissButton: .destructive(Text("ok")))
                        }
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
                        if saveAsFile() {
                            self.showSavedAlert = true
                        }
                    }) {
                        Text("Save as file").foregroundColor(Color.black)
                    }.background(Color.green).cornerRadius(8).disabled(captureActive || noOfPacketsCaptured <= 0).alert(isPresented: self.$showSavedAlert) {
                        Alert(title: Text("success"), message: Text("Saved pcapng file succesfully!"), dismissButton: .destructive(Text("ok")))
                    }
                }
                ToolbarItem(placement: .principal) {
                    Button(action: {
                        withAnimation() {
                            self.showPackets = true
                        }
                    }) {
                        Text("View Packets").foregroundColor(Color.black)
                    }.background(Color.green).cornerRadius(8).disabled(captureActive || !areTherePackets)
                }
                ToolbarItem(placement: .principal) {
                    Button(action: {
                        showPacketEmptyAlert = true
                    }) {
                        Text("Discard Packets").foregroundColor(Color.white).cornerRadius(8)
                        
                    }.disabled(captureActive).alert(isPresented: $showPacketEmptyAlert){
                        Alert(
                            title: Text("Exit"), message: Text("Are you sure you want to Discard packets?\nThis will stop any active capture on this device & any unsaved data will be lost"), primaryButton: .destructive(Text("Yes")) {
                                withAnimation() {
                                    self.stopCapture()
                                    self.emptyPacketArray()
                                    self.noOfPacketsCaptured = 0
                                    self.areTherePackets = false
                                }
                            },secondaryButton: .cancel(Text("No"))
                            
                        )
                    }
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
                                    self.areTherePackets = false
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
        self.noOfPacketsCaptured = aDevice.getPacketArray().count
        if (aDevice.getPacketArray().count > 0) {
            self.areTherePackets = true
        }
        self.packetManager?.stopTimerFunction()
        
    }
    func invalidateTimer () -> Void {
        self.timer?.invalidate()
    }
    func startCapture () -> Bool {
        if (aDevice.openDev()) {
            captureActive = true
            return true
        }
        captureActive = false
        return false
    }
    
    //sends message to dev wrapper to dealloc all packets
    func emptyPacketArray () -> Void {
        self.aDevice.emptyArray()
    }
    
    //TODO: Exclude user from saving any filetype besides .pcapng
    func saveAsFile () -> Bool {
        var filePath = ""
        let panel = NSSavePanel()
//        panel.allowedContentTypes = self.fileTypes
//        panel.allowsOtherFileTypes = false
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
