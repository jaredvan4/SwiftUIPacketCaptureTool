//
//  SeniorProjApp.swift
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

import SwiftUI

@main
struct SeniorProjApp: App {
    @State var filePath = ""
    @State var showFileChooser = false
    var mainPcap: PcapMainWrapper = PcapMainWrapper()
    var body: some Scene {
        WindowGroup {
            MainView(pcapMain: mainPcap)
        }.commands {
            CommandGroup(replacing: .newItem) {
                Button("open pcap file") {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = false
                    if panel.runModal() == .OK {
                        self.filePath = panel.url?.absoluteString ?? ""
                        mainPcap.openPcapFile(self.filePath)
                    }
                }
                Button("Save as Pcap File") {
                    
                }
                //            .disabled(true)
            }
            
        }
        WindowGroup() {
            Text("dsadsa")
        }
        
    }
}

