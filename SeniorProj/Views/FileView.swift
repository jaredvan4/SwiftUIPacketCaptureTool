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
    @State var currentlySelected : Int = 0
    var protocols = ["TCP", "SSH", "HTPP", "HTTP Request","HTTP", "HTTP Response","SSL","DNS","UDP","IPv6", "ARP", "ARP reply" ,"ARP request","IPv4","DHCP", "IMGP", "BGP", "IGMPv1" , "IGMPv2", "IGMPv3", "ICMP", "None"]
    var sizes = ["0"," 5","20","30", "50", "80", "100", "150", "200","300", "400", "500", "1000"]
    @State var selectedSize : String = "0"
    @State var selectedFilterType  = "None"
    var body: some View {
        GeometryReader { geometry in
            Divider()
            VStack {
                GroupBox() {
                    ScrollView(.vertical) {
                        LazyVStack() {
//                            ForEach(filteredPackets.indices) { index in
//                                HStack {
//                                    Text(" Packet No: \(String(index + 1))").font(.subheadline).frame( alignment: .trailing)
//                                    Divider().frame(width:10)
//                                    Text ("Time :  \(String(filteredPackets[index].getTimeStamp()))").font(.subheadline).frame( alignment: .trailing)
//                                    Divider().foregroundColor(Color.white).frame(width:10)
//                                    Text ("Total packet len: \(String(filteredPackets[index].getRawDataLength())) ")
//                                    Divider().frame(width:10)
//                                    Text ("Protocol : \(String(filteredPackets[index].getProtocolType()))")
//                                    Spacer()
//                                }.onTapGesture {
//                                    currentlySelected = index
//                                }
//                            }
                            ForEach(packets.indices) { index in
                                HStack {
                                    Text(" Packet No: \(String(index + 1))").font(.subheadline).frame( alignment: .trailing)
                                    Divider().frame(width:10)
                                    Text ("Arrival Time :  \(String(packets[index].getTimeStamp()))").font(.subheadline).frame( alignment: .trailing)
                                    Divider().foregroundColor(Color.white).frame(width:10)
                                    Text ("Total packet len: \(String(packets[index].getRawDataLength())) ")
                                    Divider().frame(width:10)
                                    Text ("Protocol : \(String(packets[index].getProtocolType()))")
                                    Spacer()
                                }.onTapGesture {
                                    currentlySelected = index
                                }.background(currentlySelected == index || selectedFilterType == packets[index].getProtocolType() || packets[index].getFullLength() >= Int(selectedSize) ?? 0 && Int(selectedSize) ?? 0 > 0 ?  Color.blue : Color(red: 61/255, green: 58/255, blue: 58/255)).cornerRadius(3)

                            }
                        }
                    }
                    //                        }.frame(width: geometry.size.width, height: geometry.size.height * 0.75, alignment: .center)
                }.frame(height:geometry.size.height * 0.55).toolbar {
                    ToolbarItem(placement: .status) {
                        Text("Total Packets captured : \(self.packets.count) ")
                    }
                
                    ToolbarItem(placement: .principal) {
                        Text("Select by protocol:")
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Picker("Filter By value", selection: $selectedFilterType) {
                            ForEach(protocols, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("Select by size:")
                    }
                    ToolbarItem(placement: .principal) {
                        Picker("Filter By size", selection: $selectedSize) {
                            ForEach(sizes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    ToolbarItem(placement:.principal) {
                        Button(action: {
                            showPackets.toggle()}) {
                                Text("exit").foregroundColor(Color.black)
                            }.background(Color.green).cornerRadius(8)
                    }
                    //place next tool bar item heere
                }
                //Packet info groupbox
                GroupBox(label: Label("Info for packet no: \(self.currentlySelected + 1)",systemImage: "").font(.system(size: 15))) {
                    GeometryReader { detailsGeometry in
                        HSplitView {
                            GroupBox {
                                Text (" Frame length: \(String(packets[self.currentlySelected].getFrameLength())) ")
                                Text("Link type : \(String(packets[self.currentlySelected].getLinkType()))")
                                LayerView(layers: packets[currentlySelected].getDescriptionAsLayers() as! [NSString])
                                Spacer()
                                
                            }.frame(width: detailsGeometry.size.width * 0.75)
//                            GroupBox(label: Label("Packet description",systemImage: "").labelStyle(.titleOnly)) {
                            Group {
                                Text(packets[self.currentlySelected].getDescription()).font(.system(size: 15)).frame(height: detailsGeometry.size.height)
                            }
//                            }.frame(width: detailsGeometry.size.width * 0.38, height:detailsGeometry.size.height)
                        }
                    }
                }.frame(width:geometry.size.width, height: geometry.size.height * 0.5)
            }
        }
    }
    var filteredPackets : [PcapCppPacketWrappper] {
        if packets.isEmpty {
            return packets
        } else {
            if self.selectedFilterType == "" || self.selectedFilterType == "None" {
                return packets
            }
            return packets.filter {
                $0.getProtocolType() == self.selectedFilterType
            }
        }
    }
}

//struct FileView_Previews: PreviewProvider {
//    static var previews: some View {
//        FileView(packets:[PcapCppPacketWrappper](), showPackets: true)
//    }
//}
