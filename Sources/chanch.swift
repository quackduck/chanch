// compile with swift build

import CoreWLAN
import ArgumentParser

extension CWChannelWidth: CustomStringConvertible {
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
    
    static func name(for value: Self) -> NameSpecification {
        switch value {
        case .width80:
            return [.customLong("80")]
        case .width40:
            return [.customLong("40")]
        case .width20:
            return [.customLong("20")]
        }
    }
}

@main
struct Chanch: ParsableCommand {
    // @Flag(help: "Just print the current channel")
    // public var noChange = false;
    
    @Option(name: .short, help: ArgumentHelp("The WiFi channel number to change to", valueName: "num"))
    public var channelNum: Int
    
    @Flag(help: ArgumentHelp("Channel width in MHz.", discussion: "                  (Usually 80 for the 5GHz band and 20 for the 2GHz band.)"))
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
        
        let currChannel = iface!.wlanChannel() // get current channel
        if currChannel == nil {
            print("Interface has no channel?!")
            return
        }
        print("Interface is on", currChannel!)
        
//        return;
        
//        iface!.disassociate()
        if iface!.interfaceMode() != CWInterfaceMode.none {
            print("Disconnect from current network to change the channel")
            return
        }
        
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
        
//        print("YOOO")
        // set channel
        do {
            try iface?.setWLANChannel(channel!)
        } catch {
            print(error.localizedDescription)
        }
        
        // iface.setWLANChannel() // set channel
        
        print("Set to channel:", iface?.wlanChannel() ?? "No channel")
    }
}

//import Foundation

// get CWWiFiClient from CoreWLAN

