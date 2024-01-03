// compile with swiftc or swift build

import CoreWLAN
import ArgumentParser

extension CWChannelWidth: CustomStringConvertible, ExpressibleByArgument {
    
    public var description: String {
        switch self {
        case .width20MHz:
            return "20MHz"
        case .width40MHz:
            return "40MHz"
        case .width80MHz:
            return "80MHz"
        case .width160MHz:
            return "160MHz"
        case .widthUnknown:
            return "unknown"
        @unknown default:
            return "invalid"
        }
    }
}

extension CWChannel {
    override public var description: String {
        return "channel \(self.channelNumber) with width \(self.channelWidth)"
    }
}

enum width: Int, EnumerableFlag {
    case width80 = 3
    case width40 = 2
    case width20 = 1
}

@main
struct Chanch: ParsableCommand {
  @Option(help: "The WiFi channel number to change to")
  public var channelNum: Int
    
  @Flag(help: "Channel width")
  public var channelWidth: width

  public func run() throws {
      let client = CWWiFiClient.shared()
      let iface = client.interface() // get default interface
      if iface == nil {
          print("No default interface found")
          return
      }
      // print default interface name
      print("Interface name:", iface!.interfaceName!)

      let currChannel = iface?.wlanChannel() // get current channel
      if currChannel == nil {
          print("Interface has no channel?!")
          return
      }
      print("Interface is on", currChannel!)

    // get the CWChannelWidth from the flag
    let channelWidth = CWChannelWidth(rawValue: channelWidth.rawValue)!

      
      // list of allowed channels
      let channels = iface!.supportedWLANChannels()
      // filter for the channel we want
      let channel = channels?.filter({ $0.channelNumber == channelNum && $0.channelWidth == channelWidth }).first
      if channel == nil {
          print("Channel not available")
          return
      }
      print("Trying to change to", channel!)

      // if not available, exit
      if channel == nil {
          return
      }

      print("YOOO")
          // set channel
      try iface?.setWLANChannel(channel!)

      // iface.setWLANChannel() // set channel

      print("Current channel:", iface?.wlanChannel() ?? "No channel")
  }
}

//import Foundation

// get CWWiFiClient from CoreWLAN

