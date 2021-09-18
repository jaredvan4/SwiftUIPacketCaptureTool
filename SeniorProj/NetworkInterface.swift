//
//  NetworkInterface class
//  SeniorProj
//
//  Created by Jared on 9/17/21.
//

import Foundation

class NetworkInterface {
    let iPv4Address: String?
    let deviceName : String?
    
    init (iPv4Address: String, deviceName : String) {
        self.iPv4Address = iPv4Address
        self.deviceName = deviceName
    }
    
    func saySomething( )->String {
        return "hi from function"
    }
    
    func initializeDevice () -> String {
        return "dave"
    }
    
}
