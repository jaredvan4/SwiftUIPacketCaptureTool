//
//  SeniorProjApp.swift
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

//TODO: Exclude user from opening any file type besides pcapng

import SwiftUI
import UniformTypeIdentifiers
@main
struct SeniorProjApp: App {
    @State var openFileViewingWindow = false
    @State var filePath = ""
    @State var loadedFromFile = false
    @State var showFileChooser = false
    @State var showFailedToOpenAlert = false
    @State var deviceIsOpen = false
    private var fileTypes = [UTType("com.app.pcapng")]
    var mainPcap: PcapMainWrapper = PcapMainWrapper()
    var body: some Scene {
        WindowGroup {
            if !loadedFromFile {
                MainView(pcapMain: mainPcap ).alert(isPresented: self.$showFailedToOpenAlert) {
                    Alert(title: Text(":("), message: Text("Invalid file type"), dismissButton: .destructive(Text("ok")))
                }
            } else {
                FileView(packets: self.mainPcap.openPcapFile(self.filePath) as! [PcapCppPacketWrappper] , showPackets: self.$loadedFromFile)
            }
        }.commands {
        CommandGroup(replacing: .newItem) {
            Button("open pcap file") {
                let panel = NSOpenPanel()
//                panel.allowedContentTypes = self.fileTypes as! [UTType]
//                panel.allowsOtherFileTypes = false
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                if panel.runModal() == .OK {
                    if !(panel.url?.path.contains(".pcapng"))! {
                        loadedFromFile = false
                        showFailedToOpenAlert = true
                        return
                    }
                    self.filePath = panel.url?.path ?? ""
                    loadedFromFile.toggle()
                } else {
                    showFailedToOpenAlert = true
                }
            }
            Button("Save as Pcap File") {
                
            }
            .disabled(true)
        }
        
    }
}

}


