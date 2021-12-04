//
//  FileView.swift
//  SeniorProj
//
//  Created by Jared on 12/3/21.
//

import SwiftUI

struct FileView: View {
    var packets: [PcapCppPacketWrappper]
    @Binding var showPackets : Bool
    var body: some View {
        GeometryReader { geometry in
            Divider()
            VStack {
                GroupBox() {
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(packets.indices) { index in
                                    GroupBox {
                                        HStack{
                                            Text(" Packet No: \(String(index + 1))")
                                        }
//                                        Text(packets[index].getDescription()).frame(width: geometry.size.width)
                                    }.frame(width: geometry.size.width, height: 25, alignment: .center)
                                }
                            }
                        }.frame(width: geometry.size.width, height: geometry.size.height * 0.75, alignment: .center)
                }.frame(maxHeight:300).toolbar {
                    ToolbarItem(placement: .status) {
                        Text("Total Packets captured : \(self.packets.count) ")
                    }
                    ToolbarItem(placement:.principal) {
                        Button(action: {
                            showPackets.toggle()}) {
                                Text("exit").foregroundColor(Color.black)
                            }.background(Color.green).cornerRadius(8)
                    }
                }
                GroupBox(label: Label("Should be bound to current selected packet",systemImage: "")) {
                    Group {
                        Text("hmm")
                    }
                }.frame(width:geometry.size.width, height: geometry.size.height * 0.5)
            }
        }
    }
}

//struct FileView_Previews: PreviewProvider {
//    static var previews: some View {
//        FileView(packets:[PcapCppPacketWrappper](), showPackets: true)
//    }
//}
