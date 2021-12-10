# Native macOS Packet capture tool
### This application is a packet capture program for macOS written in C++, Swift & Objective C/Objective C++.
### Allows user to capture ethernet packets on an available network device and save to pcapng file
### Utilizes SwiftUI & PcapPlusPlus frameworks, with full native support for Apple Silicon
# **Requirements**
 * Xcode 13.0 or higher
 * Xcode command line tools (install by running *" xcode-select --install
"*)
 * macOS Big Sur or higher (Assuming one is targeting arm64)
# **Setup**
 * To get started, install the PcapPlusPlus pre compiled compiled binaries using Homebrew by running the command "*brew install pcapplusplus*"
#### **Note:** If you are having difficulties building the project using the pre-compiled binaries, try building PcapPlusPlus from source, which is covered [here](https://pcapplusplus.github.io/docs/install/build-source/macos)
 * Clone project to local, and open in Xcode, or choose "clone from exiting project when opening up Xcode"
 * In the project settings, under "header search paths" add PcapPlusPlus' "include" directory (the location varies depending on whether you compiled from src or installed pre-compiled binaries)
 * Under the build phases tab of the project settings, in "Link Binary With libraries" add the SystemConfig framework, corefoundation, then libCommon++.a, libPacket++.a and libPcap++.a
