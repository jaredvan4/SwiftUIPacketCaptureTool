//
//  DescriptionBox.swift
//  SeniorProj
//
//  Created by Jared on 12/10/21.
//

import SwiftUI

struct DescriptionBox: View {
    var description : String
    var body: some View {
        Text(description).font(.system(size: 15))
    }
}

//struct DescriptionBox_Previews: PreviewProvider {
//    static var previews: some View {
//        DescriptionBox()
//    }
//}
