//
//  LayerView.swift
//  SeniorProj
//
//  Created by Jared on 12/5/21.
//

import SwiftUI

struct LayerView: View {
    var frameLength : Int
    var linkType : String
    var layers : [NSString]
    var body: some View {
        Text ("Frame length:  \(String(frameLength))")
        Text("Link type : \(linkType)")
        ForEach (layers.indices, id:\.self)  { index in
            Text( "layer \(index + 1) :  \(String(layers[index]))")
            Spacer()
        }
    }
}

//struct LayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        LayerView()
//    }
//}
