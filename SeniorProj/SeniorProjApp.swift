//
//  SeniorProjApp.swift
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

import SwiftUI

@main
struct SeniorProjApp: App {
    var mainPcap: PcapMainWrapper = PcapMainWrapper()
    var body: some Scene {
        WindowGroup {
            MainView(pcapMain: mainPcap)
            TextEditor(text: .constant("What goes here?"))

        }
        
    }
}
