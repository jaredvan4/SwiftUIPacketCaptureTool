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
    let status : Bool?
    
    init (iPv4Address: String, deviceName : String, status:Bool) {
        self.iPv4Address = iPv4Address
        self.deviceName = deviceName
        self.status = status
    }
    
}
